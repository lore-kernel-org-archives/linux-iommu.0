Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE27C
	for <iommu@lists.linux.dev>; Tue,  4 Apr 2023 02:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmaXelT7IP2k49DiQNsHJa+QM6nOaiXkPUM4RrGm7Q8z5xN0HgwnPiEUmDA+lqoes6I1PTZ6DiS/2eeOkMFUtd7NWIa/kc1iGHR0EV8ouxzJ+LvCWqQIm4QaaDulxufaOtF6pB97oT67vNAGKuxU7mWu0JrU9/eHkaDpKMqh/3Kx4/y8Vtp0yNzdGwwnuy2y3sbja/xOIW7sH3aFR0VvEq6oW+7jXjarpgEP2npJNBAk0dkuyT+dYwleyOYGhfc/fv67OOKRug/BvCybhYxXA+Ek5oEwI3tbaUPccwsTAEJm2/2AFDd3QI/QYpS9CrQzM43IyCi5dzDMTwqA5R6agQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLvqy4zp45VqBsKC6ERWSlc2DapA5aa3lWFOd1nds2Y=;
 b=kuFnV5UE6bt3Ni5fdVA2lMzPqIsdYqxBbwpY5vmf4s0AIqsqtZAmLy5UMkvu7vTryFqQHqzAGWjSpPIhSoEO8X1jtV3nt+KiYezW+UX1w2toWgzZcdKen8B5TsQ/mcYpe/jfnEDQ28bVf22pah5IZnGQzqZGo0OF+oZdsAM1wQYL3cOlJ+r1750aVA6DRN63y57pxjgTK/TeyGCI8tK0ysD5ySwn6C6LBdVP0uYIAhbdCbwXbk8TDWSB1wgZpvfN7AhzJQUeMMFgMeGiHUZIbZw+Z0jADe3ew5QCfz3s3cBt8QKqiL9a2VOx/Xz1kG9KG928d01IAHR6XXUa2mEuNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLvqy4zp45VqBsKC6ERWSlc2DapA5aa3lWFOd1nds2Y=;
 b=ESA5Ph26IwLPv4nMfhzEbvDqTCWQY7XxUKzQ6V2SSsVnW47OCxBxHqlbNyWR02UEVCX2ve0H7qRwO8dYj65m/fdkgEe96goz78YRZgj55KA+uE6/5GtQJva7MQ3Us0ZxkfhtI6f2XnFzFBl9SW4RCPkbMZkg63Ysh07VKzGqlzc0R1AK2bFq4fBTNS5lY9N14coJO6Iom6mwx6gCLOCaoTEZSgfbZDGKZN9G/n96Y4SwxyANxwoQGZOuRa+/qjwSsAdGiEZQcJ8D9Tk1G7iONByhLPnzS2vkEwHgsek8I1PF6kq2XiwDL1+YsncUxWRSBWFB3h4Z0QVh3bOl4qG0ig==
Received: from BY5PR12MB4871.namprd12.prod.outlook.com (2603:10b6:a03:1d1::15)
 by IA1PR12MB6387.namprd12.prod.outlook.com (2603:10b6:208:389::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 02:47:39 +0000
Received: from BN9PR03CA0481.namprd03.prod.outlook.com (2603:10b6:408:130::6)
 by BY5PR12MB4871.namprd12.prod.outlook.com (2603:10b6:a03:1d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 02:47:35 +0000
Received: from BL02EPF000145B9.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::be) by BN9PR03CA0481.outlook.office365.com
 (2603:10b6:408:130::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 4 Apr 2023 02:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF000145B9.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35 via Frontend Transport; Tue, 4 Apr 2023 02:47:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 3 Apr 2023
 19:47:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 3 Apr 2023
 19:47:21 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 3 Apr 2023 19:47:20 -0700
Date: Mon, 3 Apr 2023 19:47:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZCuPt0PENL3wxbmi@Asurada-Nvidia>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <BN9PR11MB5276B2F0CA8D14C0C07CB5EF8C929@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZCrizNMduHUgsg6a@Asurada-Nvidia>
 <BN9PR11MB527677A2CE0BA99AABE4FA928C939@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527677A2CE0BA99AABE4FA928C939@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	BL02EPF000145B9:EE_|BY5PR12MB4871:EE_|IA1PR12MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: ce189837-c2b2-4198-fbf1-08db34b6f1fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pt7f4WYhSVEl8knZV2flNA/M/CV4Xoyd6xi2GvDXk4hwgkN/8gRAx8mDMR1iKaNNuFr69XxdOZO7KIWTU32bxDrtylrRjUa7sFzM9/2t4gQICNkJgKwAwnbsuISlt0dhJnQaZ5OGD7I3498yK7NMnf6dhRgEEq/vgnL70D77arxlGnoBE3Tpf9N5xS1L3f1i3EFF1pCTc0pR1Cj92PkX34wL1xH5NAltKF40m8rmffQpDNRqQZVAAHrqSjDVDlVaq8WF87tzSYkdRAmtE6eYOm+9E1hcYCimY5mnyKZusRL5ZHbyL7BFVTCJGgBYywW1u+RpEgI/X3S/HY6CQ2t3fO+14y2cqiKUQ7CMKAO9LWozpQ+4NBaJV2cookTIIGCPgy4Jlqei10fHl25Qbc0mkVpMGfTaHdOJSVoCenaumoYq1k8fDXGbToP3EIeDczIRKXsC4/f6TBEtCtdtcpF6/5aHFiYCiQZowVZhRR8S9tWxg0nksjv+og5gUYwgZPXxg8oHGTQJSYCgrSnQVsHfM5D15WLHOtX8MMLDnXmYhlx5qDur7LMTRmw+cYUWRlghZJ++OFVW3W0z2bECVBql9yf+c1Z7SiFVtFEwfZCaYSoMFLAj2KQysexjcUjyRj3PLzmmIwjxe08VpqS+BRiR9sbfSROeSWvBvmN/ML4PHHFCgm9AdgP0kBNv7Tq8+XFX4x2T/fxDW/vUWtCANJfKZvhKphGC5g0QgjCxEmMZNYDVed+qAipP3MXVSNKmTJOu
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(9686003)(54906003)(316002)(26005)(478600001)(36860700001)(336012)(426003)(47076005)(82740400003)(186003)(70586007)(70206006)(8676002)(4326008)(6916009)(86362001)(7636003)(356005)(41300700001)(5660300002)(2906002)(40460700003)(8936002)(33716001)(40480700001)(55016003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 02:47:34.9384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce189837-c2b2-4198-fbf1-08db34b6f1fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF000145B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6387

On Tue, Apr 04, 2023 at 02:15:38AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Monday, April 3, 2023 10:30 PM
> >
> > On Mon, Apr 03, 2023 at 08:00:12AM +0000, Tian, Kevin wrote:
> > > External email: Use caution opening links or attachments
> > >
> > >
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Monday, April 3, 2023 8:34 AM
> > > >
> > > > The new set_rid/unset_rid ioctls and the mmap interface would be
> > > > essential for VCMDQ support that we'd like to achieve at the end
> > > > of this journey. So, personally I'd like to see it can be used at
> > > > this stage, by the generic SMMUv3 (and potentially VT-d) too.
> > > >
> > >
> > > We talked earlier that there could be multiple VCMDQ's when the
> > > guest is assigned multiple devices behind different SMMU's. How
> > > does the mmap interface per iommufd work in that scenario?
> >
> > Trying to documenting that each IOMMUFD object can possibly have
> > a shared page, the mmap interface takes the index of an IOMMUFD
> > object ID. So, either a pt_id(S1) or a dev_id should be able to
> > identify which physical SMMU, I think.
> 
> Are all allowed cmds in VCMDQ per hwpt? If not then building the
> mmap interface per hwpt object is not correct. We may want explicit
> VCMDQ object in that case.

One VCMDQ HW per SMMU instance. So all HWPTs that are created
by devices behind the same SMMU instance share the same VCMDQ
HW. Each VCMDQ HW can also allocate multiple queues that don't
necessarily tie to any HWPT either.

> and devices behind different SMMU's may be attached to a same
> hwpt. In that case the number of VCMDQ associated to a hwpt is
> also dynamic.

Unless two HWPTs share the same S1 Context Table, how can two
devices behind different SMMUs attach to the same HWPT? And,
it doesn't sound very plausible to share the same S1 Context
Table between two devices either?

> But if just talking about batching for emulated smmu then having
> the user to pass a big buffer makes more sense.

OK. That's in align with Jason's suggestion, passing a queue
buffer via the ioctl.

> > > and looks this is different from the requirement of having a
> > > software short path in kernel to reduce the invalidation overhead
> > > for emulated vIOMMUs. In this case the invalidation queue is
> > > in guest memory then instead we want a registration cmd here.
> >
> > Yes for the first part. There are certain difficulties of doing
> > a short path, such as host kernel replacing the host queue that
> > the actual HW ran on, with a guest TLBI queue. So, my draft is
> > more about batching.
> >
> > For the last part, what's that "registration cmd" to do? In my
> > draft, the hypervisor dispatch all invalidation commands to the
> > guest TLBI queue (or call it user queue), which is transparent
> > to the guest OS.
> >
> 
> registration means the user to pass the buffer to the kernel.
> 
> If we want to support kernel short path, then we want the host
> smmu driver to directly read cmd out of guest TLBI queue.

I expect the mmap approach can go a bit further for an SMMU
that has ECMDQ capability (multi CMDQs): it could load the
guest TLBI queue without copying that buffer and inserting
into the host queue, by allocating a separate cmdq object
in the SMMU driver and mmap'ing its cmdq->q.base to QEMU.

Thanks
Nicolin
