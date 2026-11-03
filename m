Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793723103;
	b=WPED/a1Prk+VG1tA+dlpv7uw05jSzkQYIAObfMaftUk6NqN4+jWOloorE4qTtMWgv8dp
	 T1APHXqldbnbqI+izgOCUOj5GbOOkpyDXzLvojRvl2vlBE6czozXxoh2sYCfWbImzjqc2
	 5ga0VMt9a8cYPu02fp+5F/VeHp7EeN+ONkYbx3Xl09AXVG40Cct5P037SMw5oLbQHBjpK
	 7I/tvbeVuXFhpOO5sRDjooTbvNoeIP+6J6zGXjylImFaiCJ1jBCWjq7YGcQpd1dyuUO8x
	 ezDLHwP7csKqfQzKkBTDXlFGSMZZeKbKET/vZTSzI0PQhXx76g88fJYzd9hVZ/NxsQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723103;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=cOOqBcSjsbY/uSk3m/QRiRLOIA01HChh1VM1B6chXCk=;
	b=MfHg8YbY1PeBDw1jRgypojOtLMXcDqG6Z6v4Leu5F5ME38z9wcuOBnnxy0rpAjrdZPkk
	 EeiqXw6v9GRMXJpRjTVS+801AY1bcIGYqHM2UBf5E/29SPzM3wQNf6NBQcOkwtJIaqoh7
	 ScTslX4/x8D2G7dJ+ZZOfm70bO4z6I1SR5F7+XQfKClXdujY38Ty/hTLlErNQUFEQtyG2
	 SMcBddPdcAXP5R/Z3plPwCA3P72+uUM1LuQX/RDTltbe1rr8ARVxZvxmo7ZyW2zkpEkf9
	 HDLPHTILdL6xrd3An9FHW4kLhylgZRvH7vNdN5oo0zWxRV5YYgw/1VTU6NB5AcDsJVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gYuTBWBu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.48
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127B606D80D
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 16:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D127B606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gYuTBWBu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nR2BhCw2PlTq8OQfiww+VN7UccnA8ywGW4sXPFVkjJgf4iK+746Uyk5CApPW3RX1gIiNfJlNj1L0t8+s9+jSivL3uVZDmPoMDKXrlpzgO+RmTJmIHefCaXRTXuv0xZORJ3f3J7ezMQO2D8kYjKLzKSMiatY80O7FAfVka11ohO4Mme84Wmf9N6FloGmErV+HXN9gTCdgXyfg8YtA7Ji9Zh8BHsef1BAFo2HbycRbMnfxiBnA3bSqyRR4ToxJ1+JSCbpgtdKa1zeDqUaq320r/Qa0w56WDqeYCIJKQxhPU2VCT9dDJflL5bJSSGF0gwbUMRuThLx75xM9UzMo3F2Drg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOOqBcSjsbY/uSk3m/QRiRLOIA01HChh1VM1B6chXCk=;
 b=jAkafMbrODkh1VUIa2nAfZjz79lYm0QnfPOFcBZXXepjSJU4KzaccbnwmEJ0Yz6cFJTNqoOk+THI448zgiu89pg5G9ZEV3hpddD0HWSNPIwEOOY95Dn5zNTMzms3kXeSQDfYPSozNHCTjvGs3xblljijC9T/8p9Oidf8W5fdl2wCgpGJDhuNVZ9N9NMlI/C36hIVVoT6SQUaCqT+5nL1o4qVSgMcOpxJRJMyLgQq6ZZDm6nxKFG/dGvFsnuzhCrRH4ITVjeoAyXPooizPzaUkB+szRImWDqccmOkxc05YRPW7u93mhlVYFoOH+Ih98jGvv9uhL97imbEyoq2LCXGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOOqBcSjsbY/uSk3m/QRiRLOIA01HChh1VM1B6chXCk=;
 b=gYuTBWBujDogFMnmv95L1Z3p093mbcZWrpEYIhdRPcuWfBy7Zu6vT32h5Gd0EaXdGNAyOhD9uDtE+98U7PIX400cgXo+Eeky4OccvjuzBlxab8oGz7ZLKqyr6SYNjemFkh0Pztd8x7WaMAlFdPRduFONZ+088C7lRfDfYsFCrj4=
Received: from CH0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::28)
 by SA5PPF8DEAB7A29.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 16:24:52 +0000
Received: from CH1PEPF0005BD5E.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::f) by CH0P220CA0030.outlook.office365.com
 (2603:10b6:610:ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 16:24:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0005BD5E.mail.protection.outlook.com (10.167.244.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 16:24:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 10:24:52 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 10:24:51 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 10:24:46 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <robh@kernel.org>, <saravanak@kernel.org>, <akpm@linux-foundation.org>,
	<david@kernel.org>, <ljs@kernel.org>, <liam@infradead.org>,
	<vbabka@kernel.org>, <rppt@kernel.org>, <surenb@google.com>,
	<mhocko@suse.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<baoquan.he@linux.dev>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <iommu@lists.linux.dev>, <kexec@lists.infradead.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH 1/4] kexec: do not place the next kernel in a fixed-address CMA area
Date: Tue, 3 Nov 2026 21:54:26 +0530
Message-ID: <20261103162429.2053989-2-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20261103162429.2053989-1-radhey.shyam.pandey@amd.com>
References: <20261103162429.2053989-1-radhey.shyam.pandey@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0005BD5E:EE_|SA5PPF8DEAB7A29:EE_
X-MS-Office365-Filtering-Correlation-Id: 69808556-f2aa-43a4-10c9-08df39c6fd77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|23010399003|36860700016|18002099003|22082099003|921020|56012099006|11063799006|261022105027099003|261009223027099003|261022115727099003|261028144727099003|261102130727099003|261102123227099003|261021121427099003|261026140227099003|261026121527099003|10067099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	w11FTgRXCywOPfZMJXpjgaf+KrEh4R7TB2Q0k+JMOOcpdX8JLvugDaBu/CPReF7coe4IWWUrDaKUF6Dd9FGMfDTf6qeFFbizZAZpIvxQzdv321e2GRwT92jKu3dsTO4LPHwmWxYy70sRc4FCEcto67xG/tT88Z7vK2Yclo7K3roVM6FppKrlTGmkjMqS/3qIJhods9bUiM6XwPqvGapFGcIZx/XCOOftOqJUmTJdD4rqw/yauftt9R88qeb4scWE/BmKy96XzfBYMgb8AcYw5SJ93RQSXbaNYWkCE+W+jWsKEG0RQe0OHKdVUAnQ/fV4/xLaMjkxOlSoIV3sZ5wIQfU0ZXSlm7rdVIjjdCT6dv8B+g0nrOLQNKy8aUY9q75Hrd+vYeWt48ZdGDFVKdshptSheGLHianztK1VH/uPYqr704JeqTfA7FRR02Ogw22zXk4JeBQYp5OGK3gDGaikMl60tLSzOFXZtbTvxsfrPokKhYhQVfuspzHHuYqKIMKigYs/RVlk1cDlde06bV8KeC7cefTciE7Uhp+M93DC7+DqacasHiLUztuzxjIUjzSSLTB5SaS95QJGhS1e33GB5F4zW2sL5DICFIEOMxQdWdLr/cJ8Vug59PQRaxbTZnu1B3hXbMzarzFWbox3dE8UYCmMdqQNpitbfaVUbdnY+BOD+h/+xbr6KfAoEVM8JvqmdnYD/gJdMwhdYvouvzzQl5HX54D0lISz2na8iOyo42N4UiGOAQsOx7CfGpgDDrVI
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(921020)(56012099006)(11063799006)(261022105027099003)(261009223027099003)(261022115727099003)(261028144727099003)(261102130727099003)(261102123227099003)(261021121427099003)(261026140227099003)(261026121527099003)(10067099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yx32ppD7490Hv4LXRa/cJk7A4kouWQeEh5WmwZeBNpJ1oSI1pd3O02ZPEZx28i6IqRCPlb3Jc0EJJa8gk0LGmFnxg9gnRK6GVIjqoQgCxeAKDM0d1dtCrGkG+jQ5a59nuIxvWVkZB9sknQhNB25iZRKtGTkA54hHWcsceLk8lgiq+7oAAO+CrRV1oT9SB9gxq2gy2MAdt1ukitI/Fb0ZYavAZ0SrbGrgiPo9pU/SIOnu8U1BtixaS1wJ68jF3fwYeAsoUkEoN2LaGy4fLLa8uAEcN/c1GTR+typP5b22wNEdJ1UbfOPSLKp0e3NjL5NHEdbXU33nQ63BApPghry16++d3N8XR5Vuw3eQKVnevDAMXKJHiQ9EIlccIYpqJjZ409MUitCBCuC/xFAOMIT6OfGBKG4EIt+R7/RlgqJ/DEOEV6Tz67wntsiRhPNQhHCN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 16:24:52.8094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69808556-f2aa-43a4-10c9-08df39c6fd77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0005BD5E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8DEAB7A29

kexec_alloc_contig() takes the next kernel's destination from the default
CMA area and the next kernel runs from there in place, which is safe only
if that area does not exist at the same address in the kernel being loaded.
For a device-tree area it does: the loaded kernel declares the range it is
executing from as a shared-dma-pool and cma_activate_area() frees its own
image to the page allocator. Record in CMA_DYNAMIC_BASE which areas CMA
placed itself and accept only those, letting kexec_locate_mem_hole() fall
back to the memblock search. "cma=nn" works, "cma=nn@ss" no longer does.

Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes since RFC:
- Use CMA_DYNAMIC_BASE flag instead of CMA_FIXED_BASE.
- Drop Pratyush reviewed-by tag as there is implementation change.
---
 include/linux/cma.h | 10 ++++++++++
 kernel/kexec_file.c | 12 ++++++++++++
 mm/cma.c            | 16 ++++++++++++++++
 mm/cma.h            |  2 ++
 4 files changed, 40 insertions(+)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 8555d38a97b1..d4683a4ff3cc 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -61,4 +61,14 @@ extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
 extern bool cma_intersects(struct cma *cma, unsigned long start, unsigned long end);
 
 extern void cma_reserve_pages_on_error(struct cma *cma);
+
+#ifdef CONFIG_CMA
+bool cma_has_dynamic_base(const struct cma *cma);
+#else
+static inline bool cma_has_dynamic_base(const struct cma *cma)
+{
+	return false;
+}
+#endif
+
 #endif
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b668ce8d68ee..763dee85558f 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -28,6 +28,7 @@
 #include <linux/vmalloc.h>
 #include <linux/dma-map-ops.h>
 #include <linux/kexec_handover.h>
+#include <linux/cma.h>
 #include "kexec_internal.h"
 
 #ifdef CONFIG_KEXEC_SIG
@@ -691,6 +692,7 @@ static int kexec_walk_resources(struct kexec_buf *kbuf,
 static int kexec_alloc_contig(struct kexec_buf *kbuf)
 {
 	size_t nr_pages = kbuf->memsz >> PAGE_SHIFT;
+	struct cma *cma;
 	unsigned long mem;
 	struct page *p;
 
@@ -702,6 +704,16 @@ static int kexec_alloc_contig(struct kexec_buf *kbuf)
 	if (kbuf->image->type == KEXEC_TYPE_CRASH)
 		return -EPERM;
 
+	/*
+	 * The next kernel runs from here rather than being copied out, so it
+	 * would declare this area again from the same description and release
+	 * the pages holding its own image to the page allocator. Only an area
+	 * this kernel placed itself is safe to use.
+	 */
+	cma = dev_get_cma_area(NULL);
+	if (!cma || !cma_has_dynamic_base(cma))
+		return -EOPNOTSUPP;
+
 	p = dma_alloc_from_contiguous(NULL, nr_pages, get_order(kbuf->buf_align), true);
 	if (!p)
 		return -ENOMEM;
diff --git a/mm/cma.c b/mm/cma.c
index 9ec1d1fd5dff..9c53b2b70dc8 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -55,6 +55,19 @@ const char *cma_get_name(const struct cma *cma)
 }
 EXPORT_SYMBOL_GPL(cma_get_name);
 
+/**
+ * cma_has_dynamic_base() - was the area placed at an address CMA chose?
+ * @cma: Contiguous memory region
+ *
+ * An area without a dynamic base was placed where something outside the kernel
+ * said it should go, typically a device tree reserved-memory node, and so lands
+ * at the same address in every kernel booted with that description.
+ */
+bool cma_has_dynamic_base(const struct cma *cma)
+{
+	return test_bit(CMA_DYNAMIC_BASE, &cma->flags);
+}
+
 static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
 					     unsigned int align_order)
 {
@@ -519,6 +532,8 @@ static int __init __cma_declare_contiguous_nid(phys_addr_t *basep,
 	}
 
 	(*res_cma)->nid = nid;
+	if (!fixed)
+		set_bit(CMA_DYNAMIC_BASE, &(*res_cma)->flags);
 	*basep = base;
 
 	return 0;
@@ -708,6 +723,7 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 
 	cma->nranges = nr;
 	cma->nid = nid;
+	set_bit(CMA_DYNAMIC_BASE, &cma->flags);
 	*res_cma = cma;
 
 out:
diff --git a/mm/cma.h b/mm/cma.h
index 68e574b0f951..4703e0958b01 100644
--- a/mm/cma.h
+++ b/mm/cma.h
@@ -80,6 +80,8 @@ enum cma_flags {
 	CMA_ZONES_VALID,
 	CMA_ZONES_INVALID,
 	CMA_ACTIVATED,
+	/* Base address was chosen by CMA, not dictated by the caller. */
+	CMA_DYNAMIC_BASE,
 };
 
 extern struct cma cma_areas[MAX_CMA_AREAS];
-- 
2.44.4

