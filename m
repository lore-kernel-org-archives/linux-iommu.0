Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7293157484
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042178; cv=fail; b=SmNtc7Mw0psiYesiU/2jKj1lb6bn9I4CWslQofGE5WX97Jezg0YIAzDngs+3OZqKPTRecUrNkWHrjPSG8LBFMrWjYVLVPiBX10NDSXZqSrKln4Ima5V3GhQp8ZXbnjrZSYt1cKnN7mWzT3nXfz0zvA/zy4Qi6/5sVyw1yXsaZUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042178; c=relaxed/simple;
	bh=Gw4fTcK3d2V/I5sMD0qlDIvFfld89brCDpcN48Xm3Rw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SHlEoIxiqbpPClc0OyxVnk+hmMb1Ovfnr1/N2urV9MpMaTPJ66yHets1sjCxSIIanPTi9E4QQPquISr0RFmUBpsoe12xTF1hlAzZ9ZtUkKy4RRsIvep3sKs9bkwnVeWJnHGZLUlu9n5h6+4vGIVD9UxBNEdOfkNfid5UmSHZoZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pajUQE3C; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pajUQE3C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iqV3IptiTnOmu3Dj3DhllKTGX3ITq/395cK7eqHCiNKFiOjrjkWlr7ZRNdhvA1UOmXeV2HE/kGMfQ/mhs0MSmIsTZbUMl+X2iYdGmQ/lWi3pY79hxWxlac/v8/vTmtWqFFrSswMY6pcaOOxeI5F0x63eGsmw6OC2b27s3NyqyjlrKi5nSLTNnjZNihPCZoG0FS2qVRVqH0rJZOBI1QHXqbr0wdovBLmijywiJDtjkME65fJCQ8L/S/E/Ad6uhwrF8Agfhxo8CraNf6tY6gEGrZj8HW4Lb44YGzqcU/4qcrzozwTzzrZ1Dq6SgaIHtTnCF3IAXwVKLYR8ybpGuXq+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3G7vQ4saYJhl+sWfijp4J/LxpSclfR9BFByJI2TRvrs=;
 b=N30xLlTL2tnB+hG2VmINx/eR7yRJU0qssRe4AxDNDSrriByM/qEgXE730dulBRZQOWiPz1y/ZKSI/+0wvAken5PhYhFu6NbD8eooi15W9Dd3px9Qrgs5y4RptXDbJBc+8x8DAD+lmMpPA3wbiJI9h3E5EHMwy+AWlnKs/6XHEX3Kq4Rgd2PghiPtWkMOzxWtpZjTDlziweV5ARU+bHOFEPiIRJ0fnW/3VoL54EJ354bMzgVOjZFtVFUOhxpNgcgPnc5PCaF5fBzq2KZ9HDxjLB31vgptK7y7mPh+yLcINrAB+hiNQ6kyLXolw2hcRs3MZSZjsjw3K07ZbsNp7nUPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G7vQ4saYJhl+sWfijp4J/LxpSclfR9BFByJI2TRvrs=;
 b=pajUQE3C4DXzQc5BoUcL/3zYrC8bOfo7KDd2was8RUVvoPINJwSrX652O36yGGuqunHISK0x/uByUIzuk8BP/6NZB44Fci9XscsepcsWkA9phjmVDP+aNgoIfUiL6R4/qBOr9NAVusJTXytK+FieQfE3YQMOTwCAfXE4sp30QWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.16; Fri, 4 Oct 2024 11:42:52 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 11:42:52 +0000
Message-ID: <b3e16c66-36c3-43d4-a592-9419e5955c63@amd.com>
Date: Fri, 4 Oct 2024 17:12:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] iommu/amd: Implement global identity domain
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com, jacob.pan@linux.microsoft.com
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-9-vasant.hegde@amd.com>
 <20241002193625.GS1369530@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241002193625.GS1369530@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::19) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: 07277754-8801-4a26-0c3d-08dce469adf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnFXY3d5TXhyR3I1QmYwTkxYcmZXV29qZGtqK3IxL29JWnMzZlk0RktXaXps?=
 =?utf-8?B?OXplRXloZ0c3UGo5TEpLK3ovN1dleUNWY1lxSTN5aVVjMytGY2lndXRFcTh1?=
 =?utf-8?B?Y016RFZNYlNadUJXN1RkUitZdytPSXpUNWZYcGk2WTFUOHBCRERZM252V3Js?=
 =?utf-8?B?S0ExMlVaSEFjdkd3Q2t1QnBsTTBzR0FCR245ejNzTDRGUEY4dE9KbXluZWFC?=
 =?utf-8?B?WjZMNy8vQzdUVnp0WTZTc1g0bFNhRVdXdmx6eGtOWC9pT241OE9iUGY3MlNR?=
 =?utf-8?B?L2NVWWliSVZhZnMzajgwalVLSGZaY1RNNGdVTjNjZWhxM1VBKzV0eGZuZ05M?=
 =?utf-8?B?MzFNQXBYbnZqUjc2K2h3RWVNajUvRU5jUU1NTlVLbFBzMHUvMEppVW8xb3BM?=
 =?utf-8?B?eUhVL0JxUCs3eURlZ0syTS9yTGZhWmxTL1NaNjY2QTVnaGRFdHUrR0JBdkZK?=
 =?utf-8?B?R0tlSGcrU1V0ZkM0VDg0bUN0U1NZWldkcWFXZzI0dlN5RkV2S3RMNlo1bWU0?=
 =?utf-8?B?YjQzZDVXd3hIQWozd1NSSWp4cHJOWHZjNUZuN091UUdrM1FFUnpidXpIdkFM?=
 =?utf-8?B?dkdPMllHWDk4NS9jRjRQa0ZsNTdqK3o1Vkd2VTZ3UmZPenF2TCtIK1lZVFpJ?=
 =?utf-8?B?ZEJpZ2xxVThKZndmRXJrejd6Y0hZMGZqeU1JYXBwVnFuQTZpam5KUWRyWkJH?=
 =?utf-8?B?OGsrN3Q2NDlpSk5QVmR1SXFOZnhPaUpVQnZFcEw0S0hFZnVzMjVYNUZnRGpl?=
 =?utf-8?B?UEluMjYraEdheFN3NGY3M1dEbnlyZ083dVM5VHhYTFBWQ3RKZWtSYmRYWkhl?=
 =?utf-8?B?aHNTRHdlWnBBKzVZS3NRNnBHOFQ1VktUMmR5cjlma21jWDFVSTdnU1dXem5i?=
 =?utf-8?B?L08xcFNwV05MYnlodlBtbFlFNy9mNjRDTEg2S3dCMFVRY0ROSUtpVm5Qc0F3?=
 =?utf-8?B?cnNZSjVOWGNGM05FblRGSGNwSWRwdkE0aUxXRzBMOVo5WnhwUmtHaFd2WkRF?=
 =?utf-8?B?OFNrWnNXMm8rcnpQOWZ1aTRDUkt2Tk5SV0ZMYkJQNmduNVZOWjZRTTY1VGJZ?=
 =?utf-8?B?OXNVYlNaVWppdjVxMnE1NW1rd1pYOWFiNk1vUW9lNm1qUEVmbzVmS2MzMlpR?=
 =?utf-8?B?azVTL1kvWjlORytHTFFvd3dYOEpNRlA4ZEFTSUlMVWVNR2FTSzl5eDc4UlhT?=
 =?utf-8?B?R05xL1ZtcXZROUNhdXpOOWJvM0RycnIrOTNtaXl3OEdYVzREOFNGMmdYRE9n?=
 =?utf-8?B?d1NVczdoeUxzaU5CVXhEUGJPVXB4VUwzQTB2ZTdMVFZPdXpEK0d2UU9YUWVH?=
 =?utf-8?B?NHB2bTU2VHZIdXdZT1pOYmkvZHV1Y3MwRldRMUFDdnJBek9uaHQwTmRWT1Fj?=
 =?utf-8?B?aWdaSzdWYjBtR3BFellETi91WnFiRnpCbzF3WmdpSW5Hei93RU5nRjR3ajhI?=
 =?utf-8?B?eDRLU2MwMWprTkNvZHp0RmlkVC9Xc2xKaVJ0WEl3Y3BMYU1qYm92ajJFdFZa?=
 =?utf-8?B?c01WRTkvblpZb3IwZlRHc21YL3hxY1NtR1MyRFlIU3JBNldQcXU3bGxla0x4?=
 =?utf-8?B?M1JlWWlnQVloSUh3K3Jzck8rYXpRRnFzMGQzV2RacHVYRzZ3WUhyQlR3WkZx?=
 =?utf-8?B?WmxDWTZERzZoNUdLNHV2cUxaaVlxM2hCRjg4MUxXZDdJQkNmQjQ0NWRaalMz?=
 =?utf-8?B?WnJLeSt6QUtnZnpEUk5JMjBrSDFDVTdpVUVua2ZlUndWUWJmeVMwT3lnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnRLWXZPTC9ZUzlwSDh3SnduS2Q3RS9DMXY4OXJqNlJudDJ3am9oTmZGdHBQ?=
 =?utf-8?B?WTJIL2VISFFPRDQxM2VlY1NHMWtjQlNKbnoreUxXUWZ0WEFkUVRLU1c2Y2VD?=
 =?utf-8?B?S2lYVGl5M1hacnJ6bHdZR0grQmVweEIxSTN6Qi9UempLMS9ZNTZRVjdaSnc2?=
 =?utf-8?B?VDYxSEhRY3ZzQlJDLy9nUW9uVW8zZm1VZEhtb1o1b3ZIMkJSNlRiZE0zUmx6?=
 =?utf-8?B?WklpK2FsZ2JaUklJVER2bWoza0pOZUdGc3NOa0RGMlhuRTVBSkZXVFB4RzNi?=
 =?utf-8?B?ME5vdWx3QnBBLzkvbC9JcERheCt2dkN3ZCtSREhXb2VqMVRGY1FoQ1ZPOFdB?=
 =?utf-8?B?Ymt1UzRDZWxYdFFRNEtNbU1zZng2OU5raDJEUXg2dXZMeU9aL2x4U3VFQXpY?=
 =?utf-8?B?ditxY2NEZnpsd0dvY0dFUUVPWlBKSUh1Z09rOVp2b1plc1lieXgxTGNYcHBF?=
 =?utf-8?B?YStadi9wSlZmS1NZVGhRWHIyNkVlSzd4S1FEaThGVjlkVlZseDl2SEZwbXh2?=
 =?utf-8?B?djNhQ1I1TEtFWGt6RkhzaXc1TzdCZy9qYVRPdzhjS0Vld0F2NlBRaitQTUp1?=
 =?utf-8?B?T01GQ3c5VmgyaDR4N3ozNVAwK0tMdGRJbXJyNHpweXRPZVF0OXMwOUErT0FU?=
 =?utf-8?B?YXpZNmMvT1pWVHpUdEV5ZG13SFR4bU1SMy83a1hFTWRsRjJUK3RHMWUrVGJz?=
 =?utf-8?B?Qys3WVFSUWNSVVVqYXliR3A4MXhCWVB6L0Jla3VWMDBLOTRQZWhRMkNOVG9h?=
 =?utf-8?B?Slp2RzU5Qmg2UEhuVXFLRXZyUWdnWmxmaE1mSGlKWHdUZGpHNnk3ZURmN3ZX?=
 =?utf-8?B?MHdtZXdlNWRxNXVKZFcxNXNJaFNwTjErZDZGVGR2TG9wK1R2c2FmQ2ZFelpN?=
 =?utf-8?B?Umprd1IxVjlmcWpGVTZwMUsyNURLbi84Um00aE5nR1NWWThRbFFoeS9SWnc5?=
 =?utf-8?B?b3Z6Vnc5SlVTc1B2U3BGK1VsejBvYVk2MEVmektaQVhsRzNpclhuZ3NZSnQx?=
 =?utf-8?B?WGh0ZmlES2NKcjRTd2JDdUhJWVFjK0RSTXZOVDhTWDNoY1pwZGRIQ2Fta3Bj?=
 =?utf-8?B?eEtBQUl2RnVpLzhPUGN1ZWdPS3RuZHF5bm5aM0hNMTVsdTBISjJMa0hCM1dL?=
 =?utf-8?B?NS8xRW8zNUtuTFhFV0dMQkhma05RNWFGMnBRQy80MjNoczVSbmJ5NXIvaU1U?=
 =?utf-8?B?Mm54Qk95RllvbkxNOTJmMktFTXd3bWpxVnZDbmFYNkpmcjdsc1B4bXArQVQ3?=
 =?utf-8?B?Y2FYWEEyTjBscXpBWWxGZXJSZGV1Zks2QURUeEdZa2dYS2pQMVA1U1NsbG94?=
 =?utf-8?B?amNsOGV5SkxWSklVaUZLc29FU2t4UFVNSHN3MjNEZ1J1VHpPQVluaGlNZ3pu?=
 =?utf-8?B?L2xEbnY3R09pUmI2ODBHR2FxNXhJZHlaZ2orMU54V0Y1aXRRZE41am5xWXVW?=
 =?utf-8?B?Sk5QaGFLN05OaG4zcVljWnpyY1N1OTVneFR3TVJlM1J6Q2pReWdWTVFPcnNR?=
 =?utf-8?B?aXBSZ1lwZm05WGpVb3dvby9keXMxMjcvVzlrRkppU0NhZUF4QTBnb21TL2My?=
 =?utf-8?B?ZjlIUnBFdWJrbVU4KzJjSGFDTzNIanlRNjBvMUlsVG96YXVnQ2NrUk5zTjRQ?=
 =?utf-8?B?Z0EvUTBBTjY4ZExLaW82UzkwODNIVVVsVkZxV09tSGZRZHhRWWZDYWJLQTFx?=
 =?utf-8?B?VjgyZUNicnhjMytXbktZK2pHT21BcTNQc0NOQzJ5ODBXRGV1TUR6TzhaZXJj?=
 =?utf-8?B?WW40blFCcFNCNE5KbGJteGdMTXFHM0h6SzhHRXZQd1gzTnFJQWhoL2FrWG1R?=
 =?utf-8?B?WStrWjZEQmQ0QU54UFltczNpT2YyWmp3NHc4MktkdnYxWjN5SUlwS2tOVkRJ?=
 =?utf-8?B?Z0s4YXB2QklWZkR3WDZSaDJpbnFIdzZYQWVGSUxOUVFUNGgycWxBeHNKUENH?=
 =?utf-8?B?Mjh4NHYxMlBQQ3NPT1dMRnBPSFA0eGFOUklzSHJETmJKcC9kZmFpZW5hQlJy?=
 =?utf-8?B?RVU3QVRlSXorQVQzb1UwM1VkZjJMdTlrLzIwU1kvemswaCt5MmViQXhyUmJt?=
 =?utf-8?B?elZmZ2NETS9tVTNnUTdVbDFEVTBaSUkzU2JTSTFBa3hXK1hBdkFtejhtNk5v?=
 =?utf-8?Q?TLobUumXchQawAJFvQ+vNm/4c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07277754-8801-4a26-0c3d-08dce469adf6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 11:42:52.4601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEPgXbpBSmqbmHrbxWZ0dkFbxA71q3kO6NZhDL+fas3fQSibEARd2KUaSk09menu9jDyzRiYutyvsH9Zc4CT1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111



On 10/3/2024 1:06 AM, Jason Gunthorpe wrote:
> On Wed, Sep 11, 2024 at 10:19:11AM +0000, Vasant Hegde wrote:
>> +static struct protection_domain identity_domain;
>> +
>> +const struct iommu_domain_ops identity_domain_ops = {
>> +	.attach_dev = amd_iommu_attach_device,
>> +};
> 
> It is fine for now, but attach_dev really should be a function that
> just does identity and what is left should really just only do
> paging. Same for blocked. That simplifies the flows quite a bit..
> 
> It would also be really nice if the identity_domain and blocked_domain
> was not a struct protection_domain like all the other drivers have
> managed..

We support SVA with identity domain. So for now I had to create
protection_domain as identity domain.

I will revisit after fixing attach domain code.

-Vasant

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason
