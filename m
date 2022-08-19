Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B28D6105
	for <iommu@lists.linux.dev>; Fri, 19 Aug 2022 22:16:29 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-334370e5ab9so97664827b3.22
        for <iommu@lists.linux.dev>; Fri, 19 Aug 2022 15:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=23aDVj4LlbfPkoiXqxbD0E4C7v4CoYUgh/84jy41NX0=;
        b=RfDBUV4Eoi6hUFddi87J/g/A5JBzLloY2dSMy9AH8SPOKlZLXQ//QBrA4oxiIqSu4a
         SIOdoHuaxKNOVbAJ7rfbvgzZsRd+lMbYJfODtYvKx4yHXzvVcTpentmBP17iRir2X+Q8
         FlckrSbhp4QISwdxhNXl36Ack8Ob/HkJo70k1gEcoGu4PVUev58lHdvwI4FChXgTC+y5
         LTE5zMaLdxyeGDcqGVqt2VvayphFlXKnYAmdOu8lbSbVtxx9pUAZ8nNJz8tK4YyOkHI/
         BohL+A06pQKGtVKh3c7R1TalLS7V2CuJgo894FA5LRde++POf9XldtYkSnPPXVrKJnl3
         5KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=23aDVj4LlbfPkoiXqxbD0E4C7v4CoYUgh/84jy41NX0=;
        b=E4QA36SCSAYIwVIpS52KD8dD0RpPYhDfcisGcz397Damzp77njKSkuH2Zt62WMwDQL
         uA14FJ9oExgv5YPMHbSgP3x718FKR9WQNqVAbL8MTqKzM3bxdmreYdwaV4Yr0nKby5rz
         SL1wV//Nld3tqWylasYbQROzAW9u4YMYu4g7r9/VqcMLSS8TRcn5/AynEwgjChDByOxE
         daBd10Q8T9xEiy8XD18Fj2YasadCgRlYX7JL+tFVHcGtX6BqbPQLZh6oOt+tm/QIkmw3
         57HUS8R94h6RC/H8fBxKKRRT8MKCKy6DFMF2zwtUfht78pyFOaKcCVu2TULY+xUKAFvI
         v49g==
X-Gm-Message-State: ACgBeo2+8LxPZCBZDYpY6yJ0inHZAYwbeVvp5Fw1C9NPzUJYaIeBI+V/
	Wo26eHo6Gjo3rjGb8gxbN+ZVRb++x68I0YY=
X-Google-Smtp-Source: AA6agR6A+xqItbXSEK4uHJ0mFi1QE/So6yke4k7KdQfN6tbP1gpuJnanRFbNSnpcIO10ajqPyRqVifalVRrScOo=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f93e:7b61:ce3d:5b06])
 (user=saravanak job=sendgmr) by 2002:a25:bc52:0:b0:67e:e3c:1453 with SMTP id
 d18-20020a25bc52000000b0067e0e3c1453mr9778933ybk.121.1660947388574; Fri, 19
 Aug 2022 15:16:28 -0700 (PDT)
Date: Fri, 19 Aug 2022 15:16:13 -0700
In-Reply-To: <20220819221616.2107893-1-saravanak@google.com>
Message-Id: <20220819221616.2107893-4-saravanak@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20220819221616.2107893-1-saravanak@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2 3/4] Revert "PM: domains: Delete usage of driver_deferred_probe_check_state()"
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saravana Kannan <saravanak@google.com>
Cc: Peng Fan <peng.fan@nxp.com>, Luca Weiss <luca.weiss@fairphone.com>, 
	Doug Anderson <dianders@chromium.org>, Colin Foster <colin.foster@in-advantage.com>, 
	Tony Lindgren <tony@atomide.com>, Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Jean-Philippe Brucker <jpb@kernel.org>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This reverts commit 5a46079a96451cfb15e4f5f01f73f7ba24ef851a.

Quite a few issues have been reported [1][2][3][4][5][6] on the original
commit. While about half of them have been fixed, I'll need to fix the rest
before driver_deferred_probe_check_state() can be deleted. So, revert the
deletion for now.

[1] - https://lore.kernel.org/all/DU0PR04MB941735271F45C716342D0410886B9@DU0PR04MB9417.eurprd04.prod.outlook.com/
[2] - https://lore.kernel.org/all/CM6REZS9Z8AC.2KCR9N3EFLNQR@otso/
[3] - https://lore.kernel.org/all/CAD=FV=XYVwaXZxqUKAuM5c7NiVjFz5C6m6gAHSJ7rBXBF94_Tg@mail.gmail.com/
[4] - https://lore.kernel.org/all/Yvpd2pwUJGp7R+YE@euler/
[5] - https://lore.kernel.org/lkml/20220601070707.3946847-2-saravanak@google.com/
[6] - https://lore.kernel.org/all/CA+G9fYt_cc5SiNv1Vbse=HYY_+uc+9OYPZuJ-x59bROSaLN6fw@mail.gmail.com/

Fixes: 5a46079a9645 ("PM: domains: Delete usage of driver_deferred_probe_check_state()")
Reported-by: Peng Fan <peng.fan@nxp.com>
Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Reported-by: Doug Anderson <dianders@chromium.org>
Reported-by: Colin Foster <colin.foster@in-advantage.com>
Reported-by: Tony Lindgren <tony@atomide.com>
Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5a2e0232862e..55a10e6d4e2a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2733,7 +2733,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 		mutex_unlock(&gpd_list_lock);
 		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
 			__func__, PTR_ERR(pd));
-		return -ENODEV;
+		return driver_deferred_probe_check_state(base_dev);
 	}
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
-- 
2.37.1.595.g718a3a8f04-goog

