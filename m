Return-Path: <SRS0=kzsj=LS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E19AC49EAF
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 17:18:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F1F61166
	for <iommu@archiver.kernel.org>; Thu, 24 Jun 2021 17:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F1F61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B654260BF9;
	Thu, 24 Jun 2021 17:18:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Is_44NaLGDzz; Thu, 24 Jun 2021 17:18:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 74EEC605D5;
	Thu, 24 Jun 2021 17:18:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F086C001A;
	Thu, 24 Jun 2021 17:18:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37D58C000E
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 17:18:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1138D4017B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 17:18:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ht6qeEcWiezO for <iommu@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 17:18:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 43AD640100
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 17:18:25 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 b5-20020a17090a9905b029016fc06f6c5bso3897006pjp.5
 for <iommu@lists.linux-foundation.org>; Thu, 24 Jun 2021 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XWNwGk9GjelPq0lKH2dxtU8MIJBYkaGELFI1ssqXZTY=;
 b=axtIMnpDVdkjRLH4nX+f7Hd/a94NGXarbbRZp9pKXtT6TpJu7knFwnxzm/B9XB9U5q
 ADPy7uRDHNfp2pRHlI7Plj6WxokjAj3ZwsFS7vr4aASPUFiyzw/o62bdKWis8u+5oBW4
 Vikei2WzAFO6FSuuPDtR+qxX1leJS0yoWKXB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XWNwGk9GjelPq0lKH2dxtU8MIJBYkaGELFI1ssqXZTY=;
 b=ggSqRwLPNsetXfEdARO1vaJBy1d4s30ZnrR1p+oC33713nNSPkj0jpCqicqPPKtyaq
 9u9xelMKpI9evmx5jyy8mqyPjyPfSB0JljUj1aVgsIERKMd7xuhha5bOASQfzKqaAo2+
 VgvBO063VmUdEC/tbAWPMAQFBr+Bh6zCIJpIFSaNVsSYGxPq6dRHobzEriI1gW3o6GKW
 0Mki96hT+oIvBpEkRMqcRpv+kd/KEHLuzikcWDGdrgUf4J/r+e/UvI+uQKXDqP75VTHd
 2Zxy4npstsxGIZxVXRyi6r4lP4yHHZmn/kZ4Ew40JCNdnEqOucOZ8DEVbFohlaRZSebF
 +chQ==
X-Gm-Message-State: AOAM531T+b/fu9CSuAC9qqC0isknpIQ04MiRhrmHhWqu2vQtzd3oeW6H
 1oczwhaNJ9gfteHUL5LM4HP65A==
X-Google-Smtp-Source: ABdhPJyDDZAEVmImuYqq+gOLGeBE++WkFuVJuSBHo1MrycS/xGTXZy6Yo8US/jLhBHewMabX0cuR6g==
X-Received: by 2002:a17:90b:4d8d:: with SMTP id
 oj13mr6232430pjb.184.1624555104750; 
 Thu, 24 Jun 2021 10:18:24 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com
 ([2620:15c:202:201:fd74:62bc:19e3:a43b])
 by smtp.gmail.com with ESMTPSA id z9sm3365960pfa.2.2021.06.24.10.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jun 2021 10:18:24 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
 adrian.hunter@intel.com, bhelgaas@google.com
Subject: [PATCH v2 0/3] iommu: Enable non-strict DMA on QCom SD/MMC
Date: Thu, 24 Jun 2021 10:17:56 -0700
Message-Id: <20210624171759.4125094-1-dianders@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Cc: linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 linux-pci@vger.kernel.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
 Thierry Reding <thierry.reding@gmail.com>, joel@joelfernandes.org,
 rajatja@google.com, robdclark@chromium.org, saravanak@google.com,
 Jonathan Corbet <corbet@lwn.net>, quic_c_gdjako@quicinc.com,
 linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>,
 vbadigan@codeaurora.org, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-arm-msm@vger.kernel.org, sonnyrao@chromium.org,
 Vlastimil Babka <vbabka@suse.cz>, Randy Dunlap <rdunlap@infradead.org>,
 linux-mmc@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
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


The goal of this patch series is to get better SD/MMC performance on
Qualcomm eMMC controllers and in generally nudge us forward on the
path of allowing some devices to be in strict mode and others to be in
non-strict mode. This patch series doesn't save the world but
hopefully at least moves us in the right direction while accomplishing
something useful. Specifically:
- No attempt is made to touch the PCI subsystem or cleanup the way
  that it requests strict vs. non-strict.
- No fully generic mechanism is come up with that makes it super easy
  for everyone to be in non-strict mode.

This patch conflicts with a few other patch series that are in
flight. I've tried to call them out "after the cut" in patches. I
assume other in flight patches will land before this one, so I'd
expect to send a rebased version when that happens, assuming that this
series isn't NAKed into the ground.

Changes in v2:
- No longer based on changes adding strictness to "struct device"
- Updated kernel-parameters docs.
- Patch moving check for strictness in arm-smmu new for v2.
- Now accomplish the goal by putting rules in the IOMMU driver.
- Reworded commit message to clarify things pointed out by Greg.

Douglas Anderson (3):
  iommu: Add per-domain strictness and combine with the global default
  iommu/arm-smmu: Check for strictness after calling
    impl->init_context()
  mmc: sdhci-msm: Request non-strict IOMMU mode

 .../admin-guide/kernel-parameters.txt         |  5 ++-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    | 19 ++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c         |  6 +--
 drivers/iommu/iommu.c                         | 43 +++++++++++++++----
 include/linux/iommu.h                         |  7 +++
 5 files changed, 67 insertions(+), 13 deletions(-)

-- 
2.32.0.93.g670b81a890-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
