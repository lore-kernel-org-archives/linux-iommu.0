Return-Path: <SRS0=/Eks=4X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B02C10F00
	for <iommu@archiver.kernel.org>; Fri,  6 Mar 2020 14:52:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A3120848
	for <iommu@archiver.kernel.org>; Fri,  6 Mar 2020 14:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aihyF2t/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A3120848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6D3D2874A7;
	Fri,  6 Mar 2020 14:52:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xt+ME3ufp3o1; Fri,  6 Mar 2020 14:52:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6C40786DE7;
	Fri,  6 Mar 2020 14:52:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58B45C18DA;
	Fri,  6 Mar 2020 14:52:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0DF9C013E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 14:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BCFFA2278E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 14:52:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4+uJATTWd06l for <iommu@lists.linux-foundation.org>;
 Fri,  6 Mar 2020 14:52:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by silver.osuosl.org (Postfix) with ESMTPS id C9E262010A
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 14:52:47 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id 145so2538968qkl.2
 for <iommu@lists.linux-foundation.org>; Fri, 06 Mar 2020 06:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=+GR87JEz7bnHSu9Y+6bwTYgFaQr/zFIG/NuG9Kdwt4s=;
 b=aihyF2t/7s9DwcSYHNvpWHnT3C1bxl/IZjNLEoNgOyzpHGq2CUT5SBQgARQYZcC3G6
 3QQcrLEwVInFxDWyTBXRLmXxACdXjYVIqAViex2/tQdPqzBlGGoQch5dkM9CiRhOY7Yr
 yUUf7KhbVdR7MKAD56vslHiz5RAfoDjMkqmQ4qTCQQ6gYW3ezJVfIhj1mUTLOa6MObXQ
 NNFpk5xfcDcsqIhcLIaVcUtJ5aS7/SVw3PB4wRfYRl19e3Sdp1bfYlUxjk95UosNuxLf
 bfLFXQreuG1sjxtV/SfKboz2+FupAmFWP79r+I3j96a8IihKr6R1cSfkp7pDo/v0x+v/
 8FdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+GR87JEz7bnHSu9Y+6bwTYgFaQr/zFIG/NuG9Kdwt4s=;
 b=fTf+ETxwiJC4FB9HYd/UyuVgpUStIUwHw/d+WTcycD3L5LQt1kB7UD4Jo8xq1B6HNT
 ok/6vQROHOUekpXyd19z5/aCzL7Oq7XWPJqr7rPyJM2eZNJnIjTll6RmVZ8xjwqwtatz
 TPFtZG0iGrjy9DJPG9tfJkmz2rXbPN0Vze1a44JwenSvkBtWC42EwbStEaZgqaM8SVkz
 sgu31V0IvH8hfRgfszBawCDgjMyf+XWY2hnZyYN0hexy7mxXxo28itSpWV/2VnJLWl89
 o8t3BtLnQJBKU2f1RcAtCbPXVBtMDXFCgN0GWaMiPwqYm7kVchtgTNyRRe78gD7QxwL8
 UOyQ==
X-Gm-Message-State: ANhLgQ0K0WTf5jW/rpC/Kd7Yh+9WJ2bKc+/XbizAko5Du0v2liuGuJT1
 Nc5uOA74oOfHksvXGxW4AzeprQ==
X-Google-Smtp-Source: ADFU+vt8B7E7ypc6uA8DcBdUQZ7yTuum2anrkiUB7D/EpPFaARsWnBpjWIkRxETgE9O5KR7vdHN99g==
X-Received: by 2002:a05:620a:1427:: with SMTP id
 k7mr3113149qkj.377.1583506366542; 
 Fri, 06 Mar 2020 06:52:46 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id n59sm8640178qtd.77.2020.03.06.06.52.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 06 Mar 2020 06:52:46 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jAELF-00041P-Jc; Fri, 06 Mar 2020 10:52:45 -0400
Date: Fri, 6 Mar 2020 10:52:45 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200306145245.GK31668@ziepe.ca>
References: <20200224190056.GT31668@ziepe.ca> <20200225092439.GB375953@myrica>
 <20200225140814.GW31668@ziepe.ca> <20200228143935.GA2156@myrica>
 <20200228144844.GQ31668@ziepe.ca> <20200228150427.GF2156@myrica>
 <20200228151339.GS31668@ziepe.ca> <20200306095614.GA50020@myrica>
 <20200306130919.GJ31668@ziepe.ca> <20200306143556.GA99609@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200306143556.GA99609@myrica>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, kevin.tian@intel.com,
 Dimitri Sivanich <sivanich@sgi.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org,
 robin.murphy@arm.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, catalin.marinas@arm.com, zhangfei.gao@linaro.org,
 Andrew Morton <akpm@linux-foundation.org>, will@kernel.org,
 christian.koenig@amd.com, linux-arm-kernel@lists.infradead.org
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

On Fri, Mar 06, 2020 at 03:35:56PM +0100, Jean-Philippe Brucker wrote:
> On Fri, Mar 06, 2020 at 09:09:19AM -0400, Jason Gunthorpe wrote:
> > On Fri, Mar 06, 2020 at 10:56:14AM +0100, Jean-Philippe Brucker wrote:
> > > I tried to keep it simple like that: normally mmu_notifier_get() is called
> > > in bind(), and mmu_notifier_put() is called in unbind(). 
> > > 
> > > Multiple device drivers may call bind() with the same mm. Each bind()
> > > calls mmu_notifier_get(), obtains the same io_mm, and returns a new bond
> > > (a device<->mm link). Each bond is freed by calling unbind(), which calls
> > > mmu_notifier_put().
> > > 
> > > That's the most common case. Now if the process is killed and the mm
> > > disappears, we do need to avoid use-after-free caused by DMA of the
> > > mappings and the page tables. 
> > 
> > This is why release must do invalidate all - but it doesn't need to do
> > any more - as no SPTE can be established without a mmget() - and
> > mmget() is no longer possible past release.
> 
> In our case we don't have SPTEs, the whole pgd is shared between MMU and
> IOMMU (isolated using PASID tables).

Okay, but this just means that 'invalidate all' also requires
switching the PASID to use some pgd that is permanently 'all fail'.

> At this point no one told the device to stop working on this queue,
> it may still be doing DMA on this address space.

Sure, but there are lots of cases where a defective user space can
cause pages under active DMA to disappear, like munmap for
instance. Process exit is really no different, the PASID should take
errors and the device & driver should do whatever error flow it has.

Involving a complex driver flow in the exit_mmap path seems like
dangerous complexity to me.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
