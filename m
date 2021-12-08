Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E302C433F5
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DDC341D99;
	Wed,  8 Dec 2021 01:55:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WetJPPosNaB6; Wed,  8 Dec 2021 01:55:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3F96141D8F;
	Wed,  8 Dec 2021 01:55:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15038C001E;
	Wed,  8 Dec 2021 01:55:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E568C001E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C74041D94
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a6Tm86X81Kbw for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:55:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9309241D8D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:15 +0000 (UTC)
Received: by mail-pl1-x649.google.com with SMTP id
 p24-20020a170902a41800b001438d6c7d71so283804plq.7
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=/zLOcA0/RCKP4IPePRP8srGBuJZlvIhnpk9KTslNG9g=;
 b=LxBE8r1fQIl3UYOlBm78E+SztDv7JU+iem9UMbs8YQEF6Ys7uOajRABh6dnsSJk9+F
 2E0dVIsCyPKv+U3D5VQvykjt0oagpsrOTuBEgNI7m2rdiZJHlV23waCf2tbnw264cD94
 VP6I18bDsVuk2s3boDNzZbo2s2BMpEq/m653dG27/JmTx9o/334flpmobw6Q5NA7jBWT
 sXCrIKzgbU4DOhdaDxIE9qh7KvtmwvCzjJB5FBkogquF99wcJ7cNJWjngzUAyfpaFD6F
 ZQP9VQt8iLqvOjouYpr+RD392YAmFADp0xI9PY+unelTWbbN/ppduOgmhuJa9LBMEZ6d
 JtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=/zLOcA0/RCKP4IPePRP8srGBuJZlvIhnpk9KTslNG9g=;
 b=TS4aDs08yTMe/CoH4szwcFJh2c7OClxJrOi6usjJ30It8Z50m9xkO5Jy02WVSReFeo
 mk/gk78LinMEsWPUkn/ebnYEo8ftYchITLSS7AfDUHY+i6MLt9NgO9z5dymVrBZE+gBm
 0j5PWiZCdB0OFwbOXZ5aEkjdHdJG+qm+kyeeImcedprl2LXMy6pJjIwMjIsBzOGmQNGM
 mOwR6awbETK1cKCIPR5iU2mr7v596NAoxPvthYkx8eboz6evPD8NF+iiY5QHCZMSMEMX
 NWt4lBv6nstLoUqnkdnfFa5unCngep+UwX+dH95rOoE1f9jdBnVfOUSXsDEo5Un0R+GX
 WO1w==
X-Gm-Message-State: AOAM531yc2ESa5vr0N9/4HJjOVMjefVKOH27jHus4oKRWWk692uoQJCS
 oZbwmudjBg/GeX6I3H6fPWD1NSOKooo=
X-Google-Smtp-Source: ABdhPJwHPvMbcB39XRKoVA31QI0H5nrb6VJMxVvuk887RN62Ib5bGbXOcpKiBAI+lN/UYQJEfwVMs6WUIDI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:284f:: with SMTP id
 p15mr347865pjf.1.1638928514581; Tue, 07 Dec 2021 17:55:14 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:27 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-18-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 17/26] KVM: VMX: Wake vCPU when delivering posted IRQ even
 if vCPU == this vCPU
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

Drop a check that guards triggering a posted interrupt on the currently
running vCPU, and more importantly guards waking the target vCPU if
triggering a posted interrupt fails because the vCPU isn't IN_GUEST_MODE.
The "do nothing" logic when "vcpu == running_vcpu" works only because KVM
doesn't have a path to ->deliver_posted_interrupt() from asynchronous
context, e.g. if apic_timer_expired() were changed to always go down the
posted interrupt path for APICv, or if the IN_GUEST_MODE check in
kvm_use_posted_timer_interrupt() were dropped, and the hrtimer fired in
kvm_vcpu_block() after the final kvm_vcpu_check_block() check, the vCPU
would be scheduled() out without being awakened, i.e. would "miss" the
timer interrupt.

One could argue that invoking kvm_apic_local_deliver() from (soft) IRQ
context for the current running vCPU should be illegal, but nothing in
KVM actually enforces that rules.  There's also no strong obvious benefit
to making such behavior illegal, e.g. checking IN_GUEST_MODE and calling
kvm_vcpu_wake_up() is at worst marginally more costly than querying the
current running vCPU.

Lastly, this aligns the non-nested and nested usage of triggering posted
interrupts, and will allow for additional cleanups.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index fa90eacbf7e2..0eac98589472 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3993,8 +3993,7 @@ static int vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
 	 * guaranteed to see PID.ON=1 and sync the PIR to IRR if triggering a
 	 * posted interrupt "fails" because vcpu->mode != IN_GUEST_MODE.
 	 */
-	if (vcpu != kvm_get_running_vcpu() &&
-	    !kvm_vcpu_trigger_posted_interrupt(vcpu, false))
+	if (!kvm_vcpu_trigger_posted_interrupt(vcpu, false))
 		kvm_vcpu_wake_up(vcpu);
 
 	return 0;
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
