Return-Path: <SRS0=QSWf=I3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CCAC433C1
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1380B61938
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1380B61938
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD6734032D;
	Mon, 29 Mar 2021 00:10:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VhVNTdbkGKnu; Mon, 29 Mar 2021 00:10:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 639E64032C;
	Mon, 29 Mar 2021 00:10:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6FEDC0014;
	Mon, 29 Mar 2021 00:10:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CA6BC000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B8708387D
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UslIhX59pUFN for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:56:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C0E82838DE
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:03 +0000 (UTC)
Received: by mail-qk1-x730.google.com with SMTP id x14so10902954qki.10
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZDOzS1vRcWtTYspKStQDHl39R8ItwGtdALzS3MH5haw=;
 b=BzAd00k8G81ySOORFH4ZYZ1bB3RbAIhMFXIV1td9cqvEo3UX3T7K8yDs0BLbUNs6dC
 G70pZ49bAzdfN5gPoTXAyB2FSNpShLDrz7XUsanKWuxMQrhE9um5pz0Eh9zXb8CEGvFR
 jProIh3TzVfDeb19gYLYfk5ihXrjFf2yWbMRIoNvoxWoNIfCyhIw+Kz9BsCPPMQa48D+
 /s97ueBJTMSjpIujqIKbMYw5vTW60f47/GtkTVffiOEP9zXV5SaMf2r5PpRh7pMqROjm
 DF1/IGaESef8EHnGmyWKekR0S17ktc8qfK44vFx3jKgxW3NB7Ado6xEEMvZo+NhRg8K7
 3Z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZDOzS1vRcWtTYspKStQDHl39R8ItwGtdALzS3MH5haw=;
 b=KCqf+/iewEROQPy8c5IJ6O7pivvsPjVNpeiAvsTOpa0r56tky1apcGwinaqq7N2RG9
 cgXRnh87aBqOAi45/mEcPOWyoV69FHcWcp4jog1rKhiBiGlHjzEQ2an2xeRsfO66O1CY
 Oq6nisGHtRcLVcSPX+pu+fjjAb4wBhwldZzJd4LL74oMAUaSPoPNGoI2lQlOWJxnRKIF
 rl/le/LG6SwOwfhNlIjI/s9YdgM7rJ+GEscYOAmr2G5nl37I2bEhZHGl4Yr3vJ6qA83r
 vPn2vB4WwnOk3BLCXWbTOBDI6z+ECQJz5T9YPOFNIvRapiID5+Ut2tyLxPNvypsbZeTP
 rLGg==
X-Gm-Message-State: AOAM5322KC8m2h69/R+BO6C/G2Kqt9BOvszN+2TOGm7KQQsAoSNxsLD7
 0dKnPmz1r1Lur+UG/lTw1Xc=
X-Google-Smtp-Source: ABdhPJypSYspQV6VkWopPpkt2zOnTgc+JiYwp3Y6rFrbq+R2YCZW03mpS3QNcfpuRFem43a0O2MkwQ==
X-Received: by 2002:a05:620a:110a:: with SMTP id
 o10mr23876269qkk.281.1616975762740; 
 Sun, 28 Mar 2021 16:56:02 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:56:02 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 01/30] acpi-dma.c: Fix couple of typos
Date: Mon, 29 Mar 2021 05:22:57 +0530
Message-Id: <c461490c88fdc6a18d264a283e5c69642ffa2859.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 29 Mar 2021 00:10:51 +0000
Cc: rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
 linux-kernel@vger.kernel.org
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


s/exctract/extract/
s/avaiable/available/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/acpi-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index 235f1396f968..4b1d5183bf64 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -100,7 +100,7 @@ static int acpi_dma_parse_resource_group(const struct acpi_csrt_group *grp,
 }

 /**
- * acpi_dma_parse_csrt - parse CSRT to exctract additional DMA resources
+ * acpi_dma_parse_csrt - parse CSRT to extract additional DMA resources
  * @adev:	ACPI device to match with
  * @adma:	struct acpi_dma of the given DMA controller
  *
@@ -293,7 +293,7 @@ EXPORT_SYMBOL_GPL(devm_acpi_dma_controller_free);
  * found.
  *
  * Return:
- * 0, if no information is avaiable, -1 on mismatch, and 1 otherwise.
+ * 0, if no information is available, -1 on mismatch, and 1 otherwise.
  */
 static int acpi_dma_update_dma_spec(struct acpi_dma *adma,
 		struct acpi_dma_spec *dma_spec)
--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
