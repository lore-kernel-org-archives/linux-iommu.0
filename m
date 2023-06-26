Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C99F13AC5
	for <iommu@lists.linux.dev>; Mon, 26 Jun 2023 18:02:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDFIOhBIM8yPc/HgwU/lzqW88WJkMXtaJ8l34n8tDCWhAFhnlF2lWLnTXYIP9wOZ8LbK2qERWCTmfZ+mdm44AHpRBIptmAfHIR01Ol71kAXK8ySVy2cjL8o01n+gRFTCLrNmEiPJsl8q7YrQ/oUa6cgeU7FKwh1Bg095m1gi6SV7Z5XXz30SdwFheLOxZwl5gujGML9Py9yBUt/2Ka2fQALXic6YDlVqhXhcabcQG4aZ/DfDhbFKWht/eBgsmpnDT/YvJXWWelB76XpSVLSsDsUOpksT+gZKiprO6QcFsmRJnaPgUe32uacoPDc4FmvoXNbJ6iQTR+ytqFAd8eqYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CR2wxA1Y9ehxpAAWVAhcQphkpweUdhK/cRO1HmtEDvw=;
 b=kYRxc5ew2WADNBoBlLlqjRMuLUlNm7TITl1h6Enac+2MC6JY4lrgEYkp6nX7n/Wy6oieVF41gOf6G00b6RRSGUw9bhe4xKPel6itkw0TONKJz4zDi6bIbKEFaa4okGMfplyFdjf/hgREZatGkzD3MElBIvFtR8bTLFU1jLJZWhEDfUI0eOLdfddW6Mt/Qb/RWC+VQ95N/B5isrzYR4Cz5FbETlGs70lPhy0Rh+Oye51T+FmdCM67/M/veNJGFzav0505amxw1umsmp8c1ZBzt9YETTLPLT8u1kg17FSBljZX+faMUW64QUXyZzlp97VNyBp8OWQewxLYkZJLx/q7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR2wxA1Y9ehxpAAWVAhcQphkpweUdhK/cRO1HmtEDvw=;
 b=qOy8LOrGdm6Kwo2Cx9sjwgqYyKZWH5uMYcAk6NFJ3/fOCm8LHRqbqLvLA6nUxSVn/fDRgP2hrf6LJptF/875+ySEQ+gwkk9MPfxC+2gv8Gg1iscLdWtADfKZT60itmO6KmBzMBKQN9YglXTQO0CfOSIqJrFtU6JAAaiB5mtrE/QV+/pwX4Y5asKxMv2rc8zGrRqMyJL2p27Jcve0oHe7RoKlim6Gs6wtfjevjTmabmJTrmjQ2ywTEgVv3C2pqxDLoITf+e0N3aIGym47+ZbpD9Ety8VUydFIrk3usSd/Ue2F+7TVbMbjbIBvM8QVfWBYDvNS30M6RkawEzlofZ4S3g==
Received: from DS7PR03CA0107.namprd03.prod.outlook.com (2603:10b6:5:3b7::22)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 18:02:18 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::5b) by DS7PR03CA0107.outlook.office365.com
 (2603:10b6:5:3b7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 18:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 18:02:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 26 Jun 2023
 11:02:08 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 26 Jun
 2023 11:02:08 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 26 Jun 2023 11:02:07 -0700
Date: Mon, 26 Jun 2023 11:02:06 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, "Joerg
 Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, "Yi
 Liu" <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
	<virtualization@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
Message-ID: <ZJnSnuUkkwBVNT80@Asurada-Nvidia>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <ZHZFi28jRxeZMKK3@Asurada-Nvidia>
 <a8ccbac8-c456-d116-24a2-7503ccbb720c@linux.intel.com>
 <ZJiTuO/9Bs4hMAiC@Asurada-Nvidia>
 <e374e0be-3e29-3128-b3df-6183a7a0e98e@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e374e0be-3e29-3128-b3df-6183a7a0e98e@linux.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|DM4PR12MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b20981-70c7-4eb0-af24-08db766f7afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e/Fw3U4jRcI+NKSg1aiXMxRF2lkrNp8kvetqY6QFWhavfM5ibDufyhnTJFXt5mnKeUupGumBRIPL1KlT2wQ7xZ5JvF9K4X2aI+YaQ+a0cc/I9qxFfAn0qHjYfwDWESTvSjDcPgrt5xqSqnFOvo84gThe0nu4RAlIWsg91ec3nXhB2B3qebLVEA+ON/6hCzB4tUuLB1bg6+UxAqjoOXVPSNyvnScl/7JbFBQr7iJiCb8p3ynOMl5JaeHzGwc3HCXfH614/8TMsJfPfoJawHZ1+8H2Meq8m4pMsq2rDH4L219SOduuxfOJcbfwEfvE4dAYCHgOd1HWJBIGEEd8y9N0ILPyHMO3Ys1ZN7QBaTO3KkPAODt/q9ZG/RWkm1ABvAIxCMbzuWfvijkX7xEg4Ewl+CVTh6CjxcXGw4Ftnnd5ssYncvjcND0xwGlDAO8F+xGw0Z/ET1IRbFSoOgc5kMeff+tYgsNGJhAozTBy2jtY2FbJN7wfEHir+/AY814PFUhPEw6ZrSWyjOW6jhNLc6sRaZORoKTUYlkJ+S2NUQV3krppMk5vAiY1OXANwxYLyzgm9HnYZZnpkmavBGKjlrDEgdTpVhm7AaKTHvplcx0FXcXC94gMW8wlUyR7tdhoP7KgTkH879eECgfIFS/bCU7+qHaPyHYXNWywYVo2forhQSiVm5fBNE5QDAit2/OIhhRIsTq+Eu9eft51MwSW4A67KMeOod8S2Vg/pOG4Ggc8efeCYfYJ7Wel2LZFjQzz2nDd
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(36860700001)(47076005)(54906003)(478600001)(336012)(83380400001)(426003)(186003)(26005)(2906002)(9686003)(5660300002)(7416002)(33716001)(70206006)(40460700003)(356005)(316002)(70586007)(7636003)(82740400003)(40480700001)(55016003)(8936002)(8676002)(41300700001)(6916009)(86362001)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 18:02:17.8256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b20981-70c7-4eb0-af24-08db766f7afb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565

On Mon, Jun 26, 2023 at 11:10:22AM +0800, Baolu Lu wrote:

> > > > I think that, whether the guest has an IOPF capability or not,
> > > > the host should always forward any stage-1 fault/error back to
> > > > the guest. Yet, the implementation of this series builds with
> > > > the IOPF framework that doesn't report IOMMU_FAULT_DMA_UNRECOV.
> > > > 
> > > > And I have my doubt at the using the IOPF framework with that
> > > > IOMMU_PAGE_RESP_ASYNC flag: using the IOPF framework is for
> > > > its bottom half workqueue, because a page response could take
> > > > a long cycle. But adding that flag feels like we don't really
> > > > need the bottom half workqueue, i.e. losing the point of using
> > > > the IOPF framework, IMHO.
> > > > 
> > > > Combining the two facts above, I wonder if we really need to
> > > > go through the IOPF framework; can't we just register a user
> > > > fault handler in the iommufd directly upon a valid event_fd?
> > > Agreed. We should avoid workqueue in sva iopf framework. Perhaps we
> > > could go ahead with below code? It will be registered to device with
> > > iommu_register_device_fault_handler() in IOMMU_DEV_FEAT_IOPF enabling
> > > path. Un-registering in the disable path of cause.
> > Well, for a virtualization use case, I still think it's should
> > be registered in iommufd.
> 
> Emm.. you suggest iommufd calls iommu_register_device_fault_handler() to
> register its own page fault handler, right?
> 
> I have a different opinion, iommu_register_device_fault_handler() is
> called to register a fault handler for a device. It should be called
> or initiated by a device driver. The iommufd only needs to install a
> per-domain io page fault handler.
> 
> I am considering a use case on Intel platform. Perhaps it's similar
> on other platforms. An SIOV-capable device can support host SVA and
> assigning mediated devices to user space at the same time. Both host
> SVA and mediated devices require IOPF. So there will be multiple places
> where a page fault handler needs to be registered.

Okay, the narrative makes sense to me. I was more thinking of
the nesting case. The iommu_register_device_fault_handler() is
registered per device, as its name implies, while the handler
probably should be slightly different by the attaching domain.

It seems that your io_pgfault_handler() in the previous email
can potentially handle this, i.e. a IOMMU_DOMAIN_NESTED could
set domain->iopf_handler to forward DMA faults to user space.
We just need to make sure this pathway would be unconditional
at the handler registration and fault->type.

> > Having a device without an IOPF/PRI
> > capability, a guest OS should receive some faults too, if that
> > device causes a translation failure.
> 
> Yes. DMA faults are also a consideration. But I would like to have it
> supported in a separated series. As I explained in the previous reply,
> we also need to consider the software nested translation case.

I see.

Thanks
Nic
