Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF6623A6
	for <iommu@lists.linux.dev>; Wed, 11 Jan 2023 12:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqiFuFXNA+BChvBZodV1ZBFIBpaLlFrRmoS0tPZvNr+nYl2/0Uqv/hy7NP0cZ2LuVGdXpVfC36j3XJWEemjH8Q0+hsrAgvpCLXZmuGguiCt910iLXyDZtsnJypO9hGxl2W0W3YuBuQPEvoMplpb+pgQbjtbKKescw3Rv+Rp+Un6fjhKAoavGNa6lGQHRfWHms/pIIj+xJ9PvPNuc2VHjj14mZCRZE/ffjzxHyymchHKVxo3kFQlA6WncmXsJItZSbcfjxxKCwGGcFs3/d0lkQdfcPcGU7stYMgaACGJ5GBCVzz/p2ZDlewU/Yztimhs0u/y9hK3fOFwS9PuEjhzn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzxoD8V7g/Jk1zFaSUJQRUTmUMD4Qzity+YjbtQoc9w=;
 b=h0lZSXevg9SJsEPu4YSVuWlWal5ESnCqrht3c1vlTIjaaJpAea7UGnV2Rs7o+Pbin2oDuw4R+SQcjaEpXsBjJ/hcIAjWFhRJAX2YD/3TOx+UM3Q+n/uQtu980sEOrxUsU7oWikS5rxvB2IIv2+10iUkjPACe2rGFdDFBMOB7ogj4LYZnHwvRrcunogGAEvllkhEiqYpE0wT1Lv11ANs4HjXk++Fn21OjHhbaMGSrwi23lkx7iy2R+wv0KpcYelOTCRQt02Ot1yHCf+XRyLv8hIPSQaTbJVYd22hY31XfEcJezSN79psE+fX9dc5ZSU1te2IEuAPchfNLVx+yBGPz5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzxoD8V7g/Jk1zFaSUJQRUTmUMD4Qzity+YjbtQoc9w=;
 b=EDXso1FGcU65AszQed/3HAUzzeRoTP7qamwdSjybF318N5rGr558vdpnIJU+HcVHoPIuJZ2s1vqbsstbSEwFwn6UzJLpKjATrCcDY+GCGglL4KuI7yx1chjyjsvywd30OdI0YdM9FCXr8lyEw36rLcHJgTKbCJTfuFguf6YVuQQ=
Received: from BN9PR03CA0349.namprd03.prod.outlook.com (2603:10b6:408:f6::24)
 by BL3PR12MB6641.namprd12.prod.outlook.com (2603:10b6:208:38d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 12:15:31 +0000
Received: from BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::dd) by BN9PR03CA0349.outlook.office365.com
 (2603:10b6:408:f6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Wed, 11 Jan 2023 12:15:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT079.mail.protection.outlook.com (10.13.177.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.17 via Frontend Transport; Wed, 11 Jan 2023 12:15:31 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 06:15:28 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	"Matt Fagnani" <matt.fagnani@bell.net>
Subject: [PATCH] iommu/amd: Fix error handling for pdev_pri_ats_enable()
Date: Wed, 11 Jan 2023 12:15:03 +0000
Message-ID: <20230111121503.5931-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT079:EE_|BL3PR12MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd5fabe-a63b-416d-3f65-08daf3cd888a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CnJzuEuj2p6q+qIw2TmuBQkgc3/8KM5wsF+7U+IbQfutu4Wqr5ywp57xOjh7FEnjFlVtin3NLLnoPWFEezU7KwDGEpJcVGiFVSzSanrfmMJ6TDxxiQJQLm9i9fxt5W0CiaDVv2ye3xKY0cfOikqqv2wyfXIWH7cWrnRFUOtuWz9xPBZJ9vnJA6rY1Gh7o/jVUTF4ogRKq61jn/CCNJMHb535nmaF60/sUy8NGV4oDuMXO2Lm2ln85TdaK8PzM1YE6YZyJUe+HYVAoHjJEWi9LB2Y7IP0sTPcjqN/VzKot7He38KnX1m3jppgTZFgv4GawfeDHXoigB5nzngLAtpJYx5+8/LpNodAVWrFOye/gvZpYb/4OWmAMj0sBa0ffC4eLVLIRHWrU7sneeAdoZaXeYHC77aYIfIhsz4CTowE26HMcGjOpwpNvlv8W65uXubp9doud2bdUgHB6hX4NUNclaCaoknslMglBYvm4q62CAp5sL2QpM0i0JfXJp+WSeuVF4wOFqzZX3WWYvfNNZQz4eTjxiytRpS9DrUsMs5bKLGvzt5Hhv+n0/cR8jXiWVgrPNhBdqn5HqWHeE9O2hcM0Y10S0VXSgLqwsIobPvG4FL3nmLNJitNyGVaTPM3CuuLdIJvFiGDY0/dylprxe6/s+dLH2CCgMUyyzDoa/owN6f0W8oHXeJVed9p1WX+GnvEpFlgpsd3WAIUz9Y31DN6l2pnldVeSJLsgnVgv7Us+ucIphFUeO4+ynRWMoQwdYvwt7pk2IXpd0sdEg1FG/Br4w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(41300700001)(8936002)(426003)(44832011)(47076005)(5660300002)(2906002)(6666004)(83380400001)(36860700001)(336012)(70206006)(8676002)(70586007)(4326008)(82740400003)(81166007)(1076003)(2616005)(356005)(316002)(7696005)(36756003)(54906003)(40480700001)(478600001)(110136005)(40460700003)(82310400005)(86362001)(966005)(26005)(186003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 12:15:31.0484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd5fabe-a63b-416d-3f65-08daf3cd888a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6641

Current code throws kernel warning if it fails to enable pasid/pri [1].
Do not call pci_disable_[pasid/pri] if pci_enable_[pasid/pri] failed.

[1] https://lore.kernel.org/linux-iommu/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/

Reported-by: Matt Fagnani <matt.fagnani@bell.net>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cbeaab55c0db..2f8c018e1ffd 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1702,27 +1702,29 @@ static int pdev_pri_ats_enable(struct pci_dev *pdev)
 	/* Only allow access to user-accessible pages */
 	ret = pci_enable_pasid(pdev, 0);
 	if (ret)
-		goto out_err;
+		return ret;
 
 	/* First reset the PRI state of the device */
 	ret = pci_reset_pri(pdev);
 	if (ret)
-		goto out_err;
+		goto out_err_pasid;
 
 	/* Enable PRI */
 	/* FIXME: Hardcode number of outstanding requests for now */
 	ret = pci_enable_pri(pdev, 32);
 	if (ret)
-		goto out_err;
+		goto out_err_pasid;
 
 	ret = pci_enable_ats(pdev, PAGE_SHIFT);
 	if (ret)
-		goto out_err;
+		goto out_err_pri;
 
 	return 0;
 
-out_err:
+out_err_pri:
 	pci_disable_pri(pdev);
+
+out_err_pasid:
 	pci_disable_pasid(pdev);
 
 	return ret;
-- 
2.31.1

