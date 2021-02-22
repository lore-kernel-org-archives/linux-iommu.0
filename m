Return-Path: <SRS0=ekvE=HY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1848C433DB
	for <iommu@archiver.kernel.org>; Mon, 22 Feb 2021 15:54:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D6864E12
	for <iommu@archiver.kernel.org>; Mon, 22 Feb 2021 15:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D6864E12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D3976F4DE;
	Mon, 22 Feb 2021 15:54:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W3SDV5n_ccP7; Mon, 22 Feb 2021 15:54:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9D206F556;
	Mon, 22 Feb 2021 15:54:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93DC9C000A;
	Mon, 22 Feb 2021 15:54:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74D07C0001
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 15:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7121387201
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 15:54:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id plxiwhOQQC-4 for <iommu@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 15:54:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2154E87212
 for <iommu@lists.linux-foundation.org>; Mon, 22 Feb 2021 15:54:39 +0000 (UTC)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Dkmt54vTmz7p7t;
 Mon, 22 Feb 2021 23:53:01 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.47.88.147) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Feb 2021 23:54:26 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux-foundation.org>, <kvmarm@lists.cs.columbia.edu>
Subject: [RFC PATCH 2/5] KVM: Add generic infrastructure to support pinned
 VMIDs
Date: Mon, 22 Feb 2021 15:53:35 +0000
Message-ID: <20210222155338.26132-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20210222155338.26132-1-shameerali.kolothum.thodi@huawei.com>
References: <20210222155338.26132-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.47.88.147]
X-CFilter-Loop: Reflected
Cc: jean-philippe@linaro.org, maz@kernel.org, linuxarm@openeuler.org,
 alex.williamson@redhat.com, prime.zeng@hisilicon.com, zhangfei.gao@linaro.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Provide generic helper functions to get/put pinned VMIDs if the arch
supports it.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 include/linux/kvm_host.h | 17 +++++++++++++++++
 virt/kvm/Kconfig         |  2 ++
 virt/kvm/kvm_main.c      | 25 +++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7f2e2a09ebbd..25856db74a08 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -836,6 +836,8 @@ bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu);
 void kvm_vcpu_kick(struct kvm_vcpu *vcpu);
 int kvm_vcpu_yield_to(struct kvm_vcpu *target);
 void kvm_vcpu_on_spin(struct kvm_vcpu *vcpu, bool usermode_vcpu_not_eligible);
+int kvm_pinned_vmid_get(struct device *dev);
+int kvm_pinned_vmid_put(struct device *dev);
 
 void kvm_flush_remote_tlbs(struct kvm *kvm);
 void kvm_reload_remote_mmus(struct kvm *kvm);
@@ -1478,4 +1480,19 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
 }
 #endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
 
+#ifdef CONFIG_HAVE_KVM_PINNED_VMID
+int kvm_arch_pinned_vmid_get(struct kvm *kvm);
+int kvm_arch_pinned_vmid_put(struct kvm *kvm);
+#else
+static inline int kvm_arch_pinned_vmid_get(struct kvm *kvm)
+{
+	return -EINVAL;
+}
+
+static inline int kvm_arch_pinned_vmid_put(struct kvm *kvm)
+{
+	return -EINVAL;
+}
+#endif
+
 #endif
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 1c37ccd5d402..bb55616c5616 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -63,3 +63,5 @@ config HAVE_KVM_NO_POLL
 
 config KVM_XFER_TO_GUEST_WORK
        bool
+config HAVE_KVM_PINNED_VMID
+       bool
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2541a17ff1c4..632d391f0e34 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -51,6 +51,7 @@
 #include <linux/io.h>
 #include <linux/lockdep.h>
 #include <linux/kthread.h>
+#include <linux/vfio.h>
 
 #include <asm/processor.h>
 #include <asm/ioctl.h>
@@ -2849,6 +2850,30 @@ bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_wake_up);
 
+int kvm_pinned_vmid_get(struct device *dev)
+{
+	struct kvm *kvm;
+
+	kvm = vfio_kvm_get_from_dev(dev);
+	if (!kvm)
+		return -EINVAL;
+
+	return kvm_arch_pinned_vmid_get(kvm);
+}
+EXPORT_SYMBOL_GPL(kvm_pinned_vmid_get);
+
+int kvm_pinned_vmid_put(struct device *dev)
+{
+	struct kvm *kvm;
+
+	kvm = vfio_kvm_get_from_dev(dev);
+	if (!kvm)
+		return -EINVAL;
+
+	return kvm_arch_pinned_vmid_put(kvm);
+}
+EXPORT_SYMBOL_GPL(kvm_pinned_vmid_put);
+
 #ifndef CONFIG_S390
 /*
  * Kick a sleeping VCPU, or a guest VCPU in guest mode, into host kernel mode.
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
