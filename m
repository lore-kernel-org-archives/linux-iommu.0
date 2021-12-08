Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA327C433F5
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A9EA83F0A;
	Wed,  8 Dec 2021 01:55:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7w5VuPH4BOfq; Wed,  8 Dec 2021 01:55:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C71C88281A;
	Wed,  8 Dec 2021 01:55:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD503C001E;
	Wed,  8 Dec 2021 01:55:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B63DAC0039
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8EBD960F02
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mthc3-yf77zr for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:54:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB4D260F00
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:57 +0000 (UTC)
Received: by mail-pf1-x44a.google.com with SMTP id
 e12-20020aa7980c000000b0049fa3fc29d0so689210pfl.10
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=mZkxzlEm8MBRNYBkK9eDkrOtQSNqYYOUUFB/yqMbNLc=;
 b=fvbstA2FV3AgxMq48AckzsKGodTQ5DKYyjXR0dqZMB/K2Z9wmslFmOiF8qOkvrJ8NU
 P737TQ6cN8hKJ2dAM58OE1xR/tSkpDAKFINHW8/75zo50f5N4V1x3rTCcQcQPctn+g64
 TOPf+WntX/TZ0JmmQcEogZ1xPpX7hhqo7mSjOk3yGEnSEC0o/zTDxqSrG3nIzYh7zw75
 FND9GSGO7Y6AzoJKlFdMp+i0//rjMA8hq97cQb5jp/aooc2ZOsdHslw8t/LtyP0xm6k7
 NOxQ6/pwFI0eFGe4FqyVj9f9UpJF0tUi2frxesv304I+lK07Qnk7sw4h8e2PaxDvACWZ
 WkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=mZkxzlEm8MBRNYBkK9eDkrOtQSNqYYOUUFB/yqMbNLc=;
 b=W2VmX2RY+1xk3+yUS1R/fTBG7gn+OeZWgIviDOZ5pJSSK/Ure0PHEpisxjDkzvwcnE
 ybPh5jpGzI2Z6hgHDTddfkAZ8RuwcP2cpB4b2B5S2ZRKcVf7XVyqPVA0jVHZNteFGqLQ
 mvJCEjX+Iv9LLADoq5ceqw5sVykwgDs1G5jWaN4O2tUsGb1KRhocq2lqkyVSfpwZKduD
 CFC3+V1SSKnSzGv0XI8sL45QUX63S4W5//t8pa2drgofp/j0RM/O8Q9xdpCMdGY0/gfS
 4/Txpz/rTyWT1v8p4xSsrV1xsFbg2xo9hpaHwi2lmqflIuG4iBrI5HibKnHaES7ZY5Pu
 7C9g==
X-Gm-Message-State: AOAM533MM0+zgQVWLYQyl7h2VvsyOIBJq6x/a5a4O9FNPQjJv64W4c0J
 q8EPykFq+9DKWmrktc82DXZ0XIKlWF4=
X-Google-Smtp-Source: ABdhPJwJP+xrzFBsVd/E76KaLqfJdLfkHdFbidzfSlXdv1bSh5ufbzKqJU9fhU7VtX7RUbHvfdKTcV+ROhQ=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:211b:: with SMTP id
 h27mr27065654pgh.203.1638928497275; 
 Tue, 07 Dec 2021 17:54:57 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:16 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-7-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 06/26] KVM: Move x86 VMX's posted interrupt list_head to
 vcpu_vmx
To: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 Maxim Levitsky <mlevitsk@redhat.com>, iommu@lists.linux-foundation.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>
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
From: Sean Christopherson via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Move the seemingly generic block_vcpu_list from kvm_vcpu to vcpu_vmx, and
rename the list and all associated variables to clarify that it tracks
the set of vCPU that need to be poked on a posted interrupt to the wakeup
vector.  The list is not used to track _all_ vCPUs that are blocking, and
the term "blocked" can be misleading as it may refer to a blocking
condition in the host or the guest, where as the PI wakeup case is
specifically for the vCPUs that are actively blocking from within the
guest.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 39 +++++++++++++++++-----------------
 arch/x86/kvm/vmx/vmx.c         |  2 ++
 arch/x86/kvm/vmx/vmx.h         |  3 +++
 include/linux/kvm_host.h       |  2 --
 virt/kvm/kvm_main.c            |  2 --
 5 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index a1776d186225..023a6b9b0fa4 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -19,7 +19,7 @@
  * wake the target vCPUs.  vCPUs are removed from the list and the notification
  * vector is reset when the vCPU is scheduled in.
  */
-static DEFINE_PER_CPU(struct list_head, blocked_vcpu_on_cpu);
+static DEFINE_PER_CPU(struct list_head, wakeup_vcpus_on_cpu);
 /*
  * Protect the per-CPU list with a per-CPU spinlock to handle task migration.
  * When a blocking vCPU is awakened _and_ migrated to a different pCPU, the
@@ -27,7 +27,7 @@ static DEFINE_PER_CPU(struct list_head, blocked_vcpu_on_cpu);
  * CPU.  IRQs must be disabled when taking this lock, otherwise deadlock will
  * occur if a wakeup IRQ arrives and attempts to acquire the lock.
  */
-static DEFINE_PER_CPU(spinlock_t, blocked_vcpu_on_cpu_lock);
+static DEFINE_PER_CPU(spinlock_t, wakeup_vcpus_on_cpu_lock);
 
 static inline struct pi_desc *vcpu_to_pi_desc(struct kvm_vcpu *vcpu)
 {
@@ -51,6 +51,7 @@ static int pi_try_set_control(struct pi_desc *pi_desc, u64 old, u64 new)
 void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct pi_desc old, new;
 	unsigned long flags;
 	unsigned int dest;
@@ -86,9 +87,9 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 	 * current pCPU if the task was migrated.
 	 */
 	if (pi_desc->nv == POSTED_INTR_WAKEUP_VECTOR) {
-		spin_lock(&per_cpu(blocked_vcpu_on_cpu_lock, vcpu->cpu));
-		list_del(&vcpu->blocked_vcpu_list);
-		spin_unlock(&per_cpu(blocked_vcpu_on_cpu_lock, vcpu->cpu));
+		spin_lock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
+		list_del(&vmx->pi_wakeup_list);
+		spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
 	}
 
 	dest = cpu_physical_id(cpu);
@@ -142,15 +143,16 @@ static bool vmx_can_use_vtd_pi(struct kvm *kvm)
 static void pi_enable_wakeup_handler(struct kvm_vcpu *vcpu)
 {
 	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct pi_desc old, new;
 	unsigned long flags;
 
 	local_irq_save(flags);
 
-	spin_lock(&per_cpu(blocked_vcpu_on_cpu_lock, vcpu->cpu));
-	list_add_tail(&vcpu->blocked_vcpu_list,
-		      &per_cpu(blocked_vcpu_on_cpu, vcpu->cpu));
-	spin_unlock(&per_cpu(blocked_vcpu_on_cpu_lock, vcpu->cpu));
+	spin_lock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
+	list_add_tail(&vmx->pi_wakeup_list,
+		      &per_cpu(wakeup_vcpus_on_cpu, vcpu->cpu));
+	spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
 
 	WARN(pi_desc->sn, "PI descriptor SN field set before blocking");
 
@@ -199,24 +201,23 @@ void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu)
  */
 void pi_wakeup_handler(void)
 {
-	struct kvm_vcpu *vcpu;
 	int cpu = smp_processor_id();
+	struct vcpu_vmx *vmx;
 
-	spin_lock(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
-	list_for_each_entry(vcpu, &per_cpu(blocked_vcpu_on_cpu, cpu),
-			blocked_vcpu_list) {
-		struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+	spin_lock(&per_cpu(wakeup_vcpus_on_cpu_lock, cpu));
+	list_for_each_entry(vmx, &per_cpu(wakeup_vcpus_on_cpu, cpu),
+			    pi_wakeup_list) {
 
-		if (pi_test_on(pi_desc))
-			kvm_vcpu_kick(vcpu);
+		if (pi_test_on(&vmx->pi_desc))
+			kvm_vcpu_kick(&vmx->vcpu);
 	}
-	spin_unlock(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
+	spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, cpu));
 }
 
 void __init pi_init_cpu(int cpu)
 {
-	INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
-	spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
+	INIT_LIST_HEAD(&per_cpu(wakeup_vcpus_on_cpu, cpu));
+	spin_lock_init(&per_cpu(wakeup_vcpus_on_cpu_lock, cpu));
 }
 
 bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0254d7f64698..64932cc3e4e8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6837,6 +6837,8 @@ static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
 	BUILD_BUG_ON(offsetof(struct vcpu_vmx, vcpu) != 0);
 	vmx = to_vmx(vcpu);
 
+	INIT_LIST_HEAD(&vmx->pi_wakeup_list);
+
 	err = -ENOMEM;
 
 	vmx->vpid = allocate_vpid();
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index f978699480e3..fc52721018ce 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -308,6 +308,9 @@ struct vcpu_vmx {
 	/* Posted interrupt descriptor */
 	struct pi_desc pi_desc;
 
+	/* Used if this vCPU is waiting for PI notification wakeup. */
+	struct list_head pi_wakeup_list;
+
 	/* Support for a guest hypervisor (nested VMX) */
 	struct nested_vmx nested;
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 30cc1327065c..2d17381b5210 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -305,8 +305,6 @@ struct kvm_vcpu {
 	u64 requests;
 	unsigned long guest_debug;
 
-	struct list_head blocked_vcpu_list;
-
 	struct mutex mutex;
 	struct kvm_run *run;
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d3e86f246e1c..84b4af38a2ec 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -427,8 +427,6 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 #endif
 	kvm_async_pf_vcpu_init(vcpu);
 
-	INIT_LIST_HEAD(&vcpu->blocked_vcpu_list);
-
 	kvm_vcpu_set_in_spin_loop(vcpu, false);
 	kvm_vcpu_set_dy_eligible(vcpu, false);
 	vcpu->preempted = false;
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
