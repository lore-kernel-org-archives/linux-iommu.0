Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049D7C43217
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ACFF2409F2;
	Wed,  8 Dec 2021 01:55:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X7BCwdXCiTMm; Wed,  8 Dec 2021 01:55:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 636A1409C5;
	Wed,  8 Dec 2021 01:55:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F3A1C001E;
	Wed,  8 Dec 2021 01:55:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F35CC0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7EEFF60F08
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b8dQGJsNgt_f for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:55:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F197B60F04
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:00 +0000 (UTC)
Received: by mail-pj1-x1049.google.com with SMTP id
 t7-20020a17090a5d8700b001a7604b85f5so677991pji.8
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=Y0QMANkJxI2glAsK9IA64IH6P6lAaThDPE5dh7pbbb0=;
 b=qxN7OH5XsEStC6fU9PcDLD5FmeauGir9Ufc9wpseLEk09vsdVA9CNv8R3lYl/+PAU1
 PjwhLJaLgkDzWb1C6kQ/++cGLl3queGaDz/B7l9Bny8v5wuft2Qj1mlocVXs2qlpkvPn
 Vn6E3GvsfvZd84P2V1/sqmMj2uPksI7lpm+aNjNzP6AywbLriR+HvhCWV8nphWzMgIoZ
 xn0e2ks6gEKgkb3DUU1vFkQPtW7vkRMyAzMBIuY/IPGWMSEpb9MOVnZfZ8IDrElyxpIc
 KBmKhwent59Pw2D94aIdPWGKsGq6NmlX7FAEstBomhCpfSknPX8Cmd0pW34ZqLQdsuwN
 +gMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=Y0QMANkJxI2glAsK9IA64IH6P6lAaThDPE5dh7pbbb0=;
 b=RyftjU98usXR+e9hYYUo1W0A7pVhvk0Pfkch6ZIcdHhS/Te6wzovh6uCfRDhMbQ29e
 JN/Wk3hFKhEMLedb49g1qckCGnLIznbLlZdivZLcUb4qppkDn+y8MwgIy0SUM7wwGl4i
 mBXP4kZsBkjw8Mu2triT7d0m/A4wo/XI25cVnmgk3jaLB9COh1148gK34kpo5KRrcgaR
 U9Aiw5bIq2zqWjq6q7/VRRtznoj5P/8WGb5UvWiZlJvYIOmC1K3N5LiUn/Gk8KUm2ouJ
 AS0mav8tZO97ETAPwPUiMdmmlyunA7+bknGsNef4LV3EC0iwFaMA4h7MttUH4RhhHqKB
 yHFQ==
X-Gm-Message-State: AOAM530lrtQfLO8A/8DsJBqEPrttOiOj+Kpqwi1hfKVAWEuRM3Y6EK/f
 BLB2nLgWpG1h9C8sAb/QYu3PzMDOp6Q=
X-Google-Smtp-Source: ABdhPJy6J8AgABZjKxA/fW5ow4o7SwNrge1ufnjwXJ/xhru5AumNEfY4EXs6Drt37icnUrTEV63NfM8nTSk=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:9882:b0:143:91ca:ca6e
 with SMTP id
 s2-20020a170902988200b0014391caca6emr56006763plp.64.1638928500452; Tue, 07
 Dec 2021 17:55:00 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:18 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-9-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 08/26] KVM: x86: Unexport LAPIC's switch_to_{hv,
 sw}_timer() helpers
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

Unexport switch_to_{hv,sw}_timer() now that common x86 handles the
transitions.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/lapic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 40270d7bc597..d4d875cbf05c 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1947,7 +1947,6 @@ void kvm_lapic_switch_to_hv_timer(struct kvm_vcpu *vcpu)
 {
 	restart_apic_timer(vcpu->arch.apic);
 }
-EXPORT_SYMBOL_GPL(kvm_lapic_switch_to_hv_timer);
 
 void kvm_lapic_switch_to_sw_timer(struct kvm_vcpu *vcpu)
 {
@@ -1959,7 +1958,6 @@ void kvm_lapic_switch_to_sw_timer(struct kvm_vcpu *vcpu)
 		start_sw_timer(apic);
 	preempt_enable();
 }
-EXPORT_SYMBOL_GPL(kvm_lapic_switch_to_sw_timer);
 
 void kvm_lapic_restart_hv_timer(struct kvm_vcpu *vcpu)
 {
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
