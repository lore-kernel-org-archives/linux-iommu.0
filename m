Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EEE3D60
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 18:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJIzCebfWT1FOieCZ0NLlWwmqwkoPmoPyYbMmaHhidSeSihH2gF/t2C823h+b2j80cMH8iGJ4FqHngntIwszhuuvID/N+ypspZqq8g50jRGtAktl8JQmdTyaaSKAQ6xxS2wjxEcpW82rAXnfTwMC8E0CX7uRZG2/3LWZzyzm+pJi7X4bNZAEcbnHWC9k0qsQzFQ5ATCkE+QbYwio7d708LnbdvBFSEZiNhPe2NPH6ZHYoMtZknc7ramb+v8iAxRd9iR/BZskzz9tIY4GUlRMrpMD6bsPypcYlUy3qlRtB7uhVhEeIAf8mEbmECyQN4KEiponPUf2OC3xufjKvxWrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8q6MiV0nnbsSpRnThvW+u3mjnfHRRLNKrcMfdVKoQA=;
 b=JMwXvwePSVG3HI5SUgi/5uGh9KDxsMtAAN/khalfNV2MBvyLFKdtZybGkSZ2hMWOInKvtUQWKFhEFn+u+tehuAKP5en1tiereLqu5qXwd0Pquz9g4B3szVpWDr061pmSscf3o10bvVl6VKNKUG/Vrj1WgC7WfD4d4E6GQcQDOLDeNBVFHkMw5c+6ewBMM671E3hOAVQ9TN23vwrUUK+bIaQnO+tixkkFRk7597bnMAelq6RPqFQJdHUcgsOcEJA/3XNn2VeFcUFJ4y54X3GKjxnGZ9SeXfeudctp14l1V/x3hwlynJ7XbjopLYkn8lgL9lmTtIsmoR6vSDcA6FRgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8q6MiV0nnbsSpRnThvW+u3mjnfHRRLNKrcMfdVKoQA=;
 b=laPHthm913Qbk5/sb7wFernvGIK2SZFPMxOHxib56UOZ7jqKEAhBOzC/+AFNy8wUmtAZ/63Ey2XsfH1A1LRFE74SThQKIlv2JU/a/hOzOiWLZSpUzCqPT4+9Ooui2S6coZRzQXMI2+5VRAGlX2CCEDvjSzK4pnOMvbceXg5WEGSSwUYgibVMzHnRJ5rTennj4jbqlaojoXu4U0wRsH0qELw2kdp3yvzPdoRzVmSdQrnQz4F5S6QdNzTbLo2I0u+HJbiGQe6Fk5AotEaJTSLSQrrpt0rn3Jayn8AjiYGDdx/eaOZSN/ChMDD5Brpgl8MUY+EMsJc6DYCVi/JnZPvfAQ==
Received: from BN9PR03CA0448.namprd03.prod.outlook.com (2603:10b6:408:113::33)
 by DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 18:13:45 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::54) by BN9PR03CA0448.outlook.office365.com
 (2603:10b6:408:113::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 18:13:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18 via Frontend Transport; Wed, 10 May 2023 18:13:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 11:13:29 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 10 May
 2023 11:13:29 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 11:13:28 -0700
Date: Wed, 10 May 2023 11:13:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: <will@kernel.org>, <joro@8bytes.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <jean-philippe@linaro.org>
Subject: Re: [PATCH 3/4] iommu/arm-smmu-v3: Add explicit feature for nesting
Message-ID: <ZFvex9umMMaPyXCn@Asurada-Nvidia>
References: <cover.1683731256.git.robin.murphy@arm.com>
 <136c3f4a3a84cc14a5a1978ace57dfd3ed67b688.1683731256.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <136c3f4a3a84cc14a5a1978ace57dfd3ed67b688.1683731256.git.robin.murphy@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|DM6PR12MB4877:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a22fa2-4bcf-4113-5b23-08db51824ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N9yFBQeZCwI0g6NKKM+8eT/n9sQAbDXvcs7D5CX+qMF8FkTbQIPEaIHEFOUvAb+MHgBL4HNq3hw27kA/D6FOHg2WXlbs6k0EkqXgp+cT4BJ0Bba4WuLUkYm/4PrAmfziqT1aETGZTlQSJUEPVvCTsZRn/a9dgenzbpVD6voRdet8X3jZcGe33rzq3zIM/NImNio/1ExKBQy6UelMaFugaSUYQckS7kXrpaQTtO9YepyfBEsi7nJxLF93SjfQ6FiiZlXiw6UZsT9/L+jUVmkawCEdHGUuFV7esQ3vPHiThHbQai+ZqkiQgf9iTgDkTJ6HuEoJETRcRaTcUuf08Rjgd4IVxGpI/m8PPoeIlhr4eMTc2/Xepy3on8s0lqnGQmbkAaDfdu0ainT7J2755rAm6INLAsr86962HOsZ07mMOTFWkMI60LiBeN0qgYW1W2o/7JQen7mqx6NofXpGpORJV5WS/171wra4Uxa98cZrA3gb2ylhBI8nrvonHoLq5tlPqZpqld9BBHqHIWpLQo4uXdhogEilEULmUeSasdoUiJBYNRHuMN2SYgDQgkmsynjtmdfCeiy97DXJlmDu6eAiNT/U/cmBo/EZOJw+sMctVe2I4Q/IhzbynoHq5Vr5FSP2V39qgf8EE6WuCjc2PGNtup48q7wVaHKbEjF+3wAUuFTNzgM8eYZxfpC5Z4KQb97nCXGSjH3Q4iBxcI2EinxwFFWHdZkWp3wcaT6LVe+pyK6roymDLHsBZ2WRWBvSe99n
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(36860700001)(478600001)(8676002)(82310400005)(86362001)(356005)(7636003)(4326008)(6916009)(316002)(70206006)(70586007)(33716001)(336012)(426003)(47076005)(41300700001)(40460700003)(8936002)(82740400003)(55016003)(4744005)(186003)(26005)(2906002)(5660300002)(9686003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 18:13:44.5456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a22fa2-4bcf-4113-5b23-08db51824ae7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4877

On Wed, May 10, 2023 at 04:38:45PM +0100, Robin Murphy wrote:

> In certain cases we may want to refuse to allow nested translation even
> when both stages are implemented, so let's add an explicit feature for
> nesting support which we can control in its own right. For now this
> merely serves as documentation, but it means a nice convenient check
> will be ready and waiting for the future nesting code.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
