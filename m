Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0790EC433EA
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 23:18:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B71207BB
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 23:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fb2laGua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B71207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A5B4488B13;
	Fri, 10 Jul 2020 23:18:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h65bM2lRo7Fz; Fri, 10 Jul 2020 23:18:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3B49E88AEF;
	Fri, 10 Jul 2020 23:18:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28DB8C0890;
	Fri, 10 Jul 2020 23:18:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEF34C016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 23:18:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B54E089E61
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 23:18:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id odRGPaCT06as for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 23:18:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 09BC689E57
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 23:18:37 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id 1so3174136pfn.9
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+LAKpRiBafd2oOjp/6TfYpZhYF0M8uCnrw227kRHd7U=;
 b=Fb2laGua2O0o3qIqAFaaFHeDOkX2Z7Sq4CysZLHkLud6BHKz7RjNEDQoC5zg+gdNRW
 l64bwkrGWxENZzaGdE49CdjfCWmeTUpd14CG/9Ea+BuiUN8kv4ApLd2gVTRe3z4magmR
 /XwHgns0ezmupMVonilKBcWoXcOnMTYozNC5ES7ifUTfqH2sgImqCOF62Phuf4Kszvzl
 +FemTUwsgBfpnPH36Y1zR/5tLM5bOqN7ha3p8bIkHr1EEnGS56QYXSjXfNoXh3E/MI7e
 uBh6LC8Nb0jgO/h3+mfxpKQjb79mjvvEB2SbYBWgz1rl4bCt3oeRAQCH+eVBmZ06lORX
 dcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+LAKpRiBafd2oOjp/6TfYpZhYF0M8uCnrw227kRHd7U=;
 b=ZHKQJzOd7eug6YuAxmAdFbg9f0zlJux8JbmLK/DgXEdWsb1klNIA0dTPRbjK/8oRmO
 LQH7FXoibmV8bGZUZHTDx5J3yTrVHWkU0C9fh5jM4OgZw1tjN+eKR4a/ic4IKELqccKF
 p3yExMB3mJ3P0MRzaeDvxERuysT5Ks0TG7UWfyENtlfWxVXE87B8pS+8Ohl4WBOVQNNe
 CG/+ZElNHZkx2nkM2ygzi+IO7PKD47NbIBTaYJw0wqMRcXyvBU2Pf0BbkqdkPk+Dhwmq
 Hc2LQiXuzFIH7L83/9pnB0I6qp4ZbnezUHUGT5azZE/d9T5PcC1iZmjiN1Hk+yU+jP6f
 3MRw==
X-Gm-Message-State: AOAM5316EP81BUlfLIP3e3DApXgADcmqnS5jTI8dm4ICsUEKYOuZODj+
 McEl2D2OlSnm/exw0wn+ycJGRg==
X-Google-Smtp-Source: ABdhPJxazz3b2K1meU8hdEkjra2QvmoMn+ofo3x6qLL7NuVHq/rd+1PfJ28IeoTLBIcjHFUnIpZasQ==
X-Received: by 2002:a63:fd03:: with SMTP id d3mr60360119pgh.76.1594423116626; 
 Fri, 10 Jul 2020 16:18:36 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
 by smtp.gmail.com with ESMTPSA id
 c14sm7296382pfj.82.2020.07.10.16.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 16:18:36 -0700 (PDT)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/3] irq: irqchip: Export irq_chip_retrigger_hierarchy and
 irq_chip_set_vcpu_affinity_parent
Date: Fri, 10 Jul 2020 23:18:23 +0000
Message-Id: <20200710231824.60699-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710231824.60699-1-john.stultz@linaro.org>
References: <20200710231824.60699-1-john.stultz@linaro.org>
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

Add EXPORT_SYMBOL_GPL entries for irq_chip_retrigger_hierarchy()
and irq_chip_set_vcpu_affinity_parent() so that we can allow
drivers like the qcom-pdc driver to be loadable as a module.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Maulik Shah <mkshah@codeaurora.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: linux-gpio@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 kernel/irq/chip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 41e7e37a0928..ba6ce66d7ed6 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1478,6 +1478,7 @@ int irq_chip_retrigger_hierarchy(struct irq_data *data)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(irq_chip_retrigger_hierarchy);
 
 /**
  * irq_chip_set_vcpu_affinity_parent - Set vcpu affinity on the parent interrupt
@@ -1492,7 +1493,7 @@ int irq_chip_set_vcpu_affinity_parent(struct irq_data *data, void *vcpu_info)
 
 	return -ENOSYS;
 }
-
+EXPORT_SYMBOL_GPL(irq_chip_set_vcpu_affinity_parent);
 /**
  * irq_chip_set_wake_parent - Set/reset wake-up on the parent interrupt
  * @data:	Pointer to interrupt specific data
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
