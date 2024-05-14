Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E4617BB2F
	for <iommu@lists.linux.dev>; Tue, 14 May 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702153; cv=fail; b=RFVb++XItGnpTt0JtvotJR9HEfTm/rdgctlvubUY+IM/1NIg+iDUHBSlqk3Lb6vw5azmpUdw8UJ1tzHI/eYGzU9lLf/BcVRjOpWAbJErYZ2Ufbq7TixhCA87NflR035RLIRxl3pcJ69WiYo9TYvtfu8YszJKlQNsbA6j9KjPWQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702153; c=relaxed/simple;
	bh=3nBThtrBudjvH4UTjqrwL7na19hBN3q+DMmPlorzlJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U67YV3iyOhph7Hmvkz8JbrSXRxur/jGwgPBw9iWP+oyqXznzXFWOuGpNYmVTMWJviMjueFcyZbuMHnO4kws9qGMONBMIcjXUYd+Z2iVNieUJwFQYLImH6DLKSrTLPkj5Uyi36TOAX3MjjmgPyfG+6vV6Mf3sz3iOhngDUV0R8Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ClqQlqKr; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ClqQlqKr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyYZu6AK5UdLkBiKJL4ePhEiqKGqZDu8bTHWHqlSFLPjgef0bzHxtFbL4ZvZh8ZBGJGk5jsMjxPuoDEhsx1oIJnZkKRuA+7qPeg+xadaZkt+rs46JWCOHL91r3EyiIyhx6gBFzeG60m2X9K+/0Hd7VV4t9IOSbMOe2IieL6ycK4L5McJJafhuPjkeAe1CpMMKtaD4CRA2yMvkcSzmMWd0jp7UqkP4Lk+vIKcSejztuticLdUmGHVHw4TWPUyXDXyQRCkuoh7OJCr+R90nPsIpWpEocl0sE4YZt3WybYYyPLROTfh6T/UGOyTHA6bMBoPLRY2RVwBl/nZSWTLh0xuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+rgpoVSLRxPwbLAFXI0Tb3Dg7F5RENZrgzhOCxxohM=;
 b=WYLWpqHaEf7K77rPnqDUfNxzd2KCxwMGaA1h+QI1ZOEPg/jpEBO4kl3hQ3ftAhCQhOZxIrQzNb0vMk1aYBjVInMzjOQdFBZUoEMSDXc6CJcxC548z0I7eqC3Nl4UHyhNkkF0qO0AbCVrLlcs7osiMYy95o/Gf8cRN0H38p0xgFqDJSbkInc9ocaVvIQysns5IoxgGY7KXTx1h9j1lJvTaDYkE8BnkL353z1GVPd4S5NteoK8Y6YlsbaXZGoduwQ+Pf3NMBGyoXI2h2wJuczgl9RxfCznjjHcT2Q2QCAJkW4xLUCUg/+yt1Tk2Heakj1uwTmyUY0ouyFzIMIrQPXB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+rgpoVSLRxPwbLAFXI0Tb3Dg7F5RENZrgzhOCxxohM=;
 b=ClqQlqKrFjmITdutWyEeO/IzcUis0iy9H5fQXb93839BVOkrrJgyPsHWfZAdEE64x7oyqZUXupIDpiSgGtDtqmLupXNcUkfNa5ezyEC6E3FYe9NNGQTNspBUYwjQN0/ZsuK+XBKw3PeKCudMKhUskjjKbBGjEiW5QRP9Dzi9UbxEDGTheG5luwZqw3hYAP1Zr3ljEmx7G2PrDh46x2WCTMG/kKLB4noFHxb0ekPFGPJFQM7WLM+H7VG+tug0NclvdgSrkx8bk9r2Ae6RtIxgssrQVsL7TuEtIM/xwsnU6AoZfZ8f4zWgh3f3+z1OEgFXgJP651rpYlWZRs4BTjbArg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA1PR12MB6627.namprd12.prod.outlook.com (2603:10b6:208:3a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 15:55:47 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 15:55:47 +0000
Date: Tue, 14 May 2024 12:55:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 04/14] iommufd: Add struct iommufd_viommu and
 iommufd_viommu_ops
Message-ID: <ZkOJgvMNFaZZ06OO@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <8610498e3fc00000e78bb9cef6fac9f6a54978a4.1712978212.git.nicolinc@nvidia.com>
 <ZkDMSfd9BXmsFfb+@nvidia.com>
 <ZkGKKoHnykAdGJq6@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkGKKoHnykAdGJq6@nvidia.com>
X-ClientProxiedBy: CY5PR19CA0117.namprd19.prod.outlook.com
 (2603:10b6:930:64::18) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA1PR12MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f7b16f-ed07-4328-2b5d-08dc742e5230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Ex50EmDop4HcKRzC9stsuClBLBaOXt6bC84LIP2p3rSwq4xFL/X4VCGtmxK?=
 =?us-ascii?Q?kqyzlykp6v9T7N7x3W44YUhUNSR7UVrVE62H3K29hWahXiPANvQcF0XWvVsF?=
 =?us-ascii?Q?Gauoz8Xf0Mk5DXLCSh0lDUD11W7SC+DO+Mn9jT61hc/kPP0u+xRVyo70q8p3?=
 =?us-ascii?Q?L8I6Qhuy3h+L68AC8COg6lrpHFp6rBJAjT4JoCacNpZGrD/0orLMk3+o9PCN?=
 =?us-ascii?Q?FDhRQAhPcU0mEfeXtqNTJEAw693p0O+GUpjFmmMiVHfmo++6otZNeQjgZ63W?=
 =?us-ascii?Q?fOnGuFkkW1GgSxB7NznibgsFnsRvHpPoXteFJLXeLTJXoHpk+bXQR+HmGOYC?=
 =?us-ascii?Q?RtN3Bohlg5rJ/kzWIXNzxKM4qoAb+/wd2bxMFz6vsprCmsz4zckhjmtJ562A?=
 =?us-ascii?Q?Vfik2jWueFTwOMQGQ3NEFAEkY1GVhu+HMQEgBBBo4w/2yGROHnNtPtAYudWC?=
 =?us-ascii?Q?xdFUixIAphHz1z+itssymbMuV8YkHPg7WA9PCPmV3npjVTegDSXzOXdZD+/B?=
 =?us-ascii?Q?Q3du+4veN9j/6q278ynVH0JhfHxCUDZkAdji9G7plX83LaJ7owkGnWyNNwFp?=
 =?us-ascii?Q?bC0r/R8lBRYPhcacbi3O/M3Q6b0DmW2L/5uPSxEGYopuEdwKAL5Mchsd1GeR?=
 =?us-ascii?Q?M0ENwK4YBdqGx+TDkL2Nh7kixfSXX+/oOfcNrZo7JLvIo5J3lp9YPaUMhTE6?=
 =?us-ascii?Q?ZZGDPsTPmzgEciY7Nf5K0erlEGqh4Xm2Dwqc+Qw83/zPqKNj/byASdc6ZFNX?=
 =?us-ascii?Q?BS4Xyr2ok0C6TRD+nccOmDvpXiddB+qmah/Q+Dwys6/jFIPZXcmf7Pr75c0Y?=
 =?us-ascii?Q?7array/ZWABW0hf7GmKyUlHXTG/+lWlVemk2X/d7qtfbOUZtP4K6IobcUYdA?=
 =?us-ascii?Q?DVU6SGkGjheJa30AyWauPrtc7LusrehqbifplIlzbSQxZ/l97b2WRKmZFfPr?=
 =?us-ascii?Q?ySJ5E+hQHyHs5EX2rWxjM2FTe3XXxbVFHxIZt1CRTfB+ZQgcD8A/hAi49Y2u?=
 =?us-ascii?Q?Csbm97RxPNCSLWtRoQ3Nowmu38cFx/YkBZ+fFaLILIXiEoRKSiDDzz+KRsn7?=
 =?us-ascii?Q?/Tb1YKjuXaCtoxMgIQKb6NH20mhdCXfntlIr39dbln7TQr07+CBQTdzfSVQy?=
 =?us-ascii?Q?JASnMRtHsEqq1iIx06R2THbJQERbhM3KFESnYLCYr2GvNKD61x28GriwPmNF?=
 =?us-ascii?Q?fqgoNJU0QTcaDOUpCZ53poWbSpGFsjilg8gteA0ninVGxySGeMqg0JN0fqvZ?=
 =?us-ascii?Q?LF4PEinjL1Hs8VoayzsKdOth1JlRQNOksmsxmQRhKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oq3Gng403JboX8igfqd6F90BdWUighjFCM+X+zvPAIR5DBFErL9Ogt2cGhGQ?=
 =?us-ascii?Q?/nbIDYIZdIFK2nyAOIXdZo7CUqPdeTHjOoxGEKoUGf4K3W0LqCGNuo77XGTw?=
 =?us-ascii?Q?VFrX/qBSuT5tvbfUAZDL2UZBBAt00jWi2T7kZUDj/pr/0nFOESCe5fYkk1dP?=
 =?us-ascii?Q?HgrieYup6iN2MpgxDLDm0TXCid/iwgkM6R3axOJ2Apfk/mhQlS59ABr7s9jL?=
 =?us-ascii?Q?/INP7o8HXEcEvCTGwnDm0qpHuYiCQm4h4PB2ss9pWbXcGoohVMGPnvJDbwjH?=
 =?us-ascii?Q?MJmu/lcE8rPYpi669onQLk28yLnCy6aWZ00g7+oWNCa26mnKM3zWX2SkqTfn?=
 =?us-ascii?Q?z7J6niQ7WuF4sF7szuXAEiMZFMYBKV/E3GdsOuB9mBVIywQbm/iDT09Sl8Gy?=
 =?us-ascii?Q?+TibPmdCw4aObvuYMWj4csZ8216JRIMHh5tx2ueaLlYljBClozqbNWPNeMAK?=
 =?us-ascii?Q?WWwXc38dvpDVgGN2CfRcqdy0RkqJOJ8TTOFnkfXyLII+q0gDgUzvhAS94MTV?=
 =?us-ascii?Q?PiK9Y/Iw2YDRQztyZ6zFKxasCKs4+JLgalx/ZtKu6VJ7EnwWWAGdmx/i7STk?=
 =?us-ascii?Q?0RPSK4iz3Qyd8SJrtrUqnsDMu5afWvRor0whCh7NQ78nh9GPy/FQQCffdaZc?=
 =?us-ascii?Q?ndQLkEy17wUjVzAmweEA5FZC4hwjXIdDOJXVz8nXVIidlX3MQtjeN6ijTQs7?=
 =?us-ascii?Q?XADkEX9YwZz/c0SVBGrK1xGGPcgHws5TnJUd/ZOTHuXqS5fFCaLTuHsiewiV?=
 =?us-ascii?Q?D+OZiCZwzZs1fyMOFJqAl53JFT8terUNLMJfqfKJRs5fDbYoS3zyurGxvSWe?=
 =?us-ascii?Q?JQEEDfGJUv85UYG3eCHYBoWvITO9VIMc75XLLtVy+jhadJ+gNJy+rHg5Imnm?=
 =?us-ascii?Q?x5VQSGYcVNS/Z0wtFbWvX7yIgQAlTNxqTyIaMgpBhtjcAaCJMCyaN5wL6cKA?=
 =?us-ascii?Q?erTJUn9P44YBoNpAPURnJScFAL2HsCsbH/hnED6nfHC9L/ZON1fhuzeqHpmZ?=
 =?us-ascii?Q?i0QYBU79qcFqy4lc8IQJn7Vgrmko6GZcL2HdiFrRllCQ6tiNJ5yGwcaxL/vM?=
 =?us-ascii?Q?iwWoLI++w+yz3H1QTcgJrecHgRPHMwwL+w7zc0ABOR90JpSPhhT/ipc03GEM?=
 =?us-ascii?Q?5KM45ePw2bMnOnLnZlHLcmxIE3PiMVaMKCGMChGPd31FihI6dr0dHsWiVHAw?=
 =?us-ascii?Q?kmfeGt5NJdlqYoWKtMP5xZq7MrpXKTe4E7oq1Pgy/pExQpkQaQ0jELSzHheY?=
 =?us-ascii?Q?01Fa2uqRdVrITDhA08JSBCYkl9AY68DqK6S4RS8f6LOUB1oUTwiTZDww2yS2?=
 =?us-ascii?Q?wRsWueGAFXxMcbkM+VjzT9fS7QAU1/uF8sqLhGZoJa2rPrRt4+OpcVNaSGA0?=
 =?us-ascii?Q?2bEhiQwHSZn+Z0+9Mam7jBoO/o/WA2lFXdhiQ+zmZe0xdEbOIN5lPyPlPOtr?=
 =?us-ascii?Q?NkQt1d41tRpILxClaQ5TNFdzZxo5XfPZPyTcUNhkCyieFf8/YFolAGc4aFay?=
 =?us-ascii?Q?7NhTG20KDUg0amiBpiN1RD6qN9ikHXOEkTzi8L77e7gh03lucPoexlzoVqqj?=
 =?us-ascii?Q?11wodZunooPN5EZNrdA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f7b16f-ed07-4328-2b5d-08dc742e5230
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 15:55:47.7242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLlQeI3ajJ6EmqE4UbgRRbaJx9gQwqGWFFzjZp8mCt1pVl22SNWcCQMYY7836hN7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6627

On Sun, May 12, 2024 at 08:34:02PM -0700, Nicolin Chen wrote:
> On Sun, May 12, 2024 at 11:03:53AM -0300, Jason Gunthorpe wrote:
> > On Fri, Apr 12, 2024 at 08:47:01PM -0700, Nicolin Chen wrote:
> > > Add a new iommufd_viommu core structure to represent a vIOMMU instance in
> > > the user space, typically backed by a HW-accelerated feature of an IOMMU,
> > > e.g. NVIDIA CMDQ-Virtualization (an ARM SMMUv3 extension) and AMD Hardware
> > > Accelerated Virtualized IOMMU (vIOMMU).
> > 
> > I expect this will also be the only way to pass in an associated KVM,
> > userspace would supply the kvm when creating the viommu.
> > 
> > The tricky bit of this flow is how to manage the S2. It is necessary
> > that the S2 be linked to the viommu:
> > 
> >  1) ARM BTM requires the VMID to be shared with KVM
> >  2) AMD and others need the S2 translation because some of the HW
> >     acceleration is done inside the guest address space
> > 
> > I haven't looked closely at AMD but presumably the VIOMMU create will
> > have to install the S2 into a DID or something?
> > 
> > So we need the S2 to exist before the VIOMMU is created, but the
> > drivers are going to need some more fixing before that will fully
> > work.
> > 
> > Does the nesting domain create need the viommu as well (in place of
> > the S2 hwpt)? That feels sort of natural.
> 
> Yes, I had a similar thought initially: each viommu is backed by
> a nested IOMMU HW, and a special HW accelerator like VCMDQ could
> be treated as an extension on top of that. It might not be very
> straightforward like the current design having vintf<->viommu and
> vcmdq <-> vqueue though...

vqueue should be considered a sub object of the viommu and hold a
refcount on the viommu object for its lifetime.
 
> In that case, we can then support viommu_cache_invalidate, which
> is quite natural for SMMUv3. Yet, I recall Kevin said that VT-d
> doesn't want or need that.

Right, Intel currently doesn't need it, but I feel like everyone will
need this eventually as the fast invalidation path is quite important.

Jason
