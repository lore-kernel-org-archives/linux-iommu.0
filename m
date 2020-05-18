Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FADC433DF
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 13:27:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F4492065F
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 13:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F4492065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0069988313;
	Mon, 18 May 2020 13:27:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xZCcK+TdvES5; Mon, 18 May 2020 13:27:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5752688311;
	Mon, 18 May 2020 13:27:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C6D1C0888;
	Mon, 18 May 2020 13:27:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A352C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 13:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3661420434
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 13:27:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JssiWcPrEKae for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 13:27:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 115E520420
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 13:27:01 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4DDB2ACE3;
 Mon, 18 May 2020 13:27:01 +0000 (UTC)
Date: Mon, 18 May 2020 15:26:56 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: Implement deferred domain attachment
Message-ID: <20200518132656.GL8135@suse.de>
References: <20200515094519.20338-1-joro@8bytes.org>
 <d4e1cd9e-fc83-d41a-49c0-8f14f44b2701@arm.com>
 <20200515161400.GZ18353@8bytes.org>
 <e7bdcbf1-a713-618d-3e02-037f509a17e9@arm.com>
 <20200515182600.GJ8135@suse.de>
 <f5c6ec5b-06c6-42e6-b74d-71cf29b44b8d@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f5c6ec5b-06c6-42e6-b74d-71cf29b44b8d@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Tom Murphy <murphyt7@tcd.ie>
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

On Fri, May 15, 2020 at 08:23:13PM +0100, Robin Murphy wrote:
> But that's not what this is; this is (supposed to be) the exact same "don't
> actually perform the attach yet" logic as before, just restricting it to
> default domains in the one place that it actually needs to be, so as not to
> fundamentally bugger up iommu_attach_device() in a way that prevents it from
> working as expected at the correct point later.

You are right, that is better. I tested it and it seems to work. Updated
diff attached, with a minor cleanup included. Mind sending it as a
proper patch I can send upstream?

Thanks,

	Joerg

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7b375421afba..a9d02bc3ab5b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -693,6 +693,15 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
 	return ret;
 }
 
+static bool iommu_is_attach_deferred(struct iommu_domain *domain,
+				     struct device *dev)
+{
+	if (domain->ops->is_attach_deferred)
+		return domain->ops->is_attach_deferred(domain, dev);
+
+	return false;
+}
+
 /**
  * iommu_group_add_device - add a device to an iommu group
  * @group: the group into which to add the device (reference should be held)
@@ -705,6 +714,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 {
 	int ret, i = 0;
 	struct group_device *device;
+	struct iommu_domain *domain;
 
 	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (!device)
@@ -747,7 +757,8 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
-	if (group->domain)
+	domain = group->domain;
+	if (domain  && !iommu_is_attach_deferred(domain, dev))
 		ret = __iommu_attach_device(group->domain, dev);
 	mutex_unlock(&group->mutex);
 	if (ret)
@@ -1653,9 +1664,6 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev)
 {
 	int ret;
-	if ((domain->ops->is_attach_deferred != NULL) &&
-	    domain->ops->is_attach_deferred(domain, dev))
-		return 0;
 
 	if (unlikely(domain->ops->attach_dev == NULL))
 		return -ENODEV;
@@ -1727,8 +1735,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
-	if ((domain->ops->is_attach_deferred != NULL) &&
-	    domain->ops->is_attach_deferred(domain, dev))
+	if (iommu_is_attach_deferred(domain, dev))
 		return;
 
 	if (unlikely(domain->ops->detach_dev == NULL))
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
