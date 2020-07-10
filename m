Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213C7C433E2
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 23:18:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB282077D
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 23:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9cW5ytw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB282077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AC92F89E5C;
	Fri, 10 Jul 2020 23:18:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8g5jWKg7Kozl; Fri, 10 Jul 2020 23:18:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D7D0389E56;
	Fri, 10 Jul 2020 23:18:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAB9EC0890;
	Fri, 10 Jul 2020 23:18:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC4F2C016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 23:18:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9A0F788ADD
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 23:18:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QxbsS84iOYKl for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 23:18:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C740088AD8
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 23:18:28 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id u185so3192674pfu.1
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=+59TPEQHEkQFZ55j35W3RLahGS4swop41zFjG28sQlI=;
 b=I9cW5ytw2dorAQZ66yCowEnQV62rnN/AoriJkdNr7cJgAwgRwj3foDLRAYlJONTScc
 BbvyMYrLXf4Ma+zp5w4jFN/HIONJxoJdg+7OmGipXEHe7gisS66qKVfKRlBoqOUH31qn
 wdlM3M75kl8HdNZUVzn3N+FGPD2h4fOGQLnbpRVvuMrTmgYQrVAJE5f0IWajIogniJeT
 WwHdWIIcRORBivihxFVnImhznJPtFQQkhPY2YeO0CDHXFqsgfkPHMNtsPcAWlceEH7wV
 ypAqdA3/qsYYS4O8WWsdFHUqG0aYvqC7uFPkyzPtm3uT153Tcyn4kzKbLFUcmyeWclPu
 PvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=+59TPEQHEkQFZ55j35W3RLahGS4swop41zFjG28sQlI=;
 b=Yq13S7ZZkoDanHV1C9jNj6wwqegV9Lj28UjB89od90boHYkl4A9jkKtM1ebRZJJLZu
 ioAxlhW9Q3RR1PinNLjt1sKp3ax/XxP4qjU1sORwGOQfkewlP+bTLh18E4fQcwWRj192
 K9VFjjRGK/7+j0kwa2sMNj1WMdHn+mVxg5HMnrrwc971ERV0e9XdWNxJuR3M48Gt2WsM
 YV+O+8Ge0ohTgAQXblT/OeWfY18xshWw6P84kSXTdH4axw//B/QYMfAu2WPkkVjSJ5Lr
 9IOy3rwWWzLheDxftDQseMPL93XcMrkGCVv7Q3wBEKLJnm6uJ5iCijMtYZX+NXE4vpNl
 6EMg==
X-Gm-Message-State: AOAM533pyDSAvb0yUDFhjIxOlCCDDuwQZfxs15ivhiT66SVFoUKONyji
 1rQXb8MCCIqhJBjGKSXPTLlCbA==
X-Google-Smtp-Source: ABdhPJxusBkc/oj8NBCk1Oz/2pCV5zkZFfQeGkUp9I+VXwSkN8aJ/nKOn8xnoY32VVj2OMigYe1yUg==
X-Received: by 2002:a62:1c13:: with SMTP id c19mr48626163pfc.52.1594423108114; 
 Fri, 10 Jul 2020 16:18:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
 by smtp.gmail.com with ESMTPSA id
 c14sm7296382pfj.82.2020.07.10.16.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 16:18:27 -0700 (PDT)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3]  Allow for qcom-pdc to be loadable as a module
Date: Fri, 10 Jul 2020 23:18:21 +0000
Message-Id: <20200710231824.60699-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, linux-gpio@vger.kernel.org,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 John Stultz <john.stultz@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-msm@vger.kernel.org, Todd Kjos <tkjos@google.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This patch series provides exports and config tweaks to allow
the qcom-pdc driver to be able to be configured as a permement
modules (particularlly useful for the Android Generic Kernel
Image efforts).

This was part of a larger patch series, to enable qcom_scm
driver to be a module as well, but I've split it out as there
are some outstanding objections I still need to address with
the follow-on patches, and wanted to see if progress could be
made on this subset of the series in the meantime.

New in v3:
*  Drop conditional usage of IRQCHIP_DECLARE as suggested by
   Stephen Boyd and Marc Zyngier

thanks
-john

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Maulik Shah <mkshah@codeaurora.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: linux-gpio@vger.kernel.org


John Stultz (3):
  irq: irqdomain: Export irq_domain_update_bus_token
  irq: irqchip: Export irq_chip_retrigger_hierarchy and
    irq_chip_set_vcpu_affinity_parent
  irqchip: Allow QCOM_PDC to be loadable as a permanent module

 drivers/irqchip/Kconfig    |  2 +-
 drivers/irqchip/qcom-pdc.c | 28 +++++++++++++++++++++++++++-
 kernel/irq/chip.c          |  3 ++-
 kernel/irq/irqdomain.c     |  1 +
 4 files changed, 31 insertions(+), 3 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
