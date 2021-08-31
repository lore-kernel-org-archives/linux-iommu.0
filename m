Return-Path: <SRS0=eAvY=NW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0421AC25AEC
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 03:07:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A9E61041
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 03:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B2A9E61041
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C45481CA7;
	Tue, 31 Aug 2021 03:07:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G3z4_bmPZOBa; Tue, 31 Aug 2021 03:07:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AB55981CE9;
	Tue, 31 Aug 2021 03:07:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC0F4C0022;
	Tue, 31 Aug 2021 03:07:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61F28C0024
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:07:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF00760B94
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:07:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AQnny9YMGFrH for <iommu@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 03:07:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2079.outbound.protection.outlook.com [40.107.212.79])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1C49F60B9C
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:07:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xe25dmT4CjzM7lkf3zGv6Pbl9uPr5GUHQgXLrgIdn1qX0Zkiji919TroAUMhWcmQn5t2gkPqxgdG4GBWIt0FD8Pj1jTbV8qQjs2X/h0Pk9XN2f73JZe94Sz4CwQDaA/BilwiW0QWcwhvmyi6O7ept3NcMU/04sEUYPLhauGQYHUs4Ng2XUZ4QcuejFuANU3/Gbs4SH8ALwvcLg8V6CiYTs1vTVH86BU6ssJlRbzg2JnlKNBh4vflwhZPTvn62ONau9knwltdd1lCs/cVCwtnqG3rvmmZJziSZcA0npn/nqseLb9GUoHQYs8Gh9AaVvQxHEQaQ4xLuBRydf47QWSx+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmceKKA4DlR8NrfAruAbqTlebZGGcOdEDzUTZhSWLDQ=;
 b=N/7kPwO7FTFckm4RD7Mws+/hmF+1GcHHkuCe5gpzfOShkDhq7CwF1uyWc2qZfT3YQZBH8E/CIZhoumv1G5DxnFu6desTjl3MP9JYyrDvbssUYgdT+hng9EKk7cmmIcbenrCAOOIxK0sQmFA1mCajXzUmTVJmCyxIqwdyTf2pl+RwxNrCFeKitILO/5zn/VYUixsHcH7IEJWtOan8pxYaoCqD1yHdaKh8co+w2/X2sEhPT/Ac8N8W/Pqt1RQbEWyNhTSEUgfy8AbCnaX8aBFdMzmhZM/iHXbU7WLCCW/m2q/iaMszjPXWmqwbTl/2DcaBV7lIEL0fV9nkVYBmg1E28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmceKKA4DlR8NrfAruAbqTlebZGGcOdEDzUTZhSWLDQ=;
 b=kbsZczzEJk6CF10p8AhPreAIxw+kcLEIttfb8VjAU9sCfWFAQ3kwlYZdvieRrn0XO16ArFJ3dkuwSICDMGCYRdfLnnJk7HBJy5jLviMXPSU9uL+LsridI1w2Q8PKFkzF2OyAdEL6fVuiJJISlyBegDyduN6QiWLDIdRz4b7MK1T66HY6MoRyJ3ADsZphtVcWrlQf8YNdwatGNt3mvLE36dLUqb5fLEEVVtkBKB6xYoLQMHr/vjvjvBYfn7lGxD4nOh6QwhfUgLDg4Rnt0DVFVBNgMBVhbVfNdqonhbrGyMh7Ugwb6ROBZkW4R8BeqRzK9xYwwwSXRSGguHFsGZIAbQ==
Received: from BN6PR16CA0041.namprd16.prod.outlook.com (2603:10b6:405:14::27)
 by SN1PR12MB2351.namprd12.prod.outlook.com (2603:10b6:802:2b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Tue, 31 Aug
 2021 03:07:32 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::70) by BN6PR16CA0041.outlook.office365.com
 (2603:10b6:405:14::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Tue, 31 Aug 2021 03:07:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4457.17 via Frontend Transport; Tue, 31 Aug 2021 03:07:32 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 30 Aug
 2021 20:07:31 -0700
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 31 Aug 2021 03:07:30 +0000
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
 <alex.williamson@redhat.com>, <cohuck@redhat.com>, <corbet@lwn.net>
Subject: [RFC][PATCH v2 05/13] vfio/type1: Implement set_vmid and get_vmid
Date: Mon, 30 Aug 2021 19:59:15 -0700
Message-ID: <20210831025923.15812-6-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210831025923.15812-1-nicolinc@nvidia.com>
References: <20210831025923.15812-1-nicolinc@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3c16393-82d7-410d-6336-08d96c2c79a1
X-MS-TrafficTypeDiagnostic: SN1PR12MB2351:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23510283BEF2C0517B131D75ABCC9@SN1PR12MB2351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:41;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3nTY4XKcbzTUX7bD78bfAB79ouiZVY4k+E0QjrhbKG9eYSqgibYQVqW/zbT50jxPKlwPrpk/kA2/dWbYW0Xa0nYkNulW8iPtZBnUpq6+HJX0viDP452KpsC+xiG07REmWRwogMBirlnaHR6TbkQoNODsFQQabUNoo67jrBY8/IlMcf5cfgYmYUfQJDuaLAfwhauUuLRf3vhGw594J4T9/eAXSfPsVvpAPJcBT4nFh2o2RU3jCIRABlMs6VUpsrQQ9s3E+UaHkeH+zLgaHUnAc9MFMDU9UdxdYFiCcKcrWEp433f2Eutqwmrn9TImJS5Rd1+u2iGYD7Evd6U2v6bjTiW5m4tRP8qC/cmBj4mDL1p8TiXHk3YcKM+S4HEhvABY/+yeu69rIFqtMjON7toF/JMMJIAqXGmBLbcwerLv82sAiF3M8UpWm7IMUU9Z9gV5TRL5OoJuL/78zFxYacwBQs/fjQ4si4+G/WF4eSP9DFnMZh29jnvC6eNMT3Xk0taqADsz0ewEIfhvPB+XvLHEh7cv05PNjewO9VrOyOHdJrUtn0z10KoNZyb3S0nmXLgt6YADZ5j3dkjbUg1OolbwLxryJA91O2eOPzddUr4fQvuM0y1T+dGEVm8mfD8LXhOAB4sNmGNQLKOYEMsRduRsybkP7nNhzG8imaB9pSu/C3+udjzQsvAb9Y2aypLZLjEjIY1ciztJRd6egWx2r0Nhgq64Dnr3S0lDBHdz91oTF/Y=
X-Forefront-Antispam-Report: CIP:216.228.112.32; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid01.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(36860700001)(36756003)(6666004)(70586007)(82310400003)(70206006)(426003)(83380400001)(47076005)(8936002)(8676002)(336012)(2906002)(26005)(86362001)(7696005)(4326008)(110136005)(316002)(54906003)(1076003)(5660300002)(7636003)(2616005)(508600001)(7416002)(186003)(356005)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 03:07:32.2987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c16393-82d7-410d-6336-08d96c2c79a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.32];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2351
Cc: jean-philippe@linaro.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

Now we have a pair of ->set_vmid() and ->get_vmid() function
pointers. This patch implements them, to exchange VMID value
between vfio container and vfio_iommu_type1.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/vfio/vfio_iommu_type1.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 0e9217687f5c..bb5d949bc1af 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -74,6 +74,7 @@ struct vfio_iommu {
 	uint64_t		pgsize_bitmap;
 	uint64_t		num_non_pinned_groups;
 	wait_queue_head_t	vaddr_wait;
+	uint32_t		vmid;
 	bool			v2;
 	bool			nesting;
 	bool			dirty_page_tracking;
@@ -2674,6 +2675,7 @@ static void *vfio_iommu_type1_open(unsigned long arg)
 	iommu->dma_list = RB_ROOT;
 	iommu->dma_avail = dma_entry_limit;
 	iommu->container_open = true;
+	iommu->vmid = VFIO_IOMMU_VMID_INVALID;
 	mutex_init(&iommu->lock);
 	BLOCKING_INIT_NOTIFIER_HEAD(&iommu->notifier);
 	init_waitqueue_head(&iommu->vaddr_wait);
@@ -3255,6 +3257,27 @@ static void vfio_iommu_type1_notify(void *iommu_data,
 	wake_up_all(&iommu->vaddr_wait);
 }
 
+static int vfio_iommu_type1_get_vmid(void *iommu_data, u32 *vmid)
+{
+	struct vfio_iommu *iommu = iommu_data;
+
+	*vmid = iommu->vmid;
+
+	return 0;
+}
+
+static int vfio_iommu_type1_set_vmid(void *iommu_data, u32 vmid)
+{
+	struct vfio_iommu *iommu = iommu_data;
+
+	if (vmid == VFIO_IOMMU_VMID_INVALID)
+		return -EINVAL;
+
+	iommu->vmid = vmid;
+
+	return 0;
+}
+
 static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.name			= "vfio-iommu-type1",
 	.owner			= THIS_MODULE,
@@ -3270,6 +3293,8 @@ static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.dma_rw			= vfio_iommu_type1_dma_rw,
 	.group_iommu_domain	= vfio_iommu_type1_group_iommu_domain,
 	.notify			= vfio_iommu_type1_notify,
+	.set_vmid		= vfio_iommu_type1_set_vmid,
+	.get_vmid		= vfio_iommu_type1_get_vmid,
 };
 
 static int __init vfio_iommu_type1_init(void)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
