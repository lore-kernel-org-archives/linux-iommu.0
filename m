Return-Path: <SRS0=A59K=AG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF7DC433E0
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 00:10:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94E0207E8
	for <iommu@archiver.kernel.org>; Thu, 25 Jun 2020 00:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KB67FIsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94E0207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8356C8796B;
	Thu, 25 Jun 2020 00:10:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yg79sB9+x9GH; Thu, 25 Jun 2020 00:10:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C7F1A879AB;
	Thu, 25 Jun 2020 00:10:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8A76C0888;
	Thu, 25 Jun 2020 00:10:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31835C016F
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 00:10:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 08F2521546
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 00:10:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jF-rzjG5YW0F for <iommu@lists.linux-foundation.org>;
 Thu, 25 Jun 2020 00:10:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by silver.osuosl.org (Postfix) with ESMTPS id 1C3AF2034D
 for <iommu@lists.linux-foundation.org>; Thu, 25 Jun 2020 00:10:44 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id n2so1893769pld.13
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 17:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=8GLNFmLwFxRxFkvvXf3GIeFQ0kp75ljQGaNoPkL6Oeg=;
 b=KB67FIscqsRKXoeF58Qep71/a//XbC0Lu9YseXcCAMKyeeeTnqctqHHll3EfluNzeo
 00LLvyXVTJ4H5dP+yl9r6RlvQoJI0T/KMYDjoT1aAWtTfTSGS+biJ5GMhyf7u9zcIu8q
 e0/Qx4LHVkf/1AUlRVQ9TbzVz7OFHmN+fRyN2gGTn/gusJU+l6FcRXC3gudJ1VEeGs8h
 P5k5qiTZEdQnbdFuroCZLxeoSk5iXG+/aG1LdlDA8aNJ+F294VFnMjqcce7JGb5GPgax
 zvREaBKkfqWf5mdiuZVMRGrRUkaRm0hUsFm9n/Jn1CIUMTULFVi5a/Q30cAxvzvlmZHE
 iEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=8GLNFmLwFxRxFkvvXf3GIeFQ0kp75ljQGaNoPkL6Oeg=;
 b=Q+I3e6RSZujpcTxJX/lpHC4mmvelwXMKfAOCKHcCNOFmpycybRntsIvmD1TouO/0yz
 ywrCwWfcoLPW0LONhlehbNfectgtqbIcSHJrretAyLNUYvCPcEyRZJ5gN1pHtYTigjgG
 WGSWucCUJTay7Z2s3TvzOY+HXg+npnW0OQOGkxQutDHDLDqWQWQalOXPVgYEQmMYSbR4
 OV1K71fYl7F05YWoiCJWHdE1DzJdiHLhIexTKGiFTJ2lrWkBvyXR12fGOmnyUyIc2jDA
 Tb8aBBqrS143k/mY5x4B+VAZhpOozylhwKgfd+6lu6YyXP4FR94sGCWXhhU0zCzvAVmX
 M33w==
X-Gm-Message-State: AOAM530uU0L2wIapFDVRjF5joS63qG0IvNaUuvfW2C52k+oAiVRNghHF
 e5aoN3kg1HrUnzAHmg5pdCMREQ==
X-Google-Smtp-Source: ABdhPJw5Ki+S7Ajanat5/ntyPcc1LAiikavEw9WMNgz9BOuejIKmBlFOlrRc/VFYWeblhHFU/nIYPg==
X-Received: by 2002:a17:902:ed14:: with SMTP id
 b20mr4448393pld.25.1593043843209; 
 Wed, 24 Jun 2020 17:10:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
 by smtp.gmail.com with ESMTPSA id
 n19sm17458671pgb.0.2020.06.24.17.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 17:10:42 -0700 (PDT)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/5] Allow for qcom-pdc,
 pinctrl-msm and qcom-scm drivers to be loadable as modules
Date: Thu, 25 Jun 2020 00:10:34 +0000
Message-Id: <20200625001039.56174-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 Lina Iyer <ilina@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-gpio@vger.kernel.org, iommu@lists.linux-foundation.org,
 Andy Gross <agross@kernel.org>, John Stultz <john.stultz@linaro.org>,
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
the qcom-pdc, pinctrl-msm and qcom-scm drivers to be able to be
configured as permement modules (particularlly useful for the
Android Generic Kernel Image efforts).

Feedback would be appreciated!

New in v2:
* Fix up MSM_PINCTRL Kconfig dependency logic so we match
  QCOM_SCM.
* Minor tweaks and corrections suggested by Bjorn and Maulik


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


John Stultz (5):
  irq: irqdomain: Export irq_domain_update_bus_token
  irq: irqchip: Export irq_chip_retrigger_hierarchy and
    irq_chip_set_vcpu_affinity_parent
  irqchip: Allow QCOM_PDC to be loadable as a permanent module
  pinctrl: qcom: Allow pinctrl-msm code to be loadable as a module
  firmware: QCOM_SCM: Allow qcom_scm driver to be loadable as a
    permenent module

 drivers/firmware/Kconfig           |  2 +-
 drivers/firmware/Makefile          |  3 ++-
 drivers/firmware/qcom_scm.c        |  4 ++++
 drivers/iommu/Kconfig              |  2 ++
 drivers/irqchip/Kconfig            |  2 +-
 drivers/irqchip/qcom-pdc.c         | 31 ++++++++++++++++++++++++++++++
 drivers/pinctrl/qcom/Kconfig       | 24 ++++++++++++++++++++++-
 drivers/pinctrl/qcom/pinctrl-msm.c |  2 ++
 kernel/irq/chip.c                  |  3 ++-
 kernel/irq/irqdomain.c             |  1 +
 10 files changed, 69 insertions(+), 5 deletions(-)

-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
