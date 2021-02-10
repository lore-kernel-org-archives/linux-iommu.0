Return-Path: <SRS0=5Lc9=HM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21C8C433DB
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 08:20:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 742D864E42
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 08:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742D864E42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2D08E8660D;
	Wed, 10 Feb 2021 08:20:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a+qzVmecyB4W; Wed, 10 Feb 2021 08:20:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9B29086645;
	Wed, 10 Feb 2021 08:20:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84FF8C0174;
	Wed, 10 Feb 2021 08:20:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE67BC013A
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 08:20:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9A5F986645
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 08:20:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UV4-tUVLqZcS for <iommu@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 08:20:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3048A8660D
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 08:20:11 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id b145so783242pfb.4
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 00:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=bN8+LfiNtzngdUBYXSpApBthbikVX06+ix6BW2b4aWg=;
 b=qDYB15gK8JX6ZDeswwoEwGJ2xufVymnYMBA3VTOZumhUwZy/0JJtATKD6lwbkL3q6t
 6yYWPhAsFcQX+9RkHBnAPARTikLC4SU+oyIk2DpUI4v+2PSSwhT4vEHsuXswDEfOqemV
 3LaaVXt4IT7/ks2tAmPUZZIreabqJ0OqQ1X26n9lbWOBDyOUif0hDX+bqstWHJDUpCdw
 HZ5jHDiQag1uFfFzI4ZjlV74GMIjmeqSuybjU08MYfHvY9YY603Ukg/VirC/8huxBWb5
 7ir11NhiXLa0Zvq/Zhyz+1LF777vYR2V6N32AEB6qMG8kIfeiyeSbyRxUbX21OR3GidG
 LRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bN8+LfiNtzngdUBYXSpApBthbikVX06+ix6BW2b4aWg=;
 b=ZIYUJ9JsIKNhhHTeeMFqMbg0Nx5Hx51pGywW5IewLP0EWMK66Y/Mmn7mAZxfShyxiL
 8JcfEWgORZFB+j/5J2ihW8CViyavgcvf5YWa4MaMLNvoW5kHeJ/fmc8i7NqbdmVxRu8s
 014UUQJWmQa65fcovPaiWEaAZ0Rn1Z8mhXULpzrUaqL1LbU6GXefnfz5zcSLZF8zXS8i
 5MTlw+n0W/icb1UL8WgOkMdNafGw4EOHREyzRVsT0nQ2lXRFylwuqpdsqWHQ3Wf0BD2r
 bN2vgNpoZBR9Qtgv9myJSg6Ilfge7w03rVNtavbpuzRsd7cVLIO9AHPK0QyC9u2J8YG3
 TBbQ==
X-Gm-Message-State: AOAM533xkbSY1AYUYRjxThtQbhb0FoGP0/ZWbxlWgf+jPHyCt3MX96Gq
 ApcgNjjxoc+8mAy8bwDF3gM=
X-Google-Smtp-Source: ABdhPJyuQnDmm6LwJMY3H7IP4ztnWgrF6vb/qwMY+bZaAjJ6hnrtfL4F4D0NWf/fh+kiUh1oVeBtLA==
X-Received: by 2002:a65:6392:: with SMTP id h18mr2063066pgv.165.1612945210688; 
 Wed, 10 Feb 2021 00:20:10 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id y8sm1528098pfe.36.2021.02.10.00.20.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 10 Feb 2021 00:20:10 -0800 (PST)
Date: Wed, 10 Feb 2021 00:20:53 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Guillaume Tucker <guillaume.tucker@collabora.com>
Subject: Re: [PATCH RESEND v2 4/5] iommu/tegra-smmu: Rework
 tegra_smmu_probe_device()
Message-ID: <20210210082052.GA11455@Asurada-Nvidia>
References: <20201125101013.14953-1-nicoleotsuka@gmail.com>
 <20201125101013.14953-5-nicoleotsuka@gmail.com>
 <46a96cf9-91cc-2ad4-702a-e95ba7200375@collabora.com>
 <20210205052422.GA11329@Asurada-Nvidia>
 <20210205094556.GA32677@Asurada-Nvidia>
 <f45c94b4-2949-4eac-5944-85d43a8afef5@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <f45c94b4-2949-4eac-5944-85d43a8afef5@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: "kernelci-results@groups.io" <kernelci-results@groups.io>,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
 kernel@collabora.com, will@kernel.org
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Guillaume,

On Sat, Feb 06, 2021 at 01:40:13PM +0000, Guillaume Tucker wrote:
> > It'd be nicer if I can get both logs of the vanilla kernel (failing)
> > and the commit-reverted version (passing), each applying this patch.
> 
> Sure, I've run 3 jobs:
> 
> * v5.11-rc6 as a reference, to see the original issue:
>   https://lava.collabora.co.uk/scheduler/job/3187848
> 
> * + your debug patch:
>   https://lava.collabora.co.uk/scheduler/job/3187849
> 
> * + the "breaking" commit reverted, passing the tests:
>   https://lava.collabora.co.uk/scheduler/job/3187851

Thanks for the help!

I am able to figure out what's probably wrong, yet not so sure
about the best solution at this point.

Would it be possible for you to run one more time with another
debugging patch? I'd like to see the same logs as previous:
1. Vanilla kernel + debug patch
2. Vanilla kernel + Reverted + debug patch

Thank you
Nicolin

--qDbXVdCdHGoSgWSk
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-iommu-debug-tegra-smmu-v2.patch"

From dce84731e12900b0e98dffc0ff981638a0bb3405 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Fri, 5 Feb 2021 01:41:07 -0800
Subject: [PATCH] iommu: debug tegra-smmu v2

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 arch/arm/mm/dma-mapping.c       |  6 +++--
 drivers/gpu/drm/tegra/dc.c      |  1 +
 drivers/gpu/drm/tegra/drm.c     |  4 +++
 drivers/iommu/iommu.c           | 47 +++++++++++++++++++++++++++------
 drivers/iommu/tegra-smmu.c      | 31 +++++++++++++++++++++-
 drivers/memory/tegra/tegra124.c |  2 ++
 6 files changed, 80 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c4b8df2ad328..6a6715817707 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -2136,13 +2136,15 @@ static int __arm_iommu_attach_device(struct device *dev,
 	int err;
 
 	err = iommu_attach_device(mapping->domain, dev);
-	if (err)
+	if (err) {
+		dev_alert(dev, "------%s failed with err: %d", __func__, err);
 		return err;
+	}
 
 	kref_get(&mapping->kref);
 	to_dma_iommu_mapping(dev) = mapping;
 
-	pr_debug("Attached IOMMU controller to %s device.\n", dev_name(dev));
+	pr_alert("Attached IOMMU controller to %s device.\n", dev_name(dev));
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 0ae3a025efe9..96af9186e81a 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2033,6 +2033,7 @@ static int tegra_dc_init(struct host1x_client *client)
 	struct drm_plane *cursor = NULL;
 	int err;
 
+	dev_alert(dc->dev, "-----------%s, %d\n", __func__, __LINE__);
 	/*
 	 * XXX do not register DCs with no window groups because we cannot
 	 * assign a primary plane to them, which in turn will cause KMS to
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index e9ce7d6992d2..ea6bf26f4df3 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -906,6 +906,7 @@ int host1x_client_iommu_attach(struct host1x_client *client)
 	struct iommu_group *group = NULL;
 	int err;
 
+	dev_alert(client->dev, "-----------%s, %d\n", __func__, __LINE__);
 	/*
 	 * If the host1x client is already attached to an IOMMU domain that is
 	 * not the shared IOMMU domain, don't try to attach it to a different
@@ -914,7 +915,9 @@ int host1x_client_iommu_attach(struct host1x_client *client)
 	if (domain && domain != tegra->domain)
 		return 0;
 
+	dev_alert(client->dev, "-----------%s, %d\n", __func__, __LINE__);
 	if (tegra->domain) {
+	dev_alert(client->dev, "-----------%s, %d\n", __func__, __LINE__);
 		group = iommu_group_get(client->dev);
 		if (!group)
 			return -ENODEV;
@@ -932,6 +935,7 @@ int host1x_client_iommu_attach(struct host1x_client *client)
 
 	client->group = group;
 
+	dev_alert(client->dev, "-----------%s, %d\n", __func__, __LINE__);
 	return 0;
 }
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d0b0a15dba84..890c7c7ecf94 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -220,6 +220,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group)) {
+		dev_alert(dev, "---------%s, %d\n", __func__, __LINE__);
 		ret = PTR_ERR(group);
 		goto out_release;
 	}
@@ -268,7 +269,9 @@ int iommu_probe_device(struct device *dev)
 	 */
 	iommu_alloc_default_domain(group, dev);
 
+	dev_alert(dev, "---------%s, %d\n", __func__, __LINE__);
 	if (group->default_domain) {
+		dev_alert(dev, "---------%s, %d\n", __func__, __LINE__);
 		ret = __iommu_attach_device(group->default_domain, dev);
 		if (ret) {
 			iommu_group_put(group);
@@ -852,8 +855,11 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
-	if (group->domain  && !iommu_is_attach_deferred(group->domain, dev))
+	dev_alert(dev, "---------%s, %d\n", __func__, __LINE__);
+	if (group->domain  && !iommu_is_attach_deferred(group->domain, dev)) {
+		dev_alert(dev, "---------%s, %d\n", __func__, __LINE__);
 		ret = __iommu_attach_device(group->domain, dev);
+	}
 	mutex_unlock(&group->mutex);
 	if (ret)
 		goto err_put_group;
@@ -1497,6 +1503,7 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
 {
 	struct iommu_domain *dom;
 
+	pr_alert("------%s: %s, %s, %s\n", __func__, bus->name, bus->dev_name, group->name);
 	dom = __iommu_domain_alloc(bus, type);
 	if (!dom && type != IOMMU_DOMAIN_DMA) {
 		dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
@@ -1508,6 +1515,7 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
 	if (!dom)
 		return -ENOMEM;
 
+	pr_alert("------%s: %s: changing default_domain: type %u\n", __func__, group->name, type);
 	group->default_domain = dom;
 	if (!group->domain)
 		group->domain = dom;
@@ -1532,6 +1540,7 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
 
 	type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
 
+	dev_alert(dev, "---------%s, %d: type %u\n", __func__, __LINE__, type);
 	return iommu_group_alloc_default_domain(dev->bus, group, type);
 }
 
@@ -1552,22 +1561,30 @@ static struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	int ret;
 
 	group = iommu_group_get(dev);
-	if (group)
+	if (group) {
+		dev_alert(dev, "---------%s, %d\n", __func__, __LINE__);
 		return group;
+	}
 
 	if (!ops)
 		return ERR_PTR(-EINVAL);
 
+	dev_alert(dev, "---------%s, %d\n", __func__, __LINE__);
 	group = ops->device_group(dev);
+	dev_alert(dev, "---------%s, %d\n", __func__, __LINE__);
 	if (WARN_ON_ONCE(group == NULL))
 		return ERR_PTR(-EINVAL);
 
-	if (IS_ERR(group))
+	if (IS_ERR(group)) {
+		dev_alert(dev, "---------%s, %d\n", __func__, __LINE__);
 		return group;
+	}
 
 	ret = iommu_group_add_device(group, dev);
-	if (ret)
+	if (ret) {
+		dev_alert(dev, "---------%s, %d\n", __func__, __LINE__);
 		goto out_put_group;
+	}
 
 	return group;
 
@@ -1928,6 +1945,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 
 struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
 {
+	pr_alert("------%s: %s, %s\n", __func__, bus->name, bus->dev_name);
 	return __iommu_domain_alloc(bus, IOMMU_DOMAIN_UNMANAGED);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
@@ -1943,12 +1961,17 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (unlikely(domain->ops->attach_dev == NULL))
+	if (unlikely(domain->ops->attach_dev == NULL)) {
+		dev_alert(dev, "-------%s: no attach_dev\n", __func__);
 		return -ENODEV;
+	}
 
 	ret = domain->ops->attach_dev(domain, dev);
 	if (!ret)
 		trace_attach_device_to_domain(dev);
+	else
+		dev_alert(dev, "-------%s: failed to attach_dev: %d\n", __func__, ret);
+
 	return ret;
 }
 
@@ -1958,8 +1981,10 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 	int ret;
 
 	group = iommu_group_get(dev);
-	if (!group)
+	if (!group) {
+		dev_alert(dev, "-------%s: failed to get group\n", __func__);
 		return -ENODEV;
+	}
 
 	/*
 	 * Lock the group to make sure the device-count doesn't
@@ -1967,8 +1992,10 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 	 */
 	mutex_lock(&group->mutex);
 	ret = -EINVAL;
-	if (iommu_group_device_count(group) != 1)
+	if (iommu_group_device_count(group) != 1) {
+		dev_alert(dev, "-------%s: bypassing attach_group\n", __func__);
 		goto out_unlock;
+	}
 
 	ret = __iommu_attach_group(domain, group);
 
@@ -2283,13 +2310,17 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (group->default_domain && group->domain != group->default_domain)
+	if (group->default_domain && group->domain != group->default_domain) {
+		pr_alert("------------%s, domain mismatched\n", __func__);
 		return -EBUSY;
+	}
 
 	ret = __iommu_group_for_each_dev(group, domain,
 					 iommu_group_do_attach_device);
 	if (ret == 0)
 		group->domain = domain;
+	else
+		pr_alert("------------%s, failed: %d\n", __func__, ret);
 
 	return ret;
 }
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 4a3f095a1c26..2363a9978674 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -281,6 +281,8 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 {
 	struct tegra_smmu_as *as;
 
+	pr_alert("---------%s, %d: type %u\n", __func__, __LINE__, type);
+	dump_stack();
 	if (type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
 
@@ -318,6 +320,7 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 	as->domain.geometry.aperture_end = 0xffffffff;
 	as->domain.geometry.force_aperture = true;
 
+	pr_alert("---------%s, %d: type %u\n", __func__, __LINE__, type);
 	return &as->domain;
 }
 
@@ -363,6 +366,7 @@ static void tegra_smmu_enable(struct tegra_smmu *smmu, unsigned int swgroup,
 		value |= SMMU_ASID_VALUE(asid);
 		value |= SMMU_ASID_ENABLE;
 		smmu_writel(smmu, value, group->reg);
+		pr_alert("--------%s, swgroup %d: writing %x to reg1 %x\n", __func__, swgroup, value, group->reg);
 	} else {
 		pr_warn("%s group from swgroup %u not found\n", __func__,
 				swgroup);
@@ -379,6 +383,7 @@ static void tegra_smmu_enable(struct tegra_smmu *smmu, unsigned int swgroup,
 		value = smmu_readl(smmu, client->smmu.reg);
 		value |= BIT(client->smmu.bit);
 		smmu_writel(smmu, value, client->smmu.reg);
+		pr_alert("--------%s, swgroup %d: writing %x to reg2 %x\n", __func__, swgroup, value, client->smmu.reg);
 	}
 }
 
@@ -491,13 +496,22 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 	unsigned int index;
 	int err;
 
+	dev_alert(dev, "-------%s\n", __func__);
+	if (strstr(dev_name(dev), "dc"))
+		dump_stack();
 	if (!fwspec)
 		return -ENOENT;
 
+	if (iommu_get_domain_for_dev(dev) != domain)
+		dev_alert(dev, "-------%s: domain not matched\n", __func__);
+
 	for (index = 0; index < fwspec->num_ids; index++) {
 		err = tegra_smmu_as_prepare(smmu, as);
-		if (err)
+		if (err) {
+			dev_err(dev, "failed to prepare as(%d) for fwspec %d",
+				as->id, fwspec->ids[index]);
 			goto disable;
+		}
 
 		tegra_smmu_enable(smmu, fwspec->ids[index], as->id);
 	}
@@ -805,6 +819,9 @@ static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
 	if (!smmu)
 		return ERR_PTR(-ENODEV);
 
+	dev_alert(dev, "--------%s, %d\n", __func__, __LINE__);
+	if (strstr(dev_name(dev), "dc"))
+		dump_stack();
 	return &smmu->iommu;
 }
 
@@ -842,6 +859,7 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	struct tegra_smmu_group *group;
 	struct iommu_group *grp;
 
+	dev_alert(dev, "---------%s, %d\n", __func__, __LINE__);
 	/* Find group_soc associating with swgroup */
 	soc = tegra_smmu_find_group(smmu, swgroup);
 
@@ -852,6 +870,10 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 		if ((group->swgroup == swgroup) || (soc && group->soc == soc)) {
 			grp = iommu_group_ref_get(group->group);
 			mutex_unlock(&smmu->lock);
+			if (soc && group->soc == soc)
+				dev_alert(dev, "---------%s, %d: %u: %s\n", __func__, __LINE__, swgroup, soc->name);
+			else
+				dev_alert(dev, "---------%s, %d, %u\n", __func__, __LINE__, swgroup);
 			return grp;
 		}
 
@@ -883,6 +905,10 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 	list_add_tail(&group->list, &smmu->groups);
 	mutex_unlock(&smmu->lock);
 
+	if (soc)
+		dev_alert(dev, "---------%s, %d: %u: %s\n", __func__, __LINE__, swgroup, soc->name);
+	else
+		dev_alert(dev, "---------%s, %d: %u\n", __func__, __LINE__, swgroup);
 	return group->group;
 }
 
@@ -904,6 +930,9 @@ static int tegra_smmu_of_xlate(struct device *dev,
 
 	dev_iommu_priv_set(dev, mc->smmu);
 
+	dev_alert(dev, "-------%s: id %d", __func__, id);
+	if (strstr(dev_name(dev), "dc"))
+		dump_stack();
 	return iommu_fwspec_add_ids(dev, &id, 1);
 }
 
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index 459211f50c08..faa4f4c53ac3 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -1062,6 +1062,8 @@ tegra124_mc_of_icc_xlate_extended(struct of_phandle_args *spec, void *data)
 		case TEGRA_SWGROUP_VI:
 			/* these clients are isochronous by default */
 			ndata->tag = TEGRA_MC_ICC_TAG_ISO;
+			dev_alert(mc->dev, "-----%s, setting ISO for swgroup %d\n", __func__, client->swgroup);
+			dump_stack();
 			break;
 
 		default:
-- 
2.17.1


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--qDbXVdCdHGoSgWSk--
