Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFF3C43219
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6310041D9E;
	Wed,  8 Dec 2021 01:55:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JXP8ruUXNNGf; Wed,  8 Dec 2021 01:55:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5F35C41DA6;
	Wed,  8 Dec 2021 01:55:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A94BC001E;
	Wed,  8 Dec 2021 01:55:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 104D7C006E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8317341D9E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1qZ9iUqHjJ4R for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:55:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 155DF41D7B
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:30 +0000 (UTC)
Received: by mail-pj1-x1049.google.com with SMTP id
 pg9-20020a17090b1e0900b001a689204b52so2783560pjb.0
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=VCkxR8iIoNYN3L1RJkz/btGuEUMw40noTB+y7+zqLJ0=;
 b=LHBsLMi3udo6BrUeQlkY0pT4Oc4Ew+wh9tNDgI5U1zVhU/K0iQ3l6PitAe/In7no9G
 OXT3y7uz44mqs4JDXqIHQ7BK0RaSWSDltzRyPHd0OyFaaR3vrpx63cneXeF3DTx93b9g
 F2/KpKN4IMYf61J/Il7a3FpMeSlYTvqPqK3MgdLFbpzQb7rQbMFPHsRQvt8Ph6dTV4nC
 MW/pjtPm8rI9cn9uQZFXTuJxhW36O6IqgaBHmFE+cCoTQkTPNd5oVzxa6qMc527PBa6Q
 kGs0fFfa+c8qKWopEJ+pQD8z9ov9+LAS3ZGWNB92YYF6/oohgLIDMWPUTgJwXVZpYg95
 K0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=VCkxR8iIoNYN3L1RJkz/btGuEUMw40noTB+y7+zqLJ0=;
 b=JZ56udXqKVzfvnVNKYWSpZel8mNA7eWiboRM3pDd53X8XnCza0DaqiiXtofMX6RPVp
 04gyRouD4ZqOvw0u5aFE4FziQqhXPMCwYLqrUihOSnIGumMoBV4KnM1uaQvBvmEkgQYY
 E1q4zNlqh6tYvAEiA3T+DObcRXN5pqkS9K0e0W8JxVCj4xKMe/6HC0ct4+WDaYUHo3Hq
 tK7JUvCRiyky81nqjqCEtOTJM5eXiIkRZ4fJ513JIPYZCiwWnsdh4AVboqwE5KnCSTt0
 I++jjSa92ijWm64XreMocmCJc3Ooj2fqGVNNROKW6zymi1mMh6Wg+CozEhTGBhXG8gRA
 0RXQ==
X-Gm-Message-State: AOAM531g0EyicBXjkvdUTv+qZ9XBo8IhsnVtZ2LWvMI8Lq864Jibfw5f
 UL+lqkVsYiDXqU54R5vcs/XyZi3Nh1Y=
X-Google-Smtp-Source: ABdhPJyQ9IDS5uYE2qNrBofLqK0XEq3FDd5eSHH0h+fuqLKFddQUMDjOnZnO89YNMResi94warafDO7Gz7o=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:124e:b0:143:a388:a5de
 with SMTP id
 u14-20020a170903124e00b00143a388a5demr55869342plh.73.1638928530566; Tue, 07
 Dec 2021 17:55:30 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:36 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-27-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 26/26] KVM: x86: Unexport __kvm_request_apicv_update()
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

Unexport __kvm_request_apicv_update(), it's not used by vendor code and
should never be used by vendor code.  The only reason it's exposed at all
is because Hyper-V's SynIC needs to track how many auto-EOIs are in use,
and it's convenient to use apicv_update_lock to guard that tracking.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fc52b97d6aa1..0774cf4ccd88 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9597,7 +9597,6 @@ void __kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit)
 	} else
 		kvm->arch.apicv_inhibit_reasons = new;
 }
-EXPORT_SYMBOL_GPL(__kvm_request_apicv_update);
 
 void kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit)
 {
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
