Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C7E803
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 02:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QhtTA0Gi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBP75FNk89W72rV+w0gBsjmzaGEW81+pVGdm8wOJnfG7LzodLONyFATHjO537j5ajds13sHZpTPeO4XeVUP3IuTFDVkYD3f8/FjRJ9YWMCDVWKFV0T+AiuJLKhoi3rHJyoVCZy8m0ak++s1idC/GBk74Rk27qbwsq856gbx7EjPu3S0kukj4S6cGYhcXvEBl8d7CVWR+seagIM978U8Vbos5n4Wf78kSsSpRCaw0t9+4aFS2aEyyJVRC+RZincQqtG+dnspbWCwBs5tBwm0r8UvGhNxST2Fqs/N4wIpyT0tyYK0/Lc/kWkl1exlHmdHvDPTItoV4RujuKcBLro3x9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKY3H1Gy6/FymFOlYNGsT0Hoxz9QMoPmhqfg82bThFA=;
 b=aAfPXpMABbMumWkAwTNCjBl+p5egKxUkU+24MCp9l6CSACW+Fv+u5OXW+dkdxonOjgMtO14AlFMwtwn5jxDkHHR+kwOhFsndEIIMF/sWNgnbH52WAkha/bNI6ui+P0BMgsA5KHmfpVyU6qGzNsNqLIogepisFYWaDRI3w6FWCk0LAZSFYVQdfGwEgfPFjW7IO/oSEN9Y/byLO9uGG83c07Pt0YYtAJWVtxBXAmfIfagWXIG/tvMVxZET6TndFshfNbFVjUer8GVMUarK3qlhEPDJZfYaJ5k6DL77K6ZCYQ5VjPxx2i+mCKbLjJ/IzlzQxfLCii09rcFopDLIdMm72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKY3H1Gy6/FymFOlYNGsT0Hoxz9QMoPmhqfg82bThFA=;
 b=QhtTA0GiR0F/3HGZ6WuCEKfmo1NqtGMTH8LXl/cSF08dFZXLzHgAX5evrQGlTQTGgPT35qQzyIttMISc0Mnbt2o1Kh27lPtBhb6/u7kBTNrTgB5bA0pbthmaMUtjHKvafnKQ9qkwabloHj953wrkXsZccoR+qJHw2VbRSlc0XkgZEhU+o10XGVdoUfXS/vJKNJbMj2vWhsb94Le210gHa9t2oNpl3AtXTNhL0usZD3UtFiSWjDEiNLJo+QQJKNBhWgghvDvcDBSFaLQ2Z9kyuVNFmOjxk/n7M3FRbVF8wFJXFcxHOF9SE7aOEz9qjqoRtUgABunaSR29+8F7qHZfLw==
Received: from BL0PR02CA0006.namprd02.prod.outlook.com (2603:10b6:207:3c::19)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 02:46:14 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::ad) by BL0PR02CA0006.outlook.office365.com
 (2603:10b6:207:3c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Tue, 5 Dec 2023 02:46:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 02:46:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 18:46:04 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 4 Dec 2023 18:46:03 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 18:46:03 -0800
Date: Mon, 4 Dec 2023 18:46:01 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 11/19] iommu/arm-smmu-v3: Do not change the STE twice
 during arm_smmu_attach_dev()
Message-ID: <ZW6ObRW5BWbGH7RL@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <11-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <11-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9f012a-5496-4f7f-270c-08dbf53c5932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eaJpNId5G4An2U1jWduPSz/PwmCcmHEol6vviNIs5vMzPEkdCtrWyJ+NaGDD/6qb5mYYM7aYlTY3m6BiO0nZ4L6x8dLCvCkpbEXwHweQbnR/viVLX45+SPNddlfIn5wBpN7tmXiTwm6HzCbyxJNvu/3bslvspRYdiO+DHHTeNslzHaTFQ/cRtBmR5lN7daqP1KO7hv1vxlecfsMXLUanKC4IaLaq0PoIgFzHWwuxVLzlzxFOjMMosdKEQ/f+uqLTMvttX9k1dQTvVm6MxQVHlMwN2RIzFX5gybLmLg/75aXuDd2GOfcyc7Bs/vQ+4oNJvyygfjGkdclyxWVpyyiCU3ZcMmtEzBNTlp8bc65i6duuLox6ms5HJgVQA7s77LVEM8gjMw47sNbuOQn4m+sl9PmJZke1d/01qAi7CdjQ34BEsG7G/N+pVM/XTpkGfiFJ7J1BhbXneg6d4/ARriOxRUHLgigk+4OI4b15sx/jGIjPS26ETAuvQ5yB8zskoLXlsltvWMSRmPXWg2rdAv4PZpVSKFxiBJE40IFRdVhiUW6yzYUicBzsv6AGpCqKBFsSZ3VXLpyWfT4ZAlmeL3cEsFYsYyo8UAXjP2zvQfhim/sMWyPulEg4NSJ9jzoXW0fYN0+5z/x1//2Hk8//FQ80mhTgrT2e2cx/hNUwrEjV/BfqK8L16UjeH4MjDK5d0vbnnoe4XZp2ouLqAyZeYWnC+nK1Tx2hu09GM18tNmOdQVL1+Muj1kbXZ++phk8M1HTd
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(6862004)(5660300002)(40460700003)(86362001)(4326008)(8676002)(8936002)(2906002)(33716001)(41300700001)(9686003)(40480700001)(426003)(356005)(82740400003)(7636003)(83380400001)(478600001)(26005)(336012)(47076005)(36860700001)(55016003)(316002)(54906003)(6636002)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 02:46:14.4640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9f012a-5496-4f7f-270c-08dbf53c5932
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086

On Mon, Nov 13, 2023 at 01:53:18PM -0400, Jason Gunthorpe wrote:
> This was needed because the STE code required the STE to be in
> ABORT/BYPASS inorder to program a cdtable or S2 STE. Now that the STE code
> can automatically handle all transitions we can remove this step
> from the attach_dev flow.
> 
> A few small bugs exist because of this:
> 
> 1) If the core code does BLOCKED -> UNMANAGED with disable_bypass=false
>    then there will be a moment where the STE points at BYPASS. Since
>    this can be done by VFIO/IOMMUFD it is a small security race.
> 
> 2) If the core code does IDENTITY -> DMA then any IOMMU_RESV_DIRECT
>    regions will temporarily become BLOCKED. We'd like drivers to
>    work in a way that allows IOMMU_RESV_DIRECT to be continuously
>    functional during these transitions.
> 
> Make arm_smmu_release_device() put the STE back to the correct
> ABORT/BYPASS setting. Fix a bug where a IOMMU_RESV_DIRECT was ignored on
> this path.
> 
> Notice this subtly depends on the prior arm_smmu_asid_lock change as the
> STE must be put to non-paging before removing the device for the linked
> list to avoid races with arm_smmu_share_asid().
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
