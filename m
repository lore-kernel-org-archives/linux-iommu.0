Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339B4C433E0
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A1152074D
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v8pnncAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1152074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DB13188E49;
	Tue, 16 Jun 2020 06:13:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KstyW3HiBM4G; Tue, 16 Jun 2020 06:13:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6CF6E88CBB;
	Tue, 16 Jun 2020 06:13:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63EB9C0892;
	Tue, 16 Jun 2020 06:13:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E410FC016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 06:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AC41886914
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 06:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NIVLFZVuvo6S for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 06:13:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0095C868D9
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 06:13:44 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id n9so7930295plk.1
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 23:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=d8HNtFjVL/HPLva77WTnFKUW0Kvfs2vTc0BrF81DdWI=;
 b=v8pnncAeJ6EXVXBVIROBwY85MaUJaS+3cYpbNNYYzPLk/7pselZhTcoIxYzjCeyVv8
 z7rLz6dynrZeFhSyjXXuzxJss8D71TgLPxY1wSvVrGHHBe36mvLVuJbyV7oeqmPxZPF4
 3bBf2ru+qoskK42o6IV1MKU7khzwkAlxUiF86aroPb9CUN8SmEpvlRuPhbKl/aZW/n7x
 AWmFqLqQFiPnl3Li0QE+BVRXmEQzG3QuSiiUUYtPhE0RXGhRnX5RUcHPWqrprYghVulQ
 elANL0qhyySKvw/JSPWezE64h1v8gJgRUsY4bf8AXuO5qPZruWEfPRgNNcA9UaNhTmde
 rX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=d8HNtFjVL/HPLva77WTnFKUW0Kvfs2vTc0BrF81DdWI=;
 b=YSG3jimxA2P8tduzD2zRGW1XJIpwNi0KMb/YShRScuWLWOZUmuJIAH4LXzzn/fCYNo
 2ANYGbWojEOkCGj6W4dF8cvutQk+/OrGVzLOcYFSUnpMZAbRsPzMOQ2W6sIlR82mzBn6
 kCokSoT25NKIfkKOPD1d49p9DUgDmJll9tjnadDLPP6Co28Gcok8KTcDV2kzqCZjWTww
 EROmqgRJmENrICSUmNtC/a/7HmgZ17cWfHe/ExNrzPUBz7yddk0ALUkYvIWkxNIK3bbX
 UDUJajKtbOT8+V2FUarOHVpXvBjO5igqlymmtuKu3RhzH679M+e4uoiwBLX2h9+3xJV3
 LH9w==
X-Gm-Message-State: AOAM533mIpwRrZ6yBSkzZKZWSKHGAiXz86qcCf3g29wr37k7KSyuQdDi
 Ii/ZdVhYdsXxPdKDSkhioJIKJrx97dI=
X-Google-Smtp-Source: ABdhPJxCaVz3G+/geS1NzlugB57rAw/I7PZ2XURXxDE8DMjhkDv5DK9XyvrD63NMIlJN57XPvBQpCw==
X-Received: by 2002:a17:90a:220f:: with SMTP id
 c15mr1308713pje.129.1592288024596; 
 Mon, 15 Jun 2020 23:13:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
 by smtp.gmail.com with ESMTPSA id
 i26sm15642032pfo.0.2020.06.15.23.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 23:13:44 -0700 (PDT)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH 2/5] irq: irqchip: Export irq_chip_retrigger_hierarchy
 and irq_chip_set_vcpu_affinity_parent
Date: Tue, 16 Jun 2020 06:13:35 +0000
Message-Id: <20200616061338.109499-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616061338.109499-1-john.stultz@linaro.org>
References: <20200616061338.109499-1-john.stultz@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Saravana Kannan <saravanak@google.com>,
 Marc Zyngier <maz@kernel.org>, Lina Iyer <ilina@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, linux-gpio@vger.kernel.org,
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
