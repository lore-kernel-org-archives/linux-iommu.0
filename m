Return-Path: <SRS0=BxgK=4Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B79C3F2D2
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 17:29:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC0D24699
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 17:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yZGrvgqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC0D24699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 63F95861B2;
	Fri, 28 Feb 2020 17:29:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YT8J47Iyyxaf; Fri, 28 Feb 2020 17:29:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7B45B86044;
	Fri, 28 Feb 2020 17:29:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BB54C0177;
	Fri, 28 Feb 2020 17:29:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC7E7C1D84
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 17:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 97B1E88252
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 17:29:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XwZOlmP4aCky for <iommu@lists.linux-foundation.org>;
 Fri, 28 Feb 2020 17:29:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 346D48823A
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 17:29:11 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id v2so3800100wrp.12
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 09:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jos+UmzK8Hc9Z4PLlKLT5wM1USAOZpd5S+CdEr/za4M=;
 b=yZGrvgqQ3a9ydAmqTudY9IPdx/DjncbPCa+rQvZU9WCCULTVwu2UGa5TOBot6AcdAG
 Kea81JX8LljjFV+j8BdSJpCyXxETCHdToyup/qvOs2Kn/fZyBQP4EcHVQVMY//0PDYs8
 SwcXTnK7YZ6v3S+y6nKkPQibqpCdCoHJqW4g0nJu/BIO9DBIa3lGcvtNA2prifHT/Oxw
 mIbbtRN7Vlm0MUeryNgWY+DQRCOUVg7Y7AL5rM3IrhRJM50B+aLgnA02feYoB5UL1UQX
 OV1jj+4Aepoo957kJ/DUrhNRR3P3hpqS7hEv+rVY3PJ+0f87zExAbBJD5I+PfPnq0iQz
 2xAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jos+UmzK8Hc9Z4PLlKLT5wM1USAOZpd5S+CdEr/za4M=;
 b=irJGJ+Zn46hwvPQQwmbGkja2EWmeBvJ84mW8JTXfmxc1gSnURJSsGRPwyEQYinDfmJ
 Idbx9x7sB84Y3iKofj4N/nDWeGtppHEIDMlFSh1KDm3JOxYuInfxsEk1SQ3cXC1yLffy
 9OP5VoJ5kiIX2J3ifhRYLUdCAbRaTGst5IutZ1B/blcTRVDel8W/ZTYai1H45dxGS0+v
 GWLEC1XhcZHkBFNlD/3VanROLI73NsDQf6sbaMG5yiGY3JI5Dpp+n1HwQjzkW3morXZN
 2W8QtvxD1Qn3IVtzmDw2r4GsKejlzLufoAzPWS6jJT+IDy/49rfYRUaf5On/3cwkRWF8
 mgsw==
X-Gm-Message-State: APjAAAV5xCmtTMQ1lARtDjHgAxh7KIv2SETCrLzsGN9efBsxPft7VKaC
 ZZF39fstwz9Qa3ui7Ln3MSYqGsGoc6k=
X-Google-Smtp-Source: APXvYqzT3P7sA/CZ/b1UMh6+05HJ/72/05Zr7K58Lo6dOwmy5w3WAhfYStmzvZK+P8kUpQEHVNKUng==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr5683415wrj.196.1582910948537; 
 Fri, 28 Feb 2020 09:29:08 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m125sm3004795wmf.8.2020.02.28.09.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 09:29:08 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 3/3] iommu/virtio: Enable x86 support
Date: Fri, 28 Feb 2020 18:25:38 +0100
Message-Id: <20200228172537.377327-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200228172537.377327-1-jean-philippe@linaro.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 mst@redhat.com, sebastien.boeuf@intel.com, jacob.jun.pan@intel.com,
 bhelgaas@google.com, robin.murphy@arm.com, jasowang@redhat.com
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

With the built-in topology description in place, x86 platforms can now
use the virtio-iommu.

Architectures that use the generic iommu_dma_ops should normally select
CONFIG_IOMMU_DMA themselves (from arch/*/Kconfig). Since not all x86
drivers have been converted yet, it's currently up to the IOMMU Kconfig
to select it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f8cb45d84bb0..87efc48c244e 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -508,8 +508,9 @@ config HYPERV_IOMMU
 config VIRTIO_IOMMU
 	tristate "Virtio IOMMU driver"
 	depends on VIRTIO
-	depends on ARM64
+	depends on (ARM64 || X86)
 	select IOMMU_API
+	select IOMMU_DMA if X86
 	select INTERVAL_TREE
 	help
 	  Para-virtualised IOMMU driver with virtio.
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
