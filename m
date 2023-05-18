Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651207E
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 00:53:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTk3PnwUAQs4MKFyYgs0yALmqDjpe2Ol9oV2RUhYZRq8wdzCqYWhFn+1Gv5zvpUAFioJP6KFbSx8WjJu2LVG/Gd8QtdkoEu9d4jN0l8N3V0FWwTZ+2zmT8/mQqcYVnMhBm1Ox6BVue8680KnAmWAdP3yNOnp/2iJqbOdTh5nfdW6Pe8CGcHfCGvSR9zkuEDfZfep3058XPQHGP1H68QHLycmfRMmXFDKmra5NJWz2YekypAc9E1GzG/Oh22PmvBcbNlKxcwQPG5/mxhFBEPkB8YS8IyUfI18cXArnA4ovIaCFasKs6mUwMqgW7BD7e8p+uGXJ2JcWWXonQI0bg6gpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+TDAgYlO2UmCVOzbxZHbWDn/5mnikY1tYpdxG8nbEY=;
 b=XLPYa069FwTNlUpj+2BSl1q1ave2xjrb4PddP1FwewHFs5LZn3ymTP9Gy5Nv4v5R9y8YJJB4RbVsCW2lcz9uXu6pS6pzYA9fxdqGmDmMk7Tiy6mQ/egj1gQasyB8YffmWs55GrzfkZm8o7yIsVw1ds8dpXz4AXnsnffqORN/UTH3FYI2zceDmu1fE8szTSla2nRyfVLJ5M7VmZfo6lkR78rXzcH3Qtue9+sy6XHap8gSievOFOI63CiH/FF/cBl20WSUHsbMco1w6zxeCPknh31CbUFYkTgLaB+sL3f2LbhOtwUQz7exMTeSK4P49I3qiUArtYrVZWbVCCLADe36Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+TDAgYlO2UmCVOzbxZHbWDn/5mnikY1tYpdxG8nbEY=;
 b=i2Vv0d/VY73hMtpMbXbjjqkEvJjUlhWQQWHaCRZ/Ed30tLfsLziwNrQIxRfCClMaJ4JazQ+Bu8vMDNqvxCAzvmmJOYZ9HEmX42DhlZl/2i47+8+RJaqwpVL6ka72TDhmbfHMp2pmTycWEI4QbuJ5s3/8F6p5MknZ5PMt3ERGZ0cGQmJdz7Sn9g8d+ZBkYewdjBWEU3GOgE4TLJgFrAj0Q1wvL9RmEmtPluaAgsYvxxew9DOBW0TsyZq3QV/Oo/L1hnYJyR4EJkLj6+DiKO4qYTLCm9OsD/PTnw/e5X/r3miuFkijBYoAuFIVJ9fBte6H65cVZ6O5Rxb/+sG511552A==
Received: from BY3PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:39a::14)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 00:53:36 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39a:cafe::63) by BY3PR03CA0009.outlook.office365.com
 (2603:10b6:a03:39a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 00:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.18 via Frontend Transport; Thu, 18 May 2023 00:53:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 17:53:22 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 17 May
 2023 17:53:21 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 17 May 2023 17:53:21 -0700
Date: Wed, 17 May 2023 17:53:19 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: <will@kernel.org>, <joro@8bytes.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <jean-philippe@linaro.org>
Subject: Re: [PATCH 1/4] iommu/arm-smmu-v3: Work around MMU-600 erratum
 1076982
Message-ID: <ZGV2/6487F9S3Blq@Asurada-Nvidia>
References: <cover.1683731256.git.robin.murphy@arm.com>
 <08adbe3d01024d8382a478325f73b56851f76e49.1683731256.git.robin.murphy@arm.com>
 <ZFvXF3gKL4WHiBeZ@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZFvXF3gKL4WHiBeZ@Asurada-Nvidia>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT062:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e8535f-10ea-49d7-01d1-08db573a4fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FgnkqLlnraZq8ln6uNXu6K4Qb/r9Q+SyeD9ptDEDUGX9kTtRWQlEc9HaIwKqSTdkkw0Hvn+bl2blocqfPP1Ue/p65PjJ1d3YHVfx38wJFmhtrTzAuA5HSbnXewYNzrJUZ1BJ8fu8aPapveL3G48vfwcRbifNDpbTXd5lW88UpR9rpvEe9Cxap99Y0hCGquoYuFHi5UWahyWmiEQtJRzBlXnAlxmarThxngYfquVft0X0LQ2U72lfGYK0BOlXnd0XtQlXYZy+ockFvY8VI7wqgry8comFw1dQh5XLOEG3/GXMXWQOYO51ouCj0H3QJN234u7tpWj244zuBDK8BbdFAD+d4LDgAFBRiiK0rIeUKUqYiMqkHQ3z55XQETybfah33YPLthi3LuSJ+tuAkBqbj+2yrfhXlJbXKV4IW+oFP7CVMf9LlvrWfWgFmaOVENiy1dgPepYAasOjuvRMrOge1vDbcf7UQ+OhA4ifxo33fFgcU4kcvBN7dNiWqZfrKfzttQrF+N+9YvRKXvH2/9sIm2dssPVkQVRWovqA3abtvYeCpqw5oKn1yi7TFNCHql9JprJkAXZmYTH6RpcostQbIPefF4hRApq8adaJQIA6EmTFe+w0h6Zl7H5wUbGKFOODP+8y1Sz3wDBJDC4TVw2Vya9/GDwexAk8hV38LxwxiGKMR1oQlWa7wkwDLUn4gLGJPqJysax2o+5PQp8N53DDaA/UOIorZSc0q8IB2Jd7US4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(426003)(336012)(54906003)(316002)(40480700001)(4326008)(8936002)(82310400005)(8676002)(5660300002)(70586007)(70206006)(86362001)(82740400003)(6916009)(33716001)(7636003)(356005)(47076005)(36860700001)(55016003)(2906002)(4744005)(26005)(9686003)(478600001)(186003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 00:53:35.9091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e8535f-10ea-49d7-01d1-08db573a4fbc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834

On Wed, May 10, 2023 at 10:40:42AM -0700, Nicolin Chen wrote:
> On Wed, May 10, 2023 at 04:38:43PM +0100, Robin Murphy wrote:
> 
> > MMU-600 versions prior to r1p0 fail to correctly generate a WFE wakeup
> > event when the command queue transitions fom full to non-full. We can
> > easily work around this by simply hiding the SEV capability such that we
> > fall back to polling for space in the queue - since MMU-600 implements
> > MSIs we wouldn't expect to need SEV for sync completion either, so this
> > should have little to no impact.
> > 
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

It happens that I have a simulation environment where the
IIDR value hits the errata, i.e. the NESTING feature bit
gets canceled by this patch. So,

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

Hopefully we can get this series merged soon.

Thanks!
Nic
