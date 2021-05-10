Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF6DC433ED
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 11:54:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ABCC613C2
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 11:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABCC613C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5CDF9401E9;
	Mon, 10 May 2021 11:54:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lvQ3__ClK3bv; Mon, 10 May 2021 11:54:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5C3C2401DE;
	Mon, 10 May 2021 11:54:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42990C000E;
	Mon, 10 May 2021 11:54:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80B0FC0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 11:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E57B40483
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 11:54:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ayvNiVt0X0Qz for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 11:54:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3CCA6402EC
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 11:54:15 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id i67so14962696qkc.4
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 04:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=4+X4WteNsgQ19+v1jrZ7Ekzjl0pM0a2tSBb6kLiTT48=;
 b=PWyo1gl6oTeAtHGCeTBEPCa3Yr0PE4k7LvQFXAjuZ8kYFrMR4YWhiKpWpL9UTBvZ7m
 qk8KFyM10DuEJNIBnRKAozmeWOLsaRT5BF34OdpSj6Zv4Gqt85+FGlDU+TUek9WwkkfR
 jZ7v8VD7HnnFbwgxTvyBeOotqiXojc6x8i1KKOK4cVeQIekGTw1TCNcAMW/CMpvd+6RP
 tm9qSDCStEi3cagBGLSl7+rtLDZzX8+eMCzoO28n1Ii8zBPZJRPmgHsTk8uv3JTt6aUv
 wyhvmP1oQ5xcemAq48IGapmsXw3yUdDwPENB6AdF3PlELk7SIAKnvWNK5LHjesLGFh1U
 9+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4+X4WteNsgQ19+v1jrZ7Ekzjl0pM0a2tSBb6kLiTT48=;
 b=buN6a9Q+jBYyvVuzafpn32aaOTgu3z5W0LItCxc03mt4C+n/3MZpz0OYQ0OjhyPP1y
 jqs//pM8NAc9RABckizF4oFLk975LCzfZ400CfzEu1z636QbGWelfQXijMP7AMnjMyyR
 dNt9EJKrNVHXu6nSdPCu7Rx2UxAcC622QNBnuEbAA9jCfD3FXKP2dBXuRxnJW0+A3Tz0
 n6Uvqmg0ofdHDKJHsTIn58L5SmtkFHDvLtm/fircLs7///cFkSYR+A13ooepTZdLYPll
 Nm8c+81ZNH6BjXfhOtuNmfgtZsW+9v7OR9pBpNcnN/awuR2743BngpkOpdOy5FI/uESa
 vYug==
X-Gm-Message-State: AOAM531wzoColMUiQM5/8vM92L5bkEYiqcnys+P//bv+QoPELYAtgHJw
 vjzyHikRsBgf5ZNJyuM1YcE8CA==
X-Google-Smtp-Source: ABdhPJzBhRA/mYegQ6Y3SCHv8vvyMaFup+8Bx9cPBeG9nbr9M1kzHbHa1+EnzLI/fQPr8l4kD42yUg==
X-Received: by 2002:a37:468c:: with SMTP id
 t134mr12536249qka.357.1620647654876; 
 Mon, 10 May 2021 04:54:14 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id 189sm11286888qkd.51.2021.05.10.04.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 May 2021 04:54:14 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1lg4UH-004Bs3-DG; Mon, 10 May 2021 08:54:13 -0300
Date: Mon, 10 May 2021 08:54:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: more iommu dead code removal
Message-ID: <20210510115413.GE2047089@ziepe.ca>
References: <20210510065405.2334771-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210510065405.2334771-1-hch@lst.de>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, kvm@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 iommu@lists.linux-foundation.org, Alex Williamson <alex.williamson@redhat.com>,
 "Wu, Hao" <hao.wu@intel.com>, Will Deacon <will@kernel.org>,
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

On Mon, May 10, 2021 at 08:53:59AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this is another series to remove dead code from the IOMMU subsystem,
> this time mostly about the hacky code to pass an iommu device in
> struct mdev_device and huge piles of support code.  All of this was
> merged two years ago and (fortunately) never got used.

Yes, I looked at this too. Intel has been merging dead code for a
while now. Ostensibly to prepare to get PASID support in.. But the
whole PASID thing looks to be redesigned from what was originally
imagined.

At least from VFIO I think the PASID support should not use this hacky
stuff, /dev/ioasid should provide a clean solution

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
