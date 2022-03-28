Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690D1C433F5
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 23:06:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCE5A401BE;
	Mon, 28 Mar 2022 23:06:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 50PHdVRZAP4l; Mon, 28 Mar 2022 23:06:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DD9FD414CC;
	Mon, 28 Mar 2022 23:06:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8995EC001D;
	Mon, 28 Mar 2022 23:06:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB22BC0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 23:06:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D569F414CC
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 23:06:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XE_2oEwo38DQ for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 23:06:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 21D87401BE
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 23:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648508764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/pxpSsyLbwmiHoLxXFbyVJ/FnVtdO6+a2Mb99oUfeyw=;
 b=RPoVrTMnagDdSlSc6b0XOdNGf2ofhUL+XgedVHDnEbfvfoG+914NU8ZiTB7ynBcHIj9wHm
 YKof2+35UEUkWoUhg/ktP7glkm/vwQZ6VQyvtP7byZ1Q5+3IfMmd1HaBAnNtvrRsywTJHc
 PbmOnL7dVOnJzTPNxLeqPV0yYwli3Gw=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-J6Ygtes-NZ6lVy6EL6ZM8g-1; Mon, 28 Mar 2022 19:06:01 -0400
X-MC-Unique: J6Ygtes-NZ6lVy6EL6ZM8g-1
Received: by mail-il1-f197.google.com with SMTP id
 x6-20020a923006000000b002bea39c3974so8620218ile.12
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 16:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=/pxpSsyLbwmiHoLxXFbyVJ/FnVtdO6+a2Mb99oUfeyw=;
 b=1FNaFjnbaDVjNtAZhdutUqCrEiuedfX0JHTiCLFciuaC4j9i9VrjpsAHUU+F4zYkle
 GO4rd6/3rmREP/R0V4FljOEsxcIvpq5v6OhQUel8+6fWc2Ydi70EMM9wOcBRIGt+V119
 yV2G3+0z1+ZGkksN8T5XHUXtPQfRiNIlgh6V8w8iq6mCbMhHWj+2vRTNe2BtyN0b2EIq
 RB5NeeTpQtFGBmJiweGGC8Vy95SZxeLA/IXKTvMaYxsYTVVWItlo4bkHCHUuOOiQ783g
 oyWy0YOBZ5uKs+c/q5wJaRsJJvAmOHpv/IjD6H6SzkI7Li5lZmsBfXDMvP2l4RUq0iMM
 /XnQ==
X-Gm-Message-State: AOAM530mLWWlnb8SDSVRUU3q5QaUVpIQUKLWbkvYkdNpsQel+3SqHAeE
 0XX66Uxj1b7TCz8HvhfaPCxJfzkNwCdM1EXe1Hzd85Gxk8ryVPDwkTKaa9O9m7VDmec+moFf/xr
 7kXF8gkaIi0j23M/alfkBSn0ubILMYw==
X-Received: by 2002:a05:6638:1455:b0:323:6814:5095 with SMTP id
 l21-20020a056638145500b0032368145095mr4177168jad.62.1648508760485; 
 Mon, 28 Mar 2022 16:06:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEE1d3+Xw9AuHSSz27P+6LwlaOfc1OqepbZawz9IsBd534R0ThgdhiDyS1OWieLbVLfFp5uQ==
X-Received: by 2002:a05:6638:1455:b0:323:6814:5095 with SMTP id
 l21-20020a056638145500b0032368145095mr4177151jad.62.1648508760084; 
 Mon, 28 Mar 2022 16:06:00 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 d8-20020a056e02214800b002c7bea34e3dsm8069642ilv.46.2022.03.28.16.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Mar 2022 16:05:59 -0700 (PDT)
Date: Mon, 28 Mar 2022 17:05:58 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Daniel F. Smith" <dfsmith@us.ibm.com>
Subject: Re: Bug report: VFIO map/unmep mem subject to race and DMA data
 goes to incorrect page (4.18.0)
Message-ID: <20220328170558.79af68ff.alex.williamson@redhat.com>
In-Reply-To: <20220328191451.GA18248@porter.almaden.ibm.com>
References: <20220325200640.GA29990@porter.almaden.ibm.com>
 <20220325161022.00ab43ff.alex.williamson@redhat.com>
 <20220328191451.GA18248@porter.almaden.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: iommu@lists.linux-foundation.org
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

On Mon, 28 Mar 2022 12:14:51 -0700
"Daniel F. Smith" <dfsmith@us.ibm.com> wrote:

> Hi Alex,
> 
> Answers to questions I can answer are in-line.  First an apology
> though---the machine with the FPGA board is 1000 miles remote, and I don't
> have root access.  It's unlikely I will be able to do kernel patch testing.
> 
> 
> Alex Williamson scribed the following, on or around Fri, Mar 25, 2022 at 04:10:22PM -0600:
> > Hi Daniel,
> >   
> ...
> >
> > Coherency possibly.
> > 
> > There's a possible coherency issue at the compare depending on the
> > IOMMU capabilities which could affect whether DMA is coherent to memory
> > or requires an explicit flush.  I'm a little suspicious whether dmar0
> > is really the IOMMU controlling this device since you mention a 39bit
> > IOVA space, which is more typical of Intel client platforms which can
> > also have integrated graphics which often have a dedicated IOMMU at
> > dmar0 that isn't necessarily representative of the other IOMMUs in the
> > system, especially with regard to snoop-control.  Each dmar lists the
> > managed devices under it in sysfs to verify.  Support for snoop-control
> > would be identified in the ecap register rather than the cap register.
> > VFIO can also report coherency via the VFIO_DMA_CC_IOMMU extension
> > reported by VFIO_CHECK_EXTENSION ioctl.  
> 
> $ cat /sys/devices/virtual/iommu/dmar0/intel-iommu/cap
> d2008c40660462
> $ cat /sys/devices/virtual/iommu/dmar0/intel-iommu/ecap
> f050da
> $ lscpu | grep Model
> Model:               165
> Model name:          Intel(R) Xeon(R) W-1290P CPU @ 3.70GHz
> $ ls -l /sys/devices/virtual/iommu/dmar0/devices | wc -l
> 24
> $ ... ioctl(container_fd, VFIO_CHECK_EXTENSION, VFIO_DMA_CC_IOMMU)
> 0

Your ecap register reports bit 7 (Snoop Control) set, which should mean
that VT-d is enforcing coherency regardless of no-snoop transactions.
I suspect maybe the different result from the ioctl could be from
testing this extension before the IOMMU has been set for the
container(?)

> What are the implications of having no "IOMMU enforces DMA cache
> conherence"?  On this machine there is no access to a PCIe bus analyzer, but
> it's very unlikely that the TLPs would have NoSnoop set.

There's also bit 11 (Enable No Snoop) that could be cleared in the PCI
device control register, which would theoretically prevent the device
from using no-snoop TLPs.
 
> Is there a good way How can I tell what IOMMU I'm using?

Which DMAR?  Like this for example:

$ readlink -f /sys/bus/pci/devices/0000:04:00.0/iommu
/sys/devices/virtual/iommu/dmar3

Your listing of devices piped to wc would also reciprocally list the
device in that output.  With 24 devices there's a fair chance that
dmar0 is the only one used.

> (I did think it was strange that the IOMMU in this machine cannot handle
> enough bits for mapping IOVA==VMA.  The test code is running in a podman
> container, but (naively) I wouldn't expect that to make a difference.)

Single socket Xeon processors like this tend to share more similarities
to consumer desktop processors than to the "Scalable" line of Xeons.

FWIW, there's a proposal[1] for a new, shared userspace IOMMU interface
that includes an option for the kernel to allocate IOVAs for these
cases.

[1]https://lore.kernel.org/all/0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com/

> > However, CPU coherency might lead to a miscompare, but not necessarily a
> > miscompare matching the previous iteration.  Still, for completeness
> > let's make sure this isn't a gap in the test programming making invalid
> > assumptions about CPU/DMA coherency.
> > 
> > The fact that randomizing the IOVA provides a workaround though might
> > suggest something relative to the IOMMU page table coherency.  But for
> > the new mmap target to have the data from the previous iteration, the
> > IOMMU PTE would need to be stale on read, but correct on write in order
> > to land back in your new mmap.  That seems peculiar.  Are we sure the
> > FPGA device isn't caching the value at the IOVA or using any sort of
> > IOTLB caching such as ATS that might not be working correctly?  
> 
> I cannot say for certain what the FPGA caches, if anything.  The IP for that
> part is closed (search for Xilinx PG302 QDMA).  It should (!) be
> well-tested... oh for an analyzer!
> 
> > > Suggestion: Document issue when using fixed IOVA, or fix if security
> > > is a concern.  
> > 
> > I don't know that there's enough information here to make any
> > conclusions.  Here are some further questions:
> > 
> >  * What size mappings are being used, both for the mmap and the VFIO
> >    MAP/UNMAP operations.  
> 
> The test would often fail switching from an 8KB allocation to 12KB where the
> VMA would grow down by a page.  The mmap() always returned a 4KB aligned
> VMA, and the requested mmap() size was always an exact number of 4KB pages. 
> The VFIO map operations were always on the full extent of the mmap'd memory
> (likely makes Baulu's patch moot in this case).
> 
> A typical (not consistent) syndrome would be:
>   1st page: ok
>   2nd page: previous mmap'd data.
>   3rd page: ok
> We saw the issue on transfers both to and from the card.  I.e., we placed a
> memory block in the FPGA that we could interrogate when data were corrupted.

If we assume the previous mapping was for 8KB and the new mapping was
for 12KB, I might hypothesize that the extent of the IOTLB invalidation
when unmapping the 8KB mapping could have an off-by-one such that the
IOMMU has a stale entry for the 2nd page.  The 1st page would have been
invalidated correctly and the behavior of the 3rd page might depend on
where it fell in the mapping previously, and arbitrary pressures on the
IOTLB otherwise.

> (And as mentioned, just changing the IOVA fixed this issue.)

And that would also avoid a large number of IOTLB invalidation issues.

> >  * If the above is venturing into super page support (2MB), does the
> >    vfio_iommu_type1 module option disable_hugepages=1 affect the
> >    results.  
> 
> N/A.

Probably not, but I would be interested whether the results are more
consistent if you were to call MAP_DMA for each page rather than for
the whole buffer.  This would result in UNMAP_DMA across the whole IOVA
range of the buffer making individual unmaps for each page from the
IOMMU, which may point to something like the hypothesis above.
 
> >  * Along the same lines, does the kernel command line option
> >    intel_iommu=sp_off produce different results.  
> 
> Would this affect small pages?

Not likely.
 
> >  * Does this behavior also occur on upstream kernels (ie. v5.17)?  
> 
> Unknown, and (unfortunately) untestable at present.
> 
> >  * Do additional CPU cache flushes in the test program produce different
> >    results?  
> 
> We did a number of experiments using combinations of MAP_LOCKED, mlock(),
> barrier(), _mm_clflush().  They all affected reliability of the test
> (through timing?), but all ultimately failed.  I'm happy to try other
> flushes that can be achieved in non-root user space!
> 
> >  * Is this a consumer available FPGA device that others might be able
> >    to reproduce this issue?  I've always wanted such a device for
> >    testing, but also we can't rule out that the FPGA itself or its
> >    programming is the source of the miscompare.  
> 
> https://www.xilinx.com/products/boards-and-kits/vcu118.html
> Just don't look at the price too hard!

Yikes!  Thanks, and I'll be curious if breaking down the DMA_MAP calls
give us any further leads,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
