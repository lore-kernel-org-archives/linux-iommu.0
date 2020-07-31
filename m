Return-Path: <SRS0=v9UM=BK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677FFC433E0
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 18:14:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3AE2177B
	for <iommu@archiver.kernel.org>; Fri, 31 Jul 2020 18:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T75L1Vmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3AE2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 143E7887C7;
	Fri, 31 Jul 2020 18:14:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h73I5RS7ax17; Fri, 31 Jul 2020 18:14:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6C7F0887BF;
	Fri, 31 Jul 2020 18:14:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 616B2C004F;
	Fri, 31 Jul 2020 18:14:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 132C2C004D
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 18:14:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EF598887C0
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 18:14:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dbpGTh-O9sWK for <iommu@lists.linux-foundation.org>;
 Fri, 31 Jul 2020 18:14:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5925A887BF
 for <iommu@lists.linux-foundation.org>; Fri, 31 Jul 2020 18:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596219264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h5RCnyOaFSBCI3Qz6zkjCZ63e5lETgkYf1JyHMYznJQ=;
 b=T75L1VmuKn87aEA1Ac94iyH6oSjK3TP2MBmqr+En+JSWWG6gfAl3LybtuKvoVZ/q+ME/dp
 0jMufEOvwkvNKx0k7Tvql4HLDpDUyVufgt9s1NgYyqWwJ35Qhn1sCA+8/KkHEUGEf0UxWZ
 LjreQFuKIz4Qc+EkY9dSoKc1LI0XJi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-wSMzoo6iOy6LHz813pxjOA-1; Fri, 31 Jul 2020 14:14:22 -0400
X-MC-Unique: wSMzoo6iOy6LHz813pxjOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CA0318839CD;
 Fri, 31 Jul 2020 18:14:20 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 732831002388;
 Fri, 31 Jul 2020 18:14:19 +0000 (UTC)
Date: Fri, 31 Jul 2020 12:14:18 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 3/4] iommu: Add iommu_aux_get_domain_for_dev()
Message-ID: <20200731121418.0274afb8@x1.home>
In-Reply-To: <06fd91c1-a978-d526-7e2b-fec619a458e4@linux.intel.com>
References: <20200714055703.5510-1-baolu.lu@linux.intel.com>
 <20200714055703.5510-4-baolu.lu@linux.intel.com>
 <20200729142507.182cd18a@x1.home>
 <06fd91c1-a978-d526-7e2b-fec619a458e4@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
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

On Fri, 31 Jul 2020 14:30:03 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Alex,
> 
> On 2020/7/30 4:25, Alex Williamson wrote:
> > On Tue, 14 Jul 2020 13:57:02 +0800
> > Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> >   
> >> The device driver needs an API to get its aux-domain. A typical usage
> >> scenario is:
> >>
> >>          unsigned long pasid;
> >>          struct iommu_domain *domain;
> >>          struct device *dev = mdev_dev(mdev);
> >>          struct device *iommu_device = vfio_mdev_get_iommu_device(dev);
> >>
> >>          domain = iommu_aux_get_domain_for_dev(dev);
> >>          if (!domain)
> >>                  return -ENODEV;
> >>
> >>          pasid = iommu_aux_get_pasid(domain, iommu_device);
> >>          if (pasid <= 0)
> >>                  return -EINVAL;
> >>
> >>           /* Program the device context */
> >>           ....
> >>
> >> This adds an API for such use case.
> >>
> >> Suggested-by: Alex Williamson<alex.williamson@redhat.com>
> >> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> >> ---
> >>   drivers/iommu/iommu.c | 18 ++++++++++++++++++
> >>   include/linux/iommu.h |  7 +++++++
> >>   2 files changed, 25 insertions(+)
> >>
> >> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >> index cad5a19ebf22..434bf42b6b9b 100644
> >> --- a/drivers/iommu/iommu.c
> >> +++ b/drivers/iommu/iommu.c
> >> @@ -2817,6 +2817,24 @@ void iommu_aux_detach_group(struct iommu_domain *domain,
> >>   }
> >>   EXPORT_SYMBOL_GPL(iommu_aux_detach_group);
> >>   
> >> +struct iommu_domain *iommu_aux_get_domain_for_dev(struct device *dev)
> >> +{
> >> +	struct iommu_domain *domain = NULL;
> >> +	struct iommu_group *group;
> >> +
> >> +	group = iommu_group_get(dev);
> >> +	if (!group)
> >> +		return NULL;
> >> +
> >> +	if (group->aux_domain_attached)
> >> +		domain = group->domain;  
> > Why wouldn't the aux domain flag be on the domain itself rather than
> > the group?  Then if we wanted sanity checking in patch 1/ we'd only
> > need to test the flag on the object we're provided.  
> 
> Agreed. Given that a group may contain both non-aux and aux devices,
> adding such flag in iommu_group doesn't make sense.
> 
> > 
> > If we had such a flag, we could create an iommu_domain_is_aux()
> > function and then simply use iommu_get_domain_for_dev() and test that
> > it's an aux domain in the example use case.  It seems like that would
> > resolve the jump from a domain to an aux-domain just as well as adding
> > this separate iommu_aux_get_domain_for_dev() interface.  The is_aux
> > test might also be useful in other cases too.  
> 
> Let's rehearsal our use case.
> 
>          unsigned long pasid;
>          struct iommu_domain *domain;
>          struct device *dev = mdev_dev(mdev);
>          struct device *iommu_device = vfio_mdev_get_iommu_device(dev);
> 
> [1]     domain = iommu_get_domain_for_dev(dev);
>          if (!domain)
>                  return -ENODEV;
> 
> [2]     pasid = iommu_aux_get_pasid(domain, iommu_device);
>          if (pasid <= 0)
>                  return -EINVAL;
> 
>           /* Program the device context */
>           ....
> 
> The reason why I add this iommu_aux_get_domain_for_dev() is that we need
> to make sure the domain got at [1] is valid to be used at [2].
> 
> https://lore.kernel.org/linux-iommu/20200707150408.474d81f1@x1.home/

Yep, I thought that was a bit of a leap in logic.

> When calling into iommu_aux_get_pasid(), the iommu driver should make
> sure that @domain is a valid aux-domain for @iommu_device. Hence, for
> our use case, it seems that there's no need for a is_aux_domain() api.
> 
> Anyway, I'm not against adding a new is_aux_domain() api if there's a
> need elsewhere.

I think it could work either way, we could have an
iommu_get_aux_domain_for_dev() which returns NULL if the domain is not
an aux domain, or we could use iommu_get_domain_for_dev() and the
caller could test the domain with iommu_is_aux_domain() if they need to
confirm if it's an aux domain.  The former could even be written using
the latter, a wrapper of iommu_get_domain_for_dev() that checks aux
property before returning.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
