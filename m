Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9CB6FB1
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YDUXTf8s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuRqET5Y3XMKNuUmfLxTfWvcg4ViC5ZvRrC01K4UycbsCUzChsut75y1AHM9RHt5uQXMZn6TGRvyjIj9HVJ73JICvKj6saoHhCK6FgeP1zqpgHPAFbKrMTY9tpiBggu0AxUM5r26tY2AhuG0OV2ZSN/tlMVaXDEpOdkzWG6PZzEjkUsUtpf+WUjvle0eLVbLaOMPym+wvUelL4DKC+t9Blo7GkscyKkudoqxDyr9uuBpo/6skzwdtDZlQzA5h1zqqAN6YSnJM7mtqvlkvXWTfr+uzSKmymfTam+pKaPQ5dAvyOSuEGhr0iClcuZ63xrUL7d16i6tKzizGzyhJvMx5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zSGq4oBT7AZTImdbZyjpsgtDHgTmNMync1DWkpoMPI=;
 b=JSq2CErmg0xoZJwe++BhOTnZXDm8IOrZgie+Ocmt2VWQWgAqESuhf63fv/toPBfe0a0c5vnGbK7hrdsY3696zSHYEdUwmCpRy01aF9Of2+HO/ip9VB8AUrrIXIQV5XnnqZH6qbB/3gSUchjz6CDrRHU84IlGLUSA5quI0Nj8LASz28sbiI1XNg5hBLCWK/tRkyNf0jy8qYQ+L7sNI7Cyi8A0+mHLcJxm/JUGk0sxXeG9kMwIlFx1qxG1/iBKfow8J1Qiqur56dXP/5jojSJv4D12PtaIhrRfP8eQ7VKi/j1yQLwrxFU1YFmu0YM6lKQOT0YZVqZPpir/i+s9k9i4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zSGq4oBT7AZTImdbZyjpsgtDHgTmNMync1DWkpoMPI=;
 b=YDUXTf8s/raglkrz9K6g9gMHbGgMkrvONfr8DzWaKj6UtuItEsW7MYwSn5h1HvjowTCKfRUtUxAGeo0VEMrWdQre/AzXV6SldkSgi7ysANVI6yPpLZkwB5vpB5ZIIgKTvwR7QrTn0Ly4P6o/lhwMosx1tJFi1UMqBqrktTaaUMXbV4Z9vFRuJZcr1xRSwpc7pAk2cgURSueiHHnJFrfMtSs1Odr04wdv/YB8TJkYg/JY+J64wD+gHbmwv80CgW7+jbpv8f737Mmmweq6RAB1IZhYyELCKtHQV8LjW9r9ofAJjBn0Y0sPp8EiQWP3rY61URyCzGvcHvW3NsIdlwuqvQ==
Received: from SA1PR02CA0021.namprd02.prod.outlook.com (2603:10b6:806:2cf::20)
 by BN9PR12MB5177.namprd12.prod.outlook.com (2603:10b6:408:11a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 03:38:56 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::6a) by SA1PR02CA0021.outlook.office365.com
 (2603:10b6:806:2cf::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.26 via Frontend
 Transport; Tue, 5 Dec 2023 03:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 03:38:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 19:38:43 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 19:38:43 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 19:38:42 -0800
Date: Mon, 4 Dec 2023 19:38:41 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 12/19] iommu/arm-smmu-v3: Put writing the context
 descriptor in the right order
Message-ID: <ZW6bQTvu1EoGaV08@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <12-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <12-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|BN9PR12MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: d27a4c1c-3b44-4026-e21b-08dbf543b5ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PyKhrgaWnQtcr92HUC70kTRrYYQ9t8PM5KnyWpXZFmOn7Xa5y5QJJiRDe3hAj7Fd7QfM54chcyCrVxHsnwM3+/HSEkE6XwYZvqaeuSeqseHKwBUuAHawamID6dhHiwMWRYbPjMH4vJH/b7t5WKiq341rME9ZyJT2c1lC3HHIJByrBNrnWuXobC5RhR1ouAkBAXetM664BB/LFylqsgwfJ8QUs9eXhQ6XCcCqcI5r8lZzGCUfd2MfEZ+KmPdYIDLa9cbQXkN5xaEgp99mdxQ0Pmrb9/coOR40gB4JYrJYVah4rn55G4cCsCDfnPcWgAIeNLnXKv9aOrIaRjLchmC2QquZSJf+xVMr5u09jQ9/fWe6W5o2J9/VGP3I3zVCB2YGyRMZB1uILptb5DNm/s+s+6XnwSbVqWhoS3glQZ952bxf5Fut8fLrh0fJDhSNytp/vjhkfJ5KBeu2YcsON5P5GlipvOlKkOhpM3TxtC5Eoxx4THd6BEtBFdWCucezVN5xEams8HyqsUpcm+mn5OGlIkvHMAVhIw89vY10nE/8Yak0Y0eZ1WKFAWwubVOn07dhSymyWLexMqMIGrb7n7WkT+JfplI0uH0W8Wcss+mSLkgWukCpk0VD1wnUHUbH1VYERPDmvEn9pbfcsM27W9D48BamcqA5lS8o0HKExE1p6McObEavW/JbWDvJeZAuOCl78+cn79s/Cx/4NpaiDqkA32rZSp7/VQUTrwmMlMSmlNEzGKsv8KQU/GUHp6qaqY1L
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(40470700004)(46966006)(36840700001)(336012)(26005)(478600001)(83380400001)(7636003)(47076005)(356005)(426003)(9686003)(40480700001)(82740400003)(316002)(6636002)(54906003)(70586007)(70206006)(36860700001)(55016003)(5660300002)(6862004)(66899024)(4326008)(86362001)(2906002)(8936002)(8676002)(40460700003)(4744005)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 03:38:56.5530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d27a4c1c-3b44-4026-e21b-08dbf543b5ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5177

On Mon, Nov 13, 2023 at 01:53:19PM -0400, Jason Gunthorpe wrote:
> Get closer to the IOMMU API ideal that changes between domains can be
> hitless. The ordering for the CD table entry is not entirely clean from
> this perspective.
> 
> When switching away from a STE with a CD table programmed in it we should
> write the new STE first, then clear any old data in the CD entry.
> 
> If we are programming a CD table for the first time to a STE then the CD
> entry should be programmed before the STE is loaded.
> 
> If we are replacing a CD table entry when the STE already points at the CD
> entry then we just need to do the make/break sequence.
> 
> Lift this code out of arm_smmu_detach_dev() so it can all be sequenced
> properly. The only other caller is arm_smmu_release_device() and it is
> going to free the cdtable anyhow, so it doesn't matter what is in it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
