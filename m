Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C81C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 05:43:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE30660FD9
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 05:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE30660FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9640283D2A;
	Thu,  7 Oct 2021 05:43:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SdI9NGrgbEqQ; Thu,  7 Oct 2021 05:43:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 92C9283E5C;
	Thu,  7 Oct 2021 05:43:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B334C000F;
	Thu,  7 Oct 2021 05:43:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32202C000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 05:43:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F47540373
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 05:43:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Smsqcl7n9diH for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 05:43:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 34C954018A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 05:43:46 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id z20so18417042edc.13
 for <iommu@lists.linux-foundation.org>; Wed, 06 Oct 2021 22:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4yLst2vmAYOFfsPqRs1YkPG/caPM67bEIOVz4JIIhbY=;
 b=oX+0VezrM6zgV7l+fjfAmT1wzCL9iZWgh3KtUE95eSsTFi1DbMwgGIj/fTYu6Gdte6
 59+2J+G4RutJG9OooRKbOCiVWfC2adXFdEC/4OFTMkpWEE+iJGqx3pvrRtCjureIghJ8
 TD5Kk7O/JyQ/uYcl63nCTbSfsTEY98McLCjE/+f/Rzpdt2941R/xuRnZzhZolXkCOzKU
 nIgFwffvYulGbHkPdmJJYbQdY1NwXFOA5qAvC60HF4K8yVnaoIHQKUwKa56RDhEzLuIm
 80+0OqDpO202MisydJCXUbRnob65HcG8j7gPkpRmo6lalywhAGFgJere/LU1dl4ZUB4i
 vScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4yLst2vmAYOFfsPqRs1YkPG/caPM67bEIOVz4JIIhbY=;
 b=pDu+QGppjgqoZ/WTWqXC5mvHMKYTyHfoTcc8x5mQRkuyQAbQiNLNnbd96fOPibSrjz
 zXHYyq2y1qNsXPfoTapDa8aEGj3PO/oV9x8pDcvKkCSn+yCMADZFyQSANQ5Sdcsu+x8K
 NAWT/tC9xeMY9Pfq7p0eNbmMIPPtZnvnzyJSE2zq3eDLDSdYv20YTgidO4ZmKSD92AcW
 PaiVAv2njE7btoigMem4nKckGRvgG3ueJECay3VC5t+LUbvKD4Ezh0611QvM0al+2pow
 VcvMNMtefVKqiiRwzJP7LU7AxgyZSqXAnQiHMKP3Hj1zybK7r3bxZp1PmG+X1/WsyCnb
 exWQ==
X-Gm-Message-State: AOAM5327RHoDZIwqi+yMJnC+PTlfMDwAY7as2UjtCteFoKzItABqhd62
 U0C2WM4e43Nh5sbsQTKe5QoQuIPu5J3dal/VB2k=
X-Google-Smtp-Source: ABdhPJygsOBrVz+xXtAl5BwMSgWm8ko/zp+KlRk0jNNlblvwD9ydnXMLD9SK52HKDCQSpTlfSlXAmmxqPjdgbZ0IPjc=
X-Received: by 2002:aa7:cd8b:: with SMTP id x11mr3671932edv.384.1633585424465; 
 Wed, 06 Oct 2021 22:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
 <20211001123623.GM964074@nvidia.com>
 <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
 <20211004094003.527222e5@jacob-builder> <20211004182142.GM964074@nvidia.com>
In-Reply-To: <20211004182142.GM964074@nvidia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 7 Oct 2021 18:43:33 +1300
Message-ID: <CAGsJ_4w+ed78cnJusM_enEZpdGghzvjgt0aYDPpfwk4z7PQqxQ@mail.gmail.com>
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

On Tue, Oct 5, 2021 at 7:21 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Oct 04, 2021 at 09:40:03AM -0700, Jacob Pan wrote:
> > Hi Barry,
> >
> > On Sat, 2 Oct 2021 01:45:59 +1300, Barry Song <21cnbao@gmail.com> wrote:
> >
> > > >
> > > > > I assume KVA mode can avoid this iotlb flush as the device is using
> > > > > the page table of the kernel and sharing the whole kernel space. But
> > > > > will users be glad to accept this mode?
> > > >
> > > > You can avoid the lock be identity mapping the physical address space
> > > > of the kernel and maping map/unmap a NOP.
> > > >
> > > > KVA is just a different way to achive this identity map with slightly
> > > > different security properties than the normal way, but it doesn't
> > > > reach to the same security level as proper map/unmap.
> > > >
> > > > I'm not sure anyone who cares about DMA security would see value in
> > > > the slight difference between KVA and a normal identity map.
> > >
> > > yes. This is an important question. if users want a high security level,
> > > kva might not their choice; if users don't want the security, they are
> > > using iommu passthrough. So when will users choose KVA?
> > Right, KVAs sit in the middle in terms of performance and security.
> > Performance is better than IOVA due to IOTLB flush as you mentioned. Also
> > not too far behind of pass-through.
>
> The IOTLB flush is not on a DMA path but on a vmap path, so it is very
> hard to compare the two things.. Maybe vmap can be made to do lazy
> IOTLB flush or something and it could be closer
>
> > Security-wise, KVA respects kernel mapping. So permissions are better
> > enforced than pass-through and identity mapping.
>
> Is this meaningful? Isn't the entire physical map still in the KVA and
> isn't it entirely RW ?

Some areas are RX, for example, ARCH64 supports KERNEL_TEXT_RDONLY.
But the difference is really minor.

So do we have a case where devices can directly access the kernel's data
structure such as a list/graph/tree with pointers to a kernel virtual address?
then devices don't need to translate the address of pointers in a structure.
I assume this is one of the most useful features userspace SVA can provide.

But do we have a case where accelerators/GPU want to use the complex data
structures of kernel drivers?

>
> Jason

Thanks
barry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
