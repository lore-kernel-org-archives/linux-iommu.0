Return-Path: <SRS0=H7Zn=I4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0136CC433DB
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 13:42:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 860D9619D0
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 13:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860D9619D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 393184018A;
	Tue, 30 Mar 2021 13:42:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GXTKUlKjXdHf; Tue, 30 Mar 2021 13:42:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0F7BD40183;
	Tue, 30 Mar 2021 13:42:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5500C000C;
	Tue, 30 Mar 2021 13:42:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B74CC000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 13:42:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 550BA8316A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 13:42:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6VfkAxfhIvFl for <iommu@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 13:42:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66D75831C1
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 13:42:44 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id g25so8442799wmh.0
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 06:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pnUANKY68LFCHKnXAlNl92vZ5QNwZhc3rycWb9aJ4U4=;
 b=cXrleCcTe2edFKE7JXHrs9Bj1XROOQncYe9/RXuKuyYfg1oiY9hkloCupeUygrymIP
 9ayZSOUA/kzg9omudYLIbfliaSwzsF8t2WjsUk7aasxaQAZ65kiYcqVsJssvwnbqXWaQ
 7tP999kzGqM64anG+FHHGrYwPo3CD/MmoJSW67AsljQ3h4bpd7h5J0oHBBrJFcYhNPQZ
 jSvprN5HGew9kx/NPjUMKVuGbUtOweyWIunsFY/SwCVoa+64VGBhAnUWkD+o4ORO7eF3
 KDrvwGNAF2EaQH0lzuiBF6N51eP9jHBLGYuCYZ1yO4oXRNlIuT6R6Tj2RPOAmd0YGpIB
 8yZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pnUANKY68LFCHKnXAlNl92vZ5QNwZhc3rycWb9aJ4U4=;
 b=CcTBpXdIaWIc4nmPxER+ta/WpUnd3Je5YBgZpdZp+uKAKmGUAZ5mE6gmhYFWoKcXcD
 Iltb4ZWxGfBv5k3X0SAL8yMyFf8dvvKhVsCY8WlRpK+1R1hA2SI8JWUIfYqPs4udG83e
 XykVzBtN79D2+Qt+8gs/RCuCJfrTQB/ano+tfd8jfkWwhlio7SUzKZWYTlvD3Vq4BDcD
 dVOHJqQhGUf/pR7U8i73HZ4+Kmk8kkGRL1QQRSabKSsV+i195Q9zzzrkNseU/WRGRh5o
 0UpggEdMGyYBdAw2KVRpdonLMbU/e6J67rqXSAVj0d/JGvzgdpheg9Yj/TeG6excHv6Z
 DLTg==
X-Gm-Message-State: AOAM532MbnL1Gl2QQ0PMlHUdAxhIk7j6ZJkLLjsgapp4a3wQs2lkZXj/
 4X6iorNYi+XAyXqgYNaa/XzmUg==
X-Google-Smtp-Source: ABdhPJyEaNmHwXDqXeg3ddAYPI76jKgTBEKWlhppYOYHuQly+QNGJJ3PVIlHNTsLl1NMwgMgoe4Ywg==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr4234551wme.181.1617111762614; 
 Tue, 30 Mar 2021 06:42:42 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u20sm36588716wru.6.2021.03.30.06.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Mar 2021 06:42:42 -0700 (PDT)
Date: Tue, 30 Mar 2021 15:42:24 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YGMqwPnYjSfV+Cbr@myrica>
References: <20210319112221.5123b984@jacob-builder> <YFhiMLR35WWMW/Hu@myrica>
 <20210324100246.4e6b8aa1@jacob-builder>
 <20210324170338.GM2356281@nvidia.com>
 <20210324151230.466fd47a@jacob-builder> <YFxkNEz3THJKzW0b@myrica>
 <20210325100236.17241a1c@jacob-builder>
 <20210325171645.GF2356281@nvidia.com> <YF2WEmfXsXKCkCDb@myrica>
 <20210330130755.GN2356281@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210330130755.GN2356281@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Li Zefan <lizefan@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 cgroups@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On Tue, Mar 30, 2021 at 10:07:55AM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 26, 2021 at 09:06:42AM +0100, Jean-Philippe Brucker wrote:
> 
> > It's not inconceivable to have a control queue doing DMA tagged with
> > PASID. The devices I know either use untagged DMA, or have a choice to use
> > a PASID.
> 
> I don't think we should encourage that. A PASID and all the related is
> so expensive compared to just doing normal untagged kernel DMA.

How is it expensive?  Low number of PASIDs, or slowing down DMA
transactions?  PASIDs aren't a scarce resource on Arm systems, they have
almost 1M unused PASIDs per VM.

Thanks,
Jean

> I assume HW has these features because virtualization use cases might
> use them, eg by using mdev to assign a command queue - then it would
> need be be contained by a PASID.
> 
> Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
