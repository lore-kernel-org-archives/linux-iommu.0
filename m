Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5C4C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 11:55:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5435461261
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 11:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5435461261
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B27C409DF;
	Thu,  7 Oct 2021 11:55:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1RIlUny0mRA7; Thu,  7 Oct 2021 11:55:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 028CF40A04;
	Thu,  7 Oct 2021 11:55:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE17FC000F;
	Thu,  7 Oct 2021 11:55:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45DCAC000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 11:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 303E240A02
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 11:55:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5sGyQPoxVh1m for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 11:55:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D37B3409E8
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 11:55:05 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id x7so21434374edd.6
 for <iommu@lists.linux-foundation.org>; Thu, 07 Oct 2021 04:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2Sc46Q9eMcwlaMy2IZJgD2QwpVCcYg9+SD8cXYZgbr4=;
 b=RT9YmSKnUjHCEr3v6bar51e1fzGq7K8YE+IB7ejWFNs9jODGQtkmWkzq2hgZujJCUJ
 mnennI/hqWHn0R1mtQCCEqvymetd/bl2VgplLcGb/U/N0sjVCoyKEwx/mkoc9MmETaWb
 ceVbHfdd9xnvcaN9u+osChdyCUu9BQJsE2WJ1gkkcj9kLDP7jXmcIiWdLsxl9rKdDTIf
 H3EuUUBia7VJlzi8PEgVftWKFBtcQ65f0EUzVoBGCFv1cdIyTgp1RMdXi/gD1rVfq7g4
 IPgNqk9yxnkGrT6gy6s2iNHiSDmFQpfjA2B5eyN0gQHdihyPlscJUjXMjZzUJB7bbr1L
 Wh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2Sc46Q9eMcwlaMy2IZJgD2QwpVCcYg9+SD8cXYZgbr4=;
 b=5ctfI5MbyDQgcrgmtE36/HY05JadNyz1mmqfw96fThE93i5nkyoavI7suhXXPlI//X
 5a2B+AUQ7fTaIi3EhJL5jIWoN8Jo3dg3Wkd32nWDFBMOHefb9p0Pqd14PRP3U395pFvu
 xAFbM9D6YaFNQn9yWCnxPQkds21s6QJwmyyL7N4lakoG+6LzABXypW8FOmg0YN4eUPc7
 VQFslivCWma0BZCNZfqFsNDNRqzFR7ezqqew8kYa19d5+N9fG1pz8+JH2OX+/Pc8EiZk
 YZyB94DNRPnxYbCyjb9ahFsNFrBFMqY0QIdTimx/ZcpV2k5O0V04a/9PqE/PkEXvw/B8
 LP+Q==
X-Gm-Message-State: AOAM533dveR+8gtj/jq8mucevsj8GMhz1DkNpRj2OS/K/A0PPO1j6zyo
 CmrGtH3MLhYKPQu+EO2iyQR4pPOSijrfW0sJVBc=
X-Google-Smtp-Source: ABdhPJyCXK/u3V2xMWIJIiVDE8gg9vaOTOj4ckAKIeY5EmY50zW1eFNxbthRtAZ1ldJbNFWWIlCpZCQBCqK/PKY06k8=
X-Received: by 2002:a17:906:3383:: with SMTP id
 v3mr5173329eja.213.1633607703888; 
 Thu, 07 Oct 2021 04:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
 <20211001123623.GM964074@nvidia.com>
 <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
 <20211004094003.527222e5@jacob-builder> <20211004182142.GM964074@nvidia.com>
 <CAGsJ_4w+ed78cnJusM_enEZpdGghzvjgt0aYDPpfwk4z7PQqxQ@mail.gmail.com>
 <20211007113221.GF2744544@nvidia.com>
In-Reply-To: <20211007113221.GF2744544@nvidia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 8 Oct 2021 00:54:52 +1300
Message-ID: <CAGsJ_4x2UEmNXCVhJAVRyB8568VMrTkOLeVCNp8CyP6xZJwCig@mail.gmail.com>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Tony Luck <tony.luck@intel.com>,
 mike.campin@intel.com
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

On Fri, Oct 8, 2021 at 12:32 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Oct 07, 2021 at 06:43:33PM +1300, Barry Song wrote:
>
> > So do we have a case where devices can directly access the kernel's data
> > structure such as a list/graph/tree with pointers to a kernel virtual address?
> > then devices don't need to translate the address of pointers in a structure.
> > I assume this is one of the most useful features userspace SVA can provide.
>
> AFIACT that is the only good case for KVA, but it is also completely
> against the endianess, word size and DMA portability design of the
> kernel.
>
> Going there requires some new set of portable APIs for gobally
> coherent KVA dma.

yep. I agree. it would be very weird if accelerators/gpu are sharing
kernel' data struct, but for each "DMA" operation - reading or writing
the data struct, we have to call dma_map_single/sg or
dma_sync_single_for_cpu/device etc. It seems once devices and cpus
are sharing virtual address(SVA), code doesn't need to do explicit
map/sync each time.

>
> Jason

Thanks
barry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
