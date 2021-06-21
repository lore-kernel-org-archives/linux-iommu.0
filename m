Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE60C49EA5
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 23:53:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E8B61351
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 23:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E8B61351
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41C75607D8;
	Mon, 21 Jun 2021 23:53:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pNPggw19nQAW; Mon, 21 Jun 2021 23:53:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2B48660622;
	Mon, 21 Jun 2021 23:53:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 085D2C001A;
	Mon, 21 Jun 2021 23:53:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A636C0023
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 23:53:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5369401FF
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 23:53:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JAtxOUuTXO2G for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 23:53:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3CEED400DD
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 23:53:11 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id y14so4029706pgs.12
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 16:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x4ITCUhU/nAWeClxOuhPcTZrOECIOg+GaezMrYjqOog=;
 b=BwLqztGB8hIbqFPIG2iz+F3ycDuDHHtj9AyQbRD6lqT60SE8LExVuskXB76EYzXjVG
 lca+htEYcRd7QfmkKugvc8c/OcxzCpyT3q8iyt7e0nJep78c/HVq1/rqRuwnfVRpXWTL
 jgfxiTc8Dit5C0AJEdXOVb+ofslWLH/3o7/Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x4ITCUhU/nAWeClxOuhPcTZrOECIOg+GaezMrYjqOog=;
 b=TPMq2bi1p4xeRgyomURs0O+1FY42TbicM1fFiKNbWzExbzWXIHxSVvVJ0+/WdmS7VQ
 MqVpyzJDN/0FmRLXaVIXqqW9HPlfeXFb9QUJg0jmZKddt9B3cVB6ex/F7u9JuImr5F0Z
 BQRUguBzmf37ys2bDTzd0q4pWmMeN2DuZM4kg4IMjfIlVhKO6BogWUqNTU8nMTQxDsv+
 Rkz0Mw6zMsr5Rx9xloHesvyMxQkfI0+k2sbhwtCOvXSCfjW1y9eyi3m6vvoABWiPa1wl
 hMHCT8rQi48oO7vnOeUNYzyUbnpQvNrSl79AwJpNSaOOi3S1OmqSWxZfNJP6m4VF4dKV
 NvJA==
X-Gm-Message-State: AOAM532wbJBZPUwBeGQu6b+MZ4D0li1qLeoVrBJIIyrGpp0rtU8uSE1V
 C/8dwQDUlBX2oJvSVe71xKtLTg==
X-Google-Smtp-Source: ABdhPJwZ1ajw+esBAxjNDymFx29gIQcnd4y55FxkQu9BFhGgtAStKyAK4b4QtnH9CUPyj40m+KG3Dg==
X-Received: by 2002:aa7:9729:0:b029:2ff:1e52:e284 with SMTP id
 k9-20020aa797290000b02902ff1e52e284mr675748pfg.71.1624319590637; 
 Mon, 21 Jun 2021 16:53:10 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com
 ([2620:15c:202:201:bdc1:a4b1:b06e:91d1])
 by smtp.gmail.com with ESMTPSA id s27sm4339663pfg.169.2021.06.21.16.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 16:53:10 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, rafael.j.wysocki@intel.com,
 will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
 adrian.hunter@intel.com, bhelgaas@google.com
Subject: [PATCH 1/6] drivers: base: Add the concept of "pre_probe" to drivers
Date: Mon, 21 Jun 2021 16:52:43 -0700
Message-Id: <20210621165230.1.Id4ee5788c993294f66542721fca7719c00a5d8f3@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210621235248.2521620-1-dianders@chromium.org>
References: <20210621235248.2521620-1-dianders@chromium.org>
MIME-Version: 1.0
Cc: robdclark@chromium.org, linux-kernel@vger.kernel.org, saravanak@google.com,
 linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
 quic_c_gdjako@quicinc.com, Douglas Anderson <dianders@chromium.org>,
 iommu@lists.linux-foundation.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-pci@vger.kernel.org, joel@joelfernandes.org, rajatja@google.com,
 sonnyrao@chromium.org, vbadigan@codeaurora.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Right now things are a bit awkward if a driver would like a chance to
run before some of the more "automatic" things (pinctrl, DMA, IOMMUs,
...) happen to a device. This patch aims to fix that problem by
introducing the concept of a "pre_probe" function that drivers can
implement to run before the "automatic" stuff.

Why would you want to run before the "automatic" stuff? The incentive
in my case is that I want to be able to fill in some boolean flags in
the "struct device" before the IOMMU init runs. It appears that the
strictness vs. non-strictness of a device's iommu config is determined
once at init time and can't be changed afterwards. However, I would
like to avoid hardcoding the rules for strictness in the IOMMU
driver. Instead I'd like to let individual drivers be able to make
informed decisions about the appropriateness of strictness
vs. non-strictness.

The desire for running code pre_probe is likely not limited to my use
case. I believe that the list "qcom_smmu_client_of_match" is hacked
into the iommu driver specifically because there was no real good
framework for this. For the existing list it wasn't _quite_ as ugly as
my needs since the decision could be made solely on compatible string,
but it still feels like it would have been better for individual
drivers to run code and setup some state rather than coding up a big
list in the IOMMU driver.

Even without this patch, I believe it is possible for a driver to run
before the "automatic" things by registering for
"BUS_NOTIFY_BIND_DRIVER" in its init call, though I haven't personally
tested this. Using the notifier is a bit awkward, though, and I'd
rather avoid it. Also, using "BUS_NOTIFY_BIND_DRIVER" would require
drivers to stop using the convenience module_platform_driver() helper
and roll a bunch of boilerplate code.

NOTE: the pre_probe here is listed in the driver structure. As a side
effect of this it will be passed a "struct device *" rather than the
more specific device type (like the "struct platform_device *" that
most platform devices get passed to their probe). Presumably this
won't cause trouble and it's a lot less code to write but if we need
to make it more symmetric that's also possible by touching more files.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/base/dd.c             | 10 ++++++++--
 include/linux/device/driver.h |  9 +++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index ecd7cf848daf..9a13bff8dafa 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -549,10 +549,16 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 re_probe:
 	dev->driver = drv;
 
+	if (drv->pre_probe) {
+		ret = drv->pre_probe(dev);
+		if (ret)
+			goto probe_failed_pre_dma;
+	}
+
 	/* If using pinctrl, bind pins now before probing */
 	ret = pinctrl_bind_pins(dev);
 	if (ret)
-		goto pinctrl_bind_failed;
+		goto probe_failed_pre_dma;
 
 	if (dev->bus->dma_configure) {
 		ret = dev->bus->dma_configure(dev);
@@ -639,7 +645,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
-pinctrl_bind_failed:
+probe_failed_pre_dma:
 	device_links_no_driver(dev);
 	devres_release_all(dev);
 	arch_teardown_dma_ops(dev);
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index a498ebcf4993..f7305dd6ceb1 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -57,6 +57,14 @@ enum probe_type {
  * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
  * @of_match_table: The open firmware table.
  * @acpi_match_table: The ACPI match table.
+ * @pre_probe:	Called after a device has been bound to a driver but before
+ *		anything "automatic" (pinctrl, DMA, IOMMUs, ...) has been
+ *		setup. This is mostly a chance for the driver to do things
+ *		that might need to be run before any of those automatic
+ *		processes. The vast majority of devices don't need to
+ *		implement this. Note that there is no "post_remove" at the
+ *		moment. If you need to undo something that you did in
+ *		pre_probe() you can use devres.
  * @probe:	Called to query the existence of a specific device,
  *		whether this driver can work with it, and bind the driver
  *		to a specific device.
@@ -105,6 +113,7 @@ struct device_driver {
 	const struct of_device_id	*of_match_table;
 	const struct acpi_device_id	*acpi_match_table;
 
+	int (*pre_probe) (struct device *dev);
 	int (*probe) (struct device *dev);
 	void (*sync_state)(struct device *dev);
 	int (*remove) (struct device *dev);
-- 
2.32.0.288.g62a8d224e6-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
