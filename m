Return-Path: <SRS0=OemM=6S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72C9C4725A
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 16:07:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF34206A4
	for <iommu@archiver.kernel.org>; Mon,  4 May 2020 16:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tOa5oTLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF34206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 61BFF25D87;
	Mon,  4 May 2020 16:07:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4Px4SGmg55GQ; Mon,  4 May 2020 16:07:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 344ED25D52;
	Mon,  4 May 2020 16:07:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F53BC088A;
	Mon,  4 May 2020 16:07:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEF90C0175
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 16:07:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9D44C883A1
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 16:07:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z+rSLiRxZS04 for <iommu@lists.linux-foundation.org>;
 Mon,  4 May 2020 16:07:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C4B56879DB
 for <iommu@lists.linux-foundation.org>; Mon,  4 May 2020 16:07:45 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id z6so100398wml.2
 for <iommu@lists.linux-foundation.org>; Mon, 04 May 2020 09:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nMl6SHOaMost3dT1wGRgIQNBlt6LwoX99r9Dd84bUXI=;
 b=tOa5oTLa/BSYByPuQ+26pv5RJej5b20cBe+rvpOGPI/KofVkXxxl26y2MJakqaW0FQ
 rZJEar4QOw/8Ea95uNmoZPskH+y3kSmV2qqvfj7xz7WuAu3apmEB/RRqtnxyMYZ1rwFV
 kt9KI3iTKOxkoNvLOTBuIDR0pT38dqKuazvuidA+F4t6y11UNBS8CQ764TRmaAXE6n7m
 q2Ud0IZOLQGVjWMbEwM4ap6Y19/3twFdisN9Kmfa5J4pXzqmJ6e1dcc/hcuI7bWLKgbg
 5Oqx76DnLKrP1ppU9XJcOJPcIjL1Te3iy2p8xs4JkrbmXrwXC2o4X+EqXTaqX6KHcXrS
 DrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nMl6SHOaMost3dT1wGRgIQNBlt6LwoX99r9Dd84bUXI=;
 b=Rbxyk2NbbtecP8Wl9mqx8pg5kIyWXJE/arj1hFwPjqfwTgdtgnFqj8lE/R155xP0ZT
 pJbpMKi35vkTIl03M5TTd8zaIXQXeXyB9HWaMQrfP0vNPhGXbQBnoTCRXhKL+oxDo2Wn
 szG+j7sjJcmwEciI8rPhWhLHcIYh7TX+muGCdaINKhSp7RL8DwwTUY6ezYWFHMlS2IIY
 sExvjqL5Gms+tJLeOJbxKcrhIpBI9qXzqnl18mzgl6DU2GzjovZ8GCSbnzcar34HaMlg
 uM0W5OTmtUxxYamh0q+kw5vWEz7izU0IHi+QKxQ+eU6HZ3xG5q6OL/VS/PNIa6cynKxw
 LpnQ==
X-Gm-Message-State: AGi0PuYo1b3aXDz1NG1+theDRGr2mDXIN6AGdqkKYLT7x2wKlDlOGfpg
 lS6/XcNuS+JaoM2RMnWi7aJSnQ==
X-Google-Smtp-Source: APiQypLRnG6LvHqUIo2qBJAF7F6DJOi32Rx7XybV+rqHkWXfxFrCE9dU7PixYXhfr6u9mhKSarqUxQ==
X-Received: by 2002:a7b:cb0c:: with SMTP id u12mr16851030wmj.137.1588608464322; 
 Mon, 04 May 2020 09:07:44 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
 by smtp.gmail.com with ESMTPSA id l15sm13514230wmi.48.2020.05.04.09.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 09:07:43 -0700 (PDT)
Date: Mon, 4 May 2020 18:07:34 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v6 17/25] iommu/arm-smmu-v3: Implement
 iommu_sva_bind/unbind()
Message-ID: <20200504160734.GE170104@myrica>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-18-jean-philippe@linaro.org>
 <20200501121552.GA6012@infradead.org>
 <20200501125513.GN26002@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200501125513.GN26002@ziepe.ca>
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, will@kernel.org,
 fenghua.yu@intel.com, linux-pci@vger.kernel.org, felix.kuehling@amd.com,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, robin.murphy@arm.com, christian.koenig@amd.com,
 linux-arm-kernel@lists.infradead.org
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

On Fri, May 01, 2020 at 09:55:13AM -0300, Jason Gunthorpe wrote:
> On Fri, May 01, 2020 at 05:15:52AM -0700, Christoph Hellwig wrote:
> > > @@ -432,6 +432,7 @@ config ARM_SMMU_V3
> > >  	tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
> > >  	depends on ARM64
> > >  	select IOMMU_API
> > > +	select IOMMU_SVA
> > >  	select IOMMU_IO_PGTABLE_LPAE
> > >  	select GENERIC_MSI_IRQ_DOMAIN
> > 
> > Doesn't this need to select MMU_NOTIFIER now?
> > 
> > > +	struct mmu_notifier_ops		mn_ops;
> > 
> > Note: not a pointer.
> > 
> > > +	/* If bind() was already called for this (dev, mm) pair, reuse it. */
> > > +	list_for_each_entry(bond, &master->bonds, list) {
> > > +		if (bond->mm == mm) {
> > > +			refcount_inc(&bond->refs);
> > > +			return &bond->sva;
> > > +		}
> > > +	}
> 
> I also would like it if searching for mms in linked lists was not
> necessary, this is kind of the point of 'get'
> 
> Is this a side effect of the earlier remark to get rid of the linked
> list inside the notifier?
> 
> > Or we could enhance the mmu_notifier_get to pass a private
> > oaque instance ID pointer, which is checked in addition to the ops,
> > and you could probably kill off the bonds list and lookup.
> 
> This might be the best option if it can absorb the above search..

It wouldn't, the above search is separate. I currently register the MMU
notifier on (IOMMU domain, mm). The (dev, mm) search above is to follow
the iommu_sva_bind_device() API doc, that states we should return the same
handle for a given (dev, mm) pair.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
