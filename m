Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA17748C3E9;
	Mon, 28 Sep 2026 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790636621; cv=fail; b=SLMvvPFH+jlqaBWT6quGeKpVYh2A3q1LYHBKORlbA0fYLQtDNAPWsnts5d99BuhiswB+lbcHFf07V22JtA6bMdrSusz3Y5fMYWQwHGvSE+PffyPue9d2yCIimLkhsKgSlrnSSo4efgtbwUDnWrGX2pxODMkWpC/K5ZXR5pC+nMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790636621; c=relaxed/simple;
	bh=NhEez80GsL1qNzp357zZrDcZa6d1twXoX77xrDMY4Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jL+kwGCPuN1Qp1ewN9Rm5VAyRCne0dSNpKrrVpi6J4KvBrof7euXx+C6R+D/RtCM+bKGsCvxsDU0XFeN1pSfrOA+pJDxfW12ZJ49m3hKkkkTxeW0eb02Z/yPHxI8TxBAc8HfLw1ZNBbx8NKq9BJInqUyto3VuPUPqPimnFk4hdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dN/atjpO; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dN/atjpO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+f+NVLbvnwcmrK0nceHZRUuCISc0ACIHZj6Yp/4e9SH9n2lk1EpKgW0JxngGjTWB9CweMP5sAX9wDqhj2WsoUxMUNJaPReKvHkatRi7eLTzZkg9GIWSSeycJ5q4swyzWq3YgbU5Cg7R66F3F1bK/Ln5vCiGjlxqtAkrz+k7TpqbwzLDOEbchawqXUEePQZYUprhtez3zMqIYoJLq64/IqbqJlqaLAmq1DNmc6YfGvsftKPLrzhyyK/LYO0kUQqZI3tSg3eWnGvRCX6cwMF2I3GziRSksM4qy0slXVOE90p4KOLHIJ4fZgOcIRc95cBCCte8viOxvJ/ouHkQnpiLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVvpHlHueokMEpKAOWDjmW2m/sOhr38m2laD5wnstgM=;
 b=FfqEpcRvwuRGbhfQ62GlsZnrzBVvwcBr+IlHiv255+yOVKQzc8OStA4GIzDOup1NtbswPl4e2MgyDMY2WgR9VzHLgZXDKMqAvcUinxmVDCzzwxUzevr8NeBmCT3iRSnhp671ZLVczRRs1K7Nl3pQL4q7u+1KT7KK6R6ufnOefkRcNNH8cTVeEdrWoUyWNfXRDCKfsPkC3O0v2Hf/0pMl1mFeYBMN1E84k59/7Gy6CxbSU9rMIBrwnDl5ybXnkzmhvinEhrBtkU0Nkc0sKEWJMRknRLe/pjk7ILKgustLzLRZxu+DStWSRZS2ge4BRLzBIvOiDZbxonJdw7aDGJc9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVvpHlHueokMEpKAOWDjmW2m/sOhr38m2laD5wnstgM=;
 b=dN/atjpOq88X3oQ8WXbKGJQkx6SGRfcxRG/V0ebpqR5Rp414MaQgHi/nTEs/tDGJAc5WL9oDR9mwqEpXHemM0IoUwQaV9f6BRSuucqXePHJwIsdur5E8hzPlaQHcRfVKcWSoHx4HI9AqvnSHUm8oxO3yHzOZRuxglmktuZkpQAavD9Dre850krHJsNLvY0zFM3NuQLi4ZWq3jPCfEmDFBovNOk45a0AX1zKYgUJW9g1P/zO9S419TgLQNQp3K3TyUR/jHYtbGjjuqm7E7/6nnrZJDXmMlQNa/WMCk+9fgWRfIWYq+uIPnIY3k9GJ7GYWVaXbgSJdNxxfwQLr1hBetA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS7PR12MB8229.namprd12.prod.outlook.com
 (2603:10b6:8:ea::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 23:03:29 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 23:03:29 +0000
Date: Mon, 28 Sep 2026 20:03:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, iommu@lists.linux.dev,
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
Subject: Re: [RFC PATCH v6 05/11] iommu: Add a helper to validate a vIOMMU
 parent
Message-ID: <20260928230328.GE1616761@nvidia.com>
References: <179027891416.104879.10365675178574704349.b4-review@b4>
 <yq5ald8pkhj7.fsf@kernel.org>
 <20260925122305.GG9354@nvidia.com>
 <yq5a5wzpr7b9.fsf@kernel.org>
 <20260928121147.GP9354@nvidia.com>
 <yq5azex1peqt.fsf@kernel.org>
 <20260928161738.GB1616761@nvidia.com>
 <20260928110854.00003ff0@linux.microsoft.com>
 <20260928182022.GD1616761@nvidia.com>
 <20260928152402.000079ce@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928152402.000079ce@linux.microsoft.com>
X-ClientProxiedBy: BL1PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:208:256::16) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 234eac33-32ff-4b9f-bf2b-08df1db4b5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	h/RXkr2mB8kRBZqJr5y1Q3BCfBtkeLHVXoo6roNo/hhWd66xAZT5n0ul6uNWbM3zBs+iw0ySO8JKhvJBn+RpTNOsb7BID2eg1XZxO/qjr16oxFwX3raatDsn1hLkFFKCZUQsm44ZUDtnSdEZFVitOlirGmq5dV7YyuuJXFcYoKh/g/vrh2FS/Qgb/cRMLh2A4EDZcAQGI/owdsKiQ7yUdZmea2IAEGxLyHmxxHg04gp0J8GW9o4HHCBYwXOXA/j55/ekoXPlKtHKjgt87X+DRFFLq2mWJn+39bPKVofTlxS9n+DjFcO9AIZToK3wWt2tG9lWYr+NUKaNZ6jsw0IcBbbkkcMziu+kS9sUXUsWM4zmWUFbULoTlIiLryg24Xw4ZTK4Aplp4HXwB8573Ny23VUVuY1CCNHL4GNJxmwZ5KINc5QMq04SNrMvcsUwfUvS65DVk8ullmXSMAQCSe+OAguPgRn5jAcVOWXBM1mh555lJhO5QPzIUEk8wbmPOAF6ebLqHuFnXPCneZV6xobswtYPDoL1QmntfuOlfKgc7O1A3lyed/Y0ioOWRhO86HXXnlv4ZEG9xoJBkq8ECLXOUSR7L84ZGCNi2gaJGhrjOZXlpx7n5FV7nezGydkPqNEnRjMutcCUi+T9sfdJy57s1CoGaG3aslSE2b5TRE5g3lU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ounrIjfGehNK6lsYFvsTyyznAsFkxKpsW+A3DIVeQKKVVSARmtlTAxIqcAGJ?=
 =?us-ascii?Q?rdsLyuGdkGotm84Hg7NtHpvMvTedxgE8Qwpr6gdKZXjW39zjfF8uiu8JrjZw?=
 =?us-ascii?Q?y9/r/iVpg0p2xJk4yQ1jWf25phfcDzSUEGsGlPuIL/1n5P93nf8GvSnhHFbU?=
 =?us-ascii?Q?cYZFC34Czlv/HiKjX9e6R6BX80bfc7IxwFN4ExekN5gjYjM5AdmLddj7gtHt?=
 =?us-ascii?Q?KIbX5Rm/riWMaEySg3lzNe8N1GdzxGv8heX2z30p0exyMoFs43E/WfB4SvB+?=
 =?us-ascii?Q?C0ETXhpfGCurAA/G+qG202phudRgXYHRCCkRbTqmkTsjNKIhoD9SiNmOmhjX?=
 =?us-ascii?Q?p0pWQMqwP8YOamrabgMq6PqjGlofR1YFQNKKF20ZfzbQrNVbWgTMgEhw3PEI?=
 =?us-ascii?Q?z9JIlA9S4YCG9Igw+frLFS2SEtyzZMXFOmbjPJeKqUTzM4s+RsxPPclsPZAL?=
 =?us-ascii?Q?GeQI+lyZP/lsK91TszyEygbmxb5BQ4LYraq8tLLk7Or9++ZXq1MsS3NkosyE?=
 =?us-ascii?Q?LcdvAk3Qvto9W2vQF05lZAthOJKLlN6ZNAhlA2YkuxWruReylR37oCLy2Mmd?=
 =?us-ascii?Q?Q9pKdfoVc/u1d8XSpuE9EDl8EnrM1rpE/FNsW/N9E6hOpb/y+BIXteY0++Nk?=
 =?us-ascii?Q?osRFQ1yCTu0Cy6ItguYaK4N24s2+Ba6cpYQVlqhHNJlY6oOec2m/zBHQGyXs?=
 =?us-ascii?Q?jbd8V6Cknx93mZZDkzQCTr+YAdkd0H3bxlWerfvRHvgKPmg97KopAaCNbCD+?=
 =?us-ascii?Q?XLlb3JrUHnHRttMJZLoUCFe9oHR9vYwkGzteDEZmh74kp/qmFRLMYx0c7R4F?=
 =?us-ascii?Q?/ejgDT5jZVVSg8SeoSQrK3VMR4KPOTmANugVIeugwO1ob9L8N51OZwQpsIUA?=
 =?us-ascii?Q?OGG7TC3HUyQQmdcTTbRkvIukOFBEwdmtJCMSYgOwvg2QYMjyYCvzj1cGPdDr?=
 =?us-ascii?Q?mrcVuAg+g8Afr1zW42CjJdjzgwCGGiUclxsC0bcH6TkApFPNIM/h853DtNBR?=
 =?us-ascii?Q?xAXL9AJPj5+DFQgNxLhaZJ86hnTCrzJYrE3hG5KyvK7DWihxRPs8kJnzOYSO?=
 =?us-ascii?Q?VJljAr/DWN20hiApxezddpHCESjIoyCBlEOj6NNT4JDwnsPpvB4KeGuFKYFV?=
 =?us-ascii?Q?tObAcR8lz/mivzMIxMgVrqrV0rfP5zzLRCN7WIehZuVR77xTcbPXbETD3dG3?=
 =?us-ascii?Q?elzO6BxKz8O/IXb3kOSIxCokXT7Ug3cdpMJ8dG7mbjXAG9WzQeXcbPYIePNJ?=
 =?us-ascii?Q?iGujemxnhBqCvY7UWOq0pbED0HtURU018HlnCp71rYudaKpfT/SCFZ30ttIu?=
 =?us-ascii?Q?/VgsAuUpHmQPb0wCMTp3lHdRK2rQ16EhWlviCrHR524Bga4ucDitNQEyrONN?=
 =?us-ascii?Q?exZ2A7hCMk+dN9tFhDsxBiwA0jc3eg7ucWQ/oRNZCt+jBHBVY3uGVmJeSMEM?=
 =?us-ascii?Q?kbKeoBk8vVlJitH/h7Hw1ygyuQG1c9xn6FnFtWOzsI8NxQh/X8Zs25SAMZ1q?=
 =?us-ascii?Q?tFjnwrPyalIDirx7Wgo9ES6RnFpv7JGK7k8R4yr7kyDDujdlpiso3YGCJg+3?=
 =?us-ascii?Q?19MX9UIZ/8M1tzO1wCx1dO8xt2EnhZCNZpZXTEV6kyPtTCD4Bj1ZIcBhPFtf?=
 =?us-ascii?Q?7gDJ+k3Y27MqIPzZkt7Do1M2WHX63Vihlpu8MxciosE+eVcRBjjc1LI8dLZI?=
 =?us-ascii?Q?oo20INTEHgSbdrMCmh/zH6rgtIU3lgwln/AfDFJwxyiRVCi4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234eac33-32ff-4b9f-bf2b-08df1db4b5d6
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 23:03:29.2853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SR6tdE8+gHo2gk8dhHftqg53+NPc2ZCjjV9RqU3okQAGrL3iSUn9AwVVggFV9wrc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229

On Mon, Sep 28, 2026 at 03:24:02PM -0700, Jacob Pan wrote:
> > > > +arm_smmu_get_viommu_ops(struct device *dev, enum
> > > > iommu_viommu_type viommu_type) {
> > > >  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > > >  	struct arm_smmu_device *smmu = master->smmu;
> > > >  
> > > >  	if (!(smmu->features & ARM_SMMU_FEAT_NESTING))
> > > > +		return NULL;  
> > 
> > Though I wonder why would you check for IOMMU_VIOMMU_TYPE_HYPERVISOR
> > in the amd driver?
> > 
> It is an early capability check. AMD vIOMMUs require a nesting
> parent, while IOMMU_VIOMMU_TYPE_HYPERVISOR is parentless. Returning
> zero prevents the core from allocating an AMD vIOMMU and calling
> viommu_init() with a NULL parent. As you said above, AMD doesn't have a
> allowed vIOMMU type yet.

I'm a bit confused why a hyperv root parition has an AMD iommu inside
it.. I thought that was what the hv-iommu-root driver was for?

But we should fix the AMD driver to have a type (ooops that is a
troublesome bug!), and you should call add-on-top drivers like TSM
before calling the real iommu driver..

> > Maybe hyperv should be a TSM?  Maybe we should also route the
> > get_viommu through the the "kvm" fd somehow?
> Just to understand this better, are you suggesting to do away with
> hv-iommu-root driver in the context of external domain attach, instead
> let mshv (hyperv) register as a vIOMMU external provider?

Maybe? I don't quite understand what you've got here..

If the VM path doesn't interact with the iommut at all, which is how
these CC cases are, then sure that might be a good idea.

I think you are going to have module dependency issues trying to get
the mshv driver's info into the iommu driver, adding a "TSM" like
driver would resolve that. ie mshv could just provide the viommu.

But, you do have a hv-iommu-root driver so it certainly can provide
the viommu too, if that can be done cleanly.

I guess think about it ?

Jason
