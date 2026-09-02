Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD9741167C
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788388408; cv=fail; b=h95/4wtG5IMQJk0WkPRFnGRmf+l0jrrpb56/6eC6EIeQGdi5ZhOkG8Z3YKc4hgHwbem4pjoDmdue8z450G23iwzka0zjorXEkTxR67gdwvlmYuSMBoB3hn/GnAnCSGSyKY5TntPp3IrhHV9pkFDxOKLX7Inez0G3kdfzJmW7QD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788388408; c=relaxed/simple;
	bh=ttR5tX+t3yAlzQV29IgKind7m0PVhWimuXzHwuYA4/E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gn98X/3j1ysooaZoH2uQaJHcMgchDQlV60dVdX/1kyALsTJzuGISEqnIeW9HuatsHT4YtpX6l4L8K33p7TaT72nvTEXsf6JX1jSWVgWf5xVcrcXkKhQwM2YuwCi8HnhoDO9LD0j+ny/LxE/q40NDUnLaVrSuvgcrhMSVKpvNEc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=izFNUofV; arc=fail smtp.client-ip=40.107.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="izFNUofV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJiZZBwZUauBuUPnfaatTJHh3NT9dMvZpLcEyakMO3dm7nJqiIhhUpbItXpcMjKh7Q3SedFWoccvq52M2A33Plvm20oVwjHPE/AcvGitQoEtMAb3fBnT99vjVHcPzvK+/cA6b16gXzqJrKELdD9QEHmAdLZpMMZc/6RI+IKvwl5VNZhaVevUP/zrsf4hZep+XHLUG2i6oSPnD/qAk5CQnAFML47Adk52Ywacykcjw8Vqm1X9act1C1ecdYNPh/i/wLQMqhQN3hdgT/e4hyNHEf6VBokKjeg6aMzXhY7TyWK3rtpf5VF/ymuXM+5jBq7jPwr5UGkwInHFeZw8ytjvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvMFT2bfOcSsieYBETKTm/VkcvD1J3IonTidZ5zqo3Q=;
 b=hZq/aRvBpH3LpwOPUd48kaCfSb7zH+a/7Lm4tcszkwH7ONx/y2Enat0zllKE29N/ZYmwYE/K24/rWEJSSa+n6LFzducYuf8kxCVykDEqPOSUapnaWnjl2gUQglkhNStMZfY2Mq/SMKy4Mxg0a7QSycG9O9lb8UZAS5SOVdxF+rePHoVVKTDl/WPQYZf8bWQs9vyQvhctvi3j24Q7Uk3WldHmgWA9/8B1QpIMRmQFI4NlKhVpi7Tl76lZTuqu9IJQ9ARw3Owy8PLxaGzVJwkOo96zWv9qku+2/SWH0t08FiUGdp/pOSjeZt5RyUqxwaAucHZwCtNHFd1pr/xXoF7vOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvMFT2bfOcSsieYBETKTm/VkcvD1J3IonTidZ5zqo3Q=;
 b=izFNUofVi78d+5hBQjVKz35V9VK4gBeJ88A9Z+SX5gZdwFJVZ7ap3TlbvjW3rwbCMkjq9GKsp0nlXdf9fgRT0RLZuBdu3bksZnlmGwLP/+f93IZ8Mp1AVYYqlztqpnNetpuJvspbd9tF+71K+hrkCLYfBOb6hdN0PRFtlqiqTmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 2 Sep 2026
 22:33:15 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 22:33:15 +0000
Message-ID: <9448b225-c047-4b99-8e05-bbe706cb348f@amd.com>
Date: Thu, 3 Sep 2026 05:33:06 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/24] iommu/amd: Introduce Reset vMMIO Command
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-9-suravee.suthikulpanit@amd.com>
 <0bc1f0c9-b52b-4369-83f1-822c67bf1151@linux.alibaba.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <0bc1f0c9-b52b-4369-83f1-822c67bf1151@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 260072e0-b5f1-47ae-e55e-08df09422d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|11063799006|4143699003|56012099006|18002099003|6133799003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	qPX30qIl2yAbG7+Qj5Zkm39iwxui0jg9RGKmS3rpvaC/IfC7O6IsEzi+9sa5M4UASRMI3q30VeYQW1ctKnPgovs3M/UBsJDqt6dt/53Q5KU1gbXGnKGy8VB+T9UQly4l/PN1Z8MDV7wZ1WyxJasovGEM04nUueSw6o10R5U/Q+mE3If7YsMWXPNRuLtcUnN+wGjtGaQHcJmC6OYP/syyqJLrTnT0zNd24DYpfPGimb6dFw8F2gg9zWVPEmSuWLGr2eOpn5IiOqYOyyjCB7qUXWRpUP9pzKydYtGXUOAU8OUhWQwXDnrdsBzTq8Kaj4zqtIaUZw4Fzz4iIqJeEZB3mZU7Zj1Ev+30gHJuto265VEj4DqbIGhZH3p55sNtBXv0lHbRwO85koHwRB/H/o4xNmpwbl9Cg0ozEIz7Uy/R5ER0byqPnXwKjIbRPpE/3cCI0W8Y7o8OGGQUnUtjSjxioM//c11tmHX3Czln1xK2G/zkKE078ZxtMUnlRbVpVogDvYxBhYyie39zB5P6LmEQpE4g7mkOMjHAI4GOBga4NgTTfi1zjW3KQWoRYfm9nwb0lf6FbqZLfqTJgGoAOnCCYxjtgOLb8w/mbTbmn3d25s0NRltbmie465iTrYj8MVvhsA4MfZSm16nhiWV2dl7enj+iRVIO7Q91PrI16HsRDeI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(6133799003)(3023799007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eG1ZODNNT2tjT3FITU5wWHd0NE51bGkwYm9VQWJOelhxbnE2c29jalVTblpS?=
 =?utf-8?B?WW9XUFpsWWNsY1F4VmxOVzM1Vzh1NHk2ZzlyNHovd1ZGRmt6NjgyMVArcUFG?=
 =?utf-8?B?UzRrbC8zL2dmajNYSTloODVid1VGbjNZanE4YW9yeTFmanNMcCtlWEtKNDJt?=
 =?utf-8?B?YmdON1JJUDVmN3pvdmYxUnBPM29kRklIcFdyZmdkaG43TXd6M1RYdXFSZ0VP?=
 =?utf-8?B?TFVsRkIyS21rcWZVbDRiUVNJeVM1eVh0RC81Zk9VTkc0cFZxSmg1V3g5bXZF?=
 =?utf-8?B?RjRDSWFRcWJMK0p6TFNKZVFmZjBYV0p3ejh1K2NkNUcyRVREeUg3K2syUllV?=
 =?utf-8?B?ajVMUnAweWdPZGk3cGgxcEFNOWJPM21WazhwOU1nd3NUQ29oNWVBYXJ4amFr?=
 =?utf-8?B?dmI1dHpwamVqSUVBTjY3T2E5aUtJSjcrd3ZMOGxQTjYrSVE2UVNIM0JEYUpR?=
 =?utf-8?B?QWFmOFc1cHFtZExDYkQ3NXp3cndFeE1mV3lGWERIRzRTRlR0OGEzRkg1ZWR4?=
 =?utf-8?B?dm52OEt4Y21SYW96cWU4bGZWVzdCWTNHc3E4ay9HYmF3Q2M1TTdWb2toVUx3?=
 =?utf-8?B?Tll6UU5IRGdBdm5OajYzaFREelc1bEN2YWRUMGdGeTFHYlEwek5lRGlKVGRW?=
 =?utf-8?B?bm1VQ2YxZGpVNURWUU9oYVR2elJxelRMcUtnaXRWUTJvTTgzT2hXa2k1ZmNI?=
 =?utf-8?B?ejh6UEdaS0p2bmFPZ3pyU2RoSjIrMW5VZDlWSy9JSm9zZnRvaTJFZWtjVWVv?=
 =?utf-8?B?eHJwbmhGajAyQ24zREM4dC8reDNjZnVtaUhVdUdrK2xwY3N2UDZPZzVYaWF4?=
 =?utf-8?B?Y29iU1FzZzJyVGR1SEkzRVJINmU0a21WcnhteWlmVXpwY3lZNXBQT2dmYW9T?=
 =?utf-8?B?d2FaTWdoYWp0UVNUQ1VYOWRwWDRlbE9BcGU3MUlSVnYrbytmeXpySkdsODk5?=
 =?utf-8?B?MWg2S2xSSW9MTmU2VWh2TkhyK3pqdWUwbnFzZ1MrUEFWc1NkQTdIb29EQ2pU?=
 =?utf-8?B?akFOeGo4TER1TFk5b1prNzBxeXBVVXNUaUIvMXJzZml2OFZ1c3RkeEpaelIv?=
 =?utf-8?B?MU13a2JKekllaVd3UGE3UU5ONE9vVFo0c1k0VERXcFZHWU9wa0dWYTNuY2pL?=
 =?utf-8?B?eUJaZk1XcFdVT3lTNXptRkZCRDJZSUwwbVBGS2FSci9CRkdleHFITGpkdHBp?=
 =?utf-8?B?SXJpaittUkt2YXNsS0ZnRnoyc1F2eWRwSExYWmxKSS9CdmR3N09MV3pySTZs?=
 =?utf-8?B?cmFCZGx5Z3ZqaFpHYjF6aE9IT2I2UlgrczhBMGxraElCN0lpK0p1NG5qTzdP?=
 =?utf-8?B?aFFxa0xvQUJ0U3pBZDhvL3lFdHFwcUp3dnhNWDkxTk10aUdjZmxjdnFCZnBK?=
 =?utf-8?B?L3RCZFhHSnRsYzU4elAzSFNxamI1aFp6S0kvWHZJZnhQTmNHOW0yeGNqdldN?=
 =?utf-8?B?YTVtUjBzaUxpMEFiNkFmUlhxcFFyOTB2cWkvWFJibmJzaWQyRkFUL3IxWEht?=
 =?utf-8?B?K3ZnbUVBMUJldS81N0FUTjRBdXluWkxFN3Y1akRUTjZlZHNOUzlDaXB4RFpB?=
 =?utf-8?B?UWhPQVd1WmlOUXVpZG45eVJZckxJT2J0L3hNSkt5S094a2RQWGxFQThoQnFi?=
 =?utf-8?B?ZFFpOGYycWwxdlhwT0ZwUmZXdVVSd1dCL29QeldmR2hrMXNySnlBZGpReGFY?=
 =?utf-8?B?eEdvVGxNR0pLOS9LNHJtZFBZNFcyRTErNHRYMHlzUnRuZUQ1REZXalNQeEdv?=
 =?utf-8?B?dkpQb0VtdkUyczdFMWk4eFBVR2prK1ZrSngxb3hid3dpazRsa0YwaFExQXdX?=
 =?utf-8?B?NzZVKzB1OG5qWE1CaFN0cFk0eUVJM1NYd1p1dlZHWDlXRm1lMHBGU3p4cXBM?=
 =?utf-8?B?Q3l2YzNSaW5ldHFrYXRuMDFyZkZzRWN3ZC9GL2c4QmV2L1Q4NHl6NmlkMkFy?=
 =?utf-8?B?RG5EckpER3FUSFhJWmsySVpVQ2MvS0VFSVc2bWFSbzRhNlBWNXRuSGZJVU1u?=
 =?utf-8?B?U0xLOG5Vc2lyaHV1MjB5WjZpY1NWKzNLK1g3N0orWVlhbzB6ZEFjcXR5ZDVO?=
 =?utf-8?B?T1I2dmF3NHd0M3MrbU0yWXNkUnFXckZlU3BTc0VBRTJOTGxXWi9RVkE2ZFZ2?=
 =?utf-8?B?WTZ4SlIrelI4MkF0K3VyaTdyYkZQM2FGeGQvdVI1VXBWSS9GYlhLa0tOQjQz?=
 =?utf-8?B?bU8vZEFrcG5nb2RpK3NJOGtpOUVYZ1lsd214ZU1TMW9zOW5kLyswRk5hVUl2?=
 =?utf-8?B?ZHlyUHA4ZWhxVVpiMzNzUVZuaUw0c0pnTXpQV0Zjbk9KQWdZNGJWU0xNc3hH?=
 =?utf-8?Q?7EQmpgWS31Yp4cJe4Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 260072e0-b5f1-47ae-e55e-08df09422d9b
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 22:33:14.9475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAweB5U41MGB1XO7R9/TOHftEtyIyEz+FZTWs31rnGJxmNQHi3VUADsusjghkp0Bo3vvTBQq4jJw1P2PriklaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095



On 8/19/2026 3:34 PM, guanghuifeng@linux.alibaba.com wrote:
> 
> 在 2026/7/27 21:28, Suravee Suthikulpanit 写道:
>> Introduce new IOMMU commands for vIOMMU to reset
>> virtualized MMIO registers of a particular guest.
>>
>> Reviewed-by: Weinan Liu <wnliu@google.com>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   drivers/iommu/amd/amd_iommu.h       |  1 +
>>   drivers/iommu/amd/amd_iommu_types.h |  1 +
>>   drivers/iommu/amd/iommu.c           | 22 ++++++++++++++++++++++
>>   drivers/iommu/amd/iommufd.c         |  3 +++
>>   4 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/ 
>> amd_iommu.h
>> index 044bc9a634a1..2ce207529ea0 100644
>> --- a/drivers/iommu/amd/amd_iommu.h
>> +++ b/drivers/iommu/amd/amd_iommu.h
>> @@ -11,6 +11,7 @@
>>   #include "amd_iommu_types.h"
>> +void iommu_reset_vmmio(struct amd_iommu *iommu, u16 gid);
>>   extern int amd_iommu_evtlog_size;
>>   extern int amd_iommu_pprlog_size;
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/ 
>> amd_iommu_types.h
>> index cc7049bbfa14..44fa1d6c64d6 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -218,6 +218,7 @@
>>   #define CMD_INV_IRT        0x05
>>   #define CMD_COMPLETE_PPR    0x07
>>   #define CMD_INV_ALL        0x08
>> +#define CMD_RESET_VMMIO        0x0A
>>   #define CMD_COMPL_WAIT_STORE_MASK    0x01
>>   #define CMD_COMPL_WAIT_INT_MASK        0x02
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 73fba8be40d1..6f5ecc48f4ad 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -1428,6 +1428,18 @@ static void build_inv_irt(struct iommu_cmd 
>> *cmd, u16 devid)
>>       CMD_SET_TYPE(cmd, CMD_INV_IRT);
>>   }
>> +static void build_reset_vmmio(struct iommu_cmd *cmd, u16 gid,
>> +                  bool vcmd, bool all)
>> +{
>> +    memset(cmd, 0, sizeof(*cmd));
>> +    cmd->data[0] = gid;
>> +    if (all)
>> +        cmd->data[0] |= (1 << 28);
>> +    if (vcmd)
>> +        cmd->data[0] |= (1 << 31);
>> +    CMD_SET_TYPE(cmd, CMD_RESET_VMMIO);
>> +}
> 
> This looks like a bug. Per the AMD IOMMU Specification (Rev 3.10,
> Section 2.4.10), the 'All' bit of the RESET_VMMIO command is at bit
> position 27, not bit 28. Writing bit 28 targets a reserved field and
> may either trigger an ILLEGAL_COMMAND_ERROR or silently fail to reset
> the full vIOMMU context. This should be:
> 
>      if (all)
>          cmd->data[0] |= (1 << 27);

Actually, this is a typo in the spec. AMD will update the spec in the 
next revision. The correct bit is 28.

>> +
>>   /*
>>    * Writes the command to the IOMMUs command buffer and informs the
>>    * hardware about the new command.
>> @@ -1668,6 +1680,16 @@ void amd_iommu_flush_all_caches(struct 
>> amd_iommu *iommu)
>>       }
>>   }
>> +void iommu_reset_vmmio(struct amd_iommu *iommu, u16 gid)
>> +{
>> +    struct iommu_cmd cmd;
>> +
>> +    build_reset_vmmio(&cmd, gid, 1, 1);
>> +
>> +    iommu_queue_command(iommu, &cmd);
>> +    amd_iommu_completion_wait(iommu);
>> +}
>> +
> 
> Both iommu_queue_command() and amd_iommu_completion_wait() return
> status, but iommu_reset_vmmio() returns void and ignores them. A
> failed reset during vIOMMU init would go unnoticed. Consider
> propagating the error to the caller.

I'll handle the return of iommu_queue_command() in iommu_reset_vmmio(). 
The amd_iommu_completion_wait() does not normally handle error in this 
driver. This needs a separate clean up.

Thanks,
Suravee

