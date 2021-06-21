Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685C4C49EA2
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 23:53:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C5661289
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 23:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C5661289
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07D6A82F31;
	Mon, 21 Jun 2021 23:53:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i7IgxsdeueUB; Mon, 21 Jun 2021 23:53:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 229F682865;
	Mon, 21 Jun 2021 23:53:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2AB0C001A;
	Mon, 21 Jun 2021 23:53:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75B8BC000E
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 23:53:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6396683AB3
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 23:53:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qyRzkbNKh8aW for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 23:53:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A9B9E83AB6
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 23:53:19 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id c5so2272770pfv.8
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 16:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=THKoO1RWudj0KxP+z9XOrOgTVnvtbYYdvVkwmldz9OE=;
 b=DSphfoFZ7DM95K+RvdByDg8W0x0HzT372m/CTEnE3pqPeq323dI65P/rlVSfLPKJQ1
 28O9oN0CLLEtsLKgQ6MlMRXyKqjvpu/VGmk9AAzNr4tU542Ko0Ca8Ro0ReN1BsCsYzhm
 FrHRvl46FXtYmbbghamYqJa+AdyJraOwaTHvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=THKoO1RWudj0KxP+z9XOrOgTVnvtbYYdvVkwmldz9OE=;
 b=tH1K0wx/QEh79FSZtfb0Zr3RNq5sB1AMUrPVcoEtS/XzV/04n8hbXzsV2we9ggAqHQ
 VLkStwIQVA/Lg3PIZaefPuzGq1NKd7pmu63kyEc259vNJ4CZU+qHRhnpmGZYWs9Cp/fz
 UenGEbFL+JJIxG6NXvBUrv70H3eJLXWssWOPAlfn3bf3CxoDjjWAIWPOFeyEwMJ8RAGB
 JXQaY89qeOXYCzc05HKTzahup/8FeVl7tOD1FQjTVkNAfNFKF5KQFHJRp8bEzReLaNWO
 YOFQo5wn//VkmXWg39fPuX8LzQPjaUxfe2XWuwCzmV1eeNor8OKC7boLY9hgL2YFNr4Q
 8PLw==
X-Gm-Message-State: AOAM532LIs86ajtKAbjcdMsjlYYYdXkZH5hIzu+g826QgJMccq6hdJoo
 nE0Vpzygy2ZoOKlUsZWuX0bPGw==
X-Google-Smtp-Source: ABdhPJxcsyNJ4PVOdLaM5phhP72ONpeV+ZJ8ppg8iQL6bG+AB2umwHT1C064i27TPx/qxhDHxLJD1g==
X-Received: by 2002:a62:1d8c:0:b029:300:73d5:f35f with SMTP id
 d134-20020a621d8c0000b029030073d5f35fmr723439pfd.36.1624319599173; 
 Mon, 21 Jun 2021 16:53:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com
 ([2620:15c:202:201:bdc1:a4b1:b06e:91d1])
 by smtp.gmail.com with ESMTPSA id s27sm4339663pfg.169.2021.06.21.16.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 16:53:18 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, rafael.j.wysocki@intel.com,
 will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
 adrian.hunter@intel.com, bhelgaas@google.com
Subject: [PATCH 5/6] iommu: Stop reaching into PCIe devices to decide strict
 vs. non-strict
Date: Mon, 21 Jun 2021 16:52:47 -0700
Message-Id: <20210621165230.5.I091ed869d3b324a483a355d873ce6bf1dc2da5ba@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210621235248.2521620-1-dianders@chromium.org>
References: <20210621235248.2521620-1-dianders@chromium.org>
MIME-Version: 1.0
Cc: robdclark@chromium.org, linux-kernel@vger.kernel.org, saravanak@google.com,
 linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
 quic_c_gdjako@quicinc.com, Douglas Anderson <dianders@chromium.org>,
 iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
 joel@joelfernandes.org, rajatja@google.com, sonnyrao@chromium.org,
 vbadigan@codeaurora.org
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

We now have a way for PCIe devices to force iommu.strict through the
"struct device" and that's now hooked up. Let's remove the special
case for PCIe devices.

NOTE: there are still other places in this file that make decisions
based on the PCIe "untrusted" status. This patch only handles removing
the one related to iommu.strict. Removing the other cases is left as
an exercise to the reader.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7bcdd1205535..e50c06ce1a6b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -368,7 +368,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
 
-	if (!cookie->fq_domain && (!dev || !dev_is_untrusted(dev)) &&
+	if (!cookie->fq_domain &&
 	    domain->ops->flush_iotlb_all && !iommu_get_dma_strict(domain)) {
 		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
 					  iommu_dma_entry_dtor))
-- 
2.32.0.288.g62a8d224e6-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
