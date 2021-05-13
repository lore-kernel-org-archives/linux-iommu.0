Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5DAC433B4
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 12:01:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26A16143D
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 12:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26A16143D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8AFDE400EA;
	Thu, 13 May 2021 12:01:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3owVf81cP8Iw; Thu, 13 May 2021 12:01:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6E9344020F;
	Thu, 13 May 2021 12:01:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C3F2C000E;
	Thu, 13 May 2021 12:01:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BB06C0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 12:01:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 57CB64020F
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 12:01:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rDZg8uMv2MAH for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 12:01:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 94DB6400EA
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 12:01:01 +0000 (UTC)
Received: by mail-qk1-x732.google.com with SMTP id c20so14175036qkm.3
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 05:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=NJihL2Xw2lHhkxSxjm+gjn8CDqqOTmpq6YLn31gRVlo=;
 b=M8TgruUqCLhDzSxpaZE6ZcHOf7qpdfRsiP60D15PaB+xgLxnWTKx++sLGfwnuEY7cK
 uTYSf6cnwrBxnDipK3mbByMUjNzCtv1L/Oc0MBJlorr4NuoxvcGkikJ5BmLG8fbvE38K
 cwW6Vm2DWhlAD6Eowz2NJT8cl5tk+WTOTtU+xd01yaVbd5ckZ576ptV9N5Xs3i+gxPAw
 2lJz5jv2tvdGhWn/ak1dF0461aZaFpTVHnvAOx9H2sx1wXa9fA05Uxpg9Bwu5ECS9aek
 C6gecVqVy/zLo76dzPwDBYJVfNzm4wyZXebHd+I7rH6wm0Ah7oP8HeQv9jNhbqP1eekf
 KNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NJihL2Xw2lHhkxSxjm+gjn8CDqqOTmpq6YLn31gRVlo=;
 b=AprRE8J6fZyUru/sCVw9yTNJnFBmPsaM2++8X4YhRHUiDmp1habPKwwTJSkXJt2sda
 +61uarhLy5Vxad1kO7uKX39bSi0BDZ/qRf2+XBGHUR5jiuSymPWT2iXvPF+4OTr56KEl
 oDhLnKY/L3+NOX97ofsUPy1Wkkmclz3JOKiU+EaNxTVmFGMejCZav73urnjtbc1CV+Eq
 9ezA69DCrTKQF5US9v9s03UZwQca6kwsHYLWsWJJpSVa0w+MKZXEX8vVH80BHP5V/PXe
 ly8AuSynqPcYUlLftNPM114gB5rrOHdPO10rOAi2SYeqqFjtS1uKA/o5EiPC/nL/8kOj
 RjIg==
X-Gm-Message-State: AOAM530rCV2ZcdTwTrRwel1lU9E2DKKPVFzKnngHs4vgPY9uFdGcoxDr
 WA8NGEeb/ICRaCRqHYSahUA24Q==
X-Google-Smtp-Source: ABdhPJwdEODv0dV1RGQbKjSCOgnSJl/y5fEW7JnLEVOJ+y3Rq/nxRWKcs8mWpepP6QF3X0y4yh8XwQ==
X-Received: by 2002:a37:a301:: with SMTP id m1mr38481585qke.491.1620907260254; 
 Thu, 13 May 2021 05:01:00 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id b188sm2207623qkc.11.2021.05.13.05.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 May 2021 05:00:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lhA1S-006ntk-K6; Thu, 13 May 2021 09:00:58 -0300
Date: Thu, 13 May 2021 09:00:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Message-ID: <20210513120058.GG1096940@ziepe.ca>
References: <20210510065405.2334771-1-hch@lst.de>
 <20210510065405.2334771-4-hch@lst.de>
 <20210510155454.GA1096940@ziepe.ca>
 <MWHPR11MB1886E02BF7DE371E9665AA328C519@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886E02BF7DE371E9665AA328C519@MWHPR11MB1886.namprd11.prod.outlook.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Thu, May 13, 2021 at 03:28:52AM +0000, Tian, Kevin wrote:

> Are you specially concerned about this iommu_device hack which 
> directly connects mdev_device to iommu layer or the entire removed
> logic including the aux domain concept? For the former we are now 
> following up the referred thread to find a clean way. But for the latter 
> we feel it's still necessary regardless of how iommu interface is redesigned 
> to support device connection from the upper level driver. The reason is 
> that with mdev or subdevice one physical device could be attached to 
> multiple domains now. there could be a primary domain with DOMAIN_
> DMA type for DMA_API use by parent driver itself, and multiple auxiliary 
> domains with DOMAIN_UNMANAGED types for subdevices assigned to 
> different VMs.

Why do we need more domains than just the physical domain for the
parent? How does auxdomain appear in /dev/ioasid?

I never understood what this dead code was supposed to be used for.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
