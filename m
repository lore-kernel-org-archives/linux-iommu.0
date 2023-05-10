Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890973D60
	for <iommu@lists.linux.dev>; Wed, 10 May 2023 17:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvUSc1yGnqKrEOJM81GWf+Ckv1OUAPSV3JQZ4n06GI/9TJZhUlknKcFqTOksKB8qVZf9smpJkmX88juInxfdi14kOOI/bha+GMsKrq7IyyoLPGKEoL+TMvG48J3bSU+brSz+27fx9rq27AB36p7lfYW3z7FFAvXLN8G1sC3+/7ENTDGIj/x4znsGqefp6mwlXAn+A/8Wy+VcvXwllAHPS/uc81mT1ogAFa4zrQZpxvG0qe0t06cIf9kb7dVtfhHyDR0ONbR30dgwzR/AXgixgZw9lmGeZwmfOSofTD8Tv2vCFJv3gwdE9bGpprB3nAb6+dmgCeLS/9N1eEasAecZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7kaRTlisBacM3ZRY3wTph60R+dm1Q8KFv82IxDCjfs=;
 b=ChnFPWJ+gHfDcfYh7C77xvDT/FO6E8fLQDPN8YLBk4i/lFmBVMfZtyv4Hl8AKzo0XlHZCqdq1TwyVpdCDQxeNAlYIhPslhGXMs3S+lszid2Q/KWOmfH5c5JgKmFykmWLpePwIb2IE6Mkmc4OUk+tMZc/KS/7/8BgNUpqWhhFSQOf57EACHPTWXew7D45r8HFSoi2JeGGfUoYJm8nnycC7wqSWR5USU6TD1ApSsMHQIaaKapJpoG4KKwLzVz5HzgN1yLb49o68vO4k3PB4yrQxUJULY/mMOvTwbv/wPTWK7SXxRrUzJ+73Caryu40olibH8JHA2F5QB3aRAyn/YYkaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7kaRTlisBacM3ZRY3wTph60R+dm1Q8KFv82IxDCjfs=;
 b=q1uCIqy9jZlNGoJOlW2XEnPrlx/VnWQf5yGIO0aUNIyvajguZORcsS81Hjjyth/GmMAOdKw6yvuLsJ1cnW2Y9Ry/V9ebWVF6bePt4QG2gLV+nHZ7BQ2BS9eiVaZfvPj5V6uOxmY7QITCXRGBuFGsK71kcjVVgOL6X1gGijlW4IXH4GU75cHwn01bvnpuOGQbMq2wjJWMC+zSjW8LKhXVR9/0mFyOWcSiR8emtBzMthjmllDdfH2A0gxmgzwe3bLvWzJbfQtYgr4xkJK9gMRw38UEqKY9LCARrQnzeVzs8x6qe0w8ptQuSu91EN4oy+WLSAWgHEt8CTo8ZN64oOS1jg==
Received: from MW4PR04CA0104.namprd04.prod.outlook.com (2603:10b6:303:83::19)
 by PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 17:40:57 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::35) by MW4PR04CA0104.outlook.office365.com
 (2603:10b6:303:83::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Wed, 10 May 2023 17:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 17:40:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 10 May 2023
 10:40:42 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 10 May
 2023 10:40:41 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 10 May 2023 10:40:41 -0700
Date: Wed, 10 May 2023 10:40:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: <will@kernel.org>, <joro@8bytes.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <jean-philippe@linaro.org>
Subject: Re: [PATCH 1/4] iommu/arm-smmu-v3: Work around MMU-600 erratum
 1076982
Message-ID: <ZFvXF3gKL4WHiBeZ@Asurada-Nvidia>
References: <cover.1683731256.git.robin.murphy@arm.com>
 <08adbe3d01024d8382a478325f73b56851f76e49.1683731256.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <08adbe3d01024d8382a478325f73b56851f76e49.1683731256.git.robin.murphy@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|PH7PR12MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: 3417f7a6-572c-4450-d68d-08db517db616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r7YlWIDRZETVCzx7Sfq0/Q9sdV5XiLt/G4hKYjhKeR7oDaS8iSMCl1hWTJDU3N6h8JsyTvkaTllNv29gBwElspCa+avTI37wC537yBPWqpcTyDqXuxxYOtVEfn+BPzsnuly//HO+NMGDguSB3CcbUdW08xf2ICulEaSu9ZfMtKKgw+x04GnCvmaV2vUdkREkyZqMxDK9/zc9ndqoEhy/+wD3jMpbC+ek0+d+Ga/kftepuaumMmZxprbD0vRqUj1GgzuWOSlmirCDH0p21DR8SfVgPIFwRAc/8j4LeN+bF6tHpnwmwa5JazvwiR1BcUguvmlxhH256Ygw78PcsNYHbXfjURtP/0gi1MZbozOYBZoom51pIGvWAgJ60qOFPz83X4AkxaowTc01bbekHBb8NBoKltO5498qBHILyLGBiIHfIbyva1nVVIrPLmWsF8QHdc7yqTLlqVTnZCbN86qZoB37omOPoz6rFdd2kI9JZFYO18HY243lAYyNKmxA37sWuEuJp5Xia4W8YniQRRBxveX/KbZjGYhqTX3VfxXFRJ/nKMXw8U2KbJMbG8qAzWVhQIVBcd31TBovvhDzGVTixmc5jCUy9h4yIf8JUUnBV2jdYiGW/F3IqsbDyI3hUaP/7Yx5vEKU01YjMW3kYMOk4OGaizBEIP4r0pJCPrSrOadAp25UsrGCksVBFu+oySwvuudPVb/UxfrVMjooWxLq4w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(4326008)(6916009)(316002)(70586007)(478600001)(70206006)(54906003)(86362001)(336012)(9686003)(426003)(36860700001)(47076005)(26005)(8936002)(41300700001)(8676002)(4744005)(33716001)(82310400005)(5660300002)(55016003)(40480700001)(2906002)(7636003)(82740400003)(356005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 17:40:56.9831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3417f7a6-572c-4450-d68d-08db517db616
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6695

On Wed, May 10, 2023 at 04:38:43PM +0100, Robin Murphy wrote:

> MMU-600 versions prior to r1p0 fail to correctly generate a WFE wakeup
> event when the command queue transitions fom full to non-full. We can
> easily work around this by simply hiding the SEV capability such that we
> fall back to polling for space in the queue - since MMU-600 implements
> MSIs we wouldn't expect to need SEV for sync completion either, so this
> should have little to no impact.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

> +static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
> +{
> +       u32 reg;
> +       unsigned int implementer, productid, variant, revision;

Just for curiosity -- what's the fashion behind the coding style
here? Usually I follow a longer-to-shorter style, yet perhaps I
can follow this one for further SMMU patches, if it matters.

Thanks
Nicolin
