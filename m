Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7249C433EF
	for <iommu@archiver.kernel.org>; Mon,  9 May 2022 07:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8483A81A30;
	Mon,  9 May 2022 07:49:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rCbx8uA2jTo3; Mon,  9 May 2022 07:49:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 699B58199D;
	Mon,  9 May 2022 07:49:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40D5CC0039;
	Mon,  9 May 2022 07:49:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95215C002D
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 07:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D9F441513
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 07:49:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BsyhK4MTN6eg for <iommu@lists.linux-foundation.org>;
 Mon,  9 May 2022 07:49:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB6574150E
 for <iommu@lists.linux-foundation.org>; Mon,  9 May 2022 07:49:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVYPWKvCb9obsQ7jvvYHvHUtwPf/3sIyn1qtrECkaEbbyp+dYqlSmpWxB+w52ARoaOPlOK3DpUc7613uWq4PDMu6+M0FF04ckil010i9MgVStyvpU9ZFzIx5qoin2M/v3D5VpxoMx4Z91Y95UQlXzLNNa0Yi1jhNqkOBgWXC1sooQjNbbC+4+dB+CInrBO6dfkAeI4zTGSu45Ncj82rL0dsfenwRXv3XMGQfcQpjnHJn7u6o2Q5GauHsYvfz8FD/Kf/QKxHceHuc+WbOHnbUawrN2WpkKKyEymRkaI/wW05pMne0e++4cXKIMf4zfn//cY3NZ+tu/sGMWF8iyGMMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S58AkRv4Womp2Hi+k8lDsR3Setl6WEB9KBjy3HrYeC0=;
 b=eQ3Chlt2bcpKd+WC9VnQkmZJuL39YN7/b9t5pp8+g5jEnBwVl4q9spIf4yjiq8ZsICGdyJhJV3juQLttL3Xf8fqIUTqyhc9mJ+dYReovYsE9S3X1zVnQoIThRYbPgTvBdyR1trb8DUxlSt/kjdOuo59T0dnve3w0E8W1a+rAF47Cj+vtfYjmuGGLZPvCgL4fK3jdHXN1Uc63mPpV6X5QXffmBUn5syuyEXCVbQWbyRTKujaxWKvl1d/OvYHXa7/e4+oC3IPBVMbBQgQkhZkG9N+rtOwQbIJmyF7EDuUmeR6HF0Ac6K8QmYqAScG6TlN3i9Ep9/kQxA0HQyvzZirvLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S58AkRv4Womp2Hi+k8lDsR3Setl6WEB9KBjy3HrYeC0=;
 b=GBk+yyrQVHS/iba1H4UCBB3wjuxHMaEQcNS/T5Huan6V8JpFKHe+7sR+XFRcOVzTt4PIYIjCZYvprc2Knjk4OsDn8qdy6BUaoqW4VGoq0aT1+PTiOcfjRyGZ+r3AZ1tFrUVTjez5x1qh2aVbiWDQFCSGV/4UIi9ucAbKpi4VSIk=
Received: from MW3PR05CA0021.namprd05.prod.outlook.com (2603:10b6:303:2b::26)
 by BN7PR12MB2787.namprd12.prod.outlook.com (2603:10b6:408:2b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 07:49:01 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::c4) by MW3PR05CA0021.outlook.office365.com
 (2603:10b6:303:2b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Mon, 9 May 2022 07:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 07:49:00 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 02:48:29 -0500
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Subject: [PATCH v2] iommu/amd: Set translation valid bit only when IO page
 tables are in used
Date: Mon, 9 May 2022 02:48:15 -0500
Message-ID: <20220509074815.11881-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb7fc74f-7fd1-4968-ce76-08da31906184
X-MS-TrafficTypeDiagnostic: BN7PR12MB2787:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2787A6D9D04C4227DB02159EF3C69@BN7PR12MB2787.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WBqzGVrKmY4Y+6JFRvjVywmqG4TQlUl0zEaP2BDo+JVhJG6JFvH3dKMjQJ7MC4Ly4UEINoKlcKXzmnxv5E+s0si3giF+SJojXrfewwfLwKDPpOALfcWeIAKODojIDNxts8erHk1vlCLd1AO55tmPkiz/Ph5e5AVqEi/lVQDvvVWfgxLTRdFHc+0mBaXaG+7dl2dX7FsBjZeA5veZCTCE52z0OKJ0ekJ9pOv8rW9Wmms01zGz2sV5hyUISi20GIIB62iu+J89Tbvmh0GlVBu9674zS66J8VM84Kfa7KjtlFuLN84VfmjA2mI9pc1BBAQrSWVSi29O1g/IZ5pG/qXUm55v6RfHliinQrWsQghgcriYC5+Ux4xsX87VwI4wZudk0lZxjfjJD17m9ixsYG/K41E8n0tZMr3fmolxaNaq8VKgl4ft57lF5qyNFZmkMD7WheXJbFEb+sZsr+kLfT3wHOkq45Vn4EdLZnWD6X+c4qa+xJec09TeLy4/OvpSFStc7mr/Ggcrh5cYW9bMEHlXNkgDS2QvsaYXj8leKKJcmi/8oq5f+MqGQrWfGygr8oMic+eauN1YMwu2RxFhgMDekCCrerLh7lm7Ox0HmbXNHUFQovvoRoezVuKlrUO0wgUXAxzpUnv4kv9l1uHvBgZahSMQJF2Dt6zeS9ckFRGERte/TGRv3WabYVG3V4lClbj1FIhzTyratZ5JNyytWCeWqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(16526019)(186003)(83380400001)(36860700001)(26005)(1076003)(2616005)(7696005)(6666004)(2906002)(44832011)(36756003)(426003)(336012)(82310400005)(47076005)(40460700003)(508600001)(356005)(86362001)(5660300002)(8936002)(54906003)(70206006)(70586007)(8676002)(81166007)(4326008)(316002)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 07:49:00.5460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7fc74f-7fd1-4968-ce76-08da31906184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2787
Cc: jon.grimm@amd.com, vasant.hegde@amd.com
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
From: Suravee Suthikulpanit via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On AMD system with SNP enabled, IOMMU hardware checks the host translation
valid (TV) and guest translation valid (GV) bits in the device
table entry (DTE) before accessing the corresponded page tables.

However, current IOMMU driver sets the TV bit for all devices
regardless of whether the host page table is in used.
This results in ILLEGAL_DEV_TABLE_ENTRY event for devices, which
do not the host page table root pointer set up.

Thefore, only set TV bit when DMA remapping is not used, which is
when domain ID in the AMD IOMMU device table entry (DTE) is zero.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c  | 4 +---
 drivers/iommu/amd/iommu.c | 8 ++++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 648d6b94ba8c..6a2dadf2b2dc 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2336,10 +2336,8 @@ static void init_device_table_dma(void)
 {
 	u32 devid;
 
-	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
+	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid)
 		set_dev_entry_bit(devid, DEV_ENTRY_VALID);
-		set_dev_entry_bit(devid, DEV_ENTRY_TRANSLATION);
-	}
 }
 
 static void __init uninit_device_table_dma(void)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a1ada7bff44e..cea254968f06 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1473,7 +1473,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 
 	pte_root |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
-	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V | DTE_FLAG_TV;
+	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
 
 	flags = amd_iommu_dev_table[devid].data[1];
 
@@ -1513,6 +1513,10 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 		flags    |= tmp;
 	}
 
+	/* Only set TV bit when IOMMU page translation is in used */
+	if (domain->id != 0)
+		pte_root |= DTE_FLAG_TV;
+
 	flags &= ~DEV_DOMID_MASK;
 	flags |= domain->id;
 
@@ -1535,7 +1539,7 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain,
 static void clear_dte_entry(u16 devid)
 {
 	/* remove entry from the device table seen by the hardware */
-	amd_iommu_dev_table[devid].data[0]  = DTE_FLAG_V | DTE_FLAG_TV;
+	amd_iommu_dev_table[devid].data[0]  = DTE_FLAG_V;
 	amd_iommu_dev_table[devid].data[1] &= DTE_FLAG_MASK;
 
 	amd_iommu_apply_erratum_63(devid);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
