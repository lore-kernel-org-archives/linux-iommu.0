Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E72E157468
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961435; cv=fail; b=K902l91PmSIRh2sVlGCK9ZmA6NWy9YRaTzZo9UoZvkay/OAojYBHAhfbcDX24oOOsz/gXEHA5NNRliEWDhd0dEw2gGHrdMGPlUrooLYJI+Ka1X6jsEQ58xlaR0nZYgXLkUvaeELu4v0p0h7va37ZY3nc5L6Mi67NqoAg8M6M1vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961435; c=relaxed/simple;
	bh=QdNvjk7lWMKHyDsPhsMlaHmnWni/61kr/UZin4xeuyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hcCbYBXQgDZi9GYIk49yf6j/Rd9gAoEnKfpd1MCYj2Nm9mDr94Kt5rjFXfB5cNn8u6gfWSYg+M6tnNKvmHzHqs0U8cvO18OUZfRN1vyijar4OiCi9NvVRN/bsRevkHEUQKqOCMQhaNZ0cjzZStxSXqZjqhkm86HJ2Xqc0+27RQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DGdY83ik; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DGdY83ik"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8726SafyGTzBbBjpP1g/fn5bc6DaaXr0Mz9o6BUSiZLZguun2DPan0YZn35pJOkDk7s0ce2V1GcCbR9oZur6BPbLbPlijhqeZYyeYqQivd/ecvdHEZGO3GQhBWRWAKzMvqiO9y43zcznFeePnJGdj/Bn3yxori1vyGAaGN5WdNbVTukofegXLp+9CIms8NvI8nKpS/MmIlMjfNd8BPdBqd8jfHRemhvDep1C+yao7GrijOmCZdT+6hs41xTfwn7IaeyP4EoH0fPwsplmcVeJogSreBH7QqSNJtFPUCfyMz8ucc9QLJxCEx/quOd/Lt7aNOG/wZvjfBeeHMZdVG7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUcnCMruHamLH5uCOAVtUhjskbvmcLQx9heN4x99Gqs=;
 b=WwccP2w++wchk7Dx2YYFTcV6kazezQmcvPIUhvZIZVisENyjii7UbY0C8rPfEM6XMOYUAh2afiJ9o/+ve9G5YKmWdbqjnm8kFhkcvETZgykJyWBQXHbyiumHOzNNRiWv07XXN3zDTbS8n7P0AocUtu3OYiv+Ydqk7VAxctZliloWMRnx3+uFqEwHv/5Z0S3+To3ZLWmEA0f2EzQ37TFKD36I3M3SjgFd9ZOwhx7I1PW6mLP9eOOqp2j8GmswZzlKgxVZx+AEKrEWDvtw9sxQsz4/yasr3pcSXJ+T+OBJ2HbL2dmHiQvWzrMS3sqX8MWl8CJMBdFJNq7vq8Y3zIFccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUcnCMruHamLH5uCOAVtUhjskbvmcLQx9heN4x99Gqs=;
 b=DGdY83iktsF7OQa6S2uler8zqQhBxIOnUVaJIl81IKPnopG9H9PoOWhPFwxLLavx6TqBNWBDq1QwkyisEaTSnfkLz2FqHIz0CxImhxSv41V+rju9t3LU3caydSPRqp2/Hps51ykZMQpHNPPfMkhMBp1LaDLoIJyRi9EA28WyUHzPNYB7Ztm+7RXwq0Jwz+3Pt6GrwLqLrM6DSwj6jd0NdlLBGBsaLReXBYNweeZGDJJnbBQvz6ipGqOhYlwz1lf6mnS+kEpud5fSoLb0PosCy2EV7A0Fbrt80daVIbVnC5fccECurXg0XN+kPGnUV+H2th8PaFLVhJamzaayfoP43Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.45; Wed, 24 Apr
 2024 12:23:51 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 12:23:51 +0000
Date: Wed, 24 Apr 2024 09:23:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	joro@8bytes.org, kevin.tian@intel.com, nicolinc@nvidia.com,
	mshavit@google.com, robin.murphy@arm.com, will@kernel.org,
	joao.m.martins@oracle.com, jiangkunkun@huawei.com,
	zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v2 1/4] iommu/arm-smmu-v3: Add feature detection for HTTU
Message-ID: <20240424122349.GH941030@nvidia.com>
References: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
 <20240222094923.33104-2-shameerali.kolothum.thodi@huawei.com>
 <3733929c-657e-4d24-b5e9-a5d946645abe@arm.com>
 <20240423145237.GD772409@nvidia.com>
 <90985ae5-fa1c-40f5-b4b3-57350a16e011@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90985ae5-fa1c-40f5-b4b3-57350a16e011@arm.com>
X-ClientProxiedBy: SA1P222CA0146.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::28) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS0PR12MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 35bbd114-0f12-42c3-81c3-08dc6459665a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xk/V+T27Ezt1192fbJrirjQ6hmtWG1daFIuCO5OEMEssvHSBkXJGRPUBboHf?=
 =?us-ascii?Q?KG1rd7K145p3s2pM59QjYVCyP3e5ZOSw8IZLkNClf4oynF/FD5OswSupnG4D?=
 =?us-ascii?Q?4O6QCJ38QuArH1beMEt9TCzUnr6XVYcR97DFccFKoI5KbvQ4MciloSeLvuqL?=
 =?us-ascii?Q?BLHfE6mydd9HTkpKXvmySdRESoB6iXnva5y9kfFNzVz9r0t7ixf9cKMK6yZ5?=
 =?us-ascii?Q?fUgE+0XiyTnHgLWRhyhbGadWcIPHuCNQfdXALUAGBzsHUTu/zTH9grk76Qpz?=
 =?us-ascii?Q?oM2lkp2e5/df8/EznaFcdFHhW7C7xSNLzGcmIR7YRB0Azxr15KGoe3fwaTYx?=
 =?us-ascii?Q?EcT1TZQ+kXTE661pDyf8gavYUC5g3ik7NZYG7cvwnM2Mi85ZteThYjvow5RB?=
 =?us-ascii?Q?a1+xwhcy8rgwW8ayOZbgq8DvTAWZXnjBNYghGgzmsAN2xGW9tqKWoyxjR0HG?=
 =?us-ascii?Q?Ww1mw6tA4YcYS4pPEgLg2cO7XHPcUl0u8rCmqS8/lXwsop/Is8HjcYajJ+b7?=
 =?us-ascii?Q?dgp7UXzaxfEtlKwgQ99RDPF+BaSusEYozaUWqu7gCUJQgiywRBkiCxBj3Gt7?=
 =?us-ascii?Q?/OSLNH3r5/55HOHFlCEavAZ6/aZaPX4mTgigz57+HfoqE9+aRgNJeMK3DLIk?=
 =?us-ascii?Q?AZAz3alqQKt+CwGEAQlEq9Rz74nTo29hdxy2IEiYBi4pSJ5xdZ8fNEPue42a?=
 =?us-ascii?Q?Fl1Dx3tflDlHSagFg/8vXcYyJPIrxdfsF0+XPqVSU/7Pw0GyuVFoonODqaWa?=
 =?us-ascii?Q?Jn/tOh6DKoziG5CnbiqJUBEEksVxdKLVHu0ceUPSfQ+js0TX/CCOHFKnzplh?=
 =?us-ascii?Q?bn6LPV5d1P/qBpJfj+qJVNK5Ip6SdOa9Swmg7p6H7Twhej+HsuQC7F9RMYLc?=
 =?us-ascii?Q?pRYeyYJN05LBtlqNx5EhLkg71pBU8D2TLD6Kcmrh3MRNVdj+FWLi5oqmR5JG?=
 =?us-ascii?Q?ZKb8KlXmVdNFGtYFQW7nKvl9t0lruYDpONDixV3/4TFBGxsTtqXvKgJvF9yl?=
 =?us-ascii?Q?phJ3M43+Gc5kdn3etvdcGUBEvtYN2CZLofOiLFah9V36ALH4iHl9GbDW8brG?=
 =?us-ascii?Q?DV5mt/+vOeqVeS+CcX724QsnX9B6IFt68eyCBdtR7tMps8cuuA+7qNp2kx9i?=
 =?us-ascii?Q?2avT0njoZbAX3aunke2p2nW8O9upYBA4IMa6u9W9vUGlNSipLKeVB9NDK7Uz?=
 =?us-ascii?Q?HZxweCKGOccwHiNiI75hkjl6XOLfgnZClAPXRTOjJNanUBWDpnqZ8RkCqAYO?=
 =?us-ascii?Q?S7jNjJ2YC5feEyOk2L5QTA64qtn9Es5KY3tfm8tpQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GXO3YrZCOnJX4tWSpC2KJu54OtaEW8vblIQd/MQwdfMmcjGC1rphNOnLqWfq?=
 =?us-ascii?Q?3MVN8nmTbusL3MWtMQXJH/yQ5a64DOsCuoV9qAs8VQPQDv/Ok9k5YQdsm4ql?=
 =?us-ascii?Q?KeqcpPnGI2akJbHbV8tJS5UBd159ZcKxoqlowCIcsQOk18NER+Bg1fc2Mzia?=
 =?us-ascii?Q?2FUQS4GtVRR2FmaNFm3SVOayixhZzSig2uwd8a1zeyDE4P6OQCd1lZg5uUG6?=
 =?us-ascii?Q?tG8OceaMlazpq58HpZgPx7R90WWzQbyuWGoC0fBtpgf/gDuSF1BIyaDaHNZ4?=
 =?us-ascii?Q?g8Hjln9Jt8ZATnr9W+knqPJbw/OgD3kNTxTYOmvxvS86ci80VRraeWEoYgIT?=
 =?us-ascii?Q?ZZsbY6QiB4Rn3HV/biUjKhbdxE9ml90QQ7jAFHEsmdZmBAhqxF6055ng/VA4?=
 =?us-ascii?Q?kLk3Dfam9o+o1kreu4CR38mXivtWjo2B7XzIaS43idEZHo1h0cjYcIn6Yb0v?=
 =?us-ascii?Q?D/puMIDMwfjr401XClD4QngpiE3eHCrQGwGlsAVCJ67sXxBn4ruDySHB935w?=
 =?us-ascii?Q?Z6TphRS6PuDySJcWxQM/eVjZl3DRdl4KKvv8hBVr/xP199bYD2jrBXmykB5h?=
 =?us-ascii?Q?0El60VEwtKVuKuXLWa5x4Xv+IAhTlrgFhFajqUkueyGAvT1jlx/7p4ZQVr4r?=
 =?us-ascii?Q?jnZ1QFlZsdQ9CZEejLW3s7HFRQ2zHVRDI9fhCABC6kdMsH0iXXvYdCVy1upN?=
 =?us-ascii?Q?PUiqNWR4APRaqwks45eF7VgY3O0loO8O+oORMiJosnPAvAgLAdTFMPSvgR+z?=
 =?us-ascii?Q?neMCMI49EvDGX/uiCV3Ysw21QbT/wuQ0yW0uyVSzmpY5x0h9QZsjOdgOJzbS?=
 =?us-ascii?Q?dGR9Wa4MvVoFmoKgxnx0mZO/tSv1Q/6AEPsUHnlLVR32sZxEvzCq/LIa+IBR?=
 =?us-ascii?Q?jGGqThq1od6H6oLPXf8apfaEPUgk1k25K2wLXIsuFN4m+lZLx7kWb84q1H5+?=
 =?us-ascii?Q?Ty4kzDK0aDTRD2M3AkFEqVKkxySV48KHau4BXVB2v0bWgHOn970oiG1yaqSN?=
 =?us-ascii?Q?Y78L+X3VcBKnzICjed5tu5g5SILN7OPCjTZ23q31jVZ4adGyBTeGwLcjMo2J?=
 =?us-ascii?Q?MHGEQ8onCe8kZxie9Hcx+ISnQ6+JmriQp5J7SshksgCExWa02ooZLcXnYfeV?=
 =?us-ascii?Q?MYy4mM6GQkReDJmVxztC0LLCNr4HbM0EiwXUPd/tPbNs0yo0dmBwU8a2lHfs?=
 =?us-ascii?Q?ZOAdCs6JQhSkPbvuJKerWbmPDF32kMJApUOjVQ6BG5INiNNG9+rquv6Tu6UL?=
 =?us-ascii?Q?vqj+cZ4oMvOlr/dgLra4hOuzgZXAHUrriwFqpBjiUMKj2cFDT1ulwpFzxQLA?=
 =?us-ascii?Q?nEsZxhEhmfOKb5LfmLKggalGPc8T6yADhcgCTsZLbpVOBWyV18bWc6aR5q+f?=
 =?us-ascii?Q?2jeQmsqaoF150Xr0ZKeJraQKvOx4iQUS/fupCfZS0rqB6X4sXvHOjzwpmXlA?=
 =?us-ascii?Q?XIKj1qiHuF+HNEGtH84zRwBTOkSONWJF2M3v2EZ17VM1hY4rFoHMEj9t7OM3?=
 =?us-ascii?Q?Bc0+8Vsqw+t6sAY/USeKf6V3o18/kaZniTEYQXsgpP9NebWAJrK2xCRN22Kf?=
 =?us-ascii?Q?t7mrgfftIWRTdrGvnDs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bbd114-0f12-42c3-81c3-08dc6459665a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 12:23:51.3129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKb7Qfzr7ppoig5/8+qp1XMffZxHA6WRgHVpDFV140/cpkwis8UVLYVlNJ/uROgM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397

On Wed, Apr 24, 2024 at 11:04:43AM +0100, Ryan Roberts wrote:
> On 23/04/2024 15:52, Jason Gunthorpe wrote:
> > On Tue, Apr 23, 2024 at 03:41:30PM +0100, Ryan Roberts wrote:
> >> Hi,
> >>
> >> I'm aiming to (slowly) get more involved with SMMU activities, although I'm sure
> >> it will take a while to get up to speed and provide useful input. It was
> >> suggested that this series would be a useful starting point to dip my toe in.
> >> Please bear with me while I ask stupid questions...
> > 
> > Nice!
> > 
> > I would like to see this merged as it was part of the original three
> > implementations for iommufd dirty tracking. The other two have been
> > merged for a long time now..
> 
> My understanding is that this series should pretty much apply on top of
> mainline, is that correct? (in practice there are some conflicts, but I think
> they are trivial).

It was originally based on my part 2, but I suspect it could apply
easially on top of part 2a. I don't think it is worth rebasing to
v6.9-rc since I expect Will to take 2a.

> I don't think it depends on anything new in your smmuv3_newapi branch?

I feel part 2a is done, hopefully Will will take it soon:

  https://lore.kernel.org/linux-iommu/0-v8-4c4298c63951+13484-smmuv3_newapi_p2_jgg@nvidia.com/

There are quite a few distros waiting on this:

  https://lore.kernel.org/linux-iommu/cover.1712977210.git.nicolinc@nvidia.com/

The cmdq area is not something I've studied deeply

I will be reposting the latter half of this as a part 2b:

  https://lore.kernel.org/linux-iommu/0-v6-228e7adf25eb+4155-smmuv3_newapi_p2_jgg@nvidia.com/

Which is the prerequisite for the part 3 series to enable nested
translation an vSMMUv3 for iommufd.

Nested translation and a few more bits is prerequisite to finally enable BTM:

  https://lore.kernel.org/linux-iommu/20240208151837.35068-1-shameerali.kolothum.thodi@huawei.com/

Thanks,
Jason
