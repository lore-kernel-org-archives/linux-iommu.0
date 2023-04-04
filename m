Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C2D7C
	for <iommu@lists.linux.dev>; Tue,  4 Apr 2023 03:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nu/QT1UmV18DquHLwKUq5/u9ga6NDAXe64ZNJzADwlWMVbCqVviQ3l4W6bKvsC8dcAUiy6gZGHXc77qSBBsjanu/T2AvepxnQh2Fzew/9L1vdfbTMFYpoIeT4EnXUPgn5XXnUKSvTwgZV4rUZq2GsE66koN4WAt/6qC1henX8GHIbxe0UxeLr9fJGPC16GukiX6SwNSZnuuhJ66HQPYaq0zjhV+BB4RSNBV+wXDKJYGiVsmLxrB0D3pBSmnB5sUeemwZUL4P6ZgrdjZ/adfcOW03CZ0+Fe0AJPxEFjz+3LXMG3jBF/JlLxXTfIaJB7wAinZll1aVLJjcu5tg46sZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgErkixcCralBRdmYZ9u6mngyWXqGWAhq3FuYHcA+ro=;
 b=GUCM9P3vzSeEOKPOCTE6PkWKQ+lf0iUDL9XgFVa+rNLZV7GHsy/YY23wtPKXiRS6JgFpwaPtfIMWk/uWuXA72meU9es5SWx6J9ymFmnei7ujchHreQQt01iLMAdZLeT05J3u/4OoddeeXFzCvzRJ46Se1ZOwWRemNzb0oZ46UuEw7Vl+dFvk8emS0rERgVF8VxPxOapjiDLEDvnrk56erjYqYOf2pcjAg/0hFj2vn75VPjCn67nJne+msA2uX67Mkfi1cVnXhFClH+GDEVMJ0B18vSi03xI6kUUwmIwzhRdlOFz/q0D6C+CKoKyQ2X5bRJpmSx65SyhgmoIsHFlG2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgErkixcCralBRdmYZ9u6mngyWXqGWAhq3FuYHcA+ro=;
 b=YJ4FMKOGMWhWrzh/9E2xcdnzNyz5u6Qlof7pRnPfvjGoUNNKJUlAw/sxv0woDgOIr37JuAuC5Z2K5spSknNpB0SCkCGH9XkedND6ELicxCDepXZbGVj+wVOUDoW6RUK5+Gr96e0KnTW7R0qUcnaYAlJYD0jd74xatKgjpJqGCQIeKgzjMAzlSwMx8S2bQufdOAlSqXIHv19eAtyBTA/N7btyGY5FP1LrofGwbkjSNuf8YlKOErXIGev8ZgBpe/sjedt01LT4Vktfoh+MDEBQ+bxIvmNJU6UcUfo03kSI2R/6wTEEyZZ5CFP0sQNzugsxbJ1SFSjsZGIMMILUNtD0xQ==
Received: from CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12)
 by SA3PR12MB7921.namprd12.prod.outlook.com (2603:10b6:806:31c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 03:12:17 +0000
Received: from MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::30)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 03:12:13 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::94) by MW4P221CA0025.outlook.office365.com
 (2603:10b6:303:8b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Tue, 4 Apr 2023 03:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.26 via Frontend Transport; Tue, 4 Apr 2023 03:12:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 3 Apr 2023
 20:12:03 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 3 Apr 2023
 20:12:03 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 3 Apr 2023 20:12:02 -0700
Date: Mon, 3 Apr 2023 20:12:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Robin Murphy <robin.murphy@arm.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"peterx@redhat.com" <peterx@redhat.com>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZCuVgAr+TgMzKGCL@Asurada-Nvidia>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <DS0PR11MB7529BD4A1AE9E75E1408DA4BC3929@DS0PR11MB7529.namprd11.prod.outlook.com>
 <BN9PR11MB5276462BC1879715BC15380F8C929@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZCrvpFqrUZH/9pYI@Asurada-Nvidia>
 <BN9PR11MB52762C62287D78086CBEA1238C939@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52762C62287D78086CBEA1238C939@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	CO1NAM11FT014:EE_|CY5PR12MB6034:EE_|SA3PR12MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 02cb8630-bbc8-4c3e-31f6-08db34ba632c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0Hthn0/R5jDxRrFxis9qEciyutHJ+0cVG5WJ9ZtOmfEj9JWhAUw/ftMs+33jQ8tSPR5Zg0nBETTdOibNHEN02pSqcg2HBvhvR4SDW2SKJAK8IxXhcIxMOboHAPGvKW0QWJZyMMTNXRYs0zwjfFjmsSTLn7KsCBpHk5/jaIvnZbL5jTsYQVOWwfguSI/cpgicOWOVEr8Bsiuov2vael8Ew7/QWlFJqmgyUoA5mDZTc1L+Ayj/MzbIiA3vzsTxfQ5vxFtCIkhiVGaR+APtLcpjPFDUiGJHS3zSxjvqO41c4YIW+sL/uS8OVvewgZoN3+CE8vBv1mqyD1HfQO57L/dyNfcZtqir1aDSWIBux99zJ7/A2who4Xf8CeAE7gffSkfi08KxeuZdBC1BrXx8lEjUQpoBZiJLMZmXvzqmQAWm6X4k1cgHPoRbqayE3Z3ETKkv73l3DdaP2kgdUZjid5F+CWJa71khuoFIBTppL/0dJyCMa1F+qmr1yLKsQp5u5St7aZuQ5z6dvirJqZ6vhx4sDi0b3i000BMY+zeJDdCMcGQlFTLRcY5XpPQkaDLgIh4wBCtsgObZkAbPr1sdrHAE1/qdGw3GPxPCCeQF4wh0fnLtsV3QsN/hIPb86bHOIMaFnoEaXTM6os8DSXTWYvVfBJmD8/Dk3alO/KklTgo7uOhhLCabCqfw69tFGH/1Auyy8bd+aKkKadgjXWpM0gSCvltiwa0b1kQoKf71nZjUV8q2hhxAnodUYNypSg/EklD90Jzek7Lb9KScj4eLEXg12g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(83380400001)(82740400003)(8676002)(4326008)(6916009)(70206006)(70586007)(47076005)(86362001)(316002)(2906002)(356005)(41300700001)(7636003)(54906003)(478600001)(33716001)(336012)(426003)(36860700001)(82310400005)(8936002)(5660300002)(9686003)(186003)(55016003)(40480700001)(26005)(40460700003)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 03:12:13.4521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cb8630-bbc8-4c3e-31f6-08db34ba632c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7921

On Tue, Apr 04, 2023 at 02:42:49AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Monday, April 3, 2023 11:24 PM
> >
> > > > VT-d side requires vPASID->pPASID and vDomain_id->pDomain_id
> > > > conversion.
> > > > vPASID conversion may be needed later as we may disable guest PASID
> > >
> > > vPASID conversion is mandatory when we enable vSVA on SIOV device.
> >
> > vPASID is allocated at runtime, so the hypercall timing is a
> > bit different than SMMU's vSID. But I think it could go with
> > this uAPI too? We'd just need to turn the uAPI to a shareable
> > one.
> 
> Not necessarily. It's clearer to be a separate cmd and format.

OK. Then set/unset_rid_user can be standalone, yet it likely
needs a better naming or so.

> > > But honestly speaking I'm hesitating to introduce native format and those
> > > assistant APIs for VT-d at this point. Supporting in-kernel short path
> > > won't happen in short term. What we defined now may not fit the
> > > requirement when it comes.
> > >
> > > With that let's continue to define a customized simple format for VT-d iotlb
> > > invalidation, plus allowing the user to batch the request. Having extra
> > > packing/unpacking overhead is negligible compared to the long invalidation
> > > path at this moment. Then we can consider native format as a 2nd
> > > supported format later when in-kernel acceleration is being worked on.
> >
> > It'd be okay to do it later for VT-d, so long as the uAPI we
> > add for SMMUv3 would potentially fit VT-d too :)
> >
> 
> Yes. btw you need decide which usage is comprehended in this design:
> 
> 1) vSMMU reads cmd from guest TLBI queue when the tail register is written
>    and then submits the cmd in a user-provided buffer to the kernel.
> 
>    This is the basic path.
> 
> 2) vSMMU reads base addr of guest TLBI queue when the start register is
>    written and registers the guest queue to the kernel. In the meantime
>    establish the protocol between kvm and smmu driver so when kvm
>    traps guest write to the tail register it directly notifies the smmu driver
>    and skips the userspace. smmu driver then directly reads cmd from guest
>    queue to handle.
> 
>    This is the in-kernel short path.
> 
> 3) with VCMDQ then vSMMU needs to mmap start/head/tail/... registers
>    of VCMDQ and allows the guest to directly access. No host intervention
>    when guest submits cmd to VCMDQ.
> 
>    This is the hw acceleration path.
> 
> I'm a bit confused in some discussions whether what you implemented
> for 1) must be forward compatible with 2) and 3). This is difficult before
> we actually start working on them. Given an iommu driver will support
> multiple formats (e.g. when vhost-iommu comes) probably we should
> more focus on the minimal necessary for what 1) actually requires now?

My draft is more of an enhanced (1) with batching, meanwhile
using a mmap interface, thinking of (3). Comparing to the (2),
it simplifies the host kernel, as QEMU could load every TLBI
command into a mmap'd buffer whenever it traps one.

Maybe (2) could be a cleaner implementation. I could try it
too.

Thanks
Nicolin
