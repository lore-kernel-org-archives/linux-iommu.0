Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEADC433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 08:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48C5241A4C;
	Thu, 23 Jun 2022 08:08:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 48C5241A4C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=ZChn5ahW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kK-stNh1kpEr; Thu, 23 Jun 2022 08:08:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BE8B941A5B;
	Thu, 23 Jun 2022 08:08:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE8B941A5B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A49A1C0032;
	Thu, 23 Jun 2022 08:08:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 056F7C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C6826846FC
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:08:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6826846FC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=ZChn5ahW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id upqOSaiG7Ttj for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 08:08:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 16303846F9
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16303846F9
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 08:08:14 +0000 (UTC)
Received: by mail-yb1-xb49.google.com with SMTP id
 v74-20020a252f4d000000b00668b16baa8bso15183813ybv.23
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 01:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=s9ND+o/2c+yLLqaQvSasSfGJRux3sdgC6yXqcCSmvC4=;
 b=ZChn5ahWF9VYjMaZyt75gRGdRRm9LYwWwkstPyFagKQEAyvitoOq9K9PtewRoCDhSM
 tAkvp8C+6vLvaAyusyWYI21A6zVjKa5/J8gAEms2VIQwhv3yjw+3NCR2DEx9uxGeN2QJ
 rS/zNPMzlbhn4YaJRa/lxLtaxH9A7m6NK3ZdXGOgoyyBfWLvx+PDntcmTJFeXZvqRilJ
 IYZVG4M+dhM5VQEV4SPScrfViR40Ehpl3D5iBw+7OCCiUX0dCoDDiuZRzruyfOzLI4Ou
 MQ3GXEQicXFecGuaW/OqF2wd1VI2EawxBbtZm4yAP8J1jKc/GtvpSLqNqDM4p5NK5zZS
 759w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=s9ND+o/2c+yLLqaQvSasSfGJRux3sdgC6yXqcCSmvC4=;
 b=w6vsmTvjfa/csrYTOBA4S/z/aZ362aD5NSQk2pyKHA4b4YQospLtfn614gQj8qmp5r
 zIBbJV/fpindPQ5ygPIiByDOCqKPm6MRxy6UVPtwXsBJVaxP4+nct/vouBwULX69Ajwk
 3UMvRwW+mHM+Zn8I+fihoyDqHxPRzyZL9Mwgg0Bv/SW6SowzX8nLNClTOua9jvCMvAWE
 TY0OyjnDDdMNHzpnpohNo5vJ5a4n7ls9RBRcbui1nqxxqYEoDcmRzf/mLCdJ2XHawdOt
 HrxT2GtdF5B6wcu8HirvvI2nU5n5zyx+Ga5tRwr48SWsbo9YYVjoBkKn6UTxUncD2s7v
 0SHw==
X-Gm-Message-State: AJIora8LZRt9k1c8mm+e+1XgT9ZLu1jAwztj7G1jfta0WJC65oAIELAa
 MRfIZMzuaBZd3II2g/SlIPxOvarlGRa3dmk=
X-Google-Smtp-Source: AGRyM1sE5BByBONr09uTGuYvikqMrbKKy57XSWWEHEYrg9GZbQPbgu/DImBH3QXHzvbDpX1ROMvYGcf5ilhwWN4=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:8b2d:9894:73a4:8e1f])
 (user=saravanak job=sendgmr) by 2002:a81:7007:0:b0:317:912a:32a3 with SMTP id
 l7-20020a817007000000b00317912a32a3mr9395945ywc.194.1655971692862; Thu, 23
 Jun 2022 01:08:12 -0700 (PDT)
Date: Thu, 23 Jun 2022 01:03:43 -0700
In-Reply-To: <20220623080344.783549-1-saravanak@google.com>
Message-Id: <20220623080344.783549-3-saravanak@google.com>
Mime-Version: 1.0
References: <20220623080344.783549-1-saravanak@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 2/2] of: base: Avoid console probe delay when
 fw_devlink.strict=1
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: andrew lunn <andrew@lunn.ch>, peng fan <peng.fan@nxp.com>,
 devicetree@vger.kernel.org, linus walleij <linus.walleij@linaro.org>,
 ulf hansson <ulf.hansson@linaro.org>, eric dumazet <edumazet@google.com>,
 pavel machek <pavel@ucw.cz>, will deacon <will@kernel.org>,
 sascha hauer <sha@pengutronix.de>, kevin hilman <khilman@kernel.org>,
 russell king <linux@armlinux.org.uk>, linux-acpi@vger.kernel.org,
 jakub kicinski <kuba@kernel.org>, paolo abeni <pabeni@redhat.com>,
 kernel-team@android.com, len brown <len.brown@intel.com>,
 linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
 hideaki yoshifuji <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 david ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kernel@pengutronix.de,
 "david s. miller" <davem@davemloft.net>,
 heiner kallweit <hkallweit1@gmail.com>
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

Commit 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
enabled iommus and dmas dependency enforcement by default. On some
systems, this caused the console device's probe to get delayed until the
deferred_probe_timeout expires.

We need consoles to work as soon as possible, so mark the console device
node with FWNODE_FLAG_BEST_EFFORT so that fw_delink knows not to delay
the probe of the console device for suppliers without drivers. The
driver can then make the decision on where it can probe without those
suppliers or defer its probe.

Fixes: 71066545b48e ("driver core: Set fw_devlink.strict=1 by default")
Reported-by: Sascha Hauer <sha@pengutronix.de>
Reported-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Tested-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/of/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d4f98c8469ed..a19cd0c73644 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1919,6 +1919,8 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 			of_property_read_string(of_aliases, "stdout", &name);
 		if (name)
 			of_stdout = of_find_node_opts_by_path(name, &of_stdout_options);
+		if (of_stdout)
+			of_stdout->fwnode.flags |= FWNODE_FLAG_BEST_EFFORT;
 	}
 
 	if (!of_aliases)
-- 
2.37.0.rc0.161.g10f37bed90-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
