Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C04C433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:29:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE70741883;
	Wed, 11 May 2022 07:29:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b0ETE_-r6-bw; Wed, 11 May 2022 07:29:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 63E2F41889;
	Wed, 11 May 2022 07:29:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CD2CC0039;
	Wed, 11 May 2022 07:29:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73B73C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:29:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5306540B42
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:29:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1aesBBNcvtvb for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:29:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::620])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9148940B4D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:29:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S63ZOnvJPeGa7L0Km1wjregzRjbYZOSkp2QZHrPPJZxYo+ZIt7C16eP521f8RgpBiIxDk4J6nXtKvfwLWDovvDbqPstqZUzCGdIZ09oc77JlKwhrcLzVcv2bA5dl6F5Zt0KhN8hoDa+3Hhip70cN0go9uNn6yE9Jvre75NlSsBN0Q2RNf1EC7YycJvsQVxsc2T4YojXuNYScpe0qUxd9iIyIu7dDK0SMwT86Uedt3MthtHBZVPl0TIUVbwJOVDe1GNTOJZorWWsVfEUGn5d9Oe3iRqbOF7YnEFU6ddUQGjii0jBeXT22vAAocXjqRQl0+zTK468YQhZIOc6NXh4tTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxOsZsD/ckPukp4fV5UoZ1yuS4AVx5ros/RL3GdlB4M=;
 b=HkjSVqfj87RprnWha/5m2wZa2HqvqJDdDHsNlJoZxQvuNhiAmMmfjwkDzQ+72F0Hu2Pqbi4Y4zcacKtXKQw3/O1lsRnUIBBSdL3dVsQumjhGGDDm1fzX1UGU9yIouCfhSAyREJnqRBeu4GowCk2DId9EeQ4ltZPEVNdJG6/T+8GXK3wr8tBhuN4wyyGmkKCUONd1vH8Od2Z2MptkXR8CLAXVlxnyfsWz48jY8YDGk8OXJWFiVL2St7XHwOy1eqDivtcM4pwHFbOIXf5pM6MiX7/rUEotyzqEsIshFgl2P/AFlJydBfrP7lhfXt+zjlZfl+xff+kfEy4LKb1ZFGFEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxOsZsD/ckPukp4fV5UoZ1yuS4AVx5ros/RL3GdlB4M=;
 b=yJL+XNUCqsbEzmrPK5Qj75gNZS5RSlLucun0mpRWgpU1RLCyKY1wbyGSYPG1wGFsz/lOFxZPkzbgjBY3MovhmNCat4rmcC+7w1Uwg8BqQwoYVp8RREW2ob3YC5RnOnc6w0Kb1NCEAAvhNGi8Cy+NZYW1lQJubJIS5M4QUx8Pxvs=
Received: from DS7PR06CA0040.namprd06.prod.outlook.com (2603:10b6:8:54::28) by
 MWHPR12MB1727.namprd12.prod.outlook.com (2603:10b6:300:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 07:29:19 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::39) by DS7PR06CA0040.outlook.office365.com
 (2603:10b6:8:54::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Wed, 11 May 2022 07:29:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:29:18 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:29:16 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 28/35] iommu/amd: Flush upto last_bdf only
Date: Wed, 11 May 2022 12:51:34 +0530
Message-ID: <20220511072141.15485-29-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 710fdd4b-30f0-444b-2f7e-08da331ff5d2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1727:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB17270F9F9FBA1CA1983D81C987C89@MWHPR12MB1727.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmVP9WWdsfE4F/8oDDrGv4+Ufft/bmqXRZ9PRDKvT1dEsKiPU9jvg0Z57jCDWW+gkSf/4gfYQkVxOWOTE7KskUQ6fArimXkWqSuNhwf28djfzzb16KREFdorD5B04cBiaaLdMzITn2EDhtXxkWUqDVFf9LjV0h0eju3zefx3JtjcjtW3dLrqmLwxs19YrxqLmPDutnjz9Gi9ntAhmoRZV2lSFnwZcsalO8qx/WKZ+vxLkr0gJraviHdq7jirySTZVn/D3MkcQOfOHXNIcAozksHhUGzvIzyhsVBI6hQXOrZ30QDOzFzhlW3tq//jca+xhQY7GIZgg68PFZ2l5Vhtg5uafYvscmkSoGg55pwTb84jhliwpNkvx3oRPHj9h1+m22knPPSRtpTybdknky5VdHEq8Yw3O+Dh7OhrnPJAUyf6FYfw4nph4MHFBv4rDU0kw766Mh9OGih2tNsx7CqYFVVnH0sRrH4v8LiqJYKLJ6zjBSDF0es7MWyFijQYONfjX4LyCqIrEqXQKKEIYSoL0eXZTWO2irvT1U07VbLU5UDYWV0EpWkC9dba2+H95LgrZTUJ5sHAxOv7PtbPOloi/hpJPYT43Ll4MotQVsuzlejf4wBxRMsxgQy0Hh8sszlYKvA8M25SqPPVeAwkEs/vk5E7uh+MtKcM/rGr6qM+b5baGk0tJAJFx9bqHgWP25fmkFCk02Bti7SA74NHZ+mZng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(2906002)(70206006)(8676002)(356005)(6666004)(40460700003)(1076003)(70586007)(4326008)(82310400005)(336012)(426003)(2616005)(186003)(26005)(16526019)(83380400001)(36860700001)(6916009)(86362001)(8936002)(54906003)(5660300002)(36756003)(508600001)(44832011)(81166007)(7696005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:29:18.6604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 710fdd4b-30f0-444b-2f7e-08da331ff5d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1727
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

Fix amd_iommu_flush_dte_all() and amd_iommu_flush_tlb_all() to flush
upto last_bdf only.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c21346e48bcd..68ebbccef5c4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1191,8 +1191,9 @@ static int iommu_flush_dte(struct amd_iommu *iommu, u16 devid)
 static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 {
 	u32 devid;
+	u16 last_bdf = iommu->pci_seg->last_bdf;
 
-	for (devid = 0; devid <= 0xffff; ++devid)
+	for (devid = 0; devid <= last_bdf; ++devid)
 		iommu_flush_dte(iommu, devid);
 
 	iommu_completion_wait(iommu);
@@ -1205,8 +1206,9 @@ static void amd_iommu_flush_dte_all(struct amd_iommu *iommu)
 static void amd_iommu_flush_tlb_all(struct amd_iommu *iommu)
 {
 	u32 dom_id;
+	u16 last_bdf = iommu->pci_seg->last_bdf;
 
-	for (dom_id = 0; dom_id <= 0xffff; ++dom_id) {
+	for (dom_id = 0; dom_id <= last_bdf; ++dom_id) {
 		struct iommu_cmd cmd;
 		build_inv_iommu_pages(&cmd, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
 				      dom_id, 1);
@@ -1249,8 +1251,9 @@ static void iommu_flush_irt(struct amd_iommu *iommu, u16 devid)
 static void amd_iommu_flush_irt_all(struct amd_iommu *iommu)
 {
 	u32 devid;
+	u16 last_bdf = iommu->pci_seg->last_bdf;
 
-	for (devid = 0; devid <= MAX_DEV_TABLE_ENTRIES; devid++)
+	for (devid = 0; devid <= last_bdf; devid++)
 		iommu_flush_irt(iommu, devid);
 
 	iommu_completion_wait(iommu);
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
