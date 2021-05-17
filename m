Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F5AC433B4
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 12:30:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F818611B0
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 12:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F818611B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D19D283C89;
	Mon, 17 May 2021 12:30:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NWIsRIcCxPIU; Mon, 17 May 2021 12:30:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F2E183C82;
	Mon, 17 May 2021 12:30:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA0DDC000D;
	Mon, 17 May 2021 12:30:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC98AC0001
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 12:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89F57608DE
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 12:30:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EzoXP9R6Jz_8 for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 12:30:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62B42608D9
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 12:30:13 +0000 (UTC)
Received: by mail-qk1-x72e.google.com with SMTP id k127so5456615qkc.6
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 05:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=V+Cch8xRW1WYGs40hx7Gew5bxUxEUdJtQZFXQJNl02s=;
 b=kEzgnQZu3uqvJz2RaM/nnMkpzVJMQjIqjYX5Ljayco5bkCRl+S7HGeOjFbHPgM+IlC
 lWJ/bHi7bPCSq+4QCFcUHYL6Dr4qY84zB7C+bCOUOW3BiKD/+yqO8kcVYc5cibj4cpOM
 sNm4drLaUaAUS12Gs3VDK1RKKiP2+GJgtuYm3PgXPkMmFG7oT/ROW1QcCn2Iq/GCyGQZ
 mmKYB4X9+Gygg83a8q/pcOfDTD73Zrk+yfHFTQvm/ulqoBH5ntaT1Bhvau11rLut46/x
 txhKkcOKSItA8osf8jKtip5kiWN/wowysbsuMI7z+TWK38kRWnVNS+iEjHVP55NZ9sBt
 7j0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=V+Cch8xRW1WYGs40hx7Gew5bxUxEUdJtQZFXQJNl02s=;
 b=SA20R3pHAQmfqXPZFFkgPj8KJlXpwmsP54L+bZAYhuZLZqSciInSWlwh06MU2BTm9B
 kS9SxdOgt0cGuJqf2ZXDdamfpsecv8GobXhotR856WJmPu0WmyYK+ioZOKB17KyJUVmr
 kM8QxzuuH8HGNw6pJPhe0TcBAaG8wbToHNSZ7TnxJbwh70qWPv28MddMSQoOFpqDaSDV
 eRrD5NRwLwmZIdnjfmORQsV4w9YH8iZqns1scBKbBCF8E123oDTraEn0G0AdIVGxfpjL
 IRBpIFdvDoQsCndxZdl8dK255nBuehogDvWEuSHUhNenNa8xtCI8etdUM/tsCgEtLTlk
 GHNQ==
X-Gm-Message-State: AOAM530ZPhudy0fqcJm4+tWC1gOwbxoXVtUhKIazjjouoDsricqa55L1
 9MMqC1NFNnHkz5Rxi6ZPKfoAUQ==
X-Google-Smtp-Source: ABdhPJxQlOtNjYIpu2zCl+Q2+BPq9eQ5stqEINHnYWdlSJ7QCi8aM7fqT8qcIavvrMRN9eX7fr+1uA==
X-Received: by 2002:a37:98c4:: with SMTP id
 a187mr56051528qke.277.1621254612180; 
 Mon, 17 May 2021 05:30:12 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id q7sm10302543qki.17.2021.05.17.05.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 05:30:11 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1licNu-009Fa7-J0; Mon, 17 May 2021 09:30:10 -0300
Date: Mon, 17 May 2021 09:30:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Message-ID: <20210517123010.GO1096940@ziepe.ca>
References: <20210510065405.2334771-1-hch@lst.de>
 <20210510065405.2334771-4-hch@lst.de>
 <20210510155454.GA1096940@ziepe.ca>
 <MWHPR11MB1886E02BF7DE371E9665AA328C519@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210513120058.GG1096940@ziepe.ca>
 <MWHPR11MB1886B92507ED9015831A0CEA8C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514121925.GI1096940@ziepe.ca>
 <MWHPR11MB18866205125E566FE05867A78C509@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210514133143.GK1096940@ziepe.ca> <YKJf7mphTHZoi7Qr@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YKJf7mphTHZoi7Qr@8bytes.org>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Will Deacon <will@kernel.org>,
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

On Mon, May 17, 2021 at 02:22:06PM +0200, Joerg Roedel wrote:
> On Fri, May 14, 2021 at 10:31:43AM -0300, Jason Gunthorpe wrote:
> > There is no place for "domain as a carrier of PASID"
> > there. mdev_device should NOT participate in the IOMMU layer because
> > it is NOT a HW device. Trying to warp mdev_device into an IOMMU
> > presence is already the source of a lot of this hacky code.
> 
> Having the mdev abstraction is way better than making the IOMMU code
> IOASID aware. The later requires either new parameters to existing
> functions or new functions. With the mdev abstraction no new functions
> are needed in the core API.

All that does it lock PASID to mdev which is not at all where this
needs to go.

> Yes, I know, We have the AUX-domain specific functions now, but I
> suggested a while back to turn the mdev code into its own bus
> implementation and let the IOMMU driver deal with whether it has an mdev
> or a pdev. When that is done the aux-specific functions can go away.

Yuk, no.

PASID is not connected to the driver model. It is inherently wrong to
suggest this. 

PASID is a property of a PCI device and any PCI device driver should
be able to spawn PASIDs without silly restrictions.

Fixing the IOMMU API is clearly needed here to get a clean PASID
implementation in the kernel.

> > IOASID represents the IOVA address space.
> 
> No, when it comes to the IOMMU-API, a domain represents an address
> space.

Intel is building a new uAPI and here IOASID is the word they picked
to represent the IOVA address space. How it is mapped to the kernel is
TBD, I guess, but domain implies both more and less than a IOASID so it
isn't a 1:1 correspondence.

> > Two concepts that represent the same thing is not great :)
> 
> Agreed, so an IOASID should be an IOMMU-domain, if its not used for
> passing an mm_struct to a device.

We aren't talking about mm_struct.

As above a domain isn't an IOASID, it only does a few things an IOASID
can do.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
