Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F001C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 23:00:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF10F60BA6;
	Thu, 23 Jun 2022 23:00:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CF10F60BA6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PPnfMcp3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZsdRBaCglebG; Thu, 23 Jun 2022 23:00:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 265C4606F5;
	Thu, 23 Jun 2022 23:00:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 265C4606F5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03044C0032;
	Thu, 23 Jun 2022 23:00:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D80DC002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 23:00:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6E2E404BA
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 23:00:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E6E2E404BA
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PPnfMcp3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6BjUI-ERwKya for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 23:00:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BAA14400E4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BAA14400E4
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 23:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656025249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K2a+ZoO+OyFnk1IwsI6/2cGromoSIiCUd/MQu22EaXU=;
 b=PPnfMcp3M/y1fXZQh26z0bpGyi8OVP5nRUDA0qn/CXoWc006LZNmGL1S4bKjmrGwJcNutR
 AGzc0tUqWLgYZRamiyBZcbdz7QNJrUdrOSjEzPf8TKjZlEMEqFrCJMdUAdAUlVHvZS01me
 WIPI1Y+KumlFpix6tiWLlNsMSFZql5g=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-ex_5sfb8OZqrNkg2SwQ0OQ-1; Thu, 23 Jun 2022 19:00:48 -0400
X-MC-Unique: ex_5sfb8OZqrNkg2SwQ0OQ-1
Received: by mail-io1-f70.google.com with SMTP id
 f1-20020a056602070100b00674f8035487so420279iox.17
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 16:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K2a+ZoO+OyFnk1IwsI6/2cGromoSIiCUd/MQu22EaXU=;
 b=gdgc0IxN+pirI1ku5oRpirw2r3XNfvDDtVHtgA3iTBN60QqvPEDvJBToQX6oJsGudb
 6xLMA5beqvgPBAqb/aaivXoZHqtvJS0eqtdeo/9dNneIotxM1C8XVwrbIp3AADL0/rVk
 /MkJepdGybPzcSHqgqJGMz/spwzD4yys9cooaBHWR4LTzxH5F9Nn6uFIr0oNePadSU+u
 qvWY8px+HzVUn0rKnpjZ0Qzkm98FVjkvct9CxUOGMBlEZ4impiyi1YZYY3x247fUjHUa
 q+z62POKDq9dDi5zlOs/p6a2QqeLVK6Ueo7z9dFUYzMf8Z95y0Xw767geVNCS2MccvXN
 HtIg==
X-Gm-Message-State: AJIora8eQmoE9p44xF4vygkdJ+53vNVDQMJ/TXt92FrOZV8cNL0M5ypd
 3W51umIRXhJ6VP4lgmLwjaK5bwBihFkoNiZMABk0Ub5k31ieAM/buWd6kETRKu8eR/E40NVBA5u
 lN4CUbD9vePzAxHm47Cms84OuU6/uJA==
X-Received: by 2002:a05:6602:3311:b0:669:d9d7:1026 with SMTP id
 b17-20020a056602331100b00669d9d71026mr5845180ioz.3.1656025247390; 
 Thu, 23 Jun 2022 16:00:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s4e7FapPhiWbwyg7k9pxgE/9jBqkSjaoFx8Qxcthe61Ap3+36D6aUVxzWKfQ185aqMc4RTqg==
X-Received: by 2002:a05:6602:3311:b0:669:d9d7:1026 with SMTP id
 b17-20020a056602331100b00669d9d71026mr5845165ioz.3.1656025247044; 
 Thu, 23 Jun 2022 16:00:47 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 f63-20020a0284c5000000b00339c2c0d123sm300924jai.116.2022.06.23.16.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jun 2022 16:00:46 -0700 (PDT)
Date: Thu, 23 Jun 2022 17:00:44 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 1/2] vfio/type1: Simplify bus_type determination
Message-ID: <20220623170044.1757267d.alex.williamson@redhat.com>
In-Reply-To: <68263bd7-4528-7acb-b11f-6b1c6c8c72ef@arm.com>
References: <b1d13cade281a7d8acbfd0f6a33dcd086207952c.1655898523.git.robin.murphy@arm.com>
 <20220622161721.469fc9eb.alex.williamson@redhat.com>
 <68263bd7-4528-7acb-b11f-6b1c6c8c72ef@arm.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, iommu@lists.linux.dev, jgg@nvidia.com
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

On Thu, 23 Jun 2022 13:23:05 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 2022-06-22 23:17, Alex Williamson wrote:
> > On Wed, 22 Jun 2022 13:04:11 +0100
> > Robin Murphy <robin.murphy@arm.com> wrote:
> >   
> >> Since IOMMU groups are mandatory for drivers to support, it stands to
> >> reason that any device which has been successfully be added to a group  
> > 
> > s/be //  
> 
> Oops.
> 
> >> must be on a bus supported by that IOMMU driver, and therefore a domain
> >> viable for any device in the group must be viable for all devices in
> >> the group. This already has to be the case for the IOMMU API's internal
> >> default domain, for instance. Thus even if the group contains devices on
> >> different buses, that can only mean that the IOMMU driver actually
> >> supports such an odd topology, and so without loss of generality we can
> >> expect the bus type of any device in a group to be suitable for IOMMU
> >> API calls.
> >>
> >> Replace vfio_bus_type() with a simple call to resolve an appropriate
> >> member device from which to then derive a bus type. This is also a step
> >> towards removing the vague bus-based interfaces from the IOMMU API, when
> >> we can subsequently switch to using this device directly.
> >>
> >> Furthermore, scrutiny reveals a lack of protection for the bus being
> >> removed while vfio_iommu_type1_attach_group() is using it; the reference
> >> that VFIO holds on the iommu_group ensures that data remains valid, but
> >> does not prevent the group's membership changing underfoot. Holding the
> >> vfio_device for as long as we need here also neatly solves this.
> >>
> >> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >> ---
> >>
> >> After sleeping on it, I decided to type up the helper function approach
> >> to see how it looked in practice, and in doing so realised that with one
> >> more tweak it could also subsume the locking out of the common paths as
> >> well, so end up being a self-contained way for type1 to take care of its
> >> own concern, which I rather like.
> >>
> >>   drivers/vfio/vfio.c             | 18 +++++++++++++++++-
> >>   drivers/vfio/vfio.h             |  3 +++
> >>   drivers/vfio/vfio_iommu_type1.c | 30 +++++++++++-------------------
> >>   3 files changed, 31 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> >> index 61e71c1154be..73bab04880d0 100644
> >> --- a/drivers/vfio/vfio.c
> >> +++ b/drivers/vfio/vfio.c
> >> @@ -448,7 +448,7 @@ static void vfio_group_get(struct vfio_group *group)
> >>    * Device objects - create, release, get, put, search
> >>    */
> >>   /* Device reference always implies a group reference */
> >> -static void vfio_device_put(struct vfio_device *device)
> >> +void vfio_device_put(struct vfio_device *device)
> >>   {
> >>   	if (refcount_dec_and_test(&device->refcount))
> >>   		complete(&device->comp);
> >> @@ -475,6 +475,22 @@ static struct vfio_device *vfio_group_get_device(struct vfio_group *group,
> >>   	return NULL;
> >>   }
> >>   
> >> +struct vfio_device *vfio_device_get_from_iommu(struct iommu_group *iommu_group)
> >> +{
> >> +	struct vfio_group *group = vfio_group_get_from_iommu(iommu_group);
> >> +	struct vfio_device *device;  
> > 
> > Check group for NULL.  
> 
> OK - FWIW in context this should only ever make sense to call with an 
> iommu_group which has already been derived from a vfio_group, and I did 
> initially consider a check with a WARN_ON(), but then decided that the 
> unguarded dereference would be a sufficiently strong message. No problem 
> with bringing that back to make it more defensive if that's what you prefer.

A while down the road, that's a bit too much implicit knowledge of the
intent and single purpose of this function just to simply avoid a test.

> >> +
> >> +	mutex_lock(&group->device_lock);
> >> +	list_for_each_entry(device, &group->device_list, group_next) {
> >> +		if (vfio_device_try_get(device)) {
> >> +			mutex_unlock(&group->device_lock);
> >> +			return device;
> >> +		}
> >> +	}
> >> +	mutex_unlock(&group->device_lock);
> >> +	return NULL;  
> > 
> > No vfio_group_put() on either path.  
> 
> Oops indeed.
> 
> >> +}
> >> +
> >>   /*
> >>    * VFIO driver API
> >>    */
> >> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> >> index a67130221151..e8f21e64541b 100644
> >> --- a/drivers/vfio/vfio.h
> >> +++ b/drivers/vfio/vfio.h
> >> @@ -70,3 +70,6 @@ struct vfio_iommu_driver_ops {
> >>   
> >>   int vfio_register_iommu_driver(const struct vfio_iommu_driver_ops *ops);
> >>   void vfio_unregister_iommu_driver(const struct vfio_iommu_driver_ops *ops);
> >> +
> >> +struct vfio_device *vfio_device_get_from_iommu(struct iommu_group *iommu_group);
> >> +void vfio_device_put(struct vfio_device *device);
> >> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> >> index c13b9290e357..e38b8bfde677 100644
> >> --- a/drivers/vfio/vfio_iommu_type1.c
> >> +++ b/drivers/vfio/vfio_iommu_type1.c
> >> @@ -1679,18 +1679,6 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
> >>   	return ret;
> >>   }
> >>   
> >> -static int vfio_bus_type(struct device *dev, void *data)
> >> -{
> >> -	struct bus_type **bus = data;
> >> -
> >> -	if (*bus && *bus != dev->bus)
> >> -		return -EINVAL;
> >> -
> >> -	*bus = dev->bus;
> >> -
> >> -	return 0;
> >> -}
> >> -
> >>   static int vfio_iommu_replay(struct vfio_iommu *iommu,
> >>   			     struct vfio_domain *domain)
> >>   {
> >> @@ -2159,7 +2147,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
> >>   	struct vfio_iommu *iommu = iommu_data;
> >>   	struct vfio_iommu_group *group;
> >>   	struct vfio_domain *domain, *d;
> >> -	struct bus_type *bus = NULL;
> >> +	struct vfio_device *iommu_api_dev;
> >>   	bool resv_msi, msi_remap;
> >>   	phys_addr_t resv_msi_base = 0;
> >>   	struct iommu_domain_geometry *geo;
> >> @@ -2192,18 +2180,19 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
> >>   		goto out_unlock;
> >>   	}
> >>   
> >> -	/* Determine bus_type in order to allocate a domain */
> >> -	ret = iommu_group_for_each_dev(iommu_group, &bus, vfio_bus_type);
> >> -	if (ret)
> >> +	/* Resolve the group back to a member device for IOMMU API ops */
> >> +	ret = -ENODEV;
> >> +	iommu_api_dev = vfio_device_get_from_iommu(iommu_group);
> >> +	if (!iommu_api_dev)
> >>   		goto out_free_group;
> >>   
> >>   	ret = -ENOMEM;
> >>   	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> >>   	if (!domain)
> >> -		goto out_free_group;
> >> +		goto out_put_dev;
> >>   
> >>   	ret = -EIO;
> >> -	domain->domain = iommu_domain_alloc(bus);
> >> +	domain->domain = iommu_domain_alloc(iommu_api_dev->dev->bus);  
> > 
> > It makes sense to move away from a bus centric interface to iommu ops
> > and I can see that having a device interface when we have device level
> > address-ability within a group makes sense, but does it make sense to
> > only have that device level interface?  For example, if an iommu_group
> > is going to remain an aspect of the iommu subsystem, shouldn't we be
> > able to allocate a domain and test capabilities based on the group and
> > the iommu driver should have enough embedded information reachable from
> > the struct iommu_group to do those things?  This "perform group level
> > operations based on an arbitrary device in the group" is pretty klunky.  
> 
> The fact* is that devices (and domains) are the fundamental units of the 
> IOMMU API internals, due to what's most practical within the Linux 
> driver model, while groups remain more of a mid-level abstraction - 
> IOMMU drivers themselves are only aware of groups at all in terms of 
> whether they can physically distinguish a given device from others. The 
> client-driver-facing API is already moving back to being device-centric, 
> because that's what fits everyone else's usage models, and we concluded 
> that exposing the complexity of groups everywhere was more trouble than 
> it's worth.
> 
> So yes, technically we could implement an iommu_group_capable() and an 
> iommu_group_domain_alloc(), which would still just internally resolve 
> the IOMMU ops and instance data from a member device to perform the 
> driver-level call, but once again it would be for the benefit of 
> precisely one user. And I really have minimal enthusiasm for diverging 
> any further into one IOMMU API for everyone else plus a separate special 
> IOMMU API for VFIO type1, when type1 is supposed to be the 
> VFIO-to-IOMMU-API translation layer anyway! To look at it another way, 
> if most of the complexity of groups is for VFIO's benefit, then why 
> *shouldn't* VFIO take responsibility for some of the fiddly details that 
> don't matter to anyone else?


Hmm, I agree, but I can't get past vfio-core exporting a function to
select an arbitrary vfio_device from an iommu_group.  What if type1 was
passed an opaque vfio_group pointer and vfio exported a function to
iterate each vfio_device in that vfio_group?  We'd need to export
vfio_device_try_get() and vfio_device_put() and type1 itself would stop
on the first vfio_device object it can get.  Sort of the v1 approach,
but with a vfio iterator rather than iommu.

I'd lean towards Kevin's idea that we could store bus_type on the
vfio_group and pass that to type1, with the same assumptions we're
making in the commit log that it's consistent, but that doesn't get us
closer to the long term plan of dropping the bus_type interfaces AIUI.
Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
