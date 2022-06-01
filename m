Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1871BC433F5
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 07:07:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C02EE40127;
	Wed,  1 Jun 2022 07:07:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A0e6etKnyp98; Wed,  1 Jun 2022 07:07:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BD2B040470;
	Wed,  1 Jun 2022 07:07:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97120C0039;
	Wed,  1 Jun 2022 07:07:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95014C002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 07:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7542D408DF
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 07:07:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QH7bDRo-r5Qb for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 07:07:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1DCE408F8
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 07:07:18 +0000 (UTC)
Received: by mail-yb1-xb49.google.com with SMTP id
 b6-20020a252e46000000b0065d5168f3f0so691132ybn.21
 for <iommu@lists.linux-foundation.org>; Wed, 01 Jun 2022 00:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=s1gsps1j5Ayup9Swk+EXc2kGgnx5nhOnARnKuAKYXv0=;
 b=ch5YvNSZbFFvNIFbdMWgLJY52Qnpd1NtoLMcbn1rQ4YPVTxYHbxywFyCPzAP3/GdOE
 KdsrLMveolqX+jFl+h4mIER3kCKjzchkhaA5vc1KaGo6eRizAhbS9sDWsqPUMTwf+grp
 U7krsYB7Uq2sN+6D6tVvi/PXDklkCU0WIpKMDNVMY9ZLGTpoYdnVYedYDONJOBI2h8x4
 UIe8XKZmJKhAXeerPesRykxXMFw39fsB+kV+KjPQH/ddcGxWfonhfMLcu+h3NXhKRmfi
 /YqfTTroCVXlQaiebFvlX5bBi+H7w29MdlZQ5F7xCu5rWKB+fxWysM0OGOqJxtn145ed
 E/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=s1gsps1j5Ayup9Swk+EXc2kGgnx5nhOnARnKuAKYXv0=;
 b=2KmlF2X/F/5DMJRsLqlVihJ9lCZkGGTelxY5z2vc+VtNqxmR/yqHFER5O6xFUABt20
 Y7Zz0bXCNfd3Ap1ZBmAkkxaaLZ0pY5yYlgjuHP9zH5PXaKwkKktwb55UnlSMJAsN9i0n
 9ZqPvps4740OFLTUOAUzteZ+b/0MQq/Vfwt95DINTaX945CWqFHtNJHFvcTereO4dydS
 7Qnni+cfrrmTpxQCTpfUSih6yRKz1jdW1elVqBlP2hKRHk7sFQiAtq0VaROip8BR8Pxi
 cSGfkPuT1OyE4qdua/NPFl8qOHAIXz9bOen8cleqe8MZ4RcaFmwivJLzSTqxi3bOTft1
 fdNg==
X-Gm-Message-State: AOAM530QyrP2Jew/Mt9g+yMGC9YMG+9VsrOjxDLOJ5213zaBVIZyqwPr
 eV6BaX3pd2KoPnayQxCKHkk0HUslwNjEPHY=
X-Google-Smtp-Source: ABdhPJzzpyv5qo/qKlMQeYH+3Z6qXGo9Ac2yEg0ZjA7JAUgPsaNr7W/YlAhXWO4zqrhgdu1gO/8toNkzEz6BwXE=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:f3aa:cafe:c20a:e136])
 (user=saravanak job=sendgmr) by 2002:a05:6902:2ce:b0:64b:9bbd:34fa with SMTP
 id w14-20020a05690202ce00b0064b9bbd34famr60927760ybh.440.1654067237399; Wed,
 01 Jun 2022 00:07:17 -0700 (PDT)
Date: Wed,  1 Jun 2022 00:06:58 -0700
In-Reply-To: <20220601070707.3946847-1-saravanak@google.com>
Message-Id: <20220601070707.3946847-3-saravanak@google.com>
Mime-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 2/9] pinctrl: devicetree: Delete usage of
 driver_deferred_probe_check_state()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
 Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Linus Walleij <linus.walleij@linaro.org>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, 
 David Ahern <dsahern@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, linux-pm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, iommu@lists.linux-foundation.org,
 kernel-team@android.com
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Now that fw_devlink=on by default and fw_devlink supports
"pinctrl-[0-8]" property, the execution will never get to the point
where driver_deferred_probe_check_state() is called before the supplier
has probed successfully or before deferred probe timeout has expired.

So, delete the call and replace it with -ENODEV.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/pinctrl/devicetree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index 3fb238714718..ef898ee8ca6b 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -129,7 +129,7 @@ static int dt_to_map_one_config(struct pinctrl *p,
 		np_pctldev = of_get_next_parent(np_pctldev);
 		if (!np_pctldev || of_node_is_root(np_pctldev)) {
 			of_node_put(np_pctldev);
-			ret = driver_deferred_probe_check_state(p->dev);
+			ret = -ENODEV;
 			/* keep deferring if modules are enabled */
 			if (IS_ENABLED(CONFIG_MODULES) && !allow_default && ret < 0)
 				ret = -EPROBE_DEFER;
-- 
2.36.1.255.ge46751e96f-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
