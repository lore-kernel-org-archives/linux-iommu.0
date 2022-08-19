Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7169B6105
	for <iommu@lists.linux.dev>; Fri, 19 Aug 2022 22:16:20 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-3328a211611so96674547b3.5
        for <iommu@lists.linux.dev>; Fri, 19 Aug 2022 15:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=t5NMSCOXrbG0Qu3FAuWbHVmFLW5D0kFYreRH8zEIjV8=;
        b=gWwBFfQzdDln3NwaMOLGITORJZRdOHNWfwYN4lk8hEGSpzD3nf0hp2vwhR0ehr9i2w
         R29Hm5/+BlRY+39ZdmD1y+vr3jEPlfnvwSvpVelQwQO1O7uxHZYyvePk913Fc2Fz55iX
         QjzGWD5mo4bmDesrjxJb2EwyBMXHWwWyQyFGrGuWY2g2Dc8APPCBlo+u1d7Cd73v12ib
         1Xy8VHJ3p5JBMqH9WrjSqdKP7zkHUsHt6QG1+x689dosBCL7ZjXPRMDXAxU6K3HdAbOj
         4wQEDnRMFUt+HthMu1axqnRVGLRFtqAAl07/bp2Re7kFQ2Bm7Z0Zbz/5vPJvBClJV19J
         Ff2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=t5NMSCOXrbG0Qu3FAuWbHVmFLW5D0kFYreRH8zEIjV8=;
        b=DqSfWWAL7BKaqqfn7rtvc5oafPqEjydzuyRYKgdR334WKwlqYZsUuVxRmZpyFatdBH
         Wl3K/b//kzWLFdzbypgoaOcO8opbUyKqFisc6UX6BFpM95xpOeyPIj2qdVmVDfctutZw
         YcvHdGB4OwBAGyx4JbxuhAJtO4U2NsrcF164gWrm+z0WB+TbtrVNjG3fuJl+N7wh7YmD
         UiVIe5WNSOrh5X/WFhNpJyea8VcSkD1UM7USAb9pd3sbkCEtqegdzK+t5LM2HcvY4WD7
         kOTFVh3RgoOYiDSpATMXnt4gWlI47LyoCnZSJ/L9/oBfN07hh4FMU2t8c6I9ftw0N5aj
         P1vg==
X-Gm-Message-State: ACgBeo1alB3imj7c3a13C3/mnQRY+98q9eNDZYJi2Y+iZ/g4qpAdvJFo
	wkcQPBZkV1ovXzD+swOvJowsdjOHwQ21pbU=
X-Google-Smtp-Source: AA6agR4EX1OBULn40ut/MjDpJQQkX96WwHfTFwXQk6CpU2kNVzlbku/C8FdhqvNBCu/ZTTWVaRDqauv3HvTZg1M=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f93e:7b61:ce3d:5b06])
 (user=saravanak job=sendgmr) by 2002:a81:d353:0:b0:31e:2888:93a1 with SMTP id
 d19-20020a81d353000000b0031e288893a1mr9560863ywl.498.1660947379483; Fri, 19
 Aug 2022 15:16:19 -0700 (PDT)
Date: Fri, 19 Aug 2022 15:16:10 -0700
Message-Id: <20220819221616.2107893-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2 0/4] Bring back driver_deferred_probe_check_state() for now
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

A bunch of issues have been reported in the original series[1] that removed
driver_deferred_probe_check_state(). While most of the issues have been
fixed in a new series that improved fw_devlink [2], there are still a few
unresolved issues I need to address.

So let's bring back driver_deferred_probe_check_state() until the other
issues are resolved.

Greg,

Can we get this into 6.0-rcX please?

-Saravana

[1] - https://lore.kernel.org/lkml/20220601070707.3946847-1-saravanak@google.com/
[2] - https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@google.com/

v1 -> v2:
- Added a revert of the iommu change too.

Saravana Kannan (4):
  Revert "driver core: Delete driver_deferred_probe_check_state()"
  Revert "net: mdio: Delete usage of
    driver_deferred_probe_check_state()"
  Revert "PM: domains: Delete usage of
    driver_deferred_probe_check_state()"
  Revert "iommu/of: Delete usage of driver_deferred_probe_check_state()"

 drivers/base/dd.c              | 30 ++++++++++++++++++++++++++++++
 drivers/base/power/domain.c    |  2 +-
 drivers/iommu/of_iommu.c       |  2 +-
 drivers/net/mdio/fwnode_mdio.c |  4 +++-
 include/linux/device/driver.h  |  1 +
 5 files changed, 36 insertions(+), 3 deletions(-)

-- 
2.37.1.595.g718a3a8f04-goog

