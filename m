Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783A6C433DF
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 19:08:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4938620674
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 19:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTv8hl9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4938620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D2D8324E36;
	Wed,  8 Jul 2020 19:08:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ep7aDDOZV2GN; Wed,  8 Jul 2020 19:08:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5570F23B31;
	Wed,  8 Jul 2020 19:08:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C215C0893;
	Wed,  8 Jul 2020 19:08:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D787C016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 19:07:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3976E89727
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 19:07:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SinCORvdI3gB for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 19:07:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 777068972E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 19:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594235276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i2jzZdLUrEZwSvsltld7qJazxhy6bdHEH3AcJYhJaq4=;
 b=GTv8hl9Kt93QT+k+zv/wPVFkOW/sYNkVJnvhMRpebWbg8yFoMvV5N0Xqx30ToN/C6QDGaC
 6OuuCm7kKKWJ2bxreysecElL+4/ItV6sS2UN1zK0RX9FvCtqwzAsv9xZ7DvaW5XxMikSXX
 P6jl0vHQssmFTLQ/8BCyl5OQskAM48I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-XdLsMZw-McaWOVhxfaNBeA-1; Wed, 08 Jul 2020 15:07:52 -0400
X-MC-Unique: XdLsMZw-McaWOVhxfaNBeA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9ED62800C64;
 Wed,  8 Jul 2020 19:07:50 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF58773FEA;
 Wed,  8 Jul 2020 19:07:49 +0000 (UTC)
Date: Wed, 8 Jul 2020 13:07:49 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 1/2] iommu: iommu_aux_at(de)tach_device() extension
Message-ID: <20200708130749.1b1e1421@x1.home>
In-Reply-To: <dc98a109-7121-36b7-0854-f899b09692a4@linux.intel.com>
References: <20200707013957.23672-1-baolu.lu@linux.intel.com>
 <20200707013957.23672-2-baolu.lu@linux.intel.com>
 <20200707150408.474d81f1@x1.home>
 <dc98a109-7121-36b7-0854-f899b09692a4@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

On Wed, 8 Jul 2020 10:53:12 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Alex,
> 
> Thanks a lot for your comments. Please check my reply inline.
> 
> On 7/8/20 5:04 AM, Alex Williamson wrote:
> > On Tue,  7 Jul 2020 09:39:56 +0800
> > Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> >   
> >> The hardware assistant vfio mediated device is a use case of iommu
> >> aux-domain. The interactions between vfio/mdev and iommu during mdev
> >> creation and passthr are:
> >>
> >> - Create a group for mdev with iommu_group_alloc();
> >> - Add the device to the group with
> >>          group = iommu_group_alloc();
> >>          if (IS_ERR(group))
> >>                  return PTR_ERR(group);
> >>
> >>          ret = iommu_group_add_device(group, &mdev->dev);
> >>          if (!ret)
> >>                  dev_info(&mdev->dev, "MDEV: group_id = %d\n",
> >>                           iommu_group_id(group));
> >> - Allocate an aux-domain
> >>          iommu_domain_alloc()
> >> - Attach the aux-domain to the physical device from which the mdev is
> >>    created.
> >>          iommu_aux_attach_device()
> >>
> >> In the whole process, an iommu group was allocated for the mdev and an
> >> iommu domain was attached to the group, but the group->domain leaves
> >> NULL. As the result, iommu_get_domain_for_dev() doesn't work anymore.
> >>
> >> The iommu_get_domain_for_dev() is a necessary interface for device
> >> drivers that want to support aux-domain. For example,
> >>
> >>          struct iommu_domain *domain;
> >>          struct device *dev = mdev_dev(mdev);
> >>          unsigned long pasid;
> >>
> >>          domain = iommu_get_domain_for_dev(dev);
> >>          if (!domain)
> >>                  return -ENODEV;
> >>
> >>          pasid = iommu_aux_get_pasid(domain, dev->parent);  
> > How did we know this was an aux domain? ie. How did we know we could
> > use it with iommu_aux_get_pasid()?  
> 
> Yes. It's a bit confusing if iommu_get_domain_for_dev() is reused here
> for aux-domain.
> 
> > 
> > Why did we assume the parent device is the iommu device for the aux
> > domain?  Should that level of detail be already known by the aux domain?
> > 
> > Nits - The iomu device of an mdev device is found via
> > mdev_get_iommu_device(dev), it should not be assumed to be the parent.
> > The parent of an mdev device is found via mdev_parent_dev(mdev).  
> 
> My bad. The driver should use mdev_get_iommu_device() instead.
> 
> > 
> > The leaps in logic here make me wonder if we should instead be exposing
> > more of an aux domain API rather than blurring the differences between
> > these domains.  Thanks,  
> 
> How about add below API?
> 
> /**
>   * iommu_aux_get_domain_for_dev - get aux domain for a device
>   * @dev: the accessory device
>   *
>   * The caller should pass a valid @dev to iommu_aux_attach_device() before
>   * calling this api. Return an attached aux-domain, or NULL otherwise.

That's not necessarily the caller's responsibility, that might happen
elsewhere, this function simply returns an aux domain for the device if
it's attached to one.

>   */
> struct iommu_domain *iommu_aux_get_domain_for_dev(struct device *dev)
> {
>          struct iommu_domain *domain = NULL;
>          struct iommu_group *group;
> 
>          group = iommu_group_get(dev);
>          if (!group)
>                  return NULL;
> 
>          if (group->aux_domain_attached)
>                  domain = group->domain;
> 
>          iommu_group_put(group);
> 
>          return domain;
> }
> EXPORT_SYMBOL_GPL(iommu_aux_get_domain_for_dev);

For your example use case, this seems more clear to me.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
