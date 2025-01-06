Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30FC1DACBE
	for <iommu@lists.linux.dev>; Mon,  6 Jan 2025 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736160938; cv=fail; b=VSeasTlIKQB5Vu5rmRcX/2sOkVX0L88tGU38PLeY35ndFWHgF/CdsaAs6TeIXHT5NLtiHR8muCN+sKhhgNJaFIR3SIMemX8VZu2beU1Ltbpd+Vk1Ands61NQUsD0+Umi1V82k5iSlDekBq9AzfQvSnSokygeIP/H+IzK7rEritc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736160938; c=relaxed/simple;
	bh=pVB4EROj1gDCkPcWynjyPBJ4F8PFlem4bTVZGQt4Ngc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZnZ+kEi8gHyE4WTywhKqyuW/l1lqhlCLT36vZQ1bNB2KKA+MBxKGVNmimwr5fyi7GLuLYtFQxIgG/2YMJmUIu0pqbEvyWI/Z2vtOwzeiBubIA9uINAxNlf+p9pbghpplzB4wUFtyUed76mfsYkhmupSQ2sYzdfek6NYVNTp1uMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NlQRdjOf; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NlQRdjOf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqi86a76aG4kxFhY6L56mU6GNfyDHO8BSDnT3lCoOBVrihoRtfBbzuTYje5QhBh2eV2BgTeWBFYp4R4x0z8FreHdy1J0XSzJGNMFttLXu4vrMn+ZAh7+k30NbdJU+/30PFzz6LvZByDuqEwP9Gv0x7HRvNacjPEaCTe2o+AJRnoV6o0p6o6AeDATq63At7aK0iLi4x+4UJdTr5PRoTI4ur4wrOJebnbu+VfcwHQX5vHHiWslfXADpsoh9uHva0ugN2FfpLFE30V0gAgEh//zBcW8CaFk4HbUSw1u9tKF6Z2TQdp9zQDhGzEuiJCQWLTQtUi5Mc1a2v0pjFpQnEnFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLlYlURc1zDEIqa5SNLKZK9jnIt9eZEoNf38uEsosHw=;
 b=ODIuesCSuNlvi1C3zX6Htli1tAEnCKHfHK2zs0btlVII84X7m2qAN4OB9dYnS5bcfVYYQiE8qM0SzVtQ9r/vzceI9MgQB3D70O7B1fBkEGLKws5VuE0RcQW8f80O5yjk6x7PPmI1nsrfHI+Qc9bVObhKU8gQiIqcbkW5MsMdfDl+8clvWW3LhKd7ReOjq89uTjt67MHfKoOdgZ9AbGR+LpFtF2vUrzD5fF0rZsysG6JE/IxcTdHY+186Mus2cy2ZuuIAVUwaozolb5xLynQ0jwFthbJtFF2gPV+/o8kCWdQLmqaggXuloIkXX/pdcPeZo33NUs/JhJ4ni+vIUz7MrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLlYlURc1zDEIqa5SNLKZK9jnIt9eZEoNf38uEsosHw=;
 b=NlQRdjOfweILiWNe/uB5S9q8slaKdsgT4JqvUW3uAEGfH7vu+XD6SMKmRN8taqYBwVjWNvY/p0E7C8nGuMBXq5Q34mFUpCkCu9IgqXk6W9RIkQoSjMOzqWAtODMsw/2tI4DwWkMU6yLJWA0uGr3PQuKNi3aWUQa8V9exZ2eDX1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.17; Mon, 6 Jan 2025 10:55:30 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 10:55:30 +0000
Message-ID: <ac420b8a-cd5b-41dc-8a4d-247f560a9043@amd.com>
Date: Mon, 6 Jan 2025 16:25:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: move the adding group info to proper place
To: Li RongQing <lirongqing@baidu.com>, iommu@lists.linux.dev,
 robin.murphy@arm.com, will@kernel.org, joro@8bytes.org
References: <20250103052811.39544-1-lirongqing@baidu.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250103052811.39544-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a52616-45b8-4f3d-6433-08dd2e40a2c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWJIYmdVMmxndlVxenNRNlF2U1MwcW5PazFwczVpSVdETVV4SnZBMXdRVWpQ?=
 =?utf-8?B?MCtndzVVRU9MeFpCL1lFeHZmbUM0eituaEJlcEZvSVgxZ3RVQ0l6OG0xdHE1?=
 =?utf-8?B?RkFXODRiRytxVUJZVVBDRldMVkdBTWlrU0NJS1h2OGpaa3VnczlXRml0VDNZ?=
 =?utf-8?B?dEo2bWsrWVcwdzVEQ0ZqdjVjcUN0L0tGQkh0SUJLYXBXR0QxUjhXY2cwOXBv?=
 =?utf-8?B?TUMxcHIwZU94NHhxcmRWZThkd1NVcUZCSzIwT0YrTzdWSlUvTFNiRjhBNDcv?=
 =?utf-8?B?TjcrUmdncC8wLzJzOGduSkFjZWdubXpuc3FvSmNxYzMxd3RJSFFxN0pOSEdR?=
 =?utf-8?B?dGx1eitxb0VIZVlEUU1YYzN6QSt1L0txWDliM2I1QzNJZDFybm90YzFhVWRr?=
 =?utf-8?B?blVlT3BhVnhOZlFhcHFpZUF4U3E1dDBYV2x4elpHdHdwZ0ZSYWI3WFlGcDRw?=
 =?utf-8?B?b0NLSlBOWHVwOEZKYmNPcjdEOVRMQmMrZlhMemc3Y2t2eE03c0FXd1dVaVlJ?=
 =?utf-8?B?dkVPYlNmNFBHN2pXZVN1aE56Wkw2UFlPSnZaQlorajd4Vk9iOUhzZGdIOG1K?=
 =?utf-8?B?eUtSbTFiVEp6Vk40L0d1b2d2TnFGbGJkanpxbzlMTlp2aVNFR2RUTzhDZnlF?=
 =?utf-8?B?MU5Fc25Mck5vVTlUcWs5YmNKd28zVVNoay85UjhWc2hham1CVWZqdkFqYW5u?=
 =?utf-8?B?NjFid2pWMHRLMXBFQVYyWkZDejZ2ZjZnNW41azNhRlNtbGxXSDhjWGZ1R3V3?=
 =?utf-8?B?cUlENnFoaVdWR0xOQWVpdStCYUt0c1RnZTdNdEhHbGxuMm9aVFRWVWE1VWEv?=
 =?utf-8?B?Y280YzBxb2loSEFDRmk0WmV0aGtVTWNSK1I4aE45c01IaGQwdzdmSU84ai9N?=
 =?utf-8?B?dllIY2YrQUl4Y0E4ejRoZWNIMUY2Nm82dnlzR0twTjFiRWVxc3F4cnBkOHZO?=
 =?utf-8?B?aWdZTjJqMFdPMHRxUmlDYm1GM1Q4M1UxS1pTbWZlazZoeVdtMW9VdDYzQ3Va?=
 =?utf-8?B?bFUwQk02TkJHRkRVQ0ZpREhJU0VFcnMrZnFpcW03NER0eXVEblBKS0lWQlFm?=
 =?utf-8?B?N0dHMzVWNHl3TDlybm1TcnlZMERBcHBrdEZaazdYU1lJL1p0K2xDbUJTR0Q1?=
 =?utf-8?B?ZWtHYTBwelBLQm92eUY3bWswQnFtcFdoNmd6bWpsR2hJV2h2ems2d1dNNWtQ?=
 =?utf-8?B?dHJnNDliUkU5Y3h3dkdKZ2xlRG9yZ1g1WG1OTW8vbVgrM29PbUJUa3NZR3VT?=
 =?utf-8?B?RldUdkNYTk8yRHpHWkZyNGJ2K2Npc1ZuMkkzV0p3SEo1SVJzVG1Oa3MxUkF4?=
 =?utf-8?B?VlhUMTduclQ5TnlvSmhsdERxbStDak4wdmk0b2pXQ3dnZ2VOSkJaV2tacEtI?=
 =?utf-8?B?Q29OSnkvYk9VRFdwNW5IaDFLRHJiTE9YZjM5bktHQ3orM0hMUWxnZWpUZCtF?=
 =?utf-8?B?MnFNWkZIU3h0MFZ0Z2JxSDc3QStaTDhnZzlOMVphcDhYTWRlc1gyV2U2VElT?=
 =?utf-8?B?N2pKeEkweTRJSW1VU2ZuU3hpWEtjbVM3UnFQUm1PdzYvdWl0MHJ0eGFac0FT?=
 =?utf-8?B?dGh3MGpWcXl1dHFBUE13SFRnZ3lENVpFZXRtSW9QZ1YzYmtKTG9jL1lha2k1?=
 =?utf-8?B?VHBXVTVYcHpBcEtFeXFMOVlvd2NOZ0F1TVBVWVo3VzVuSm5yckFmQVcyMVZE?=
 =?utf-8?B?TElBZThKTmg4UHFpZWNYME9QancrV2E0aXZ0YURqVzBEeEhKWEx0MVJWNFl4?=
 =?utf-8?B?a0l6bEhGYzV3clkwWmdORnBnV2kvZWhaVlVzOUFaUUNEaUU2QmRCWklKR0p3?=
 =?utf-8?B?QURtOEI4Q1hFYjR1R3VqRTdvWG1ETGZaaGVBZG01SE9LYkdsZ21GQXRtWSsw?=
 =?utf-8?Q?qFZu5yM/6j0v4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3g1N2I2SmVqV0xHZUU4ajBmaU1CZlFrVGN6VFFRYnZ0QmFrTW5zMFI0L3Rx?=
 =?utf-8?B?VTJHWnZ6eFNRKzlTK016OWpNY3FwWjhvUkNQOG02bE9wbHR1VDBFWlY0U0xW?=
 =?utf-8?B?bkx3NzZYWmJndEdQU0RCR1Q1V3ZlSGU4ZzBXM21KVzZTSjJlUVRFR3k0Qm1G?=
 =?utf-8?B?Q2lveEc2WkhJUHVuMWt3a1BWNDdKUFBGK0hMRHp4cXJHcEpxZWdDcFlyYnd5?=
 =?utf-8?B?bCs0RjNsdjZTVnV2ZVd4ZUc4RkliMDI3VmR6NjlIaTc5ZTN0dmxlT2NwakM3?=
 =?utf-8?B?WXRESjBPb2dZSWMzcFJmeE1OdmpuYU1sclFqMk5EL3JrWjBhRnBFc3FtNGhF?=
 =?utf-8?B?MlJraWJQSHpyWHZmNzN5ZUp1NE85UENtaHVOdER1VE9EZXk2STR6ZDdXUTZh?=
 =?utf-8?B?aG9pT1JMTkljSmxMdlp1ZDcwZkFZL0dja05iaFZRVG44UnpSODQwMHpQdExZ?=
 =?utf-8?B?TEFwVTIrWXY0d0NWVnFPdmxjZjZ0aWpuOXh1ZmRuWVBMUmtrcVJxVXZyREFI?=
 =?utf-8?B?RjdGak9hNmFUd1FhK3diR0pLellkNXFZaC9SK05iVnBhZFVySEhoVVV3bW41?=
 =?utf-8?B?SzNFb0tEWUx1N2tENDFNNlBTcjE5UnJWUUNIZHJrTmFaMkVZaHZhcWdOdWYy?=
 =?utf-8?B?NzRFdHdZckxZR0dPKy9FdVR2amhHYUQzUHZsdWpYbG01OG90SzFlNnRVdlQ3?=
 =?utf-8?B?VVlwWnhFeDA0eVBZbC9Eek9Dc1NGbjlBbnJZb0UwU2JUY2VNb1R1MFF3aUFY?=
 =?utf-8?B?bG9yZU9Ddzh4VUFGamI3eExrVE8wckQvNTM5TCtHRS82Rlk4YmlkbnQzK29I?=
 =?utf-8?B?QTFqcWQ1MkprOGNXQTJnVFB5SGYwRWRDWS9kQ2d2WHF4dlNnWDA0V09iS2ln?=
 =?utf-8?B?dkJpZnNrTEJwQjVJbnVZWitnUDcyZGJPcmdMNEhqTXVHK0t6UlFXOG52Mkd1?=
 =?utf-8?B?UjFtVVVZZkZVdVp2eTlZTjR0VFlHVnYxSXhWeDhmUTA2aStqQmhyeW9KNVBn?=
 =?utf-8?B?T0hhVGphNDA1REpBSjc3RVcrdnArMmFkY0ErWm5WelN2cjhQTVQ1QWxVUSt2?=
 =?utf-8?B?VGY3RUVSY0NGcHJmQ3lrdGZSRE1mQi9vck1uVXRkdTh3bzI1blVVNFNuL0ZM?=
 =?utf-8?B?UDhsckFJK2tsOW14ckNIcFd5ZUFyOFFhZXFjT1FYaW83clp3SnNRNVNhUGsx?=
 =?utf-8?B?bk9nSkE1ZnovaDhYSFBaTG9TVGovYkU1azVDMk5Vbmswc1NrVkNMZ3VNQkZi?=
 =?utf-8?B?d296YjdSUFM2S1RpeXFtWU1Kc25zYzg1V3R2ZGVTRlJmSkhuRDBzSUVlRTl2?=
 =?utf-8?B?Y0l2OWw3NzRlUTRMV0lSNnBiV3N6QXpRcmVhZWNMQjhvS2t2elcrWmpJb2lQ?=
 =?utf-8?B?dHAxZk5IQzI4TDA2Nzg0OHRyRHA4VU5haWpuWVQvekYxc0RRNTVGWS9DMUVL?=
 =?utf-8?B?ZzAvMGlzRDYxTWxhVXZsQTE3cU1IUFRydlZZNVp0cDRQZ3NtWFVQVkNNaDFG?=
 =?utf-8?B?c1JMR1gzS1V2RkM1VXdFK3VQQlQrZkFoZXFHazduWkFnbDkrR3V0Mm1tbC9Q?=
 =?utf-8?B?VWZLZXlCeVdzMmZxS2s5QlVsRmtIaGlhbTl0TTlxVHB3Rk52a2wxYlZXTXBH?=
 =?utf-8?B?RFR6elV4Zm0xOU1BaXNFay9rYjMwUk1NRDBFMTcvdWlNTlUwbzMwdTJWYWFK?=
 =?utf-8?B?MC9wOXBVajhKaHNZUnJValk1dkwreWVnQ0hvRmxvVFg0azM5VWsyU0V1Ym82?=
 =?utf-8?B?S1ZDTndpZGlLbzA0bkVSbWthdTBndVZBc0FpUmw1Z25xN3ZzSjFZN0V6N3R5?=
 =?utf-8?B?cVZFNXlqeENzUWtjVGVuaVg3cGRBNGJycmRUWHZXdk92WHZkTDFCRDlTcFho?=
 =?utf-8?B?aHdwbzJpejU3djJkekk1RVl1Z29EY3hGYmZNaFZ6dGhET0wvWTgwaExpeU5a?=
 =?utf-8?B?VDhzdyt4b1VoVndKZHZuVGN1YUNpOEVQby9ER001QXNWNmJrWVBLSmlTL1ZE?=
 =?utf-8?B?ZWlGY0dsWFhrdnlHUzhjVDhEdmRmRkhSbTJrMXdsVTJvYmpKdTh1dkRlekNU?=
 =?utf-8?B?amRBV1hra09SM3pFTHRVZk1MQ0pDN09HVFl6dHUxNXQ4S2ZBRDFZTk5EVk82?=
 =?utf-8?Q?EGL0mamQFPZmysetfnsDOjEm/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a52616-45b8-4f3d-6433-08dd2e40a2c3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 10:55:30.3924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2u4wALNN1etZohZ5aXLqj+7AtaNRkKiL+lgqvWXwrecSkpxDbSG4Rr02ON0xXrj+MUJlQKYkOQOYP3OtVsVXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320

On 1/3/2025 10:58 AM, Li RongQing wrote:
> After commit fa0828036488 ("iommu: Split iommu_group_add_device()"), the
> adding group information is left in iommu_group_alloc_device, but which
> only allocate group device, not attach the device to iommu group;
> 
> so move the print to iommu probing and adding functions
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/iommu/iommu.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 599030e..03f95f2 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -586,6 +586,9 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>  
>  	mutex_unlock(&group->mutex);
>  
> +	trace_add_device_to_group(group->id, dev);
> +	dev_info(dev, "Adding to iommu group %d\n", group->id);
> +
>  	return 0;
>  
>  err_remove_gdev:
> @@ -594,6 +597,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>  err_put_group:
>  	iommu_deinit_device(dev);
>  	mutex_unlock(&group->mutex);
> +	dev_err(dev, "Failed to add to iommu group %d: %d\n", group->id, ret);
>  	iommu_group_put(group);
>  
>  	return ret;
> @@ -1192,10 +1196,6 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
>  		goto err_free_name;
>  	}
>  
> -	trace_add_device_to_group(group->id, dev);
> -
> -	dev_info(dev, "Adding to iommu group %d\n", group->id);
> -
>  	return device;
>  
>  err_free_name:
> @@ -1204,7 +1204,6 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
>  	sysfs_remove_link(&dev->kobj, "iommu_group");
>  err_free_device:
>  	kfree(device);
> -	dev_err(dev, "Failed to add to iommu group %d: %d\n", group->id, ret);
>  	return ERR_PTR(ret);
>  }
>  
> @@ -1230,6 +1229,10 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)

Add error message if iommu_group_alloc_device() fails here?

-Vasant

