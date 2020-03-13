Return-Path: <SRS0=vGJT=46=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B442C2BB1D
	for <iommu@archiver.kernel.org>; Fri, 13 Mar 2020 19:13:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A54206B7
	for <iommu@archiver.kernel.org>; Fri, 13 Mar 2020 19:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oMwn2l4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A54206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CA8808789B;
	Fri, 13 Mar 2020 19:13:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YExpnwYdB2ux; Fri, 13 Mar 2020 19:13:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id ED2AB876BF;
	Fri, 13 Mar 2020 19:13:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D590FC089F;
	Fri, 13 Mar 2020 19:13:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D9D1C0177
 for <iommu@lists.linux-foundation.org>; Fri, 13 Mar 2020 19:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 32B7589721
 for <iommu@lists.linux-foundation.org>; Fri, 13 Mar 2020 19:13:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u5bTYeqpemMy for <iommu@lists.linux-foundation.org>;
 Fri, 13 Mar 2020 19:13:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com
 [209.85.219.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 183478971B
 for <iommu@lists.linux-foundation.org>; Fri, 13 Mar 2020 19:13:28 +0000 (UTC)
Received: by mail-qv1-f65.google.com with SMTP id h20so1287215qvr.12
 for <iommu@lists.linux-foundation.org>; Fri, 13 Mar 2020 12:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=PPCktG6nEvhXmf9moRkI6GaBpVzb4qfjuLIfr4oX24U=;
 b=oMwn2l4h8Tx8PfqTSSs7jcFo6p6SGfbk2paFxxCwDo4UjReV48Ea0WeynOCfP0UESg
 D5Wx42yUB6XE+ECNQi7oshT1K/ITK0SF6QPuBytfQjClq48PdGDZYZkEX2mV44jsJSIZ
 JmfVZzlPCGi2MhuzvTGwSFBdDoRlPsRM31IIJc35bnTCaDgjPvUbOxtPlMnxXel6a7FY
 S2aBIZ8kX+EntSYh+k5ozLPfkAcPFTOlfbRQwTdgkhhTV0n44gq50oUncZS8eLjHICPI
 cRSxnBCKNdjtgvnQfhAC9bltqGz7vdFDc4E/CspLPEX7CV9xxZf3RANkXlRVD60eUYDj
 pyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=PPCktG6nEvhXmf9moRkI6GaBpVzb4qfjuLIfr4oX24U=;
 b=hnjKJhpsbEUrWtGvH5ko7ES29ZNUGGvE2nxWlJ/bzvbqRUcu+dbP/645oDRIgyiuMe
 fbv3yPUj3DMnZIf1tIqfaLZc3kAP3h4g0dPsaCVx5WZ/ybgIit/5dRL1ipzG6/Fvg7N1
 /zMms2IYmVshp+ZGSImGDr4wK6P5slJY9w2pOQ6V9UAEOax4xhW6mPvNb/wDVE0V61yJ
 ufkEp3gBMmzNoUoFcMTpLEktC1grdvYnxUsw3A+m15q5xCoHj5Bo+LHc+Ou7ttOa46CP
 IDcRDTNsj5n7oRHPJ5gOKWiu1KYDRxPzG/HClcMum4f97agqCV/ajDByELPUV578dbAg
 3+JQ==
X-Gm-Message-State: ANhLgQ0C1CZn0iGbC/QCTxUJcV5QK3ReCw/7DJyaAmXLmFk/nPA4sKmc
 FE9HH7tTjGzF30ekLFs+BtF3Cg==
X-Google-Smtp-Source: ADFU+vutgg3YrWNjonghOGBQTDVm29PBDy/u3g+sX5DbKZ/TP9j/X7cNOJItzK6P4dCcACQHzOv8kg==
X-Received: by 2002:ad4:458d:: with SMTP id x13mr13168915qvu.155.1584126806856; 
 Fri, 13 Mar 2020 12:13:26 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id b10sm9121866qto.60.2020.03.13.12.13.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 13 Mar 2020 12:13:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jCpkK-000463-VD; Fri, 13 Mar 2020 16:13:24 -0300
Date: Fri, 13 Mar 2020 16:13:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200313191324.GG31668@ziepe.ca>
References: <20200228144844.GQ31668@ziepe.ca> <20200228150427.GF2156@myrica>
 <20200228151339.GS31668@ziepe.ca> <20200306095614.GA50020@myrica>
 <20200306130919.GJ31668@ziepe.ca> <20200306143556.GA99609@myrica>
 <20200306145245.GK31668@ziepe.ca> <20200306161519.GB99609@myrica>
 <20200306174239.GM31668@ziepe.ca> <20200313184929.GC2574@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200313184929.GC2574@myrica>
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

On Fri, Mar 13, 2020 at 07:49:29PM +0100, Jean-Philippe Brucker wrote:
> On Fri, Mar 06, 2020 at 01:42:39PM -0400, Jason Gunthorpe wrote:
> > On Fri, Mar 06, 2020 at 05:15:19PM +0100, Jean-Philippe Brucker wrote:
> > > On Fri, Mar 06, 2020 at 10:52:45AM -0400, Jason Gunthorpe wrote:
> > > > On Fri, Mar 06, 2020 at 03:35:56PM +0100, Jean-Philippe Brucker wrote:
> > > > > On Fri, Mar 06, 2020 at 09:09:19AM -0400, Jason Gunthorpe wrote:
> > > > > > On Fri, Mar 06, 2020 at 10:56:14AM +0100, Jean-Philippe Brucker wrote:
> > > > > > > I tried to keep it simple like that: normally mmu_notifier_get() is called
> > > > > > > in bind(), and mmu_notifier_put() is called in unbind(). 
> > > > > > > 
> > > > > > > Multiple device drivers may call bind() with the same mm. Each bind()
> > > > > > > calls mmu_notifier_get(), obtains the same io_mm, and returns a new bond
> > > > > > > (a device<->mm link). Each bond is freed by calling unbind(), which calls
> > > > > > > mmu_notifier_put().
> > > > > > > 
> > > > > > > That's the most common case. Now if the process is killed and the mm
> > > > > > > disappears, we do need to avoid use-after-free caused by DMA of the
> > > > > > > mappings and the page tables. 
> > > > > > 
> > > > > > This is why release must do invalidate all - but it doesn't need to do
> > > > > > any more - as no SPTE can be established without a mmget() - and
> > > > > > mmget() is no longer possible past release.
> > > > > 
> > > > > In our case we don't have SPTEs, the whole pgd is shared between MMU and
> > > > > IOMMU (isolated using PASID tables).
> > > > 
> > > > Okay, but this just means that 'invalidate all' also requires
> > > > switching the PASID to use some pgd that is permanently 'all fail'.
> > > > 
> > > > > At this point no one told the device to stop working on this queue,
> > > > > it may still be doing DMA on this address space.
> > > > 
> > > > Sure, but there are lots of cases where a defective user space can
> > > > cause pages under active DMA to disappear, like munmap for
> > > > instance. Process exit is really no different, the PASID should take
> > > > errors and the device & driver should do whatever error flow it has.
> > > 
> > > We do have the possibility to shut things down in order, so to me this
> > > feels like a band-aid. 
> > 
> > ->release() is called by exit_mmap which is called by mmput. There are
> > over a 100 callsites to mmput() and I'm not totally sure what the
> > rules are for release(). We've run into problems before with things
> > like this.
> 
> A concrete example of something that could go badly if mmput() takes too
> long would greatly help. Otherwise I'll have a hard time justifying the
> added complexity.

It is not just takes too long, but also accidently causing locking
problems by doing very complex code in the release callback. Unless
you audit all the mmput call sites to define the calling conditions I
can't even say what the risk is here. 

Particularly, calling something with impossible to audit locking like
the dma_fence stuff from release is probably impossible to prove
safety and then keep safe.

It is easy enough to see where takes too long can have a bad impact,
mmput is called all over the place. Just in the RDMA code slowing it
down would block ODP page faulting completely for all processes.
This is not acceptable.

For this reason release callbacks must be simple/fast and must have
trivial locking.

> > Errors should not be printed to the kernel log for PASID cases
> > anyhow. PASID will be used by unpriv user, and unpriv user should not
> > be able to trigger kernel prints at will, eg by doing dma to nmap VA
> > or whatever. 
> 
> I agree. There is a difference, though, between invalid mappings and the
> absence of a pgd. The former comes from userspace issuing DMA on unmapped
> buffers, while the latter is typically a device/driver error which
> normally needs to be reported.

Why not make the pgd present as I suggested? Point it at a static
dummy pgd that always fails to page fault during release? Make the pgd
not present only once the PASID is fully destroyed.

That really is the only thing release is supposed to mean -> unmap all
VAs.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
