Return-Path: <SRS0=rqG6=XB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D027C43140
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 21:48:50 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6155220838
	for <iommu@archiver.kernel.org>; Fri,  6 Sep 2019 21:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9KS64BP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6155220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 38EA327C8;
	Fri,  6 Sep 2019 21:48:50 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 50DF0279B
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 21:48:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F00F27DB
	for <iommu@lists.linux-foundation.org>;
	Fri,  6 Sep 2019 21:48:48 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id y72so5420026pfb.12
	for <iommu@lists.linux-foundation.org>;
	Fri, 06 Sep 2019 14:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=PmbeXR16EILkjisUuUV6rfWxt0BghSuM480d7BBoObE=;
	b=l9KS64BP1B0VVFLP3cG+Fu9U3dUbCksmelSZOoyogDcNDZW7sjsm328l7B9JP6x26f
	DZaO/ojDzSUVS4Il84HxoyaRZCseDaFTbt0s08wXIhLhOunAvz314/stiuohiLGFMmpE
	o3ol62LvFBaKO08hIXHcKu89nLOnrucM/f4gr9kbmXTL/db0eQb2NfDz1gsUIVqf14t0
	QS0EoD8cKG4EdIQwYJ9KgSsGFyxXBCE3mbcRtamjbEN+ffrHwSzbUJ5ryEqWsTz7LGFr
	PJrVc19D7lpchjdUYFkmeYBA9fAiwKYdQ49Fv5Gw7pcbMrSl95PcHvVJdZOvz2bGBBlT
	Gx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=PmbeXR16EILkjisUuUV6rfWxt0BghSuM480d7BBoObE=;
	b=UyK6yT7zVd+Z561UC/dhhVvFQWTBSJdwH5lrIL3LzQWFFDKc+3ja1pjMJO+vs3L440
	ecaysRsK0eP74iF2i8FsNl3UDWp06z+ESpaNEERaeQMh135TaNbj31OghlkGwk72VAig
	Vf4uhEN+am7mLiNX9xsAES5loRAA0qBBArH9NER0mnxdV/q0wQeyARCmVq+9ddq75Tqg
	5KHU0gQtPPV9lggYRc3Llt8ljWjSReswTXuBlKny7/oZg7acmIA8gZhlAAKj0c91M+/f
	KQpddGrlQDJLrGSrv8E7OuEI7RIKFYGu5W2jmyr8VhZMt2cQbf+KkoLIlHCViESbEg7y
	uidg==
X-Gm-Message-State: APjAAAXFzKNOrPPMmErld2skOp+iRbQXrImr7WQjkU6g4gQV4B8HW+zj
	TaMcL7jogw7NCtJLuyfjd12JA/YmD0iWww==
X-Google-Smtp-Source: APXvYqxQCd7WFr1bk2mCpZ+S1Nv/UOSK0AKJu6DLOAfsUfGckUthB3lN7nqi/NUB8YzjJgdlC0+ugA==
X-Received: by 2002:a63:4823:: with SMTP id v35mr9858403pga.138.1567806528190; 
	Fri, 06 Sep 2019 14:48:48 -0700 (PDT)
Received: from localhost ([100.118.89.196]) by smtp.gmail.com with ESMTPSA id
	j9sm6894230pfi.128.2019.09.06.14.48.47
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 06 Sep 2019 14:48:47 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 1/2] iommu: add support for drivers that manage iommu
	explicitly
Date: Fri,  6 Sep 2019 14:44:01 -0700
Message-Id: <20190906214409.26677-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190906214409.26677-1-robdclark@gmail.com>
References: <20190906214409.26677-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-arm-msm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	open list <linux-kernel@vger.kernel.org>
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/iommu.c    | 2 +-
 drivers/iommu/of_iommu.c | 3 +++
 include/linux/device.h   | 3 ++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0c674d80c37f..2ac5e8d48cae 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -674,7 +674,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
-	if (group->domain)
+	if (group->domain && !(dev->driver && dev->driver->driver_manages_iommu))
 		ret = __iommu_attach_device(group->domain, dev);
 	mutex_unlock(&group->mutex);
 	if (ret)
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 614a93aa5305..62b47e384a77 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -221,6 +221,9 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 	} else if (err < 0) {
 		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
 		ops = NULL;
+	} else if (dev->driver && dev->driver->driver_manages_iommu) {
+		dev_dbg(dev, "Driver manages IOMMU\n");
+		ops = NULL;
 	}
 
 	return ops;
diff --git a/include/linux/device.h b/include/linux/device.h
index 1aa341b2a0db..b77a11b8d9bb 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -284,7 +284,8 @@ struct device_driver {
 	struct module		*owner;
 	const char		*mod_name;	/* used for built-in modules */
 
-	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
+	bool suppress_bind_attrs:1;	/* disables bind/unbind via sysfs */
+	bool driver_manages_iommu:1;	/* driver manages IOMMU explicitly */
 	enum probe_type probe_type;
 
 	const struct of_device_id	*of_match_table;
-- 
2.21.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
