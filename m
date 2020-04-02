Return-Path: <SRS0=urD1=5S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BE4C2D0F3
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 14:58:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04FC620784
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 14:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehn/hXoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FC620784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D2BB985721;
	Thu,  2 Apr 2020 14:58:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PS7VxgcGA5Rq; Thu,  2 Apr 2020 14:58:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4A78A855B1;
	Thu,  2 Apr 2020 14:58:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FE14C1D74;
	Thu,  2 Apr 2020 14:58:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A570FC07FF
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 14:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 904A888091
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 14:53:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wGdgWEP2dV8U for <iommu@lists.linux-foundation.org>;
 Thu,  2 Apr 2020 14:53:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0759088077
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 14:53:08 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id k18so1424193pll.6
 for <iommu@lists.linux-foundation.org>; Thu, 02 Apr 2020 07:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gjUUD6QNlvW5+sj/OX+BljKH59QNXj2Gt2J1SVUv6Sw=;
 b=ehn/hXoUTJe3Y8c0P19r6zXuFp+SUe4FP80NLHWvEkg0bSA5NDKLEcgUhQCyvlXgCJ
 BwXc/6Cf7BhLGtMN2kI6hvxgmhHyjKzO+X0DXyzQc6EIEJ1HDRsnZ2DOCtDalGJGK0AO
 yGxCBhxFCZHz7BlI9ZtuSefS94sAtuONi12PolQvEZ7ramw5qWO5YWsmH/R9AwXMEZFY
 g5xZqDHYCtd++IOYBnIbSYqVMZhLTakLZBydutfxZg5PIcPOfIi6Qc3sxyPQjzSWgXPb
 nlYE29Bogp6Lsej60bhlOXc19e9T+G/8G6DoPSuZhpcK8NKSovy9d2EFPbaeFYDz2ENQ
 JHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gjUUD6QNlvW5+sj/OX+BljKH59QNXj2Gt2J1SVUv6Sw=;
 b=aEZtubUxTBBuCV/rBnMtTUFF57pvAyn62wbVsWFtr57rGUzGCyjlGBvXrIvIXJbx18
 ktf9pTcm/VWA2p8xUim4K5ywQZpc3teVhSF6qGsziOw0a/XDu91qPwKBqgSuv6PZv9LK
 /QXX1Iyu7397qP7stRQoIgmgtt9xlENtBbPfjFtt/pfrgW6iF48iNNc/lCe8T+EAEqqT
 PmiqdN5Os1UGbpVmd/M8ycQI3PYAA0jJkFPUhUae3HfWLsggnw8/OwKlWAe6FwzVAe/5
 szn1Zb4VJITDcWw1OHQPWnQOieeOBultQ8VyvNTSSGTfiyHkntHG9tjFidT+zUy0sOfs
 7XTA==
X-Gm-Message-State: AGi0Pua7e/GR+NXofcGIrODVJ+Q8Gvjcb9S0upyJeUWjYKMD/FPPs1fi
 YfjvUwkyJlvAU78i7/pRWuP7zbQqiVk=
X-Google-Smtp-Source: APiQypLsB4uUXyO6n50Uiy8e6kyCTAFVCBbDkYiFrlAENoQYnW7JprvIztp3Rz5ResFKsvFqoiW+2A==
X-Received: by 2002:a17:90a:c20b:: with SMTP id
 e11mr4213422pjt.57.1585839187417; 
 Thu, 02 Apr 2020 07:53:07 -0700 (PDT)
Received: from pek-lpggp6.wrs.com (unknown-105-123.windriver.com.
 [147.11.105.123])
 by smtp.gmail.com with ESMTPSA id u3sm4024376pfb.36.2020.04.02.07.53.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 02 Apr 2020 07:53:06 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu: Fix the memory leak in dev_iommu_free()
Date: Thu,  2 Apr 2020 22:37:49 +0800
Message-Id: <20200402143749.40500-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b814c1
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 02 Apr 2020 14:58:35 +0000
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

In iommu_probe_device(), we would invoke dev_iommu_free() to free the
dev->iommu after the ->add_device() returns failure. But after commit
72acd9df18f1 ("iommu: Move iommu_fwspec to struct dev_iommu"), we also
need to free the iommu_fwspec before the dev->iommu is freed. This fixes
the following memory leak reported by kmemleak:
  unreferenced object 0xffff000bc836c700 (size 128):
    comm "swapper/0", pid 1, jiffies 4294896304 (age 782.120s)
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 d8 cd 9b ff 0b 00 ff ff  ................
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    backtrace:
      [<00000000df34077b>] kmem_cache_alloc_trace+0x244/0x4b0
      [<000000000e560ac0>] iommu_fwspec_init+0x7c/0xb0
      [<0000000075eda275>] of_iommu_xlate+0x80/0xe8
      [<00000000728d6bf9>] of_pci_iommu_init+0xb0/0xb8
      [<00000000d001fe6f>] pci_for_each_dma_alias+0x48/0x190
      [<000000006db6bbce>] of_iommu_configure+0x1ac/0x1d0
      [<00000000634745f8>] of_dma_configure+0xdc/0x220
      [<000000002cbc8ba0>] pci_dma_configure+0x50/0x78
      [<00000000cdf6e193>] really_probe+0x8c/0x340
      [<00000000fddddc46>] driver_probe_device+0x60/0xf8
      [<0000000061bcdb51>] __device_attach_driver+0x8c/0xd0
      [<000000009b9ff58e>] bus_for_each_drv+0x80/0xd0
      [<000000004b9c8aa3>] __device_attach+0xec/0x148
      [<00000000a5c13bf3>] device_attach+0x1c/0x28
      [<000000005071e151>] pci_bus_add_device+0x58/0xd0
      [<000000002d4f87d1>] pci_bus_add_devices+0x40/0x90

Fixes: 72acd9df18f1 ("iommu: Move iommu_fwspec to struct dev_iommu")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/iommu/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2b471419e26c..54757c404866 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -170,6 +170,7 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
 
 static void dev_iommu_free(struct device *dev)
 {
+	iommu_fwspec_free(dev);
 	kfree(dev->iommu);
 	dev->iommu = NULL;
 }
-- 
2.25.1.377.g2d2118b814c1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
