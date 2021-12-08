Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A075C43217
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 08:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4CE440103;
	Wed,  8 Dec 2021 08:47:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mbe6bGxmqcRa; Wed,  8 Dec 2021 08:47:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3B2D340491;
	Wed,  8 Dec 2021 08:47:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61A4DC0077;
	Wed,  8 Dec 2021 08:47:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67F33C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 08:47:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C4A2380DF2
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 08:47:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iQKXywOMFMS1 for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 08:47:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A72AD80D95
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 08:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdhcd62nPtX6qzq28puixavZ60mhutVL5Lm8uGAOToNd0yS+2JIk4iacBoQzc/5E1UBPx5BLN+wEzH/iZmbsZ5SdRFgdUoYYSmIQ9wDZ5E2xW4H4S1yJt48gUH5ZTIN4bvuHbtaUxprH/mqxu32XaWKlCouZIrd2H5e0gDgYYf2OVrqmRiZh0KuR1ZDDI6/u7VN7la80AbpiIrZwxhAjfOAAWnYnawiwqT6qOnqvacFVD6la6fkTZumYqdq3NzXg0zl0ekUvGY9wwG9NGm33iMidA/N9l6tUrqWPtVzupTFTuimc7hJjsd6lPF8QvwyUPSx+HYIZlrVutEt1JvMaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPMj/moO5TcJNWA0d7vQ1RQpB4J/DM0ahlI64oSSiR4=;
 b=Z2gcpa6BhXYnge8ra4rw9KBZOp2lnYebPgfKmO+tA/0pSwB4/xyIga8/G1err/BA9ulDUl5V0x9Rs8/LAZw53VaveCkSkj7SDB7HHZG4ii42s5EMTHACnd8TWaLqSlqHfMaJ2nVOqvjTf3YxoJwdxE4K0bQpZijC3AGSsa6aNaao2bW9DwFu0RxvanX1sIZvWZaZ4aXwB+YPZrnjfs6ms1MLoX25LFbZDGvYlwX0fMAsdBOs2SavtgrlKM288ZcFzIK3/9MZd87Ja8WfW8Qofu+zLovfIgksJkZ0LFA0HsP2TNZKKoZrDGvg3SIX1RXKNsThUnmGPnT66bYVP4prFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPMj/moO5TcJNWA0d7vQ1RQpB4J/DM0ahlI64oSSiR4=;
 b=nCTCsMFbH6ReemYO+51B1o+cQWDi4l3YHgHu/7DYwhSs5OEqkBqawZ6ms5BBjZjjlWxjQEDIGdTpszk2lHOZfamz0uAFtLBYtX6pERPsZg85bg3jTEJe8pYxuHVSU3ie9DXtUC6g/CR24aCDmPbhtlX0MkF/wITp5nFLX2FKsbiTBZGJF4lyFFlmxL8/Zmeddw6JfuL520A8KoS/+AVag2WvmwApa9bEocQCU0Ysb3NLw4GD0dHi3P7AXYFb7LzKjliNtDqAyuVDJFc/0fZpTqN8nfydNmwhmkeNNPJ/UAZXxFbnFqK3ojNf1dj43MJLMlXt5RLS8mh+sk6NAyeSlw==
Received: from MWHPR12CA0059.namprd12.prod.outlook.com (2603:10b6:300:103::21)
 by CY4PR12MB1910.namprd12.prod.outlook.com (2603:10b6:903:128::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Wed, 8 Dec
 2021 08:47:47 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::49) by MWHPR12CA0059.outlook.office365.com
 (2603:10b6:300:103::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Wed, 8 Dec 2021 08:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 08:47:47 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 08:47:44 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 08:47:40 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Dec 2021 00:47:39 -0800
To: <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>
Subject: [PATCH v7 0/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
Date: Wed, 8 Dec 2021 00:47:26 -0800
Message-ID: <20211208084732.23363-1-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a796d66a-3440-4bed-c5f8-08d9ba2768e1
X-MS-TrafficTypeDiagnostic: CY4PR12MB1910:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB191064A12897C2F1DA44F3A2AB6F9@CY4PR12MB1910.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbCwqr6zN3HHpYuOmGlt5DSoz2rsjHd9pVmg8eDU0d8kzzWMahOJYfdd+laMxe3rhOX3KLmu4+HhG1TDTsFnQSU/Y5LRRTEPHDxRaa2ztqnow6AM4wxws3E5PUirqA0sWuMIYVZ6OKk2wWIDFLMuuTZ5NSIWJiMeHC7Qyajj8w/0MZz+Ij+tKBu7iVnyPI2Jd+iP8gtYtfr3C2rbZBGn4QY4rUVkRSvzTIBG76+FijkryOv+W1whyWlO1YJborWNKUDBNIAx/HxsUXVIutBF5aF18E6zLuqxxw1R9/HOaPi2D0mOq9PKvBJlO0dEawD3FSMlxF4CefWrnC/m0f7x+AO7UhR+Aa0CxXNhJvv1O4/xXBlnPbb3WmEHSD1eclnjznkYHF2W8t09RgUXaAKGGGeIJC1RERQfMn6nvUbyvpSHSIN9gOJZTnGCEUAtT2TizTbjFbL9GNS0Yh6ofsY7ZrbSZBu0vWEeokYF9tWQvmv+uNCPw1YJc36vPDUre3A9/RHxrhx28wLYGwAi+US5npff+LtDuUEKEr3WJySrZvBd51RObo/7JwKuGllVPs/ooJHBE0ufxLrVWkQo9JNznKdHm/aXGAr0EsZs8PpjkWHK3KZY0A2fZ/ihUSr4ce7/spgfRWoFsC0vgfxr4bKaA57A3Fol8S7U3VB++3bL3t7YiZCSWIunf2D5UfIAH7tbbi12iZ2MFrQv2EQdDqwYoNit3KZReVUiJsMjx6cqpr9RDaCsNYvCtJLJ7yilRHfN5shK0/DGPFHasUQZRKeu5vGOfQ2O/XPnQ6HF9lPWrTVHczcq7zXukN0Hn5mbtWzFvbrlsq/OqtLVsVKbeSs187KKh+/HRXDzXYYAcDBZFnC8y+lrtQaGD4vD9EuffuTp/1C0GI0YCV7gq44mVHIFu6mzcY2rfbXTaCCJHO6UYCM=
X-Forefront-Antispam-Report: CIP:203.18.50.13; CTRY:HK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:hkhybrid02.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(26005)(36756003)(426003)(2616005)(2906002)(336012)(186003)(5660300002)(54906003)(110136005)(6666004)(966005)(7696005)(316002)(36860700001)(86362001)(8676002)(8936002)(82310400004)(70586007)(47076005)(40460700001)(508600001)(1076003)(70206006)(4326008)(356005)(34070700002)(83380400001)(7636003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 08:47:47.2316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a796d66a-3440-4bed-c5f8-08d9ba2768e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[203.18.50.13];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1910
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, digetx@gmail.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This series of patches adds a new mappings node to debugfs for
tegra-smmu driver. The first five patches are all preparational
changes for PATCH-6, based on Thierry's review feedback against
v5.

Changelog
v7:
 * Added "Acked-by" from Thierry to PATCH1,4,5
 * No other changes for PATCH1,3,4,5
 * PATCH-2: dropped "s/soc/group_soc" change
 * PATCH-6:
 * * avoided forward declaration
 * * dropped castings in pd_pt_index_iova()
 * * used "'-' : 'S'" for non-secure attribute
 * * changed multi-line outputs to single-line format
v6: https://lore.kernel.org/linux-iommu/20210915043806.GA19185@Asurada-Nvidia/t/
 * Added PATCH1-3 for better naming conventions
 * Added PATCH4-5 to embed previous struct tegra_smmu_group_debug
   into struct tegra_smmu_group
 * Dropped parentheses at SMMU_PTE_ATTR_SHIFT
 * Dropped swgrp->reg print
 * Replaced ptb_reg contents with as->attr and as->pd_dma
 * Added "index" and "count" in the PD entries for readability
 * Removed Dmitry's Tested-by and Reviewed-by for the big change
   from v5 to v6.
v5: https://lore.kernel.org/linux-iommu/20210315203631.24990-1-nicoleotsuka@gmail.com/
 * Fixed a typo in commit message
 * Split a long line into two lines
 * Rearranged variable defines by length
 * Added Tested-by and Reviewed-by from Dmitry
v4: https://lore.kernel.org/lkml/20210315033504.23937-1-nicoleotsuka@gmail.com/
 * Changed %d to %u for unsigned variables
 * Fixed print format mismatch warnings on ARM32
v3: https://lore.kernel.org/linux-iommu/20210315031530.GA15245@Asurada-Nvidia/T/
 * Fixed PHYS and IOVA print formats
 * Changed variables to unsigned int type
 * Changed the table outputs to be compact
v2: https://lore.kernel.org/linux-iommu/20210312010932.GB29926@Asurada-Nvidia/T/
 * Expanded mutex range to the entire function
 * Added as->lock to protect pagetable walkthrough
 * Replaced devm_kzalloc with devm_kcalloc for group_debug
 * Added "PTE RANGE" and "SIZE" columns to group contiguous mappings
 * Dropped as->count check
 * Added WARN_ON when as->count mismatches pd[pd_index]
v1: https://lkml.org/lkml/2020/9/26/70

Nicolin Chen (6):
  iommu/tegra-smmu: Rename struct iommu_group *group to *grp
  iommu/tegra-smmu: Rename tegra_smmu_find_group to
    tegra_smmu_find_group_soc
  iommu/tegra-smmu: Rename struct tegra_smmu_swgroup *group to *swgrp
  iommu/tegra-smmu: Use swgrp pointer instead of swgroup id
  iommu/tegra-smmu: Attach as pointer to tegra_smmu_group
  iommu/tegra-smmu: Add pagetable mappings to debugfs

 drivers/iommu/tegra-smmu.c | 301 +++++++++++++++++++++++++++++++------
 1 file changed, 255 insertions(+), 46 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
