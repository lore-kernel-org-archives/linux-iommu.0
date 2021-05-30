Return-Path: <SRS0=A9HU=KZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D0CC47095
	for <iommu@archiver.kernel.org>; Sun, 30 May 2021 15:06:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E282611AC
	for <iommu@archiver.kernel.org>; Sun, 30 May 2021 15:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E282611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D62B840275;
	Sun, 30 May 2021 15:06:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8LOkU7IQyuh6; Sun, 30 May 2021 15:06:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3F41640198;
	Sun, 30 May 2021 15:06:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AB53C000D;
	Sun, 30 May 2021 15:06:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54B22C0001
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 15:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50B6840198
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 15:06:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QuylZoPrFShP for <iommu@lists.linux-foundation.org>;
 Sun, 30 May 2021 15:06:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 36752401BD
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 15:06:44 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id p39so7076528pfw.8
 for <iommu@lists.linux-foundation.org>; Sun, 30 May 2021 08:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=as2MfWVTTjebtE6pObnR6ZA7Z7Mm2lquU8h3QkjiG+Y=;
 b=GpZ60FI6fTr2Eb0z+JTjvboH6NeKZstEkZ9Z3PcaEev5NTP5cyblGYKdaVvXLEr73E
 WX+AEtVQzFVfJaLV0rYdWNfG4LrBbdsrnRbFm4RpbKaCmNw1mQZDhRlTndRUyrZnQNhw
 sbNHxW6s7/Twp5y6+uUKltkXMZDm6+ka+AqcBJmYLAdpfVO1jFJa79kQ4XH1KSZwaAWT
 va/SSdgTJhh2i8jjzh4r1zZBeqmPTKcKLpJ/SXZH/mTj4+QEpCrFvfzA4muUqpzsyXKB
 ZZdJclz9Jcoqd0dAOmUrQ8hcyE2iaZOIYsoE5BbOWtOfJ+QgEo4cSySeRczXEFgKMmmr
 lbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=as2MfWVTTjebtE6pObnR6ZA7Z7Mm2lquU8h3QkjiG+Y=;
 b=XB7YyC9uFUZZeHzeH1ctqlNxpeXHFyYsMJo/enS8piuZenvX8+C89YKcsP41GE1mpi
 DTh9wLX0R4H2x7Wne8broIbE6R/Zt/VmrdLANOscUl/vlfVc2J/g8VEjKACZu7i5tOQG
 RAC8U6I+eXEyChMgc5nf7PSHKAOL5BT/GkaiFNWyWvJkLt0utAxmrhAWpWhvJGNfumtP
 QPPq/slq1aa21/xVqqFxmeIqYLbXrvVHN6rbAKWtSK00d1CYJPhny1w1dZrw0YtoGP+f
 O0sr8ZesnDXEiczEZ3Jf3XQoy5A7X54KCgKvxj3FQDDopw1kQlGwZmWhvYjgsiCFMOxU
 T0fQ==
X-Gm-Message-State: AOAM533LzNruE4wC/fp/qX4u9GH4RHBlHrbpdIU3maQFX47ZB1F6XCMt
 xyBwbbNmJv6qNkvYOU/G5Ro=
X-Google-Smtp-Source: ABdhPJz/1IJuFU3tpWooRg4ISBSdPCyLtODAH6GZPX1+lCpyZCLB2ut70Lz6laAnP0+zEj7rLpgQiw==
X-Received: by 2002:aa7:84d9:0:b029:2dc:9bd3:91f3 with SMTP id
 x25-20020aa784d90000b02902dc9bd391f3mr13280563pfn.0.1622387203493; 
 Sun, 30 May 2021 08:06:43 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:9:dc2d:80ab:c3f3:1524])
 by smtp.gmail.com with ESMTPSA id b15sm8679688pfi.100.2021.05.30.08.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 May 2021 08:06:43 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 arnd@arndb.de, dave.hansen@linux.intel.com, luto@kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org,
 kirill.shutemov@linux.intel.com, rppt@kernel.org, hannes@cmpxchg.org,
 cai@lca.pw, krish.sadhukhan@oracle.com, saravanand@fb.com,
 Tianyu.Lan@microsoft.com, konrad.wilk@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com, boris.ostrovsky@oracle.com,
 jgross@suse.com, sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 xen-devel@lists.xenproject.org, davem@davemloft.net, kuba@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com
Subject: [RFC PATCH V3 04/11] HV: Add Write/Read MSR registers via ghcb
Date: Sun, 30 May 2021 11:06:21 -0400
Message-Id: <20210530150628.2063957-5-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210530150628.2063957-1-ltykernel@gmail.com>
References: <20210530150628.2063957-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, sunilmut@microsoft.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V provides GHCB protocol to write Synthetic Interrupt
Controller MSR registers and these registers are emulated by
Hypervisor rather than paravisor in VMPL0.

Hyper-V requests to write SINTx MSR registers twice(once via
GHCB and once via wrmsr instruction emulated by paravisor including
the proxy bit 21). Guest OS ID MSR also needs to be set via GHCB.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/hv_init.c       |  26 +------
 arch/x86/hyperv/ivm.c           | 125 ++++++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h |  78 +++++++++++++++++++-
 arch/x86/kernel/cpu/mshyperv.c  |   3 +
 drivers/hv/hv.c                 | 114 +++++++++++++++++++----------
 include/asm-generic/mshyperv.h  |   4 +-
 6 files changed, 287 insertions(+), 63 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index dc74d01cb859..e35a3c1556b8 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -472,6 +472,9 @@ void __init hyperv_init(void)
 
 		ghcb_base = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
 		*ghcb_base = ghcb_va;
+
+		/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
+		hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
 	}
 
 	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
@@ -564,6 +567,7 @@ void hyperv_cleanup(void)
 
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
+	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
 
 	/*
 	 * Reset hypercall page reference before reset the page,
@@ -645,28 +649,6 @@ bool hv_is_hibernation_supported(void)
 }
 EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
 
-enum hv_isolation_type hv_get_isolation_type(void)
-{
-	if (!(ms_hyperv.priv_high & HV_ISOLATION))
-		return HV_ISOLATION_TYPE_NONE;
-	return FIELD_GET(HV_ISOLATION_TYPE, ms_hyperv.isolation_config_b);
-}
-EXPORT_SYMBOL_GPL(hv_get_isolation_type);
-
-bool hv_is_isolation_supported(void)
-{
-	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
-}
-EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
-
-DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
-
-bool hv_isolation_type_snp(void)
-{
-	return static_branch_unlikely(&isolation_type_snp);
-}
-EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
-
 /* Bit mask of the extended capability to query: see HV_EXT_CAPABILITY_xxx */
 bool hv_query_ext_cap(u64 cap_query)
 {
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index fad1d3024056..fd6dd804beef 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -6,12 +6,137 @@
  *  Tianyu Lan <Tianyu.Lan@microsoft.com>
  */
 
+#include <linux/types.h>
+#include <linux/bitfield.h>
 #include <linux/hyperv.h>
 #include <linux/types.h>
 #include <linux/bitfield.h>
 #include <asm/io.h>
+#include <asm/svm.h>
+#include <asm/sev-es.h>
 #include <asm/mshyperv.h>
 
+union hv_ghcb {
+	struct ghcb ghcb;
+} __packed __aligned(PAGE_SIZE);
+
+void hv_ghcb_msr_write(u64 msr, u64 value)
+{
+	union hv_ghcb *hv_ghcb;
+	void **ghcb_base;
+	unsigned long flags;
+
+	if (!ms_hyperv.ghcb_base)
+		return;
+
+	local_irq_save(flags);
+	ghcb_base = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
+	hv_ghcb = (union hv_ghcb *)*ghcb_base;
+	if (!hv_ghcb) {
+		local_irq_restore(flags);
+		return;
+	}
+
+	memset(hv_ghcb, 0x00, HV_HYP_PAGE_SIZE);
+
+	hv_ghcb->ghcb.protocol_version = 1;
+	hv_ghcb->ghcb.ghcb_usage = 0;
+
+	ghcb_set_sw_exit_code(&hv_ghcb->ghcb, SVM_EXIT_MSR);
+	ghcb_set_rcx(&hv_ghcb->ghcb, msr);
+	ghcb_set_rax(&hv_ghcb->ghcb, lower_32_bits(value));
+	ghcb_set_rdx(&hv_ghcb->ghcb, value >> 32);
+	ghcb_set_sw_exit_info_1(&hv_ghcb->ghcb, 1);
+	ghcb_set_sw_exit_info_2(&hv_ghcb->ghcb, 0);
+
+	VMGEXIT();
+
+	if ((hv_ghcb->ghcb.save.sw_exit_info_1 & 0xffffffff) == 1)
+		pr_warn("Fail to write msr via ghcb %llx.\n", msr);
+
+	local_irq_restore(flags);
+}
+
+void hv_ghcb_msr_read(u64 msr, u64 *value)
+{
+	union hv_ghcb *hv_ghcb;
+	void **ghcb_base;
+	unsigned long flags;
+
+	if (!ms_hyperv.ghcb_base)
+		return;
+
+	local_irq_save(flags);
+	ghcb_base = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
+	hv_ghcb = (union hv_ghcb *)*ghcb_base;
+	if (!hv_ghcb) {
+		local_irq_restore(flags);
+		return;
+	}
+
+	memset(hv_ghcb, 0x00, HV_HYP_PAGE_SIZE);
+	hv_ghcb->ghcb.protocol_version = 1;
+	hv_ghcb->ghcb.ghcb_usage = 0;
+
+	ghcb_set_sw_exit_code(&hv_ghcb->ghcb, SVM_EXIT_MSR);
+	ghcb_set_rcx(&hv_ghcb->ghcb, msr);
+	ghcb_set_sw_exit_info_1(&hv_ghcb->ghcb, 0);
+	ghcb_set_sw_exit_info_2(&hv_ghcb->ghcb, 0);
+
+	VMGEXIT();
+
+	if ((hv_ghcb->ghcb.save.sw_exit_info_1 & 0xffffffff) == 1)
+		pr_warn("Fail to read msr via ghcb %llx.\n", msr);
+	else
+		*value = (u64)lower_32_bits(hv_ghcb->ghcb.save.rax)
+			| ((u64)lower_32_bits(hv_ghcb->ghcb.save.rdx) << 32);
+	local_irq_restore(flags);
+}
+
+void hv_sint_rdmsrl_ghcb(u64 msr, u64 *value)
+{
+	hv_ghcb_msr_read(msr, value);
+}
+EXPORT_SYMBOL_GPL(hv_sint_rdmsrl_ghcb);
+
+void hv_sint_wrmsrl_ghcb(u64 msr, u64 value)
+{
+	hv_ghcb_msr_write(msr, value);
+
+	/* Write proxy bit vua wrmsrl instruction. */
+	if (msr >= HV_X64_MSR_SINT0 && msr <= HV_X64_MSR_SINT15)
+		wrmsrl(msr, value | 1 << 20);
+}
+EXPORT_SYMBOL_GPL(hv_sint_wrmsrl_ghcb);
+
+void hv_signal_eom_ghcb(void)
+{
+	hv_sint_wrmsrl_ghcb(HV_X64_MSR_EOM, 0);
+}
+EXPORT_SYMBOL_GPL(hv_signal_eom_ghcb);
+
+enum hv_isolation_type hv_get_isolation_type(void)
+{
+	if (!(ms_hyperv.priv_high & HV_ISOLATION))
+		return HV_ISOLATION_TYPE_NONE;
+	return FIELD_GET(HV_ISOLATION_TYPE, ms_hyperv.isolation_config_b);
+}
+EXPORT_SYMBOL_GPL(hv_get_isolation_type);
+
+bool hv_is_isolation_supported(void)
+{
+	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
+}
+EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
+
+DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
+
+bool hv_isolation_type_snp(void)
+{
+	return static_branch_unlikely(&isolation_type_snp);
+}
+EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
+
 /*
  * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
  *
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 6af9d55ffe3b..eec7f3357d51 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -30,6 +30,63 @@ static inline u64 hv_get_register(unsigned int reg)
 	return value;
 }
 
+#define hv_get_sint_reg(val, reg) {		\
+	if (hv_isolation_type_snp())		\
+		hv_get_##reg##_ghcb(&val);	\
+	else					\
+		rdmsrl(HV_X64_MSR_##reg, val);	\
+	}
+
+#define hv_set_sint_reg(val, reg) {		\
+	if (hv_isolation_type_snp())		\
+		hv_set_##reg##_ghcb(val);	\
+	else					\
+		wrmsrl(HV_X64_MSR_##reg, val);	\
+	}
+
+
+#define hv_get_simp(val) hv_get_sint_reg(val, SIMP)
+#define hv_get_siefp(val) hv_get_sint_reg(val, SIEFP)
+
+#define hv_set_simp(val) hv_set_sint_reg(val, SIMP)
+#define hv_set_siefp(val) hv_set_sint_reg(val, SIEFP)
+
+#define hv_get_synic_state(val) {			\
+	if (hv_isolation_type_snp())			\
+		hv_get_synic_state_ghcb(&val);		\
+	else						\
+		rdmsrl(HV_X64_MSR_SCONTROL, val);	\
+	}
+#define hv_set_synic_state(val) {			\
+	if (hv_isolation_type_snp())			\
+		hv_set_synic_state_ghcb(val);		\
+	else						\
+		wrmsrl(HV_X64_MSR_SCONTROL, val);	\
+	}
+
+#define hv_get_vp_index(index) rdmsrl(HV_X64_MSR_VP_INDEX, index)
+
+#define hv_signal_eom() {			 \
+	if (hv_isolation_type_snp() &&		 \
+	    old_msg_type != HVMSG_TIMER_EXPIRED) \
+		hv_signal_eom_ghcb();		 \
+	else					 \
+		wrmsrl(HV_X64_MSR_EOM, 0);	 \
+	}
+
+#define hv_get_synint_state(int_num, val) {		\
+	if (hv_isolation_type_snp())			\
+		hv_get_synint_state_ghcb(int_num, &val);\
+	else						\
+		rdmsrl(HV_X64_MSR_SINT0 + int_num, val);\
+	}
+#define hv_set_synint_state(int_num, val) {		\
+	if (hv_isolation_type_snp())			\
+		hv_set_synint_state_ghcb(int_num, val);	\
+	else						\
+		wrmsrl(HV_X64_MSR_SINT0 + int_num, val);\
+	}
+
 #define hv_get_raw_timer() rdtsc_ordered()
 
 void hyperv_vector_handler(struct pt_regs *regs);
@@ -197,6 +254,25 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
 int hv_mark_gpa_visibility(u16 count, const u64 pfn[], u32 visibility);
 int hv_set_mem_host_visibility(void *kbuffer, size_t size,
 			       enum vmbus_page_visibility visibility);
+void hv_sint_wrmsrl_ghcb(u64 msr, u64 value);
+void hv_sint_rdmsrl_ghcb(u64 msr, u64 *value);
+void hv_signal_eom_ghcb(void);
+void hv_ghcb_msr_write(u64 msr, u64 value);
+void hv_ghcb_msr_read(u64 msr, u64 *value);
+
+#define hv_get_synint_state_ghcb(int_num, val)			\
+	hv_sint_rdmsrl_ghcb(HV_X64_MSR_SINT0 + int_num, val)
+#define hv_set_synint_state_ghcb(int_num, val) \
+	hv_sint_wrmsrl_ghcb(HV_X64_MSR_SINT0 + int_num, val)
+
+#define hv_get_SIMP_ghcb(val) hv_sint_rdmsrl_ghcb(HV_X64_MSR_SIMP, val)
+#define hv_set_SIMP_ghcb(val) hv_sint_wrmsrl_ghcb(HV_X64_MSR_SIMP, val)
+
+#define hv_get_SIEFP_ghcb(val) hv_sint_rdmsrl_ghcb(HV_X64_MSR_SIEFP, val)
+#define hv_set_SIEFP_ghcb(val) hv_sint_wrmsrl_ghcb(HV_X64_MSR_SIEFP, val)
+
+#define hv_get_synic_state_ghcb(val) hv_sint_rdmsrl_ghcb(HV_X64_MSR_SCONTROL, val)
+#define hv_set_synic_state_ghcb(val) hv_sint_wrmsrl_ghcb(HV_X64_MSR_SCONTROL, val)
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
@@ -213,9 +289,9 @@ static inline int hyperv_flush_guest_mapping_range(u64 as,
 {
 	return -1;
 }
+static inline void hv_signal_eom_ghcb(void) { };
 #endif /* CONFIG_HYPERV */
 
-
 #include <asm-generic/mshyperv.h>
 
 #endif
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index d1ca36224657..c19e14ec8eec 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -325,6 +325,9 @@ static void __init ms_hyperv_init_platform(void)
 
 		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
+
+		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP)
+			static_branch_enable(&isolation_type_snp);
 	}
 
 	if (ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED) {
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index e83507f49676..28faa8364952 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -136,17 +136,24 @@ int hv_synic_alloc(void)
 		tasklet_init(&hv_cpu->msg_dpc,
 			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
 
-		hv_cpu->synic_message_page =
-			(void *)get_zeroed_page(GFP_ATOMIC);
-		if (hv_cpu->synic_message_page == NULL) {
-			pr_err("Unable to allocate SYNIC message page\n");
-			goto err;
-		}
+		/*
+		 * Synic message and event pages are allocated by paravisor.
+		 * Skip these pages allocation here.
+		 */
+		if (!hv_isolation_type_snp()) {
+			hv_cpu->synic_message_page =
+				(void *)get_zeroed_page(GFP_ATOMIC);
+			if (hv_cpu->synic_message_page == NULL) {
+				pr_err("Unable to allocate SYNIC message page\n");
+				goto err;
+			}
 
-		hv_cpu->synic_event_page = (void *)get_zeroed_page(GFP_ATOMIC);
-		if (hv_cpu->synic_event_page == NULL) {
-			pr_err("Unable to allocate SYNIC event page\n");
-			goto err;
+			hv_cpu->synic_event_page =
+				(void *)get_zeroed_page(GFP_ATOMIC);
+			if (hv_cpu->synic_event_page == NULL) {
+				pr_err("Unable to allocate SYNIC event page\n");
+				goto err;
+			}
 		}
 
 		hv_cpu->post_msg_page = (void *)get_zeroed_page(GFP_ATOMIC);
@@ -173,10 +180,17 @@ void hv_synic_free(void)
 	for_each_present_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
+		free_page((unsigned long)hv_cpu->post_msg_page);
+
+		/*
+		 * Synic message and event pages are allocated by paravisor.
+		 * Skip free these pages here.
+		 */
+		if (hv_isolation_type_snp())
+			continue;
 
 		free_page((unsigned long)hv_cpu->synic_event_page);
 		free_page((unsigned long)hv_cpu->synic_message_page);
-		free_page((unsigned long)hv_cpu->post_msg_page);
 	}
 
 	kfree(hv_context.hv_numa_map);
@@ -199,26 +213,43 @@ void hv_synic_enable_regs(unsigned int cpu)
 	union hv_synic_scontrol sctrl;
 
 	/* Setup the Synic's message page */
-	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
+	hv_get_simp(simp.as_uint64);
 	simp.simp_enabled = 1;
-	simp.base_simp_gpa = virt_to_phys(hv_cpu->synic_message_page)
-		>> HV_HYP_PAGE_SHIFT;
 
-	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
+	if (hv_isolation_type_snp()) {
+		hv_cpu->synic_message_page
+			= ioremap_cache(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
+					HV_HYP_PAGE_SIZE);
+		if (!hv_cpu->synic_message_page)
+			pr_err("Fail to map syinc message page.\n");
+	} else {
+		simp.base_simp_gpa = virt_to_phys(hv_cpu->synic_message_page)
+			>> HV_HYP_PAGE_SHIFT;
+	}
+
+	hv_set_simp(simp.as_uint64);
 
 	/* Setup the Synic's event page */
-	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
+	hv_get_siefp(siefp.as_uint64);
 	siefp.siefp_enabled = 1;
-	siefp.base_siefp_gpa = virt_to_phys(hv_cpu->synic_event_page)
-		>> HV_HYP_PAGE_SHIFT;
 
-	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
+	if (hv_isolation_type_snp()) {
+		hv_cpu->synic_event_page =
+			ioremap_cache(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
+				      HV_HYP_PAGE_SIZE);
+
+		if (!hv_cpu->synic_event_page)
+			pr_err("Fail to map syinc event page.\n");
+	} else {
+		siefp.base_siefp_gpa = virt_to_phys(hv_cpu->synic_event_page)
+			>> HV_HYP_PAGE_SHIFT;
+	}
+	hv_set_siefp(siefp.as_uint64);
 
 	/* Setup the shared SINT. */
 	if (vmbus_irq != -1)
 		enable_percpu_irq(vmbus_irq, 0);
-	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
-					VMBUS_MESSAGE_SINT);
+	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
 	shared_sint.vector = vmbus_interrupt;
 	shared_sint.masked = false;
@@ -233,14 +264,12 @@ void hv_synic_enable_regs(unsigned int cpu)
 #else
 	shared_sint.auto_eoi = 0;
 #endif
-	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
-				shared_sint.as_uint64);
+	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
 	/* Enable the global synic bit */
-	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
+	hv_get_synic_state(sctrl.as_uint64);
 	sctrl.enable = 1;
-
-	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
+	hv_set_synic_state(sctrl.as_uint64);
 }
 
 int hv_synic_init(unsigned int cpu)
@@ -262,32 +291,39 @@ void hv_synic_disable_regs(unsigned int cpu)
 	union hv_synic_siefp siefp;
 	union hv_synic_scontrol sctrl;
 
-	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
-					VMBUS_MESSAGE_SINT);
-
+	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 	shared_sint.masked = 1;
+	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
+
 
 	/* Need to correctly cleanup in the case of SMP!!! */
 	/* Disable the interrupt */
-	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
-				shared_sint.as_uint64);
+	hv_get_simp(simp.as_uint64);
 
-	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
+	/*
+	 * In Isolation VM, sim and sief pages are allocated by
+	 * paravisor. These pages also will be used by kdump
+	 * kernel. So just reset enable bit here and keep page
+	 * addresses.
+	 */
 	simp.simp_enabled = 0;
-	simp.base_simp_gpa = 0;
+	if (!hv_isolation_type_snp())
+		simp.base_simp_gpa = 0;
 
-	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
+	hv_set_simp(simp.as_uint64);
 
-	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
+	hv_get_siefp(siefp.as_uint64);
 	siefp.siefp_enabled = 0;
-	siefp.base_siefp_gpa = 0;
 
-	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
+	if (!hv_isolation_type_snp())
+		siefp.base_siefp_gpa = 0;
+
+	hv_set_siefp(siefp.as_uint64);
 
 	/* Disable the global synic bit */
-	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
+	hv_get_synic_state(sctrl.as_uint64);
 	sctrl.enable = 0;
-	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
+	hv_set_synic_state(sctrl.as_uint64);
 
 	if (vmbus_irq != -1)
 		disable_percpu_irq(vmbus_irq);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 2914e27b0429..63e0de2a7c54 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -23,6 +23,7 @@
 #include <linux/bitops.h>
 #include <linux/cpumask.h>
 #include <asm/ptrace.h>
+#include <asm/mshyperv.h>
 #include <asm/hyperv-tlfs.h>
 
 struct ms_hyperv_info {
@@ -51,6 +52,7 @@ extern struct ms_hyperv_info ms_hyperv;
 
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
+extern bool hv_isolation_type_snp(void);
 
 /* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
 static inline int hv_result(u64 status)
@@ -145,7 +147,7 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 		 * possibly deliver another msg from the
 		 * hypervisor
 		 */
-		hv_set_register(HV_REGISTER_EOM, 0);
+		hv_signal_eom();
 	}
 }
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
