Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329AFC433F5
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 14:20:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA3961A6F
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 14:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DEA3961A6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B684E614D5;
	Fri,  1 Oct 2021 14:20:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RdUMpbpoqOfa; Fri,  1 Oct 2021 14:20:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7EF4C6068F;
	Fri,  1 Oct 2021 14:20:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB334C0023;
	Fri,  1 Oct 2021 14:20:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50062C000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 12:46:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B3AB613E1
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 12:46:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N_sHikwZvNcg for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 12:46:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F40660644
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 12:46:13 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id v10so34639457edj.10
 for <iommu@lists.linux-foundation.org>; Fri, 01 Oct 2021 05:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JA98+GIBaPHY6lzBmZ4Tvs/snpUhHoNpqwt61nTpkis=;
 b=Is5IqeVMoXBsSYVNc+BFcM1OoT119+AkF8qL2/okCD58nmP6OhA3iQ4f5TMNyqrjoK
 cb2+r1W2u4pyHVeqXBDFMdeNnRqec2bqCqRpXsfVEJ95ZOUESabZJVLBWm+5rhgdlHUv
 b/ryU+BYOE6LEkxv0n83Nab6K3vvgwDIwWPW5i0jFtfaKH69YjR9S24feRgohcJQQHtB
 g4ns6FIB7E0M2bKArcf/fXtJ5w0Roum8U/kDMjAsnl84CKLQ/ldLzZTNShmaAJikKVs4
 zvZBe8R9Ts+G9JhY3gnUQ/6vvote/VYDxgAHFmSzlDKPmb1BG0p4iOmvfHnAvWWNO+LY
 3AKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JA98+GIBaPHY6lzBmZ4Tvs/snpUhHoNpqwt61nTpkis=;
 b=QRhvZNBbE6w9T2Mjr7832bCfADifl3IKc6M/aUwTaHpYHx3sq0fqwO7hHfKwrPf79K
 4dbNP5tlLD9fOf7ZlG1Lmu710KdmPF6s+Gn5q026R4ZtBFywZj4HRc/mDBEzvD0fedwn
 cp0tDHBK2nm4mzzx3veKUjIJXlmEFV0aR9zCcyfhHJIn3n+wQzf5bcieK/lxiLOFChaM
 Mm6QZ6mz+w7024VCWb/b0XB6Z8fXJRR1M9O6rRnXWHaKDMzt5VQfMwmH6JFKbCWdbIL6
 AxVxEykpQlA6/BhQrbTGqluIhR9iJLiINmRjCLBRrhWkQ6emap2Dc8c13VH2fCvdFV6+
 779w==
X-Gm-Message-State: AOAM533gyWlR8+I/TyDrqt9OYuWyZdYZXXmswhhd3EZpiyyKemK27Mt+
 hTeKTeZQC6l6uUNVIR//cPCU3TSxocHKMPM5X94=
X-Google-Smtp-Source: ABdhPJxWiAd7awY5FtJw8iqY2HDUYsVtRLzq0FFELa59+THVoAzC4qdbZLWi9qBDropgPYf+lhIrCIjpvxRQBPP+EW0=
X-Received: by 2002:a17:906:280f:: with SMTP id
 r15mr5671342ejc.559.1633092371103; 
 Fri, 01 Oct 2021 05:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <CAGsJ_4z=2y2nVStXP-aAPnQrJJbMmv78mjaMwNc9P9Ec+gCtGw@mail.gmail.com>
 <20211001123623.GM964074@nvidia.com>
In-Reply-To: <20211001123623.GM964074@nvidia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 2 Oct 2021 01:45:59 +1300
Message-ID: <CAGsJ_4wfkrJp-eFKiXsLdiZCb3eS_zqZtJvXQTBafoTWY2yWKQ@mail.gmail.com>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
To: Jason Gunthorpe <jgg@nvidia.com>
X-Mailman-Approved-At: Fri, 01 Oct 2021 14:20:38 +0000
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

On Sat, Oct 2, 2021 at 1:36 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Sat, Oct 02, 2021 at 01:24:54AM +1300, Barry Song wrote:
>
> > I assume KVA mode can avoid this iotlb flush as the device is using
> > the page table of the kernel and sharing the whole kernel space. But
> > will users be glad to accept this mode?
>
> You can avoid the lock be identity mapping the physical address space
> of the kernel and maping map/unmap a NOP.
>
> KVA is just a different way to achive this identity map with slightly
> different security properties than the normal way, but it doesn't
> reach to the same security level as proper map/unmap.
>
> I'm not sure anyone who cares about DMA security would see value in
> the slight difference between KVA and a normal identity map.

yes. This is an important question. if users want a high security level,
kva might not their choice; if users don't want the security, they are using
iommu passthrough. So when will users choose KVA?

>
> > which have been mapped in the current dma-map/unmap with IOMMU backend.
> > some drivers are using bouncing buffer to overcome the performance loss of
> > dma_map/unmap as copying is faster than unmapping:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=907676b130711fd1f
>
> It is pretty unforuntate that drivers are hard coding behaviors based
> on assumptions of what the portable API is doing under the covers.

not real when it has a tx_copybreak which can be set by ethtool or
similar userspace
tools . if users are using iommu passthrough, copying won't happen by
the default
tx_copybreak.  if users are using restrict iommu mode, socket buffers
are copied into
the buffers allocated and mapped in the driver. so this won't require
mapping and
unmapping socket buffers frequently.

>
> Jason

Thanks
barry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
