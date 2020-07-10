Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF234C433E6
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 23:18:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 920432077D
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 23:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pz1BOCQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920432077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 61E2589D29;
	Fri, 10 Jul 2020 23:18:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ta7KZgnMuQSI; Fri, 10 Jul 2020 23:18:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id ECC1E899EA;
	Fri, 10 Jul 2020 23:18:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4D4FC0890;
	Fri, 10 Jul 2020 23:18:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F737C016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 23:18:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6F06D89D28
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 23:18:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 927PRu6Xfkgf for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 23:18:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3B398899EA
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 23:18:35 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id k27so3181911pgm.2
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 16:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qCGYxi6L0dmDdYzHShkkSHiKc6T34aWWoWuQkkFnaWU=;
 b=Pz1BOCQB0pXjBmo0xAku7n+cwdXdjkY8Qu/3gwY1QOKhNMztkqxXIGamSB0+URD4zJ
 bWGsle4ItBlbOYOFz3XZNcJ+GUr8J7HxfpiuyudOZpOdtLYbAAwglyH0n3zi4kk2nhcS
 mvQ133SopxNOT2bwP33RuYrlCnRwVtE3wmrCetH7/Q9qh0nPSPrysb9a3+/s2XmyxP+Y
 ulNhRUI6X5nAUpZHovYN2PASbHMZkbriStlea5f8FcJEhpZClmWwbmd7xaj0AuMhmyoq
 xQYYHC0uckxurGhu1x+gXqb2mo/0ksmiHT6dXqmO1uiAHdW9omZK3wwUwJpvSjfFFDWf
 mi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qCGYxi6L0dmDdYzHShkkSHiKc6T34aWWoWuQkkFnaWU=;
 b=Tx375lxRZ0sebpbXJKXysZdTDZ9ITHE10FejPMeBT36cPfxh0X3gx0rQSmknwRwx1g
 ry3yfbTYrHEnuEDz0gqEkmLgGiv799I/OUwo1P3twKCW0SaRcnjzZBx17KnnciBG+dsy
 ZOvqcd3mIsQo1aA/E3ijtuzcDW+Xb5whVRjBACI3iebQ/bJf4mujMbwfLM0KevVNgJf1
 f5Rqf5xL8zYjZGZmRukyTKLm0Ds3A8ZoreKiWEoq0duB/ix4hL6c+qbEbjH10pKA0bqv
 c7xiCOgtGFv+vFeVK77fwHfYSP85A1uZaXja9pR+j/SP9EhMDKAbXnat2Sq6TmYRCeLV
 ealQ==
X-Gm-Message-State: AOAM532kFqV+R3h8Z6V7pDjBJtUHsk5sPhSBUEra9gusan1K83T1Rodw
 FCZM+8zeBEOpInzHGuLJb6VzHw==
X-Google-Smtp-Source: ABdhPJxxd7gWIsbfCYIPEz7NG3FjvS01GFW7aSmOlHcok8aGrenQft1MCuaHlreDug7QVzY2Ybcl0w==
X-Received: by 2002:a63:8c5a:: with SMTP id q26mr58143248pgn.312.1594423114697; 
 Fri, 10 Jul 2020 16:18:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
 by smtp.gmail.com with ESMTPSA id
 c14sm7296382pfj.82.2020.07.10.16.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 16:18:34 -0700 (PDT)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] irq: irqdomain: Export irq_domain_update_bus_token
Date: Fri, 10 Jul 2020 23:18:22 +0000
Message-Id: <20200710231824.60699-2-john.stultz@linaro.org>
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

Add export for irq_domain_update_bus_token() so that
we can allow drivers like the qcom-pdc driver to be
loadable as a module.

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
 kernel/irq/irqdomain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index a4c2c915511d..ca974d965fda 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -281,6 +281,7 @@ void irq_domain_update_bus_token(struct irq_domain *domain,
 
 	mutex_unlock(&irq_domain_mutex);
 }
+EXPORT_SYMBOL_GPL(irq_domain_update_bus_token);
 
 /**
  * irq_domain_add_simple() - Register an irq_domain and optionally map a range of irqs
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
