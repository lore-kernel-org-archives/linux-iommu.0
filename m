Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2638F65D
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411718; cv=fail; b=tiPtckNvn8IN4mCB2BQsx8f04JwJ9TkpULqMRU3KXbC0FfKU8qnN+mpnJJDrgIaLbjX5Z/kLysrW4hhx1rMg04VwQN/y5iQtoP2YAA4In7dJLHauOVuYKcpXkibqubdy/j981Ya1DrqYKFDe+TtubXBsfpQCvnntrsreRTZxT1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411718; c=relaxed/simple;
	bh=Lyalh7EPjq0mjMfaOWPVVEL82Lq8TE7j1Pz3PDay41I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdAgilXkvZJPGCv/AmIAXd8BzmxO6ei25EXvOdgwjanaiI/qYlPNDMxYuPQVvcoD+lZX9vip2lGy90SLdcogK1bCMOIUCNa1oexjlp2TViHZwyBJLKb4UTy/UQweoXjUOIQ9F6qpVUd8jV4ahoCgMCjxZwNgvKjIWy8cveBT7WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kf0mIQfJ; arc=fail smtp.client-ip=52.101.201.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kf0mIQfJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJMHuBjLIewRL0LeoGIKjPE4eHgQVCU+N+zTLaC+YFvsH/xqAZXbR/m72pFaydERDEj89mZe2eiEAso+6T4FpgAoaH72ruxnTu32NjBh+G/CKkXnyTzNWvLB27jSAy8Ft49KNwl/ant8lGnkb3JzE1AtDe59RoDi27hmc+n8NYj/o0VsN8q/SardYvQPq01OUHEeAPHH4B2P2DMImLFF6af6CG+X/J6WeWKPvvQahmRLrf9MMjLztPQaJbVyJ1u4UBnWRj06CE/1iMVPyRXOFh5sfUYrixm80cw7mhnVMkdoj/Ksvc4qmh8bolx+vWknOqoD7df4lGd6po5AV3zOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HUCt7salzl06P67dQH+HQ2N7aOz5fVmTNQGZLqzN2M=;
 b=GCDFxJ7OwjS8V4bFoo+l5D5X4zSZKI0qaFMgsx2dMECd7kTyNpMHvO2tI8sPbW2LuUtCjeD5NQL7G4H0HYG23etLZnAXBqNbslelpT1ooTGzyPHRgIp7VrOqjx/Qqz95ptNkdSGy6LjltY3z6Q5t26WCzDiA+KJi9CP29lXFygmLNG5qJbosUKicOFc29MO1LiSBkAT0nMP0jHjah2YWoCSZG9hh3KOeok3K5brxmLSvdXBhS9CZtorZVt7oUAXlJhpS95oEx6J7mRdD5EZ7MzON1RKkqKesp5wjNdaJUsJiWkQMnuJ6oRgTkSKf3DdS2I1rDUnR2vgt/NFzVWnH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HUCt7salzl06P67dQH+HQ2N7aOz5fVmTNQGZLqzN2M=;
 b=kf0mIQfJiEThhmGxTHM7wiZUfWkCyF7be1Hu4nnEqZFu15TBIAzy7GKZHW7otNnAekbZak9Xxi1JWgH+ZpRZg7fxk5y4kDrLTjOh1ZDm3GyU7XYMlF2tqOpGoXgDL73duwMue/28DpC5zvgXUFwZgEOVUeY9lxMDpn02j+5LbQQ=
Received: from CH0PR03CA0448.namprd03.prod.outlook.com (2603:10b6:610:10e::11)
 by SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:48:29 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::81) by CH0PR03CA0448.outlook.office365.com
 (2603:10b6:610:10e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:48:28 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:48:22 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 02/24] iommu/amd: Introduce EVENT_TYPE_GUEST_EVENT_FAULT
Date: Mon, 14 Sep 2026 18:47:28 +0000
Message-ID: <20260914184750.222939-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a16c1f6-60e0-4f88-bb34-08df1290c442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|7416014|376014|36860700016|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Zyd2Pe3pGNa+FPZ6bYt34UYHfpAeBgJn+bQ9myPmgplUM44XYOS/1/gED+2V94BXSIB8aF5y2KfVkRxdn1wnYyTQ5SA2Iyj6QupUPnMK515qlcyl0b7Beam+9x9FrHpkYrZ7lp1KL1d7N9grQW2AR1ViDOnpnDt0xoUa9sxZDAYp08WHYhVCiTDRHVRC+GLduOF0Ib029+AJdHOSVzxWrX/xvJUJNkV9EpqhrgaXrWCBJf14F/GnKwMNBif+sIDHi24tIN98gCSFpOcU2OUQaHGQTKGw/DJgRZjb61utuB05bcq4nCo+tkXjlWCQuZVTB5oSp4Agsx+rdnJlfY2jcSbtgQa4vupyl20SV6Ss1W4WOM7cDElmvFlG+M/13L7ayxoxpLTNGTXglFPWAn54kdqv3T5uxTwbieA3w9jwdGW36NML47Z5fn5CFaEyFrQpG8EfEgfL4v/dQSDVHe4bpCYOCbyZKjB871+ZeMhYQoTxnGm4yynW7u2Uo28NnVZqtjSQH7Af81HafT55+C5OJVq3T7kzGdSFHblZ8vlIRt/cprtJfFIDIARwboNPgDSMaSOgG/TywafFtS77saQ2frhHQptrOHFQX+12Elr558zlareWLrRGLYYhCCvEHnAcBbvkk9wyfLm+MmX2L8H1OorwJzUHLNP0kI9RF02zwuqht6xn/UtYUupfmL1adM8eKQZxeVb0frEnD8gW7tALMg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(7416014)(376014)(36860700016)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fELO5G1H+GV7AR6izNsWPi60WmuvXfx5Bf1VjlyQ0OphUq1mlqsnaxFsFbcKCDI8TxaoOYMvsytlPeWcRMul/Eo43lQgiiM/NwNGRHe9xWjJy3BjXz31lP3RZbRS0zs8iqI0lwd3OkAqezdrSxApRXBjMX2fALstrygxxm6yv6n2nKUNuEsTAfxFg+LpkivdajhbzYtYWo0nNSosDgzTz50o/mNTB6bI3zTccdx9SAo2m3kelbuaj8MOkRzQcoOXffYy1vitZ5ulJZgOU+6FRmMB/i6PpMtSt0jZ8avFLS6lja0VI4gigv2dKWtWh1BGKNp6bUNPjTT1YDvXGcIfbkf8LkDJcoCOZhX69KInrXYIdb0HERhAIOMSjmP+WZfUoWWaWzNSYJ+9PXWLoZaTL9QOeNMz9viahZcLJfHHGDK8zvPmKnRbCRwvN5XAKqWp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:48:28.6759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a16c1f6-60e0-4f88-bb34-08df1290c442
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824

INSERT_GUEST_EVENT with non-zero reserved bits logs
GUEST_EVENT_FAULT followed by the original guest event.
Consume both event-log slots, wrapping via
evt_buf+(head+EVTLOG_ENTRY_SIZE)%size, and dump the guest
payload raw so it is not decoded as a host event.

Wait until occupancy is at least two entries, not merely
until live tail is not the pair offset. Re-read the
event-log tail each poll iteration so a return of 2 cannot
advance head past a stale cached tail and walk empty slots
with the type-0 erratum retry.

Retry a type-0 guest slot up to LOOP_TIMEOUT, the same way
erratum 732 waits for the primary slot. Return 2 only when
that slot is already in [head, live_tail). Return 1 if the
pair never appears in tail. Rate-limit the guest-triggered
logs.

Log an invalid guest-event when the pair slot is still
missing or type 0 after that wait, instead of stalling
the event log.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |   2 +
 drivers/iommu/amd/iommu.c           | 109 +++++++++++++++++++++++++---
 2 files changed, 100 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f26a9059a356..704b4c8acdc5 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -138,6 +138,7 @@
 #define EVENT_TYPE_IOTLB_INV_TO	0x7
 #define EVENT_TYPE_INV_DEV_REQ	0x8
 #define EVENT_TYPE_INV_PPR_REQ	0x9
+#define EVENT_TYPE_GUEST_EVENT_FAULT	0xb
 #define EVENT_TYPE_VIOMMU_HW_ERR	0xc
 
 #define EVENT_TYPE_RMP_FAULT	0xd
@@ -255,6 +256,7 @@
 
 /* Constants for vIOMMU event fields */
 #define EVENT_VFLAGS_MASK		GENMASK_ULL(31, 27)
+#define EVENT_GID_MASK			GENMASK(15, 0)
 
 /* Constants for PPR Log handling */
 #define PPRLOG_ENTRY_SIZE	0x10
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 43a5690721af..c34a0f5a9540 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -942,8 +942,18 @@ static void amd_iommu_report_ppr_err(struct amd_iommu *iommu, volatile u32 *even
 	pci_dev_put(pdev);
 }
 
-static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
+static u32 evtlog_used(u32 head, u32 tail)
 {
+	return (tail + amd_iommu_evtlog_size - head) % amd_iommu_evtlog_size;
+}
+
+/*
+ * Decode one event-log slot (or a GUEST_EVENT_FAULT pair).
+ * Returns the number of slots consumed.
+ */
+static unsigned int iommu_print_event(struct amd_iommu *iommu, u32 head)
+{
+	void *__evt = iommu->evt_buf + head;
 	struct device *dev = iommu->iommu.dev;
 	int type, devid, flags;
 	volatile u32 *event = __evt;
@@ -965,7 +975,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		/* Did we hit the erratum? */
 		if (++count == LOOP_TIMEOUT) {
 			pr_err("No event written to event log\n");
-			return;
+			return 1;
 		}
 		udelay(1);
 		goto retry;
@@ -975,7 +985,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 
 	if (type == EVENT_TYPE_IO_FAULT) {
 		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags, vflags);
-		return;
+		return 1;
 	}
 
 	switch (type) {
@@ -1023,9 +1033,83 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	case EVENT_TYPE_INV_PPR_REQ:
 		amd_iommu_report_ppr_err(iommu, event, devid, address, flags);
 		break;
+	case EVENT_TYPE_GUEST_EVENT_FAULT:
+	{
+		u16 gid = FIELD_GET(EVENT_GID_MASK, event[1]);
+		u32 next = (head + EVTLOG_ENTRY_SIZE) % amd_iommu_evtlog_size;
+		volatile u32 *guest;
+		u32 live_tail;
+		int guest_type, wait;
+
+		dev_err_ratelimited(dev, "Event logged [GUEST_EVENT_FAULT gid=%#x flags=0x%04x vflags=%#x]\n",
+				    gid, flags, vflags);
+
+		/*
+		 * GUEST_EVENT_FAULT is paired with the original guest
+		 * event in the next log slot (possibly wrapped). The
+		 * poll-time tail can predate that slot. Wait until
+		 * occupancy is at least two entries, then retry a
+		 * type-0 pair slot the same way erratum 732 waits
+		 * for DMA visibility. Return 2 only when that slot
+		 * is already in [head, live_tail). iommu_poll_events()
+		 * re-reads tail each iteration so head cannot skip
+		 * past tail.
+		 */
+		wait = 0;
+		for (;;) {
+			live_tail = readl(iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);
+			if (evtlog_used(head, live_tail) >=
+			    2 * EVTLOG_ENTRY_SIZE)
+				break;
+			if (++wait == LOOP_TIMEOUT) {
+				dev_err_ratelimited(dev, "Event logged [GUEST_EVENT_FAULT invalid guest-event (does not exist)]\n");
+				if (!amd_iommu_snp_en)
+					memset(__evt, 0, EVTLOG_ENTRY_SIZE);
+				return 1;
+			}
+			udelay(1);
+		}
+
+		guest = (volatile u32 *)(iommu->evt_buf + next);
+		wait = 0;
+		for (;;) {
+			guest_type = (guest[1] >> EVENT_TYPE_SHIFT) & EVENT_TYPE_MASK;
+			if (guest_type)
+				break;
+			if (++wait == LOOP_TIMEOUT) {
+				dev_err_ratelimited(dev, "Event logged [GUEST_EVENT_FAULT invalid guest-event %08x %08x %08x %08x]\n",
+						    guest[0], guest[1], guest[2], guest[3]);
+				if (!amd_iommu_snp_en) {
+					memset(__evt, 0, EVTLOG_ENTRY_SIZE);
+					memset((void *)guest, 0, EVTLOG_ENTRY_SIZE);
+				}
+				/* Occupancy already includes this slot.
+				 * Skip it so a late DMA fill is not
+				 * decoded as a host event.
+				 */
+				return 2;
+			}
+			udelay(1);
+		}
+
+		dev_err_ratelimited(dev, "Event logged [GUEST_EVENT_FAULT guest-event %08x %08x %08x %08x]\n",
+				    guest[0], guest[1], guest[2], guest[3]);
+
+		/*
+		 * Erratum 732: clear both pair slots so a stale guest
+		 * event is not decoded on the next poll. The second
+		 * slot may wrap to the start of the ring. Skip on SNP;
+		 * that buffer is not writable.
+		 */
+		if (!amd_iommu_snp_en) {
+			memset(__evt, 0, EVTLOG_ENTRY_SIZE);
+			memset((void *)guest, 0, EVTLOG_ENTRY_SIZE);
+		}
+		return 2;
+	}
 	case EVENT_TYPE_VIOMMU_HW_ERR:
 	{
-		u16 gid = event[0] & 0xFFFF;
+		u16 gid = FIELD_GET(EVENT_GID_MASK, event[0]);
 		u8 src = (event[0] >> 16) & 0x3;
 
 		dev_err(dev, "Event logged [VIOMMU_HW_ERR gid=%#x address=%#llx src=%#x flags=0x%04x vflags=%#x]\n",
@@ -1044,24 +1128,27 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	 * SNP enabled system.
 	 */
 	if (!amd_iommu_snp_en)
-		memset(__evt, 0, 4 * sizeof(u32));
+		memset(__evt, 0, EVTLOG_ENTRY_SIZE);
+
+	return 1;
 }
 
 static void iommu_poll_events(struct amd_iommu *iommu)
 {
 	u32 head, tail;
+	unsigned int n;
 
 	head = readl(iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
-	tail = readl(iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);
-
-	while (head != tail) {
-		iommu_print_event(iommu, iommu->evt_buf + head);
+	for (;;) {
+		tail = readl(iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);
+		if (head == tail)
+			break;
+		n = iommu_print_event(iommu, head);
 
 		/* Update head pointer of hardware ring-buffer */
-		head = (head + EVTLOG_ENTRY_SIZE) % amd_iommu_evtlog_size;
+		head = (head + n * EVTLOG_ENTRY_SIZE) % amd_iommu_evtlog_size;
 		writel(head, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
 	}
-
 }
 
 #ifdef CONFIG_IRQ_REMAP
-- 
2.34.1

