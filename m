Return-Path: <SRS0=iPMr=L7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E2AC11F66
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 15:46:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E333361CC3
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 15:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E333361CC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE036605AC;
	Wed,  7 Jul 2021 15:46:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jjkZr926-3VG; Wed,  7 Jul 2021 15:46:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1AD10605D2;
	Wed,  7 Jul 2021 15:46:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E98E9C001A;
	Wed,  7 Jul 2021 15:46:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC603C000E
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 15:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA94840633
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 15:46:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GYNdiVqWbhfv for <iommu@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 15:46:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45F2D40661
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 15:46:53 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id j199so2542893pfd.7
 for <iommu@lists.linux-foundation.org>; Wed, 07 Jul 2021 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Yf6ZTtN7PeYt6X8aFjGtHsBACJgt9SiJhwxT0+Mfzbw=;
 b=sifWWUzXmixvnGdsQykdK2Wy6G+ZMy9MY6kv6S7iets5sYOfuSTxai3Y++EFR9zQL1
 6N2QQZHUhXBcXABah5k6DsIZzbwYym3TPlwmbwhwCPJk/3LVH5IeQAIeJlKVFbEFhg8R
 CUZlBsj1jbcK/UAIsHAPwaTk/Zdn0J/k87BLgyXQYIphH8+IBOQ7Y30r2Hdp3s9bPTS3
 YEwlNsQXEo7trKuzcvB1DrSMIGkZu/rJsd2K1t0spLWK9Ysx/Nhe5lfuP3g/3TmHp4sa
 F+7WngQNJM5y8InhFNVWvrTb7DBrvhzuJusVsn7iKACWSfBjoD8B/fJyOdcyWr49GIS+
 tX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Yf6ZTtN7PeYt6X8aFjGtHsBACJgt9SiJhwxT0+Mfzbw=;
 b=ccqsUKiv+RDU/hMReEl3BpgL8ctirh/4dWsOfjC4DB1yIgtjbBVCn2HoVwayMzi/D/
 fY72EEOBnmQ9ZioO8yY3Q7HTahJZr1/BqxLJHmaXZrr4bgrdqpHPBmy7jXSeLi0nVTET
 DpvStdwNyzjeElOzMPxD/mbJw2pwqDMlKHDAQvf8579Np5pRDVD1jJ9o5ikC+4ODyAiD
 MoSgY0xn954QN/AXIafJ9iWP3iKxem9qyLXL7anz4/2JuhcGm+5RvZaAESsSpJwkyG8g
 XTv5rZ9t4whzf5lSgX/ygQJ3kgxiiwt0Bbh1OrUiixDiCRgQMk/RYhuin9VIJvwLTlJb
 l/iw==
X-Gm-Message-State: AOAM530lvMAdYecld/CdBesvgGfD+KamBceMAApSEOlAnxCI4kdDZK4p
 bJ+6/DOHf/M1KXROdR7pNLs=
X-Google-Smtp-Source: ABdhPJxPmY8rrNBIgMOufu5t49wD5FKe56ShTc3mMOWTqCdj4DWoMBZU8fK92CgFTTjFWXKCyNp4Gg==
X-Received: by 2002:a63:1841:: with SMTP id 1mr26554315pgy.377.1625672812665; 
 Wed, 07 Jul 2021 08:46:52 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:38:6b47:cf3e:bbf2:d229])
 by smtp.gmail.com with ESMTPSA id q18sm23093560pgj.8.2021.07.07.08.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jul 2021 08:46:52 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com,
 sstabellini@kernel.org, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com,
 kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
 rppt@kernel.org, Tianyu.Lan@microsoft.com, thomas.lendacky@amd.com,
 ardb@kernel.org, robh@kernel.org, nramas@linux.microsoft.com,
 pgonda@google.com, martin.b.radev@gmail.com, david@redhat.com,
 krish.sadhukhan@oracle.com, saravanand@fb.com,
 xen-devel@lists.xenproject.org, keescook@chromium.org, rientjes@google.com,
 hannes@cmpxchg.org, michael.h.kelley@microsoft.com
Subject: [Resend RFC PATCH V4 05/13] HV: Add Write/Read MSR registers via ghcb
 page
Date: Wed,  7 Jul 2021 11:46:19 -0400
Message-Id: <20210707154629.3977369-6-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210707154629.3977369-1-ltykernel@gmail.com>
References: <20210707154629.3977369-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
 brijesh.singh@amd.com, linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 anparri@microsoft.com, vkuznets@redhat.com
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
Controller MSR registers in Isolation VM with AMD SEV SNP
and these registers are emulated by hypervisor directly.
Hyper-V requires to write SINTx MSR registers twice. First
writes MSR via GHCB page to communicate with hypervisor
and then writes wrmsr instruction to talk with paravisor
which runs in VMPL0. Guest OS ID MSR also needs to be set
via GHCB.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/hv_init.c       |  25 +------
 arch/x86/hyperv/ivm.c           | 115 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h |  78 +++++++++++++++++++-
 arch/x86/include/asm/sev-es.h   |   4 ++
 arch/x86/kernel/cpu/mshyperv.c  |   3 +
 arch/x86/kernel/sev-es-shared.c |  21 ++++--
 drivers/hv/hv.c                 | 121 ++++++++++++++++++++++----------
 include/asm-generic/mshyperv.h  |  12 +++-
 8 files changed, 308 insertions(+), 71 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index e058f72eeee5..97d1c774cfce 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -445,7 +445,7 @@ void __init hyperv_init(void)
 		goto clean_guest_os_id;
 
 	if (hv_isolation_type_snp()) {
-		ms_hyperv.ghcb_base = alloc_percpu(void *);
+		ms_hyperv.ghcb_base = alloc_percpu(union hv_ghcb __percpu *);
 		if (!ms_hyperv.ghcb_base)
 			goto clean_guest_os_id;
 
@@ -539,6 +539,7 @@ void hyperv_cleanup(void)
 
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
+	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
 
 	/*
 	 * Reset hypercall page reference before reset the page,
@@ -620,28 +621,6 @@ bool hv_is_hibernation_supported(void)
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
index 24a58795abd8..c7b54631ca0d 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -6,6 +6,8 @@
  *  Tianyu Lan <Tianyu.Lan@microsoft.com>
  */
 
+#include <linux/types.h>
+#include <linux/bitfield.h>
 #include <linux/hyperv.h>
 #include <linux/types.h>
 #include <linux/bitfield.h>
@@ -13,6 +15,119 @@
 #include <asm/io.h>
 #include <asm/mshyperv.h>
 
+void hv_ghcb_msr_write(u64 msr, u64 value)
+{
+	union hv_ghcb *hv_ghcb;
+	void **ghcb_base;
+	unsigned long flags;
+
+	if (!ms_hyperv.ghcb_base)
+		return;
+
+	WARN_ON(in_nmi());
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
+	ghcb_set_rcx(&hv_ghcb->ghcb, msr);
+	ghcb_set_rax(&hv_ghcb->ghcb, lower_32_bits(value));
+	ghcb_set_rdx(&hv_ghcb->ghcb, value >> 32);
+
+	if (sev_es_ghcb_hv_call(&hv_ghcb->ghcb, NULL, SVM_EXIT_MSR, 1, 0))
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
+	WARN_ON(in_nmi());
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
+	ghcb_set_rcx(&hv_ghcb->ghcb, msr);
+	if (sev_es_ghcb_hv_call(&hv_ghcb->ghcb, NULL, SVM_EXIT_MSR, 0, 0))
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
+/*
+ * hv_is_isolation_supported - Check system runs in the Hyper-V
+ * isolation VM.
+ */
+bool hv_is_isolation_supported(void)
+{
+	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
+}
+EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
+
+DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
+
+/*
+ * hv_isolation_type_snp - Check system runs in the AMD SEV-SNP based
+ * isolation VM.
+ */
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
index 2172493dc881..f9cc3753040a 100644
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
@@ -196,6 +253,25 @@ int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
 int hv_mark_gpa_visibility(u16 count, const u64 pfn[], u32 visibility);
 int hv_set_mem_enc(unsigned long addr, int numpages, bool enc);
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
@@ -212,9 +288,9 @@ static inline int hyperv_flush_guest_mapping_range(u64 as,
 {
 	return -1;
 }
+static inline void hv_signal_eom_ghcb(void) { };
 #endif /* CONFIG_HYPERV */
 
-
 #include <asm-generic/mshyperv.h>
 
 #endif
diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
index cf1d957c7091..482a4bb92c48 100644
--- a/arch/x86/include/asm/sev-es.h
+++ b/arch/x86/include/asm/sev-es.h
@@ -103,6 +103,10 @@ static __always_inline void sev_es_nmi_complete(void)
 		__sev_es_nmi_complete();
 }
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
+enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
+				   struct es_em_ctxt *ctxt,
+				   u64 exit_code, u64 exit_info_1,
+				   u64 exit_info_2);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 8aed689db621..d9ac13230950 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -339,6 +339,9 @@ static void __init ms_hyperv_init_platform(void)
 
 		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
+
+		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP)
+			static_branch_enable(&isolation_type_snp);
 	}
 
 	if (ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED) {
diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index 0aa9f13efd57..b7da08c97d2c 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -93,10 +93,10 @@ static void vc_finish_insn(struct es_em_ctxt *ctxt)
 	ctxt->regs->ip += ctxt->insn.length;
 }
 
-static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
-					  struct es_em_ctxt *ctxt,
-					  u64 exit_code, u64 exit_info_1,
-					  u64 exit_info_2)
+enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
+				   struct es_em_ctxt *ctxt,
+				   u64 exit_code, u64 exit_info_1,
+				   u64 exit_info_2)
 {
 	enum es_result ret;
 
@@ -108,7 +108,16 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
 	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
 
-	sev_es_wr_ghcb_msr(__pa(ghcb));
+	/*
+	 * Hyper-V runs paravisor with SEV. Ghcb page is allocated by
+	 * paravisor and not needs to be updated in the Linux guest.
+	 * Otherwise, the ghcb page's PA reported by paravisor is above
+	 * VTOM. Hyper-V use this function with NULL for ctxt point and
+	 * skip setting ghcb page in such case.
+	 */
+	if (ctxt)
+		sev_es_wr_ghcb_msr(__pa(ghcb));
+
 	VMGEXIT();
 
 	if ((ghcb->save.sw_exit_info_1 & 0xffffffff) == 1) {
@@ -119,7 +128,7 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 		v = info & SVM_EVTINJ_VEC_MASK;
 
 		/* Check if exception information from hypervisor is sane. */
-		if ((info & SVM_EVTINJ_VALID) &&
+		if (ctxt && (info & SVM_EVTINJ_VALID) &&
 		    ((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
 		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
 			ctxt->fi.vector = v;
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index e83507f49676..59f7173c4d9f 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -8,6 +8,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
@@ -136,17 +137,24 @@ int hv_synic_alloc(void)
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
@@ -173,10 +181,17 @@ void hv_synic_free(void)
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
@@ -199,26 +214,43 @@ void hv_synic_enable_regs(unsigned int cpu)
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
+			= memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
+				   HV_HYP_PAGE_SIZE, MEMREMAP_WB);
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
+			memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
+				 HV_HYP_PAGE_SIZE, MEMREMAP_WB);
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
@@ -233,14 +265,12 @@ void hv_synic_enable_regs(unsigned int cpu)
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
@@ -257,37 +287,50 @@ int hv_synic_init(unsigned int cpu)
  */
 void hv_synic_disable_regs(unsigned int cpu)
 {
+	struct hv_per_cpu_context *hv_cpu
+		= per_cpu_ptr(hv_context.cpu_context, cpu);
 	union hv_synic_sint shared_sint;
 	union hv_synic_simp simp;
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
+	if (hv_isolation_type_snp())
+		memunmap(hv_cpu->synic_message_page);
+	else
+		simp.base_simp_gpa = 0;
 
-	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
+	hv_set_simp(simp.as_uint64);
 
-	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
+	hv_get_siefp(siefp.as_uint64);
 	siefp.siefp_enabled = 0;
-	siefp.base_siefp_gpa = 0;
 
-	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
+	if (hv_isolation_type_snp())
+		memunmap(hv_cpu->synic_event_page);
+	else
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
index 2914e27b0429..e6d6886faed1 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -22,9 +22,16 @@
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/cpumask.h>
+#include <asm/svm.h>
+#include <asm/sev-es.h>
 #include <asm/ptrace.h>
+#include <asm/mshyperv.h>
 #include <asm/hyperv-tlfs.h>
 
+union hv_ghcb {
+	struct ghcb ghcb;
+} __packed __aligned(PAGE_SIZE);
+
 struct ms_hyperv_info {
 	u32 features;
 	u32 priv_high;
@@ -44,13 +51,14 @@ struct ms_hyperv_info {
 			u32 Reserved12 : 20;
 		};
 	};
-	void  __percpu **ghcb_base;
+	union hv_ghcb __percpu **ghcb_base;
 	u64 shared_gpa_boundary;
 };
 extern struct ms_hyperv_info ms_hyperv;
 
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
+extern bool hv_isolation_type_snp(void);
 
 /* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
 static inline int hv_result(u64 status)
@@ -145,7 +153,7 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
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
