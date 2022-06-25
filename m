Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CFCC43334
	for <iommu@archiver.kernel.org>; Sat, 25 Jun 2022 21:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B129D41548;
	Sat, 25 Jun 2022 21:33:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B129D41548
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JQA4mf4s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UJZELbMmAXvq; Sat, 25 Jun 2022 21:33:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0F2AE41511;
	Sat, 25 Jun 2022 21:33:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F2AE41511
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1310C0039;
	Sat, 25 Jun 2022 21:33:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33F37C002D
 for <iommu@lists.linux-foundation.org>; Sat, 25 Jun 2022 21:33:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 081CE41046
 for <iommu@lists.linux-foundation.org>; Sat, 25 Jun 2022 21:33:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 081CE41046
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JQA4mf4s
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LnDRNYdkFume for <iommu@lists.linux-foundation.org>;
 Sat, 25 Jun 2022 21:33:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D89004018F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D89004018F
 for <iommu@lists.linux-foundation.org>; Sat, 25 Jun 2022 21:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656192798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZjAOJJmte7WRiyCc6Q0LCvObU2AofHsmmXcwQFMuZ90=;
 b=JQA4mf4st3qXxs4Qo3fpjeZbgHGQZGkyOUem1UZVdFUT0FwOwXSYiZcGX1gRdcsHkl4A9a
 RMeTj8uBnKSZGVMTTQcuiU7FRcUw+sKnvXk3O2DwPWLlxtGh++OdywM6v/pXclQFdtH4wC
 k3C09QvgxHp6YTn+Eyd7ZlUaOkAHkZ8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-Q9JAn7agNiahsklCngRogw-1; Sat, 25 Jun 2022 17:33:17 -0400
X-MC-Unique: Q9JAn7agNiahsklCngRogw-1
Received: by mail-pl1-f200.google.com with SMTP id
 k11-20020a170902ce0b00b0016a15fe2627so3223255plg.22
 for <iommu@lists.linux-foundation.org>; Sat, 25 Jun 2022 14:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZjAOJJmte7WRiyCc6Q0LCvObU2AofHsmmXcwQFMuZ90=;
 b=ViLGPW9ocXioQadIVFTWpDKYx5R5NuyfOuuKT4H4vlQlOBE7wkctwlNfaEb++TmmNi
 vbm7/U8v+Fh6WnkNvqncL+JAX3iMrhaXlEoX7zGJu1mlvzU+cm11ZeXTsaiNP5ecJpnC
 Hf9eBZ+yG4BmceRftY+lvl50kZPEnBU3UXA90oPgpmMcJTncma6lo9B3vb2JzS8n2VAJ
 zzoGYqXRnOgWYCAgWRNBeAXdwduuIbfQLLdvGEsCm9TxrG3K3UVCnFQX7lka0edjuesL
 HF2xhq3hmA+/GYY6GeBoFEbhM9CV70uGejxjO9+8zBvCrbdDH1MlJ7xANE3DH3q2uZ6g
 Qdzg==
X-Gm-Message-State: AJIora9pmPTcj9tSyCknO9Kj33yHJ8ib8WW+INkunNEjme9mFnixTuXz
 4Q0+ifbMvVA4JhHrJ12S/1o89j+AkLMckS48A5RoPzCEgPJ3TJJ4bQpxmd+sPjNE+dLoMwVeV+l
 s+9BvDCe7BpP8EmlJf5v2gfclXs3rDw==
X-Received: by 2002:a63:4741:0:b0:40d:4e20:6662 with SMTP id
 w1-20020a634741000000b0040d4e206662mr5002068pgk.520.1656192796135; 
 Sat, 25 Jun 2022 14:33:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u8Mg4SsmJ2O/6nuE5zeoHw2Bo2AjI++cHcHSo7BLFqJnAHHCdsPe0QuRb4UelUjMMBw6Lwag==
X-Received: by 2002:a63:4741:0:b0:40d:4e20:6662 with SMTP id
 w1-20020a634741000000b0040d4e206662mr5002048pgk.520.1656192795818; 
 Sat, 25 Jun 2022 14:33:15 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
 by smtp.gmail.com with ESMTPSA id
 ij26-20020a170902ab5a00b0016a1b60b19dsm4154831plb.91.2022.06.25.14.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jun 2022 14:33:15 -0700 (PDT)
Date: Sat, 25 Jun 2022 14:33:13 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: iommu_sva_bind_device question
Message-ID: <20220625213313.ekpo5vbowxlx4uwf@cantor>
References: <20220623170232.6whonfjuh3m5vcoy@cantor>
 <6639b21c-1544-a025-4da5-219a1608f06e@linux.intel.com>
 <20220624011446.2bexm4sjo2vabay5@cantor>
 <552074ff-fd32-8cdb-cc10-1d71319c71db@linux.intel.com>
 <20220624134102.qxid72gqghjhyozn@cantor>
 <20220624144730.a6ork4dbjixnfhbf@cantor>
 <Yrdne20Eq+5KwF5h@fyu1.sc.intel.com>
MIME-Version: 1.0
In-Reply-To: <Yrdne20Eq+5KwF5h@fyu1.sc.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnitsel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Sat, Jun 25, 2022 at 12:52:27PM -0700, Fenghua Yu wrote:
> Hi, Jerry and Baolu,
> 
> On Fri, Jun 24, 2022 at 07:47:30AM -0700, Jerry Snitselaar wrote:
> > > > > > > Hi Baolu & Dave,
> > > > > fails.
> > > > > 
> > > > > You also will get the following warning if you don't have scalable
> > > > > mode enabled (either not enabled by default, or if enabled by default
> > > > > and passed intel_iommu=on,sm_off):
> > > > 
> > > > If scalable mode is disabled, iommu_dev_enable_feature(IOMMU_SVA) will
> > > > return failure, hence driver should not call iommu_sva_bind_device().
> > > > I guess below will disappear if above is fixed in the idxd driver.
> 
> Yes, Jerry's patch fixes the WARNING as well.
> 
> > > > 
> > > > Best regards,
> > > > baolu
> > > >
> > > 
> > > It looks like there was a recent maintainer change, and Fenghua is now
> > > the maintainer. Fenghua thoughts on this? With 42a1b73852c4
> > > ("dmaengine: idxd: Separate user and kernel pasid enabling") the code
> > > no longer depends on iommu_dev_feature_enable succeeding. Testing with
> > > something like this works (ran dmatest without sm_on, and
> > > dsa_user_test_runner.sh with sm_on, plus booting with various
> > > intel_iommu= combinations):
> > > 
> > > diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> > > index 355fb3ef4cbf..5b49fd5c1e25 100644
> > > --- a/drivers/dma/idxd/init.c
> > > +++ b/drivers/dma/idxd/init.c
> > > @@ -514,13 +514,14 @@ static int idxd_probe(struct idxd_device *idxd)
> > >         if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
> > >                 if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA))
> > >                         dev_warn(dev, "Unable to turn on user SVA feature.\n");
> > > -               else
> > > +               else {
> > >                         set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
> > > 
> > > -               if (idxd_enable_system_pasid(idxd))
> 
> Please add "{" after this if.
> 
> > > -                       dev_warn(dev, "No in-kernel DMA with PASID.\n");
> > > -               else
> then "}" before this else.
> 
> > > -                       set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> > > +                       if (idxd_enable_system_pasid(idxd))
> > > +                               dev_warn(dev, "No in-kernel DMA with PASID.\n");
> > > +                       else
> > > +                               set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> > > +               }
> > >         } else if (!sva) {
> > >                 dev_warn(dev, "User forced SVA off via module param.\n");
> > >         }
> 
> The patch was copied/pasted here. So the tabs are lost at beginning of each
> line. So it cannot be applied. Please change the tabs back.
> 
> Could you please send this patch in a separate email so that it has a
> right patch format and description and ready to be picked up?
> 

Sure, if you feel this is the correct solution. Just to be clear you would
like the end result to be:

	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
		if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA))
			dev_warn(dev, "Unable to turn on user SVA feature.\n");
		else {
			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);

			if (idxd_enable_system_pasid(idxd)) {
				dev_warn(dev, "No in-kernel DMA with PASID.\n");
			} else
				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
		}
	} else if (!sva) {
		dev_warn(dev, "User forced SVA off via module param.\n");
	}


> > > 
> > > The commit description is a bit confusing, because it talks about there
> > > being no dependency, but ties user pasid to enabling/disabling the SVA
> > > feature, which system pasid would depend on as well.
> > > 
> > > Regards,
> > > Jerry
> > 
> > Things like that warning message "Unable to turn on user SVA feature" when
> > iommu_dev_enable_feature fails though seems to be misleading with user
> > inserted in there. I'll leave it to the idxd folks to figure out.
> 
> How about removing "user" from the warning message? So the message will
> be "Unable to turn on SVA feature"?
>

I think what was confusing to me is it seemed to tie the SVA iommu
feature to the user, and talked about independence of the kernel and
user pasids. I understand the pasids themselves being independent, but
both depend on the SVA feature being enabled. So idxd_enable_system_pasid
can only happen if iommu_dev_feature_enable(dev, IOMMU_DEV_FEAT_SVA)
has succeeded prior to it, and idxd_disable_system_pasid should be
called if needed before there is a call to
iommu_dev_feature_disable(dev, IOMMU_DEV_FEAT_SVA).

When I looked at the code that seemed to be the case outside of this
block in idxd_probe, but I wasn't sure if I was missing something else.

Regards,
Jerry

> Thanks.
> 
> -Fenghua

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
