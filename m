Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8847F1BE86A
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941052; cv=fail; b=bu9QsUeV14G3D/owiQ9Ecoi6REOBnQiOzQE1uiIlPSDAdr7pcNKiMatmpueLbdCL/SOpG9i9f+kdhHpQIK9qmrJuM1zJtihj9F7ihXRBmjveonvfHz3jcv+Xa/PGNzrIyPilodlm/otjI3D5w6e9Bc5WNTqGzqFLvoREk2TgGb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941052; c=relaxed/simple;
	bh=Ef3KysPBT9efs1o/Tt1LbtYjQHcp/0vXRGO1n9tk3lw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aWVqChOsu2khjTKZCYSMneXT/PgZ6GIaVUaJuHrjchBNxh7rRi6yjlQV03KmmKfL3pePLuMoVXEb3rJ+jo70xiJasCJkItMr7L6DX7ZZ8xT76B0t9m28HHiVmcLR3dj7q56yg2M28V+AeS+xYXpMajUDrkKDH+iOFeurE8Hkny8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eTRGPxUt; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eTRGPxUt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q2D7CZbmDnxb9Nb5vm7FyLMSyWzdHCq5IEb1eEORmEks5mNRxaAY0PdJ8B59cIUHlykJnWzbXgnf+9FH4oo6bQ3lcZGSOiGITna1kbzJIeACP/9XbFpWzWm1zb6lLObYIeMsgxJFg05vansDVXR2cgQiBZGDKDFVgBjqvQPMYbhJFFi+1Q3VuuvoMBKtifv13GPSdBJQHYj+F576v5jL+NiRPB5/H8XHUdNKrR8VTA3/q0MgJaCgawG/ywPrrpJe1JvFhkUcgKcNdfAmNnOPV9BmTQUmsWBkYp+9+1UX3W23Fn9ZLl5RBRObtBiAsG1mi768yrTTU08t85R+3DtUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dldn/zyH51hgV9AlLQJkZmFmWxt6vUyIVCL3LLZX35c=;
 b=yKhtwGkiao1E6kSeszbbdM1tiWtrKo7vJN0/bj3iOjqbADWb158vZ520ASmKDgM9FUWrsbakIb+a6wGm9k+nrD4wYIP4YAmO8aCW6frd6fbSaz3QktfWtRV8GbKzIOYf3aFIFvjVcTA7f+OBt1u/1l0N4KnC5ega5XV4Q8BWxXyRw/H4SslhJfJ5i6F2rBobACBP6a7kiKo1lDcDSUTM5d9cBXwoZNofuOYTNZENQgI2OcivUWpJu3ZuzFa0VTvHB53NSh3UW3zc4SScyKm5MYu447KxWenML8ToNv5eD9Wi5UpxajTjqfBpIqMr9FtNgOyH+jJM9zmJ19tCML8Fpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dldn/zyH51hgV9AlLQJkZmFmWxt6vUyIVCL3LLZX35c=;
 b=eTRGPxUtqUpBKKCYjHz6C42TWEtheampFemNNZPKvTOTQDyGlic8HUqinOaIbx4MHwk4sRB+BkmCAtQjNoFYXT2cmtqmUKc2JlaBMuE+a3E9E3EsPPIIRIeMKZJ8PoocMwUQhRGmIZFe86gefviSvSJSz9RbSZipcUGVqm2c9/+ItLzjKhOT9ObjtEWlMUfLnJFXdxxY3wktpV5Y/NomEJMpEmxgayZ3Vv8auQQPqYfWNjITV01bAQ8bUf37yuDVrVTc3I13cYoi5+j0EQIsXfZktZ3s+qdSlO8RXUQ2K8TbtlYfX27/HOKOleA6HuINc/nySlDNIlfbNc4O9R5/nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5)
 by MW6PR12MB8958.namprd12.prod.outlook.com (2603:10b6:303:240::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.33; Tue, 6 Aug
 2024 10:44:05 +0000
Received: from CY5PR12MB9056.namprd12.prod.outlook.com
 ([fe80::9a15:4da5:cfae:f5c6]) by CY5PR12MB9056.namprd12.prod.outlook.com
 ([fe80::9a15:4da5:cfae:f5c6%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 10:44:05 +0000
Message-ID: <5fc09b67-cb36-447a-a927-b60bf20a492d@nvidia.com>
Date: Tue, 6 Aug 2024 16:13:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] iommu: Optimize IOMMU UnMap
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20240805084106.214584-1-amhetre@nvidia.com>
 <bfd0f7c7-5492-47ec-9c66-4c1ad4cd0e52@arm.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <bfd0f7c7-5492-47ec-9c66-4c1ad4cd0e52@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::10) To CY5PR12MB9056.namprd12.prod.outlook.com
 (2603:10b6:930:34::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB9056:EE_|MW6PR12MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: 865d19fa-fb9e-4a1e-fa7a-08dcb604b117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djM0YXd5cG5LRTRRRUluTkZXSGQ4d0EzcmJENHdOTnRQRStpSDc1bXI5SkRJ?=
 =?utf-8?B?Nm5IdUJFUHpDUGF2NVBxYWp2SEQyc0xRVStoMEpQWWxOUUtpVnlUN1VubjZk?=
 =?utf-8?B?bExtNlAzZ09NeENiL1I4NXp1STZBTm1kVHo4YThQbnpheFZoVTJvZnI1VUtj?=
 =?utf-8?B?YkdDREJNamEySDNKQmY2RjY4cE01SDRKcnNFandEM3hRK2dQd2loREdaQlZz?=
 =?utf-8?B?MU4rSE41ZmRnY1FJU09LSitKcFhqelMwYkRRMFAzRXJud29tVDJmMGRKLzNu?=
 =?utf-8?B?ZU5Ud0NublZmbURITjRJQzlPVEhqMU5IWHBlZFVLUS8zZ2cycCs4aWYvZHpi?=
 =?utf-8?B?ZjBKL0hBczZXMm5UdWh4TWRKY3FOY0RWVTdsdnJleE9nL1E5RHZZd2VsaEZa?=
 =?utf-8?B?NEpXYTFkVGIwUzRTNm15Nkg1RkFDb0s3VElOSjlQS0RraHFrT3lUQUNEeE5u?=
 =?utf-8?B?eDFTMWFPVVA1eDJBY3kyTmMxNGJ6a0EwLzRtTk02Szdnb2NNenJhUnNUQXRi?=
 =?utf-8?B?eG12VDNsckFsdisvMzhqYXR6Rk9pMFdkSlZYQndMWUdlUCttNTgxWWFHVUxM?=
 =?utf-8?B?aGgzamlhNFBuLzFPOUYrbGlDRmtPb1EyTmdKSHd1NDZjZWNpcC9pbHJQUHpB?=
 =?utf-8?B?N2puY1g3Z0ordkNZcnA4b1Z3R1U1UXRWTllyL3Q3dWxycG56K0haSVVWVEVw?=
 =?utf-8?B?ZjY1T0M4bmlNZUZZVlFEVDNQd3l6eXpzWk4rZWJwUjFEWkRkME0vKy85VGZB?=
 =?utf-8?B?aEJGNXVYZXdQNWc1d2dFcVluazVFYURkemNhTGZncmdxeld6MzVJQ25HZXVt?=
 =?utf-8?B?R1NOem9VcU5MbmRyeVB3YVFOdWZKZ3ZodldOMXdFcUpoVDBOQWdYZ0lKZy9T?=
 =?utf-8?B?VFg1MFZHOS9tRFpZUHFaSDZod0k1Q3BLZVVUWHI4WVZZRlRtZ21PNFpqOS9Q?=
 =?utf-8?B?STZYY3BrSjhyZFZOUkhocEpKSlk1R0lzNVVBUHh5SU5JSUthRnVnSUVON1Vz?=
 =?utf-8?B?L04xODBkbHBnVzNYamJrVkt4SnVReUo3ZjRXekpkY0tGQ1FsS05pS0NZWUd0?=
 =?utf-8?B?cFp4VmhQdmJJb0U4eWZ1citlZjhRRU96ZVRxMldxTXBGZFFWSWptZ1ZOVm1y?=
 =?utf-8?B?dVhZbm4wY3Q2VVhCeG00cGdKRUhZRjN0YlUrblMwMTR0Yk9EcWhDdENnQndF?=
 =?utf-8?B?akpaSDl1SDBYd2hXTDBkaXNTVE8yL08xZjBZeDNueHB5RnFsSUdSNkVneExL?=
 =?utf-8?B?dzVMK1dxaUdFUnNsMHkxTTRzbFFGcW13SG1PVWtlZVRjZHNqYndvUFdXeFJR?=
 =?utf-8?B?Q0tSWnVIOWY4WXdudzNidHcwc093R1E1SFo4M283UmIzSy96dG9vbVVZNUtV?=
 =?utf-8?B?eXBEaktrNjJiZTZGSjlWUzdiNTQrc2hkMnZsc1ExRmcxRDFuQW8wRjc5VVdC?=
 =?utf-8?B?SVJIMGMyV0hjWmpUSlhYZXp1K3pjWk40UHhBWlJyVmlUUFd6OWRIQzJJSVA3?=
 =?utf-8?B?MFY2RTFmekc4WXg1clQrTmFvTzFjaHZFa3RLU0hBYkNRekgzWTEzQlVaNVlr?=
 =?utf-8?B?MGlZTDBMblpmOHpBeXlGTWN2ZWxHREhWM1dKY2dTV3RJWFdEYkQyaU95K2hZ?=
 =?utf-8?B?NUNmZXptcDJCaEZ6cUtrZDFucTJvQ3EzbW5jNStmaHI3SEFmZjhxWnFwa1NG?=
 =?utf-8?B?alk5WEVsZ1pIQTAvSlZuaTVKR3FDbHUyYmhwNjR4S3U1Ly9DOWlGb3dCNXY5?=
 =?utf-8?B?Mktsa1p3czI5SGtBWkxNbFNwUjBLekRFRzNzQVIyNm1sQXpiZ3ZKKzZxdlRE?=
 =?utf-8?B?ZGo3bGdpamxaVVAzaUhadz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB9056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU9jbWpVbHQxVURNWjZhbzVVbkZhTXFCVFVWa3pIZTNZMXFBM25WVE5OL05Q?=
 =?utf-8?B?VER2U1N2d0dLSVlmcVJxdTh0R2U0Y1BQQUkzL2cyTjl4UVhLbEtyRk01YXJS?=
 =?utf-8?B?ZkZ6Z2lQbEl6eVFneXhDdGhDaGk1eFhsd0tkWFVlRUNWT2RqK2JyeGxlMlR6?=
 =?utf-8?B?aDZWTU11Kzhxd25LVUZETzdLdis5NUxPRDJDOW5mUGNndFV3K21ReUFock5P?=
 =?utf-8?B?YXlQNVBINWhFdEFOSmMydHRNaWhNS0tpVE1rR0VkNjh2U0dkcVhsN2s0dXVn?=
 =?utf-8?B?QXZaYWpjU3BvMWM2eUFNc1Y3bkZPU1llZzlaVk9ZSUhJQUMveHc3OUFYVU50?=
 =?utf-8?B?Q2xXVkVZZ1JWcnoyaWxNRVZLajNQT3JMS1J3TTZyNDZDcjJkUDVsdExBUUp5?=
 =?utf-8?B?R2lvRVE4WjEzMmRkTTRoeXc5M1h0Q1UyT1h5WUFxZkxIQS9HR1FxYUlnbVlZ?=
 =?utf-8?B?ZzdRUUxiY0N6U2RMSVN6cFRVTnhDTTUyMmQ5MjU3Vy9YM1ZSYjBkeUtVWVht?=
 =?utf-8?B?MEpiUjM3Y0IxVUN4OWRUQllZOWZTWlRQR0x5TTMvMUtja3FCTVh1NmFIcDRv?=
 =?utf-8?B?TGhWWVA5SytTd25XU1JzNkpMemNlR2srZHFHM0E5VlFPd1RBMVk3M0ZWUDlP?=
 =?utf-8?B?cFJtNkZyQ09yWTFMeFFQeWhlWE00Nis5YmFOSmdMWTIreE9DRFpMTy9CUW1L?=
 =?utf-8?B?QU9ySEZZZDN6MU5DRmJlT1ZYTjhkZkJTK1lLckdMeVJiU3dESEVaMDd6VTgy?=
 =?utf-8?B?VEo3YkNJVWwrbCsyeWZkQXpKSmliZHZUODZjdVlHZ25nNGZHTTFuL0NvMUFV?=
 =?utf-8?B?cFpnTlNONzdaeENudEhDd2E5RFB0aGI1R3RMYzkrZGNJWU1JcDllNmpMQjQ2?=
 =?utf-8?B?M3JIREI5VEtIU08vL1BmZHpqdmpCajU0RENXN0tiVFFDcU8zandmblFWNWd3?=
 =?utf-8?B?UDJyc0JQUU1IdVk5ZFphN00rR25qV3pjdnEvY2lYa0tDeDcvK3RZRmNmUHh5?=
 =?utf-8?B?UTM5aE9lQkFBWEc1b1phZlM4dzY1TFlhK2RJVTJKT2I0SjRwOEdQeEp2ajNJ?=
 =?utf-8?B?T1lrMHg4ZzdGTjNId0owNkV0WnpzYy8zYmduMG5peVZpTTFReGNab3JOaVhq?=
 =?utf-8?B?dExkeFVOUVhLRFd2Z2N4T0V5L2VmdnE4THcxWU81c09GR0ZjQ2tKdnp0THBS?=
 =?utf-8?B?V1NvVWZTc0Q2Q0oxc1Z3bU1MVmN0SVdYaE5sOGplOWtlV1V2d2gwQUg2dFIz?=
 =?utf-8?B?UGQ2c2QrOWUrNzgyM2VyL3pZSnZWMVBjb3JRV25iYUlVU3JwYzNpZlE2SGdl?=
 =?utf-8?B?dGZ0YmJTQkRUdUhrRnlSbEhudmxhNVRHQlZUU3NpcmNUbk9VYkx4V3c5aTlU?=
 =?utf-8?B?OWxpZnQwVjhmRHVjMVdVUGFNbTZFZEp4cHVzRXdsc2VEM3FlWEhhekwrVlMx?=
 =?utf-8?B?ZFlnTGhpYXc1Z0psVXpBWmFqWW05SFJUcU5mNlg5Tm90WWRnalp4NFBzaUhj?=
 =?utf-8?B?a2FWRnFwelJVRXdFZ3U3L3pUQjN2SXBGMHJPRnlMQTBneVdYZ2YvVnkwK1cw?=
 =?utf-8?B?UGRuWElIRDNUSlBRNi9UbDNJVWc0Um1oZWNpSDZZdkFPdWdmcjI2eEliY3NZ?=
 =?utf-8?B?V3FJSC9CUExqZ2E1S1dHTkl3a1EvcGh3dkJwZEhnTkJlR3czUjQ0Q2ExSk1i?=
 =?utf-8?B?bmlobG95TG1yaEIxem5KcTRLamx1T0JRWGpNWE9oQTBtV29LaGVoQ2VqWXh2?=
 =?utf-8?B?MDZ1SEQrWGRoNW1RQWRhcGtwSXlxRHJKKzd3b3g0clFXK1ovQXJCQjBxaVZP?=
 =?utf-8?B?NDZWSDExNThBZ2dtRjlJR3JabUJWMko3OGFCODRVK1NObXNZY2N2ZjBzdDBS?=
 =?utf-8?B?MWNUdU9WdUlmdWdWMklkT2tOTGhlZWdOZVlVY0E1S0xmcFJFUkdCQTlWd3VN?=
 =?utf-8?B?ME1CRUpISXFlMmVuSnBLaWE0a21VUjBST2dxc2x3QUhIMnYyZDdrQXF0K21o?=
 =?utf-8?B?U2ZwOGtwQVZ5Ukl2TnJxR2tYNGtpdVlHQUswelFCY0U1aU9hclpVYjZqWW5j?=
 =?utf-8?B?YXpSN3JRUVRsSWFhNTFtRlpuSTM2aHpNbFhDMitpRnJuSGRiaS9qaWlQeTRi?=
 =?utf-8?Q?ja1AEkyiHp8+L2eWPv80RjSOf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865d19fa-fb9e-4a1e-fa7a-08dcb604b117
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB9056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 10:44:05.2169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLhDfxJNtMmggCV/HjmU2VzGcHZfRyxAuB+i/332fFu7hEMzc4ebu5V8ueRix4NOR9XpeHqeWGZZQXzIW+55Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8958


On 8/6/2024 4:09 PM, Robin Murphy wrote:
> External email: Use caution opening links or attachments
>
>
> On 05/08/2024 9:41 am, Ashish Mhetre wrote:
>> The current __arm_lpae_unmap() function calls dma_sync() on individual
>> PTEs after clearing them. Overall unmap performance can be improved by
>> around 25% for large buffer sizes by combining the syncs for adjacent
>> leaf entries.
>> Optimize the unmap time by clearing all the leaf entries and issuing a
>> single dma_sync() for them.
>> Below is detailed analysis of average unmap latency(in us) with and
>> without this optimization obtained by running dma_map_benchmark for
>> different buffer sizes.
>>
>>               UnMap Latency(us)
>> Size  Without         With            % gain with
>>       optimiztion     optimization    optimization
>>
>> 4KB   3               3               0
>> 8KB   4               3.8             5
>> 16KB  6.1             5.4             11.48
>> 32KB  10.2            8.5             16.67
>> 64KB  18.5            14.9            19.46
>> 128KB 35              27.5            21.43
>> 256KB 67.5            52.2            22.67
>> 512KB 127.9           97.2            24.00
>> 1MB   248.6           187.4           24.62
>> 2MB   65.5            65.5            0
>> 4MB   119.2           119             0.17
>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>> Changes in V2:
>> - Updated the commit message to be imperative.
>> - Fixed ptep at incorrect index getting cleared for non-leaf entries.
>>
>> Changes in V3:
>> - Used loop-local variables and removed redundant function variables.
>> - Added check for zero-sized dma_sync in __arm_lpae_clear_pte().
>> - Merged both patches into this single patch by adding check for a
>>    NULL gather in __arm_lpae_unmap() itself.
>
> Yeah, that's cleaned up really nicely!
>
> Other than a nit that the subject ideally wants to be something more
> accurate like "iommu/io-pgtable-arm: Optimise non-coherent unmap" (sorry
> I forgot to mention that last time),
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
Thanks Robin. I will update new patch with change in subject and add
your Reviewed-by tag.

>> ---
>>   drivers/iommu/io-pgtable-arm.c | 31 +++++++++++++++++--------------
>>   1 file changed, 17 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/iommu/io-pgtable-arm.c 
>> b/drivers/iommu/io-pgtable-arm.c
>> index f5d9fd1f45bf..6fecf3d9fe67 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -274,13 +274,13 @@ static void __arm_lpae_sync_pte(arm_lpae_iopte 
>> *ptep, int num_entries,
>>                                  sizeof(*ptep) * num_entries, 
>> DMA_TO_DEVICE);
>>   }
>>
>> -static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct 
>> io_pgtable_cfg *cfg)
>> +static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct 
>> io_pgtable_cfg *cfg, int num_entries)
>>   {
>> +     for (int i = 0; i < num_entries; i++)
>> +             ptep[i] = 0;
>>
>> -     *ptep = 0;
>> -
>> -     if (!cfg->coherent_walk)
>> -             __arm_lpae_sync_pte(ptep, 1, cfg);
>> +     if (!cfg->coherent_walk && num_entries)
>> +             __arm_lpae_sync_pte(ptep, num_entries, cfg);
>>   }
>>
>>   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>> @@ -654,26 +654,29 @@ static size_t __arm_lpae_unmap(struct 
>> arm_lpae_io_pgtable *data,
>>               max_entries = ARM_LPAE_PTES_PER_TABLE(data) - 
>> unmap_idx_start;
>>               num_entries = min_t(int, pgcount, max_entries);
>>
>> -             while (i < num_entries) {
>> -                     pte = READ_ONCE(*ptep);
>> +             /* Find and handle non-leaf entries */
>> +             for (i = 0; i < num_entries; i++) {
>> +                     pte = READ_ONCE(ptep[i]);
>>                       if (WARN_ON(!pte))
>>                               break;
>>
>> -                     __arm_lpae_clear_pte(ptep, &iop->cfg);
>> -
>>                       if (!iopte_leaf(pte, lvl, iop->fmt)) {
>> +                             __arm_lpae_clear_pte(&ptep[i], 
>> &iop->cfg, 1);
>> +
>>                               /* Also flush any partial walks */
>>                               io_pgtable_tlb_flush_walk(iop, iova + i 
>> * size, size,
>> ARM_LPAE_GRANULE(data));
>>                               __arm_lpae_free_pgtable(data, lvl + 1, 
>> iopte_deref(pte, data));
>> -                     } else if (!iommu_iotlb_gather_queued(gather)) {
>> -                             io_pgtable_tlb_add_page(iop, gather, 
>> iova + i * size, size);
>>                       }
>> -
>> -                     ptep++;
>> -                     i++;
>>               }
>>
>> +             /* Clear the remaining entries */
>> +             __arm_lpae_clear_pte(ptep, &iop->cfg, i);
>> +
>> +             if (gather && !iommu_iotlb_gather_queued(gather))
>> +                     for (int j = 0; j < i; j++)
>> +                             io_pgtable_tlb_add_page(iop, gather, 
>> iova + j * size, size);
>> +
>>               return i * size;
>>       } else if (iopte_leaf(pte, lvl, iop->fmt)) {
>>               /*
