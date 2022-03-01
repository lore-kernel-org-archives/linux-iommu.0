Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0E4C433F5
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 08:57:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C03081A0D;
	Tue,  1 Mar 2022 08:57:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YWXUkga3rbZG; Tue,  1 Mar 2022 08:57:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5684D81A24;
	Tue,  1 Mar 2022 08:57:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A862C007B;
	Tue,  1 Mar 2022 08:57:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB607C001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C744F4136C
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:57:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pgIKKMU02Oq0 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 08:57:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::62f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 629ED41299
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 08:57:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZWFMLlcRARKHD9tGKiRU48X6PB1cXSbKf3VSTreYMMjkDoGWFZiadHzDw3hIFv4nopn6iiuJRF0vn3tJ3Za0jFrHVbsJJQPlnm6YUnVNTh0LOQv7BPFOG2ssuYp/C59z8GmUGJPOAZkFv1IsrjMl3+jdtcM4qixgIzgVdY7L0C2deHq5m2J6ycIKLgAe/+aW9PCvIOXYi+YkhchQ12JqQVRnlHLKb3oNnIlRkJsrZpltMfncI0aMNqYHTGDaPid9v2gbvv4i8zlW6gdN2f7gcNnf391rLb2K0KWmJDfwMxZMzEIYyJe7Lkaf9a5ed1EKpKAdkNCWMT7fDjTSZptAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOATbEWG1QXGY5nSw5Gb8Jii+BpgCtO+cwuD95erw/w=;
 b=VXb4Kn1yEL1bRPj3rUmOL+N65wFdXeFry43YA8Ao3E/rfv/sD+jqtL7Gmi13EU9G6StsGDbkaFLrhYI2hWCCJW5wyCAxH/mSJJGeTJk8zKHRK3jGdOqPFwObp8VuJxCbtp8pA41afBZqoFK6dWiJ9tQgRNTOxI9XU8MGJQTzRNPmJLyiOa+g4mHUxZJvLyR1QO/uWcwj76HqrckiC9LanUmXNlqA9i+P+fp6xwMx7rIcHH+uvXsfE9gGnaQm9OMq3mDiOyjwnjSgHpiKNg+py096GIGUo6B4vlIbiBZAGxZTQ+vBGm6Gmnai4/3jczZp6K7mhrPYc3rgr+ZMU3tvWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOATbEWG1QXGY5nSw5Gb8Jii+BpgCtO+cwuD95erw/w=;
 b=QUWgvXzAh3mpoiNzpWn9MnRu9KGYislzkCb7OJ0R0NA4Ng/zokKnT2ShiBWKhYtva+NAl/aBW+mbQb6iTNkInVIqcyVQQTGwnjgTumQl/utv5uHpUONN0SgIXlWB8SWo9CXaCWFw4EJ/K87IouZ0LX9LRKlvZ+U+6K/cjfiwAYc=
Received: from MWHPR21CA0042.namprd21.prod.outlook.com (2603:10b6:300:129::28)
 by DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Tue, 1 Mar
 2022 08:56:59 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::ba) by MWHPR21CA0042.outlook.office365.com
 (2603:10b6:300:129::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.1 via Frontend
 Transport; Tue, 1 Mar 2022 08:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 08:56:58 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Mar
 2022 02:56:50 -0600
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 0/5] iommu/amd: Cleanup and fixes
Date: Tue, 1 Mar 2022 14:26:21 +0530
Message-ID: <20220301085626.87680-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff261f18-1934-4c92-1ba0-08d9fb6171b6
X-MS-TrafficTypeDiagnostic: DM4PR12MB5103:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB510364AA3A719F451D60210A87029@DM4PR12MB5103.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P8necD74AKSmapTbP8sHmtQvIwF+uLQ25ROyIxGvpToTdxwhTIp/lMwBxblrwK2hJ7Yp+uCS/2d2JWjWwhW6au1VQ0zgicEYj2Bb0v4ygGvygi1PCbBRy9c2ChVR2nMAlsAhwFQhSY7lXJzUIZPhbe5lRvcWxW3rPikW2u8BVnunyCiZAlARwzMOVNpIMo/GhZkZJpQRUcrtOJi3d/UtacjaI1yla5+Xm6ZVQu8CWFsuJy5LVgYabqlrxXsl+RSTokOm/KCCze4FN7iAUEwi4JaPt07FnZMVjRmjVuKop/lEpe579i714qlZ4VmZNhBiby8986wGfzCt8LBIj2kBL8eKDfyMvA3ljn94z0zaBctLMU7cFaahytDl72Wv/FGV/eIqOQNPtzvvr47u5Srk52+8Y4KqSw0BXUDkHmznL6VO6dQVBlqWCrNhTHwG+W52I1zsoLpOik3xNka1m+6synIEsFLvYW7OfET31bstjormbrYhckHFSP7UKObvZx4SemJOrFUgpBoDSNOSiXOtICIuthY+Chkp9T6sn/i470rtt3+zz9mmxNF7TVgnv/6+rveeuWfTq/ULvLNu+TcBK3zPpeHOMMz15ebFj5ZE/jRyVgyCkLNrfuLYma1RnXBykvGw85rchmYEDvsswHXElSmqNSeb8g3/Cj/xT0DZ4eU+hMSArrDrG53ltI4499EFhnRWkWZm4WDq0GE2hs7SZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(2616005)(86362001)(4326008)(336012)(426003)(1076003)(316002)(8936002)(44832011)(82310400004)(70206006)(70586007)(8676002)(2906002)(16526019)(4744005)(26005)(186003)(36756003)(356005)(81166007)(6666004)(508600001)(54906003)(83380400001)(110136005)(36860700001)(40460700003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 08:56:58.5920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff261f18-1934-4c92-1ba0-08d9fb6171b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5103
Cc: Vasant Hegde <vasant.hegde@amd.com>
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
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This series contains various cleanup and trivial fixes.

Changes in v2:
  - Fixed error log message in patch 1 as suggested by Joerg.


Suravee Suthikulpanit (2):
  iommu/amd: Improve error handling for amd_iommu_init_pci
  iommu/amd: Improve amd_iommu_v2_exit()

Vasant Hegde (3):
  iommu/amd: Call memunmap in error path
  iommu/amd: Clean up function declarations
  iommu/amd: Remove unused struct fault.devid

 drivers/iommu/amd/amd_iommu.h |  4 ----
 drivers/iommu/amd/init.c      | 18 ++++++++++++++----
 drivers/iommu/amd/iommu_v2.c  | 35 +++++++++++++++++------------------
 3 files changed, 31 insertions(+), 26 deletions(-)

-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
