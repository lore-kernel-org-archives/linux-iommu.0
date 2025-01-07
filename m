Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80D81F03DB
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257619; cv=fail; b=e9muc6AoH+JUzZcy058x5WG7Nj7HEAxgtu34O+FtheZcXGzzYzE4GguTLJwzARemv0UeiwpT7QKN2XPEdvfRdwgP+hHVCeKBzMdY05c2DaUXeXTfBfqwRf7XvQEMEVd2roq4/oOCxRjrPgKJ7xrLiXK++eJSBC5C6PXp6lBNuwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257619; c=relaxed/simple;
	bh=XkgqRjxSfXCbhVdYvhln2pp+gzjlXscdSNgUU7Wvzqk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s+2WKwK8CgSuclxApj6fCAuxZ0SV6A4EFqFq1lX0Tqi6H/IFk1LLZEBnCopNOAmD8c8LK5bNj1IxlPY0ZRDNCc0dQBP3H7wyKz0a0tli9lqt4Z/WlsgbuV76xtn2nItPm0QrlnfJ5KnvOryhsyXFlIkeGctwv0tkge169y36+V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jPJhEYld; arc=fail smtp.client-ip=40.107.96.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jPJhEYld"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmHrosMbeZXIJ77XSL0+66t4DAsqvfBTT/kMkd5fqsBNLD6OoNEU/k//DVrqqHWVW8zvbishFqyx5Fyl89z8mVM97Q1grJs6lHZWiLz6U8yf3szi4ekY2uPi3PwUXF/4S3aLo9taA6OnICitjiA+hip/P2N9eQIHFus0YWcnrmCyFVUmczF4WtD1noFoiTrSt0x/folypt5YMU8fammjVI27PHXkD7ISV4f4o2moEd0YINEy8Mkntfsxn6zENrrvGaQQYbblbH5D5w8rIqyLAkLBqIpNkGrdc8jhB1FGe+LHMDys57RizfMWEFdhE3Q+xfHWOiCfZ1bkLl/Gily+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOjXgiXbCoT5yWMhIxeTEzXrx02vrxCEUzrPGhC7USg=;
 b=VA+deB0jprCoYSTXig0GF6jvNhB5yDEr7/7bwzhfkN77KVC8N9lW+SKjaac/+QV+lw/dcSAyJcc3gtVNTJH5ChCT2aXbv4fP6d6EVINc6XjLrCsS2T+jl4Cs9glxiszDPNuOpWftICYlBOl9GESfegNxVWIU5irZgIZz1JDi14kXMVeLbBD9vhfteiYpGJ9BLr92jZ6qXEHUqMlbH6apMzj4JKphRT3GRT2C37izuqbSZk2APQgREWed2Mt+HSrMcIcZf5lHqpKQZYAjCG5FJ/6y4njRdUVENDliJd9Anl04HJ5QIagrsumzXpcR8rbiiX+SY95tWDI28Z6CoKQpKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOjXgiXbCoT5yWMhIxeTEzXrx02vrxCEUzrPGhC7USg=;
 b=jPJhEYldL9mkGJYz4gHID/0FGzsiY5XlTuqKiXrN+xk4GpOZhYTQKTGScOt6BGPvGvr3+Vv9E/iV1mRMU/Wyb/JuUyC3WC8hHB3FNa+7mLMb6z+n4VqH75mskUjQhMrXtHtZS9MrToNAsGO/COIdqCdAXQMX1n/7ao3h1/3yd/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.18; Tue, 7 Jan 2025 13:46:47 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8335.011; Tue, 7 Jan 2025
 13:46:47 +0000
Message-ID: <4c8fe862-4629-4c1f-9416-d82132e1b996@amd.com>
Date: Tue, 7 Jan 2025 19:16:36 +0530
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF1bdjJd?=
 =?UTF-8?Q?_iommu=3A_move_the_adding_group_info_to_proper_place?=
To: "Li,Rongqing" <lirongqing@baidu.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
References: <20250107033558.41135-1-lirongqing@baidu.com>
 <cafe5714-aeaa-4774-bdad-124e4e036ae7@amd.com>
 <a78452d7e99e49e7af2b6e3a3c312bda@baidu.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <a78452d7e99e49e7af2b6e3a3c312bda@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::22) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6a346a-8b48-4865-fa18-08dd2f21baa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tmovb2w5dGRGVEowTHBWUU9KUGtzbGFEdDZ6Q1M0Y0FtVkMycnB2b29QUUdk?=
 =?utf-8?B?MTJ0Y3FtNGZML1g4TDdmNXRkRUZmU1lvbGhXV3RuUjFKekVPT0xWUFpSM2N1?=
 =?utf-8?B?Q1dxeVhmYmdRZTBlb2ZqNDdIYWhlRXQ0N0FkRlViWVFJbkN2dTYwbFI5RzVm?=
 =?utf-8?B?YjcydUdSVUwzRStmdkp1REdieVZpQ21iREl5R3YrK05CdURhQm45Zllud1dk?=
 =?utf-8?B?SGYxYkNsYmJtbFowSjk4NmplNmlBVVhnWGx5clN1c3VZVEhDUk5SMzl4SDB3?=
 =?utf-8?B?UWwrSlcxS2l2REhUalBmenc4VTNJdWpjdFRIcTF6aFhxcHo3RGE1NnE1cG9s?=
 =?utf-8?B?RGNjOFdQSWVCcU1pRjNYSEtqUVAyeUpXM1VCK2paanZVRkNhR2ZDNmh0RllF?=
 =?utf-8?B?VE1DYzh0dkMzQ3FKcnpyRHVXQ2VjKzQrbGlCb1Z2Ny8zRndYQkRuc2ltVkhR?=
 =?utf-8?B?L1lYK3lCSTJKSHh1V3FhckpPa3VEeGhYT0V4OFgwak9JVnc3S1F6dmY1dzk4?=
 =?utf-8?B?UEd2Z2cxOTRONTJMVFowekV1WnJyOGJvb1h4bnFFM1ZDV1ZqbTNjRXBEOWpP?=
 =?utf-8?B?a1RrbDRvNm05eldWM2M5R3VzcStzM3R1WXBDZy9tbEF2c0JiUmFkN1lwOWtu?=
 =?utf-8?B?OWRTWnBJZ2F5SnRrTWdaRjJkcVpoNXcrK1JwNFhjL0V2SnRUdkpqZUg2cDV4?=
 =?utf-8?B?cE1WNzd5ZzdSajdzUkF6eWFOcEJ5b1YrYXplcVAraGZHMkZDdlhHRWF6cFF1?=
 =?utf-8?B?Q2g2bU94VTdlaWNxVXlPaVk5Z2pYVnVnUjdMQW0wUHdqNDAyRmVZZ01uRDdG?=
 =?utf-8?B?LzdiZ1BUNlVDUHg1OXE1cWFTZVN3aHp6aDBOakVQMHFrUWdUdExpL3FHZnd1?=
 =?utf-8?B?S3ZNQUtIQmFrc3U0UHFnaGpzdWpxeUlDbVhzSmFCd1lPdXF2TW1TVXIvYlFG?=
 =?utf-8?B?Y3BrNDMwRTMya1puS2RXWllNVlZ2RFhWMjVOSnU1UlVKYmkvTnViOE9ieHN2?=
 =?utf-8?B?SXVRU0Zna1FTZThEZkY1bW5hZDZiRXpmU0pFK2kxaXVFd2JWTEtRVE1mamF3?=
 =?utf-8?B?UWZ6VTNJaDRsZHRqRDkrb1dHY1VCbjFEc1dCQ000b3p5M04xMzZLWnRYK29o?=
 =?utf-8?B?QXM3bWxid3VlVEJadm1VUmlBcWd5Q0J2Rkg1Yzlqd2RBOW1LQWovNDQwbWtP?=
 =?utf-8?B?YkUxekU3eVNQZVRmQzRNWVB5dkFTZnBTek1mMUswbnJ4cmxXSjg5dUUxaW5W?=
 =?utf-8?B?dTVuNlBUN2hOOUpCS0ZjNXdmV01hVjJNRE90WkJRajRPKzA3WWhDNUJzd3JS?=
 =?utf-8?B?My9BU2VUM0RwcVVDRUpwWnFzSTJ0SEZMNU1oQUNSKy9WN1BXMm9hYmRvRXRm?=
 =?utf-8?B?cC9ad1pXV3F6Q0xsQTNNMHBGd1JwQ2k1cnNiWUpZeXFraTJhN3VZc3RaM1Jp?=
 =?utf-8?B?U1FhOEtLR1NtV2p2VTlQci85OEZqOVJlVDZMa05YT053Z0dqL1VjNlAvV05o?=
 =?utf-8?B?UFZuRkU3NkRtK3IzVng1SzNMWUJKd296dWZQeTBXbUxqVmc4ZWZ2Q1B3aXhm?=
 =?utf-8?B?VlZERG5GR29iT1pPaG83OXNMSlJKcjNkL0JRUHZ4Y3hTMWx4dm8yeG5CV241?=
 =?utf-8?B?bVNoT0ExZG5kaUE0Wk5lTURqQkMvU09RaXVjaEV3T0pMakVSbS9YNDFUR2hy?=
 =?utf-8?B?WGRuclUwRzE4TWRrV2M0eWtUc2loamNMQ1cwRUVETEoxOWoySGRVT2k0V04x?=
 =?utf-8?B?SUxib2NlWGpvNEZvdzg2STVxQ0RMREgyeWJqWEgrVWxZcHpidmRkMlJuYWg5?=
 =?utf-8?B?R1hyT2xPNm0xSmlzcUFwSG1va1pRYmU2dzFKdktPR0ZldlpTcWtBMWZJYmlo?=
 =?utf-8?Q?CCop0IEyw0tx3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3MxRUtXUGU2emxPcnRmcjM4NWVOL2NselhhNkpjWVBONXlnMVVWMzIvRGJO?=
 =?utf-8?B?dzNWRW0yc3JXRXliYmgrbFRWWEFPdkZScGRrVjVNOGF5MGVCTm40eE5NTjM0?=
 =?utf-8?B?M25WMGVHcGM1ZC9VdnZQSko3U2dFTVJMdldxVWZsRFd6elRFM0RNUTYycjVt?=
 =?utf-8?B?cnBiM2t2ay9pRUQ1MlZ4em44bFFJR0ZydTNXSVI2eW43K2RuZEd4QzFrWEJz?=
 =?utf-8?B?d2ZxK1Z1V0pMeVVISXRqR3F5M3JRS3F4bGhDWnpJSkFOV3NQM21GTlZVL2w2?=
 =?utf-8?B?b3ozTWRaR0NsYnFUbVA2cnVpRUQzZ3BSbjYySk5FQnFmcU84eVd6S0RhV3lL?=
 =?utf-8?B?UkJkTmgxWER6NDBYM05sekdUd2M5TmkzVysxd2NTL2ZJbkFRQnU2NmJ0dEtt?=
 =?utf-8?B?M1U3WEluMkxSNTVrVzQxS0xWd1BYTWRucnJiVm5hdTQ2NFJWc202R2hQcXlx?=
 =?utf-8?B?ajBtS3Q3UzhkS2plQ3cyOUtkUFl1L0NMUHRxQTBaVGl5S01iSHFJZDVicGJY?=
 =?utf-8?B?d2NIWGxPdUJybDFzTDFxOWRsU0oyZzlHN3l6SVZhbXNHVWt1djRiUWwzUHh4?=
 =?utf-8?B?SGlmcmZaM2loSk5QWDhzalFCam1vS2lYLzI3S3hRWXJpWFY3WitHMWFjdGhL?=
 =?utf-8?B?bEhVdzBhemx4cFl2NU94UWQ5NVFOaVAwU0VLUFYrVlB1UDVUd0RWdTlkN0lq?=
 =?utf-8?B?d0tzZWxja2YvK3BMT2p2ZS9yU1pvZjZQTGhJTjV0SDZLVGd1QjlJT0lrRzBm?=
 =?utf-8?B?MWNqVndhR2NZUXZudmVqeExNQkFlQzNTQkJiV1JNSElIMCtRWFpWQktCUGZB?=
 =?utf-8?B?Y0RDeExHT1c0cUx2UWYxYzR1MUdSY0RzSG9BV1YyWlpUOEx2VGtzbEs2Yyt6?=
 =?utf-8?B?dlRIVjJoRTdZQzB3Z0k1aStjL2lyL3RXd0ZSTkVFVjNBdnRKTEU5dDMweE5r?=
 =?utf-8?B?eERFczhOS3NvU1F0ckNiYU1wQTV6dllYdlk4Q2dNckV0ek41V2FiSnVhZmhL?=
 =?utf-8?B?L3NiRlNmQngrMklRMzgxQTJrdWhpek92NW4rNldMY0pwb0VIbjFLbkZJNmdP?=
 =?utf-8?B?UWtETlpnNm84Mk5TTy94amlIT2dXSmVidHBnbyswTE9FSDViK0JQR3BLMGVX?=
 =?utf-8?B?NXM5TFBFUUpWaGJBVk5kbW03WnBMOEN4YlE1NXU3QWRCNmxUZ3VzNzQ1TkQ3?=
 =?utf-8?B?RVptcXVwbkk1Smw1dEVYNGhpWk5zbmFtbGtWUTRKOHU1eUxGNjg3V1hPQ0Va?=
 =?utf-8?B?N2FzWm4rRVdQdlA0VmFpUmdnUm1DVjNwZlVRazd2ZzN6NDc4RlNSeUp0eFBT?=
 =?utf-8?B?QTRNZW0rUEZ5YkJKbVd6WFdZWDdUTlJ1ZGpGUTRHOFFEbVhvaFRvMy9FZHNo?=
 =?utf-8?B?cFBUR1NLZkZ1WkJ5WEhsRkRhb2dWdXhhV2pqVkc3TnJYSjlmcDI3OWZSMldp?=
 =?utf-8?B?TmNCbk5pQWlJOVRNZHZXK3JxT3dxdW5SdGpWSjVpM3ZCOXV4RjBqTlpOZTU2?=
 =?utf-8?B?MkZ2RlNxREw2dHlnUHBRVUNqQXRMZHVBVnpleDlLMmphVEFXcDV5U2xHYXRL?=
 =?utf-8?B?R2xORHFzQWhmbzdYS3JvbXV6c2d6NXI2eWlPV2VxMHJ1L21lOThBMkxLanNs?=
 =?utf-8?B?OFowc0h2cnBEOFhHRUZWWTROS0NKd2gvdlVuVUhBV1FyUG90cW81TkwxczUx?=
 =?utf-8?B?L3J4Vk42SDVFTXd5WmVHTFd0bGtPcmNIVVBCaW9RZVAyeGlHcGt6NUlMY1lq?=
 =?utf-8?B?dHEzYUM5N2F4eGdEcUxPZkpRQWRFMU1NOU5ONTRxS3kyNWdXelp2VzQ2djdD?=
 =?utf-8?B?ak9hbzBDc29xSFVtcHpBM1VFYmk3SVhqZmFpSWdrQ1RpNFF6RGhZVTc2MGZW?=
 =?utf-8?B?NGVHaGFUOFlWK1RScWdZb0RRYnZuWmxzNFNycUtHVDFCaWI2Z2IxZTRSTkR1?=
 =?utf-8?B?WkdOc2lBU3NZWXhjMnFJZFRKbUhPcXRscGNCR3VJcW9ZRmJlWjJPYXJwSUpS?=
 =?utf-8?B?cHliYTRBNGJvenhRMFc3eDNtQXBJcUZKYzZ4ekF3cWxjdHJRb2VEWEhoSUhi?=
 =?utf-8?B?d2VaNEtqZHFLQkdTUk9IUGh4VkFGODVKdlY4SS9vSFlMTlRpYzc5Q1NRUUFp?=
 =?utf-8?Q?86Qw05/aaUog5gDIt61uTs+4a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6a346a-8b48-4865-fa18-08dd2f21baa5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 13:46:47.1792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: af0VTuwzDgWtnlcp8k227YUhF+dpR1vBLoDQd8o5uyqQscHH+nSk/dqEMn7j38D9r7poNP743P3wajNW/Tg9qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461

Hi Li,


On 1/7/2025 6:00 PM, Li,Rongqing wrote:
>>> -	if (IS_ERR(gdev))
>>> -		return PTR_ERR(gdev);
>>> +	if (IS_ERR(gdev)) {
>>> +		ret = PTR_ERR(gdev);
>>> +		dev_err(dev, "Failed to add to iommu group %d: %d\n", group->id,
>> ret);
>>> +		return ret;
>>
>> Why not just return PTR_ERR(gdev)?
>>
> 
> Since dev_err will print PTR_ERR(gdev), so I define a local variable to conversion once

Ok. Thanks

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

