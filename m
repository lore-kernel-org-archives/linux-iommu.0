Return-Path: <SRS0=/Eks=4X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94407C10DCE
	for <iommu@archiver.kernel.org>; Fri,  6 Mar 2020 17:42:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7E020656
	for <iommu@archiver.kernel.org>; Fri,  6 Mar 2020 17:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fceAxzqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7E020656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 10D5D86DF2;
	Fri,  6 Mar 2020 17:42:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RWzA2U9F_DOo; Fri,  6 Mar 2020 17:42:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6A67786BFE;
	Fri,  6 Mar 2020 17:42:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4990AC18D3;
	Fri,  6 Mar 2020 17:42:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2FD5C013E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 17:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C9C8F86C04
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 17:42:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0zfdpIlBds9q for <iommu@lists.linux-foundation.org>;
 Fri,  6 Mar 2020 17:42:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5617E86BFE
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 17:42:42 +0000 (UTC)
Received: by mail-qk1-f194.google.com with SMTP id f3so3111205qkh.1
 for <iommu@lists.linux-foundation.org>; Fri, 06 Mar 2020 09:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=PxT02ryeWyx7p1SBqN6kTMwWdglwMPqc7wMiUtKckm8=;
 b=fceAxzqKtPxKpBdyBHvIYC/k/jeNtyEFzrsgn7TJvkxLs22sR9WiBM6453QdPTwvJ2
 93UYmt1Orc9z4jHue6YWkq4c44RthUiPb/T9rH7qfZN2eZY2Xq3DFtWCpEtWlaAber1f
 HTsaHpVQnQu0i950k23k9hzTJEjKD+BN7/Y/tDId6MCXM2Jq/oAfQ5infM5paw03g9Vz
 fDBMIkB8bceHTgGX1/Vpyp9g9uOcrHu05i9iMph/9UxfrLbjUIDtwqwEFe+QO0y6kUt5
 zKGrPWs4/zh+Z5lFrLMK9wdgK1uWKJWRJ5Z5s7FtAiUywEXkXWhLK89r07oF90jjf8ZV
 UsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=PxT02ryeWyx7p1SBqN6kTMwWdglwMPqc7wMiUtKckm8=;
 b=Q9obb9ui/mT9R3o94yknf4E191YQ0AHv7jUwObuduJ1mp68AJYWgHmT5CB/2C7tFqf
 sF0XMu58+khfxeBFZC8NNtJBEvB6At0ngmn/ZI9V9kUdHDBvwgYtEwFN1CqcQXDRl1Dd
 JOOEvEhEaYPj2mKhkfAuUAeKzw2On8G0nEOD02tuEsviMUDeJ6rAy6YATXi+IDUKHxDE
 SaUofPlRWxjulB0tMCoJ/0fWSrcqv6myUxFfEjWYwiffYhfkGDx6V21wV0Lo0+p/T9IU
 gcvdMiVe08p8xmG1OaZfl5OsrOZhz734LSwMlJx+rz039j0xQJ8aQU7JQfzcBOJbPtLq
 MGZw==
X-Gm-Message-State: ANhLgQ2ctnfNLl5SzQkNQxCCldJC10d16kNLdMu5oPhpGapP36EIOoym
 DMiZWwv3VdPgePWNWylUnd2/Cw==
X-Google-Smtp-Source: ADFU+vsWbhZAJApLkHJjK1rpJphwwDR2QESHx2duAJgFhBpEHJLxHbOgXJEEbadil5uHQfcoM+kVpg==
X-Received: by 2002:a37:a44a:: with SMTP id n71mr2362594qke.210.1583516560952; 
 Fri, 06 Mar 2020 09:42:40 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id g15sm14342523qtq.71.2020.03.06.09.42.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 06 Mar 2020 09:42:40 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jAGzf-00060f-N3; Fri, 06 Mar 2020 13:42:39 -0400
Date: Fri, 6 Mar 2020 13:42:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200306174239.GM31668@ziepe.ca>
References: <20200225140814.GW31668@ziepe.ca> <20200228143935.GA2156@myrica>
 <20200228144844.GQ31668@ziepe.ca> <20200228150427.GF2156@myrica>
 <20200228151339.GS31668@ziepe.ca> <20200306095614.GA50020@myrica>
 <20200306130919.GJ31668@ziepe.ca> <20200306143556.GA99609@myrica>
 <20200306145245.GK31668@ziepe.ca> <20200306161519.GB99609@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200306161519.GB99609@myrica>
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

On Fri, Mar 06, 2020 at 05:15:19PM +0100, Jean-Philippe Brucker wrote:
> On Fri, Mar 06, 2020 at 10:52:45AM -0400, Jason Gunthorpe wrote:
> > On Fri, Mar 06, 2020 at 03:35:56PM +0100, Jean-Philippe Brucker wrote:
> > > On Fri, Mar 06, 2020 at 09:09:19AM -0400, Jason Gunthorpe wrote:
> > > > On Fri, Mar 06, 2020 at 10:56:14AM +0100, Jean-Philippe Brucker wrote:
> > > > > I tried to keep it simple like that: normally mmu_notifier_get() is called
> > > > > in bind(), and mmu_notifier_put() is called in unbind(). 
> > > > > 
> > > > > Multiple device drivers may call bind() with the same mm. Each bind()
> > > > > calls mmu_notifier_get(), obtains the same io_mm, and returns a new bond
> > > > > (a device<->mm link). Each bond is freed by calling unbind(), which calls
> > > > > mmu_notifier_put().
> > > > > 
> > > > > That's the most common case. Now if the process is killed and the mm
> > > > > disappears, we do need to avoid use-after-free caused by DMA of the
> > > > > mappings and the page tables. 
> > > > 
> > > > This is why release must do invalidate all - but it doesn't need to do
> > > > any more - as no SPTE can be established without a mmget() - and
> > > > mmget() is no longer possible past release.
> > > 
> > > In our case we don't have SPTEs, the whole pgd is shared between MMU and
> > > IOMMU (isolated using PASID tables).
> > 
> > Okay, but this just means that 'invalidate all' also requires
> > switching the PASID to use some pgd that is permanently 'all fail'.
> > 
> > > At this point no one told the device to stop working on this queue,
> > > it may still be doing DMA on this address space.
> > 
> > Sure, but there are lots of cases where a defective user space can
> > cause pages under active DMA to disappear, like munmap for
> > instance. Process exit is really no different, the PASID should take
> > errors and the device & driver should do whatever error flow it has.
> 
> We do have the possibility to shut things down in order, so to me this
> feels like a band-aid. 

->release() is called by exit_mmap which is called by mmput. There are
over a 100 callsites to mmput() and I'm not totally sure what the
rules are for release(). We've run into problems before with things
like this.

IMHO, due to this, it is best for release to be simple and have
conservative requirements on context like all the other notifier
callbacks. It is is not a good place to put complex HW fencing driver
code.

In particular that link you referenced is suggesting the driver tear
down could take minutes - IMHO it is not OK to block mmput() for
minutes.

> The idea has come up before though [1], and I'm not strongly opposed
> to this model, but I'm still not convinced it's necessary. It does
> add more complexity to IOMMU drivers, to avoid printing out the
> errors that we wouldn't otherwise see, whereas device drivers need
> in any case to implement the logic that forces stop DMA.

Errors should not be printed to the kernel log for PASID cases
anyhow. PASID will be used by unpriv user, and unpriv user should not
be able to trigger kernel prints at will, eg by doing dma to nmap VA
or whatever. 

Process exit is just another case of this, and should not be treated
specially.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
