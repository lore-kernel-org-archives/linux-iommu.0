Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545CCC433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:54:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0169982784;
	Wed,  8 Dec 2021 01:54:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k0sVYYGXdWMV; Wed,  8 Dec 2021 01:54:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DFF25824EE;
	Wed,  8 Dec 2021 01:54:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEBC0C001E;
	Wed,  8 Dec 2021 01:54:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5660AC0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 396AA41D74
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MoCnPEVuVGNz for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:54:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD98F41D8A
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:49 +0000 (UTC)
Received: by mail-pf1-x44a.google.com with SMTP id
 a23-20020a62bd17000000b004a3f6892612so665367pff.22
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=t+Ei0itOPUqCS4bP4MpGZr4Y0AKiyZYQUO3shvC6OH4=;
 b=k2YwbuxAPGemjRBHL7uFYlBdoruRLQIFroSCqiVqW7M9ZBvnUQQ9jGvvoRM5wp50BU
 zIgGQ7HGQFBmuNg7A+QIp+NCeTdN/K7rIpyetOEYv0fFftMX25G2HHMkN4qtIQ0LfZMv
 nEZ0SJpr3uyAnIWFfnfoFOuoynn+5sugfYnXc8Zu5xGttDxjBfbR1pzNtBX3wmGo5Eh4
 tc+DrZgmJZQlP0JmnQUhMMdwg4C1ob1gWVBL3GTQuYBEqUYWxacTaSRVkDaRkCGPvyNC
 fBrkeiQfSYOSRFEFYUtRYvG8vJlWJMCUTEIGnMXeL5T96k3SQN4J7z95j0CLBBRC0fn1
 ygmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=t+Ei0itOPUqCS4bP4MpGZr4Y0AKiyZYQUO3shvC6OH4=;
 b=pNJ/e30w+8v7utV4lRkn8M+nJCJty/wKcsEeKPXfOQt70DOSxvVl1ANwot86pSlHha
 TrX9SL03eyT+XwUA6K9d2OHZuW9ZKc0eUDJq9bcWV8Rwp2ZroWK3IyL6VOPn2oeIsuyv
 wp0j80a3aiBCO0BNi9PXg9vhQee6h5BYKyUf6DEvY62WLqZZgSkXQgodumE67t5kXOMB
 IMUgEhhRGywIWBIJ6K0ZBdAM2hj889abLxeU8qOU8bzfrHpNEk6Y7caQt7tes45Mj7Dj
 yeKKwI06P6BYqCP911aQqHWYruBNpRbWTPtgKwuVojnjImoMkdeQJqKPqqlNXRcwomqs
 jjBA==
X-Gm-Message-State: AOAM531YQ0kEHuXfebT6NrSvj1p2orzi72+THc4zQkVJnngJTkrHzDqN
 RJeabp0NsbOcANQSFWEuUCQXRX+aK8M=
X-Google-Smtp-Source: ABdhPJydNGMZpFjjQ57G1ZC66ywbHz44PKREG9EyVwHjLHfG2SNsZYM0b6sqBp1lD+CDQVcAS7e/s6aPdYs=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1486:: with SMTP id
 js6mr342701pjb.0.1638928488764; Tue, 07 Dec 2021 17:54:48 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:11 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-2-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 01/26] KVM: fix avic_set_running for preemptable kernels
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

From: Paolo Bonzini <pbonzini@redhat.com>

avic_set_running() passes the current CPU to avic_vcpu_load(), albeit
via vcpu->cpu rather than smp_processor_id().  If the thread is migrated
while avic_set_running runs, the call to avic_vcpu_load() can use a stale
value for the processor id.  Avoid this by blocking preemption over the
entire execution of avic_set_running().

Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Not-signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 1d8ada5b01f8..d7132a4551a2 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -997,16 +997,18 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 static void avic_set_running(struct kvm_vcpu *vcpu, bool is_run)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	int cpu = get_cpu();
 
+	WARN_ON(cpu != vcpu->cpu);
 	svm->avic_is_running = is_run;
 
-	if (!kvm_vcpu_apicv_active(vcpu))
-		return;
-
-	if (is_run)
-		avic_vcpu_load(vcpu, vcpu->cpu);
-	else
-		avic_vcpu_put(vcpu);
+	if (kvm_vcpu_apicv_active(vcpu)) {
+		if (is_run)
+			avic_vcpu_load(vcpu, cpu);
+		else
+			avic_vcpu_put(vcpu);
+	}
+	put_cpu();
 }
 
 void svm_vcpu_blocking(struct kvm_vcpu *vcpu)
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
