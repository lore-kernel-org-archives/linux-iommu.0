Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FFD802
	for <iommu@lists.linux.dev>; Tue,  5 Dec 2023 04:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q+4okY2C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vse7YgeuPINXLCyDhEMbZjdPBTTzVxvFkQpvmHJG4fWbXqJvkFptx6KmMP/PwJTDfK+RP5VPRswTG1zJDkUEaJnx96QRrxgzO7JERV5vvMzRRlwJNhgM4YKDb2xAgfSz4Pf7EEQAN07s5huC9xpNekf4NSulUOua2RnzyTNRtl7dEqXkCFQUcU+qLPtPC7PidaT0+5xYKqGQsgYNEEOWV2kBv5yro+vfm3RKSAhx54RHY+p/0HbptrBEVIEnf4ZbRL4aJmmAbgxF3arzvmXR2Zf6AP7xHaN6AlXRvmxjHzLrlX6fEPVsAtjmmlTTF0zPnfooCSG9JlmV+3khOH5gLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bi8Bk5laQaKf9qodeJ6ZtpSh15PWEsJHLkGx7cM4isY=;
 b=gPyuh2OIhWMFpclBYQZxYb+q7COgQBBRdm8+kjjz7Bxq+yRLOlll9yBm0a0FehVVrYKU/zjwu0RbljrLjTeEetsp7n4VEDV11sgoAkzmwI6F0FY9AP4XBJ0okgwClLzXXeuIOws4wygBfboJTwj6+KCAhP44X9R2FamrQ3d6rla76ioK1vunKje94FyCbv0fUi9r3D1o6FEkTimEbZPDoR2rMVCB0lxrXiVOClHVuEndfwxiFIRM4MLqUeZTs1HMsC8uswyI77l8yP2sacGC2nA/Eivx4j6YMtPvEJzS9w3APfFssyITty7Ax42DyivBq/0nXW13YcHeutEP6laTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bi8Bk5laQaKf9qodeJ6ZtpSh15PWEsJHLkGx7cM4isY=;
 b=Q+4okY2C/2buLHOoRzz7SqiRAMGLJrxDVJ8Lo0PPYyZKr2NJ2Z2obkVPJUvocoUhFW4xJCNRwUzfEyNCvH3qegEhuWoyUOVFqdUiFzg9v0xTrM49PTYe22+eZYyqMQj1aIUcGCeMsArMzHQh/WHTfa4QiIlzztWCXxwqyuU6VHW5WsUvniEP240nQi7hCI4CZa2KinrbQtSi/208UpY9xncFFR/1bjis/NByl73vPhQXjaKZ/CHvPo0qwo0OKmvRzxG23nAN6y0WzdPIlypl0iEcBvARCfj57bdPv4joG9r4HvKrm1tjiqYvR/8/+4qv4iVHzRvQMNsqfq6uQc4UEw==
Received: from MW4PR03CA0102.namprd03.prod.outlook.com (2603:10b6:303:b7::17)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 04:41:12 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::bc) by MW4PR03CA0102.outlook.office365.com
 (2603:10b6:303:b7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 04:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 04:41:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 20:40:54 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Dec 2023
 20:40:54 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 4 Dec 2023 20:40:53 -0800
Date: Mon, 4 Dec 2023 20:40:52 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Michael Shavit <mshavit@google.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 19/19] iommu/arm-smmu-v3: Convert to
 domain_alloc_paging()
Message-ID: <ZW6p1AFRiGaiZMb+@Asurada-Nvidia>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <19-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <19-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: e36a6e01-79ef-461f-1f4f-08dbf54c684c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	21To0c5icghQREM8dZjIJ2YEIkOrjBXcMyvx+Z4z8UH3llQhEI9WNKaawoLr3bQxcbbnPPfWy6O4hqcjKMOFbsk5hWPkZckNB9zQ6Hb/O/Bl/GG+Q2Yu7w3OY95frdO0fI1jjGnr+eCGr2n9bpsNfxzDJd4VnPS3H8fIkIV3DlxlH3u+qkHhkPRCB1lk64Rw1Mvi2CwkJ7TODFvxCd50z/yXV1rL6bDsG74801aO/5fCubu8SB/ap+F8c854ZAsMvfLMmzKAW/Kr+yHRYaUuu0sV+UMCXl8CpfhoG1E1jErOmZLfkkUVAUWojr3bGKc1wLwaZLyOfC4le9lG1EsEEXiP2TZzMDO76KU6ZzTNdiq3ZWVOz0Yrkq+c/TniL0OqB1iX8JeJtE696TOFuZVN1bRDAoQV+ONNRp8R9WZpK7uoXLL05GsM+JOqVy7pSJU+0EPLC9cmq9F2QUZyG+cogVfG08s9zV5/G1Tobt4i14s8Gdv5o2x+mhc8d/hzC/sVjah8KS5N9URY600agkxTY2ZCjeG4lDfKPrf0Ws/sE1mdJPDnS8gyt9v/T1uyHdjIFtTXvGr8JYDZKtv9DfOc1d+LuzV1WzjruSe6CB/5m3b+JsXlTM+jLR+5TOpXZIHGJwvcUQ8eRR4Wa0ex/7MZrp9T54cJXJ3cESt3XCGXVvfbx23dMVBIXyI2Keiw6eihC5LzP5k7tvEm4Y8f4XLWplXnYyaRr/doMCw3PinTeT303u/Q+Evcl8MI9EZXvDys
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(40470700004)(46966006)(36840700001)(26005)(478600001)(83380400001)(7636003)(336012)(47076005)(356005)(9686003)(426003)(40480700001)(82740400003)(316002)(6636002)(54906003)(70206006)(70586007)(36860700001)(55016003)(5660300002)(4326008)(86362001)(6862004)(2906002)(8936002)(8676002)(40460700003)(4744005)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 04:41:11.8414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e36a6e01-79ef-461f-1f4f-08dbf54c684c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522

On Mon, Nov 13, 2023 at 01:53:26PM -0400, Jason Gunthorpe wrote:
> Now that the BLOCKED and IDENTITY behaviors are managed with their own
> domains change to the domain_alloc_paging() op.
> 
> For now SVA remains using the old interface, eventually it will get its
> own op that can pass in the device and mm_struct which will let us have a
> sane lifetime for the mmu_notifier.
> 
> Call arm_smmu_domain_finalise() early if dev is available.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
