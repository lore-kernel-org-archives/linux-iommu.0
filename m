Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED85C433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E3C860F0B;
	Wed,  8 Dec 2021 01:55:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bnvUgcN8N5ro; Wed,  8 Dec 2021 01:55:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 076A360F04;
	Wed,  8 Dec 2021 01:55:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2B71C001E;
	Wed,  8 Dec 2021 01:55:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10110C001E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A78AE82660
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QJm5QAwMQTSq for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:55:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 15B08824EE
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:06 +0000 (UTC)
Received: by mail-pg1-x549.google.com with SMTP id
 n6-20020a632706000000b00330ca963fc3so450789pgn.3
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=sWS8lI0gUmOyHyHSjJQNlBlA+evEhEXiCmD7ctQTR2I=;
 b=IGqaujrdw3pJA8/VhNCiiJK2demMr9npnPg8OO94u4zJussXfBB3Cqu07hb5L7vmoo
 /c6MfWai3Vea5erWwSXjPyme/mdg306Z4WzeqPKrZhYYQBJGzaKAveodHtgEkT8tGWUZ
 PcpS5xXAqfMzOfKNtBI5GkB/zi4X5qcK3VVJcB7cjBoby9q8TRWgFnv/iAXQVa0SD/En
 CozCyLTvHHATnEtLUrsJYhslqGc5KRzmC/q9aBARyhCobQnFyxrw8rUgkz6UAiq3kgzx
 Taw5NHJldSf8XzoSB8uGZbZbfhVVGSr8PCF//rfTWwBTVMqeUGHKmFD1J+qhibeA4Ou/
 sLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=sWS8lI0gUmOyHyHSjJQNlBlA+evEhEXiCmD7ctQTR2I=;
 b=KcDnCg9HD/EtdKXrb34RNdQ19ksHOGzoyzIfWy4UdFX53ZRair9Ki3ZjJ4cDO3KWEf
 gXeAEG6p5ZM0ZO+RHO7qPk+v1vAEV2fl2JUvLNrMwIqiyIVYkCydtKEDpNthW/aYPPVl
 uWhS1E34UWiWA+KmoqdReLla4a3rw1vBVe/IQmVdoMv8GY7P16pnCsEJykpwNl34FdPh
 /Kip7e7+C5obZgwhnjeR0BLSwTXd/6UDDWrHnxaPdE8Yi0evNMGH63qGAqZEVe9zVF61
 PX9ukUaqoSKvjO36ojZgVocz9U9a9NLCnEW411LPY56TvLR7vx1hnwX6q93CoAoPvOtI
 YlfQ==
X-Gm-Message-State: AOAM531or/B7DaLVyot/yq6gdG72zPK4cLkBgMHgGDJMIZT9sJuibeak
 sGgwnGMwkVswoylqWuf18fzUkTc+ipw=
X-Google-Smtp-Source: ABdhPJzthhrK0JA6NDs214v10Pktv2tAPLKbFKJ7sATCDbyBlSHPGWuwB1tBteo7rjgt3jNfMh86Ubp8Krc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:a0b:: with SMTP id
 11mr27831511pgk.282.1638928505499; 
 Tue, 07 Dec 2021 17:55:05 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:21 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-12-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 11/26] KVM: SVM: Don't bother checking for "running" AVIC
 when kicking for IPIs
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

Drop the avic_vcpu_is_running() check when waking vCPUs in response to a
VM-Exit due to incomplete IPI delivery.  The check isn't wrong per se, but
it's not 100% accurate in the sense that it doesn't guarantee that the vCPU
was one of the vCPUs that didn't receive the IPI.

The check isn't required for correctness as blocking == !running in this
context.

From a performance perspective, waking a live task is not expensive as the
only moderately costly operation is a locked operation to temporarily
disable preemption.  And if that is indeed a performance issue,
kvm_vcpu_is_blocking() would be a better check than poking into the AVIC.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/svm/avic.c | 15 +++++++++------
 arch/x86/kvm/svm/svm.h  | 11 -----------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index e2e4e9f04458..37575b71cdf3 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -295,13 +295,16 @@ static void avic_kick_target_vcpus(struct kvm *kvm, struct kvm_lapic *source,
 	struct kvm_vcpu *vcpu;
 	unsigned long i;
 
+	/*
+	 * Wake any target vCPUs that are blocking, i.e. waiting for a wake
+	 * event.  There's no need to signal doorbells, as hardware has handled
+	 * vCPUs that were in guest at the time of the IPI, and vCPUs that have
+	 * since entered the guest will have processed pending IRQs at VMRUN.
+	 */
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-		bool m = kvm_apic_match_dest(vcpu, source,
-					     icrl & APIC_SHORT_MASK,
-					     GET_APIC_DEST_FIELD(icrh),
-					     icrl & APIC_DEST_MASK);
-
-		if (m && !avic_vcpu_is_running(vcpu))
+		if (kvm_apic_match_dest(vcpu, source, icrl & APIC_SHORT_MASK,
+					GET_APIC_DEST_FIELD(icrh),
+					icrl & APIC_DEST_MASK))
 			kvm_vcpu_wake_up(vcpu);
 	}
 }
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 9f153c59f2c8..ca51d6dfc8e6 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -574,17 +574,6 @@ extern struct kvm_x86_nested_ops svm_nested_ops;
 
 #define VMCB_AVIC_APIC_BAR_MASK		0xFFFFFFFFFF000ULL
 
-static inline bool avic_vcpu_is_running(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_svm *svm = to_svm(vcpu);
-	u64 *entry = svm->avic_physical_id_cache;
-
-	if (!entry)
-		return false;
-
-	return (READ_ONCE(*entry) & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
-}
-
 int avic_ga_log_notifier(u32 ga_tag);
 void avic_vm_destroy(struct kvm *kvm);
 int avic_vm_init(struct kvm *kvm);
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
