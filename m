Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384DDC433F5
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0395D84B87;
	Wed,  8 Dec 2021 01:55:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ggyIFOfKaI5G; Wed,  8 Dec 2021 01:55:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F232482A5D;
	Wed,  8 Dec 2021 01:55:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D067CC001E;
	Wed,  8 Dec 2021 01:55:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40EFEC001E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DEB1409EE
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N_fB_RWqbDDE for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:55:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 57059409FB
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:28 +0000 (UTC)
Received: by mail-yb1-xb4a.google.com with SMTP id
 x5-20020a2584c5000000b005f89a35e57eso1806764ybm.19
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=nSA+7Wbn1md8c4hejoAgllm6FyYF3EIl7O6C+XokVrA=;
 b=FhPI6SiC4iO3RKc/hZUq1Y5sHMYSUtxK47TC+eEWDtGVJqun3MqjqRWeOpkOjtDObH
 vvaZZJoOLeIspoyCyToiThABZa89sJuC4+IhWuzo0Zc+dxdwcEN8gzlNLjNxGFu4DUdW
 3B4qe0ecCyjkpglFvsLtoQOkuybiafiKm++S3gkV5B80+9xH7FWRoA5/TLtYKreDlb2P
 9Q2YypVQNTGKpqi/RvynV+dUT1CJdCN3K3yqAXKfUldZ0G7XUa4YsGV8/Igm0UIulDDx
 nXc36tIAKiH0gX2mjSzxi+KKj8Pz3TnPVtVCQDzdpySRak+dBmwyuT49toXaV2ttZ1Cd
 suGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=nSA+7Wbn1md8c4hejoAgllm6FyYF3EIl7O6C+XokVrA=;
 b=YpIszFGogGeddC6X+HyZmJNV1qxO8HXRS1ic4S77jE36TgXtoERVUhmB4w+3RujqPr
 EvjzWYFRQ3bWMmb0vbSlxcJ3nrFRHcJhyVq+jxJrCi9NvTtDQuGIp2ajdQnYJDEzJT8S
 lTL4JgKkONysloPiNz1pkn8d7Ne+o5D8WJL30aT4lUMlVl10ceK2mhVLpyh2VjFnennF
 iYYQlmdfqPJ03W2uTCFr/gL+KJbE6iqK0hhgNddJulm7fd4Qztv0HhGQ1yTjjVTTvDLI
 iybvxZ7bIWPVtZLJgCODdSWLmrurdX5/iENcutcS7cKX1HuPxiII1r/kz48d0OGKTnOm
 feFw==
X-Gm-Message-State: AOAM532pigYQMtJKXOEh0VCV3yx/lQg3kLWvgh2memQcE+S7T15RFfe8
 toRofk4Xl4u9pLcbf+dfl6gLlLyWLbI=
X-Google-Smtp-Source: ABdhPJwlJGmLgQ9J6FIpPO/lILT+cfvhzCud+NGJkyme0uG+7Qffst4AD9tNwdk3H8zfZxC0+0MTTaWGPYQ=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a25:d55:: with SMTP id
 82mr54919866ybn.237.1638928527132; 
 Tue, 07 Dec 2021 17:55:27 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:34 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-25-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 24/26] KVM: x86: Skip APICv update if APICv is disable at
 the module level
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

Bail from the APICv update paths _before_ taking apicv_update_lock if
APICv is disabled at the module level.  kvm_request_apicv_update() in
particular is invoked from multiple paths that can be reached without
APICv being enabled, e.g. svm_enable_irq_window(), and taking the
rw_sem for write when APICv is disabled may introduce unnecessary
contention and stalls.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 3 +++
 arch/x86/kvm/x86.c    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 7179fa645eda..175c1bace091 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -112,6 +112,9 @@ static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
 	if (!!auto_eoi_old == !!auto_eoi_new)
 		return;
 
+	if (!enable_apicv)
+		return;
+
 	down_write(&vcpu->kvm->arch.apicv_update_lock);
 
 	if (auto_eoi_new)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index abf99b77883e..c804cc39c90d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9602,6 +9602,9 @@ EXPORT_SYMBOL_GPL(__kvm_request_apicv_update);
 
 void kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit)
 {
+	if (!enable_apicv)
+		return;
+
 	down_write(&kvm->arch.apicv_update_lock);
 	__kvm_request_apicv_update(kvm, activate, bit);
 	up_write(&kvm->arch.apicv_update_lock);
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
