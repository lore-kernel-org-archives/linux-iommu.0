Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9933C433E0
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 09:59:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5272074D
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 09:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5272074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 57ED187D3D;
	Fri, 15 May 2020 09:59:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7pOoVxx_z0TL; Fri, 15 May 2020 09:59:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B97CB87D01;
	Fri, 15 May 2020 09:59:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 840E4C0859;
	Fri, 15 May 2020 09:59:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38BCAC016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 09:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 351AE8695F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 09:59:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cv+jOJq2U2bt for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 09:59:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 97E22867F0
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 09:59:22 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 18A43379; Fri, 15 May 2020 11:59:21 +0200 (CEST)
Date: Fri, 15 May 2020 11:59:19 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Subject: Re: [PATCH] iommu: Remove functions that support private domain
Message-ID: <20200515095919.GQ18353@8bytes.org>
References: <20200513224721.20504-1-sai.praneeth.prakhya@intel.com>
 <20200514131315.GJ18353@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573A6427@ORSMSX114.amr.corp.intel.com>
 <20200514183233.GO18353@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573A651E@ORSMSX114.amr.corp.intel.com>
 <20200514195615.GP18353@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573A6672@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F573A6672@ORSMSX114.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

On Thu, May 14, 2020 at 11:12:52PM +0000, Prakhya, Sai Praneeth wrote:
> +static int is_driver_bound(struct device *dev, void *not_used)
> +{
> +	int ret = 0;
> +
> +	device_lock(dev);
> +	if (device_is_bound(dev))
> +		ret = 1;
> +	device_unlock(dev);
> +	return ret;
> +}

This locks only one device, so without lock-conversion there could be a
driver probe after the device_unlock(), while we are probing the other
devices of the group.

> [SNIP]
> 
> +	/*
> +	 * Check if any device in the group still has a driver binded to it.
> +	 * This might race with device driver probing code and unfortunately
> +	 * there is no clean way out of that either, locking all devices in the
> +	 * group and then do the re-attach will introduce a lock-inversion with
> +	 * group->mutex - Joerg.
> +	 */
> +	if (iommu_group_for_each_dev(group, NULL, is_driver_bound)) {
> +		pr_err("Active drivers exist for devices in the group\n");
> +		return -EBUSY;
> +	}

The lock inversion comes into the picture when this code is called from
device(-driver) core through the bus-notifiers. The notifiers are called
with the device already locked.

> Another question I have is.. if it's racy then it should be racy even
> for one device iommu groups.. right? Why would it be racy only with
> multiple devices iommu group?

Valid point. So the device needs to be locked _while_ the default domain
change happens. If triggered by sysfs there should be no locking
problems, I guess. But you better try it out.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
