Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7561DA0ED
	for <iommu@lists.linux.dev>; Mon,  6 Jan 2025 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736158148; cv=fail; b=rtbXaAY09eqn8bxgpnEfy5TrPIHKZUlgb+DBlyeS82WhvwM9HRCDDg5eX5PDL84KjFf59Iv0vD6m4TxjfbcJMNg3+qGRU3/NimWmkR4CWL2b6QSO1GRofm3O8u9XynaExDagXc1l1aiBUqIJZEu+DjvDWnM1hJtu5Jucs7Y1qv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736158148; c=relaxed/simple;
	bh=QeomqUF9ICLpxvx+0D8r/fBS0t9NLpnopAMGxzwr1kI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RhJuCwv6JadiFtaV3ViVkCYnj3QqnJK2bydlmPfNW2vO5XVjZ97DPX/pULs0iNepv3eAXAxTQBvsKUPFML6e7I9fndegAlBJoM1VOEwVYDvdPRLeebkBcEkRIJKAgzvOwXtwcyGA7MilA7QG/kBJiw0FHCdVlVHZ3ihg+ywmXAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vl35EjCb; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vl35EjCb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lq4DkS0Q0Y6BGad98QkAlz1lsNiabnbi62fjxL9YZpYLPEcNSFzTjzHFeW6fUXYeuDDgLGtjciLGSH/hgONXCPPJ9fL7dBXoKEXJZhV/900XQ7cI0FsGXWV1Zz4Vjrz9NG83myh3shubOMzj6Wour4c6tXysv93CZxSINx4xi4lgiJFekHfiv76a9nDNogVtMkIpBX63nOdTbsEMCo6iQUgekeuQPAjOMb6zB7JtL5W3Dkr35Zzif/qyK7H7yC0eSuG+mYqYqkmC/6fA9bkZuKc9Zw0FcqHsc6amqS4VAXjAXRL/noN9xLgoVczojPlmUHAtL1Mg6670j4oF2r2/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sj6snFlVQhDUb5NyjWpAt4OhzDoQQ1G+xM3gX4JwTUA=;
 b=n9u7eYlUoAO51IAuaOpacPmvkv7Lum0Ikk3ma3NoQOq/AIOpzpm9dTKrf0xKp2mzIfNlg6NG8mGOgamtVnvRzm+lO4vd6Jm9GTJzZBFDCBgV4X+KSbk+fIymncIP5HLVNaeSnJaGd6YZHFx12ov+4vzLkYFWJw+irzp9k24B7povV1cxhIJwMWKFzvU58hYgVLng1n5WfMJelz/eH4QEFAtPb9k12siqWLHMmiQ12QTb8vSoZ6XQi/8VA4a4E8nG0jhdX465IH2j4p8gaxKuJ6F/svJRIKY069NeCGi9fioSYHDC2TBnF6wXQm88LPa5vm7mvwEuCP4ZYFOT3/9f3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sj6snFlVQhDUb5NyjWpAt4OhzDoQQ1G+xM3gX4JwTUA=;
 b=Vl35EjCbnwKN96CoZmeQktX4slj2QoQdjX61qjOjHOVFUO0SGxVru0z1p2yZS9YuPZiF1+7XdSZkBbPDvvXHWIFqFApgSXyRL7ECdM0E7VrEux1OygpPCfV5dxyjtLT/MSYgUni21/MkkIYvbk3p7y67cuToXVBUitDrAumXJ4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 10:09:00 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 10:08:59 +0000
Message-ID: <2b2fd4c1-e5d2-463a-b7f5-9b95fa7ed5b8@amd.com>
Date: Mon, 6 Jan 2025 15:38:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/amd: remove return value of amd_iommu_detect
To: Gao Shiyuan <gaoshiyuan@baidu.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
 christophe.jaillet@wanadoo.fr
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250103165808.80939-1-gaoshiyuan@baidu.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250103165808.80939-1-gaoshiyuan@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::30) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 902cacbc-78cd-43d8-c6c3-08dd2e3a237b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elRmdkgxMStzOU5BWVFCU0puejMvRmVOeFdFV2tpM0J1enFUaDhnSmN5Rzla?=
 =?utf-8?B?REhROUJDUE41eW0veHlQZytKTmdIVEJQa0M2a256QnY5aEkzaVo3Vm1tVnM2?=
 =?utf-8?B?MlhWdDlzNW91N2I5QlRDSGVrbm9MUlpObEVlY2N1MEllU3gvTHNlM20vaUhi?=
 =?utf-8?B?bnhDZzhBQmYxOTJlZldoTWZrNXgxelVwUGlMeE9hZzZ4V1NvVVVEQ0lGWEtJ?=
 =?utf-8?B?VzNQVmFqYVBMRGo2emVmNS9oWHA1UGRBWkhRTDFoYkNIeWV3eGNkTGNkUjMv?=
 =?utf-8?B?djRCRFlHUDhMYVJ2aU9iRHA0Mm9RR28xMXpiTWRBcU5haURWUzd1SjQ2NXli?=
 =?utf-8?B?Z1B4K1ZleXgrT25KYlB6bE01T2JqNi9rTUdjUzRjaVFqVm45dTVtUllQZGo5?=
 =?utf-8?B?a0h3KzhaYXp1UW4vWmtUWEdiNFZpWmJGNmdkVkVXOHZEVGFtSkRSa2FxTlo1?=
 =?utf-8?B?MHE4WFRodG90WFFpRmZlT0h2NHdxbWN1UFMwRjZ0WW9vci9oeGxIMFQ1NEw3?=
 =?utf-8?B?VlZpUGRRN3RWYm9LOUVoelo2WVpNNXFWVTIxZ3hmUkR6Um94Y1ZFUGpoYUN3?=
 =?utf-8?B?TFVjTWdtY1JNWndyaGxEdmx1cUgrOG5jL0E0MGN6M1J5Z1lQRkdSb1l5dXh6?=
 =?utf-8?B?NEtJbERnVnAzclVXMG43azVHQnpIYWRBbWpuTHIybkU1VDZkNkVNOGZMTnJY?=
 =?utf-8?B?dURsSGxReGdoWHpXRzVqNjloMmFQaW5GWGFkdk5EWmhNaXpUMW85U3R5eDRo?=
 =?utf-8?B?QzZ1QkFwVEZqRE4yekxPTEt5czIybjZhd3pvTUlLVDNGV2ZPTU5iaUNuOUh4?=
 =?utf-8?B?Vi9MMEtpdmFmejJWS3dnTjFwb2xLN3NWMUlGditxV0dqQVhpdWxaUGdNQnZu?=
 =?utf-8?B?QXd5SWhBTDd5eklxZkNQKzBSMUJDbUMwSjNKR1g1VkFYZVdaajVHU3NraDJu?=
 =?utf-8?B?bFJacHVFZENtMWxoYVVnQzhUeTNLRTZCbXg2U29aZFRrem5qWVJ0WGlxcjB2?=
 =?utf-8?B?WTlFd3hVT1FEcmpHeDF2YlVoTVVwaGI5VjVzbG1rSzlLcG4xMXMwQW5ZYTFU?=
 =?utf-8?B?aWpnRHU3WnNyZGlVNHJvZWNXM2pDN0VMWkR2Y0U3cWVTcUt6d1p4cGF2L2Ns?=
 =?utf-8?B?SFhkNU5CdXZ4bGVJSk4rVmxvNm5wNTdOSDB0L1lLS3R2enVudjk1akU5TFlr?=
 =?utf-8?B?MDNCM3VuQVRDVW9zQlJ4ZXFjaWozcVBXUWtFM3FwbjdhalBhRW9tMHhyS3F0?=
 =?utf-8?B?bVpteTl6WStKZ28vSlBaTnl3UFRna0VKOUo4Zk5FSVFkNU5wSU4remFJeGts?=
 =?utf-8?B?b1RzU2F3TEZuWkQ5bE53aWF2RHROTjB6T2J3RjhUaWZpNzRHOHBha1hkdk1R?=
 =?utf-8?B?ekVhZWx6djBXeEhWUUhWa29MclFJNTFYTzBhV0NuQVdCM2JxdFFMTzdTZHNR?=
 =?utf-8?B?b2tnY1V5RTZBK0hwOHcxUXVGOUlUVmFqMlZNWnJ4NkNBc3N2L1NhS2t4b3RY?=
 =?utf-8?B?bkVnandRWUpHMjlMQTkybFA0UWJQMXBsL2hJUXBOQlM0VWd4WjRaa1hOVkpj?=
 =?utf-8?B?ZVd6dnNiUWh3TGloWlNCYktmK2hzNzF2Y0RwU2R1TjdvRXUrSEg4UUNNZFZP?=
 =?utf-8?B?M0pBcXhIR1ZXdjR3NThmK3g0L1g2MitaYm13Y0tXRjhQL1owdWE2bExTc2Zt?=
 =?utf-8?B?S25VM0dDMVQ4WjJmdittRmZYT2gzTUpVa3JnSi8wYWtZWlVCNElJTDh3WlRr?=
 =?utf-8?B?cGVCY0xBSUw1ZGZzVEllME1OTWFTTGVlSWUzd2E1R2hPRkhoZkkzSjNWVmpY?=
 =?utf-8?B?ZmFTYXRSbFJUNmRsMjJoYzFLL0FRSHA1MWhmSHJyRlZ2QzhEU09LcU1BanBZ?=
 =?utf-8?Q?O90yjlElzPXXJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VktMYVF0V0NRNGI1bUxNMzh3QmZvdTJRcWtZREpjMmhJcGIrYjB5RTQ3RU1w?=
 =?utf-8?B?VkI4eHNSOUhvRmc4ZW1JVmhabmxIbGJNVWhPVkdNRk9xaGJuWUFYK08zb0JZ?=
 =?utf-8?B?VGJuNWhiMXZ3QlcxZE9qT3ZwYUlLdWVqTzFNb3hibVVGb2RaanpwWlNDODdy?=
 =?utf-8?B?a01LOG9lSkN3bDBRTDFINU55a0JTRGlObDN1dHQrUTV5SVF5MjNnV1ZrUU1z?=
 =?utf-8?B?UUN1STNMd3hQdlllTHhqcG53OG9LS0J2L1BZdHpPQ0lBc2oxR2U3UDZlakhS?=
 =?utf-8?B?dm9YUVZRbWRnTEpUNjYvdTZPc3hWOTNwWGdkT3ZHc1pNNVVUeTFjbXFqV1hz?=
 =?utf-8?B?NXJDeGVaVmdmVmtVTXNnV3Q5U0hZM3hYOUNUbU91TU9YY1dkNGtyMkZMM0VP?=
 =?utf-8?B?d0RVQzRYYjJESHJoMUNmQkU5dzdDY3QxUHV1SERaWEI2SWtJTmlUZ0MrV0VE?=
 =?utf-8?B?R29PLzY3ZXBEckM2TVdtVDNxK29BbjFzc0xiN0Y5cWlOdGgwOUtFRWZRRzNr?=
 =?utf-8?B?b2VpOVJ0MEFla3JOdHBxSGhiUjRaSXJqQzVkV3EyeVdPM0RTVWtkbjZPc2l6?=
 =?utf-8?B?Y2llVEZvaFNiZE5QeXM0QmtXell2ZkxhT2NTZ3dYY1JMYjE1a3R4QXJESjRW?=
 =?utf-8?B?MXBmOGNEWG1nVy96QXRrRXZRaVBsRnRUVW1DUlFiOU9HVlRnOTdtWUEvZFBC?=
 =?utf-8?B?cHdmS2xtUEdiTU5NVjF6dXFNSkRMcDF5TnFQNmlyZkFkRmZzN2dGbGswS3Vh?=
 =?utf-8?B?cWtCaHA5MXlOYUNUV25VY1k0STdqc0dXOEZxSlZWblluWjVZdjU0R3hacFR4?=
 =?utf-8?B?U3J4eTZ3ZkVyQ25CVjM1c0FSblcrMnpvVGV3MFhxWjJiT212S3Z4MDRiNmVl?=
 =?utf-8?B?OERQNTFoQTMvbUtqaTZVSWtPNDhJNUJmcFNPOGE4L0piUzJ0V2lseDVHRDda?=
 =?utf-8?B?Qk94b01ISlNrV3BhNG1URDMvcWxGWDllL05HbU9YRmRJNXJJT3FjaTBVYWNz?=
 =?utf-8?B?Q0NGYTBwOHNaY3FhUG1wVmkraDZ5WmVqejBsb21qT0k5cUpBa0JtZ3dUa3FO?=
 =?utf-8?B?N21DZXhPUzdMQVJMZytKaUV4TTRBckNjVUx3dmdWQ1hNR1FyZlFzbU5DVWNL?=
 =?utf-8?B?NUZUekpmcGhoOVVvcjh5cHRqTXZ4aWdmUzZSMnVLOWNPRlloSHhBcGdtWVFV?=
 =?utf-8?B?Z0ZJZmFRSGFWcisrcnU4c1VZYUtzS3ZpVjQ2R09Dc0FrSk96M21YTnBkMlEz?=
 =?utf-8?B?YVdvL25rdm9tWEpmajFFRllJTTJrSzRubUhjRkxrWWhIdUNCZG93aUkwUjdU?=
 =?utf-8?B?N1BLVkR2MlhXeU1MTnRmcVNvN2JWQmtqcWpGSEZQdE1CZDFLcTNQemZkSEkw?=
 =?utf-8?B?MTRrMElOWUVISXl2V1l3VG9RalJPclRZQURxbnk0c09WZHZneTByWHdTRzlG?=
 =?utf-8?B?ZVVzQ3hIWWRncVFwNFJIUkhoMEdwZEFmYzQ4dmh1aWpNNllUUjBIeXJSRWtP?=
 =?utf-8?B?ckFkaG9ZN2ExR0MweTR3R1o3b1FlZmg0eWNYcDhqdktmSGtWdUs2VXhkTS9u?=
 =?utf-8?B?NXRuVUh0TVBib1VpWktNY1ZPQVIyaTMzTVNKQnE3VVRacTlxb2NyejdtakUy?=
 =?utf-8?B?Zjk1bE55ejBzQXpRZlA1Qi9HMVZhMTljNmlUUmRFZDVsOVlFN29TRVAxcFNw?=
 =?utf-8?B?UkYxSHVDK2dZdUtjS2VFZXc4QVZBc3o1UGhJc0lscDExSlFlSmEyUldNeGVm?=
 =?utf-8?B?UU12dmNBYUpTZko0MCs2aWxUMkVZN1RQQW5PbHRsaVh2M1duOGU5SGN1SFRj?=
 =?utf-8?B?SmpFY1NiTFdaa2ZIdVlIQzZwNkdiQkliZlFYSkFIelVBQnoyRytwUFhMWTM1?=
 =?utf-8?B?QllTOXozdHVDaC9qUlZmNlZPVjlwcCs0VDV5S1htVSt1SGRIK2VJRFNMQ3Nu?=
 =?utf-8?B?bkFLcWw1WnZoSWtueFNKRmEyelFrUytvSW5IZ3VZWDloWENhNk9wTWN0QUg0?=
 =?utf-8?B?MlZmSFBtNnJzN3MxWnZaMXpLbGZWRFJMNHFKOXloWHZHbmMwcEkyRXJZbHBo?=
 =?utf-8?B?aWVOMTdWTnpkMnZRa0hrczMzUWh5QnZvNnd5L3JENk5vamUwZTlaK1BUY1BE?=
 =?utf-8?Q?wp2tPaf0F9zh6oTme1AZjdJGf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902cacbc-78cd-43d8-c6c3-08dd2e3a237b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 10:08:59.8703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtRO1XCs4D8wkropXoTgfF4T4p27btJjhw5coMATN8xwFrDNIG4+2XmGHM2MHhGXtlkU/3u9JdImlYurbZ2xVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

On 1/3/2025 10:28 PM, Gao Shiyuan wrote:
> The return value of amd_iommu_detect is not used, so remove it and
> is consistent with other iommu detect functions.
> 
> Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>

Thanks for the fix.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


