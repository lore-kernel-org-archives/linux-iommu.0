Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C2CC433F5
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 07:07:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30D3040917;
	Wed,  1 Jun 2022 07:07:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1P52lrPz8K7H; Wed,  1 Jun 2022 07:07:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EC15A408DF;
	Wed,  1 Jun 2022 07:07:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8730C0039;
	Wed,  1 Jun 2022 07:07:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9667C002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 07:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D799260E95
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 07:07:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dcyNSPoujDxF for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 07:07:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3BC8960E92
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 07:07:21 +0000 (UTC)
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-30c87716af6so8101027b3.22
 for <iommu@lists.linux-foundation.org>; Wed, 01 Jun 2022 00:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=lAKGb0lSp1bNkiKuJEzypZJll/zlqvzNkWZhsUnzLII=;
 b=MxzMPjivbh8UPmat16hBsiJmsp4xusaF/0CtHPB0ALBaGfGkOMgUpY8zIaxAPzAoDw
 Zl6+3kczb7YbM1rSrTx4wP/yTeTri3Jfl5+p6nJV1gEDeVI6VWvU3mpHCdD2qdiHVpXm
 wMjcXLMd29dryni46Yc0Gyx63Fpb+y0iXkhd060EohwmCgYoMEkLyxYIdeK67AN9X+XM
 l+63h8QaBbKw5BUcgNeyC9N3gk29Mj7R7JjXJI524jDGJ0i4z+1XeFvkV9Hj2umfL3Hv
 1c4OYmI4f54F2pIxXJZY02Znx1CwOy45KNza117L8OwoHgiV4UhpRUJ5V4rcFsZP52cT
 IB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=lAKGb0lSp1bNkiKuJEzypZJll/zlqvzNkWZhsUnzLII=;
 b=5Txg7uSIi1hXZjwCev5QrvZly/ctYDHbvAl6ehza0E9MZJdXBVTJz/3IPTKZcPqiE9
 S96FgKComf1zl6/XXT6nVeGNQji8UUn4+bHQW7wZTsunZFmglVvIYJJNPJkINFP0Lnnu
 n5NEMh1orstVAcDV3iqxw4F2i4vwLjtq4WYq6LUoEyg1Sd3xS6iuwojInq7LMsONNqoj
 hNI/jdss75hRTUyaTeZd3IvzW1XPg4AkIc4mL5pGwMdg9q+uEaKhMxQsS0UzzAtfWgf9
 EoCG/nj9jpd9JZ6K5Pjm1aOSdeglLuZXyPtPJOavM4VtmXNwu2zpD0kX/KzIdx5NjyIr
 rfig==
X-Gm-Message-State: AOAM531Ox0HOCIKo/g2QeaEZqP2HXpeO5CP9DjuDgIWWNfmeMey6oK6F
 qh/IcY/5ze5eQTg/YpHBYIUCi4F6swsBjlQ=
X-Google-Smtp-Source: ABdhPJw2d0Ydq+M1EKFVKl90vlnxKPzzmDAPtejNfxeIXjemJ3M++mFT/aYs9/m2glcq1N1UFunbFqMpHF9mXvo=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:f3aa:cafe:c20a:e136])
 (user=saravanak job=sendgmr) by 2002:a0d:d416:0:b0:30c:15f1:64d6 with SMTP id
 w22-20020a0dd416000000b0030c15f164d6mr23080655ywd.394.1654067240020; Wed, 01
 Jun 2022 00:07:20 -0700 (PDT)
Date: Wed,  1 Jun 2022 00:06:59 -0700
In-Reply-To: <20220601070707.3946847-1-saravanak@google.com>
Message-Id: <20220601070707.3946847-4-saravanak@google.com>
Mime-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 3/9] net: mdio: Delete usage of
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

Now that fw_devlink=on by default and fw_devlink supports interrupt
properties, the execution will never get to the point where
driver_deferred_probe_check_state() is called before the supplier has
probed successfully or before deferred probe timeout has expired.

So, delete the call and replace it with -ENODEV.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/net/mdio/fwnode_mdio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index 1c1584fca632..3e79c2c51929 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -47,9 +47,7 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 	 * just fall back to poll mode
 	 */
 	if (rc == -EPROBE_DEFER)
-		rc = driver_deferred_probe_check_state(&phy->mdio.dev);
-	if (rc == -EPROBE_DEFER)
-		return rc;
+		rc = -ENODEV;
 
 	if (rc > 0) {
 		phy->irq = rc;
-- 
2.36.1.255.ge46751e96f-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
