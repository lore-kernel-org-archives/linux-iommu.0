Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFD714A089
	for <iommu@lists.linux.dev>; Tue, 21 May 2024 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716330450; cv=fail; b=VMbgpMCyBNVczL/uPl5bTF+4xjMUVBJdeja+6hPdqvxOyMuJo9WUg0yh4MaFyKKtgvrXfjIIGqF1RukWkY6bs2/9X8EG+Vpre7WvJ+eoUDxM/+/YkDZUA9x5Tr+YFSHHCC/L8ITKCkO4HYl/Cr9YnrMHegt1bceNk6DswMaGs9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716330450; c=relaxed/simple;
	bh=iOjA4Qg6gg76SC0e4uToKZ5t9dWlsWhZW85Lsb6hPA8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+fl1ECsbvN9z9u470izJJs5VkHLcY2zW+uHNRb8WEcSJw0UuvkZC6H3+4JMdo1ldJ6tT1cYV+Ud+Pmhc5TK8BUocKG8Tr4291md9TxcnezP2urCbmJpXL0x2bRQ0vxNavjI5r9Pv2br/Z2AXmydjRwPDM7GxfhSvagajkLN8nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QoSDIrC1; arc=fail smtp.client-ip=40.107.96.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QoSDIrC1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOmK3GHfL5nU+U+wXBN0N90bBHh2MBo9XdOoklCN6oI5Wg2bjpGJ9xw6lPL4rzjjvW1ndBAlB1xgWvPS/DBxmv0BLRinMtvy7tVQim5msmnU37R0HurfR4I/8PQEJJ+Ug4Wjic1LcW/ymmiseodLnrzvCZrMliCTPXDULYVSvkkJdFbRa6QA2EBCAlqL7mBOGzpNzvJC/rW6ZfZMXq5Q/Qo6Fg+zrt0VZLCfXwBjjAUmyl6ksQSP3KzMTWvFd4TVHuWknsLcqMqqQcx4GqOiSbWRt1IxR/Fo+me9Km+p4jVoPO+v+uzZm3QHTiQrrqoHZDABxL9ZxUE7MmBZnTyGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPXD2YtyBU74GRpG/IzmQd1DNNffv0XfhMCCqq74z3U=;
 b=WoGGI9kR6CKd0fikuvxHMVtKM90Hm55q0bsWX150FbEkSRo8E0VN28hAuTaEAXUrszTsO6pY4p9dxI+o7FtSsRfyFt+T2OorVvOgB1N1v3siXZRZbuYd0nha/yT1YK3fXvD+9UwzW3jMARY423rOLn4G2jwl8vmzyMhfiDcv+qLxMf/sgnxZuC3VShdIdN5B9TbYxgHNZNHbQa+sampgY4Ar+s53DzAwTnLCdRLc2JsHvmIR5GwFq0+jOwRaBijaunuZH06cYfka05k8/XmCMIKXWtAQ9iHUXTHSmcFxGnvc7I+rOMZoZBI761FVIOJHJbEXT7EBBM9MsieYuqXyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPXD2YtyBU74GRpG/IzmQd1DNNffv0XfhMCCqq74z3U=;
 b=QoSDIrC14aK+Rs7yQ3fyqs/Xl/x8HnARDFw0xOXav/SyEvI7/ZRlKbZOPXkOmzrMIog/M55RBa06QSsCmCz3n1BV7977K8d5fuSfsJ3pewCW/W7JTYOpU31YksPgsh4sPmZrFPtNE7e8kXIE9Cc+NNtMV1LeJGdNXd2yD07F2W6HilO3UKEqiznDDe+/vdBYMFTd4/LBC8XTFVaWsoNHOSbdUTapWhwQ6pvvqvSvbta/zyV6/TRaHxc8vQURoLswgN9KbUWaAOPlpBBKafAFUS3OXXlEuFgjao0JtoUrs1V44XE9e24TMEOotwC6NyHFr9UStF5Oswa+Xv/psAv0Kg==
Received: from DM6PR06CA0013.namprd06.prod.outlook.com (2603:10b6:5:120::26)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 22:27:24 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:120:cafe::d2) by DM6PR06CA0013.outlook.office365.com
 (2603:10b6:5:120::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37 via Frontend
 Transport; Tue, 21 May 2024 22:27:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 22:27:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 May
 2024 15:27:09 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 21 May
 2024 15:27:09 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 21 May 2024 15:27:04 -0700
Date: Tue, 21 May 2024 15:27:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <vasant.hegde@amd.com>,
	<jon.grimm@amd.com>, <santosh.shukla@amd.com>, <Dhaval.Giani@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Message-ID: <Zk0ftlf3f4gBaNgy@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
 <ZkDWXnPW7CaX5TtA@nvidia.com>
 <ZkGZc5dvLigXcWib@nvidia.com>
 <ZkOI8ztR1mUMJ8oe@nvidia.com>
 <ZkQW6/OAQ8MzN6Go@nvidia.com>
 <20240521182448.GN20229@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240521182448.GN20229@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|MW6PR12MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: e2264309-9905-4dff-5625-08dc79e52ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|82310400017|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ubJHmYb+kUyqE3KG1t4xu3XNWSG+ZsN6rP/pmZWaiqsLRDjNdsTs2r9+oDWs?=
 =?us-ascii?Q?PvkTf+qmfoz/5EdE6GKOnnG3ZjNnXmKoEMewPBhm73iQrccB5dzOkULw8EIG?=
 =?us-ascii?Q?yvho6+1fnltqeYymskXqzZ3CLZUwVRgnEKC+WTFwf1IK1UQvzvSKWYPBpw5u?=
 =?us-ascii?Q?36gVUL+IE2eDNer24e5WbKMF0bF7PTfJNSOIMJASkCCDF+mpzQMUjuK02EBY?=
 =?us-ascii?Q?IgvzkrNaOydFv/hV7vmeRVyRC+GpD4B+AWcC+Z/zKC58WxgZ9jgBck4R46VM?=
 =?us-ascii?Q?6X0nldHs4TIsU1hfAOIWsNgzECFtzzcFTzIQJ2A1WaJBhtR+sYJE/Zz2PHGU?=
 =?us-ascii?Q?HK8bLZiFGZHChe+BfhVVck3c31jM7bIeKnSIxQlRhRZBf/vXkRwJenXiC2aK?=
 =?us-ascii?Q?cz0YhVFRpbvp/lhNrhUb2e2gfJienBY5wH+y5ZQc9Ri7mmXdknF6yORoUy98?=
 =?us-ascii?Q?luFFHFiDLHiUoyyUXfqSnj34qJ/FaZk3tzjNo7uQ3GRC2ezhpet/83rhKGfj?=
 =?us-ascii?Q?Mxnvn5FHYU6ZA+A/F4rf3NbxRv4309BmEd7Pg2ywzu+iGQQXcmLHfPiE8Q34?=
 =?us-ascii?Q?O3OFgHW5kCBqeBqLpS2XQ2MnxO1y4v8p2G9pa3g6M/1HNvnBwl6m30ZYBAXy?=
 =?us-ascii?Q?gVZzzDidMcRj+tRKX65o7v0RFNdPvgi+HbvzRrD74omTKimQ9O69SpkxHU86?=
 =?us-ascii?Q?hqV/N2XiUTxWwtwplGGeAiFg17FP9knNFctWmw64bxLphIlmA1KwYBOJ1BFR?=
 =?us-ascii?Q?+oZGfENT4I/vcE3kl/Iv+zApqj1u9ZLeeMDJOTIe8JfMFIFlkrizCdw7e6n7?=
 =?us-ascii?Q?7JhyIII7PbGCbgv9MTBlSalsHW6lZLbo5XJmglcUMwPx5blZaf6PGLSnCBb9?=
 =?us-ascii?Q?yr/3jrn8ewMbVMYKQmbFdqAlKwgjEBEIba+seIXdf0uS/fyPnpAoGuqNdjed?=
 =?us-ascii?Q?ufqusxhp4GKJh9ULhk8rqeHGWKkdp2vwaKvE0YT/OlHCK5CgBnvvuPXFLPwm?=
 =?us-ascii?Q?hGudiEODuD25xiLljusatzDZGYOg3ajAvaqqEB+lTuaFwz+t99CiO9jAnv3+?=
 =?us-ascii?Q?0EYVSqQsVJFyh0cpMfkronZvhvJv0kyj4XpIEy1aaPTl2Br0bhPspzc19PGm?=
 =?us-ascii?Q?2DS7+RGWlDr4nLtPt1u9b2blpGqWU07W8b33Y7G2spZcuYIL7tqJEIWXSYY2?=
 =?us-ascii?Q?SfLqhMxsEXqXweMPLWkW44OTbiRWunSz5Co/ThLAVfDjk5pEX+UFaz1YNKhw?=
 =?us-ascii?Q?793jXWEq6otSpKnfmuX26WFy8vKRnfONqDsEoseCOXlzuFovIXUnQ/yfT1MI?=
 =?us-ascii?Q?wD6WGHBKO2nAnUzHkFEgvu6vClQ/BbeX6RMYwXKmIeHU+kvIziwmvtcha3o6?=
 =?us-ascii?Q?pgyZXXFPJXhCgpbgDfgVMNdnBm4p?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(7416005)(82310400017)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 22:27:23.7234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2264309-9905-4dff-5625-08dc79e52ff9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835

On Tue, May 21, 2024 at 03:24:48PM -0300, Jason Gunthorpe wrote:
> On Tue, May 14, 2024 at 06:59:07PM -0700, Nicolin Chen wrote:
> > So, you want a proxy S1 domain for a device to attach, in case
> > of a stage-2 only setup, because an S2 domain will no longer has
> > a VMID, since it's shared among viommus. In the SMMU driver case,
> > an arm_smmu_domain won't have an smmu pointer, so a device can't
> > attach to an S2 domain but always an nested S1 domain, right?
> 
> That seems like a simple solution to the VMID lifetime, but it means
> the kernel has to decode more types of vSTE.

Yea. For vSTE=abort, likely we need a nested block domain too?

> > > Functionally we could use that global nesting domain
> > > to deliver the DEV_INVALIDATE too.
> > 
> > If my narrative above is correct, the device is actually still
> > attached to S2 domain via a proxy nested S1 domain. What cache
> > do we need to invalidate except S2 mappings in this case?
> 
> qemu needs a reliable place to send the invalidation commands to (ie
> what ID to provide).
> 
> If we add IOMMU_VIOMMU_INVALIDATE then the ID is the viommu id.
> 
> If we enhance IOMMU_HWPT_INVALIDATE then the ID is the identity
> nesting domain.
> 
> Either case leads to the viommu object in the kernel.

Ooohh! I didn't connect the dots this far. Yes. This turns the
IOMMU_HWPT_INVALIDATE back to the very first version supporting
device cache flush. Though using IOMMU_HWPT_INVALIDATE feels a
bit rule breaking now since it assumes the nested HWPT keeps a
vdev_id lookup table somewhere in its associates...

> I don't know if there is merit one way or the other. A more specific
> API surface is nice, but the two APIs are completely duplicating.
> 
> So maybe:
> 
> #define IOMMU_VIOMMU_INVALIDATE IOMMU_HWPT_INVALIDATE
> 
> As documentation and have the kernel just detect based on the type of
> the passed ID?

Yea, the only difference is viommu_id v.s. hwpt_id that we can
document.

Then in this case, we have two mostly identical uAPIs for the
SMMU driver to use. Should we implement both?

> > > > So again, yes, it makes sense to me that we move viommu and the
> > > > set_dev_id to the nested series, and then drop DEV_INVALIDATE.
> > > 
> > > I would like to do this bit by bit. viommu is a big series on its own.
> > > 
> > > DEV_INVALIDATE is fine, it just can't do ATS invalidation.
> > 
> > I am not very sure about AMD.
> 
> AMD will need the same vRID -> pRID stuff and we want that to run on
> the VIOMMU
> 
> > Same question: any other case can we use the DEV_INVALIDATE for?
> 
> DEV_INVALIDATE was interesting before the viommu idea because
> userspace could process each invalidation command and when it reaches
> ATS it would invoke the correct DEV_INVALIDATE.

Agreed. That helped a lot in VMM dispatching the invalidation
requests.

> With viommu we expect ATS supporting drivers to support viommu and
> then to do vRID -> pRID in the other invalidation paths. In this case
> I don't see a reason to do DEV_INVALIDATE right now.

Yea. I guessed so.

> > > We can add ATS invalidation after either as an enhancement as part of
> > > adding the VIOMMU either as DEV_INVALIDATE or VIOMMU_INVALIDATE (or
> > > both)
> > 
> > Yea, maybe step by step like this:
> > 
> > Part-1 VIOMMU_ALLOC and VIOMMU_ATTACH
> > Part-2 VIOMMU_SET/UNSET_VDEV_ID
> > Part-3 VIOMMU_INVALIDATE
> > Part-4 VQUEUE_ALLOC
> > ...
> 
> So we have this stuff still open:
>  - Identity STE with PASID (part 2b)
>  - IOMMU_GET_HW_INFO (part 3)
>  - IOMMU_HWPT_ALLOC_NEST_PARENT (part 3)
>  - IOMMU_HWPT_DATA_ARM_SMMUV3 (part 3)
>  - IOMMU_HWPT_INVALIDATE_DATA_ARM_SMMUV3
>  - VIOMMU_ALLOC, VIOMMU_ATTACH
>  - VIOMMU_INVALIDATE
>  - VIOMMU_SET/UNSET_VDEV_ID
>  - VQUEUE_ALLOC / vCMDQ
> 
> I feel like IOMMU_HWPT_INVALIDATE_DATA_ARM_SMMUV3 is a reasonable fit
> to part 3. Then part 4 would be VIOMMU_ALLOC -> VIOMMU_SET/UNSET_VDEV_ID
> which brings ATS support the API.

There is some conflict at passing in viommu_id/viommu v.s. parent
hwpt_id/domain for a nested domain allocation. Do you think that
should be addressed later in VIOMMU series v.s. part3?

More specifically, I have two drafts in my viommu series:
87a659e65229 WAR: iommufd: Allow pt_it to carry viommu_id
7c5fd8f50bc9 WAR pass in viommu pointer to domain_alloc_user op

I know that these two only make sense with VIOMMU_ALOC. Yet, will
there be a problem, if we establish nested domain allocation with
parent domain/hwpt by part3, in the uAPI, and then change later?
Will we end up with supporting two for backward compatibility?

> vCMDQ hypervisor support would sit on top of that with just VQUEUE?

Yea.

Thanks
Nicolin
