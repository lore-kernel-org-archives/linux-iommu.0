Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C634C18635;
	Wed, 24 Jan 2024 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091347; cv=fail; b=WU0H6xG5UBZKDEYoiVlzE1LyQ4m1asIYDRy78V/fdXEFTNwSKX1XuLHK+BKvU7AkFUfziGH2MhxxV4XAwebqqqmXLfCv0ygfaLXKv8fwdbFtRkjjgc1542S+RbAio6/t3udbKqfmdaoMneCI4wB81aMHtFIVuJ2g/7IHLTe8yK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091347; c=relaxed/simple;
	bh=gioK1tbdlEvL155trq0cM7cL8vTOYqIEaJYq6RtOujw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oCbgEBAweZlR23FlxABsG3eyAndnC8eXAy1L7Pb+8yNmb5/Cd09NQUpyasuOykaNVS/Pr8c15Lschpp2zT7B29wE/mHy6tt1SiIgd3/JnM5Xl/BxAkRx/VlNVdcs6QMZxfq/CIq2pDC6KNsjg8hsvXAYFKSC1tnjbilWwvku9Rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mGgs1QEV; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mGgs1QEV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0N4dEhGHBYU1LN2lEvWp0R5wD6+l3Rm4nRUoO7ljEnQvP+CLLW0oLtiWOPJCsYISDq/Vaz91ndw0oqWNstzNxUs3KNNJN/uaYjMidecRjYMumSrUXNTwFe0eQCVlGOrIwCu4m9QPUtLo//Z59CpyBcD2VzjR/B7hyA/xLOMfaN7Us7m/xNnOqX5p/2XBlefYujQzAw5IWdArHbY59s/Q+K7NeaYvWK/84+hozMC2xLKbQOUAJZF5RQdi9moQAHRDG2asQpkl+Zm297QANBR73TlyGvSTVlHVcf/6CnhtTp6FspF809BjSVmGVnCmkdpdtLRprDrqaszQS8d2Ga0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynv7fuSd/bcAIn7CpVQW1QzB0Lq5vySLNjstecK0iWA=;
 b=JIjbV82jOeASc1NJX3Zia+EqJZaAw6Kc0pJj+oZq1CzZB4IEkly8E21dXWlyOKQdPBIdjOKeJJ+Gw3oC2Drg9sKYVrSr0Jab3HMkDYwuPKsMtEnpTq+j1ci+8s1mMbE7g/nweckWnP9y32bF04d+OX9ikbAuAEY/LYRdV4kcxPwp54WqeFTtXEMRhCTUiq8otf9RCVYuvZI3+Lg2yJ17wI+UuWQoC0H3sTRlDMYw63SYly6797xjl37dLUt2g3GrTxti6IhlbFizq9qj9YuTxzO5kuWxQ/S2UGywHydGE73CMf6cJHelQhL3MSronGI4KaHa+q9IlGzw+XmgvrCXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynv7fuSd/bcAIn7CpVQW1QzB0Lq5vySLNjstecK0iWA=;
 b=mGgs1QEVs8LhMLvBNJJFuQ5jwzEdaG7AddnywgxdsgS+MbGiRHHxEi5kqiBr26Rc1f9O2d5my/lEhxKyH1D3gUJbV3oi9398Wc2o1GPdFYfXZ1WIU7eZWGoGlysp+eR5YPh7FPhG+heJ9Z3BMGX69cBvNR5vV8OWXD49xOShAe3ayzu1s5YVpAJctpCHwhQvC5nqWC4dlh2vMM1o7ZEWlnh9weCEojO+ochRH5KP9Ki15uRhcd/fTFGw8iU0e5ns9FDMPs6Lj3zxa7yPM+INaCX/l21RM/ZkdvVhMXbTBYTAj1PHxSzkZ7uD7H/EoV9fw1HMVtQGeKhjrMNi698lww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 10:15:41 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe%3]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 10:15:41 +0000
Message-ID: <b0334c5e-3a6c-4b58-b525-e72bed8899b3@nvidia.com>
Date: Wed, 24 Jan 2024 10:15:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Failed buffer allocation in Tegra fbdev
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, baolu.lu@linux.intel.com,
 jsnitsel@redhat.com, jroedel@suse.de, linux-tegra@vger.kernel.org,
 iommu@lists.linux.dev, regressions@lists.linux.dev
References: <bbmhcoghrprmbdibnjum6lefix2eoquxrde7wyqeulm4xabmlm@b6jy32saugqh>
 <20240123151508.GR50608@ziepe.ca>
 <1754c86c-704e-4c80-93c3-1b75a9a247df@tecnico.ulisboa.pt>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <1754c86c-704e-4c80-93c3-1b75a9a247df@tecnico.ulisboa.pt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0520.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::16) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|PH7PR12MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: c22cf065-a5ee-4dfe-c08f-08dc1cc56b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2NL6iwkgTpnzX8SfzC3+BOUlhdLo7aZA1OeHwg9y2DHLI6jPqn//BT02ft/A3fAbRxs4Dxnx5AR1jWn7bhFZuRqi3ow2vCB9fE5OlY79T49rwybQCBgVBL867WDPNbdVgsMl2F+uOe5ctgLlaePgWlRlqFnxzEDE/TDga+WC3xzNyqtXkJs7wKu7AfBUl0pXvhSoDXjrLDXK5xg0ZzXOVfz6FmVKdTqDoNWTmTozfSQhusEQAxW+f3Att6XXkN36ivfj13B7fG6wCIEbdYXtPQCfZCUvbx/FZVAk1bDFOVWIxUr+dSyDb1onKf5HCxmlLY36iikDWXI5YxBtZjzq8NGGdgNAg9ACoNX+zJaOl7z8jIROpUuZEYUTova5HXuCa1AL/aDWLrQ4B7V5qb9r84sMzY0KkMQi9GNOQ58RuIDpQIzLj0wRfE0T9F0svfuzV+9Qj6MvtnvkSyWTQZi7Ohz4CSXCfEuJLjpdanS1TQpfiethUxy23M9MwYJdQK8VWNxHPvfjgli1N9hQbaudOB/8Ze9wc5Xq04Q2aqG7tS4irEc6jc4t0UCRpaS/cOwGhL4PohR/TkMwWhMwr3ELh0psLOoPLYun+B9yoxwminawZqwLeHDXNchhtOaWVGiDhq7hxJYEKhD4i0UtPFPmVktHvz6GkFXyguPIFvpX2ou0hdI2GzoN+dk4z0OGo0zT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(38100700002)(36756003)(41300700001)(86362001)(31696002)(8676002)(8936002)(4326008)(31686004)(6486002)(6666004)(83380400001)(6512007)(66476007)(53546011)(110136005)(2616005)(7416002)(6506007)(66946007)(66556008)(5660300002)(316002)(478600001)(45980500001)(43740500002)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3A0VnVCWTNMcGpmRmdHR0lnRjRXUG9LWDROTy9nQnRKM0w2YTJJQnpyZTVQ?=
 =?utf-8?B?TjZ2TDZMZG5NSzkzR2VheVJRWW1laGRQWTdUeEluREpBMGhkeEtsNC80V1po?=
 =?utf-8?B?bFl4aTZ5UWlKYUs0aEdOZkV4Y3NIbVA1U05lN0hzdnhnSEZpZGphditJZFNS?=
 =?utf-8?B?WmpwOVVBcE5ibjRXbmMraUZhWVdtWW0wU29uZ1FLaW1mWnJCdklkeFU2ZEsx?=
 =?utf-8?B?dHpFSURQbUladWc5alpTR1lqRS95NDBEQ2Y3d3pyRllOWG5xeU5VS1pWS3FD?=
 =?utf-8?B?Z0lFaEo3dVhZejdFdDV1ZGcrTENKN3Ztd0d1Z2FCZGRSdEpkNlgzK2VzU3Rp?=
 =?utf-8?B?bk8yNU40NDU0QXRDeU5jSFNDYXRwNnJ5ZDlBZ2hxdFQ2bklVNlcvaFd0ZU5h?=
 =?utf-8?B?RDVCZzlNTlIvZk1qRWhGb0VjUFU5QTNCR2tVNjdqeXpKTXhHYXJTUXZ1NUlS?=
 =?utf-8?B?YTVDbjJIeHk5UStJdUNtbCtnOW9NOUQycFpQcnE0eks1TmJGZlB6aThaMFI0?=
 =?utf-8?B?RkV2Rk95RkhMTDRWT3lIelgyU1FKVmJqK2J2MFI4MHk2azZsa0pZQjNvZTFn?=
 =?utf-8?B?ZktlU1NoanYySTE3L09ISytVT1Z1bUU5K3VJaXBxeGdKSGRBbWw4bGZRMGFP?=
 =?utf-8?B?WjVmSTlpL2RjYU9GakZ2S0pUaWp5NkpFTEpFcWE4WCs0OTBxOXU3WUJNVitN?=
 =?utf-8?B?R0toeFYzQ3QrVEt6bFF3YlVmb0pzYXdrMEgyZWxlNUd4MVJETlVCNVlRbFFF?=
 =?utf-8?B?WXlqTGRZVmZKa0pQcmEwRUtQb2VCSXdzbzk4RFArV2UzR0F4bTJ4blBaUHY1?=
 =?utf-8?B?S3VjUTFKbWZyakpFdENHOGdKUzRrQXc4M0N4dVlGOUZVZFFVUG53NWJ2bEh0?=
 =?utf-8?B?SzJOWFRpMzJKb2FiMnpPMldJNk9RR1pGNEpUSm1pVm1peEZEV1pXN0pielNq?=
 =?utf-8?B?azVxenZ1WVdoazR4b2w1YjZWVTZCcHdlcUZydGQ4MEIvRnNBTjQ2VFVVZy9M?=
 =?utf-8?B?RmJOd2lrQlRRenNJRmdPUTdreG1MTHhhdmdabTB4QWVsR0JacTJaOTlaS012?=
 =?utf-8?B?aG5TSGx0Zm5yaEV4UGVvVTdtZ3RNeEN4dVZ0TksybmplTnZwdTZKWHY1QjFq?=
 =?utf-8?B?WDZQYmJka2psUEdNYjFpQng0bHpPUlpFTWUvSVQwYXFXVjVseUx2Z1cyUTNJ?=
 =?utf-8?B?ZFJFM3pmcm8rcXVCaXEwcy90ZVI4Ky92QTBvT1Qva2pVL1ZLd3IyWnZjdjFs?=
 =?utf-8?B?L1RsK3RJTFNycmRwNEhCMTE4ZG56M0YxUlZwL1FhTGZTZXdwZklXZ0hxeC9P?=
 =?utf-8?B?NkFOWVpnbDBzbWJxaHlJdUZLN0JXVVdET1d1WWRWNkl3ZnlYTmg0RFVPUTJn?=
 =?utf-8?B?amNPRXc3VjR4aGU3RThiUStMU0FLRXFDM0p0cmtYcnh4YlBiUGVPTWRjR2ho?=
 =?utf-8?B?UzB4VWsxMUxla0xKMThVZDhMNklsa0hYZmE5cU4waG00SGlaSFRaZ0lWK3Y3?=
 =?utf-8?B?Z3FjSXBvV3FZSkFOd0Nxa2h1NitSTWVZU2F5cXcxdXorWGY1cDJVSHZjOFZl?=
 =?utf-8?B?cWhlZC9zc2J4NmJDV1h0dHJDODZ3SkdyUXZzWkxZM3M5dnNHallncjBsR3ov?=
 =?utf-8?B?THVua3N4OEphZUY3azdRT3h6WW1VQTNOamtuejhkUWFONEtzLzNuNHBpTDVa?=
 =?utf-8?B?N1dFMzBXZkJuZXoreGd6c2s5TVhBU05lVmdqZzdXcFZ6Mnl6dmVqTDZWZUtq?=
 =?utf-8?B?d3dpWC9jcFkrUzJjOExDN01IZUo5T1h3SENoMGZwWjlieUdZVzhRbDlYT1pR?=
 =?utf-8?B?VXhSWmRERTNZMjVvZkkxU0c3QjVwbmw1a1dIbnZBaG81QTVobGlQTjNlWm5R?=
 =?utf-8?B?NzdlY0tDTHVScE5FUEdDd0NSck80QjdwU1hCaTBTWitZZmlZN1F1ejFVRFha?=
 =?utf-8?B?OERjdkVKMlVYb1Z1MnZWWDByeVZWa3FDSmVLaHhxMjlWd3U1Rlg0bnN1UVNT?=
 =?utf-8?B?RGZMZEpPWFBDaG14NjhGUzR1UUpNcEd6TDZuWjVwVUhPdEVIclRtcXJ0d2tK?=
 =?utf-8?B?UlBlWHRLY0NtanZQNnVGTzFvaXBjdjR2UTlSajdGbjRlNnhLSm1vQ3B4UVQy?=
 =?utf-8?B?aVBjUzlCWGpOZFRvVytVaDVXaHBnaXRocEhkVFc5dk5rRXBNZWhlTnVQZ3py?=
 =?utf-8?B?dGNjd01KS3hmaWxDZHBuMGRJZlcyamxxVytVUjF3clBiTVgvaXhQSFZSaFpx?=
 =?utf-8?B?UWpQZitPSUxIb0cxWG9zdEc5d0xRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22cf065-a5ee-4dfe-c08f-08dc1cc56b00
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 10:15:41.1408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+VHg2F4FPA1hlVWSSl4ebuduisPxTZO6f5LNZUk0Edx4HUvL9LmH+hR4iRVKWcaZGxwiuZTKZjv59lLO9r9sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162


On 23/01/2024 18:44, Diogo Ivo wrote:
> 
> On 1/23/24 15:15, Jason Gunthorpe wrote:
>> On Tue, Jan 23, 2024 at 02:33:15PM +0000, diogo.ivo@tecnico.ulisboa.pt 
>> wrote:
>>> Commit c8cc2655cc6c in the recent IOMMU changes breaks Tegra fbdev
>>> at least on the Pixel C with the following error message reporting
>>> a failed buffer allocation:
>>>
>>> [    1.857660] drm drm: failed to allocate buffer of size 18432000
>>>
>>> This error message is printed from tegra_bo_alloc() which is called by
>>> tegra_bo_create() in tegra_fbdev_probe(), which may indicate that other
>>> allocations would fail as well, not just the framebuffer.
>> Presumably this is because iommu_map_sgtable() under
>> tegra_bo_iommu_map() fails?
>>
>> Which I suspect is because of the logic in
>> host1x_client_iommu_attach().
>>
>> After c8cc2655cc6c iommu_get_domain_for_dev() will never return NULL.
>>
>> So this:
>>
>>     if (domain && domain != tegra->domain)
>>         return 0;
>>
>> Will happen and the domain will be left at IDENTITY, while I suppose
>> the tegra_bo_iommu_map() assumes the domain was switched to 
>> tegra->domain.
>>
>> Does this solve your issue?
>>
>> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
>> index ff36171c8fb700..15c7910b2e1c76 100644
>> --- a/drivers/gpu/drm/tegra/drm.c
>> +++ b/drivers/gpu/drm/tegra/drm.c
>> @@ -960,7 +960,7 @@ int host1x_client_iommu_attach(struct 
>> host1x_client *client)
>>           * not the shared IOMMU domain, don't try to attach it to a 
>> different
>>           * domain. This allows using the IOMMU-backed DMA API.
>>           */
>> -       if (domain && domain != tegra->domain)
>> +       if (domain && domain->type != IOMMU_DOMAIN_IDENTITY && domain 
>> != tegra->domain)
>>                  return 0;
>>          if (tegra->domain) {
>>
>>> This may be connected with an error in of_iommu_configure() that
>>> became visible after commit 6ff6e184f1f4d:
>>>
>>> [    1.200004] host1x drm: iommu configuration for device failed with 
>>> -ENOENT
>> Hmmm
>>
>> This is a new logging, so it doesn't necessarily mean something has
>> changed in the code flow.
>>
>> It seems the issue is something in there is returning ENOENT when it
>> probably should be ENODEV, but I haven't been able to guess where it
>> comes from.
>>
>> Can you do some tracing and figure out where under
>> of_iommu_configure() this ENOENT return code is from?
>>
>> Jason
> 
> Yes, this does fix the issue!


I am seeing the same error message on Tegra194 AGX Jetson. However, the 
above does not seem to fix it. In this case it is slightly different as 
I am not seeing the DRM allocation failure. In this case, it appears to 
be the of_dma_configure_id() call from the 
host1x_memory_context_list_init() function that is failing.

Jon
