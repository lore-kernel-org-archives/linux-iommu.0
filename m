Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793851326;
	b=ztiuJXJaVz2VO/KWeZt6tuOwsF0SvmvEsCzU9mTbMOe0te+pIBCSOfn1H+hf3uW6d+l+
	 lTPiZ2dmTih6KcKkytGaF+GZTbbT7yG2BscPUd54Vpo8ZvNe7Z5kvk7KnEklSNyYMLeyR
	 uAt9fIR+LIDbbdJlbvbKzhNcWuw44OAMvEKuQtrbWfSTupCspebj/SJs9z1b8c5a0g9py
	 qgW6UwWhSJaMwaFwK5AkR4fZv9wWvJgG4tE/ESJ2ShEa0L0PzIVgSKfZBNLarN/zEBjSJ
	 0uMobLeo1/8kBcFM2uejkqqqbDN2cMWDpAjUhVMe+AKZ5t0rXzBX0QzrWcqBjgtEYig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851326;
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
	bh=mu/mL59B+5j4INe5AZTOdGUxcXghGKQswOCj8oJ1HoE=;
	b=PpVTS50mZIRGkcKQSw4UJgQOyGfETfu2nVN5APfAuCB34jDRPuE+nRHNtT9JtzUzgx6X
	 urZfMgHuTqNFW/qGYLqaCKfc112A0r2kjxhfaJPSqO0HCIvrC0q5HKwlZLREfghg2XkgC
	 FCbhKO6bm0BknWpsqfbJ09gwDS/FyzHgC7ZC3eGVRnJ42L16h6Irb1tgPEqPtwWDCruEO
	 6CPlfvcKvChrAW4Vqi7luIEK+jQLWuaAIT7gIaMFYsm1sl1JIfmYbho867AZUE0MfhVkJ
	 giWkprx48Rn6oEyrez5PcJP8C091DkbYejkxlsDyrIynMbML+7sk3TbG66GGwwYqLoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T5Ne7VPl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.33
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC3F606A33E
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DC3F606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T5Ne7VPl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfKzxaTOCxL0Bowe5TQjB5WwblyXu+Wb5OXYNj566dEeEeNV7HEouIdVnEEgc30KPIqAmwksBSQsmCDh81wQKgjHdO/EEVlHFtJKLCIdHIrhQafWtfNZTsMK4mjUxmn5jNVoLgpkfvL1pgRnBAk8OMVQ22NwwZQ68iIbDbAEMAY83o/8WUgb0lchC4n1T7yJ8upG+bB0gQtHkXo4Gi9N5jyMJx8atL529DxSKcGWU/vOp2OtjucUkFJ4VXUFkPpNUbQthpPisCroyieCZh0DV1OQSjQOBp8B04zeidVl1dAeCeC+6Oa9bBcM5UGMw/+1QVsguV1RwGw0BbQcGv5wmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mu/mL59B+5j4INe5AZTOdGUxcXghGKQswOCj8oJ1HoE=;
 b=uDrEi3Ta7LANR6lqvbW7ZvaD5mV4F0aNQgH03umDM8Teh1G0C9g78z6UyLEfnMQFgOgaJB6UxT4sIgDbWaegxw8ESJj2HRfh6kR1lXnhZD0So7MUuuDF1CeOkbPUq93aV1/GRFqq9JOgwuoLyr0oAluT0hPa0m53yzLfXhCohvrsSYOUIzUGcCiv4hkFRuS5EmGa4JkgJ5CoCVddAX3rHTrayeY2Ga2qyHXdSHg0T94geA7Bl7rB2KM5DQX3IHllYZ7xGjIH+1EYY0uiAQWsNCyiFYSsW8qO+4pMfcyOA/D92Rs5o+fdSuET2aa+6dzhQI/zRx9FPOM292XpY440ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mu/mL59B+5j4INe5AZTOdGUxcXghGKQswOCj8oJ1HoE=;
 b=T5Ne7VPl6aS+laYD4bnfCaoXb18lKUwLeQRHHGFy/WohXRaM4dZF3382xFklkwJh1FFFZXUa37s5ogy4KFvXMJhshL0FjhAtIjLdZUNxJUjcHQs8zCkYIVYg5IO550qkb2PH0GV+GtUIE1NNCH1GSUwBD5PMH4khcZvGndooWy4=
Received: from BN1PR10CA0004.namprd10.prod.outlook.com (2603:10b6:408:e0::9)
 by DS4PR12MB9817.namprd12.prod.outlook.com (2603:10b6:8:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 04:02:01 +0000
Received: from BN2PEPF0000A892.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::55) by BN1PR10CA0004.outlook.office365.com
 (2603:10b6:408:e0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:02:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A892.mail.protection.outlook.com (10.167.248.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:02:01 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:01:59 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 5/5] iommu/amd: Remove the shared INTCAPXT domain only after its IRQs are freed
Date: Thu, 5 Nov 2026 04:00:16 +0000
Message-ID: <20261105040016.398718-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105040016.398718-1-vasant.hegde@amd.com>
References: <20261105040016.398718-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A892:EE_|DS4PR12MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: f488c4d8-429d-4ab7-6819-08df3af18bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|261102123227099003|261021121427099003|261022105027099003|261026140227099003|261009223027099003|261026121527099003|261021123027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	ZlpAOvJhIgL6B4xR6DOVpQaN5yJbpmu2kONrYb+6ZHoBqtbJ7hq1TnPWxZFxGUXJHupg1pNaXhOjtIFOYNfTD11KD5s6yXV9ATzyQAmjSTTjW5d0ok/63Yme95y8iX5KFHoY3rd1/p39fEsFMvdGwIA1bWkBjVVckxsXuMCJy3e7no9ueKJRLbvgkPBC23s7Z6LK49qw1z/PgFDI5ul9yDs7f2e3l4I8In2e1EaP/U/+Ha5/tvqxkth3rr7IzPM0lyeBK62vzXtSBTSDh96zewPz5zD0JjkEnF2/5z64Xqn4yAF8bu+wL18P4CWt9WfiV1ePk9qC+mWXUr8h1/81N0FOBb6VpaFxNWKe3pl8p1iK2LKIjUgDYVEenqNgWwyOupTBU5QZG2ojrOlVy3iJ4iTcINNx5+QMTu1USNSJRsSRwx08Q5LW3NhDZAUf4C2k55kpyckDi8XHKiQ3fSj48gBA9Ff0/qI1orKxTHIbcUCiZjh5V8MC4UDiUSDzFSy9qYGJK6tJ/HB0KE0QCbIPPlYzPuQ2VSvtQZs7M8S5/bRpNTSbg85IMc6oz4WM14kiZOfWc2vTYEf8pBRCVC30fopiZF+2eW/GvUlKUPcZ0YA1onGDAy9P3ae/w29AmFcha8ISggUXwquiLRYY4/dQLRb8c4Bu05ZEm7zzaQr04OpBvn7nuoodm3Lw8T0v7p4dfJuUbDsAItqCqRZfG8eHHA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261102123227099003)(261021121427099003)(261022105027099003)(261026140227099003)(261009223027099003)(261026121527099003)(261021123027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M69JUMCstIcOamje9BnYjnaQmbzQ6QF6msP158wkBFbb8qbMhLzQpPnN6DuRqbmeEis1lajlvd4sG+4SMFrOM+8porYSkUWFcEj8V9q+7sTovX7ATQhwq5E5RmzFT50bpCXu3u8b+Lv4Koc26jJmMxS3bOAXh8LeuEjP0Qr0wAPnh8/aj43vpOuPz8i1Imk5G6roiHL7zKYSfu/o6BNRh02FIEqn6LHhaUXlWN4BSO3Pr2jJIV6QaSQ+bsJivKNfsb70RCLj5raVXcooUj0t3XM/H/rHTwUl+1eEc5tkb35kJ/fFxPSBxZmP3/4QZNWPxhJNM0A28TiD4Ep1hEe0w+FRQ8KD9fIflOAeru1ggLy3jaT9Ld76walW+G6bkiBK9YDSyTaZdjxmROGNQDszWyMHYBQYUeTNg/gPyQVcExLEDqOmURCp8x3bam7vk2Oc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:02:01.4266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f488c4d8-429d-4ab7-6819-08df3af18bab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A892.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9817

__iommu_setup_intcapxt() called irq_domain_remove() when allocation or
request_threaded_irq() failed. That domain is shared by every IOMMU and
by the event, PPR, and GA interrupts. Removing it while another IRQ is
still mapped trips the revmap warning, and iommu_irqdomain keeps
pointing at the freed domain.

Free only the IRQ whose request failed. Remember each requested IRQ and
release it if a later interrupt fails or when the IOMMU is destroyed.
Remove the domain, and clear iommu_irqdomain, once its last IRQ is gone.

Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 ++
 drivers/iommu/amd/init.c            | 62 +++++++++++++++++++++++++----
 2 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 0e79c43be001..47a5ec3c8ef0 100644
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
index d967544baa6c..a48aa8806a19 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1810,8 +1810,17 @@ static void __init unregister_iommus(void)
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
@@ -2547,6 +2556,33 @@ static const struct irq_domain_ops intcapxt_domain_ops = {
 
 
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
@@ -2588,7 +2624,7 @@ static int __iommu_setup_intcapxt(struct amd_iommu *iommu, const char *devname,
 
 	irq = irq_domain_alloc_irqs(domain, 1, node, &info);
 	if (irq < 0) {
-		irq_domain_remove(domain);
+		iommu_remove_intcapxt_domain();
 		return irq;
 	}
 
@@ -2596,11 +2632,12 @@ static int __iommu_setup_intcapxt(struct amd_iommu *iommu, const char *devname,
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
@@ -2612,16 +2649,18 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
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
@@ -2629,8 +2668,17 @@ static int iommu_setup_intcapxt(struct amd_iommu *iommu)
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

