Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B608BC43216
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 21:40:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7628160F02
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 21:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7628160F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4261E60715;
	Fri, 23 Jul 2021 21:40:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PiF8i0L7Anxk; Fri, 23 Jul 2021 21:40:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 24107608E7;
	Fri, 23 Jul 2021 21:40:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93DCBC000E;
	Fri, 23 Jul 2021 21:40:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31D97C000E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 127E840676
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=wdc.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nMswp-sTGW-j for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 21:40:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45AA3405DE
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 21:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1627076438; x=1658612438;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FZmD5JDut8+hqQnxscDF4nA471lKHOPpWVdLU/AZ18o=;
 b=NzEP6GJ+vTrZoRsYL1+hVW6/+YPNJDfc5n3/6RZW4PS2/rXhDcO+YApS
 AL5bqTuhZkv7/MMOw0copSp7mjUWFZJ8w/T7we6iCxzJkQudfmG6Izyhb
 cf0jQzXnpCazii7TWqbIfQGAmjt4wLw2InJmRZ/enzeyzBUqesFqcwLQ1
 mwu7dcSkXfxAhNGRd9zhgav+wjILac8t66aTwcxW3wYPWqh7FhC2kccl5
 XVPg7r8LKd+mVRVpoPdshgfaxvTLMT55QzbIR/Vf7B780gprIQD/QrG81
 Bn2DCWaDvNU5qMMqbxMQz4f7v2DZPMaY7bKvsjTtVQWapRwQeNzE5LNvn A==;
X-IronPort-AV: E=Sophos;i="5.84,265,1620662400"; d="scan'208";a="279198465"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2021 05:40:37 +0800
IronPort-SDR: CKyth6h+GJV94USuHn1bOW42ZgtKw0dLRV7tL/18iFvQj2cSXsH46jxwkR32jSkzXH66J/S+AT
 2/8wzLvir0UgWKGawGJa5RKNJL/gFVnVX/5hOpFco+CGGn3l/Moq+S5ztY94NpZUcVMjX4dSoe
 ioQ3m5nxmLvsveZcX9ypIve2r/b9CPwmA1O6zkgUA+n7IIEjeQL9qQ20rq0rvmeQPtRu+UclQz
 txdttosBoVUkj0c3Q1YHkG9ROExIDf1ITv4p8VibAnwQdm8FNWu55bYmwOGwZhnh4XXU9ImrcW
 /xe4cKLHX1BTkpnNk7AxFgaO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2021 14:18:26 -0700
IronPort-SDR: LjlOnqwO6a/04wGjvbug293m/8qn7cznMgBruMkmo6Tel5ZJMkE6+M7OvZdwEvPubcxMheZERt
 lQ+sNikSqbrehg8ASur9Vjq9mL3Z4lqGj5A946yoMS6Ts92f/InosBlv1k2y7BMcnZXeI9zPvx
 mJQEjGWo0n4PPJ7AA4mRZXBBF3gLp53/vEUqb9aWh7AAOyzSZkDvpyEMe1gzV0DokMofyshPSa
 GwceP5V147VgMQfr8U+sGdKkY+aTpBTNx89lHFjrE172mP1ushHKqjMVO+Y4cL8vURhvNaPxhK
 Jzc=
WDCIronportException: Internal
Received: from ucfbox21.ad.shared (HELO hulk.wdc.com) ([10.225.167.4])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Jul 2021 14:40:38 -0700
From: Atish Patra <atish.patra@wdc.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC 4/5] dma-direct: Allocate dma pages directly if global pool
 allocation fails
Date: Fri, 23 Jul 2021 14:40:30 -0700
Message-Id: <20210723214031.3251801-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210723214031.3251801-1-atish.patra@wdc.com>
References: <20210723214031.3251801-1-atish.patra@wdc.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
 Tobias Klauser <tklauser@distanz.ch>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Atish Patra <atish.patra@wdc.com>,
 iommu@lists.linux-foundation.org, Guo Ren <guoren@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>
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

DMA_GLOBAL_POOL config may be enabled for platforms where global pool is
not supported because a generic defconfig is expected to boot on different
platforms. Specifically, some RISC-V platforms may use global pool for
non-coherent devices while some other platforms are completely coherent.
However, it is expected that single kernel image must boot on all the
platforms.

Continue the dma direct allocation if a allocation from global pool failed.
This indicates that the platform is relying on some other method (direct
remap) or just have coherent devices.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 kernel/dma/direct.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index d1d0258ed6d0..984ea776f099 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -161,8 +161,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
 
 	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
-	    !dev_is_dma_coherent(dev))
-		return dma_alloc_from_global_coherent(dev, size, dma_handle);
+	    !dev_is_dma_coherent(dev)) {
+		ret = dma_alloc_from_global_coherent(dev, size, dma_handle);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * Remapping or decrypting memory may block. If either is required and
-- 
2.31.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
