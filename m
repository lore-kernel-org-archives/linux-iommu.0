Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820206FAA
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 14:29:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMcsL5OYkIQFg65aPZTTzidx7olzxcvCeGn7oNMV4a8iUVgtWtKicXdGNCENJYUX+4pfB1LsMEKrv544kf5sNDcObD1V3EG91it8ZxLcDHxnwslVf9CizHfeXSC+1CXrxXpxjJ4yL5rPvZKBNpy56bhv5sWKlGbC8QqTaDyFI+gpjfFInzIJPY8RQacka4yi8FLRWZqOstqZMEGC3A7Id0ovBOLJWL5LGgzTdHCI0fZPHXajwh59fzM5co3gcOxJ0pFnfJbg8o9wh9LW3MuilRv2bYnDrg+XRY0Em/x+YbS/PdT+pOop3HY3+iXfYlcuwqYvEIcuhWPm0tSSzZUeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kv4dzu4+5jrFqjjHJczLiKu/9/xt8h2lGpNPuzT4p1s=;
 b=fUu22MNdpNjiC69OlWtzL3YRVe6JDRUEOU0l0R56HKQ57BCyCGlc6Vc6MZF+3CFBZoLMhvL/Yu4jk0mJjRlt3nSA8h5dHh2dhM33fw3u2G7VV/1gT6xxijM+trSmikrcO4v2qLnjmuci0P9+5ARiv03SRazs234Mo0YNjrdQKu0bb0f7yfO4YewR6g59lG3rVRJxOD0Gqanl1fdLtuKHyVNCPtwG6W1tVb3kGKCnQfosMiChu1C+Uza2m1HUgH881nzr3DT70pJo2WtmjQRYQrxML5ofGcwIiC21MDST9+gf/zWGNeMZnwFglN4GwgLLUOCYJem1ptpoN6zjid3tjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kv4dzu4+5jrFqjjHJczLiKu/9/xt8h2lGpNPuzT4p1s=;
 b=H9zb2lI18MS1ZEtU4czqrHsjcpOFKKAdZCVjzXC/U9F9uJosT2JfxtpRr0YEnDHDmJUZdmwV+1+fP4DZMqawo24Y8Smwt1KeI1AZqrdONkjir8GuHnzIb7b2D4xO/pqWOe57a0SaF8ds76SBrOW1rFhWHBwW+lWNsL0RlBmc8DQ8nAUpRvbJlmJGaP+zwG+/yjluXqdTpxN21PQI1p1ulvlE0PZi5aFbSmjIwoILU4/VIp1dXD9fy+/HkNWQDDeR7oR16Uyi6zfxJvznKKg8TBbD/xIfngsQU/Lr3lB0ybqk52byAizl2w/oqZS5YH0VAlxCaLjRatBpuSczZy9cFw==
Received: from MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Mon, 3 Apr
 2023 14:29:53 +0000
Received: from MW4PR03CA0265.namprd03.prod.outlook.com (2603:10b6:303:b4::30)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Mon, 3 Apr
 2023 14:29:45 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::e4) by MW4PR03CA0265.outlook.office365.com
 (2603:10b6:303:b4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Mon, 3 Apr 2023 14:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.16 via Frontend Transport; Mon, 3 Apr 2023 14:29:45 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 3 Apr 2023
 07:29:35 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 3 Apr 2023
 07:29:34 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 3 Apr 2023 07:29:34 -0700
Date: Mon, 3 Apr 2023 07:29:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZCrizNMduHUgsg6a@Asurada-Nvidia>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <BN9PR11MB5276B2F0CA8D14C0C07CB5EF8C929@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B2F0CA8D14C0C07CB5EF8C929@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	CO1NAM11FT091:EE_|MN6PR12MB8472:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: ac455a3d-a53a-4087-c845-08db344fdf43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IXjxuTNRmuNWRgVp58/WX21UsN6iFFBjiBOt16BQilfnxXCWIEewVkyEnx32TlXkN/TGsuN8vmH12NMT8TxEa2yzgzPlOtALH4qYwo/rvHECQgMxzxeKjjFJUPneINilDsXPZ0gadhq8viIrhR2sWBa50rmxiHjGq3po0b6p3sGoJzXgg57cYsmChq1WN2FTpiX2HsEzdMGha6xp1ohzxqUWuU+FPptuN33nQv09NoW1p6UEaBTo+3TfMeStKdTPyDBppe+IXUFZEBfw017YCuzg5tKatL+a2FWo5MLxk2JCXVnVoUVyiHv5jZYGUuhiW93m2Z+ksPlsymqNaEelIf05KUz0lAynWefCeiSFvwFdF+9k7NugmHPoJIcY9be/trcFwrWyCOgaWMVHW0y4v+MCGD65fji9Hpuq8PVX2iQwRt602x6gHX7tEjx8WCc7Bojh5hgKnrygxUOyReuN/EU4FnynGT8cajbBsxEJKtjbsLIEFQcw44cj1bZAuRL9eUOLI06e2qq47mRMMQQ1eXfmE4bJUksqUQ2KJ6ieX1sai+KsL3YLp/bVym2CrJ5/sFh9Y7JW7hw/hGf1h9vEy+OCoo9pOS3f/mZgUqFnh69qSYIFX2Yu34cuAHXVqPa4YZxqpncft9yfId54BoHT9BEfkLG1wqFTEYo8WIM7yFQMTAt4lPbFtfNLx1IjhQ1Iu5dClU2cD37XcMWSlmXujSuZQ4MAOKRTw6vNHhGKxI8kw8QhDpAyp6NDNvDr81UzXUwzLFkuizy1xVMNhgiUfA8N50AruOgzYaNb2PmIMjQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(8676002)(356005)(70206006)(47076005)(33716001)(70586007)(7636003)(82310400005)(40460700003)(5660300002)(8936002)(41300700001)(2906002)(82740400003)(40480700001)(55016003)(86362001)(6916009)(34020700004)(336012)(4326008)(36860700001)(426003)(54906003)(26005)(316002)(478600001)(9686003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 14:29:45.4317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac455a3d-a53a-4087-c845-08db344fdf43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573

On Mon, Apr 03, 2023 at 08:00:12AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Monday, April 3, 2023 8:34 AM
> >
> > The new set_rid/unset_rid ioctls and the mmap interface would be
> > essential for VCMDQ support that we'd like to achieve at the end
> > of this journey. So, personally I'd like to see it can be used at
> > this stage, by the generic SMMUv3 (and potentially VT-d) too.
> >
> 
> We talked earlier that there could be multiple VCMDQ's when the
> guest is assigned multiple devices behind different SMMU's. How
> does the mmap interface per iommufd work in that scenario?

Trying to documenting that each IOMMUFD object can possibly have
a shared page, the mmap interface takes the index of an IOMMUFD
object ID. So, either a pt_id(S1) or a dev_id should be able to
identify which physical SMMU, I think.

> and looks this is different from the requirement of having a
> software short path in kernel to reduce the invalidation overhead
> for emulated vIOMMUs. In this case the invalidation queue is
> in guest memory then instead we want a registration cmd here.

Yes for the first part. There are certain difficulties of doing
a short path, such as host kernel replacing the host queue that
the actual HW ran on, with a guest TLBI queue. So, my draft is
more about batching.

For the last part, what's that "registration cmd" to do? In my
draft, the hypervisor dispatch all invalidation commands to the
guest TLBI queue (or call it user queue), which is transparent
to the guest OS.

Thanks
Nicolin
