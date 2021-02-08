Return-Path: <SRS0=aVDl=HK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E0DC433DB
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 21:35:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E82664E8F
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 21:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E82664E8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 93B3B2155D;
	Mon,  8 Feb 2021 21:35:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CG3s0Ujpz2lH; Mon,  8 Feb 2021 21:35:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 146C8204D5;
	Mon,  8 Feb 2021 21:35:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0476EC0174;
	Mon,  8 Feb 2021 21:35:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96312C013A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 21:35:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 738CA21526
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 21:35:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sfZ8EGi7Lpdq for <iommu@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 21:35:38 +0000 (UTC)
X-Greylist: delayed 00:05:12 by SQLgrey-1.7.6
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by silver.osuosl.org (Postfix) with ESMTPS id DAEF1204D5
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 21:35:37 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id d85so16044443qkg.5
 for <iommu@lists.linux-foundation.org>; Mon, 08 Feb 2021 13:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9qkflY5nbnrf1GydCZmzRH2mO9Zc9djQTfZafbwHa/g=;
 b=n+Mx8XiSpZIp2bzSh2g6O0jcWjTGzzEPa5DiVzraCS1z3aCBR7wlO4ojyvJXShXJqo
 dErGhsLjKKXGxEO4udDchIYBWbjDTcQIGFEXN/foR//8dLWzKZFOSVsJPe9ZU60Gz3ku
 ALAVbytloLtwAOoVkuyDyiODB5zBwwa/R5CnRGsiJbwztjwgeQ0miNWzM368nevWNycx
 Z0eWTWRLO+N+Oz19f9i7ogGrDu3DLRq3e08oV4K7/TmaG0lH5CTxMMzdEtlcX8Jgplyz
 K6PyW8JX+anGM6F7IruuNGlOi7PcrSYVM9d2Cfb6AG3AzVpw85b7UgE0KO478IIrv4L7
 2t9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9qkflY5nbnrf1GydCZmzRH2mO9Zc9djQTfZafbwHa/g=;
 b=ElNFSBgicywES4ptXzVW+1vAs8mfYFwfD3SaTEjPzREYHaLWYm57ZYCMkEB5JPQUjQ
 +5GjQf6/ikks5Clju9tY31qOhBWwlxFeXm1Me7pNIxP3E/u3HekxHXw2f5vr7uD3Iw/Q
 HnOAP0Krpim83h6td0VuJ5fBXbCsgcwujCP70m1SFj3RN7DYPOeghWnFOGIN22h5/71R
 ogGoWv+ZvAj1IvHkRmhq94lsdOxoHQ9QvweQXR1l4p1s5Rrh9UPlbSy8vqLtiOrx71rx
 OCUdorTymfyCZn2bI8uJPaFeqW/fBuoa8Xur1345dxIwO9HWwd7S18j1uc7QZJKlMybe
 zJNA==
X-Gm-Message-State: AOAM531SY9uFEIc6DNVeamt0LK3+ADryja2T5UeVC+9tNOvf+2fcz2JQ
 Bp/xfcpHScEakpQtFaXpYFf1NPqmr9ErTID3
X-Google-Smtp-Source: ABdhPJzFdGa04wz/eyZ4j9hhnXsbH3wCkpiuKEtnZzgfxA85nq9G/2jkn8TOldhN5jopR+fvtidBWA==
X-Received: by 2002:a37:bc45:: with SMTP id m66mr4594058qkf.86.1612819824350; 
 Mon, 08 Feb 2021 13:30:24 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.115.133])
 by smtp.gmail.com with ESMTPSA id c63sm14340966qkf.8.2021.02.08.13.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 13:30:23 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1l9E6x-00560h-7w; Mon, 08 Feb 2021 17:30:23 -0400
Date: Mon, 8 Feb 2021 17:30:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
Message-ID: <20210208213023.GZ4718@ziepe.ca>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <a587bd61-9194-4b46-c122-8b4da7b941a8@redhat.com>
 <20210208183348.GV4718@ziepe.ca>
 <0dca000a6cd34d8183062466ba7d6eaf@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0dca000a6cd34d8183062466ba7d6eaf@hisilicon.com>
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "chensihang \(A\)" <chensihang1@hisilicon.com>,
 David Hildenbrand <david@redhat.com>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
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

On Mon, Feb 08, 2021 at 08:35:31PM +0000, Song Bao Hua (Barry Song) wrote:
> 
> 
> > From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
> > Sent: Tuesday, February 9, 2021 7:34 AM
> > To: David Hildenbrand <david@redhat.com>
> > Cc: Wangzhou (B) <wangzhou1@hisilicon.com>; linux-kernel@vger.kernel.org;
> > iommu@lists.linux-foundation.org; linux-mm@kvack.org;
> > linux-arm-kernel@lists.infradead.org; linux-api@vger.kernel.org; Andrew
> > Morton <akpm@linux-foundation.org>; Alexander Viro <viro@zeniv.linux.org.uk>;
> > gregkh@linuxfoundation.org; Song Bao Hua (Barry Song)
> > <song.bao.hua@hisilicon.com>; kevin.tian@intel.com;
> > jean-philippe@linaro.org; eric.auger@redhat.com; Liguozhu (Kenneth)
> > <liguozhu@hisilicon.com>; zhangfei.gao@linaro.org; chensihang (A)
> > <chensihang1@hisilicon.com>
> > Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
> > pin
> > 
> > On Mon, Feb 08, 2021 at 09:14:28AM +0100, David Hildenbrand wrote:
> > 
> > > People are constantly struggling with the effects of long term pinnings
> > > under user space control, like we already have with vfio and RDMA.
> > >
> > > And here we are, adding yet another, easier way to mess with core MM in the
> > > same way. This feels like a step backwards to me.
> > 
> > Yes, this seems like a very poor candidate to be a system call in this
> > format. Much too narrow, poorly specified, and possibly security
> > implications to allow any process whatsoever to pin memory.
> > 
> > I keep encouraging people to explore a standard shared SVA interface
> > that can cover all these topics (and no, uaccel is not that
> > interface), that seems much more natural.
> > 
> > I still haven't seen an explanation why DMA is so special here,
> > migration and so forth jitter the CPU too, environments that care
> > about jitter have to turn this stuff off.
> 
> This paper has a good explanation:
> https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=7482091
> 
> mainly because page fault can go directly to the CPU and we have
> many CPUs. But IO Page Faults go a different way, thus mean much
> higher latency 3-80x slower than page fault:
> events in hardware queue -> Interrupts -> cpu processing page fault
> -> return events to iommu/device -> continue I/O.

The justifications for this was migration scenarios and migration is
short. If you take a fault on what you are migrating only then does it
slow down the CPU.

Are you also working with HW where the IOMMU becomes invalidated after
a migration and doesn't reload?

ie not true SVA but the sort of emulated SVA we see in a lot of
places?

It would be much better to work improve that to have closer sync with the
CPU page table than to use pinning.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
