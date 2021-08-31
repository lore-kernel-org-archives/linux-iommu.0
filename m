Return-Path: <SRS0=eAvY=NW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB90C43214
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 03:07:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DDA61039
	for <iommu@archiver.kernel.org>; Tue, 31 Aug 2021 03:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29DDA61039
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42DC760B94;
	Tue, 31 Aug 2021 03:07:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KlJjnxUmCClJ; Tue, 31 Aug 2021 03:07:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EA7D260BA0;
	Tue, 31 Aug 2021 03:07:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 712A3C0024;
	Tue, 31 Aug 2021 03:07:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8549C001A
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3C4460B94
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:07:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JaRksOwgcMlc for <iommu@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 03:07:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE95A60B97
 for <iommu@lists.linux-foundation.org>; Tue, 31 Aug 2021 03:07:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq4Eg3QQR/y80Wnl1YFQq3uw0w1BERxc9J16Wdjre5aliTxUHChXnFq6PMGzt7PSm3x/c7AdNq0qki2wgiDZaLPeCHl4cK8FANHCxhJpFWHDwtfDGtowsxxRvAqgiommj4fknS7cMzxC5kKQnP5qYlQfRD0qvZzo6GVC7bClMHvvRT8pD8nyBGZg+FlDl6JQE0UatTVi4ZMlP4qE1jp7OtZBBHIKiMCSAx98bt7MdiZPPoOwv9R286zpBWwOqGT6dvetT2Irdd2p8VAB5zFE/f9rDdnrOwqyr3z+01HfUxQKdlvpQAHwPPW1t5Fn1sb0bGCqcsYw2bep+EulOqCAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRoWwVZ0qFjyy84HJrH7KnAp6D0Tim4zu0pbGXeP1U0=;
 b=Li60Y9CyWh/dEtAnKkr2VUjBYMIVNrvAGhJHq3U+l6XtcylsTWoni2Vhv8qV3MV20zuK8KkJfhYAilitr4pQ16uH9fx9JXV0/BvmtETkDcDSCfW/NwEYO3ki1vvrNTt0NWMY2Ye4WamBjRwq5oqcYwIMFLVIsYbhBpKiWTUOG14AZuMSnNU6WcQQP7U+HhCp6IEBNgR54R4Rqhk6YtDiLVFXcdtliKhkq8h10vPSWdzm0ia4NXmqD/upW8/XltbaifrV9M+THjOEBtH0exApdP3HGYelU2JTbSt8M5wU4Wz5mcMigiYbCrFJynAtFK5u0cNwlLkcUGlTwjN9Sq+lJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; 
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRoWwVZ0qFjyy84HJrH7KnAp6D0Tim4zu0pbGXeP1U0=;
 b=W4sUj1v/EGdu4mFXeCmwT6kFEFSxezJkRhm3n8Si5M1Ukl0ZpOmcQJUCZ5KsG2Hi622ySIAkAS4xhRwc2xKf+LXEfM+uPxmhE+LoWd1QCCJovZM95G2Z8ZWT3XXemzt3ZHihfpTfRlRmc6mnTmHzECl/iBpr2UwCFIJlNF1y0QaVf2Vf9YIQCtNffLhUUPjbmGdb7KLIswKHgL0kx17KtvZoKdpAzfb2bKRsXj3T3T2O7frY524M3i2e7qN9w+9x7gUqZMfFxYptH1h4WIBgMEFP2PBAk+goYvZ6C+HsA0SpHjAvuuD3hTfRF7VKzVhwXSmtmngyOSd6IGrZCCExsA==
Received: from BN9P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::20)
 by SN6PR12MB4717.namprd12.prod.outlook.com (2603:10b6:805:e2::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Tue, 31 Aug
 2021 03:07:31 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::c) by BN9P222CA0015.outlook.office365.com
 (2603:10b6:408:10c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend
 Transport; Tue, 31 Aug 2021 03:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4457.17 via Frontend Transport; Tue, 31 Aug 2021 03:07:30 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 31 Aug
 2021 03:07:30 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 31 Aug 2021 03:07:30 +0000
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
 <alex.williamson@redhat.com>, <cohuck@redhat.com>, <corbet@lwn.net>
Subject: [RFC][PATCH v2 01/13] iommu: Add set_nesting_vmid/get_nesting_vmid
 functions
Date: Mon, 30 Aug 2021 19:59:11 -0700
Message-ID: <20210831025923.15812-2-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210831025923.15812-1-nicolinc@nvidia.com>
References: <20210831025923.15812-1-nicolinc@nvidia.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4956911e-727e-44dc-3606-08d96c2c78cc
X-MS-TrafficTypeDiagnostic: SN6PR12MB4717:
X-Microsoft-Antispam-PRVS: <SN6PR12MB4717B51C508DA6952E77F1FAABCC9@SN6PR12MB4717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: upqo3zLCzUfotU+WTyAYedipiOzp+sb9g8lHi/ujeplvDdrwTuPbEQExnehM1dTycNjwISUFaLbUrLxWSm+io0ubaQzE3nvZArGpjScw3ea8fXQ4fwqEubUbtnjN7GJFpfuksjfzgHHos01E4i2lunWyvhi78VTQROhqLAWaAKwUm1+wBpi7gCqSfda1cb68Yyf5jtrvs4M7fudaNDZdFeev+5MOOzm2pd2SBxxisdwBk/Aw0cAJv2lFFCLxn9SmbSQp6zQiNfFaKvklxHaoSHiIHszpSQVcf2UAcBcWEEVuq6jRoswF3YJE16zWUAs6T874bJ6xqLon+G+1Aakvj2ZZMHiwV39VE5mXx0phbbGPkjVhl9YusCOFn8TW6mxkuykmNhyJVXrom7zTzwFxljOs3kaXNxX4aPnSnuEBIdM8cT0B43qQTk1ND2riXnZsQZOSxyePL27COOPxMesetCpns6LCFwgL070mVnWoU6yespo+LjwdDpv0D16YyrlGuesSgF1pCxsTXCbl9C+ZPgMqSY7cXB1p/dVFa3Wv4Nq1Oqkx2T41p0Qu508qeZeWXtJ07cOvxei61cDCRvblGN5otFOEOaHMyz65zgDhitYljhEUx0TdTxTDXUsTo8mcfLcaF64trT1b0pBdUHXV5W1UOqra/L5YKux94U6K63Z/uKf7ThDrq4mxuj3sxgG9ynTFGoCLuQmk9L9VM6GYOxbszYWFK19ZSCTDgalIzkc=
X-Forefront-Antispam-Report: CIP:216.228.112.35; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid04.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(36840700001)(5660300002)(36860700001)(336012)(426003)(2906002)(1076003)(83380400001)(186003)(2616005)(82740400003)(36756003)(86362001)(7696005)(478600001)(7636003)(82310400003)(8676002)(356005)(36906005)(26005)(54906003)(316002)(70206006)(7416002)(6666004)(110136005)(70586007)(47076005)(8936002)(4326008)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 03:07:30.8986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4956911e-727e-44dc-3606-08d96c2c78cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.35];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4717
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

VMID stands for Virtual Machine Identifier, being used to tag
TLB entries to indicate which VM they belong to. This is used
by some IOMMU like SMMUv3 for virtualization case, in nesting
mode.

So this patch adds a pair of new iommu_ops callback functions
with a pair of exported set/get functions to allow VFIO core
to get access of the VMID value in an IOMMU driver.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 20 ++++++++++++++++++++
 include/linux/iommu.h |  5 +++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3303d707bab4..051f2df36dc0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2774,6 +2774,26 @@ int iommu_enable_nesting(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL_GPL(iommu_enable_nesting);
 
+int iommu_set_nesting_vmid(struct iommu_domain *domain, u32 vmid)
+{
+	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
+		return -EINVAL;
+	if (!domain->ops->set_nesting_vmid)
+		return -EINVAL;
+	return domain->ops->set_nesting_vmid(domain, vmid);
+}
+EXPORT_SYMBOL_GPL(iommu_set_nesting_vmid);
+
+int iommu_get_nesting_vmid(struct iommu_domain *domain, u32 *vmid)
+{
+	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
+		return -EINVAL;
+	if (!domain->ops->get_nesting_vmid)
+		return -EINVAL;
+	return domain->ops->get_nesting_vmid(domain, vmid);
+}
+EXPORT_SYMBOL_GPL(iommu_get_nesting_vmid);
+
 int iommu_set_pgtable_quirks(struct iommu_domain *domain,
 		unsigned long quirk)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d2f3435e7d17..bda6b3450909 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -163,6 +163,7 @@ enum iommu_dev_features {
 };
 
 #define IOMMU_PASID_INVALID	(-1U)
+#define IOMMU_VMID_INVALID	(-1U)
 
 #ifdef CONFIG_IOMMU_API
 
@@ -269,6 +270,8 @@ struct iommu_ops {
 	void (*probe_finalize)(struct device *dev);
 	struct iommu_group *(*device_group)(struct device *dev);
 	int (*enable_nesting)(struct iommu_domain *domain);
+	int (*set_nesting_vmid)(struct iommu_domain *domain, u32 vmid);
+	int (*get_nesting_vmid)(struct iommu_domain *domain, u32 *vmid);
 	int (*set_pgtable_quirks)(struct iommu_domain *domain,
 				  unsigned long quirks);
 
@@ -500,6 +503,8 @@ extern int iommu_group_id(struct iommu_group *group);
 extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
 
 int iommu_enable_nesting(struct iommu_domain *domain);
+int iommu_set_nesting_vmid(struct iommu_domain *domain, u32 vmid);
+int iommu_get_nesting_vmid(struct iommu_domain *domain, u32 *vmid);
 int iommu_set_pgtable_quirks(struct iommu_domain *domain,
 		unsigned long quirks);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
