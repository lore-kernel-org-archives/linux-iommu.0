Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EC5C4743C
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 23:53:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C284B6120D
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 23:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C284B6120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7889240439;
	Mon, 21 Jun 2021 23:53:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gyPMpDxLEcMq; Mon, 21 Jun 2021 23:53:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 25A51403E6;
	Mon, 21 Jun 2021 23:53:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD669C001A;
	Mon, 21 Jun 2021 23:53:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D342C000E
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 23:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F7E1403EE
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 23:53:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jLtjitfz9j3g for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 23:53:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 31B94403E6
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 23:53:09 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id m2so15443373pgk.7
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 16:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n91GfziZ5syAC28F6UjBolJ+M+YVU4V/73A7TE0XUb0=;
 b=SUyoFV/+KdCNo/00LCnOAUpTOHYgzf0cSORstuKQbNiRU4V1vUrGu4QetCpbQBYc1W
 GAxBENYZAxru0gINenfaFo3ipVEzhLwv0U2eNgFcJ2cPC7dG4++rrl8IkdEXEecTnwhe
 LSHANxMj999/UFOJcme3BmijnH7TMuu4qQkCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n91GfziZ5syAC28F6UjBolJ+M+YVU4V/73A7TE0XUb0=;
 b=rvqhJcg8W1oQn4yUGqAEwogJ5D2FdGiANJSar58fja2RTpn/HFRDlWOZh0GRkZvxZN
 yV32QX8NIWt/+8M/v8b0VUV7a3AyLRL1ioWh3eqncSMy3LBRqBG01zL0ntTwL9+0r9H+
 9rkIgL460Y9MC2/8tLlgZXthUWYtzVYi+Pd4l8GrWK1nuEvl9js+0vH4Mkz2sciiABm8
 BziO/iGKK/q0MeRdgZwVBnKN0SeBb013ODDrIdmvQP0o4L3vcIUXMpVc6142xrWVpCXT
 3AZ6+fXiHJmuCz2sjZe2+SPNP4QR1WLJZZ6yaZ0fblru+vQvWLjJPUWOSQ8wavOFVGhR
 ybvQ==
X-Gm-Message-State: AOAM531e1AZZM+Nt+PWOPhoZDB/bM+TG8QDemV3uBfNUTOKHdQI5lEdn
 LzuKPc2iTZLI39JS27ZDMr+4oQ==
X-Google-Smtp-Source: ABdhPJxZEK+bTs68KqckxQkGsSx8yLSwQ1E3xNiGaYMPOkRx7NyxIeuHTI/Mz9yWdTNtGbeL+DqgvQ==
X-Received: by 2002:a62:2601:0:b029:300:bd5a:9268 with SMTP id
 m1-20020a6226010000b0290300bd5a9268mr718024pfm.1.1624319588586; 
 Mon, 21 Jun 2021 16:53:08 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com
 ([2620:15c:202:201:bdc1:a4b1:b06e:91d1])
 by smtp.gmail.com with ESMTPSA id s27sm4339663pfg.169.2021.06.21.16.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 16:53:08 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, rafael.j.wysocki@intel.com,
 will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
 adrian.hunter@intel.com, bhelgaas@google.com
Subject: [PATCH 0/6] iommu: Enable devices to request non-strict DMA,
 starting with QCom SD/MMC
Date: Mon, 21 Jun 2021 16:52:42 -0700
Message-Id: <20210621235248.2521620-1-dianders@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
MIME-Version: 1.0
Cc: robdclark@chromium.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-kernel@vger.kernel.org, saravanak@google.com,
 linux-arm-msm@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 linux-mmc@vger.kernel.org, quic_c_gdjako@quicinc.com,
 Douglas Anderson <dianders@chromium.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-pci@vger.kernel.org,
 joel@joelfernandes.org, Dan Williams <dan.j.williams@intel.com>,
 rajatja@google.com, sonnyrao@chromium.org, vbadigan@codeaurora.org
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


This patch attempts to put forward a proposal for enabling non-strict
DMA on a device-by-device basis. The patch series requests non-strict
DMA for the Qualcomm SDHCI controller as a first device to enable,
getting a nice bump in performance with what's believed to be a very
small drop in security / safety (see the patch for the full argument).

As part of this patch series I am end up slightly cleaning up some of
the interactions between the PCI subsystem and the IOMMU subsystem but
I don't go all the way to fully remove all the tentacles. Specifically
this patch series only concerns itself with a single aspect: strict
vs. non-strict mode for the IOMMU. I'm hoping that this will be easier
to talk about / reason about for more subsystems compared to overall
deciding what it means for a device to be "external" or "untrusted".

If something like this patch series ends up being landable, it will
undoubtedly need coordination between many maintainers to land. I
believe it's fully bisectable but later patches in the series
definitely depend on earlier ones. Sorry for the long CC list. :(


Douglas Anderson (6):
  drivers: base: Add the concept of "pre_probe" to drivers
  drivers: base: Add bits to struct device to control iommu strictness
  PCI: Indicate that we want to force strict DMA for untrusted devices
  iommu: Combine device strictness requests with the global default
  iommu: Stop reaching into PCIe devices to decide strict vs. non-strict
  mmc: sdhci-msm: Request non-strict IOMMU mode

 drivers/base/dd.c             | 10 +++++--
 drivers/iommu/dma-iommu.c     |  2 +-
 drivers/iommu/iommu.c         | 56 +++++++++++++++++++++++++++--------
 drivers/mmc/host/sdhci-msm.c  |  8 +++++
 drivers/pci/probe.c           |  4 ++-
 include/linux/device.h        | 11 +++++++
 include/linux/device/driver.h |  9 ++++++
 include/linux/iommu.h         |  2 ++
 8 files changed, 85 insertions(+), 17 deletions(-)

-- 
2.32.0.288.g62a8d224e6-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
