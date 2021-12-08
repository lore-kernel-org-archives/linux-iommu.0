Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9D6C4332F
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0D44824EE;
	Wed,  8 Dec 2021 01:55:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0XTNDTO2sdrX; Wed,  8 Dec 2021 01:55:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9D3E083F35;
	Wed,  8 Dec 2021 01:55:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 765C5C001E;
	Wed,  8 Dec 2021 01:55:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74262C0075
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5872560F12
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xG0CuPR-Gbhp for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:55:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85A7460F0C
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:10 +0000 (UTC)
Received: by mail-pj1-x1049.google.com with SMTP id
 bf17-20020a17090b0b1100b001a634dbd737so2710040pjb.9
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=Os9t3PK/1Q6X8L88GHE3qfHjmqX2bj+Lj4P7zobea20=;
 b=GxPab2eAQ1zR+MIC7R4aaig3jil5DsGkCS9yQ8q4Z79CpuJL+SET/SFcCSTqFKGfUK
 gGth0HAhK64hi3UbzwTDtSKi+AFgbtNUffEN1ZBuN/woQ+e3eq0NNOmE2fMddj5+Uvyn
 A+fMa6DuJe95mkeMtBC1Djxf47VoYGT5YM9xlACTrUurxDi85vj+PbL3wpS8I6/hgUNP
 720meHO9QbRwhUZavuQwNn52WMtS9s80CfHoA6jU1f4ho66MvnR/Mj0+HL5BL2QpcfrG
 BQdDB1WB7G/IyCqL+oej6dueC+ctxa3Zk2OpwuNceFfyhWzVb8GwDbKw+FK2tGjukM5P
 0CZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=Os9t3PK/1Q6X8L88GHE3qfHjmqX2bj+Lj4P7zobea20=;
 b=B/snE+8VgdKhyOaAK3Lgo8XCRYzCbBAeL+54fqNLMAxSFfDzak4UxTKly+a6Cp7mih
 ZWF72emZDRsgpu1j7HAH17pAw45SbM/KIQM+z3x1H1zuvPk6IWXrd6QiJypgYlBmSKu9
 3qE2QXZzmDZVTQNBfDRg0OMaQKnFXxYdMtz8nOFQFjg1LmBeTp4MHfiEzKnlEYhj8pNM
 7POuidku43BXWb+YLkrjzzZSB5MmChkllBnDeIW+8r6+8sa7Wg/q1AHgR71aJfLSHxPK
 eIFFaAMU41xAGRMf0Y19hMWXSAh1aXKTHza0c2RWf7bqXxtk7tQwe4AkJgm8/iI9bPpK
 4G2A==
X-Gm-Message-State: AOAM530AU4/HuU4hgvLgMpS0djs4o2wa1mUZCTnAn9UVZKb5XmzGtbAJ
 lHXHlWiSAp4kfr2gaQrxV+X3Pt6eJPU=
X-Google-Smtp-Source: ABdhPJxsMsSxtywu0s/1ig+ARF1hrT3HXASsf4sf2qoyLew9jB7OXnpi43IqnpO+NMpFJVnL2vJImWV0uqk=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4a4d:: with SMTP id
 lb13mr3543900pjb.97.1638928510003; Tue, 07 Dec 2021 17:55:10 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:24 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-15-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 14/26] KVM: SVM: Skip AVIC and IRTE updates when loading
 blocking vCPU
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

Don't bother updating the Physical APIC table or IRTE when loading a vCPU
that is blocking, i.e. won't be marked IsRun{ning}=1, as the pCPU is
queried if and only if IsRunning is '1'.  If the vCPU was migrated, the
new pCPU will be picked up when avic_vcpu_load() is called by
svm_vcpu_unblocking().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index dc0cbe500106..0c6dfd85b3bb 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -974,7 +974,6 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	u64 entry;
 	/* ID = 0xff (broadcast), ID > 0xff (reserved) */
-	bool is_blocking = kvm_vcpu_is_blocking(vcpu);
 	int h_physical_id = kvm_cpu_get_apicid(cpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -985,24 +984,25 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (WARN_ON(h_physical_id > AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK))
 		return;
 
+	/*
+	 * No need to update anything if the vCPU is blocking, i.e. if the vCPU
+	 * is being scheduled in after being preempted.  The CPU entries in the
+	 * Physical APIC table and IRTE are consumed iff IsRun{ning} is '1'.
+	 * If the vCPU was migrated, its new CPU value will be stuffed when the
+	 * vCPU unblocks.
+	 */
+	if (kvm_vcpu_is_blocking(vcpu))
+		return;
+
 	entry = READ_ONCE(*(svm->avic_physical_id_cache));
 	WARN_ON(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
 
 	entry &= ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
 	entry |= (h_physical_id & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK);
-
-	entry &= ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
-
-	/*
-	 * Don't mark the vCPU as running if its blocking, i.e. if the vCPU is
-	 * preempted after svm_vcpu_blocking() but before KVM voluntarily
-	 * schedules out the vCPU.
-	 */
-	if (!is_blocking)
-		entry |= AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
+	entry |= AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
 
 	WRITE_ONCE(*(svm->avic_physical_id_cache), entry);
-	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, !is_blocking);
+	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, true);
 }
 
 void avic_vcpu_put(struct kvm_vcpu *vcpu)
@@ -1011,8 +1011,12 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	entry = READ_ONCE(*(svm->avic_physical_id_cache));
-	if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK)
-		avic_update_iommu_vcpu_affinity(vcpu, -1, 0);
+
+	/* Nothing to do if IsRunning == '0' due to vCPU blocking. */
+	if (!(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK))
+		return;
+
+	avic_update_iommu_vcpu_affinity(vcpu, -1, 0);
 
 	entry &= ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
 	WRITE_ONCE(*(svm->avic_physical_id_cache), entry);
@@ -1043,5 +1047,6 @@ void svm_vcpu_blocking(struct kvm_vcpu *vcpu)
 
 void svm_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
+
 	avic_set_running(vcpu, true);
 }
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
