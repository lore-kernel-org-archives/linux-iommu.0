Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E5EE572
	for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374932; cv=none; b=OIzYOAr6c4jdPfKxVHYOzvzpgl1TelO41PyysQMnshUJBWOAXX7BswtiIa8JWdZctmOZZXmgZvF03g/pAgArH3Jq4ZGnQafRCbDnUhHjDQ0grQ4/92WheYK6Z8iu7XPRaHLCcK0DTTMHHrWTf/+xyzdQJVeqsKnwpG4gE9W2qwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374932; c=relaxed/simple;
	bh=UT3jwponDbjl5OONR3Oj3tAS9bDmUperLc/haaGrdAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BUBTUqhsl9sH/LKFFviKYnxa4Vlv1jDperD+V9KH/1BmAgRP5bJ0cWWomWhFnKt84dhbZNDrdjMQCpCRULelfLGld6FxYK1vVY05zFnzv/9ybbF5A2A8F0wasy4rzBOYRA1M15NxxB9ev9PWk9KQPDEmYDZHn9sgqZwavit5IkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CU6ueDmh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CU6ueDmh"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f700e4cb92so19763545ad.2
        for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 07:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374930; x=1718979730; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x4rb9oTxKJjPNdgedRtYvM9+kkgOfbw//+2IpuNP3u0=;
        b=CU6ueDmhvkQx5je/AH78gFtPRh6j5hhg6mRhQu4u9GUArR3dUwraLnzHyhB+pxpzhX
         0SfVdMwgU7kvb38pDmUq0UexscDV4Sa93lItvcSQPrBTv5jm84sMk3sqLjadaxiRWd43
         bpQwr3A1kUojpHwVvWPcuYJ8xb0PAWnsZm9Od5OJw1rTXJ98uXEnhaZF86e4/BLEZMDI
         mpoi9OEKe2a/zfclAx5Inbq48iI6zP2CfCR1q165cO/IByX2gjHW1di2TqPzWGa4u0XR
         H/2Lk6v9ARKyBmh80hJR4eSwo+nOZX0RvXVK568MTn/yNWQ3YBhFx57XV6fhuXuJIZOb
         oLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374930; x=1718979730;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4rb9oTxKJjPNdgedRtYvM9+kkgOfbw//+2IpuNP3u0=;
        b=hfZ52+BpHuartpFSvlz74+kJ9xDjibqekjgbVVmDrRCnEyUUu515EkswMZhOUZlV8v
         xCtxv/fU3321gIF/h+Gc/j+GwavvdegSsbB08nOeEqexKtNDf0MR9jVO7cghk898wGQV
         pZRsYKSeWHHbZPNHMttB5kOyOK7oETwE9HNTvl5civV/eaf0a9f8E9jW+PyTsEVb2X0L
         oaAU4XhIap42APEYKu14siOlEYObkGK7lzVPBkYkz40kaUD3zh2Nbbapu0XdIC4xgPiX
         nTIcLaXzsbFlzXEUkPot+nE/P6XOpEEGBxUZ3ejE4PiXdJqZ1x1pkBHvKQr4w8kNrGpD
         Nygg==
X-Forwarded-Encrypted: i=1; AJvYcCUwL/HwpbD9pBEwqfvki/MO8ZgFadshHDMVBdnQiLwbjfmAeo5uTIeWOWdzq04LmHZJhnRpTtoS8YUYpZPJG9d4lYTGqvw=
X-Gm-Message-State: AOJu0YyKHTq5ESlCoiRTuIN57J0f7cGz0qLuUg2phi74N/54PhFRlD/2
	CV8dX3VJSgXv6tg3GLrMkVN9zY86nmNBabsSrgGc0nOp0AYdMYd18iWRX9SWcUjGeQMXuqCPtLe
	9cDE=
X-Google-Smtp-Source: AGHT+IEJt+rLxgOJ7sJAERmwv+9zCjQ5igS1rVXxOX0yXhtIC/U/Sk1uEt2Pa5Lkl3QWCML+x9LzJA==
X-Received: by 2002:a17:902:cec6:b0:1f7:36a8:671d with SMTP id d9443c01a7336-1f8625cf720mr34825615ad.25.1718374930121;
        Fri, 14 Jun 2024 07:22:10 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:09 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [RFC PATCH v2 01/10] iommu/riscv: add RISC-V IOMMU PMU support
Date: Fri, 14 Jun 2024 22:21:47 +0800
Message-Id: <20240614142156.29420-2-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614142156.29420-1-zong.li@sifive.com>
References: <20240614142156.29420-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

This patch implements the RISC-V IOMMU hardware performance monitor, it
includes the counting ans sampling mode.

Specification doesn't define the event ID for counting the number of
clock cycles, there is no associated iohpmevt0. But we need an event for
counting cycle in perf, reserve the maximum number of event ID for it now.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/Makefile     |   2 +-
 drivers/iommu/riscv/iommu-bits.h |  16 ++
 drivers/iommu/riscv/iommu-pmu.c  | 479 +++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.h      |   8 +
 4 files changed, 504 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/riscv/iommu-pmu.c

diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
index f54c9ed17d41..d36625a1fd08 100644
--- a/drivers/iommu/riscv/Makefile
+++ b/drivers/iommu/riscv/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-platform.o
+obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-platform.o iommu-pmu.o
 obj-$(CONFIG_RISCV_IOMMU_PCI) += iommu-pci.o
diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index 98daf0e1a306..60523449f016 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/perf_event.h>
 
 /*
  * Chapter 5: Memory Mapped register interface
@@ -207,6 +208,7 @@ enum riscv_iommu_ddtp_modes {
 /* 5.22 Performance monitoring event counters (31 * 64bits) */
 #define RISCV_IOMMU_REG_IOHPMCTR_BASE	0x0068
 #define RISCV_IOMMU_REG_IOHPMCTR(_n)	(RISCV_IOMMU_REG_IOHPMCTR_BASE + ((_n) * 0x8))
+#define RISCV_IOMMU_IOHPMCTR_COUNTER	GENMASK_ULL(63, 0)
 
 /* 5.23 Performance monitoring event selectors (31 * 64bits) */
 #define RISCV_IOMMU_REG_IOHPMEVT_BASE	0x0160
@@ -250,6 +252,20 @@ enum riscv_iommu_hpmevent_id {
 	RISCV_IOMMU_HPMEVENT_MAX        = 9
 };
 
+/* Use maximum event ID for cycle event */
+#define RISCV_IOMMU_HPMEVENT_CYCLE	GENMASK_ULL(14, 0)
+
+#define RISCV_IOMMU_HPM_COUNTER_NUM	32
+
+struct riscv_iommu_pmu {
+	struct pmu pmu;
+	void __iomem *reg;
+	int num_counters;
+	u64 mask_counter;
+	struct perf_event *events[RISCV_IOMMU_IOHPMEVT_CNT + 1];
+	DECLARE_BITMAP(used_counters, RISCV_IOMMU_IOHPMEVT_CNT + 1);
+};
+
 /* 5.24 Translation request IOVA (64bits) */
 #define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
 #define RISCV_IOMMU_TR_REQ_IOVA_VPN	GENMASK_ULL(63, 12)
diff --git a/drivers/iommu/riscv/iommu-pmu.c b/drivers/iommu/riscv/iommu-pmu.c
new file mode 100644
index 000000000000..5fc45aaf4ca3
--- /dev/null
+++ b/drivers/iommu/riscv/iommu-pmu.c
@@ -0,0 +1,479 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 SiFive
+ *
+ * Authors
+ *	Zong Li <zong.li@sifive.com>
+ */
+
+#include <linux/io-64-nonatomic-hi-lo.h>
+
+#include "iommu.h"
+#include "iommu-bits.h"
+
+#define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iommu_pmu, pmu))
+
+#define RISCV_IOMMU_PMU_ATTR_EXTRACTOR(_name, _mask)			\
+	static inline u32 get_##_name(struct perf_event *event)		\
+	{								\
+		return FIELD_GET(_mask, event->attr.config);		\
+	}								\
+
+RISCV_IOMMU_PMU_ATTR_EXTRACTOR(event, RISCV_IOMMU_IOHPMEVT_EVENTID);
+RISCV_IOMMU_PMU_ATTR_EXTRACTOR(partial_matching, RISCV_IOMMU_IOHPMEVT_DMASK);
+RISCV_IOMMU_PMU_ATTR_EXTRACTOR(pid_pscid, RISCV_IOMMU_IOHPMEVT_PID_PSCID);
+RISCV_IOMMU_PMU_ATTR_EXTRACTOR(did_gscid, RISCV_IOMMU_IOHPMEVT_DID_GSCID);
+RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_pid_pscid, RISCV_IOMMU_IOHPMEVT_PV_PSCV);
+RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_did_gscid, RISCV_IOMMU_IOHPMEVT_DV_GSCV);
+RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_id_type, RISCV_IOMMU_IOHPMEVT_IDT);
+
+/* Formats */
+PMU_FORMAT_ATTR(event, "config:0-14");
+PMU_FORMAT_ATTR(partial_matching, "config:15");
+PMU_FORMAT_ATTR(pid_pscid, "config:16-35");
+PMU_FORMAT_ATTR(did_gscid, "config:36-59");
+PMU_FORMAT_ATTR(filter_pid_pscid, "config:60");
+PMU_FORMAT_ATTR(filter_did_gscid, "config:61");
+PMU_FORMAT_ATTR(filter_id_type, "config:62");
+
+static struct attribute *riscv_iommu_pmu_formats[] = {
+	&format_attr_event.attr,
+	&format_attr_partial_matching.attr,
+	&format_attr_pid_pscid.attr,
+	&format_attr_did_gscid.attr,
+	&format_attr_filter_pid_pscid.attr,
+	&format_attr_filter_did_gscid.attr,
+	&format_attr_filter_id_type.attr,
+	NULL,
+};
+
+static const struct attribute_group riscv_iommu_pmu_format_group = {
+	.name = "format",
+	.attrs = riscv_iommu_pmu_formats,
+};
+
+/* Events */
+static ssize_t riscv_iommu_pmu_event_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
+PMU_EVENT_ATTR(cycle, event_attr_cycle,
+	       RISCV_IOMMU_HPMEVENT_CYCLE, riscv_iommu_pmu_event_show);
+PMU_EVENT_ATTR(dont_count, event_attr_dont_count,
+	       RISCV_IOMMU_HPMEVENT_INVALID, riscv_iommu_pmu_event_show);
+PMU_EVENT_ATTR(untranslated_req, event_attr_untranslated_req,
+	       RISCV_IOMMU_HPMEVENT_URQ, riscv_iommu_pmu_event_show);
+PMU_EVENT_ATTR(translated_req, event_attr_translated_req,
+	       RISCV_IOMMU_HPMEVENT_TRQ, riscv_iommu_pmu_event_show);
+PMU_EVENT_ATTR(ats_trans_req, event_attr_ats_trans_req,
+	       RISCV_IOMMU_HPMEVENT_ATS_RQ, riscv_iommu_pmu_event_show);
+PMU_EVENT_ATTR(tlb_miss, event_attr_tlb_miss,
+	       RISCV_IOMMU_HPMEVENT_TLB_MISS, riscv_iommu_pmu_event_show);
+PMU_EVENT_ATTR(ddt_walks, event_attr_ddt_walks,
+	       RISCV_IOMMU_HPMEVENT_DD_WALK, riscv_iommu_pmu_event_show);
+PMU_EVENT_ATTR(pdt_walks, event_attr_pdt_walks,
+	       RISCV_IOMMU_HPMEVENT_PD_WALK, riscv_iommu_pmu_event_show);
+PMU_EVENT_ATTR(s_vs_pt_walks, event_attr_s_vs_pt_walks,
+	       RISCV_IOMMU_HPMEVENT_S_VS_WALKS, riscv_iommu_pmu_event_show);
+PMU_EVENT_ATTR(g_pt_walks, event_attr_g_pt_walks,
+	       RISCV_IOMMU_HPMEVENT_G_WALKS, riscv_iommu_pmu_event_show);
+
+static struct attribute *riscv_iommu_pmu_events[] = {
+	&event_attr_cycle.attr.attr,
+	&event_attr_dont_count.attr.attr,
+	&event_attr_untranslated_req.attr.attr,
+	&event_attr_translated_req.attr.attr,
+	&event_attr_ats_trans_req.attr.attr,
+	&event_attr_tlb_miss.attr.attr,
+	&event_attr_ddt_walks.attr.attr,
+	&event_attr_pdt_walks.attr.attr,
+	&event_attr_s_vs_pt_walks.attr.attr,
+	&event_attr_g_pt_walks.attr.attr,
+	NULL,
+};
+
+static const struct attribute_group riscv_iommu_pmu_events_group = {
+	.name = "events",
+	.attrs = riscv_iommu_pmu_events,
+};
+
+static const struct attribute_group *riscv_iommu_pmu_attr_grps[] = {
+	&riscv_iommu_pmu_format_group,
+	&riscv_iommu_pmu_events_group,
+	NULL,
+};
+
+/* PMU Operations */
+static void riscv_iommu_pmu_set_counter(struct riscv_iommu_pmu *pmu, u32 idx,
+					u64 value)
+{
+	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
+
+	if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
+		return;
+
+	writeq(FIELD_PREP(RISCV_IOMMU_IOHPMCTR_COUNTER, value), addr + idx * 8);
+}
+
+static u64 riscv_iommu_pmu_get_counter(struct riscv_iommu_pmu *pmu, u32 idx)
+{
+	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
+	u64 value;
+
+	if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
+		return -EINVAL;
+
+	value = readq(addr + idx * 8);
+
+	return FIELD_GET(RISCV_IOMMU_IOHPMCTR_COUNTER, value);
+}
+
+static u64 riscv_iommu_pmu_get_event(struct riscv_iommu_pmu *pmu, u32 idx)
+{
+	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOHPMEVT_BASE;
+
+	if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
+		return 0;
+
+	/* There is no associtated IOHPMEVT0 for IOHPMCYCLES */
+	if (idx == 0)
+		return 0;
+
+	return readq(addr + (idx - 1) * 8);
+}
+
+static void riscv_iommu_pmu_set_event(struct riscv_iommu_pmu *pmu, u32 idx,
+				      u64 value)
+{
+	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOHPMEVT_BASE;
+
+	if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
+		return;
+
+	/* There is no associtated IOHPMEVT0 for IOHPMCYCLES */
+	if (idx == 0)
+		return;
+
+	writeq(value, addr + (idx - 1) * 8);
+}
+
+static void riscv_iommu_pmu_enable_counter(struct riscv_iommu_pmu *pmu, u32 idx)
+{
+	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
+	u32 value = readl(addr);
+
+	writel(value & ~BIT(idx), addr);
+}
+
+static void riscv_iommu_pmu_disable_counter(struct riscv_iommu_pmu *pmu, u32 idx)
+{
+	void __iomem *addr = pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
+	u32 value = readl(addr);
+
+	writel(value | BIT(idx), addr);
+}
+
+static void riscv_iommu_pmu_enable_ovf_intr(struct riscv_iommu_pmu *pmu, u32 idx)
+{
+	u64 value;
+
+	if (get_event(pmu->events[idx]) == RISCV_IOMMU_HPMEVENT_CYCLE) {
+		value = riscv_iommu_pmu_get_counter(pmu, idx) & ~RISCV_IOMMU_IOHPMCYCLES_OF;
+		writeq(value, pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES);
+	} else {
+		value = riscv_iommu_pmu_get_event(pmu, idx) & ~RISCV_IOMMU_IOHPMEVT_OF;
+		writeq(value, pmu->reg + RISCV_IOMMU_REG_IOHPMEVT_BASE + (idx - 1) * 8);
+	}
+}
+
+static void riscv_iommu_pmu_disable_ovf_intr(struct riscv_iommu_pmu *pmu, u32 idx)
+{
+	u64 value;
+
+	if (get_event(pmu->events[idx]) == RISCV_IOMMU_HPMEVENT_CYCLE) {
+		value = riscv_iommu_pmu_get_counter(pmu, idx) | RISCV_IOMMU_IOHPMCYCLES_OF;
+		writeq(value, pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES);
+	} else {
+		value = riscv_iommu_pmu_get_event(pmu, idx) | RISCV_IOMMU_IOHPMEVT_OF;
+		writeq(value, pmu->reg + RISCV_IOMMU_REG_IOHPMEVT_BASE + (idx - 1) * 8);
+	}
+}
+
+static void riscv_iommu_pmu_start_all(struct riscv_iommu_pmu *pmu)
+{
+	int idx;
+
+	for_each_set_bit(idx, pmu->used_counters, pmu->num_counters) {
+		riscv_iommu_pmu_enable_ovf_intr(pmu, idx);
+		riscv_iommu_pmu_enable_counter(pmu, idx);
+	}
+}
+
+static void riscv_iommu_pmu_stop_all(struct riscv_iommu_pmu *pmu)
+{
+	writel(GENMASK_ULL(pmu->num_counters - 1, 0),
+	       pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH);
+}
+
+/* PMU APIs */
+static int riscv_iommu_pmu_set_period(struct perf_event *event)
+{
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	s64 left = local64_read(&hwc->period_left);
+	s64 period = hwc->sample_period;
+	u64 max_period = pmu->mask_counter;
+	int ret = 0;
+
+	if (unlikely(left <= -period)) {
+		left = period;
+		local64_set(&hwc->period_left, left);
+		hwc->last_period = period;
+		ret = 1;
+	}
+
+	if (unlikely(left <= 0)) {
+		left += period;
+		local64_set(&hwc->period_left, left);
+		hwc->last_period = period;
+		ret = 1;
+	}
+
+	/*
+	 * Limit the maximum period to prevent the counter value
+	 * from overtaking the one we are about to program. In
+	 * effect we are reducing max_period to account for
+	 * interrupt latency (and we are being very conservative).
+	 */
+	if (left > (max_period >> 1))
+		left = (max_period >> 1);
+
+	local64_set(&hwc->prev_count, (u64)-left);
+	riscv_iommu_pmu_set_counter(pmu, hwc->idx, (u64)(-left) & max_period);
+	perf_event_update_userpage(event);
+
+	return ret;
+}
+
+static int riscv_iommu_pmu_event_init(struct perf_event *event)
+{
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	hwc->idx = -1;
+	hwc->config = event->attr.config;
+
+	if (!is_sampling_event(event)) {
+		/*
+		 * For non-sampling runs, limit the sample_period to half
+		 * of the counter width. That way, the new counter value
+		 * is far less likely to overtake the previous one unless
+		 * you have some serious IRQ latency issues.
+		 */
+		hwc->sample_period = pmu->mask_counter >> 1;
+		hwc->last_period = hwc->sample_period;
+		local64_set(&hwc->period_left, hwc->sample_period);
+	}
+
+	return 0;
+}
+
+static void riscv_iommu_pmu_update(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	u64 delta, prev, now;
+	u32 idx = hwc->idx;
+
+	do {
+		prev = local64_read(&hwc->prev_count);
+		now = riscv_iommu_pmu_get_counter(pmu, idx);
+	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
+
+	delta = FIELD_GET(RISCV_IOMMU_IOHPMCTR_COUNTER, now - prev) & pmu->mask_counter;
+	local64_add(delta, &event->count);
+	local64_sub(delta, &hwc->period_left);
+}
+
+static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
+{
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
+		return;
+
+	if (flags & PERF_EF_RELOAD)
+		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
+
+	hwc->state = 0;
+	riscv_iommu_pmu_set_period(event);
+	riscv_iommu_pmu_set_event(pmu, hwc->idx, hwc->config);
+	riscv_iommu_pmu_enable_ovf_intr(pmu, hwc->idx);
+	riscv_iommu_pmu_enable_counter(pmu, hwc->idx);
+
+	perf_event_update_userpage(event);
+}
+
+static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
+{
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	riscv_iommu_pmu_set_event(pmu, hwc->idx, RISCV_IOMMU_HPMEVENT_INVALID);
+	riscv_iommu_pmu_disable_counter(pmu, hwc->idx);
+
+	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE))
+		riscv_iommu_pmu_update(event);
+
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	unsigned int num_counters = pmu->num_counters;
+	int idx;
+
+	/* Reserve index zero for iohpmcycles */
+	if (get_event(event) == RISCV_IOMMU_HPMEVENT_CYCLE)
+		idx = 0;
+	else
+		idx = find_next_zero_bit(pmu->used_counters, num_counters, 1);
+
+	if (idx == num_counters)
+		return -EAGAIN;
+
+	set_bit(idx, pmu->used_counters);
+
+	pmu->events[idx] = event;
+	hwc->idx = idx;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	if (flags & PERF_EF_START)
+		riscv_iommu_pmu_start(event, flags);
+
+	/* Propagate changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static void riscv_iommu_pmu_read(struct perf_event *event)
+{
+	riscv_iommu_pmu_update(event);
+}
+
+static void riscv_iommu_pmu_del(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	int idx = hwc->idx;
+
+	riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
+	pmu->events[idx] = NULL;
+	clear_bit(idx, pmu->used_counters);
+	perf_event_update_userpage(event);
+}
+
+irqreturn_t riscv_iommu_pmu_handle_irq(struct riscv_iommu_pmu *pmu)
+{
+	struct perf_sample_data data;
+	struct pt_regs *regs;
+	u32 ovf = readl(pmu->reg + RISCV_IOMMU_REG_IOCOUNTOVF);
+	int idx;
+
+	if (!ovf)
+		return IRQ_NONE;
+
+	riscv_iommu_pmu_stop_all(pmu);
+
+	regs = get_irq_regs();
+
+	for_each_set_bit(idx, (unsigned long *)&ovf, pmu->num_counters) {
+		struct perf_event *event = pmu->events[idx];
+		struct hw_perf_event *hwc;
+
+		if (WARN_ON_ONCE(!event) || !is_sampling_event(event))
+			continue;
+
+		hwc = &event->hw;
+
+		riscv_iommu_pmu_update(event);
+		perf_sample_data_init(&data, 0, hwc->last_period);
+		if (!riscv_iommu_pmu_set_period(event))
+			continue;
+
+		if (perf_event_overflow(event, &data, regs))
+			riscv_iommu_pmu_stop(event, 0);
+	}
+
+	riscv_iommu_pmu_start_all(pmu);
+
+	return IRQ_HANDLED;
+}
+
+int riscv_iommu_pmu_init(struct riscv_iommu_pmu *pmu, void __iomem *reg,
+			 const char *dev_name)
+{
+	char *name;
+	int ret;
+
+	pmu->reg = reg;
+	pmu->num_counters = RISCV_IOMMU_HPM_COUNTER_NUM;
+	pmu->mask_counter = RISCV_IOMMU_IOHPMCTR_COUNTER;
+
+	pmu->pmu = (struct pmu) {
+		.task_ctx_nr	= perf_invalid_context,
+		.event_init	= riscv_iommu_pmu_event_init,
+		.add		= riscv_iommu_pmu_add,
+		.del		= riscv_iommu_pmu_del,
+		.start		= riscv_iommu_pmu_start,
+		.stop		= riscv_iommu_pmu_stop,
+		.read		= riscv_iommu_pmu_read,
+		.attr_groups	= riscv_iommu_pmu_attr_grps,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+		.module		= THIS_MODULE,
+	};
+
+	name = kasprintf(GFP_KERNEL, "riscv_iommu_pmu_%s", dev_name);
+
+	ret = perf_pmu_register(&pmu->pmu, name, -1);
+	if (ret) {
+		pr_err("Failed to register riscv_iommu_pmu_%s: %d\n",
+		       dev_name, ret);
+		return ret;
+	}
+
+	/* Stop all counters and later start the counter with perf */
+	riscv_iommu_pmu_stop_all(pmu);
+
+	pr_info("riscv_iommu_pmu_%s: Registered with %d counters\n",
+		dev_name, pmu->num_counters);
+
+	return 0;
+}
+
+void riscv_iommu_pmu_uninit(struct riscv_iommu_pmu *pmu)
+{
+	int idx;
+
+	/* Disable interrupt and functions */
+	for_each_set_bit(idx, pmu->used_counters, pmu->num_counters) {
+		riscv_iommu_pmu_disable_counter(pmu, idx);
+		riscv_iommu_pmu_disable_ovf_intr(pmu, idx);
+	}
+
+	perf_pmu_unregister(&pmu->pmu);
+}
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index b1c4664542b4..92659a8a75ae 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -60,11 +60,19 @@ struct riscv_iommu_device {
 	unsigned int ddt_mode;
 	dma_addr_t ddt_phys;
 	u64 *ddt_root;
+
+	/* hardware performance monitor */
+	struct riscv_iommu_pmu pmu;
 };
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu);
 void riscv_iommu_remove(struct riscv_iommu_device *iommu);
 
+int riscv_iommu_pmu_init(struct riscv_iommu_pmu *pmu, void __iomem *reg,
+			 const char *name);
+void riscv_iommu_pmu_uninit(struct riscv_iommu_pmu *pmu);
+irqreturn_t riscv_iommu_pmu_handle_irq(struct riscv_iommu_pmu *pmu);
+
 #define riscv_iommu_readl(iommu, addr) \
 	readl_relaxed((iommu)->reg + (addr))
 
-- 
2.17.1

