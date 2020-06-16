Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9BCC433E3
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5501207D3
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 06:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aIIoFqiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5501207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A17F925D1D;
	Tue, 16 Jun 2020 06:13:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OhKTk-K7yxce; Tue, 16 Jun 2020 06:13:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5116125AD0;
	Tue, 16 Jun 2020 06:13:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38981C0888;
	Tue, 16 Jun 2020 06:13:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96406C016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 06:13:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9216988CBB
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 06:13:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mkuAqYc+fbLh for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 06:13:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E7D1B88CB8
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 06:13:43 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id y18so7922056plr.4
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 23:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=h4JqKpoTJwOLVa4Di6JSd/Ph+43PAaMLhE3KrwrB/cQ=;
 b=aIIoFqiwCuM3dby19TgymneGR+eeoT1Wxy2TPpRkJqUdrynkdRP8+CNDZi8knMQXSA
 f6Bnkylgm0SyUXod2iE5akD5Gq/nK9BJ96sFopeuj+cDyIrPembwe8QM5m9mgdTOvT/p
 95P3wC7lRmPEoi2hm5fpeVSFDjBKYxmhYTmzVw3juKPimfKhaq0XCfwXn9MoK/NPKS8v
 fgds0I21HWcIzLuqkAxiS2DAXTEESOnA37rEYOfIy2DG1XAnGRh/eAXCdqoPN1mDr2EJ
 gAtL26MemRtwwpZCy39jr2cpC4DNJ+Q5ORFGwo52pyKJV0BZ9VXCJSBmyLvzLfGUCnLK
 4aVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=h4JqKpoTJwOLVa4Di6JSd/Ph+43PAaMLhE3KrwrB/cQ=;
 b=jyZjYNiGrZF2jD2qis3jOb5c98LEvDwub1wFAgt5RdR8FE1WE0UOtw+rQUQEhAe0Er
 GUwxj+1zoIkrSqwf8ak8nJEIQ9exY8guqUKPakNnk6/XHjmd/NKENmKJqDuEjTj1SZjc
 7DYTFpGBy9Tg2gkTEAhD9K8LZXBSNZfTv5GFMl8gmDh/I8MccY+UlkqaaWn/t9aVSd/2
 nqFJLW9C8E3dImmGyLEpQKoEmg9QUTV41BAIXZfwJ4HyCJF1fd4Afzr6IaZnplnBhhV8
 3FBfGo0Rb+Yjw1hwEe5NamSZeVXldWWuOT6QxRE3v3/lIzpbN/cGKYnljcVLXx0m6hYT
 TTNw==
X-Gm-Message-State: AOAM531T+OpzgQWpPVfJ2DmLwqRbzQnx0M7HRy77oPu9n2gSrTN51hZx
 2GQNsCaNVArGLLlddUNyYqmXHQ==
X-Google-Smtp-Source: ABdhPJwzygD/WHkWLyQJ6iGsnCwTqfRIFtsc++PcBZQkjKRMfUmeu8vpzS8kFNaT35Xwy6HpTPU4IQ==
X-Received: by 2002:a17:90b:46ca:: with SMTP id
 jx10mr1362107pjb.3.1592288023527; 
 Mon, 15 Jun 2020 23:13:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
 by smtp.gmail.com with ESMTPSA id
 i26sm15642032pfo.0.2020.06.15.23.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 23:13:43 -0700 (PDT)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH 1/5] irq: irqdomain: Export irq_domain_update_bus_token
Date: Tue, 16 Jun 2020 06:13:34 +0000
Message-Id: <20200616061338.109499-2-john.stultz@linaro.org>
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
