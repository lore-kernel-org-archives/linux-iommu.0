Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B32C4332F
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 74379409F6;
	Wed,  8 Dec 2021 01:55:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q02qVLjghe8J; Wed,  8 Dec 2021 01:55:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3DBCF409F3;
	Wed,  8 Dec 2021 01:55:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29D49C001E;
	Wed,  8 Dec 2021 01:55:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 416CDC001E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B811409F6
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ebZpNpZqq1ig for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:55:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8748F409ED
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:20 +0000 (UTC)
Received: by mail-pg1-x54a.google.com with SMTP id
 i12-20020a63584c000000b00330ec6e2c37so443962pgm.7
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=lL7Ah91e3ij9X4ILfB+Eg7xuVQkNKOT75fKaL9t5euc=;
 b=YSkEa/Mi2ETQaGznq3e7ke6p7MfXvU6iPcOcmhxmAvTs7sJ7NbWla5aE4B0uEs1nRy
 F0/iwWE6PUu0hOSvBJ/7aNJmQH6vdpWYxfaLudRsjwldpfZsZZ2B9x2Bu1R1EWYphKQs
 XkUtLYvcOQvHKpTedcFRv//lPbXRhXUQwpfhaJKYLDvtw+6kEXx+JCbdpCq0K9uFGpp+
 vZ8ZSRzWiswdm1gyWLiA27FEX/hNeBiWA9s3YTfL84CHkSdJ/aawxd0NN0KRjJ6nXMwR
 RMqf96pxDFadpqFZBuPFtqwAYJiJVdRSE1EYSJtvAkFFEZzDjqpG3SlPu0ZA4T4qoPiM
 pFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=lL7Ah91e3ij9X4ILfB+Eg7xuVQkNKOT75fKaL9t5euc=;
 b=BEyA+bVnQeS1GMF2fxAcL1jbSHNkHqgXrkuZFky1knIct1cpmtyQP70YS7VR8AsZ9q
 MsStXLSWaEWjdWWepg7EprUb6QLAIAPex/ZBVGrcg4IQtW3WYO50vqYjV04zN77y7wcN
 /mBo+1ONxSJIgbgnOoqUrwN7fppnqZPHbBcDnbvkK3Gp1S0ay2aAknQIAIVJSjINC7L1
 QWRgicBkSXJBWB0cyUSTyVJNrUqEAjRRH7+Kd+g1LSjT7o1BXCPP5ovsCnuckuPBXVc+
 EyT/24lX+G/Fl/5VGoiuX0jTe1A8zNyIu8msLM2ami7G4EawNIlXnBM4hxFIukkd4vRy
 pdYg==
X-Gm-Message-State: AOAM532Is4MtCUJzXGl0Ux8lDo15576Ctr6oYwMfTf17cyJWInpECmeK
 ZqNrUFnfDlN/nEhAr9rtwnEGfJSxOM0=
X-Google-Smtp-Source: ABdhPJwVoW65XdPki0wHByMFQDgUosdqBIe36fXCy42y0RYnEbdN8YqqHxyWCjIdH47J58cqyCGvdf6eS+I=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:db02:: with SMTP id
 g2mr3692938pjv.76.1638928519864; Tue, 07 Dec 2021 17:55:19 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:30 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-21-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 20/26] KVM: VMX: Don't do full kick when handling posted
 interrupt wakeup
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

When waking vCPUs in the posted interrupt wakeup handling, do exactly
that and no more.  There is no need to kick the vCPU as the wakeup
handler just needs to get the vCPU task running, and if it's in the guest
then it's definitely running.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 023a6b9b0fa4..f4169c009400 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -209,7 +209,7 @@ void pi_wakeup_handler(void)
 			    pi_wakeup_list) {
 
 		if (pi_test_on(&vmx->pi_desc))
-			kvm_vcpu_kick(&vmx->vcpu);
+			kvm_vcpu_wake_up(&vmx->vcpu);
 	}
 	spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, cpu));
 }
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
