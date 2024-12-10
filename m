Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD921AAE13
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839067; cv=fail; b=tVc6V1ySB40rRD24c2srZ7M/4mCXUhpHwmCD8jSCYoSY3NB43jEZkGkXyqM9cuuDQEcS26GQo6umCV709JzfSq3t6gSggFLtmXqoFU7S2EitGZNemWlb1BDPnP00VNzbPNqtrhBfKlBqpZcXiO5QnHaR7fq4EG9CfZ+Ri0uhiTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839067; c=relaxed/simple;
	bh=b1jWHgfypdXpQc8sFEB9qd18TALXZHgaIDO25C2CDoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nq8ZTmA4RTpBWpywwWqlLVhROmnPwNs/ZKH+V9la6U5ERUXz+dAE6UYDcBQnDwelmbn0ZIj+JJBsUbqGWCW5sVTfz+J98WNbU6dkN7RgeKigWB8VhoFI68Pi22fFJtfKKOO3SPuU9XtclbOhcA/gLyJLegeGLN/FZRZk72Df5T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d7SOkGud; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d7SOkGud"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKixY9bWMmrM/raMyvpRkV4jPHQOpozf8Nmr/3DJQIJICjdrvupWKxPLgH974YFAe2QpAt/J+Gs1lmTqMyZvEYVM1IyAOY3b0iCtTnFAX+y0VWt6KRK1ymL/32pK39rFPtj8i1r+U3oB1MReoPZqPfasLxk3aR5EMIX4BtEKQbpxm0O+yOZ21Vq83tw/y3pLoEkDucfMcsu7S0dPs7uvFLi2pHucufrGqQreTqhjQkYUD9CO7d5TOWL11sGjAY+Cjz/9lvYVH2mkXKI6DOyvLzWwIhic+pBPYZvBhqE+bP+CLZ2dmx7/0IncuJbFJguHm+m/q4c8jvFL++F8KIGFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzWIsXlhtAHSf/NujWzoqu8vNUbg+zCspworSEi2iXU=;
 b=t20e+mLFNaTNa4lmc+u5VULaKtLHXQDFrQpURHPIZdRDGmOorFrP3R2c/lUCBpmCtz06HBL6CzoPgfjO7BrmXh1sqHCbIvfoX7+i/YfRmFxWfwi8IrhCF9o4bcNEHbVEnhSgSMwD3bFsz68KZL7OZhu9ejN6aNbE1Y2jXkCKqPc35fgvbwNPBRt6aPNq86b/ui0CIQNHigKpWz9QN7AktnCRrPlCFvGIB3EF1+Rac+MzxQeSHaOFLWB0naEfYH+o0UKvDQRI33hHv/u1prpinCdlWbTDerlsIld2CLijFPTbEb6FZzkjVQJNLJI8ki2ppwWBAgypdh4Uv4E3Om6d6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzWIsXlhtAHSf/NujWzoqu8vNUbg+zCspworSEi2iXU=;
 b=d7SOkGudd0DKcZM9Ah6dpKObwpYwi2lIJTEMokkgG7tcW6y+FGYAzsBZiiie8RmSGeut1ZlcuW1ocGqL38ofmdktIFAeBz/NyXBVlKwaqv5/2qohlU+NojYUWt+E5EDPthkW1S7AEiqpY+o+BkoOMBJ+okG/MalRPBOmESxno8luCE7RM2oSakKq2NVS/DaiORRgPsWTi5eL0cbOM0e7uu1SOJA4q3iZcJK8rSE8IpxkkuOmac5OzWLyi/P5LOs1ehgJkT9iOzCAfPOHzdRYi7E2IMCWTeXUZdbiFhyz22KhFCMZIVkn6LOkeYi/B+3cKa9AcP0IVI+MUEY3NhNEbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB8860.namprd12.prod.outlook.com (2603:10b6:806:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 13:57:42 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 13:57:42 +0000
Date: Tue, 10 Dec 2024 09:57:40 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
	kevin.tian@intel.com, eric.auger@redhat.com, nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	vasant.hegde@amd.com, will@kernel.org
Subject: Re: [PATCH] iommufd: Deal with IOMMU_HWPT_FAULT_ID_VALID in iommufd
 core
Message-ID: <20241210135740.GH2347147@nvidia.com>
References: <20241207120108.5640-1-yi.l.liu@intel.com>
 <b1e8ad5e-e149-4502-8242-b971ac1d4eff@linux.intel.com>
 <3f9e3172-dffb-449d-8bd5-23f9cb2de73a@intel.com>
 <20241209150514.GD2347147@nvidia.com>
 <95a85b9b-a17b-4df5-a1ac-7a0880950960@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95a85b9b-a17b-4df5-a1ac-7a0880950960@intel.com>
X-ClientProxiedBy: BN9PR03CA0809.namprd03.prod.outlook.com
 (2603:10b6:408:13f::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7a24b0-e1a1-47cd-4812-08dd19229d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yzvTH4ZPSMnTYQBslS3K5lqeUB7lP+eEPhOTkdpY908A34/VvSatfrtLouiC?=
 =?us-ascii?Q?xNrUM+rWRjNpfv+Bvb0macfTif9tAczPCbq5fQdzJWnSTnx/Wi/ITmmx+Wwn?=
 =?us-ascii?Q?pa9hHewMJTWskyIBK+0kzytVqViJOEhYg9y2PJNdDh51EkWuekWlrjoHCUDo?=
 =?us-ascii?Q?d2zXNoK3fMdDm5Fqeyp5Z+zlkhu5pchISHclC7edTyv7ykl5CVNIiPrB7uBR?=
 =?us-ascii?Q?Up+rf96NXA3uyvIzFphs6/x9GF0X/EVZbVd+iBCOK+Uok0UBf8cbiSlz/EWm?=
 =?us-ascii?Q?CfQwxVVpAww0hdYfFyIpaMn+y4Jq3bFcMOoEAx2R8fqgetn/FSaK9kMwrkki?=
 =?us-ascii?Q?uLqL3lmhjhsrFqDQILaraATxl6AVfrscBfgg+SJxXAvrhDBsEwBdHIes4I2N?=
 =?us-ascii?Q?BlmrDJSYjJDq0RiLTC1+hwaEZxSXQJBmq3gsYwHLxFeDlL8YAPHFcswIq9z5?=
 =?us-ascii?Q?jk1gwWvgvgMFgy1mUZXzQ/BCs3tMjxkFc9gXBFmf0WUup/MiTavjt0a+RGGN?=
 =?us-ascii?Q?E+5KbRfEN9Omoy5+wWCFBDBuLFmdelu7uDjxE9bqL18hGehXO5Od65IXBBU5?=
 =?us-ascii?Q?TeybDPA+e2HNDM1UNd9ljum+lqxGDNWb1VEFbkJe+QguKBVGt9h25eygSHaO?=
 =?us-ascii?Q?8DyDXsidiBVbnBvZyEpHkTNLr+7bPy41Gi/H5Kf/EyI5F9CEBYpJbu+dTkwo?=
 =?us-ascii?Q?82TYLZdNkOCpNOkoa79XjjcjqUtttyjWZZc2vX7GKrRRplan9/L6wLa7IF4/?=
 =?us-ascii?Q?R2L4uFVRPqFBmEXzt7mVqCr9npDxv4La2T53yj6ZnI76mMkAr/8xcvqSJ9Il?=
 =?us-ascii?Q?6TAAA/GYmIDtAtqyLop2WEly7dqYfth3Gj2Bp9MrTbiMr7ps8XHZBm6CnZ/+?=
 =?us-ascii?Q?kbgZM6p/Uu9LuD3mgLdkmjCiLOsLcYpMJrgx+jEMRhj8XWXc0tY1cBEkSpRX?=
 =?us-ascii?Q?E+qRudLLCkp2gcNsDGT/bKZ09/dbDLxMYKhH7+CxTCkP6huPmSlcXBE9qoaf?=
 =?us-ascii?Q?Co1DWumrYmdbLEE47eZwbnmSTM3iyrS6hBx0gTYhSzzetFiZwo8Uwx+VzRJo?=
 =?us-ascii?Q?MA6Wf3/01oaXZpWhsZdyOEJHdeRGz6DsyWTr5sfY9WeItYXwGdrQp+agz80C?=
 =?us-ascii?Q?BOWwPh0u+N8/DOeAuJdmJb6fZNqoT84ESaK90j05Nqhf+AVR1ZpSOwcXhiAE?=
 =?us-ascii?Q?zZAVNwPAlCIKZT5dMmCRMK6NdJPowwJVAxIspDITWaKk3kkeNqJTvbEr4Hbn?=
 =?us-ascii?Q?ws3X4pSi/bRWwwy/8utJch4M6ZDDte5mv7Edrxq1/XQzA4GlhlCYrmdIZPlB?=
 =?us-ascii?Q?AIXqbJB4BGSELsSBKibVNcAVeFg+GitVOrD5uo0f6ZnwHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YbMjERbrn3rxEfvcU46dDfB/633zCOBDKxfC7ACapUjbj7ZHTjK1UTn9ANv2?=
 =?us-ascii?Q?zw5iOdIWApsuew9yd/M9phRGuJL/lA/v2pgiW/J8S/I3+Xc0/3zyTEhr8vLI?=
 =?us-ascii?Q?6eB6YwaCnIMqGH0zYbqUfEm0Ivq58QKvrK+Vx/fhUikwpjzoVvjrYybzlRc0?=
 =?us-ascii?Q?O2bFO3cMKEySidz+Y2JPnMOC5Ab1EFsFvZzAnbstZtVYLbywfNMNuOvUCmKX?=
 =?us-ascii?Q?mtetNy6ZGSN+cBr0JJBtOYpSVYukrfIr91CV509GEgNHSWkMhKILa4k8zu2V?=
 =?us-ascii?Q?VPGiT41VnycEWIZjaTVWpjIbRwE2Hk+OeSAlocNN+7izYqtiRJ5KDi5u9s5Q?=
 =?us-ascii?Q?2ySmtG5RO2V1p7NC6h6Z8+WLoM3q5gcZIoZUR5SmOv2HOboHivUlUXhDO7BN?=
 =?us-ascii?Q?SVPvTKXnbqTBJI0P44400q5uxgel4F6/LgHBnP4mCucjwCIpWwmNxNX5dRqQ?=
 =?us-ascii?Q?dl2rDwFNajof8n1cc9xOK0om+TFtb7BMaeYXz56LMe6VCYp+6bI0BK9J38GQ?=
 =?us-ascii?Q?QG2l2lKn2aJv2IDxRiQy8eY+51jpsV66WCTE5bufnVTargXgS8ytF7tgWydO?=
 =?us-ascii?Q?A279yoxQQ8rXK/delAQnvAYgTZ4Xgg41KUQwWEK567So7DuUuTgijFmnHiHI?=
 =?us-ascii?Q?mZ9YRIocLoYMYsNH0o3qWwlbsWpQ3xIMAoSw8PpukNtdUoC6Fkfs7AG2L/U5?=
 =?us-ascii?Q?GkwSdrEMxzpw4HaM5SvqEjfOAJjoGA17DsMoFWW9r6gVDEtph5xXXsX0H/T6?=
 =?us-ascii?Q?svbu3khJ3SQPb/vZsZClDvXDsqeQj65KEq6reVu4R35c7b+5Pe9OEG5b8sHy?=
 =?us-ascii?Q?NG1E4DErw2opGI//e8/EeJMy1cvXS5BW8+cY71p3wRdIRjJ7DiRmmM45n2LE?=
 =?us-ascii?Q?bxc4IuVg1uuYLujHIHltiQDanS+iQnX8g431y9BXFCPGbvPpNfMNm/Na/foX?=
 =?us-ascii?Q?GOGPh2YQ8JXMxYIECyfw9WSSNep0h6jvzzqIrEl+TTispnUz3m/6YK3qsnZ2?=
 =?us-ascii?Q?yxHxsZwLFgBQSNEwpJBrEp1Lt+TsF1z3tvt2XY1x/t6vCABR825LZV37QRNH?=
 =?us-ascii?Q?o3AsvKme/rJk3evg5p1h2fVplDHKsYQMxytospj4jbIIi8EOSyx5inHKMP8e?=
 =?us-ascii?Q?AeT+oZIQ9v3skx9LMefnTZpdv1s72ULAej784q4uDbEJSlHXRoSgXCJC4bOA?=
 =?us-ascii?Q?Hc3rxgEYMmBMXsQN43n6kNa/Z7UbMycBoSlWMIHbBF9gx64MHYzn/cU+Po5l?=
 =?us-ascii?Q?9WwQS9QLQNcuS1tAluWt8piBE2Jt0uqV8z2T4Y/v1AZeTmQupakQkrZefEMT?=
 =?us-ascii?Q?SUufMzOpyRQqVUL5s7xGeWPusSZr41VJHIzAD7Jg3DxpjRBXCtv4Ltieuijs?=
 =?us-ascii?Q?g7ifwd67njgeQM79M3EynK+2eWs+jmVZV522M9oyKmN4uG1rVkY8AHARYM3c?=
 =?us-ascii?Q?v4TPj7yuORynAm50AkKtS5q0eCgbkuFmb3CVQgPRb5qIK+p5KeCmIZaHC4+k?=
 =?us-ascii?Q?93CHAZlgnCcPlYjfuQP2Z0Cxm8vWSiR56TWcSgI9+8LqvxlJ7WLRn7FmlQ4d?=
 =?us-ascii?Q?ZkWqpgcar8DOxNmIh7lA0HYEbGGXaBAa2IVv/dQ7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7a24b0-e1a1-47cd-4812-08dd19229d71
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 13:57:41.9128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5egNnJ8UeJBT8U1k6gPfi8AfHZkiO3715bjXSd6NMslCpD52sWLyIqM4S7bsPoEk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8860

On Tue, Dec 10, 2024 at 01:52:28PM +0800, Yi Liu wrote:
> On 2024/12/9 23:05, Jason Gunthorpe wrote:
> > On Mon, Dec 09, 2024 at 10:51:51AM +0800, Yi Liu wrote:
> > > On 2024/12/9 09:08, Baolu Lu wrote:
> > > > On 12/7/24 20:01, Yi Liu wrote:
> > > > > IOMMU_HWPT_FAULT_ID_VALID is used to mark if the fault_id field of
> > > > > iommu_hwp_alloc is valid or not. As the fault_id field is handled in
> > > > > the iommufd core, so it makes sense to sanitize the
> > > > > IOMMU_HWPT_FAULT_ID_VALID flag in the iommufd core, and mask it out
> > > > > before passing the user flags to the iommu drivers.
> > > > 
> > > > Is it a valid use case for an iommu driver to intercept the
> > > > IOMMU_HWPT_FAULT_ID_VALID flag as an indication that user space requests
> > > > an iopf-capable domain?
> > 
> > For now we have no use case, so we can drop it from drivers, I think.
> > 
> > PRI support or not is decided when the domain is attached based on the
> > fault_handler in the struct iommu_domain.
> 
> hmmm. It sounds reasonable. But I failed to see such checks in iommu
> drivers. 

It would not surprise me, but also we are deliberately being very lax
on fault support to allow devices with internal fault queues.

> So attaching a non-fault capable domain to a device that has
> enabled PRI can succeed. 

Yes

> But the PRQs from this device will be responded as bad PRQ.

The core code should be doing this in the fault handler when it
fails to find an appropriate domain to deliver the fault to.

Inside iommu_report_device_fault() find_fault_handler() will fail:

	if (!attach_handle->domain->iopf_handler)
		return NULL;

Which should permanently abort the PRI to the device.

> yes, iommu driver should be able to fail such attempts in attach phase.
> So I may keep this patch as it is since IOMMU_HWPT_FAULT_ID_VALID is not
> supposed to be used by iommu drivers.

It makes sense

IMHO we don't have a clear set of rules when the iommu driver should
permit a fault capable domain to be attached. We don't have any API to
tell if the device will handle faults internally or if the device
requires PRI.

A device that can do internal faults only requires ATS support from
the iommu. Otherwise you need PRI enabled at the device and PRI
support in the iommu HW.

Then there is the special ARM stall mode too..

For now I would leave this as is.

Jason
