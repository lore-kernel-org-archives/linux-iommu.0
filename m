Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810EDC43334
	for <iommu@archiver.kernel.org>; Sat, 25 Jun 2022 19:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0466B60F84;
	Sat, 25 Jun 2022 19:52:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0466B60F84
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fReGelXY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wRvHSP77ti9S; Sat, 25 Jun 2022 19:52:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B1E7960F66;
	Sat, 25 Jun 2022 19:52:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1E7960F66
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84A89C0039;
	Sat, 25 Jun 2022 19:52:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AEAEC002D
 for <iommu@lists.linux-foundation.org>; Sat, 25 Jun 2022 19:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 105F983EE9
 for <iommu@lists.linux-foundation.org>; Sat, 25 Jun 2022 19:52:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 105F983EE9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=fReGelXY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0-rZkhcB7L7x for <iommu@lists.linux-foundation.org>;
 Sat, 25 Jun 2022 19:52:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 43C4983ED6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 43C4983ED6
 for <iommu@lists.linux-foundation.org>; Sat, 25 Jun 2022 19:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656186728; x=1687722728;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=47Jqfx1NohYaYKLginO4ikhq1M0z7eg6k0Svy4OXQro=;
 b=fReGelXYVr34K1EH8UfSQKMse/4aNp6L67FS97mkOhg3DQ2Zjch17RQd
 5PBcIfGtk/qfDbfw9BKBNZVUZSKvZS7XR9qGWq510vTlB7IjP9KTymU8o
 N9OgK+wva7fe+Faw/IaLsUDEB/HwAdVq3gR/CupbOu8cpK8X/BKRmXJv3
 m9vVua0Kirzs77QksoFH2BytQ8uLJVwsDobF6QDGjTj0RLhDTHBRigE/5
 wz5BuHHikm9/qH0uDMnJWtUOSR0PESCNTqAwaO6hxcfRKKTVpitPWSK/Q
 6XvKWnSFS5C/8Uwf0stPPOGnLCU0ZmEIquxGR0fKXMH3j53KCzqaifCLm w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="367531096"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; d="scan'208";a="367531096"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2022 12:52:07 -0700
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; d="scan'208";a="678991598"
Received: from fyu1.sc.intel.com ([172.25.103.126])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2022 12:52:07 -0700
Date: Sat, 25 Jun 2022 12:52:27 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: iommu_sva_bind_device question
Message-ID: <Yrdne20Eq+5KwF5h@fyu1.sc.intel.com>
References: <20220623170232.6whonfjuh3m5vcoy@cantor>
 <6639b21c-1544-a025-4da5-219a1608f06e@linux.intel.com>
 <20220624011446.2bexm4sjo2vabay5@cantor>
 <552074ff-fd32-8cdb-cc10-1d71319c71db@linux.intel.com>
 <20220624134102.qxid72gqghjhyozn@cantor>
 <20220624144730.a6ork4dbjixnfhbf@cantor>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220624144730.a6ork4dbjixnfhbf@cantor>
Cc: dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org,
 Dave Jiang <dave.jiang@intel.com>
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

Hi, Jerry and Baolu,

On Fri, Jun 24, 2022 at 07:47:30AM -0700, Jerry Snitselaar wrote:
> > > > > > Hi Baolu & Dave,
> > > > fails.
> > > > 
> > > > You also will get the following warning if you don't have scalable
> > > > mode enabled (either not enabled by default, or if enabled by default
> > > > and passed intel_iommu=on,sm_off):
> > > 
> > > If scalable mode is disabled, iommu_dev_enable_feature(IOMMU_SVA) will
> > > return failure, hence driver should not call iommu_sva_bind_device().
> > > I guess below will disappear if above is fixed in the idxd driver.

Yes, Jerry's patch fixes the WARNING as well.

> > > 
> > > Best regards,
> > > baolu
> > >
> > 
> > It looks like there was a recent maintainer change, and Fenghua is now
> > the maintainer. Fenghua thoughts on this? With 42a1b73852c4
> > ("dmaengine: idxd: Separate user and kernel pasid enabling") the code
> > no longer depends on iommu_dev_feature_enable succeeding. Testing with
> > something like this works (ran dmatest without sm_on, and
> > dsa_user_test_runner.sh with sm_on, plus booting with various
> > intel_iommu= combinations):
> > 
> > diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> > index 355fb3ef4cbf..5b49fd5c1e25 100644
> > --- a/drivers/dma/idxd/init.c
> > +++ b/drivers/dma/idxd/init.c
> > @@ -514,13 +514,14 @@ static int idxd_probe(struct idxd_device *idxd)
> >         if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
> >                 if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA))
> >                         dev_warn(dev, "Unable to turn on user SVA feature.\n");
> > -               else
> > +               else {
> >                         set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
> > 
> > -               if (idxd_enable_system_pasid(idxd))

Please add "{" after this if.

> > -                       dev_warn(dev, "No in-kernel DMA with PASID.\n");
> > -               else
then "}" before this else.

> > -                       set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> > +                       if (idxd_enable_system_pasid(idxd))
> > +                               dev_warn(dev, "No in-kernel DMA with PASID.\n");
> > +                       else
> > +                               set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> > +               }
> >         } else if (!sva) {
> >                 dev_warn(dev, "User forced SVA off via module param.\n");
> >         }

The patch was copied/pasted here. So the tabs are lost at beginning of each
line. So it cannot be applied. Please change the tabs back.

Could you please send this patch in a separate email so that it has a
right patch format and description and ready to be picked up?

> > 
> > The commit description is a bit confusing, because it talks about there
> > being no dependency, but ties user pasid to enabling/disabling the SVA
> > feature, which system pasid would depend on as well.
> > 
> > Regards,
> > Jerry
> 
> Things like that warning message "Unable to turn on user SVA feature" when
> iommu_dev_enable_feature fails though seems to be misleading with user
> inserted in there. I'll leave it to the idxd folks to figure out.

How about removing "user" from the warning message? So the message will
be "Unable to turn on SVA feature"?

Thanks.

-Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
