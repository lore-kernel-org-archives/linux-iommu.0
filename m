Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EC61946A2
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219519; cv=fail; b=MtKZQdmxfLBQTNSdz+1s/9nBjqQw2bp4dM+rpvx8IDCxm9U7NQgmoecFkmocs/4VxB3/HnG8xxaZkQzOLAQo3tLgqiFVThY4vh0yQQmtH+k3LbW94Nnn5EPMhCnMjKMTaHSwoVzuWwItmPM2NHBuNGvL4n9oBeHrR3twAC2RCOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219519; c=relaxed/simple;
	bh=5TUjqabhMutNY1heLwyWtSYap8AJDvaTwx9m3ZstPGI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ui+d5qcP4tnIkhzN7rqAYjTmWkN+bUziaKo1+rXmgexd4J8eemUXluhOig/N6MQpUtQSistTvIpWJ+Edf+9ISzIiXWrhJ9WIrJR75POpM19It1Y1IkE+Z/2nUtBA4OXVAEBLgHp7uuMB/hNO322c+8VmY65b55Njl3+SlZ7AucE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X//74/Rh; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X//74/Rh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPzDGmgzq3CHqhB0Vrmzo0VbjOBW6t9XQ54PusYBFxBI0eXLBD/Y2ha1P7NLj7r4UruaaGqBIKPEX4TP6nLHqJFFyfuQhiX83B5+aRd6xqNMI3ZVtAxaVcEoCNHb6T2wWNsabfqrfoJgsfbfG/rlD0a6JdMYZOz4nKwUTll05DCLKDOfctevJUG8nM55JgnrImyhfrGWnJcFne+3EgSq6vdV7evl3g5Uoy4onihudYjvGJZ0LhUGdbNJ2BbppCD8uYABQXHJ/Nom0uoAACFAm/Mu71zoYOihqSlkYZuysmWffy2DYDi6iARBdY7jX6Gkr0ynKnNGOm1RIs0bMiZuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ya/dH1gXU7WPtYLWM63l/CX5vnN0XQD+A05PP4EsXA=;
 b=LPnfdg813CTM9HqzznGFHAdmoFIfV4CidM0zPbnT95ZlQ5bDJ97xV0EOPBPtV/CHdAJ6hRNEct+Dm1cCdEtlFYnW/R0BuzXc4Q4By7f7TiWh+Gxa5m/AOfJiphzffAncpoe8UltSRSv6uPBjnhENmt7liTL1MrGFnulQ7ZRMxFnTF2rrLXRiFnYJWnLWMMOFVlXP7HMGCzu9U/ly2m6vWIZzw5tqvIEWhn0phRbj0mdmczxKxJGGzlNOLLe6EM77/j06nJb4yDzdou2ljJbY1Oiv4mHsPWskmt6yHekyc24HmXIaVGXwW7oyq+12eJjoHa3hdSR9YKyiMm1phQpAew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ya/dH1gXU7WPtYLWM63l/CX5vnN0XQD+A05PP4EsXA=;
 b=X//74/RhNa5tBZxkVW7p4Z0uHTbeUxt04P+UdGP0zXlg3XvKW3Jq89FetT2Kv+znSPTvi1vm3zt40ZDXoWK9jJPJaC6ga2HTuCdb9fINmZpyNltWS6XdSHliGa4f6vt4AagA2T5kKyVOebVuixOK8gBezmlCfkkJUqKtv8cS37E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 16:31:50 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 16:31:50 +0000
Message-ID: <ca1c84e2-f36f-4384-a3b4-4eb095bdaddc@amd.com>
Date: Tue, 29 Oct 2024 22:01:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Fix prototype of iommu_paging_domain_alloc_flags()
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20241029105849.52069-1-joro@8bytes.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241029105849.52069-1-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::31) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 81db2d48-3270-4f9b-af1e-08dcf837303c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWNLM1VRRDdhRThZM1NIaDNXSFZ4dERZTjBuMFJIMnkvbEZ2alkwY2ZZdDBv?=
 =?utf-8?B?Z05sTzNwQnMyVUtqVmV2UDJwWHgwTmwybFgrYXA0M3VJSkp2bGVTdldza3VQ?=
 =?utf-8?B?cWhJRFNINVhGcGZIY0xYb2kzQStwVU05K0pxOGtldW5CUE9iamRrK2k0b1Z0?=
 =?utf-8?B?RThXMkZkNFk1Mlh0bk1pbzNicGZlVWNpWTM3dGJBVzMrSEQySk56WklMY1dE?=
 =?utf-8?B?cjloOXFucm5tTERLVGxGWExVL3BxNGNYL1JEakZsaXQvUUtzbENCU2cwU3I2?=
 =?utf-8?B?azVtWitES3VGZkxHa3RnNmFrWVphQVhtQkJoNmpqNEVsU04rbFpzeGIwR2F0?=
 =?utf-8?B?ditDVnZoN09oQTEvbDhjWGI2VXFrZFo2Snp4d01haHVUMWJCYVZwQUliRjFZ?=
 =?utf-8?B?bGRVMmVGREN6WmhXS0VRcjFpZ3BmMU1MQ0JWZmFLZWZtRWtHaGFmOG85L3Nu?=
 =?utf-8?B?ZDR4dUQwVWR0RnpHbTkxY2YxUEhiK2hnN3lJMklnNXp4YUd1ZjZMTUlVcWRk?=
 =?utf-8?B?cWZCbmxyUXErSjFsa0duWWdaV2Voa1EvZ2pxSUFKeXZsNzBNNWkrN2lKKzhD?=
 =?utf-8?B?M0d2N2piUTJrUzZKV3dQSGNRMVR5MHRXbzRXMTZ4a0l3ZEVKZlhRczdCOFkv?=
 =?utf-8?B?dHJkZmxIbmpjRmVicXBLS3VnMkN3T0p3N09YaExEaUtWREI2bGg3MTB6WStH?=
 =?utf-8?B?bmEyc3pzUWs2dnVxWjlLd0c2aDlYZGM4L3FDNUJZaUlUdFkrbzBkRlA3T1p3?=
 =?utf-8?B?TFhqaEs4Zi9hQmt3dHk4S2FOZ3lmWWkzTTlRMUwzOUU4SlVmWWw1NDFEUHFZ?=
 =?utf-8?B?Y0ZGUmlJSEpWMEtUd3FxRVA0R0FNVXB2U0YzQzJPb3pTNnFncjNYTGhuMlFY?=
 =?utf-8?B?UjloS244RlNzYVRTWEhabnpQb2g0U3RlUWV2VXNSYVA3MHhYM3JoRW4rc2ZB?=
 =?utf-8?B?aHNNdXdGbTRseUdKWUozN28vVnJhMFRRcmlLNUdTQ3lTb3RZTUVySHg4TU01?=
 =?utf-8?B?N2Q3c2FxdU5KTWpaSE5iRWw0UmNkN2krZW9yQnNyQmsrSlBBMlE0T3pWcDZV?=
 =?utf-8?B?ME9uWDZZQVpsZFBwZHZHVVFqYnduYkczT1lqWFRQMjBwb2VxdDhZdFNpbjBl?=
 =?utf-8?B?WHFjQUFyQzZXOU5RN3lvWm5FZmZOdXdWempTYXFwZEdoY3hRRVpKM0Vxc3BO?=
 =?utf-8?B?dVFBZzh1Um4wN2E3cTNpazhzdG5PTTBBZTlUamNlZmxQd1g4amFxd3FHQVJk?=
 =?utf-8?B?TW9icVJMek1qaUpPc0tJamx4UEppclZhVEp6dlhVTmRZNWFpc3FicmxRQ3N2?=
 =?utf-8?B?S2ZDYlNqcDVHM09URjZzdnFBY2xaVERtZWhIYzJNTjVKR2FIdVl6dGJmVi9i?=
 =?utf-8?B?NmJZbTMzRHJ0bVhCYkxGVFprajQ3VWtpYVdEWE1tL3dDZVFRSXA3NWxrb1hP?=
 =?utf-8?B?VkEvWitoWmNQWE5DcUtMbUdra01jeUpVWDVDY2pQZ1lvcU1vNmtCSC9SV2VB?=
 =?utf-8?B?NXFmWG1iNHJ2TGZ2cTlya2xadGFiYmpXUW84NWZBNEpMUEdjOW51U3NLM2pP?=
 =?utf-8?B?ZnFHODBOOFA3SkNHeU9NY3ZsaXBVdkc5cFY3cmNmQWFYYlUwdy9RcmY4S2g1?=
 =?utf-8?B?Ujdob1pGcmhTNFRCTEFTcG14dWozMTJ4WVhpQ0FWQXBaOURpci9IbUVnQStQ?=
 =?utf-8?B?S1BPbGZ3djk0cVNkcjZ5RWlMZTZYNWxYWG03Rk80ZStMVlZJV1R2eGR2ZTBi?=
 =?utf-8?Q?CpaLv+fm4UiUdfaMwGEMLtpM55vlifeHzvJvgDe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVBja2I4NkNiS1VpWUtOWUN1cmxIcjNTTUcvcWNYTk1hUzFmSTVOWEtrb3lo?=
 =?utf-8?B?L1hOYk5vVHc5WHhPSmJGbVFiaXZKU3NFenJqQm1XQk82cGxqZlFreUV3TWow?=
 =?utf-8?B?V3FzVUhMNkx3VlR6aXplRmZpaTBWQ0Z3T3hTZzVmZFArLzNkZndISStKVE9O?=
 =?utf-8?B?Vy9qckxieklrK21LUTg2cFNYYTcyaXM1cWp4cXBKSE1xVUNhMDZENGhPQW9h?=
 =?utf-8?B?YitGRWNEWmxTbFpvUG5BTkRRRmpacTBLaEl6aVVPaUhzWnBsaG9HdVNDZVNB?=
 =?utf-8?B?T0cvV0V6SytocElyV2VDemdrSUVxTE9pNkxWR3gwWGNsK0duQ0JGWlBJWXJv?=
 =?utf-8?B?SUloRC9WeEpvTEEwNHBxQXh5cGRLYWY4MkZLalRiQnFkYmFuY2cxODZGZWla?=
 =?utf-8?B?bFBienFUcWtNMHJ0S0x1dmp1QUhMS2NzVFNuOTA5UXRmbEhhYlBMR2l4aVIv?=
 =?utf-8?B?U29DeUovejVEN3ZZNi85ZWI4VFh0SklxY1htb1h0MjIyZGxuZEdQZ0VCOStD?=
 =?utf-8?B?MFBORXM5MG5iQU11T1NyVmVGb1REc3JIM2hSWEtaUmx4L0ZqVjlHLzcwUkFh?=
 =?utf-8?B?R3RyU1Jld0x2RWdZY0RiMWtHMzlzMjN3d0djWnhram8vQTluaUdzMXpkTmxQ?=
 =?utf-8?B?WllDc1VNV05wYklEcjRXTUFjNzJLdjR1YjlXdGJpOEpiaTFlaFV0cGhmWUpz?=
 =?utf-8?B?UlNUOUNPL2xqSDhLMTJ4dCs4ckE1aXRZMFNwaDA5dWI4cGtHcVUxVlR6VERW?=
 =?utf-8?B?Q1c4ZVh5Umh5dklTeWM1NHBOT3loUzAyWmR2d2N3b01xNGpkUFhUOEw2cUFi?=
 =?utf-8?B?MWVVVFZ4Y3k3RkFsTlAwaVBpTTdWaFd5L291OWl2SFBHUForU2RBcUIrRWFL?=
 =?utf-8?B?Ri9YOVZlOCt3UDU4cGsxaC9lTldwQ3BaUjNjWVgwazVxVDNuclFGTnM1bmFi?=
 =?utf-8?B?ZEE5WTk0djVMUWhsSUJpSW1POEZYaEwrL3BKTGlEU21MaGhJamNFOTZNR2hq?=
 =?utf-8?B?NDFXM2RGbmsxMWNoZ3FBWXZZZkVrRW1LZkRPbnBVOHo0UGd2VFdkTUVXOUZX?=
 =?utf-8?B?bU1YelpsNW1lais1T0o4SzBHQzhRM3FKV1dGdkY4bGVRMnBrdVlXejRZWnJa?=
 =?utf-8?B?M1R6anpXN2E3MXlzeklGVExWL1I5cTlaSnlrMkE4MllGY1U3WDRheWFqdDRH?=
 =?utf-8?B?TzNNTXpjOG9YOVhKRXBra1JmekNaRXZNb1BCeDRNQUp1SHdXWUxFWXhDRzZ4?=
 =?utf-8?B?VHVCdGI3NEpvcnU2dmhoVjFDZ2FWcnpiSEJwVlhwWGR5Z0pTbDd6REY0dXlZ?=
 =?utf-8?B?ekJORzU0aEdLM3hrTDE4YURsUlJBNXZlVnZGV2xMek5JOXQzSHRBZGFySSt6?=
 =?utf-8?B?ZnJ2SUM5U3huTy9VaXc2NFAvM2NTbFZzRlpnSnQ2QWdpRUZ4ZVhaT2RDRmJ4?=
 =?utf-8?B?c3ZhS2Q3eStRaVlsS3QwMGJhNks4UzMrb0U1a09md010bUd6MWFLYVR0WTJl?=
 =?utf-8?B?c2xINnQrVHlxVnJFcnNvZ25sdmpVT3FqMzkyQlBsdnhSblc5UVhDTUl4OWti?=
 =?utf-8?B?Mk5SbmVEOXl3YUNHWGZnZ1FQZHZFOWdHTG01dWVLbndJbnBqVlo2ZzZ5SXZp?=
 =?utf-8?B?ZXB2UkI0aEF3VDVlVnpsemZ5SjNSZ2dWRmlKT3NRT2NzcWNOYVgrVlVpNVBL?=
 =?utf-8?B?ZnFMRVI0cHlMNTNnNGZldVJqVURneXZpNitpTnVYTHZoK2s3SWVTZGhsbDJv?=
 =?utf-8?B?Ym9lVUJ6STdUMWp6NXoyZ21oeVh2SUtQems2eGg3UXZlVUYvZmdiUlBDbFpD?=
 =?utf-8?B?MktCOEsyR21pUTV0RlpOZWtWNGVCWFhKR1k0ZlFPS0FwQ2JxUWpkVUQ0RlpC?=
 =?utf-8?B?bHB5ekh3RlhQVnZ2NmtEZnpqT1NRY1dOWURwQ2daT3ZNbk1HWThZUEdyRFlq?=
 =?utf-8?B?Tk14ak0xYnRIL0p6ek5Qd2kzREdOcVpYaXMvdkVMNGMvdU85Ui81R3ZmcEhz?=
 =?utf-8?B?aWZabkwrSnZSdHRSVXFZM05KdGlRRnFKY1J6SDZwcEZjY1JqblRTb2FZaTJl?=
 =?utf-8?B?bUVxc1JMTWdqdFhmbXprMUFHUExESi8rSGRQUW5GdHpsWFlGRVFoeGNZOVRu?=
 =?utf-8?Q?8IY9j5EzA3+P/90lmTSHhIo5o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81db2d48-3270-4f9b-af1e-08dcf837303c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:31:49.9485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nT+pMrWVkiNCcoD23QQJKVOSs9A3XDYr2Isok++z7RSrXrGn5WJ2ulATdF/JL1pM1F+Iur4UcHA9t7n5EjE+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7939

On 10/29/2024 4:28 PM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The iommu_paging_domain_alloc_flags() prototype for
> non-iommu kernel configurations lacks the 'static inline'
> prefixes.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Vasant Hegde <vasant.hegde@amd.com>
> Fixes: 20858d4ebb42 ("iommu: Introduce iommu_paging_domain_alloc_flags()")
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Sorry. I missed to fix this one.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


> ---
>  include/linux/iommu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index aa78d911fdda..522efdc7d815 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1080,7 +1080,7 @@ static inline bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
>  	return false;
>  }
>  
> -struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
> +static inline struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
>  						     unsigned int flags)
>  {
>  	return ERR_PTR(-ENODEV);

