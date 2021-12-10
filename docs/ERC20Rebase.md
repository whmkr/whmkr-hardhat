# ERC20Rebase









## Methods

### allowance

```solidity
function allowance(address, address) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined
| _1 | address | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined

### approve

```solidity
function approve(address _spender, uint256 _amount) external nonpayable returns (bool success)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _spender | address | undefined
| _amount | uint256 | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| success | bool | undefined

### balanceOf

```solidity
function balanceOf(address _user) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _user | address | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined

### decimals

```solidity
function decimals() external view returns (uint8)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint8 | undefined

### index

```solidity
function index() external view returns (uint64)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint64 | undefined

### name

```solidity
function name() external view returns (string)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | undefined

### symbol

```solidity
function symbol() external view returns (string)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | undefined

### totalGon

```solidity
function totalGon() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined

### totalSupply

```solidity
function totalSupply() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined

### transfer

```solidity
function transfer(address _to, uint256 _amount) external nonpayable returns (bool success)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _to | address | undefined
| _amount | uint256 | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| success | bool | undefined

### transferFrom

```solidity
function transferFrom(address _from, address _to, uint256 _amount) external nonpayable returns (bool success)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _from | address | undefined
| _to | address | undefined
| _amount | uint256 | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| success | bool | undefined

### userGon

```solidity
function userGon(address) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined



## Events

### Approval

```solidity
event Approval(address indexed owner, address indexed spender, uint256 amount)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| owner `indexed` | address | undefined |
| spender `indexed` | address | undefined |
| amount  | uint256 | undefined |

### Transfer

```solidity
event Transfer(address indexed from, address indexed to, uint256 amount)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| from `indexed` | address | undefined |
| to `indexed` | address | undefined |
| amount  | uint256 | undefined |



## Events

### LowAllowance

```solidity
error LowAllowance(uint256 have, uint256 required)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| have | uint256 | undefined |
| required | uint256 | undefined |

### LowBalance

```solidity
error LowBalance(uint256 have, uint256 required)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| have | uint256 | undefined |
| required | uint256 | undefined |


