Return-Path: <SRS0=LOQj=BI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916F4C433E1
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 20:03:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5645020658
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 20:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aM1RFh0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5645020658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1E62687F43;
	Wed, 29 Jul 2020 20:03:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 22bgKNbbaleB; Wed, 29 Jul 2020 20:03:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 36E1387EFB;
	Wed, 29 Jul 2020 20:03:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E497C0050;
	Wed, 29 Jul 2020 20:03:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CE8DC004D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 20:03:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8243384C1E
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 20:03:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qLJmrUAtrW88 for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jul 2020 20:03:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A35EF84AE2
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 20:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596053024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QeIeIW3OOISCAV7Iy3NjwK504xkdQFp8POlsXJR8oE4=;
 b=aM1RFh0nPeyd2FxsuDwVGhexi6kvACrETboa1EcZKFibOa/TC1+PekdzYmpHsI/rCiV8v1
 W8mN9XZL8OPoXObQFBdbU7Pxshqg6m0z2nRThgfEpsGu7LUSop4f6ws5r+wYJfNLl657mF
 lvEjt9FAumvPXZQtVNowxuYhI+rFcqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-2W7ts5LJMy63kXFMDtbztA-1; Wed, 29 Jul 2020 16:03:40 -0400
X-MC-Unique: 2W7ts5LJMy63kXFMDtbztA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D00F800479;
 Wed, 29 Jul 2020 20:03:38 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D8FB78525;
 Wed, 29 Jul 2020 20:03:37 +0000 (UTC)
Date: Wed, 29 Jul 2020 14:03:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 2/4] iommu: Add iommu_aux_at(de)tach_group()
Message-ID: <20200729140336.09d2bfe7@x1.home>
In-Reply-To: <435a2014-c2e8-06b9-3c9a-4afbf6607ffe@linux.intel.com>
References: <20200714055703.5510-1-baolu.lu@linux.intel.com>
 <20200714055703.5510-3-baolu.lu@linux.intel.com>
 <20200714093909.1ab93c9e@jacob-builder>
 <b5b22e01-4a51-8dfe-9ba4-aeca783740f1@linux.intel.com>
 <20200715090114.50a459d4@jacob-builder>
 <435a2014-c2e8-06b9-3c9a-4afbf6607ffe@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

On Thu, 16 Jul 2020 09:07:46 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Jacob,
> 
> On 7/16/20 12:01 AM, Jacob Pan wrote:
> > On Wed, 15 Jul 2020 08:47:36 +0800
> > Lu Baolu <baolu.lu@linux.intel.com> wrote:
> >   
> >> Hi Jacob,
> >>
> >> On 7/15/20 12:39 AM, Jacob Pan wrote:  
> >>> On Tue, 14 Jul 2020 13:57:01 +0800
> >>> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> >>>      
> >>>> This adds two new aux-domain APIs for a use case like vfio/mdev
> >>>> where sub-devices derived from an aux-domain capable device are
> >>>> created and put in an iommu_group.
> >>>>
> >>>> /**
> >>>>    * iommu_aux_attach_group - attach an aux-domain to an iommu_group
> >>>> which
> >>>>    *                          contains sub-devices (for example
> >>>> mdevs) derived
> >>>>    *                          from @dev.
> >>>>    * @domain: an aux-domain;
> >>>>    * @group:  an iommu_group which contains sub-devices derived from
> >>>> @dev;
> >>>>    * @dev:    the physical device which supports IOMMU_DEV_FEAT_AUX.
> >>>>    *
> >>>>    * Returns 0 on success, or an error value.
> >>>>    */
> >>>> int iommu_aux_attach_group(struct iommu_domain *domain,
> >>>>                              struct iommu_group *group,
> >>>>                              struct device *dev)
> >>>>
> >>>> /**
> >>>>    * iommu_aux_detach_group - detach an aux-domain from an
> >>>> iommu_group *
> >>>>    * @domain: an aux-domain;
> >>>>    * @group:  an iommu_group which contains sub-devices derived from
> >>>> @dev;
> >>>>    * @dev:    the physical device which supports IOMMU_DEV_FEAT_AUX.
> >>>>    *
> >>>>    * @domain must have been attached to @group via
> >>>> iommu_aux_attach_group(). */
> >>>> void iommu_aux_detach_group(struct iommu_domain *domain,
> >>>>                               struct iommu_group *group,
> >>>>                               struct device *dev)
> >>>>
> >>>> It also adds a flag in the iommu_group data structure to identify
> >>>> an iommu_group with aux-domain attached from those normal ones.
> >>>>
> >>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> >>>> ---
> >>>>    drivers/iommu/iommu.c | 58
> >>>> +++++++++++++++++++++++++++++++++++++++++++ include/linux/iommu.h |
> >>>> 17 +++++++++++++ 2 files changed, 75 insertions(+)
> >>>>
> >>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >>>> index e1fdd3531d65..cad5a19ebf22 100644
> >>>> --- a/drivers/iommu/iommu.c
> >>>> +++ b/drivers/iommu/iommu.c
> >>>> @@ -45,6 +45,7 @@ struct iommu_group {
> >>>>    	struct iommu_domain *default_domain;
> >>>>    	struct iommu_domain *domain;
> >>>>    	struct list_head entry;
> >>>> +	unsigned int aux_domain_attached:1;
> >>>>    };
> >>>>    
> >>>>    struct group_device {
> >>>> @@ -2759,6 +2760,63 @@ int iommu_aux_get_pasid(struct iommu_domain
> >>>> *domain, struct device *dev) }
> >>>>    EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
> >>>>    
> >>>> +/**
> >>>> + * iommu_aux_attach_group - attach an aux-domain to an iommu_group
> >>>> which
> >>>> + *                          contains sub-devices (for example
> >>>> mdevs) derived
> >>>> + *                          from @dev.
> >>>> + * @domain: an aux-domain;
> >>>> + * @group:  an iommu_group which contains sub-devices derived from
> >>>> @dev;
> >>>> + * @dev:    the physical device which supports IOMMU_DEV_FEAT_AUX.
> >>>> + *
> >>>> + * Returns 0 on success, or an error value.
> >>>> + */
> >>>> +int iommu_aux_attach_group(struct iommu_domain *domain,
> >>>> +			   struct iommu_group *group, struct
> >>>> device *dev) +{
> >>>> +	int ret = -EBUSY;
> >>>> +
> >>>> +	mutex_lock(&group->mutex);
> >>>> +	if (group->domain)
> >>>> +		goto out_unlock;
> >>>> +  
> >>> Perhaps I missed something but are we assuming only one mdev per
> >>> mdev group? That seems to change the logic where vfio does:
> >>> iommu_group_for_each_dev()
> >>> 	iommu_aux_attach_device()
> >>>      
> >>
> >> It has been changed in PATCH 4/4:
> >>
> >> static int vfio_iommu_attach_group(struct vfio_domain *domain,
> >>                                      struct vfio_group *group)
> >> {
> >>           if (group->mdev_group)
> >>                   return iommu_aux_attach_group(domain->domain,
> >>                                                 group->iommu_group,
> >>                                                 group->iommu_device);
> >>           else
> >>                   return iommu_attach_group(domain->domain,
> >> group->iommu_group);
> >> }
> >>
> >> So, for both normal domain and aux-domain, we use the same concept:
> >> attach a domain to a group.
> >>  
> > I get that, but don't you have to attach all the devices within the  
> 
> This iommu_group includes only mediated devices derived from an
> IOMMU_DEV_FEAT_AUX-capable device. Different from iommu_attach_group(),
> iommu_aux_attach_group() doesn't need to attach the domain to each
> device in group, instead it only needs to attach the domain to the
> physical device where the mdev's were created from.
> 
> > group? Here you see the group already has a domain and exit.  
> 
> If the (group->domain) has been set, that means a domain has already
> attached to the group, so it returns -EBUSY.

I agree with Jacob, singleton groups should not be built into the IOMMU
API, we're not building an interface just for mdevs or current
limitations of mdevs.  This also means that setting a flag on the group
and passing a device that's assumed to be common for all devices within
the group, don't really make sense here.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
