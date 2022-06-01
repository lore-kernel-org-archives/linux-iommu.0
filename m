Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE50CC433F5
	for <iommu@archiver.kernel.org>; Wed,  1 Jun 2022 07:07:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7292381470;
	Wed,  1 Jun 2022 07:07:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6sNjNmg6jSSp; Wed,  1 Jun 2022 07:07:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6B7D5814B8;
	Wed,  1 Jun 2022 07:07:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4437DC0039;
	Wed,  1 Jun 2022 07:07:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37403C002D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 07:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 15BDB40918
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 07:07:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lRfYMPJHYmOT for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jun 2022 07:07:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 43DD640902
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jun 2022 07:07:27 +0000 (UTC)
Received: by mail-yb1-xb4a.google.com with SMTP id
 k73-20020a25244c000000b0065ca88b381aso742184ybk.2
 for <iommu@lists.linux-foundation.org>; Wed, 01 Jun 2022 00:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=dQEtI1CAczIBuvDz3GZ7U2zzA60s6PfFxMj/9gjiRQI=;
 b=dR7RpwH0OGQgdq5IkjUp0wI+kkXSRbNo+z8wKuVYmhF5jBwh9y6txlMuL3p9oOu2kZ
 wPPBUSqq/aYBuqa517o9bAD77BHGWgYWs4stcLD/c5P5I4GNJdZuDvwIt+YBFb31fdLB
 6zUXWtjdhyChYQDoJ2zR1S2tqwWpzQnMhQv0CP3yR6ExhViYXE39N0bMEhjNOlxU33zZ
 EdAp5EoXLEUNyiLkQ+0mYMQCtOLO1Y/nznitQm8gq3O56AfLSY2rXnJOF6aeB3s/9Rue
 1UCDaLkk9f2RRDPnMVqUDjfwwIppZ6DCFLXO7D9pTdLF04gvr1TYoFoAEKDgJaikerxa
 Zw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=dQEtI1CAczIBuvDz3GZ7U2zzA60s6PfFxMj/9gjiRQI=;
 b=Y9nrIr0JhvLQM3rDp459/zKGzingRIR6qKT1tdhL0jb/3LDdyBuEC37SRP1mOl4t8T
 cInVumvpNpiYzRbBfCMek+HUpUfEhh9FDXwGEp9Idkz/J/J+HWjCNb3xeFfkMBgHUDLu
 JRxPl2lVyjX5vnaUXq+QDpzv4XAVLUCvB/8hByQ+sI8xykF8LAxDWOmxEP6RBPfPsLcz
 wtgsuv60Y2Momrbw9tT5NzN5aNDyOTdwFuNxrOuWAcDN3MiIW+MhmCx8VzAGwJeIJQP/
 NKcgI7dc4btB80zg9+KiKk1z3riPoxJwtkhRmXAxeQiPXLNPOqqlqnykedeXlZ/hh+o2
 vqcg==
X-Gm-Message-State: AOAM533CCdO7xAeqEBvCi6CArRYaJzrcBZR8/paFEOK0QyJsRlc91dN0
 v4bY05CBnANIMisVHwp6fRYr3onhjFgfyds=
X-Google-Smtp-Source: ABdhPJzjzqJGs64NvAdSlO/KVC/8uBUgQ7KmMn/05KCKbRpPaPfy2ffCOi3FUKYkp1MN38cKmElXlMfsooa1FsE=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:f3aa:cafe:c20a:e136])
 (user=saravanak job=sendgmr) by 2002:a0d:cc89:0:b0:30b:14ee:6329 with SMTP id
 o131-20020a0dcc89000000b0030b14ee6329mr25787073ywd.38.1654067246121; Wed, 01
 Jun 2022 00:07:26 -0700 (PDT)
Date: Wed,  1 Jun 2022 00:07:01 -0700
In-Reply-To: <20220601070707.3946847-1-saravanak@google.com>
Message-Id: <20220601070707.3946847-6-saravanak@google.com>
Mime-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 5/9] net: ipconfig: Relax fw_devlink if we need to mount a
 network rootfs
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

If there are network devices that could probe without some of their
suppliers probing and those network devices are needed to mount a
network rootfs, then fw_devlink=on might break that usecase by blocking
the network devices from probing by the time IP auto config starts.

So, if no network devices are available when IP auto config is enabled
and we have a network rootfs, make sure fw_devlink doesn't block the
probing of any device that has a driver and then retry finding a network
device.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 net/ipv4/ipconfig.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 9d41d5d5cd1e..2342debd7066 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1434,6 +1434,7 @@ __be32 __init root_nfs_parse_addr(char *name)
 static int __init wait_for_devices(void)
 {
 	int i;
+	bool try_init_devs = true;
 
 	for (i = 0; i < DEVICE_WAIT_MAX; i++) {
 		struct net_device *dev;
@@ -1452,6 +1453,11 @@ static int __init wait_for_devices(void)
 		rtnl_unlock();
 		if (found)
 			return 0;
+		if (try_init_devs &&
+		    (ROOT_DEV == Root_NFS || ROOT_DEV == Root_CIFS)) {
+			try_init_devs = false;
+			wait_for_init_devices_probe();
+		}
 		ssleep(1);
 	}
 	return -ENODEV;
-- 
2.36.1.255.ge46751e96f-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
