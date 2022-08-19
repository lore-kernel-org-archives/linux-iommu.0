Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E746105
	for <iommu@lists.linux.dev>; Fri, 19 Aug 2022 22:16:32 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-335cf0fd1a4so97280587b3.11
        for <iommu@lists.linux.dev>; Fri, 19 Aug 2022 15:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=H3YEiHHCZDHfvJiU4fCYVtnbVB8iHyjPM7ELjaj28Ew=;
        b=X1U73b0XniNLU7Z952Uoe4oLLlOQuH9fMoxIo3YE8wTvISBipZU3kbSsA/PpZc74b9
         GKGrN3RRsS65zQ/iiGgHDkFgLoHu+HT15JxvGOx9hJ2PV56mfIi6fXTua6T4tCzBZCDs
         pidzBZcxXFnAUE6H041z//D5yM40NWB78f6EufBqHmtQf2Fy2jYoy7SMHxtXqD8J18Jl
         tglJU4xpK/iRl2mW5tY+0pgOj4nH9Bx5lesRwnijThCj0o6tZ7h84PrI8aDfHNjuuotw
         33+iubcVMVmM0KnScNcfs0uK//EhpI5sVYu65TPan5KCq2k7mlKkYFPNxSojzIFEnPuE
         wSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=H3YEiHHCZDHfvJiU4fCYVtnbVB8iHyjPM7ELjaj28Ew=;
        b=K2g54lTlqhXFZoYPGyBWBENbBtEy9Gg0qf2jcA10pTZiTx96jsJGnim8BeLayyRJXU
         ISzbHNK0nh1oexFGu/L1gNd5QsUNEC6WyiWz5VhTpYYOAIidBRdAxviiQyq3WYvAAeiB
         jjQs1wfY2yjrXaop+BnwKcMxxbM60ynGejP81iqFUicUlN83UX28CozjarUaQ/suMoaT
         nNntO7YIHUyoH3/Q7ln49+M9jK//UExP7VVWe6EXa1Sa7FH9qcizA/BPEYvOvVBMiUjk
         D0NCNVWrvXzKOc9zu2+RFa0tRjScMNriVWoo9riVtRX4uPilgPBpU06e+E7WKNjqVBHO
         vuwg==
X-Gm-Message-State: ACgBeo2HS867b2+t7V3n6yQNB8rqK1Rk1fflg6Ea1LeTZQev/ID6tNaR
	/5RImEc3y79LHq2qnNHeAdtJSt7q8CMSLW8=
X-Google-Smtp-Source: AA6agR6s7O9ks9P+6MMRLsKupYiohHddIyehPE2rdJmt/AJwJ41rH2q/2hZo31rpF1++hMgFEDboETrWBMyKu5U=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:f93e:7b61:ce3d:5b06])
 (user=saravanak job=sendgmr) by 2002:a81:5744:0:b0:333:7505:5bca with SMTP id
 l65-20020a815744000000b0033375055bcamr9459605ywb.315.1660947391375; Fri, 19
 Aug 2022 15:16:31 -0700 (PDT)
Date: Fri, 19 Aug 2022 15:16:14 -0700
In-Reply-To: <20220819221616.2107893-1-saravanak@google.com>
Message-Id: <20220819221616.2107893-5-saravanak@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20220819221616.2107893-1-saravanak@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2 4/4] Revert "iommu/of: Delete usage of driver_deferred_probe_check_state()"
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

This reverts commit b09796d528bbf06e3e10a4a8f78038719da7ebc6.

An issue was reported[1] on the original commit. I'll need to address that
before I can delete the use of driver_deferred_probe_check_state().  So,
bring it back for now.

[1] - https://lore.kernel.org/lkml/4799738.LvFx2qVVIh@steina-w/

Fixes: b09796d528bb ("iommu/of: Delete usage of driver_deferred_probe_check_state()")
Reported-by: Jean-Philippe Brucker <jpb@kernel.org>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/iommu/of_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 41f4eb005219..5696314ae69e 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -40,7 +40,7 @@ static int of_iommu_xlate(struct device *dev,
 	 * a proper probe-ordering dependency mechanism in future.
 	 */
 	if (!ops)
-		return -ENODEV;
+		return driver_deferred_probe_check_state(dev);
 
 	if (!try_module_get(ops->owner))
 		return -ENODEV;
-- 
2.37.1.595.g718a3a8f04-goog

