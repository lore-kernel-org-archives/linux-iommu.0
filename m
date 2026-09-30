Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA2E4772B3
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760266; cv=fail; b=gKwFZJOIPEw4tdMofa/QG3SAvs+OYUHQEEsTY+4zH5o2nGMTDKTks8K8JTMZgVval+u2ONbqJsY4HyfnqN7mEO+fr6kKRr0EA2EVtR2GY81/cU55bItTOAy4Ou72XDyT3Vr0xxJ3cg0zd5B8xNmyPMMnZBaEClenxUmlMd0R1ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760266; c=relaxed/simple;
	bh=klv3B7YaEnMIxT7fFzCCgQWw9WHRhumxQQt4hDVXb64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atZoP+xbqq/yFcm2le4vjgULI+8h6DT560ql09ZlN79XoLGkdnvhw7p6kerY6k8BSTCHtoTZz1aJviPJLHG56l0nfGBvO7kNPivM2SI2aUFJGb1XNYpX185SW2YrwJBlHHmPrDK98Hec3a6PamdDdKRIyOir1r0AkjdcgyU+yEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JSZvNT4a; arc=fail smtp.client-ip=52.101.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JSZvNT4a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSgijvY+oFv7byMbSH+ldF9GY03SwQyJ/tVkShSvwtoxASAlZq2NVTwcD3sd/inHztrboq4RlGfL5vukQ36LOXsJm+f5ZjCSczc8dlnX4jhcLmfus0S2irUNdKGRk6DLUOoe5TELIxa8PQI2DmPON/8W0fXqdB8LI+x6w1pvscCiB8fI9ImBSFQqS6/qjYZGfCdQgUqsCEwu2/yV8xkvWSaPw8QLnsxpJ1SDIEM6q79vfXPZ4ZRRGyCcrL10wOqUpVZ/c/IOkb1P3w95SB6zEY7WsUBalpZ+5T4BPh330kL1RFCkKZFk5u1xvlWkaQH0YWhUN4ZSgs4mDOC3UktSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9uk8UAFI8W1lnSrs4CtlZhK5VssO0zaFTNh1hvTN3s=;
 b=pRpUOfBgSWsaR/Kp54LTpaNV7vmUi8FsN7YaqXXQmnLOHhhiJTEU4aONxY/D+8hQ6h2NKM/YA4xAxC0u4aXnusYqy7F36e0sTE4l15UwTYesN6fqWYCANZEianMWcri2aKc10JnJFjvrtNzK1Ra5WAUAOijNl8C2pJUUizlfrGogKlsfldi7mgOb2E6jyQsaSWaWmb+GVkzmjoUjlw3f6F1FygknUcA3MvJFPY2+6XsOOR2vUQ2apLoK/sdp8Ca5tn5H7mxdSQnn/00pfaSOmTTVV5qMHKK7p6vRLZY/VJ4hR/mdBTqjUPXIcdjE7oyg2aemc+Rc3eiIiMdtMUDimQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9uk8UAFI8W1lnSrs4CtlZhK5VssO0zaFTNh1hvTN3s=;
 b=JSZvNT4a29dN3oyqHaW04EGH1l4IXzPQoShyyIb21TcvwPudcfMQgd2zgty9Q4CBeIbDMgzs71cmtUK0Puo7PLUvxgofZHbkASpvqOL/S+ezPcet/UCgWbIDSNws82UUY5TggYGwFKfqQU7dZzypp13dYlIYhk43sd8xfYP+jq4=
Received: from PH8PR20CA0021.namprd20.prod.outlook.com (2603:10b6:510:23c::26)
 by SJ2PR12MB8651.namprd12.prod.outlook.com (2603:10b6:a03:541::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Wed, 30 Sep
 2026 09:24:17 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::9a) by PH8PR20CA0021.outlook.office365.com
 (2603:10b6:510:23c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:24:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:24:17 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:24:10 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <chrisl@kernel.org>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 02/24] iommu/amd: Introduce EVENT_TYPE_GUEST_EVENT_FAULT
Date: Wed, 30 Sep 2026 09:23:22 +0000
Message-ID: <20260930092344.5616-3-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SJ2PR12MB8651:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b2645d-590c-415e-7e11-08df1ed49a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|23010399003|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9RoBagjo8UGbguMFNWtpZ/hStkOictyo9ziZvfmFoosyr8B67IuvbPA3PyLVpVMycFkX7D1xE3phBR2K35mOEltoWQHLIXmm4m9msOMkEBPkH2hR+kpEEi3UKMAl86ELdyaEKhOPyRLAzyYLCnB8INGFEpeS8gXCMlkiQXzi2Ay9zZ8etdddg56Blw5TxVrH9q0MbtOENwLm5NDDlpS7z1iDk16FzxguAiiiB92d5db4/TZu9GMHApQbka3uWQvTubY0ToC1VjSWy8BpawZN2cxR5Qg9FLZYiStENJsfcbbLdXRY9dHUkZqYuNnj7sN28mo+FQOvP5nsR3rdEBpGNinLeqmHt6e4kE8SpoCaq2OpPxIT9LILBGxEFTwxHRnOoEoXD1/sZG0i1swIrv7b/XOcSft66z49xW56XUdc1owOTWwUmiMro2JYx7DrDfuYrzTCegi23MI2YOnHv1+5DnQHe/6SOrCgOXApe0aUi44LuxWRty/SXAx+Bhp7cGFz0fAVOHhtKNIsKeX4BsMi6JL8JH49JLyc6Ku/sa32Wa9pf6/tV98aQBTA+GifFGKb6xEG4QmKu9IfecukdrSNa4a4XWBzwG1xfXRVJDOH1qriJ8Yt/e3k0KShXgFhcoVIwQGmTx7WEJqu7/hAiQ9ASk2TFD54ti0HXSlA8H2fsWAv3HSdHhGEN1zUP8ri65bqxPC5ImaeiI/YNf3qDvF5yw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(23010399003)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z6VBPKtlRHNv86gNNft//HCcUd+3NvLXLm7ATK6gcUXfVflTk3YeVuboyTH+70LVDgMZmLBTIohvLQHPVnm+GQ1uoYcnSfYhpdcagRGu0MRTN/0M9X1e2WEhGUmWhAsAb/9KKGAg1hWCACEWhDR55lamDDsKpvYPfr8EnXHMVlxb/sM0TlPPDAXaVZ0Gu8ELFSK8BSKhyezf5GV9A6FBg9DTgjaOyZrV5FKohRpVjovHzwj/B0nludLI4xXwrE0Sxw3xse9ifiBkQbTjTgnDNhdozs4KMwzEKJUyw3pBkyWg0tDCpf9bdpGqIi6hSG+dx6uKZei22dQsGgnSHfsWFcbBMRI/dKdfsRFsLYyvDOztC+9yY2ZL+96sEllfJZxm5GzcS/0ofU/aUGDMj2Say0QXicxmqSpMpvYDr9L/iVwvC3Kb/1U+eSjOmHp/hw7h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:24:17.5177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b2645d-590c-415e-7e11-08df1ed49a04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8651

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
 drivers/iommu/amd/iommu.c           | 116 +++++++++++++++++++++++++---
 2 files changed, 107 insertions(+), 11 deletions(-)

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
index 43a5690721af..2df81e29519e 100644
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
@@ -1023,9 +1033,90 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	case EVENT_TYPE_INV_PPR_REQ:
 		amd_iommu_report_ppr_err(iommu, event, devid, address, flags);
 		break;
+	case EVENT_TYPE_GUEST_EVENT_FAULT:
+	{
+		u16 gid = FIELD_GET(EVENT_GID_MASK, event[1]);
+		u32 next = (head + EVTLOG_ENTRY_SIZE) % amd_iommu_evtlog_size;
+		u32 *guest;
+		u32 live_tail, w0, w1, w2, w3;
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
+		guest = (u32 *)(iommu->evt_buf + next);
+		wait = 0;
+		for (;;) {
+			w1 = READ_ONCE(guest[1]);
+			guest_type = (w1 >> EVENT_TYPE_SHIFT) & EVENT_TYPE_MASK;
+			if (guest_type)
+				break;
+			if (++wait == LOOP_TIMEOUT) {
+				w0 = READ_ONCE(guest[0]);
+				w2 = READ_ONCE(guest[2]);
+				w3 = READ_ONCE(guest[3]);
+				dev_err_ratelimited(dev, "Event logged [GUEST_EVENT_FAULT invalid guest-event %08x %08x %08x %08x]\n",
+						    w0, w1, w2, w3);
+				if (!amd_iommu_snp_en) {
+					memset(__evt, 0, EVTLOG_ENTRY_SIZE);
+					memset(guest, 0, EVTLOG_ENTRY_SIZE);
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
+		w0 = READ_ONCE(guest[0]);
+		w2 = READ_ONCE(guest[2]);
+		w3 = READ_ONCE(guest[3]);
+		dev_err_ratelimited(dev, "Event logged [GUEST_EVENT_FAULT guest-event %08x %08x %08x %08x]\n",
+				    w0, w1, w2, w3);
+
+		/*
+		 * Erratum 732: clear both pair slots so a stale guest
+		 * event is not decoded on the next poll. The second
+		 * slot may wrap to the start of the ring. Skip on SNP;
+		 * that buffer is not writable.
+		 */
+		if (!amd_iommu_snp_en) {
+			memset(__evt, 0, EVTLOG_ENTRY_SIZE);
+			memset(guest, 0, EVTLOG_ENTRY_SIZE);
+		}
+		return 2;
+	}
 	case EVENT_TYPE_VIOMMU_HW_ERR:
 	{
-		u16 gid = event[0] & 0xFFFF;
+		u16 gid = FIELD_GET(EVENT_GID_MASK, event[0]);
 		u8 src = (event[0] >> 16) & 0x3;
 
 		dev_err(dev, "Event logged [VIOMMU_HW_ERR gid=%#x address=%#llx src=%#x flags=0x%04x vflags=%#x]\n",
@@ -1044,24 +1135,27 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
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

