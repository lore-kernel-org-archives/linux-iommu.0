Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26595C433F5
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CC0C3409EC;
	Wed,  8 Dec 2021 01:54:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U7zBvJxOYtYB; Wed,  8 Dec 2021 01:54:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A20C0409EA;
	Wed,  8 Dec 2021 01:54:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E524C001E;
	Wed,  8 Dec 2021 01:54:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2180C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B9FDE6077C
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L8LRM1Ef5c05 for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:54:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3177760EBE
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:56 +0000 (UTC)
Received: by mail-pj1-x1049.google.com with SMTP id
 lj10-20020a17090b344a00b001a653d07ad8so2757260pjb.3
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=0rf52m0OFsJ6vdpTPwC+YH53TFkMwIcyep6ybPqU2JE=;
 b=ALX+F6xb+1ftz8ZFqlXHYKMF5o6uoCIfAV9YWKQ6dHwcp3tfhgBpTtXHqLEo/dtnlO
 M8Va2r/PG5RN6w5P/yocjEnBZU08zfh5dvhN+FbGIAWaN+qWccNVYOqlVKRk1pBLeQEo
 qZnXEBWMMHGZ7RpCMpn9tE+eXwU6tOu/Fehr/2Ua54V+tr5S5OdFVC96vcomF0dGVodt
 vhVF/58K3GVasiXXOQZLDcQ6Yca0uw7ChaThbBk0o6c5X3I2pIt2k/bS+DQs3hU6t3+e
 gg85TLtmU20/H4+8Z11G23Rl3zHTgTuUj4nfIfjvTI245cspZEU1PXyFCz5NwmvHezLi
 c80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=0rf52m0OFsJ6vdpTPwC+YH53TFkMwIcyep6ybPqU2JE=;
 b=cxIVL3s7lW/gGP2leAeIcBCFIT/ZCgn6oyf+lN6R/djdOVht71/IOBzqPV26B6DL1O
 MpNz+UTi5yc4fDbFuePPlxNxjeOdQHcKMW0l+bguoUW23a0YCO6t9AJDe1CUc6HFfEZD
 vv6yTPuHj0OegVy+Jdw3Xy18bBWCaj4QAHLQw/Tr5lsHxBkGeU4BuTV93MqHFc8h+KIE
 Tfpl6KBV0pyU5PzQbTvMztUCpFCaOEJ3WVnFopq+sBwyUlI2lzVj/NqYNIl33Hi2L30T
 hof2b1Oofe8qqceDgeicoUitSIsDWVN+dsHQJ2OSfgRaA4SJXfkUGDUxsS9tPQADDMlP
 1Mmg==
X-Gm-Message-State: AOAM530AhLvKK4NTseSWRuMqqCb00jtx1lq2ERew/HwtdCBA6Hccrz2F
 THyQqp8UU9rVzkptlq3isPD+XXcmjbY=
X-Google-Smtp-Source: ABdhPJxMvVDgDQDgT5n2opsiPcTnngzCmW7OhEj/nnOqNcYBinuBirWqSvdpU36Uf7z5Mv1VYTYwKMs+lew=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:e74e:b0:142:fa5:49f1
 with SMTP id
 p14-20020a170902e74e00b001420fa549f1mr55709592plf.84.1638928495591; Tue, 07
 Dec 2021 17:54:55 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:15 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-6-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 05/26] KVM: Drop unused kvm_vcpu.pre_pcpu field
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

Remove kvm_vcpu.pre_pcpu as it no longer has any users.  No functional
change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 include/linux/kvm_host.h | 1 -
 virt/kvm/kvm_main.c      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a745efe389ab..30cc1327065c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -305,7 +305,6 @@ struct kvm_vcpu {
 	u64 requests;
 	unsigned long guest_debug;
 
-	int pre_pcpu;
 	struct list_head blocked_vcpu_list;
 
 	struct mutex mutex;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 863112783ed9..d3e86f246e1c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -427,7 +427,6 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 #endif
 	kvm_async_pf_vcpu_init(vcpu);
 
-	vcpu->pre_pcpu = -1;
 	INIT_LIST_HEAD(&vcpu->blocked_vcpu_list);
 
 	kvm_vcpu_set_in_spin_loop(vcpu, false);
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
