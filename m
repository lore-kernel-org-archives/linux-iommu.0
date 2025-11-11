Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D70934B1A5
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869599; cv=fail; b=P0kJawTv9CBLu64xYpZhWRGDeijSWusTDxXDmGEKG7W8pBDEdwIA0JDk8s8Lmq//TiOe9RSLC+/qb9LZRSS3LD+Lz2DwhOYTRsH9XXYj6M3zyhrq+v+dhbn42M/mrQkdz+RlSe79othg3wS1HRKDlPuiYtXwq6lnNoHh0KDaRxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869599; c=relaxed/simple;
	bh=z238szjZQsV1Kp6XVZMOLP+RnEJRJUcXA6Q6SkuQfHE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hkmSFhqJdHrHrE2YA5Uc+fbDNY5HXmpyKvQtN+Ui3TyPMx2ELidoKpJRRNjRhK6NK67BzC5Pl2AzWPjFBp9niQyZPL3dID4pwsac0yRh+kGeL50+iJ0KWwVLp9JinTOz63WIj0v/omOMe3ZruzY34D/3U17qISwQ37HMzqgQ2xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZW+x3cvT; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZW+x3cvT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yocgXbZSTAdG7+8Bt22i25wWzZRorStbp/RelXCYEAv8l0y55pl+yVoYDxNFKegG51wpM2T3iK41m1Gc7rJ58R1p6CkdIUB7M5+TenRiHKBgdA33NpZDFEhsfD+uecvOPpR1EioGfNXuNOA6u/GtiA1LzJKNPJCL5HisEJxrOUAoUwCKRYPa2PGa4MQVTa/QvIkuICc4M7BxEpG323FU4NFpdKV9wL1z4QcbUJTOvCSvIjbqTwNuZ1JtuidjlM6jHNMyNA69y/oyi8qLH6O7pxa8wdvYCwNQbwgWQmJQWwYVCIUfThZk2klLxy60yM9CCuNqlnZyyD4sBAy+Jg1e1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1z4XvUnwi/mAvkEq1duUZW4Th78SZTj00c7i+PPULs=;
 b=UfjDkw20JQ1bM25UqFkDlt9mnU/owz6bwwImsK64Mf4UjSaKsJJJ++6efHXRLuEO4TBq1yNo8PVuN+mkiBzdPZ0lQHYWHMGh+vNAQ1wq2sj2x4bUgLx61M/u+9WgZpAg6S9OrMrPWBdtfD4ROAiqriT32m6O6dhRPGJIW1sSM2h4vU6S0zBFGUrJoBSIADqC21hZ4OKC7bCfM/ucaOpRbp93O41+1DdxEpbhi3bNKozrk1WCoAv0jZv0WjIMx0MusU3EGuRJ+kT6AKKeRggUF+43Oxn6Rg5d6Da0I5uNPVsd1YFVOsCq0InIDhRFF5TdaIbwPKJ9iCK4+G9qpiWFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1z4XvUnwi/mAvkEq1duUZW4Th78SZTj00c7i+PPULs=;
 b=ZW+x3cvTNqJ3duX8VLXE6oMAhJOgFSq58ZjAjBis2sDGYEvja6Pp6/6TVpGZbWwLlCV2GhLbKM5QEv1cwFAoFIPq7/mMwF7zeIntjqYTckZCbZGo5OJnrpTdhwGqyt/4w10UQKfppoWIaWomqscF5cGKP1+kV3s/7f82V3Y3DJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 13:59:53 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 13:59:53 +0000
Message-ID: <942b601a-410e-4714-9852-842bb17acbd8@amd.com>
Date: Tue, 11 Nov 2025 20:59:42 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/16] iommu/amd: Always enable GCR3TRPMode when
 supported.
To: Vasant Hegde <vasant.hegde@amd.com>, jgg@nvidia.com, nicolinc@nvidia.com
Cc: linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
 joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 iommu@lists.linux.dev, santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
 jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
 wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-10-suravee.suthikulpanit@amd.com>
 <99cb0f7a-0d21-4071-844d-893b230b7038@amd.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <99cb0f7a-0d21-4071-844d-893b230b7038@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|IA1PR12MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: fe827371-bfb7-41ba-3b17-08de212a95b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTJWWVpIOENUdmJseWRqZnBONHFxeGVHMzA5ZUdTb09nVUFSUmMvRTFXVTJS?=
 =?utf-8?B?ODArV2orUVZpUmZGZTh0V1o2VG9ubWRHcnlXUUI5WVArelAxSVFKSmxUL3g0?=
 =?utf-8?B?QXR0aFBGcndzdVlPam5TWnRRdS9YdENKdDVGaHVJRXYreitXbGJCdG5NZHBs?=
 =?utf-8?B?VlNQQ3VLVkVWWlFqa0RLSFNkc1o2SVlvYUNiSTNpRU1vYk0zT2J4cndoaHJN?=
 =?utf-8?B?RmtSTk1ESDlrdmhpZXhJSUF5bmxWb2orOHZ2SFB1VG1BeWhHeVdyWjdVU2Nj?=
 =?utf-8?B?RGpObmg0YVJRR0xmMXloaUFqZ1pkc2VaRjBGVXQrUXR5bVVCZk5qbXAvYjN1?=
 =?utf-8?B?anQwQW04VnJGUzM2U2hveEJlcm16SVFVemRsMzZVRDkwcStvT1FQY0N5Z2sy?=
 =?utf-8?B?QmdhT1h6RGErOUZ4UXFzRy8zNkJyNno3RzFCbGNvRFdkbXJDNWh1bkMyNjlo?=
 =?utf-8?B?WUFWWlF3emxFdzM2TkhtVlZMcHpSQXl0aElybTRLbkZ4d2FXMmFFL3BsNEd6?=
 =?utf-8?B?MkdFcHpJUmFac0FZd1lCUXJ5RmxJblhWWHJDMzkrVkJpZXkvZXJuTmRsRnc3?=
 =?utf-8?B?dHZVaXA3MFlmTzlYeUVsa0tKM3BPM2U3K3pkNXJUS09zeW9MeWpNTGxVYkti?=
 =?utf-8?B?TDRseGcyTGtERm8xTkJiSGo4ZW5HbDZYMkJ4K3NQYWxFQm1TMDRaRHdNMkln?=
 =?utf-8?B?R1B6ZHZBMHN6TFhadWtnR0ZPUjd2N3ZXV0MyR1QwYlVRN3FkU0pWa3o5N0dY?=
 =?utf-8?B?OUlaQWMxa3JETmg3MzZZSUhiZ2p4aHlISlBUUFhzTEFkcGhjZGtjc2F4RExP?=
 =?utf-8?B?N1BBbUxncWFwTGdQcE5OaENvYWU5TURwVjVUY25LS2VmU2t1TkxSOWhiUzFR?=
 =?utf-8?B?SmNRblJ1TXZRYnl6TkpUNzIvQWFQVC9mM1VZR2xiV29PMi8rMExJNkZQSkZJ?=
 =?utf-8?B?MFVMUUFNU0VPQjh4ZHNER09kQ3hUVUNxQ2tRMjBpaDUvRGdWRnZkYTZuaFRj?=
 =?utf-8?B?WmEyVFZDOEQzY0FYQXZiYlpmbmtRdGZhTSt6bEhjVEhDQUwzZHVkYXNpVVhj?=
 =?utf-8?B?VmpzdlZXMENGbkd3OCtGWm43aDd2YkpHMThUUFF0OUdJUnBid1pDbmJ5S0dD?=
 =?utf-8?B?aksrck1PcVlhQitET3R4N1pDTE4vZk10TEQ0WjZUTXNjTnZQLzNFQXJHUjdV?=
 =?utf-8?B?OGxaelJ1L2FsM2k4dmplNzlCN0J2eEZaVzNTZnRnaTg0UkMxNDA3RXhCWlk4?=
 =?utf-8?B?VDNRMUxEWm1oTzZMSEthdk5jd3ZBWDFGdm5Ca2xZQ0dxcGE2NWxrVlNzYXRI?=
 =?utf-8?B?U2VhbnBuMDlmWmYrbGwyNXoxa0NGRVprbmV1UUpxSy9hR3J3RWVPSUJDNjdm?=
 =?utf-8?B?VVVyMXhmNEFVU3dRMTBUVW8rdTlrajl6c0xMcTJsRlZCVWJQUGN2ZzZsbWxs?=
 =?utf-8?B?UWNyT2hIMUtTVVJseGtyL2dYa0hwQ0ZYVDcrdzVYcnhWL3o1cGJNZ2JneVhq?=
 =?utf-8?B?OHNMUDVjZ1FhRGhGRW45R1EzU3NXbUFKb3g3ZVE5azUweU4vT1p5ZTZ4d0FZ?=
 =?utf-8?B?aVl2S0g4TUZ0YldJQjc4Slpsa2hIc0pET25FT3VKbGFRcTNYWDYzTFlQdjVO?=
 =?utf-8?B?RlZVU1RDdXBQdVI1YzFPaGVyNHpqei94UXJqR0J1S1RkckVmZFVXSnlmcitV?=
 =?utf-8?B?QXdBVEZvQUFYd0ZHdTQrUHNOR2JYVTJSM290U09RSFRMNTFxaTJadUcrUXVT?=
 =?utf-8?B?Vkl6M0sxZmpEWndLQTBiRzdnT3J2Znl1eldPd2dSV0xCTmdwcmtQRFh3NWda?=
 =?utf-8?B?aXNLSmJFeUFoNUZ3eW16WDRJbHBpRGZjTkRGV3ZacW9BOW5VT3B0VkhuS05z?=
 =?utf-8?B?WlZna3J1UnExSnRUN3hVa2xSc1N1TDE3Y3l4b0VsRVBkWEoxSnFCWWlkeHZL?=
 =?utf-8?Q?zcn2VFaRABhuhIiZJLVBoSDodjQ6xdKj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M281L1N2ZVpWT3pXWTNGMGpwMnJTSmZ2RFYzZFFDYjE5NytsTms1SkJxNmYv?=
 =?utf-8?B?Zng2MXlOSU5TNWl2MkZlbUswQTJUQ3JTemFIcFJvRU5kMjVrRHpmMnFBU3Uz?=
 =?utf-8?B?N3FkWHVlZXdnMzh1amlUa1lFS0hLMWd5c0NLcDVUM0hwekJhZWdtenBlNGFJ?=
 =?utf-8?B?Q3o4OWhjWmNKaHFGNkkrWXFIT0lFTGx4djI2a1ZBY3E4bWVXaldjWFJMdERn?=
 =?utf-8?B?WEZUYWVnQy85R2FvbUFtL0hlb3BJWlBQVjc4ai9MT3hBN0RXckFkcC94d01u?=
 =?utf-8?B?ZmttQU9ScnQvQUVZZW04Wmg3bU5NR2tjOGU0RUdob3U2RWsyTThha3ptSlE5?=
 =?utf-8?B?cEFjbTFXUkQ2UXRFRjZBc3lBY0Z6Mk9ERGt6ZjYyTzBoaTk4UzhOU01uajVO?=
 =?utf-8?B?Nk5YbVJFUHM5dHlLWlRmZ1BlcWErRGNGRmQxQTY5eUlnUkpXU2ZVcWwza0xS?=
 =?utf-8?B?OGdaOFpQRDJuM2xwL0ZUYlhxWEJrRkx6UHhoOWZ3TnJTK1Q1UHRiU0Jhd1Rt?=
 =?utf-8?B?Rk56Q21ISFZVcTBUamlhcyt5a2dWcmEvdm5JaU5LOVMzdVpoQ1VjcTMzcTZJ?=
 =?utf-8?B?aUcwK1RUT2VRQzZHMGt5bGxPdjVSbE15UWg1RlIrNDFzendQQU5rWEVKblBN?=
 =?utf-8?B?d1NCeE9oTUh4RVZ1cExNT1d3TmlLZ21qNGJ3NlRsVUdFa1EycEF5bUJNN0Rp?=
 =?utf-8?B?eFprMTlhdmVFRDQrTlJrODYyRFRmRzJkaVc2aDEyaGVNM1BhK0UyV0pxNHRH?=
 =?utf-8?B?aGZtUXBRTkZsNGxKYVlHODY0YjNtZlFQU2cyQkk5ZmxLS1NYZy9LZlFBNDdP?=
 =?utf-8?B?SGRNY3RtbUFZQ2R4SUNnR0VKeThhTVlWbHZlUnpUb0lHcHdZUE90YUpEWk5n?=
 =?utf-8?B?N0VtaDhyak13UG1YM2I5bWppc09UcEdBc01TZVBmYk5HZGVaczZyZFh4Q2xO?=
 =?utf-8?B?bWF2QlNMWlNETXBaeVQrTnJkeVdVaHRnemF5WnZydXFSUmFBN00rdWRIWDlt?=
 =?utf-8?B?OHlxeTZYQjVKbjlXMGM4SEwyMisvSUFQNExuN1RySE83aFdELy9BSDI3MHFG?=
 =?utf-8?B?Z0U0Z3pKb2JIWlJ6S1ZCb3R5djE2bGFCUjdTUzZpaXF5NnVSS1J3NGFyMkxJ?=
 =?utf-8?B?eVRaNFd3NkEzOGl4M0VBZk45ODNZbDlOd0NKblhnT2JLblQyS3NQc21HYTkx?=
 =?utf-8?B?R0ZDTFR4VjBNWnJNY1dZL0ZuZHJ6NjBzUTdnbGpOYTUxMGE3b0xDMmdTUEhH?=
 =?utf-8?B?eTJhTnFaQmRTaHU4aFpqa1VMME1seWFWVmJvNVhybTVkNGVZTEx4alQ5VmZB?=
 =?utf-8?B?dEpNYVBnWXpOTlBoN0IrYmxFbGR0RmFmUk5GY2xpcCtzcG8zK3pxZG00aHps?=
 =?utf-8?B?akk1ek5zV0pNQkZEOG81OXo4Yk9zNkZaZW4yN0FUOXRpdGJKRUovc2M3ZHBG?=
 =?utf-8?B?TWxEeWNlWkZKTi8rc1VGVFFLWGIzUEkrRVdjMmdndWRtZDF3WTdzWkVybVNL?=
 =?utf-8?B?MmRYUnpzYThoZDJxUEpWRVo3aVBpM2t0cEZCRFpHQWt4eDRXeXRtUWNnaTYx?=
 =?utf-8?B?azQzQTA3SVNKRlo4U0RCRndtSlgxaHk3c0dMS3R2bms0d3V0Ungzb1RoaDZQ?=
 =?utf-8?B?bFJqMVJGYTFPS3c3T1NiZzhhem03M05veko2amNOSUR5NnNqUHBQd0ZXQkQx?=
 =?utf-8?B?K2hpd3ZFNjBHc3k4L3dmVVp3ZThtMHZrRWV3eUt5SnlTOGdKUFpiS2loZ1JU?=
 =?utf-8?B?TVBiN1EyN0JtU3FYWXVkNjMrcVZQTXZrbkhwaVEzd3FzcG5EZXp2QUtrdDBs?=
 =?utf-8?B?b3l6VUtlNXh5dVcxOFJqRFRaWkc5SUNzbFBnNFluTktJRkVCK3drZEY2cXph?=
 =?utf-8?B?dWk0WCtuaXFDMW5ZV3ZPQUZsbmhrZGh1aVpzYTdVNUlFSDJMTnBwT3NBMmwz?=
 =?utf-8?B?bHNnSlBaZDQ5MXg0aWZDOXMrVU5PUGJQM0RCbTQ4T25uaU9OT3NoL0JOY25x?=
 =?utf-8?B?U2tGRXMvbEJWS1pnMEI3eG5XK01URjFQZUlGc3hESkZYSFZadGNpb09rVU9K?=
 =?utf-8?B?QlhYSGFLbC9Rdld5TStPWkd0Vk5ETWZ6UGU1am4vNGxzNXBod2txUzNqVmJO?=
 =?utf-8?Q?MJqI4WfInDV+hQRtRueaS4xbj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe827371-bfb7-41ba-3b17-08de212a95b5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 13:59:53.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cke3dhd37hurPI1hkgeC+ZxkoltocMfrtg3MCEPrVsnkNKgpgEY36Aa/CNpLAJoar3YIlSjTpCaqMHqRxpRkAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579



On 11/9/2025 12:39 AM, Vasant Hegde wrote:
> 
> 
> On 10/21/2025 7:13 AM, Suravee Suthikulpanit wrote:
>> The GCR3TRPMode feature allows the DTE[GCR3TRP] field to be configured
>> with GPA (instead of SPA). This simplifies the implementation, and is
>> a pre-requisite for nested translation support.
>>
>> Therefore, always enable this feature if available.
>>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   drivers/iommu/amd/amd_iommu_types.h | 1 +
>>   drivers/iommu/amd/init.c            | 3 +++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index 556f1df32d53..9226edd8af69 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -185,6 +185,7 @@
>>   #define CONTROL_EPH_EN		45
>>   #define CONTROL_XT_EN		50
>>   #define CONTROL_INTCAPXT_EN	51
>> +#define CONTROL_GCR3TRPMODE	58
>>   #define CONTROL_IRTCACHEDIS	59
>>   #define CONTROL_SNPAVIC_EN	61
>>   
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index f2991c11867c..c45a4bd89569 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -1122,6 +1122,9 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
>>   		return;
>>   
>>   	iommu_feature_enable(iommu, CONTROL_GT_EN);
>> +
>> +	if (check_feature2(FEATURE_GCR3TRPMODE))
>> +		iommu_feature_enable(iommu, CONTROL_GCR3TRPMODE);
> 
> This works for now as iommu_snp_enable() enable is getting called later.
> But how about moving it to iommu_init_flags() ? 

I put it here because the GCR3TRP feature depends on GT supported / 
enabled, which is checked in this function. This avoid duplicate checks.
> Also we should probably add a comment here.

I will note in the comment regarding this needs to be called prior to 
iommu_snp_enable()

Thanks,
Suravee
