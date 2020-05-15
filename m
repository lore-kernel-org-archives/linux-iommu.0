Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712D4C433E0
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 18:26:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F7BE20671
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 18:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7BE20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D1A6D20013;
	Fri, 15 May 2020 18:26:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eXXq85rw8wRJ; Fri, 15 May 2020 18:26:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0221E2EBA6;
	Fri, 15 May 2020 18:26:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DADFEC0178;
	Fri, 15 May 2020 18:26:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D8B7C016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 18:26:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8876889B92
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 18:26:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4THC5t5scDYj for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 18:26:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E457889B9A
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 18:26:04 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C0E6FAD93;
 Fri, 15 May 2020 18:26:04 +0000 (UTC)
Date: Fri, 15 May 2020 20:26:00 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: Implement deferred domain attachment
Message-ID: <20200515182600.GJ8135@suse.de>
References: <20200515094519.20338-1-joro@8bytes.org>
 <d4e1cd9e-fc83-d41a-49c0-8f14f44b2701@arm.com>
 <20200515161400.GZ18353@8bytes.org>
 <e7bdcbf1-a713-618d-3e02-037f509a17e9@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e7bdcbf1-a713-618d-3e02-037f509a17e9@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>,
 linux-kernel@vger.kernel.org
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

On Fri, May 15, 2020 at 05:28:53PM +0100, Robin Murphy wrote:
> On 2020-05-15 17:14, Joerg Roedel wrote:
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index ba128d1cdaee..403fda04ea98 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -362,8 +362,8 @@ static int iommu_dma_deferred_attach(struct device *dev,
> >   		return 0;
> >   	if (unlikely(ops->is_attach_deferred &&
> > -			ops->is_attach_deferred(domain, dev)))
> > -		return iommu_attach_device(domain, dev);
> > +		     ops->is_attach_deferred(domain, dev)))
> > +		return iommu_attach_device_no_defer(domain, dev);
> 
> Wouldn't it be simpler to just invoke ops->attach_dev directly and avoid
> having to formalise a public interface that nobody else should ever use
> anyway?

That would omit the ops->attach_dev != NULL check and the trace-point on
device attach. Besides that, it would be a layering violation. But the
function is of course entirely internal to the iommu subsytem and is a
good canditate to be moved to a header file in drivers/iommu.

> @@ -746,8 +747,11 @@ int iommu_group_add_device(struct iommu_group *group,
> struct device *dev)
> 
>         mutex_lock(&group->mutex);
>         list_add_tail(&device->list, &group->devices);
> -       if (group->domain)
> -               ret = __iommu_attach_device(group->domain, dev);
> +       domain = group->domain;
> +       if (domain && (!domain->ops->is_attach_deferred ||
> +                      !domain->ops->is_attach_deferred(domain, dev)))
> +               ret = __iommu_attach_device(domain, dev);
> +       }
>         mutex_unlock(&group->mutex);
>         if (ret)
>                 goto err_put_group;

No, doing this in iommu_group_add_device() doesn't solve the problem.
The attach must not happen before a device driver took control of the
device and silenced any DMA initiated by the old kernel. At probe time
this isn't guaranteed.


	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
