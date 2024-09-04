Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C9E1E1322
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469453; cv=fail; b=gBHS806QBoA6XFvL6yVGIKoZp/AA469kfWUDeeOYthMPTsOV0EoUvTNFbTc98v+0XYhPHoCJdgXI17ruQG1sYT5kL2etSbTb+l3SB1wJzzcvkxd+NxqcKGYlpz9J/nvt965wJHXQvU4vQcSJVQ0xh/sRPSNuL9E7CtuhUnL4niQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469453; c=relaxed/simple;
	bh=8aYF51SV5mVWOHtcA6l9LsvU3XvwD/136kaYC82z5fE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V9Nh76sjQ1wrT/3Y66yAvRCklcR80jmUltoP+0BvLtbK86WD6S9lNG8rpihF/rdTnEbI8j7I2G0PTvIF1UEctuNNsX694ptI7C7+Q+L4NnCeqNXZ7njkqfUX7nDN8wdYncUCSEj0svws+QCxIIme0i0TG5sqhTZP8a8VxAOtvSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SHQgIU/C; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SHQgIU/C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9BKK0cY8/zaxS+X3soJ6ReRNyAYXfZB/n7skfgnseXerNDZWAW6M1XOvnsb1E891Rk8aQkQDuc7VHPGv2XD0M62G+TXg605Vgp26C+3QamitTALkkY6z91FtpQF1xsQqYpGU6K3Q8On4OyDXqesKyx9BjPh0qQryV6ztCvemR3DeEGpVwtoYsItubt7pZ8UTjzlvkOZgDTVlqzgHpXS+r+k3td1AK6VxSvZ6hcS1hTL/hdLDb8SvF8mnonPZu1B9eUnGSKEml7FbiLcQg8bsBUfSAqwUoSbnWgoleU2GkFq/q5OUBr0/ILbQLCNag7fij8uNfTNdDFJujtI704vaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JADTROH4LtkNt0BV7xUYjDy/PWR3iz548DX0Z+QgCx4=;
 b=sNL1fDj4kuvZse75AysiFCDrG4Ib63QL4SI9zkHC3DQEDSurbx2DMLweMwYslhJFPhq0JoTjD4KxSRwgQAF1KWinZq1sPB0ni1fdGG2Q6lrgsP64Om3YT2ShavWMtrgK3zRzCi9ZBKH4IMMF23VgnO//z6mg5IjXNX1OHYnZP+8khtKyweVXx2po2PItvGfric1tOvppi5dsgxDf48DgwRUVx0sDDHQati9oHqF/VVeTbct8dHSAyNAbMBGxxFqtUUILGWcMjJLfhkBISPJ6FuSjHhGqt9JZG/A6bXFS0JWjiyWy/W26TE0KbAu/xIlTB794oOScUHSC9u+iNInvAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JADTROH4LtkNt0BV7xUYjDy/PWR3iz548DX0Z+QgCx4=;
 b=SHQgIU/C2ZL3dEeXcD1ryMlh7Juf55TmC2wNAMNalnXmfPcGoSFZmxcRMpE1/ma/+K0/YPc3qurcgrN8gFYPdtVgp2TyVYCT/hlFtqg02DxKaNMayhns+YRtkhtNvdaTVCpZI4U/lEVAFznLMjkHDbgecrMmVvSIufurHEhVndU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Wed, 4 Sep 2024 17:04:09 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 17:04:09 +0000
Message-ID: <5b6131cc-cc9f-4dd8-a2be-696e1b4e574a@amd.com>
Date: Wed, 4 Sep 2024 22:34:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] iommu/amd: Remove conditions from domain free
 paths
To: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20240904165537.GP3915968@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240904165537.GP3915968@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::26) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: fa18ba63-f2e9-45b9-c625-08dccd039799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emhmUHRlYlliYks4bk5GUTNFYitubVdYTExncmYxdUFXS1FNc1l4bS8yUkpv?=
 =?utf-8?B?cEQwQTI2UUdWaDVNMnltTDJrNTFuOFgyWXRYSVg4aEs0clQvMUhUWnVIc2lR?=
 =?utf-8?B?K0ZodkRITksvMjRGT0xMQmFteTRnM3RwSEw2ZGRmekw4YWdLUTFtbkIvcjNW?=
 =?utf-8?B?RWFsa0lKSVZJMExXbjd3dWpHQnhyOEZ1cXFZcVlyeThFUXNORE0yZHlPaTIv?=
 =?utf-8?B?dzVYM21LOGdGODJyL0QxSEZyOElXMTFObDNqSFY1amgxNEkyUDhpMWlrQlN1?=
 =?utf-8?B?amo3TTVNQXNDQnBIbHBkc2xyNGJoOGszWU41TkN5QUlnS1JLN2Y4bC9YWFZP?=
 =?utf-8?B?aEphTGJ4dDRibExXYW91aHJ5M2FtbUhCZWxTMkMwQmFreUVFNlovakF2ZHhM?=
 =?utf-8?B?MGF3R0IwT3NMZHVMNmFaTjdvUU9jUUJMbHA2LzZGKzVJVElVbEprQmdJeVZL?=
 =?utf-8?B?YWxQR0gyMWt1anhvejVUQ3ZtUW55LzZCZFZ5OXZJd2JmaEcyWEZNby95d2xK?=
 =?utf-8?B?S0IwRG5FbUlrdTkrUm15dGlDMUZqSE1xa2xJbXlFN1RDdGNUZTE0Z1pyem9U?=
 =?utf-8?B?ZUVIUkhYbDdxTUtOeVlPcHVvSlczbTVDUnV1bnJtbS9TM1N6YjM3N0ZNdnZM?=
 =?utf-8?B?OGhNT2xyamYzc0s0U0lZSHlLZkZwZXdyWW1ESW9JYUlodFlic1BtOXJmU0hX?=
 =?utf-8?B?RU4yVnlZL0lEdlQyVlhEdklGYVR0RnZxSDNQUjZRTTkweTI3NTJLeFpqRXd3?=
 =?utf-8?B?bGt2MDI4MFFoenlYUmhWMUdKN0IrRE1pNGVBMGllRXBGa3JOeGZQSE5Udi90?=
 =?utf-8?B?WGVRRWc0dkRFMGh1Snp5YlZIeEd6TnNTUW1YQ0EzRHBLeUtwTmpZMnNjNnRT?=
 =?utf-8?B?Q1JJZWtoMG5pK3E1RDJnQitDSTBxQ1YzN2xQZVpPWkVMc3dNZjZSR1BpVUtZ?=
 =?utf-8?B?V0ZTc254eUpNL2JhWG5leUFqd3U2QkxCU05JQUFQcHlqK2ZlTXlXUHZaK3FI?=
 =?utf-8?B?OFgvUTlVRnQxYVVHVW9ya3BrZ1dPUTlMdEMzWlp6UStMT0ViMSs4SnJDVDgy?=
 =?utf-8?B?N055Tm94TFgrRlZmbUtmMVVCT2d4L0ppaHBzVzRDUFp6QVFFODEwbVFDdnBH?=
 =?utf-8?B?Vk4wdnJhcEkvdGdFUWpyK1lUUnhQTlpHWmREVGZQS1RJZG5hbEVlNlNWejF2?=
 =?utf-8?B?eFRJTm44M1AyaURMaVd4cGhweVhjcit1Vnp6OUpxQURvVURpdUZ4OVdQTUE2?=
 =?utf-8?B?eElxZi9WbmRZWDk4OEJ6aUtSZVZJa3RxbjRYdWdaUnV5SXBMcC84STFMbCtW?=
 =?utf-8?B?SDVyRDcxRkowd3Q1ckdCK1FUZXdrSVc4c1dyajh2eXg5TVlLRExHL3RXU0wz?=
 =?utf-8?B?ZEVWUy9sbkdwSFBpeExlK0hGQnBZZy9oaTloOGNxSGlicUpSWWl1ZjZobDBW?=
 =?utf-8?B?Vi8wMlpHc09yY29KOElhUEJrOHJ4ckhLcHdHeUVYczJtRGI2amY3YndzODZr?=
 =?utf-8?B?S3RIVEJaaVhFOWY2WC92WDRLQ1R1MkZwVTE0cGd3OEZ6U0VPRlBpcjJUQmpX?=
 =?utf-8?B?MkQyOVZYMEtIajZmbTV6eCtoQm1KKzBUL0dCa3BwY3lpZVdTd2tiMjFxTVNl?=
 =?utf-8?B?N2pGTnl6bS9KU3hJQWhpUDlMWTJNKzd1K0xXckg5dlVqUFBkN3MxMTVOckxU?=
 =?utf-8?B?bjU3WU5HaFR0TnQvWVpwYk1TL3JjRmxoUi9HRlpSTUVBMmtsSEN4RWNEb0FK?=
 =?utf-8?B?SWs4cVVDemJwMnB6WUllcmRpblUyTXFJcFBxRmRSa3I2cytxaGdyd0cyOEly?=
 =?utf-8?B?b2c5N0pVYnFXL2R5dnJuZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tk8rcVpEZWJxenNMNVR3TFZYc25KV25KS0IzVXVvQTdscUw1a2hVMjA5U1FO?=
 =?utf-8?B?ZDRrWWZSeFc5K1NRTGpLSms0YzE3VkJVbkZSTTdCYUNETlliQmg0dlVPYW40?=
 =?utf-8?B?T3ArbXg0V2NDaG1wK1ZRV0dWeWIwWmd2Q0J4dlJlZW14ZHJaWkZCc0Yvbk9t?=
 =?utf-8?B?eERaemdUZDFxcGtaY3pJQ08vUzhmQkdMSDBHQkVCWUd6d0twZ1RiZXcxSm1p?=
 =?utf-8?B?Yzg4UENFT3k5OW9IbUNFTzdYQ2dlZWYxNGsxZC84My9STHg0MXVPUDNoM0JT?=
 =?utf-8?B?UWphSUpGRHYwOTYvV0lIeVovVUtzdkczTGZRRVR6V2FtamNZRUllTnNnMHlY?=
 =?utf-8?B?bGtXVEJPaG80ZWhVRXg4TDc4ZjZoLzRkTHJWODZVSlFGVm5UZFI2bXVwNDZ2?=
 =?utf-8?B?MWN2UHFma3F5V2lEdHhKT2sxSHdyM3lMak9TU1BDUFU4VEY1WFJFKzBkS0JF?=
 =?utf-8?B?a2FKbzVpNEV6UDZ1MDRqbDI4eVprVVliSDJCVEhKTlB1ZEltN2xldGxwRWw4?=
 =?utf-8?B?aXZkZU5ZNFg2RUYwQ3FqaVhhaUk1YWQ0NDY3SFVNVmtMMEVOYU9pVEpWZHIr?=
 =?utf-8?B?YisvUlAyK0xZMGR2VytnMGZsNThXMm52SEpFQko5VVpVU0F4c3J4ZTROYTBI?=
 =?utf-8?B?TGN3cTVQaS91STQ2dk1QdVJncXZkd3RYeDRpZS95ZE9RNFFhcXFyZUU3eXRB?=
 =?utf-8?B?VDRKdjI1a3JldUZEcHlJV3JVb1YwOHNCVGlCZVVPL0tQdDY3cnVBMHMwWTNk?=
 =?utf-8?B?ZVhkbllNdzFaN2tMb1dpZFZaNUNUUmxYRmxUbHFOd3AzdXhBN1hNN2UzNk0y?=
 =?utf-8?B?OHdsTDl2L0xrNFlhR3NTQ3p0V3h2UndMT0o1QXN1SjBhb09QME53WlprZ2hv?=
 =?utf-8?B?VWwxZjdNaXlpdmZxVmYxM01kemwwcG5Jbmp4ZGlIMmY5UURaRFljVmhaSzRI?=
 =?utf-8?B?WlVaeWpNVjQwbUpKTHd1dVhuTzR0Qm9QakdGWUxpTjFKNlFLMVlqWEhiNGZ0?=
 =?utf-8?B?Q1BwRVpSTDdQL1FIZzFadTFRbzBRRUdUM2NvcTN6QVJ4alovUlhBVnZHRmh2?=
 =?utf-8?B?bm1aMXd3bURqdFEwZEtFWm9yODdjVHBadjJIR2lFNUlpVGJ3UE9pRDdZOE5C?=
 =?utf-8?B?OXZqSFdOMFpuNG1mTDFrVzJmRkZDb0tMUm1VWFA2MDJFMXVEbXhNSFA5dXpw?=
 =?utf-8?B?NEJVUlJrYjhhY2JHQXlLUjFDY2tkd2FUTDlBUWtZM24xL2QxNVlPQUt5d1RX?=
 =?utf-8?B?YXcrUmhSWkpFb0ExRE5UbkxGaGhyakdtUVlvVXRLUEgrV0RXbXlTcTJwYVcz?=
 =?utf-8?B?U2EzeThwaHhMaUh5U2RyU1duWkNseDVIWTgzVHdYbEhWSzBWU0N3ZzNRNmtZ?=
 =?utf-8?B?UDYxbmJacS9Pdkw1emJDQXhzei9wYmlObWYxRFdlSUFNUkw3eTAyR09icjJR?=
 =?utf-8?B?eUx5NTRoRkR1eGdKbXdiRDlnNUtzYVJGUm81MU5GYjQ1MlBIOERqaUZyTmJa?=
 =?utf-8?B?Uzd5RktRUWgyUGRtb0k3dzFIOXQ4NkhSRUcvRUVkUWlIMmMvQXZma3FxRjdo?=
 =?utf-8?B?MVBlRlp2a3FRcHNZeGh6ZEpPTmsyNmp0dU8zcC9lSE9ZSjFLSFNXbWxRemhK?=
 =?utf-8?B?a0ZhUS9tQng4VXBGYnBIY2EyeHdvdWxqcWZXYS9IY0Nva2U3WHJtYmRrM0Jw?=
 =?utf-8?B?Q3BDOTNrNVppZjNHbEl0RHpHZFNQUHhkQStIck5FaGJpMTB1a05Db2Q1SHNt?=
 =?utf-8?B?c2RZRUV6LzhEN0tIS1QrKzBsWnJrWWFCNGgxVDRDZlpaZ1g1TUtYR2d0ZVhq?=
 =?utf-8?B?UTFRY25WME1XUWgyMnVTdUhML3ZVclE3d2xad2Z5UmJYWnVpRkJBSWMxK2Rl?=
 =?utf-8?B?Sms5bS9qaytPRGIyNElkUElSTGdab0d1SmtSZkV3Vjl2bVJxSENJbzVwZzlr?=
 =?utf-8?B?cEcraVFXWnFqQnd1azlxYWRpUEFLSk9wQ016VXVXZ2ZIVDZOS2U0MEtWUCs1?=
 =?utf-8?B?Sy9OVlRXNDRRM08rWTdoMEt6cTlqU3B4Zzk5bmhRNTVNdWRZWGwxSTJ6ZnVN?=
 =?utf-8?B?T29FSHBOQ1FKM3R2Mjhhdk84Sis5bmVQcFR6VlYvbnc4eGt5dGtvRUx4eElF?=
 =?utf-8?Q?xFFIjD2MAWfU6VZNw26NVgyvK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa18ba63-f2e9-45b9-c625-08dccd039799
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 17:04:09.5076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zfr5qHZZsxtAPIlnd7JQltz4v9WLnh14/AqF9UOUVbuytrDVllOjLNG+vq1a4efKJ+13qrvqPlEPHJkUIRbB1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978

Jason,


On 9/4/2024 10:25 PM, Jason Gunthorpe wrote:
> On Mon, Sep 02, 2024 at 05:33:50PM +0530, Vasant Hegde wrote:
>>>  void protection_domain_free(struct protection_domain *domain)
>>>  {
>>> -	if (!domain)
>>> -		return;
>>> -
>>>  	WARN_ON(!list_empty(&domain->dev_list));
>>> -
>>> -	if (domain->iop.pgtbl.cfg.tlb)
>>> -		free_io_pgtable_ops(&domain->iop.pgtbl.ops);
>>> -
>>> -	if (domain->id)
>>> -		domain_id_free(domain->id);
>>> -
>>> +	free_io_pgtable_ops(&domain->iop.pgtbl.ops);
>>
>> This is common path gets for all domain type including passthrough, SVA.
>> Hence its not yet ready for unconditional call.
> 
> Oh, I see, and ops isn't a pointer so it doesn't become NULL like
> other drivers..
> 
>> This is causing NULL pointer dereference when I try to change domain
>> type.
> 
> Yes
> 
>> For now, can you keep abvoe check -OR- add PAGING_DOMAIN check? I will revisit
>> after implementing global static identity domain and fixing SVA code.
> 
> tlb is always NULL now that is why I had to do this.
> 
> @@ -2259,7 +2259,8 @@ static void cleanup_domain(struct protection_domain *domain)
>  void protection_domain_free(struct protection_domain *domain)
>  {
>         WARN_ON(!list_empty(&domain->dev_list));
> -       free_io_pgtable_ops(&domain->iop.pgtbl.ops);
> +       if (domain->domain.type & __IOMMU_DOMAIN_PAGING)
> +               free_io_pgtable_ops(&domain->iop.pgtbl.ops);
>         domain_id_free(domain->id);
>         kfree(domain);
>  }
> 
> Is that OK?

I have exact fix locally! It work fine.

-Vasant

> 
> Joerg can you squish it?
> 
> Jason
