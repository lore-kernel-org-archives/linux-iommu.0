Return-Path: <SRS0=urD1=5S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF25C43331
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 17:59:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B472078B
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 17:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4TatPre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B472078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 60A6C88F89;
	Thu,  2 Apr 2020 17:59:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GuB52-o2WcsI; Thu,  2 Apr 2020 17:58:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C580688F87;
	Thu,  2 Apr 2020 17:58:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB7CCC1AE2;
	Thu,  2 Apr 2020 17:58:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23DE2C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 17:58:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 12BCB86019
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 17:58:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a3hGY0yh7FLS for <iommu@lists.linux-foundation.org>;
 Thu,  2 Apr 2020 17:58:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D86E985FC0
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 17:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585850336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+UzGBAyCOwnRp2qUqh7GymZdca86W4ussAYAJSlbIs=;
 b=H4TatPreBDs01QjHUejUFv4V2I/AqfmpH9CPY89qqkzoUZGTU5Tfv+F+Awyh82J5z52Ss7
 QPiDUQ+PyfaQFm6DzKyQxuRPGMJ4YAYqy0u82J2uLWZWmCMSoJgvmOg4V1piNo6d4m8x4E
 DT9plI28WKjH5dPJgtLIdxD4KdmdYZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-Z9Whas84MPeFLJQgXODzHw-1; Thu, 02 Apr 2020 13:58:53 -0400
X-MC-Unique: Z9Whas84MPeFLJQgXODzHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBCA91021848;
 Thu,  2 Apr 2020 17:58:41 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 307561147CF;
 Thu,  2 Apr 2020 17:58:32 +0000 (UTC)
Date: Thu, 2 Apr 2020 11:58:31 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v1 2/8] vfio/type1: Add vfio_iommu_type1 parameter for
 quota tuning
Message-ID: <20200402115831.22e31611@w520.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7FF888@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-3-git-send-email-yi.l.liu@intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FF3C5@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A217C68@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FF46F@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A217D97@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FF888@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, 
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

On Mon, 30 Mar 2020 11:44:08 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Monday, March 30, 2020 5:27 PM
> >   
> > > From: Tian, Kevin <kevin.tian@intel.com>
> > > Sent: Monday, March 30, 2020 5:20 PM
> > > To: Liu, Yi L <yi.l.liu@intel.com>; alex.williamson@redhat.com;
> > > Subject: RE: [PATCH v1 2/8] vfio/type1: Add vfio_iommu_type1 parameter  
> > for quota  
> > > tuning
> > >  
> > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > Sent: Monday, March 30, 2020 4:53 PM
> > > >  
> > > > > From: Tian, Kevin <kevin.tian@intel.com>
> > > > > Sent: Monday, March 30, 2020 4:41 PM
> > > > > To: Liu, Yi L <yi.l.liu@intel.com>; alex.williamson@redhat.com;
> > > > > Subject: RE: [PATCH v1 2/8] vfio/type1: Add vfio_iommu_type1
> > > > > parameter  
> > > > for quota  
> > > > > tuning
> > > > >  
> > > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > > Sent: Sunday, March 22, 2020 8:32 PM
> > > > > >
> > > > > > From: Liu Yi L <yi.l.liu@intel.com>
> > > > > >
> > > > > > This patch adds a module option to make the PASID quota tunable by
> > > > > > administrator.
> > > > > >
> > > > > > TODO: needs to think more on how to  make the tuning to be per-  
> > process.  
> > > > > >
> > > > > > Previous discussions:
> > > > > > https://patchwork.kernel.org/patch/11209429/
> > > > > >
> > > > > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > > > > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > > > > Cc: Eric Auger <eric.auger@redhat.com>
> > > > > > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > > > > ---
> > > > > >  drivers/vfio/vfio.c             | 8 +++++++-
> > > > > >  drivers/vfio/vfio_iommu_type1.c | 7 ++++++-
> > > > > >  include/linux/vfio.h            | 3 ++-
> > > > > >  3 files changed, 15 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c index
> > > > > > d13b483..020a792 100644
> > > > > > --- a/drivers/vfio/vfio.c
> > > > > > +++ b/drivers/vfio/vfio.c
> > > > > > @@ -2217,13 +2217,19 @@ struct vfio_mm  
> > > > *vfio_mm_get_from_task(struct  
> > > > > > task_struct *task)
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(vfio_mm_get_from_task);
> > > > > >
> > > > > > -int vfio_mm_pasid_alloc(struct vfio_mm *vmm, int min, int max)
> > > > > > +int vfio_mm_pasid_alloc(struct vfio_mm *vmm, int quota, int min,
> > > > > > +int  
> > > > max)  
> > > > > >  {
> > > > > >  	ioasid_t pasid;
> > > > > >  	int ret = -ENOSPC;
> > > > > >
> > > > > >  	mutex_lock(&vmm->pasid_lock);
> > > > > >
> > > > > > +	/* update quota as it is tunable by admin */
> > > > > > +	if (vmm->pasid_quota != quota) {
> > > > > > +		vmm->pasid_quota = quota;
> > > > > > +		ioasid_adjust_set(vmm->ioasid_sid, quota);
> > > > > > +	}
> > > > > > +  
> > > > >
> > > > > It's a bit weird to have quota adjusted in the alloc path, since the
> > > > > latter  
> > > > might  
> > > > > be initiated by non-privileged users. Why not doing the simple math
> > > > > in  
> > > > vfio_  
> > > > > create_mm to set the quota when the ioasid set is created? even in
> > > > > the  
> > > > future  
> > > > > you may allow per-process quota setting, that should come from
> > > > > separate privileged path instead of thru alloc..  
> > > >
> > > > The reason is the kernel parameter modification has no event which can
> > > > be used to adjust the quota. So I chose to adjust it in pasid_alloc
> > > > path. If it's not good, how about adding one more IOCTL to let user-
> > > > space trigger a quota adjustment event? Then even non-privileged user
> > > > could trigger quota adjustment, the quota is actually controlled by
> > > > privileged user. How about your opinion?
> > > >  
> > >
> > > why do you need an event to adjust? As I said, you can set the quota when  
> > the set is  
> > > created in vfio_create_mm...  
> > 
> > oh, it's to support runtime adjustments. I guess it may be helpful to let
> > per-VM quota tunable even the VM is running. If just set the quota in
> > vfio_create_mm(), it is not able to adjust at runtime.
> >   
> 
> ok, I didn't note the module parameter was granted with a write permission.
> However there is a further problem. We cannot support PASID reclaim now.
> What about the admin sets a quota smaller than previous value while some
> IOASID sets already exceed the new quota? I'm not sure how to fail a runtime
> module parameter change due to that situation. possibly a normal sysfs 
> node better suites the runtime change requirement...

Yep, making this runtime adjustable seems a bit unpredictable and racy,
and it's not clear to me how a user is going to jump in at just the
right time for a user and adjust the limit.  I'd probably go for a
simple non-runtime adjustable module option.  It's a safety net at this
point anyway afaict.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
