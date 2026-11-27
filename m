Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779041;
	b=kMryhSwkqso0mMGCtLZYUCdXoNOoYH3deJkROhq25WqABFKZZmS8oG+ZeDmL/uu1iuY4
	 sRYZ65dRUG996bqNfe51L2lMBoRQgrRC/wNFsGD8jSgI5Hss/92DERu6XyPnh1/yEikBh
	 nL9Gl0vCLuR3q4e8/zjJgyEBjVBfjhfoAWXIJ0597hA3JUwyJsh6Pf94dpMmoKPtCWXdx
	 qbDB/+0jFVYa/1Pqv6wzPHHtA7VB3ajcZT4LeL8w1RzAn1nSGlVpKSklFDh/pvRbenKut
	 mWfNU3SMmQXvbB2oy/4JIUM6WWSYd6BersnrJeNo2099cDbMucrjBSruhyahY48QeFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779041;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=U9Zu42OvhD/mfTuzBbZixTVFAr0m34BB7PMILNs+OGo=;
	b=R6rbCZHEHIQVEr1Yl28vfzSXWNhy82Fy7UR1aQaAJY7IwBqa8Gl6649LnAqxREZtOYzV
	 ByJ5Otf+YSaEAOzU8IctLcG91i1x1l8hic/k5vCqAtgdFKNWHfnaL/QmD6KUMyr8OcY4W
	 of047c9eapSzETcEYGk28L2/RQ6iljFqKYG89kJVPtyx8JsL+2mngGltmRVOyhRqxepT+
	 s8OYlOe+u75yISrXC8llcbG93ek2TWEfyUj6NXmTtF37iLDaygtyKsrGtLRKx1pAGUflr
	 fmggwIAluqDox0CCFYuQ3G6qeEPTlhMAY8PWq/3UWOJcq84KM1U1JEQU4wY35SStoQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MpIjTck5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.19
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73B606A31C
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C73B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MpIjTck5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s40C0TJISktYoBjp+mqRfZjZbqwhhrnyAJRVyhgnwOCIaFRIi535P3J0FtJBmI0YQr9dF7efgKG/psOMy9srml6vn3hK5qItdr5ZXXUF9xCzQx7tqjRpQ2Rs938fwffy9lwIN75J8bBtCxseUpqnuyULTqVa8IPHeC38rE3RZ3cOYsYfpKE7VsR3DWwwdSe/fsWCiWejHH/hm3tpvwuziTws4hGTtq1PSlNvBPlfC8VLb1NL1HQOKMS2DlXPgzHpYqbhx71cZ06ePHBmMwqDXD5Js9um9GNLDdbHb6DBHkTTrxo5dyYdCzZIlfHPbSwRAaxFRzVh+k8FilnDLl8N6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9Zu42OvhD/mfTuzBbZixTVFAr0m34BB7PMILNs+OGo=;
 b=xmAfwxcGNxLBJx9BWf3/iVvkpPMDZdpUKmSgvcX6FdECqavHkUje44tGhpJayxk1L/PC5CpHCxg5jmW/f6PhwAena27+9NLAbxQEc0zuQcL0OCYxACSg5uFFghxIA8UhCSX/JwpXsJahdxrTDBdMR1xIN1kt52q9+Oo3B4qliiJCxXCdCfdMPbmgSSfrjUZ6adtPtU5SoJBa5SKtwzGoe1jO6PE49lYgK/PaJ8Cfzk9trNfJ/eY5pvJFuw9EgId09Oe5jPreQt8zIZfZ4t2USw6NOn4unIgUrhJ3O1HTtNexeGIERDJ88IxGwzurDwcvMaqyLyNjJJy8WbFCWuvrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9Zu42OvhD/mfTuzBbZixTVFAr0m34BB7PMILNs+OGo=;
 b=MpIjTck5slN1iizL8TQY9GeOrUJzmKL33p3oW1+oFfGLyeoZq8cqddq2gPwBkz8f3kIqGTkhYYzTTo4MgzXkjE5+Dgj7oO/pgVbV+dKNubWctSEJ1Leq9/xnQKP067+SZyDPGgoV7M2UJ64BgBbvQEzGk6DpceqElPeKu4KAI1E=
Received: from BL1P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::15)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 11:28:34 +0000
Received: from IA0PEPF0000003B.namprd03.prod.outlook.com
 (2603:10b6:208:5b5:cafe::5b) by BL1P221CA0040.outlook.office365.com
 (2603:10b6:208:5b5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 11:28:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003B.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:28:34 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:28:31 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 4/4] iommu/amd: Remove the shared INTCAPXT domain only after its IRQs are freed
Date: Fri, 27 Nov 2026 11:27:10 +0000
Message-ID: <20261127112710.208885-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127112710.208885-1-vasant.hegde@amd.com>
References: <20261127112710.208885-1-vasant.hegde@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003B:EE_|MN2PR12MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a228e7-80c3-4261-23ef-08df4c7992ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|261009223027099003|18002099003|22082099003|11063799006|10067099003|56012099006|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	8OrBwVWTQBALF6RutF/Yc2iUDWlsJNn72FqoIc0tMy3K1h4ebb26yd8X8KCsAFFEFwcRrTlcyMroMU9loEFiL+HAT7tyZjlkWzHhg1OZrkjzkkvV6OiRJ8SdKRjq3KEKqFO9bAGfXd8Xkj6LpVEXrzKEL/fNnTEWCe9h78yZCNIFKxgEuPamvkPjOe304Pmwkp8+qQiM7dUn1GUYG943FDtaA2qIIkYBgSzp+PK4Btz/mW+mMaPbykWoKr1HWA1kp0DNAmvmDWmR7aDMOJemk+PYyn7fyRxaHFvsuFlFQ/vfKDvtRzaJ08jKLJ/BlikFwc1avfcTodRgb97HNUqV/VIRSiad2xbZr7P9NfkEpej/TZQ96J3+353dlkOya1mtKeEi16gje9feiHxL8ZLQJtZZovtnKcJGtNsp5ZRcQ/dzawxaI+DnnBmwe2W9+soUdo0uM3YIJcnP5WizdPE5kWtfa4MEnFYi2GTVasZuf6xsGIbiknN+vC2Uzja4fvx7c9abtqzT6XiVlmyYgJoveW34xFKPIaIiqxOAafM6kv9ALmrwG0+OnWMjlPabSLXvCfX7kRblANbzNu5EsJgdXAymhQGZ82HhbNrTobR9aLfffEhK/+Sg61OJ/IiztLLisi8nUaBSO8C27eN5DcqU3AzdnkLA8OHyrQmrR2++EK+0sN5AajwGZ/sz1/4P7Dj7BQ1TLkATGx4Ke2nn2nbYEA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(261009223027099003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QUVUB9j7ifAyQc9lzqy88f9ioAf54/kU5UbNbvcmk25zuThb061qXZHJrFSu/xoe4QurIa8PX2vKquxJaM8JvCvjZPM8/S+VoD1mCkh41m5Bkz7NA2RzpGQKoJXwoj8nolo/ND8hRg0hYotwMPAcmBmavJEejDZusKTs/c+DSss+KHZNPUY8SXT57sccETSocUwZ+dWaAHH/Lt0BjATe7Dhb4EPdsfk701N+pgPLwQktbs54QMG8oXbBcZAmJ2a8PmHsRp1sjhxuepdhmMDyO1Rp9r/aIbsx3yKRXxDnrEPUQqfd0Zemib4mJCQe2hvJdnkUbc48NpncXWapjasoLyQylPVyiDavJSTwaULmO/A+ly+Fd2lmaG1B7KVPEOgcMbaErGK4b8Yk8XoabjbHsBuzzjGWam49BGG151RE464dd9RpVC3JERJvfnjfOboU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:28:34.5095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a228e7-80c3-4261-23ef-08df4c7992ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392

__iommu_setup_intcapxt() called irq_domain_remove() when allocation or
request_threaded_irq() failed. That domain is shared by every IOMMU and
by the event, PPR, and GA interrupts. Removing it while another IRQ is
still mapped trips the warning, and iommu_irqdomain keeps
pointing at the freed domain.

Free only the IRQ whose request failed. Remember each requested IRQ and
release it if a later interrupt fails or when the IOMMU is destroyed.
Remove the domain, and clear iommu_irqdomain, once its last IRQ is gone.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 ++
 drivers/iommu/amd/init.c            | 62 +++++++++++++++++++++++++----
 2 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f98770db0090..9657e80ffdeb 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -686,18 +686,21 @@ struct amd_iommu {
 
 	/* Name for event log interrupt */
 	unsigned char evt_irq_name[16];
+	int evt_irq;
 
 	/* Base of the PPR log, if present */
 	u8 *ppr_log;
 
 	/* Name for PPR log interrupt */
 	unsigned char ppr_irq_name[16];
+	int ppr_irq;
 
 	/* Base of the GA log, if present */
 	u8 *ga_log;
 
 	/* Name for GA log interrupt */
 	unsigned char ga_irq_name[16];
+	int ga_irq;
 
 	/* Tail of the GA log, if present */
 	u8 *ga_log_tail;
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f9258ff1c5b8..c9c504ce8ce6 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1868,8 +1868,17 @@ static void __init unregister_iommus(void)
 	}
 }
 
+static void iommu_free_intcapxt_irq(struct amd_iommu *iommu, int *irq);
+
 static void __init free_iommu_one(struct amd_iommu *iommu)
 {
+	/*
+	 * Masking an INTCAPXT IRQ writes its MMIO register, so free the
+	 * IRQs before unmapping the IOMMU registers.
+	 */
+	iommu_free_intcapxt_irq(iommu, &iommu->evt_irq);
+	iommu_free_intcapxt_irq(iommu, &iommu->ppr_irq);
+	iommu_free_intcapxt_irq(iommu, &iommu->ga_irq);
 	free_iommu_buffers(iommu);
 	amd_iommu_free_ppr_log(iommu);
 	free_ga_log(iommu);
@@ -2607,6 +2616,33 @@ static const struct irq_domain_ops intcapxt_domain_ops = {
 
 
 static struct irq_domain *iommu_irqdomain;
+static int iommu_intcapxt_irqs;
+
+static void iommu_remove_intcapxt_domain(void)
+{
+	struct fwnode_handle *fn;
+
+	if (!iommu_irqdomain || iommu_intcapxt_irqs)
+		return;
+
+	fn = iommu_irqdomain->fwnode;
+	irq_domain_remove(iommu_irqdomain);
+	iommu_irqdomain = NULL;
+	/* irq_domain_remove() does not free an irqchip fwnode. */
+	irq_domain_free_fwnode(fn);
+}
+
+static void iommu_free_intcapxt_irq(struct amd_iommu *iommu, int *irq)
+{
+	if (!irq || *irq <= 0)
+		return;
+
+	free_irq(*irq, iommu);
+	irq_domain_free_irqs(*irq, 1);
+	*irq = 0;
+	iommu_intcapxt_irqs--;
+	iommu_remove_intcapxt_domain();
+}
 
 static struct irq_domain *iommu_get_irqdomain(void)
 {
@@ -2648,7 +2684,7 @@ static int __iommu_setup_intcapxt(struct amd_iommu *iommu, const char *devname,
 
 	irq = irq_domain_alloc_irqs(domain, 1, node, &info);
 	if (irq < 0) {
-		irq_domain_remove(domain);
+		iommu_remove_intcapxt_domain();
 		return irq;
 	}
 
@@ -2656,11 +2692,12 @@ static int __iommu_setup_intcapxt(struct amd_iommu *iommu, const char *devname,
 				   iommu);
 	if (ret) {
 		irq_domain_free_irqs(irq, 1);
-		irq_domain_remove(domain);
+		iommu_remove_intcapxt_domain();
 		return ret;
 	}
 
-	return 0;
+	iommu_intcapxt_irqs++;
+	return irq;
 }
 
 static int iommu_setup_intcapxt(struct amd_iommu *iommu)
@@ -2672,16 +2709,18 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
 	ret = __iommu_setup_intcapxt(iommu, iommu->evt_irq_name,
 				     MMIO_INTCAPXT_EVT_OFFSET,
 				     amd_iommu_int_thread_evtlog);
-	if (ret)
-		return ret;
+	if (ret < 0)
+		goto err;
+	iommu->evt_irq = ret;
 
 	snprintf(iommu->ppr_irq_name, sizeof(iommu->ppr_irq_name),
 		 "AMD-Vi%d-PPR", iommu->index);
 	ret = __iommu_setup_intcapxt(iommu, iommu->ppr_irq_name,
 				     MMIO_INTCAPXT_PPR_OFFSET,
 				     amd_iommu_int_thread_pprlog);
-	if (ret)
-		return ret;
+	if (ret < 0)
+		goto err;
+	iommu->ppr_irq = ret;
 
 #ifdef CONFIG_IRQ_REMAP
 	snprintf(iommu->ga_irq_name, sizeof(iommu->ga_irq_name),
@@ -2689,8 +2728,17 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
 	ret = __iommu_setup_intcapxt(iommu, iommu->ga_irq_name,
 				     MMIO_INTCAPXT_GALOG_OFFSET,
 				     amd_iommu_int_thread_galog);
+	if (ret < 0)
+		goto err;
+	iommu->ga_irq = ret;
 #endif
 
+	return 0;
+
+err:
+	iommu_free_intcapxt_irq(iommu, &iommu->ga_irq);
+	iommu_free_intcapxt_irq(iommu, &iommu->ppr_irq);
+	iommu_free_intcapxt_irq(iommu, &iommu->evt_irq);
 	return ret;
 }
 
-- 
2.31.1

