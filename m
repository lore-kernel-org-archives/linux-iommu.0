Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E899F40BF5
	for <iommu@lists.linux.dev>; Sun, 29 Jun 2025 05:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751175535; cv=fail; b=MI0cABg4zhnfGbvAN/MQzgJ08dNMog/4LSOZ0tOWJ9q1i6WtuUC39l8ITWEnQTRMbtElMw0suIpPvrrKQToeSlCOwkXrJNWj+hnbdKPR57CUJrkFdQ3n4plRbJbwRTUx9ks6o7416pZWncQOgFkG06mPwMos1dc22PgE4sEPSM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751175535; c=relaxed/simple;
	bh=bPwRtQpyyN/UoeloPuzT/9pvZu0ydgOj9esPQ11fqZs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ifkm49pz6ULJ7LKi/XsFlkSCleYxHVAXDFcAzpa7XLSz4dKJRkdRsDuf5I8eh1nOeqLg4ZS0DYgTROXwNYCWY/VFgYH/wjddVmNAkStKfq+e5GCXFxR515JkXmU1yfgzboS2h2HSIiDEII/Yj3I7Hp0c3gVpiGvTr0+tPK04E7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1RZhX0ik; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1RZhX0ik"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkwgAIfwhNJk8Lj2+SbQbzgHw6TvGEU26y6PnyJhNeTdVmV9axMJhT2v+LaSgqkT9iBt7eMm9O6/Sq5BaQb0uBVvTEQReYPEdpzscW+nNkkZePCQsroKgqqD36m6SVXLsxHS+bLK/c6S/cITYa6FhVJtw9lmjiFfphwylbtWLcmi9wI58H7zvXR3Pv7EFQ2naszx3Voih+XcInZhNG+PsdNL+cgELuqInH1d4SA4ZXfln+6nEAxZI8e1xkl7nUxkpm7oxojXXLwGQGIJRaUT74Mzs8+vYvZQWs7I7yqIfPKYKPamyjqbcIjhCW1AGwiED9iNXNs2KpX7MCnCYwrfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWPrxgw1es86MGIf5saZrkaqMjkxz3cjVydA8xpG2Kw=;
 b=AdbST6PdLHswgEUFuWpWAfPnjixLMYZ+GZYuVLyB6H9Q6Voq8xoHiL6YOoMRa1va4zfjKt4qVR5wBcsf5bk2srBxgXYwFvFXR5H/HEwom4nKs5OJuDwsBISQ8L2eioaNDVZORaYb3gvONkgGR2203efJ1RcqekCswq7fW+YAtIG6EsiJJOP4oRUKxRTVVNwIF6ZLLPtf9/q7QrTMyKgBHPgX5MkHTz+4fReH0I3y/MDJxRP9HhfZ5IB10iqkTspEAzsvJqDZUTXbdxGohYLtVCu5UXHufcCYNce7OhY8WJiX9WB+QjyjqPnhycg+dtX6bjJZffKLOS0EQaq0mJLo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWPrxgw1es86MGIf5saZrkaqMjkxz3cjVydA8xpG2Kw=;
 b=1RZhX0ikT9/ClQA87z/atlUDKJ+m3hyEDZNSCR+x1PHKHQUKkZSSPhWajM7gnPXhs1U2FO94h4exp/GeLVj1TXhdOLqJyI3uB6HQ2X8v4+L5s133q9IO8pLp0wfXery+ttJdmgn0EMHvC/Yai4SLCzpNBq5tmr3OCbJwOa9ms5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Sun, 29 Jun 2025 05:38:50 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8857.022; Sun, 29 Jun 2025
 05:38:50 +0000
Message-ID: <5b360e8a-03bf-4886-8134-8e4ab5a9f485@amd.com>
Date: Sun, 29 Jun 2025 11:08:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/8] iommu/amd: Add debugfs support to dump device
 table
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
 <20250604163647.1439-7-dheerajkumar.srivastava@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250604163647.1439-7-dheerajkumar.srivastava@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe23dff-2675-45ab-2553-08ddb6cf39c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmVTNmk3dEtVZVpNbGFhcUpXRUNDSisySnVRZ1hNZWlKT3R1NEw1Wi9Tc0Zh?=
 =?utf-8?B?dTlvanhjSnkweXZKM2F6ekZ2R0MrOEJJRmN1dFBTemM4Z044WDdrNllNSlFz?=
 =?utf-8?B?LzFvODRzSXdCV0xDSWR2VWI4bzhHUjdLTVBiWTZpdkJCdmxibEhDV3F0Wndp?=
 =?utf-8?B?VDBsRmgrSjRhRlByYzNlVjV1SHRaQW1lTUkxVVVtb0xVZ1ZkNFZBVUkzOTFt?=
 =?utf-8?B?cS9iV2dXYkVoM0s3QkplN21SOVdqYTVETTVYM3dkZnJrWDQrU2wwdWlIQnRN?=
 =?utf-8?B?SmxycGsxY3gxaEVRVENrQ0I2T1g5NG9IVjBWcHVwZi9tbXlNczYyckI2bi9Q?=
 =?utf-8?B?MnpTMWdYc1k2bkNtbEZRZXNxM1RzNnR2cmlvWkZmR0E2b01zeUNZNURydjRw?=
 =?utf-8?B?MVVOZ3RzZVpldjY2OUQ1TTFveFF1R215Mm96WlpkZlFBTHdlSVg3cjQ5VEs5?=
 =?utf-8?B?cklpYUtaUldaMlg4TzliVlY2LzBhSDM4aGFuQnc4VVZXK3RDZG1uc2NFTE12?=
 =?utf-8?B?ditxVEtIRjFWRFdxWUx4NkhiNEFWZVlVQnJGK2FoeFZNbWo1U0JCa254bGpB?=
 =?utf-8?B?bkkwa1JZUjc5UzcyencyUm5JbTl1RTVWVmxaVi9WVVhDa3dSSkdTTGppdnU2?=
 =?utf-8?B?aXAyUnBMSzRwZXBqY09NOXZ2NFN2WVpLT1ZkK0NUMmNUK29FVFM2RjNBaTAw?=
 =?utf-8?B?NWpIaE5kR1VDZ0c4VXk3ZGxZSU5wQWx3Kzc2cjhRN29FSU5CREVBV1dPR3Nv?=
 =?utf-8?B?WkRIWDN4RGcyTmVuYzZlY0tvMzBVMFE2aEdQZjBibUdtbm0xWmxIcVZMbnow?=
 =?utf-8?B?aEhnVGZWYkxwRXFtaXJadEpmenllSFF4TFg2aFJ2anQ1LzRtS1IwREJVYWJw?=
 =?utf-8?B?NU81N1I1eGNuZXVyUis5bXcwc1NXUjNKZ29rdjUxakNkekxScU9ZUFZRdzhU?=
 =?utf-8?B?SjRlTS9EUmorWHdEM1pLTXVLNXpLc0xJaXhtYU5SL2diWUI1OEdZQytrbmg2?=
 =?utf-8?B?eldydnM0NzhyTkxObGhOOVM0TzZOUW9veStoTjlCakFJcG1kVlNhWWp2bWxu?=
 =?utf-8?B?M1lDQUM3TlRDQ1ROTUFrQWJobHBYUXFvSHNvemRadHNHL3BBM3kwajhVR3Vl?=
 =?utf-8?B?T29EQUJBeDM4TFpBRUgzTW9TcHEranJ1dXRwR0t6d3J3YWJSM1dhUWhyNmVT?=
 =?utf-8?B?VHlWVGJabFZHRGlqR2ZTWmxjQmdFbXlSWDR5TmJ0Q3BMNFl5K1dyQjNlb2RC?=
 =?utf-8?B?NXAxUVVXdGI1a3JzcXlWVk0ydUp5TXg1SUt4L0lUMDZCeW1EakMybG9zZ3Y3?=
 =?utf-8?B?eVFqQ05uZEhTUHZoVjA0TkMxSG1yaWhuYzlEeCtrcWhDVkc3U3E1NTZEek9w?=
 =?utf-8?B?T3B0L0VjY1I2clFKa29nL05YVzBadTNzejZSc3gzZmZvcmhMTlNhcTB4ZjFD?=
 =?utf-8?B?UWFzQlBTbjF1TDhBTWZyZU9NalFGeFlqRFdrSTFteFRqTURyWll5RC9GTUt4?=
 =?utf-8?B?YWptN0dLeEhQT2pPRXl0WHNtSUtRZTk4MXNXYVJvVUVoeEQ4Z2FXRXBZNFBU?=
 =?utf-8?B?anJGY01HaDREOTUxV1dzakNQbWFkbWp2WEZrT1BhVjdFbmQ3bmsrYVhsZHpl?=
 =?utf-8?B?bE84QVY1S0FuUkNtOTBYMEZUWnUvU2pGT3J5WWsyM3RuZ0R1SVU5Y1pqMDdY?=
 =?utf-8?B?MG53QmVUVGpRU2M0a0h1WjBkM3NWYUg5b0pHM2NSZytLSjJnaWRTVmgrT3lh?=
 =?utf-8?B?a1RXZDBHUmJZbDcrZHdMNzhjbFFpaEpiMEd0OVVqVk0zbUF0NDdGQW5GcnNy?=
 =?utf-8?B?d1k2MElwdzREWk9HanlYQksxZWlQckJ3dTJPRmFCZmt1Qlk5V0h0NGJNeHZN?=
 =?utf-8?B?Q0FKdXdBVzk3U0RDU1g5dml2aDc0clhYK0Raek8zb0ZaUjVKK2FyTERjQloy?=
 =?utf-8?Q?MiMWOq1NJto=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUpXNURJd2lQZHQzL3hmaENNZlJwZjN2bUJyckVpcEV1TEMwQkFicmprdFFB?=
 =?utf-8?B?Zkk5US93cEdQTzIvWElTV3ovREl5R25LWlVobnFXbFJ2WlkxWTBGOTlnSzZK?=
 =?utf-8?B?eUFITThuMVJodVVqQ0tQMzlmV3VFaFJRb0dydjk5eDN1SjBLRFhnSVgzaUdF?=
 =?utf-8?B?VHNpclhrSFBReEorZXRtU1h3YWdqV1ZzQlJiS0tUa0RRQ1daN1JrY28rbURW?=
 =?utf-8?B?RUl1bS9FaTRvVTNkbVhRK0wrZW4xKzgrNXBaS1NpTG9sNjdoWVpmdTMvSDht?=
 =?utf-8?B?eVhCTUNhTTNDTENXL094UlYrMTlnVEpHdDE1d21yUXN4WGZxS3pJK3pTT2Fm?=
 =?utf-8?B?bnRyQmY4YlVkZ1VmQjBndlpCdndpaWRncG84ZWpBMm1zNXo4c2RkV0tLYm04?=
 =?utf-8?B?T2NWREc3NE1QcWRjb0VSTHNVUEI2aW9zUVY2MGdzV2lRMjlMOVV0MjhvNGZn?=
 =?utf-8?B?TFBLeWFaZU9FL2Q3ZlBiSXA2VitzMGtpZ0h2clBRMG05VERSaFJ4cmlZZU1B?=
 =?utf-8?B?cCtudnNqbzNjV3IrVkc1aUoxaG13Y2VzRFR3RnZRVnNDWUluZ1lRYjlHOHpO?=
 =?utf-8?B?ZkxlSkdvQzhGRzBrODM0VUdpK1FmUERwWlYrN2NGZGgvckhnaERpRW00Q1ht?=
 =?utf-8?B?TG11NXNEUFJqcVUyRnpYTFZkMDJNMDVmWWNtUCtZVklnWTRnZWJaVDNpbFRB?=
 =?utf-8?B?eVlRanVMMmtNYStBZUZJNmRPQlNtc0o2dVZBQWxVT0paVTBoYm80cXlSTWll?=
 =?utf-8?B?ZE5HckZ4a2dOOTQvMHJzZkp2V3h3SFBENUtQWnFNbTYyMW9EODVpQnJzSk1C?=
 =?utf-8?B?V1U0Y3JQenRER0JVOXA3V1gwMkpXdytiT2tMYkNFeFpqWTdzNEJUVHQ4akhD?=
 =?utf-8?B?ZFRRRUpNOXBMMEVDMGMzN0krU3pveGdBZXFIdjdCRjduZWlmZVBhMFp0TStQ?=
 =?utf-8?B?VC9QNXdBb0tGNVd5ZkgxOVhyUTVtaUxGOXhPa1VtMUpib0NvODNUUFVtRUt5?=
 =?utf-8?B?Z09mVUh4Z1ZpVEN0SVFzQnVTL0hIN3doWFhLZytlOVlCOWlkUkNzcUFRc1Ft?=
 =?utf-8?B?QTFjMlRBT1pRcXJQcUhaUEw3WWdnOVJjL0diclc4U1IvV0FTOWhMVFdvbFo0?=
 =?utf-8?B?SlpMcjA5aUlycW5CV3Vua2FxRVZ3WHNYendYN0lPTzN4ODVNUmhSOGE5d1M5?=
 =?utf-8?B?MEdjZDAzVllxNDRWdThpSHZXd2pNUHBxd3IrTC82cXFwOWRFQWNycmFGaUcr?=
 =?utf-8?B?VHhmRGczamxhcXFXUEpDVzdyVFF1d0Rwb1FCcHVheG1LRlNoU3ZBRGsxbkNN?=
 =?utf-8?B?bUo1dEFHMUVsZ2I3NzFaQ05SOGk0bTBmbGNqaGt3aU54OEFCdlB4WW93U2dE?=
 =?utf-8?B?TzNhWDVnTFZnNnFxREFVMnpST1RsaFRGRVNOUUlZdkFUa1ZVSzdzK2JnWnlv?=
 =?utf-8?B?NjRJczMxcnZLWnhlMU8rT2J3V1VaaUt1cVIxbmVsYTBXaXpyVEY1aGFRWVpr?=
 =?utf-8?B?NGxnRVZnRkdyL3NkVmdXdDA4K0RocnE0b0F4OEp3V1Y0RWVOdTlMakR2R0ha?=
 =?utf-8?B?dWF3M0UvenVKK2VBd2hndXJQVXIrKzFEZkljRnB5YVNsaHZOVGZtQVIzaDkz?=
 =?utf-8?B?RzBRcnczSXpoZk9udGhUbjQ2b3REMTFGTkR3TExKSTFoL1A2SXphY3l6YzAx?=
 =?utf-8?B?amY2eXBCTjZmUWNVOGJ5OXRsWnJ6MDBzRnNVZTNHWGk2NlFmUkhzZ3JyRWxn?=
 =?utf-8?B?dWorWlBRWnBJNGllZStBVHpJTWF1OHVpbUJNS2JTdXhkdHFQbGYyaFdWS1A5?=
 =?utf-8?B?YUwrVno5cmNEdmt4VWMydURmNjdweFJmVXZrZFdVdHgvU3JDTjJUMjRscmZq?=
 =?utf-8?B?MTh3K05QSUhidEhvK3JHVS8rYXRYMHJtSlhLYitPSzFyY1Z0N21FNXBhaHls?=
 =?utf-8?B?K0ZNYnB2OGhnQ1FWckhFZDZOMDFZKzRhdVdtZy90VWZuaEdYV1ZaRkg5cldp?=
 =?utf-8?B?dm5vUUlNNEZGL25JNlYwUmxtbDlwOE9uZGxLR3A5MzNvNEN2MUlwTGVzZC9B?=
 =?utf-8?B?LzRsYlJwd0FLU01JWklzOXozcUJpTjBob1Y3QWd3eHl2RGZ5cHFGa0dxdDNN?=
 =?utf-8?Q?Yk/PwHQfM2U/Vs2nN5WK23O99?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe23dff-2675-45ab-2553-08ddb6cf39c8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 05:38:50.4787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Umj556RTroxIIG47gZmiGTFUAMoVFnQh6mk18rCk8+uHQojiUT785VXpsYbf79LY+HLcNAWTCe3hGVMCoHowgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767

Dheeraj,


On 6/4/2025 10:06 PM, Dheeraj Kumar Srivastava wrote:
> IOMMU uses device table data structure to get per-device information for
> DMA remapping, interrupt remapping, and other functionalities. It's a
> valuable data structure to visualize for debugging issues related to
> IOMMU.
> 
> eg.
> -> To dump device table entry for a particular device
>    #echo 0000:c4:00.0 > /sys/kernel/debug/iommu/amd/devid
>    #cat /sys/kernel/debug/iommu/amd/devtbl
> 
>    or
> 
>    #echo c4:00.0 > /sys/kernel/debug/iommu/amd/devid
>    #cat /sys/kernel/debug/iommu/amd/devtbl
> 
> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> ---
>  drivers/iommu/amd/debugfs.c | 49 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
> index 8b57ab4ab809..38d3cab5fd8d 100644
> --- a/drivers/iommu/amd/debugfs.c
> +++ b/drivers/iommu/amd/debugfs.c
> @@ -207,6 +207,53 @@ static int devid_show(struct seq_file *m, void *unused)
>  }
>  DEFINE_SHOW_STORE_ATTRIBUTE(devid);
>  
> +static void dump_dte(struct seq_file *m, struct amd_iommu_pci_seg *pci_seg, u16 devid)
> +{
> +	struct dev_table_entry *dev_table;
> +	struct amd_iommu *iommu;
> +
> +	iommu = pci_seg->rlookup_table[devid];
> +	if (!iommu)
> +		return;
> +
> +	dev_table = get_dev_table(iommu);
> +	if (!dev_table) {
> +		seq_puts(m, "Device table not found");
> +		return;
> +	}
> +
> +	seq_printf(m, "%-12s %16s %16s %16s %16s iommu\n", "DeviceId",
> +		   "QWORD[3]", "QWORD[2]", "QWORD[1]", "QWORD[0]");
> +	seq_printf(m, "%04x:%02x:%02x.%x ", pci_seg->id, PCI_BUS_NUM(devid),
> +		   PCI_SLOT(devid), PCI_FUNC(devid));
> +	for (int i = 3; i >= 0; --i)
> +		seq_printf(m, "%016llx ", dev_table[devid].data[i]);
> +	seq_printf(m, "iommu%d\n", iommu->index);
> +}
> +
> +static int iommu_devtbl_show(struct seq_file *m, void *unused)
> +{
> +	struct amd_iommu_pci_seg *pci_seg;
> +	u16 seg, devid;
> +
> +	if (sbdf < 0) {
> +		seq_puts(m, "Please provide valid device id input\n");

Where? This should clearly indicate where to provide device id.


-Vasant

