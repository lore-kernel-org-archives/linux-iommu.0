Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E2FC43461
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 09:37:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D50611C2
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 09:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D50611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73C7A60C07;
	Thu,  8 Apr 2021 09:37:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aNigk2TgcHRc; Thu,  8 Apr 2021 09:37:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5971960A4A;
	Thu,  8 Apr 2021 09:37:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AB32C000B;
	Thu,  8 Apr 2021 09:37:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 999BBC000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 09:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 880E584C82
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 09:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9mxj6Z94nZGC for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 09:37:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D2DA84C54
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 09:37:35 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 n11-20020a05600c4f8bb029010e5cf86347so3698660wmq.1
 for <iommu@lists.linux-foundation.org>; Thu, 08 Apr 2021 02:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=W/yHsDt8vP0u2gfAgM+TLjsXBjDf3kcjStZ5TkuBO04=;
 b=L5BRsWJ8dydkBP9Vi3TF7ADyA4Q5GaNirzWF94eqpg+JL306eqT94na2clpu3nDELP
 dMAUkP34cNKUubQsnzzBBJumO4zcJGAIfpj1grXxgQ2yhbG3monwA+u5fya1ii40SmGn
 uvAWVf2oQg1pX4OpfR97WCcf31mQtF2h1bItuDvOJMwp+9YtuW4mtreSNi9FGNsIofm+
 ua2fL0BRhP0XS5ofnTIxaJffPESnYgmxaDLwoXDKxIflWeQJwndYp52a0kZ9Qeh/hmre
 7ZTLGWwwViwBS+UTUcH7N0rwucQn3bwcuWYusqgoEZMOTJjo/wgxp7GTAipXRVmo/K9m
 2INg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=W/yHsDt8vP0u2gfAgM+TLjsXBjDf3kcjStZ5TkuBO04=;
 b=PZLFDJMrJx941uB282eHoFaSsG0MtjowcL0INrhvoVyHolARymZbqsfH+yejxSfqyT
 j8hXeZCAUfWtgvv538mmXDC+dNxThiKzmablfip2xxqdD3GjJC+AGbEanewr6ly8hYuU
 ro/YXZk50P8b2rc8pI1gZFqbD7CMO7XHbbcEOexws5hgWeMIEbcqffFtbuLqU7D6vaXL
 DS4MAH0b92eHLv02oz7Q/JtvVPcD1z42x5d6TI3T7R0CyeI2DV3FU9pIN1dyM2aYdcTl
 UrQu/iuNM7nKiVZU+xKMxSoeCTmeMj0BGEhpFwPWhcwrAJishl6gjgdwos6z6B2ywGpK
 fk/Q==
X-Gm-Message-State: AOAM533WgtPzp2LKBwrMvuwR+VORqWAX3WPAf/3TqmRtU6Q1nrPf7InL
 pKEVQSgnumJHJywlXGHZ5euF5Q==
X-Google-Smtp-Source: ABdhPJzJL3dixxN/yLW8668xthwKI1Qe27J5sx/WY544bIVjXbdwnVBFT5n3x6q0eGEHleVFu9k3cQ==
X-Received: by 2002:a7b:c047:: with SMTP id u7mr7488121wmc.98.1617874653812;
 Thu, 08 Apr 2021 02:37:33 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id a15sm45246768wrr.53.2021.04.08.02.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Apr 2021 02:37:33 -0700 (PDT)
Date: Thu, 8 Apr 2021 11:37:15 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YG7Oyyju/2J6KMf+@myrica>
References: <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405234230.GF7405@nvidia.com>
 <fa57bde5-472f-6e66-3521-bfac7d6e4f8d@redhat.com>
 <20210406124251.GO7405@nvidia.com>
 <MWHPR11MB1886A7E4C6F3E3A81240517B8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YG39ZtnTuyn5uBOa@myrica> <20210407193654.GG282464@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407193654.GG282464@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, Jason Wang <jasowang@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, Li Zefan <lizefan@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Wu, Hao" <hao.wu@intel.com>
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

On Wed, Apr 07, 2021 at 04:36:54PM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 07, 2021 at 08:43:50PM +0200, Jean-Philippe Brucker wrote:
> 
> > * Get a container handle out of /dev/ioasid (or /dev/iommu, really.)
> >   No operation available since we don't know what the device and IOMMU
> >   capabilities are.
> >
> > * Attach the handle to a VF. With VFIO that would be
> >   VFIO_GROUP_SET_CONTAINER. That causes the kernel to associate an IOMMU
> >   with the handle, and decide which operations are available.
> 
> Right, this is basically the point, - the VFIO container (/dev/vfio)
> and the /dev/ioasid we are talking about have a core of
> similarity. ioasid is the generalized, modernized, and cross-subsystem
> version of the same idea. Instead of calling it "vfio container" we
> call it something that evokes the idea of controlling the iommu.
> 
> The issue is to seperate /dev/vfio generic functionality from vfio and
> share it with every subsystem.
> 
> It may be that /dev/vfio and /dev/ioasid end up sharing a lot of code,
> with a different IOCTL interface around it. The vfio_iommu_driver_ops
> is not particularly VFIOy.
> 
> Creating /dev/ioasid may primarily start as a code reorganization
> exercise.
> 
> > * With a map/unmap vIOMMU (or shadow mappings), a single translation level
> >   is supported. With a nesting vIOMMU, we're populating the level-2
> >   translation (some day maybe by binding the KVM page tables, but
> >   currently with map/unmap ioctl).
> > 
> >   Single-level translation needs single VF per container. 
> 
> Really? Why?

The vIOMMU is started in bypass, so the device can do DMA to the GPA space
until the guest configures the vIOMMU, at which point each VF is either
kept in bypass or gets new DMA mappings, which requires the host to tear
down the bypass mappings and set up the guest mappings on a per-VF basis
(I'm not considering nesting translation in the host kernel for this,
because it's not supported by all pIOMMUs and is expensive in terms of TLB
and pinned memory). So keeping a single VF per container is simpler, but
there are certainly other programming models possible.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
