Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF16C433ED
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 08:29:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E738A613C3
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 08:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E738A613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9046405E9;
	Wed, 14 Apr 2021 08:29:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O2pLBPWGjEbb; Wed, 14 Apr 2021 08:29:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E03A40562;
	Wed, 14 Apr 2021 08:29:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 318C4C000B;
	Wed, 14 Apr 2021 08:29:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E140C000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 08:29:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7EA360BA8
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 08:29:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rSgvNOj_2sL7 for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 08:29:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3031600BA
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 08:29:13 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 y124-20020a1c32820000b029010c93864955so12108080wmy.5
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=epXw3irDvsvZFL4o434NpborWULmmHYE5K7OMVRyRAI=;
 b=p7Sxm7w9vNyyhaZiiyz/88cew7fUg3K8H2EC02WrUDTOxJ+2hC/CbH8VY3rrYvX7eO
 uXMzbiDRMr6+nUahA7p0JZigYAC26pMFHDdVxyyTBvUtSCN17kVwhxyOtanZ2m1yrU0a
 PIzpBpDOKr+9R/QEzcW2792Htj+Sp/VfoWh6o0mux4Fa8voOp7Fv7ufJr7RHhlXRQmhP
 oaymv49jrNB2zFc/5CRVufR87V5BwOu1+7EZ1mEtQP/dNOzv+xaz6A5TPrLkgu2nffad
 Frd3gdc3Xk7xN5YU2hiw2L6CdAZFkZkbMw4G9LTDk8d3atgG7ZlqgojFSKM36b+gAg9q
 25XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=epXw3irDvsvZFL4o434NpborWULmmHYE5K7OMVRyRAI=;
 b=Gh9ihqA4MCyCFKJU3Iqjpn5gtU6Et9ynBXSeq+GAjNPRMQJ/8CFPE8klZ02Ajs6BtG
 trlK5VuW/eRZlbFoPhsXRQD2GUAGTZ5pVq5kTglgBjRH2fXCpKMNrvpfJC7EIYHpqO7i
 bXj6UAwrDgbeQzzICYSH6tmE0x8yqFoxy6WdZMqPmzq7tzFuOB1ZdmiAme8ilRDQKlI3
 vkGioCNm1GeGIgc4ZWtYZfzy/MKdQdoDjy/1DOmejOLWFd+A8np0XeeAmAG+cR6KkaR2
 f5j9QSfV3O3hoccigSOwHo0PqI++suiJJMdTTDnyRaotlus5Sb7QDQSCGwdUjUgofDGs
 ZRHw==
X-Gm-Message-State: AOAM5314KEZPTcfRRwTbztV9ZagdOOF4DFqAOfPUkQTvZXR8tSj4I9Fp
 Od4AelbdLgnefV3ksTYUsjeX/g==
X-Google-Smtp-Source: ABdhPJwM8rnaaPmIEmSVIcO5Ix/lhhztBwn1RzthnOJVzNgGDiuXonPn4QdXuKllPtda2dypc+NOZQ==
X-Received: by 2002:a7b:c8ce:: with SMTP id f14mr1765553wml.113.1618388952091; 
 Wed, 14 Apr 2021 01:29:12 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id c12sm23850730wro.6.2021.04.14.01.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Apr 2021 01:29:11 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org
Subject: [PATCH] x86/dma: Tear down DMA ops on driver unbind
Date: Wed, 14 Apr 2021 10:26:34 +0200
Message-Id: <20210414082633.877461-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, will@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, hpa@zytor.com,
 robin.murphy@arm.com, hch@lst.de
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

Since commit 08a27c1c3ecf ("iommu: Add support to change default domain
of an iommu group") a user can switch a device between IOMMU and direct
DMA through sysfs. This doesn't work for AMD IOMMU at the moment because
dev->dma_ops is not cleared when switching from a DMA to an identity
IOMMU domain. The DMA layer thus attempts to use the dma-iommu ops on an
identity domain, causing an oops:

  # echo 0000:00:05.0 > /sys/sys/bus/pci/drivers/e1000e/unbind
  # echo identity > /sys/bus/pci/devices/0000:00:05.0/iommu_group/type
  # echo 0000:00:05.0 > /sys/sys/bus/pci/drivers/e1000e/bind
   ...
  [  190.017587] BUG: kernel NULL pointer dereference, address: 0000000000000028
   ...
  [  190.027375] Call Trace:
  [  190.027561]  iommu_dma_alloc+0xd0/0x100
  [  190.027840]  e1000e_setup_tx_resources+0x56/0x90
  [  190.028173]  e1000e_open+0x75/0x5b0

Implement arch_teardown_dma_ops() on x86 to clear the device's dma_ops
pointer during driver unbind.

Fixes: 08a27c1c3ecf ("iommu: Add support to change default domain of an iommu group")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/x86/Kconfig          | 1 +
 arch/x86/kernel/pci-dma.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..2c90f8de3e20 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -85,6 +85,7 @@ config X86
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_SYSCALL_WRAPPER
+	select ARCH_HAS_TEARDOWN_DMA_OPS	if IOMMU_DMA
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index de234e7a8962..60a4ec22d849 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -154,3 +154,10 @@ static void via_no_dac(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
 				PCI_CLASS_BRIDGE_PCI, 8, via_no_dac);
 #endif
+
+#ifdef CONFIG_ARCH_HAS_TEARDOWN_DMA_OPS
+void arch_teardown_dma_ops(struct device *dev)
+{
+	set_dma_ops(dev, NULL);
+}
+#endif
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
