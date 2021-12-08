Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B29C433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6DD49409ED;
	Wed,  8 Dec 2021 01:55:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N3zAz1LD1S-w; Wed,  8 Dec 2021 01:55:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3AE50409F0;
	Wed,  8 Dec 2021 01:55:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13AD7C001E;
	Wed,  8 Dec 2021 01:55:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43720C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26478824EE
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 73SF2reFVMh4 for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:55:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A536B82950
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:07 +0000 (UTC)
Received: by mail-pl1-x64a.google.com with SMTP id
 e9-20020a170902ed8900b00143a3f40299so259724plj.20
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=aSFkuCGEBTHTvZi9DSeJE23ynNu9ldCmJkWpDFHPYL4=;
 b=pj1BFS5JDZwdQsoV5ZfUR4IjugpB87psw0hdDXxPgq+MvLU0SnQUMVYqxy80OHAJMz
 h/HlENiyKKLI8u7Ab1qQ/zFZ0keBREMi7vKUUYCICeOYbPGxHfCaEbg6UHNMkziCJEDn
 ic8apfjbU4NgCtjM6YLR3j+K4NyNpQLhRlKKXjwqFT5ebNr5zvgY53H2I+VkERETd09z
 vjcLZXi9NO8+z9zFBak7kTFIzqI71zO2DdlXn/VAjhI6oztWbyjY0w6J/w0ongdSRJSQ
 A4SM8jHE5VE46ur/zAukww8n4VP2XB8Q0gthwSw3Lxsok8nXU/JcGwe97EQIklK6KtfX
 kiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=aSFkuCGEBTHTvZi9DSeJE23ynNu9ldCmJkWpDFHPYL4=;
 b=x0Iw3pKV3gsHszaWrRzHwSqxHNW7IKAyxqrhdMBbaPM6CmehA8aR/p5BKaGXz9ob7w
 Obn8R9guBJNGbXx91EtOE3aptPePhLE+iFPgdaw+P3zCbS2x40tyc5ZPg1vv5bv+Z+sl
 Kx78ZDerKV2EPKguIPlKRLY/9y6TvjqV1BTXUKYfurj0kGM42iM5o83hrjOPCgEEJeSe
 S16eTl2qMLW4Tk+KI9YoiomF1ZCCMbN4E5siKbCdfCFUmPjwW+LqgWjL5xJgkWTNr9e1
 wQ6xnAZkEIHNEv2LT+pRWd/mTpEto7KnEKzKdNSc2p8nuRRoE68PrlRaM+u9cpkIzY0N
 Sq5g==
X-Gm-Message-State: AOAM5321WU2nWqjIshpIcE73PE9q7JcOIcc1pcZaOqzy8/kma30R/bHz
 NLT0Ivkb2iAi09tXb6z59Ik9Desgdp0=
X-Google-Smtp-Source: ABdhPJx+JTTqJ9FCS754xSjU5PQfNUcp7bYmDjWBmkUjGbJNupRxR6OWycRJ4EvS9kgqXp+3ZNsipA1oW9M=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:2055:b0:142:497c:a249
 with SMTP id
 q21-20020a170903205500b00142497ca249mr55114947pla.35.1638928507106; Tue, 07
 Dec 2021 17:55:07 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:22 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-13-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 12/26] KVM: SVM: Remove unnecessary APICv/AVIC update in
 vCPU unblocking path
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

Remove handling of KVM_REQ_APICV_UPDATE from svm_vcpu_unblocking(), it's
no longer needed as it was made obsolete by commit df7e4827c549 ("KVM:
SVM: call avic_vcpu_load/avic_vcpu_put when enabling/disabling AVIC").
Prior to that commit, the manual check was necessary to ensure the AVIC
stuff was updated by avic_set_running() when a request to enable APICv
became pending while the vCPU was blocking, as the request handling
itself would not do the update.  But, as evidenced by the commit, that
logic was flawed and subject to various races.

Now that svm_refresh_apicv_exec_ctrl() does avic_vcpu_load/put() in
response to an APICv status change, drop the manual check in the
unblocking path.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 37575b71cdf3..16e4ebd980a2 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -1039,7 +1039,5 @@ void svm_vcpu_blocking(struct kvm_vcpu *vcpu)
 
 void svm_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
-	if (kvm_check_request(KVM_REQ_APICV_UPDATE, vcpu))
-		kvm_vcpu_update_apicv(vcpu);
 	avic_set_running(vcpu, true);
 }
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
