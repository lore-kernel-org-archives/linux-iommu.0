Return-Path: <SRS0=bDbm=VH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A47C74A35
	for <iommu@archiver.kernel.org>; Wed, 10 Jul 2019 18:38:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F296D20844
	for <iommu@archiver.kernel.org>; Wed, 10 Jul 2019 18:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdE1Snln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F296D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8A97C4872;
	Wed, 10 Jul 2019 18:38:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C827347F6
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Jul 2019 18:28:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
	[209.85.210.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D3B55886
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Jul 2019 18:28:52 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id i189so1470110pfg.10
	for <iommu@lists.linux-foundation.org>;
	Wed, 10 Jul 2019 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=X2wPmom3sJSwZ6VYG/6JKsbwq16BGxAUHYVA29t4WUs=;
	b=bdE1SnlndmJmWXI4tshCAMHf1y6EjPIbK8Fbzi7N09M0t7c7CXz9jPaAF+U4zpK2Ar
	qgCiZ/PtW4leBd9a9AxyI8AX8KAj2qjw9PES2Zr2jdM0CYFXuuMwafu1VW3XyuIX85ze
	WyeGDguVLVu37gQ+z7B90eyFqfNkom1MP3LikG5lNXvgTOw7RM96ogRtu5S7/ndJUKBX
	SFSf82JGBHHIEmapCMaggiqsSGmD80h/HwjFTvWjD5i1CXq8qlzCKfCl22YLtstT+vsh
	abGOlhy9STPiO77wHf6EZUAMV63/A7eAJBWH/kg8JCzyNogW1v4N+kxJ1fDAn8+Wu7uz
	ddfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=X2wPmom3sJSwZ6VYG/6JKsbwq16BGxAUHYVA29t4WUs=;
	b=POWgKbuLJzCSUZOvlIVPs/PtvydpZy+EHJu9sBoepMcdLseW4Sn5wMXGdvQzmIxzra
	leWM/bCROz9YTeUmJ4kFP4yvmKpyZHG6SoY/WWM+exjWWeFpbZK3MNbLsA2piZhApJ++
	z+JpQZ36vjLPG2/96FIh7mnsitFTML6qLe3KPCh1UCRDO6lv4EJqKEuSsj05/XXVKZdq
	UMaB0AUKBQfGdIRHrNGD9cI7i/u5+dC4GSdxuHyezCwTvtbmFpGptwAdXOzQbtN7sECU
	AYzGyAPkltCeSijVUgnU67suNjgFmdBk4eOOtY82tJsBvECwhvifj27LYj5Zuj6I5/0o
	uMnQ==
X-Gm-Message-State: APjAAAXuAtyr05QDG9D5E+3JMnmkmxMUvw92MikV5KxfEMkMP8fQwwZC
	jGS24gLeauMPw9S1KxYJp2WZbKlNdEw=
X-Google-Smtp-Source: APXvYqzxVJwORPZh7pa+tFmbtMmG7GfDyUMvQifbBp9D3WGXW+RU3JFqDMMKkm/CNidWkfL1FXSk/Q==
X-Received: by 2002:a65:454c:: with SMTP id x12mr38500524pgr.354.1562783332011;
	Wed, 10 Jul 2019 11:28:52 -0700 (PDT)
Received: from localhost ([2620:15c:f:fd00:4c3b:936:8dc5:a2ad])
	by smtp.gmail.com with ESMTPSA id d16sm2943054pgb.4.2019.07.10.11.28.50
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 11:28:51 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2] iommu: add support for drivers that manage iommu explicitly
Date: Wed, 10 Jul 2019 11:28:30 -0700
Message-Id: <20190710182844.25032-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702202631.32148-2-robdclark@gmail.com>
References: <20190702202631.32148-2-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, aarch64-laptops@lists.linaro.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Robin Murphy <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Rob Clark <robdclark@chromium.org>

Avoid attaching any non-driver managed domain if the driver indicates
that it manages the iommu directly.

This avoids a problem on devices where the bootloader takes the SMMU out
of bypass and enables scanout, such as is the case on snapdragon aarch64
laptops and newer snapdragon android devices.  Attaching an IDENTITY or
DMA domain before the driver has a chance to intervene will break efifb
scanout and start triggering iommu faults.

If the driver manages the iommu directly (as does drm/msm), it can
shut down scanout when it is ready to take over the display, before
attaching an UNMANAGED domain.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
v2. Move the check into arm_smmu_attach_dev() (as I *think* this is
    what Robin preferred; update commit msg to focus on the display
    related issue that this solves.

We also need Bjorn's patch set to inherit SMR and CB config during
init:

https://www.spinics.net/lists/arm-kernel/msg732246.html

 drivers/iommu/arm-smmu.c | 11 +++++++++++
 include/linux/device.h   |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1a5efa7c8767..4a80710124db 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1411,6 +1411,17 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return -ENXIO;
 	}
 
+	/*
+	 * If driver is going to manage iommu directly, then avoid
+	 * attaching any non driver managed domain.  There could
+	 * be already active dma underway (ie. scanout in case of
+	 * bootloader enabled display), and interfering with that
+	 * will make things go *boom*
+	 */
+	if ((domain->type != IOMMU_DOMAIN_UNMANAGED) &&
+	    dev->driver && dev->driver->driver_manages_iommu)
+		return 0;
+
 	/*
 	 * FIXME: The arch/arm DMA API code tries to attach devices to its own
 	 * domains between of_xlate() and add_device() - we have no way to cope
diff --git a/include/linux/device.h b/include/linux/device.h
index e138baabe01e..d98aa4d3c8c3 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -282,7 +282,8 @@ struct device_driver {
 	struct module		*owner;
 	const char		*mod_name;	/* used for built-in modules */
 
-	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
+	bool suppress_bind_attrs:1;	/* disables bind/unbind via sysfs */
+	bool driver_manages_iommu:1;	/* driver manages IOMMU explicitly */
 	enum probe_type probe_type;
 
 	const struct of_device_id	*of_match_table;
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
