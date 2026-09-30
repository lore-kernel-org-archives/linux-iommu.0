Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013011.outbound.protection.outlook.com [40.93.196.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1F3519DE7;
	Wed, 30 Sep 2026 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777357; cv=fail; b=QwklY5U+NiEFSwy5DcfddV/IHZnuSmE3ySbgcdndxy1Xt2GLVULcwXTH/nO5btnZIanJGpd3LJc48TbH1x+HUeVWDRO+Vnl6iVi0q13EtSC9JeGrn9kGO5svcJIOF4+Hp1aV62bODp1MBQUj2oFgtdd8GI7toMy8z+mh0GnJTkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777357; c=relaxed/simple;
	bh=LkIfbmf11o8Z5B/2Szs9W/sH/A5hf9woJ0HrGUXY0cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uDTYEH9OuxShT6A5qKFcWiUDIb+G/2N4BpqWEdGomLhvhg5aPJYopQNZiaUcC0f64AxIjP5vC0m4pZ/4Rn7G2zDrB3ZqKdMJLTMMWraArBMxH3Pvy80w2IjYG4GHqjbYmnoCfSLhCkp9HPNylFd0JHE84bJX1YgYoSWGIdPIlHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KpMhVPkc; arc=fail smtp.client-ip=40.93.196.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KpMhVPkc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbyHiQJEZFiNwcyKYf5t0BhFvlUWOxW+RVIqw9gV3thUwUlepyZ//e85s8t0+rthi/2rhsl0i7DMwvYkRLlJjKVoVPBNSpoAGJ24NxIVcIZ6f1fwgJ0PxTC8VMb/vRxgoEDkbl0TOLl0ICK6R++W3cP+IChBitlZq4Ok1Jh2wEDMtGD+b+DsVOqe85Vw8AdqUBeNFApCORNp8XRAzoAAmLhssxb2QBJm7fzEIYWJPdLGMqhEoDJV7BVkAZTpLdVSh0qqAV0/JJHy1eTbdAjTOa7C1s9DLmEf/NlHwVhhac0X0UthNhP6uL5LWo6cHkczX8njO4EduEh3yLXzWLhoMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fq7W9liFFQxp9nUz+Aw1IQ9qkk1K/JschF0PCXu0jiI=;
 b=P9uQQwZh4wapRHupFJDLaxcnTdo1ffpHfBUFMIpN488viqRJeu5s+pVICang+RkpmfC1oLRdbns3RHxQvauZqf2plWstReHf5UfBU857HFMji+JLXvcvCHPNYyUaCHOB5PWbMmCWsKIj2zDyN9sVkLzGjO6toirPcr1EVFy9qzT32c9bMcbUuRIxg2NIgQKk9O/8G0yfJBWLfJ1lWMz+Bjj98/gPukw9ocvomV2UsdAzUTbsagMqzIQHuRmbVPRo2JI1Z7aWLgCvR1kztNNwZowAJ445tW7q7XT7h69Sjw3rrAlXX0SK1NWyky+02UHjfQZ/B6rIodCDwmZnfqEe+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq7W9liFFQxp9nUz+Aw1IQ9qkk1K/JschF0PCXu0jiI=;
 b=KpMhVPkcBPnMdBtflg0LBwYsqT0ewBwaMcSCb/5sVv9kAxMEppxSQazHdNnJNJ4rtcJ6NZbktah0zO8gG0dCQ71YEeCwqWCrd63meRcr1KspZQydKrxHxL8ttZrLDZ7RjJTqdVILdzW4a99wpcj7uaK0lvv5sheYawQJSZbHlA51g+rsrOxoRalAl3j9cZfgHEyszxk6fzs9pFeQh0ZAIVBt3IXPtmJIUSj8tDlJAE6gSQ0n7Lm9vt6S4e/uXORQ/Rumle5/JNDmVqPWCsZI5mklflN2rqNjny0t2jxLPc3kmwUCYWUlBemSalleMz+1qAQ2Oddjhxe+Aceaipq9vg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by CH3PR12MB873938.namprd12.prod.outlook.com
 (2603:10b6:610:366::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 14:08:49 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.024; Wed, 30 Sep 2026
 14:08:49 +0000
Date: Wed, 30 Sep 2026 11:08:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 09/11] iommufd: Add the vdevice TSM request ioctl
Message-ID: <20260930140837.GT1616761@nvidia.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-10-aneesh.kumar@kernel.org>
 <179027891417.104879.282447770434616733.b4-review@b4>
 <yq5a7bk3upx6.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a7bk3upx6.fsf@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:332::33) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|CH3PR12MB873938:EE_
X-MS-Office365-Filtering-Correlation-Id: 112d26a2-9310-40e7-8d2b-08df1efc53ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|11063799006|4143699003|10067099003|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4Vrh3cjIjayHL7hJRdauEylWnAstGWwCbFd3AjE59tQi84lArFW2W3ZKrNk5Ds/FcmcddvqbyWH6xcyGen0ynyprU41D1ownTsCzgg4o+U84rlidloWl8Rs5DpEj/DKn4C9qx7+ffNt7llxfqsHiVUQYUeOG5oyW6SdGY/7PRTvScmuBQt9876PdUysDspnb2p5PNveQv1zS5LznaQ9un59ns6Yz1gb9hrlENyR5pVgn0plwWROa4tYKiBWjD1t/z0IjgHIUpEZvyqysgM8YFPFOVVnUPSWWtil6VzQ+bN2oMB4h/MWmypN0cwaCzWFaw1eSmZ8jj1oAi9/f1dZWtbwfkpsGaRW45BaNjti0aaWM0irlsjIR4kaEvpY6sx0m4qir5tyDf8rGMzoEun7aGoKwwoNl4z3SPg3zxqtyxoY52rnS+raq0LwKzMAAwrhDqLdU4N0XH/Vpapzz4lSBpZrmeD1/py4ZYF+ES8Ty68VY77D2Bn2D+JGudxeE2YjSGwzt94Wa56G2fuDVfh7LZlBqAbQ8JFMT0XdaU4gio2WN3x2UvhycDqq6fJ0/keiiby8FEtc4PGkE91xYiZ+uLyi0jC4pTtefmcR+q0RyH5TPv1pzMSuRRgROHtobwLswxuPT4FkHPTRa4GGi39C1vwZMyKr+NmOQIuY8l++alfY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(11063799006)(4143699003)(10067099003)(3023799007)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rqi6/+Sla7LnsqYvVtlxR2O88ttLI3qO2JgrIAqrzNSqUgU30abB4ZBPCBO+?=
 =?us-ascii?Q?TG5Ngv2Yc/qikIjhsEunx3/WTELzAbsB6IfFivfIVTe1ztDh/LN6IV1gKi95?=
 =?us-ascii?Q?8I8j9JlL/rhECVv2ZboIxoDbKM6WrYrbtaP8CjSf+k4EEsowJtImmf4tC3zy?=
 =?us-ascii?Q?cd3gJAg+5F9aVcQG1C2VQcxYC3lO30ozs+QeHIOm66Xz7OyAelSil9tPp0mo?=
 =?us-ascii?Q?15j/2Lfd1zwDhDIVB2YVcsZ0m5wbvL5+14lEOf3FQp/wDolaRUhgl+5UBCYi?=
 =?us-ascii?Q?ovbR/DyD3EuT/CIjkHERG9dC3gymUGlbmQrz0fP0BPbBej4ujfacE2dAhyuS?=
 =?us-ascii?Q?RTj7OzJMzS6OA1bmsDOIyiRaNid4N3KZ78Jy/01UTH76w7JjXOC+wCSZZ3tI?=
 =?us-ascii?Q?05/340DVq1AfOViX+6gpKp+c2kMUipEqduMLRwNndQENKca+NRdqShUF3zqC?=
 =?us-ascii?Q?CWW5r1YmZQ+lTU/jBjj375pa1jccg5aoRzR1YPdOMJSleIGRPnnranrPubxr?=
 =?us-ascii?Q?MSrD9CPOPQqTq5FEWXAezcq69zfTFpxhsrHHPSDuVzebwYviaA68cwSaG75z?=
 =?us-ascii?Q?f6JxaFnI40C7oX18pdmwfuy24x8ULQgdg+fnNNGPDZT0BsZLJ2l3NFcO6cIW?=
 =?us-ascii?Q?DaUNPZtbRs/jSFoyoco1NxA2EYCm/0nU3Rd4j/m5qm/8QwmDDX/+mfHD8wMN?=
 =?us-ascii?Q?38JrlLbUBddodsgqiWEF56RAN6LJfeeZetDss54cQY1JjPlJWYFpFlnxpbto?=
 =?us-ascii?Q?tr4JWDeV6KtKSe9nv854UX67tuAG56bjdKK4Lq1i8d7mLRsEPA5x8G8bUe2h?=
 =?us-ascii?Q?T5ACRPXRmxk2Q1OIHakVAqvUlKRys1KF+McLAOJbGTVYwS6gL249v9Srjyy9?=
 =?us-ascii?Q?D3jt/auYpO+/1FEdhqjivRHHqd4lxtZXfBTWGrZHTgns6WCxAO9elLhoBx1H?=
 =?us-ascii?Q?lbd6pn7isGAaiQGQ1c991IaI0VlejX3zziTOb1UW3EHvVL+myjFAAg4fxrpm?=
 =?us-ascii?Q?0SXchy/gVGrudbX4+9OTQ/9U3XZPLHWGWEsEMlL7CbpviPq5/hw1BZQ+sSmL?=
 =?us-ascii?Q?Yv6EWHEJaZlr1K5UPdWl86AjrYGpGo4vPIFW9qwtKrmUb+tUHjDt+zbIbxRb?=
 =?us-ascii?Q?InnpZ2KxFZXQB0j4HGADD6Ul9V6nVd2rjggU/9Bg8qWtwbw354gKlh2sTejt?=
 =?us-ascii?Q?GqYttjLyOPUq7K5KCUT4or9GevsBqIf9z9LAjs8+yRrziR7bw3EaeGhEFMIw?=
 =?us-ascii?Q?OVDJhIhcHxM2Oo9VBak0fcji/tOC+yqu7uVpmNGsBjSSZutlGWzuCqkSLx2p?=
 =?us-ascii?Q?hEZ1HW44OijDRU7aVW/2uDmUxAz14VZ12P3BI9nxt+yDD1csApaLUcDVZB1q?=
 =?us-ascii?Q?gb8DwbOeV4Q2HjztUTZdubfRLzpzOhvYm7Y3ojBRzFjnXpUhaIbmX9yjfcI0?=
 =?us-ascii?Q?A6elhDF+aJ8kJtZbCozPwiPPVyYUL6hfPw7i55ccyzY+0sW3EVWkgBElyyXY?=
 =?us-ascii?Q?sEEg1tFkC4tdF2QFVarU26dnsn7jnckcosHhdcE0KRi4c4+B6qD0ACPObR7n?=
 =?us-ascii?Q?qPUg/UtvAB2o7hYmlfr7kCHOaolDnETkENqmENYOXU/vvEJDN4RFhw0lYB5I?=
 =?us-ascii?Q?LT/gGkYm0d0gn7O5qQNEfEwITonuEfEE/KfhLxVlJn2+ccy0Am1RFcFf742O?=
 =?us-ascii?Q?XfWipuwltegkXhCeChDoIFDlf8QKQCL2ino45jvV+p3wPzlp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112d26a2-9310-40e7-8d2b-08df1efc53ae
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:08:39.5456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rg4bx2pFcUlFlw5zrv2KPSHMLzRQ1+czw0Eo9E3Et94aaMLuVlbtMVcUUz4i/C5x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB873938

On Wed, Sep 30, 2026 at 01:33:17PM +0530, Aneesh Kumar K.V wrote:
> > Why would it ever not be tied to userspace pointers? I don't want
> > an in kernel user ever using this kind of struct?
> 
> The previous discussion suggested that another kernel subsystem might
> need to use this low-level TSM interface, although no concrete example
> was identified. In other words, an opaque guest request could be issued
> from either userspace or kernel space. 

Don't do it without a user then.

Directly coupling KVM to iommufd is some other future topic. I don't
think KVM should be coupled to TSM.

> > That seems wrong.. The hypervisor should not have control over T=1
> > DMA.
>
> This was added specifically for AMD SEV, which requires an IOMMU-side
> update to enable DMA.

See my remarks to Vasant. I want to take a very careful look at this
list eventually, but for now lets focus on the other parts and keep
this seperate.

> We have gone through several iterations to identify the guest
> passthrough request facility we need. IIUC, both TDX and CCA give the
> hypervisor some control over the request type, while SEV-TIO is more
> opaque.

Is there a record? I would be interested to read a summary

Maybe you can summarize the details in the comments. Eg define exactly
what spec operation each arch will implement under every proposed
call?

> >> +/**
> >> + * struct iommu_vdevice_tsm_req - ioctl(IOMMU_VDEVICE_TSM_REQ)
> >> + * @size: sizeof(struct iommu_vdevice_tsm_req)
> >> + * @vdevice_id: vDevice ID the guest request is for
> >> + * @op: One of enum iommu_vdevice_tsm_guest_req_op
> >> + * @tvm_arch: One of enum iommu_vdevice_tsm_guest_tvm_arch
> >> + * @req_len: Size in bytes of the input payload at @req_uptr
> >> + * @resp_len: Size in bytes of the output buffer at @resp_uptr
> >> + * @req_uptr: Userspace pointer to the guest-provided request payload
> >> + * @resp_uptr: Userspace pointer to the guest response buffer
> >> + * @tsm_code: TSM-specific result code returned by the TSM implementation
> >> + *
> >> + * Forward a TSM request to the TSM bound vDevice. This is intended for
> >> + * guest TSM/TDISP message transport where the host kernel only marshals
> >> + * bytes between userspace and the TSM implementation.
> >> + *
> >> + * The request operation is guest initiated. The TSM backend validates
> >> + * @tvm_arch against its bound TVM architecture assumptions.
> >> + *
> >> + * The request payload is read from @req_uptr/@req_len. If a response is
> >> + * expected, userspace provides @resp_uptr/@resp_len as writable storage for
> >> + * response bytes returned by the TSM path.
> >> + *
> >> + * The ioctl is only suitable for commands and results that the host kernel
> >> + * has no use, the host is only facilitating guest to TSM communication.
> >> + */
> >> +struct iommu_vdevice_tsm_req {
> >> +	__u32 size;
> >> +	__u32 vdevice_id;
> >> +	__u32 op;
> >> +	__u32 tvm_arch;
> >> +	__u32 req_len;
> >> +	__u32 resp_len;
> >> +	__aligned_u64 req_uptr;
> >> +	__aligned_u64 resp_uptr;
> >> +	__aligned_u64 tsm_code;
> >
> > out_tsm_code
> >
> 
> That is required for SEV-TIO.

I mean spell it 'out_tsm_code' since it is written as an output, that
is the convention in iommufd structs

Separately I also don't know why we'd need it since we have an entire
resp_uptr. If the arch specific action needs an arch specific code, it
can go in the arch specific resp struct.

Jason
