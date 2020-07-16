Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1F6C433E5
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 15:40:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB3952064B
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 15:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hD6l8n5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3952064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8DA59203C7;
	Thu, 16 Jul 2020 15:40:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aCyRlaZAkXYK; Thu, 16 Jul 2020 15:40:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 606E12001C;
	Thu, 16 Jul 2020 15:40:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37D94C0893;
	Thu, 16 Jul 2020 15:40:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AE67C0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 15:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8323287E60
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 15:40:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XvNAitsPn6G5 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 15:40:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B26F787E5D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 15:40:14 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id f12so7024279eja.9
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 08:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=R0hixZr2FmuyDxkOlsaDyB/rdEVS5zH7ZB3SMwB7SjA=;
 b=hD6l8n5tJJDWItbmnePOZqH87rq9e8eH4kwTJjei+YlKoq+eZA6TxVUrekVxY7d3Wr
 sq4TgU+k4PJIOwlPET6TC8b7a9T4l6guHNgOwJ7s8lXuIodZrVm/mBol4m6qXC6pQ0ke
 jeORpF49hRiPTmT1zhAXpBOAXLldbfNj5a9MlouXOr6XopKltk2mbMZsdGW9QZMY0gRu
 7xKMEt2jKEN1zJWRtNGVQkRz3m785A0bjhgt91N4O1BYoxq8DN37CVavlMU9yBvS2V4w
 YVfk76wli+I2fBBGwyHwxH+LsW0iXasq9FkxBsWT+Rgjw6oevIZko/T6J7+ORXQl53Yg
 SKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=R0hixZr2FmuyDxkOlsaDyB/rdEVS5zH7ZB3SMwB7SjA=;
 b=Qi0mUsbu0Se/1baTV0utzkBX8686QCU3Gaw7F2mOWiPJPQ8J/4YRIkXqyBS3F70/Gn
 TubtEPvrJQOQ9UHZzOjdGy5goeTJsl7eGtByugT8/8I1S+IM3ragXjtFv3dy6xTXyg4/
 BxCw2jrrS4p3XxB0gNjBTbzrArW/jXbuZS3rNKDkKftB6/WB2kaei4gVMwm3I1SKXlJE
 axB8uYxOTl8IzTS4xq34qaLDlLUQpXrQkCxXU/eZjUssK9hHzhml0L1GDzmRR5pnKGii
 Nc+gwNdMe7ufoN1nD8jo/41cYUH9gDCL9sROUWY5CbfeuwPLRjWlLqHhQTNQePqZ1qGp
 Ebqw==
X-Gm-Message-State: AOAM530XRivu/3xMWS1uvlo6LUZSbhhqA+5jwlgRXeRM0+ykQ7hGdN3+
 RBZTrijghFahOdeJuOY5qId+bA==
X-Google-Smtp-Source: ABdhPJzjRmSUHB2zFZ7vBLZF6CzWlFP1LEz/kUgyBixSbyTvv5dKfO22jCQHN6IyVtoTtdqjdu9Rpg==
X-Received: by 2002:a17:906:3c42:: with SMTP id
 i2mr4628994ejg.14.1594914012974; 
 Thu, 16 Jul 2020 08:40:12 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id gu15sm5285033ejb.111.2020.07.16.08.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 08:40:12 -0700 (PDT)
Date: Thu, 16 Jul 2020 17:39:59 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v5 03/15] iommu/smmu: Report empty domain nesting info
Message-ID: <20200716153959.GA447208@myrica>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-4-git-send-email-yi.l.liu@intel.com>
 <20200713131454.GA2739@willie-the-truck>
 <CY4PR11MB1432226D0A52D099249E95A0C3610@CY4PR11MB1432.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR11MB1432226D0A52D099249E95A0C3610@CY4PR11MB1432.namprd11.prod.outlook.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, "Wu, Hao" <hao.wu@intel.com>,
 Will Deacon <will@kernel.org>, "Tian, Jun J" <jun.j.tian@intel.com>
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

On Tue, Jul 14, 2020 at 10:12:49AM +0000, Liu, Yi L wrote:
> > Have you verified that this doesn't break the existing usage of
> > DOMAIN_ATTR_NESTING in drivers/vfio/vfio_iommu_type1.c?
> 
> I didn't have ARM machine on my hand. But I contacted with Jean
> Philippe, he confirmed no compiling issue. I didn't see any code
> getting DOMAIN_ATTR_NESTING attr in current drivers/vfio/vfio_iommu_type1.c.
> What I'm adding is to call iommu_domai_get_attr(, DOMAIN_ATTR_NESTIN)
> and won't fail if the iommu_domai_get_attr() returns 0. This patch
> returns an empty nesting info for DOMAIN_ATTR_NESTIN and return
> value is 0 if no error. So I guess it won't fail nesting for ARM.

I confirm that this series doesn't break the current support for
VFIO_IOMMU_TYPE1_NESTING with an SMMUv3. That said...

If the SMMU does not support stage-2 then there is a change in behavior
(untested): after the domain is silently switched to stage-1 by the SMMU
driver, VFIO will now query nesting info and obtain -ENODEV. Instead of
succeding as before, the VFIO ioctl will now fail. I believe that's a fix
rather than a regression, it should have been like this since the
beginning. No known userspace has been using VFIO_IOMMU_TYPE1_NESTING so
far, so I don't think it should be a concern.

And if userspace queries the nesting properties using the new ABI
introduced in this patchset, it will obtain an empty struct. I think
that's acceptable, but it may be better to avoid adding the nesting cap if
@format is 0?

Thanks,
Jean

> 
> @Eric, how about your opinion? your dual-stage vSMMU support may
> also share the vfio_iommu_type1.c code.
> 
> Regards,
> Yi Liu
> 
> > Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
