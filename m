Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AE0C433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 759A741DA8;
	Wed,  8 Dec 2021 01:55:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F0u7_PPD3cME; Wed,  8 Dec 2021 01:55:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7BDED41DA5;
	Wed,  8 Dec 2021 01:55:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 140A3C0070;
	Wed,  8 Dec 2021 01:55:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EDD4C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0164441DA5
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tqt3r5JcYytA for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:55:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73DF841D9E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:29 +0000 (UTC)
Received: by mail-pg1-x549.google.com with SMTP id
 66-20020a630545000000b0032e4e898d24so438148pgf.10
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=etoB+YRcMf7Ew/pZhl7cqvSO7EaRAoODrPxvLsV0z+Y=;
 b=abdsZBN8AulwfhpgxPD+fgtZW/OszFybglG7I8YRmtY7jsOfHDVEx09Lnku4UA955k
 ygBEaurFeMMSLJx27MmrK/PzcasdeMNUItLZLxFC6PoPTOdqjNFWj5pviZrAKowSRgJa
 BZRu/Z3d4oB33ANMuQCaoRn07LBKczKYvcneWRW7/QyAxRlbFMF1i0HHAd8rn33iOQVD
 KPpXUBvskSE3vCwkI2VuZW2t6vCz57WbRCoOQbnHiReBty2TU1rSPxDXZ9f2mG5EfT5e
 kH25/9G+rtGAnb0qyHV2Q8ZvYoUy0TZoPaMLVk4tjhpAPay2215OyvJxjU4Ob2M+DqZ5
 8N5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=etoB+YRcMf7Ew/pZhl7cqvSO7EaRAoODrPxvLsV0z+Y=;
 b=TVY4uYSU1sqep/jtJVIIM4Pn1wbOXCB/4cmaMG+y5LfJoh67ry4sSnVhZoy3eLI1Rw
 6RPrFipIsyrDLeUL3VlFh8p2w0l4mHlW9DW9rteV2IPGmCzfpicFXbQR/vjoP+Z4unwN
 BbyRj3BeAHJmiHswVfJmeNm3oFtpkM4uOB/dr9XFM3nEKE58txFhIdI9G00eA/dnjq8B
 4j1Z18y7RqjN8kpunP4bnefxP31XGrWGUIQx2z/UNBGEf3k1qNSD34Uzqlm988Hu9UwU
 rCPZF/g0jKawVGR4eG8OOfhTsNmayg4HYdf8SdepK2T1I/MMWc4rFSU7umf6uRsP/7Eb
 kR+Q==
X-Gm-Message-State: AOAM533weHqbXB6At2bB/Fz1Rz30d3klDNrTFzzqxe4OnjOW5rek4yGZ
 h47uWiV0bqBB/Nv7FQ7VuzR10lqpKyk=
X-Google-Smtp-Source: ABdhPJxcULKyDqDzC4JHXW6P7xwo5S92TmpNNZDY8LH9XdQvp4jfLUO34zv8xNRKjk81H5IFvofKgTYBoNA=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:8f09:: with SMTP id
 n9mr10821495pgd.38.1638928528800; 
 Tue, 07 Dec 2021 17:55:28 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:35 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-26-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 25/26] KVM: x86: Drop NULL check on
 kvm_x86_ops.check_apicv_inhibit_reasons
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

Drop the useless NULL check on kvm_x86_ops.check_apicv_inhibit_reasons
when handling an APICv update, both VMX and SVM unconditionally implement
the helper and leave it non-NULL even if APICv is disabled at the module
level.  The latter is a moot point now that __kvm_request_apicv_update()
is called if and only if enable_apicv is true.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c804cc39c90d..fc52b97d6aa1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9564,8 +9564,7 @@ void __kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit)
 
 	lockdep_assert_held_write(&kvm->arch.apicv_update_lock);
 
-	if (!kvm_x86_ops.check_apicv_inhibit_reasons ||
-	    !static_call(kvm_x86_check_apicv_inhibit_reasons)(bit))
+	if (!static_call(kvm_x86_check_apicv_inhibit_reasons)(bit))
 		return;
 
 	old = new = kvm->arch.apicv_inhibit_reasons;
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
