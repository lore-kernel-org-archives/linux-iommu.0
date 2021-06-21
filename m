Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C935C49EA7
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 23:53:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F161C6128A
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 23:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F161C6128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C327183ABE;
	Mon, 21 Jun 2021 23:53:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zLrpjFqb9sTb; Mon, 21 Jun 2021 23:53:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F10283AB3;
	Mon, 21 Jun 2021 23:53:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A89BC001A;
	Mon, 21 Jun 2021 23:53:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59565C000E
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 23:53:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44D64400DD
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 23:53:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ccpSrJk1vUBv for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 23:53:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC910401FF
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 23:53:15 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id g24so10909015pji.4
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 16:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1hap5rrkK42QaF5phRIGliKevrZCv+fxjBjTLJ/pE7w=;
 b=SaTkql2WXjMyJO6whWG9JyCnglGg6faOh30E8Lhu9SgvFGWDGvulc9SplCY+Wx4hJB
 DCYHUv1GwmTka12BMkZes72rKui1uDoY0LzvsieTa2ZmIrnL4mVCj5E9Nvn0LnsgSd9a
 klTw+FraV7UJBMyr3e/hUg0h10KaCLpg93/bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1hap5rrkK42QaF5phRIGliKevrZCv+fxjBjTLJ/pE7w=;
 b=itDTFzBMYayAj/7mtbuQmGWNOpAfMo6eMhHY0lgrs2cD5dtLacRdGRWMTisPjM2Z5B
 ZUEhQstE2c5tNMOyMwQbydEuIGdEKFqzvrLeB4Gpuo5oJTzIw8XbSeI6Wu0Wqvbg429E
 rcHZ5utCpQrhALQG4cfrqwRDnZdZwWicoxeK0WWrArJ3cphXaRCyLfDndXRnV7o86J2X
 Koyx0YaqIL+ggd7z4BPKr5NTe7POfZJLN4/mju1qQVXfXee3xApOoff0f9KHCfndQaWJ
 CUqhmDHnfXKRCLSj+XKEZMpjrQzkYr8axH80OCdkigegVCs+O1zqoIR2/tMfpALs7sRU
 d1/Q==
X-Gm-Message-State: AOAM533SgHewExF4Iv/V1oonypWUIrTY6L8gak7UTGKQ868AXoys1h8Y
 vDAm0yI5cSQZVHY1umsIjWYERA==
X-Google-Smtp-Source: ABdhPJwXH5vi0Xs9ZIXNanUJNzJ2JIBdTlSTrxUumm5ORFc6vCcYGBtgB9XO+d3fthNCPEvr8XR/lA==
X-Received: by 2002:a17:90a:6be6:: with SMTP id
 w93mr598015pjj.171.1624319595138; 
 Mon, 21 Jun 2021 16:53:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com
 ([2620:15c:202:201:bdc1:a4b1:b06e:91d1])
 by smtp.gmail.com with ESMTPSA id s27sm4339663pfg.169.2021.06.21.16.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 16:53:14 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, rafael.j.wysocki@intel.com,
 will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
 adrian.hunter@intel.com, bhelgaas@google.com
Subject: [PATCH 3/6] PCI: Indicate that we want to force strict DMA for
 untrusted devices
Date: Mon, 21 Jun 2021 16:52:45 -0700
Message-Id: <20210621165230.3.I7accc008905590bb2b46f40f91a4aeda5b378007@changeid>
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

At the moment the generic IOMMU framework reaches into the PCIe device
to check the "untrusted" state and uses this information to figure out
if it should be running the IOMMU in strict or non-strict mode. Let's
instead set the new boolean in "struct device" to indicate when we
want forced strictness.

NOTE: we still continue to set the "untrusted" bit in PCIe since that
apparently is used for more than just IOMMU strictness. It probably
makes sense for a later patchset to clarify all of the other needs we
have for "untrusted" PCIe devices (perhaps add more booleans into the
"struct device") so we can fully eliminate the need for the IOMMU
framework to reach into a PCIe device.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/pci/probe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 275204646c68..8d81f0fb3e50 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1572,8 +1572,10 @@ static void set_pcie_untrusted(struct pci_dev *dev)
 	 * untrusted as well.
 	 */
 	parent = pci_upstream_bridge(dev);
-	if (parent && (parent->untrusted || parent->external_facing))
+	if (parent && (parent->untrusted || parent->external_facing)) {
 		dev->untrusted = true;
+		dev->dev.force_strict_iommu = true;
+	}
 }
 
 /**
-- 
2.32.0.288.g62a8d224e6-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
