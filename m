Return-Path: <SRS0=TTgE=JT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A5FC433ED
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 10:00:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70EC36101E
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 10:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EC36101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0024D40E54;
	Thu, 22 Apr 2021 10:00:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yMOUXiUvQ5c0; Thu, 22 Apr 2021 10:00:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B72040250;
	Thu, 22 Apr 2021 10:00:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60A75C000E;
	Thu, 22 Apr 2021 10:00:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A075DC000B
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 10:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 790DA40E54
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 10:00:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BtPaWG9owIY2 for <iommu@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 10:00:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E242740250
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 10:00:22 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id u187so4278710wmb.0
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 03:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=C88bKwIBkAr6gUwe9b4LaLz3Z0nsrf4Ahxaf+tTLHeQ=;
 b=antu4lNUb7sWBAB1q6zgHFbQukoXkPBqzOwOjjSpqOevv959YJaU7xIpqiGmL8Feng
 LFF+SwzSqbyW6jAAXyLs1mlYhRYeNHUjd8SKGoJUHJ17OEciGP/MF7wzwprCVF7pZrsS
 diJA7ctzYnqHrM49GvePWXnGi4wd7vaxLTl5mKzuOnYXJ8swQgkzdDmZ/nwccuLe88ed
 eth3nr4Wrro57tO+wlmJC5E/VNGoiL1kbZ1q25xw7gPjL44ZxAd9VrdNi14dc7myHhus
 kl8kVR1NZVYd4hxtCWS8kGKd/HpJKicXyQFEj0Uu6yoVaBcUqw4n5HaysxUb4wS5/ddz
 k8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=C88bKwIBkAr6gUwe9b4LaLz3Z0nsrf4Ahxaf+tTLHeQ=;
 b=HDHcCjQ/2dIVRIWbJtsnWUvuRewESQRR1g2oq5GOPp/PGXsUyEa/ll3AJu9uUwYFLY
 jd35hibgpMRcMLB6fRnW3PYRnMjngRE4dEEE828hiSP/4QYFYch1hBiTOuUyDItb5PY+
 SsuXqfwGqrphD+IAp7dvJqCRMkQ/l1fw/R9ulxC1w71rY5bZwkqZINq06pVBQjA3ssbM
 fSOLnZOcU46n8ugy9vRhKk43AWnx29Hb4usp+C4hxH+ViJ6v5V8tO/IDWs+3d8Ah1QFK
 rZ5eRU974cYJDHppABLcic/hy4D0Y2f5O0lxsrQTVzB5xEwjUCCLhDs2fSAspdeTwPbE
 qU2A==
X-Gm-Message-State: AOAM533/P6lIP0AFiaVEoQTIFGtEwvscUi4moQKVR0GIzaJdLhMuR22x
 aRRT+TI/6k8q/+tsjCP4Tab5fA==
X-Google-Smtp-Source: ABdhPJzSL3vKrAYcUjveunFlo5gJ5bEkina7MirFK5hqYI9Fa8l2FdmhohNzh5W2uZ4bZMiL3LnwYQ==
X-Received: by 2002:a05:600c:4e91:: with SMTP id
 f17mr14296173wmq.6.1619085620984; 
 Thu, 22 Apr 2021 03:00:20 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id p14sm2663455wrn.49.2021.04.22.03.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Apr 2021 03:00:20 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org
Subject: [PATCH] iommu/amd: Clear DMA ops when switching domain
Date: Thu, 22 Apr 2021 11:42:19 +0200
Message-Id: <20210422094216.2282097-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: robin.murphy@arm.com, iommu@lists.linux-foundation.org, will@kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
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
  BUG: kernel NULL pointer dereference, address: 0000000000000028
   ...
   Call Trace:
    iommu_dma_alloc
    e1000e_setup_tx_resources
    e1000e_open

Since iommu_change_dev_def_domain() calls probe_finalize() again, clear
the dma_ops there like Vt-d does.

Fixes: 08a27c1c3ecf ("iommu: Add support to change default domain of an iommu group")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

---
It could be factored into iommu_setup_dma_ops(), but this is easier to
backport and less likely to break other platforms. Since I need the same
for virtio-iommu, I'll do the factoring there.

My previous attempt at fixing this by implementing
arch_teardown_dma_ops() [1] was misguided. It's how arm64 deals with the
problem but it cannot reliably work on x86, because there the DMA ops
are set on device add, not on driver bind.

Thankfully Boris reported a regression on his test box and dropped that
patch [2]. Although I couldn't reproduce it I'm guessing what happens
is:

* probe_finalize(), called from device_add() or bus_set_iommu() sets up
  the DMA ops.
* Some driver, possibly ata_generic, probes the device and returns
  -ENODEV. arch_teardown_dma_ops() clears the DMA ops.
* Another driver probes the device and starts DMA. Now the direct DMA
  ops are used even though IOMMU protection is active, DMA faults.

[1] https://lore.kernel.org/linux-iommu/20210414082633.877461-1-jean-philippe@linaro.org/
[2] https://lore.kernel.org/lkml/20210417120644.GA5235@zn.tnic/
---
 drivers/iommu/amd/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a69a8b573e40..7de7a260706b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1747,6 +1747,8 @@ static void amd_iommu_probe_finalize(struct device *dev)
 	domain = iommu_get_domain_for_dev(dev);
 	if (domain->type == IOMMU_DOMAIN_DMA)
 		iommu_setup_dma_ops(dev, IOVA_START_PFN << PAGE_SHIFT, 0);
+	else
+		set_dma_ops(dev, NULL);
 }
 
 static void amd_iommu_release_device(struct device *dev)
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
