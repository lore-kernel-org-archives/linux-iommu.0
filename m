Return-Path: <SRS0=/Eks=4X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D75C10F25
	for <iommu@archiver.kernel.org>; Fri,  6 Mar 2020 09:56:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45912072D
	for <iommu@archiver.kernel.org>; Fri,  6 Mar 2020 09:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+vSL2j8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45912072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A15AD20508;
	Fri,  6 Mar 2020 09:56:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GvT7k+EK+z58; Fri,  6 Mar 2020 09:56:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 98A9C204DB;
	Fri,  6 Mar 2020 09:56:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D6BAC18D3;
	Fri,  6 Mar 2020 09:56:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C14C5C013E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 09:56:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BB51D87583
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 09:56:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J94L8EQByBqN for <iommu@lists.linux-foundation.org>;
 Fri,  6 Mar 2020 09:56:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B289C874A7
 for <iommu@lists.linux-foundation.org>; Fri,  6 Mar 2020 09:56:23 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id i9so1651245wml.4
 for <iommu@lists.linux-foundation.org>; Fri, 06 Mar 2020 01:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7WA8KxQFlE6B8qCgTFRQ+YrpY3GYXgfg/QOgK1f77sM=;
 b=Z+vSL2j8scoLCGNkZyokN15xJq1aniWOej9xa0jO1y/7aiSn6wUVH8PGc2mmDoSxkx
 hKYfJxAN6zemdGqm+/m/AwAvjWPnxYO3i8iNXAcdbEHhdhF9uUqrEmLCTqWr8lqHMzAU
 5/u3kcwg3w6H2MZgNCyva5KikrewAvfB8ctsMOZd35NBMW7AF0sSL8FLlPXq2+tABW5v
 3eEcsqfJCErJCgsWy2UZ9D2YLRkwKUkct1WRvgXbWkdGsl+/AqLCS6/4rzZZzbeHMXAb
 aQFr7GnLr8aSRBGzmvQjRCLEcf731bgNW+CD7gus6HHQ+MyynH9kPWMxpkl+lZZbqIIM
 Kw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7WA8KxQFlE6B8qCgTFRQ+YrpY3GYXgfg/QOgK1f77sM=;
 b=hUO5+witX3eR6ZnyLeApOwmObtEdLhf2aniEcoZxhx8BA7+doxhkHtPZyM/8AZbOFy
 sBlG4iu4ylfFXFQUvnHSWA9A0yCXVCaQ+40BT55waHm5UXAPEjeZTH4cG/m26p5jp68c
 IWMkSoM8Xo2DeksdqEH9eEe19Teka0h6vly1fjqh2HsWVt0AaE89bLoiOx1BvJp9jIx4
 ERQlRavuWpzkrxy/ZD06kYvypR4/46tpLWAHOCs9ZniGdGH/JmyQ14t5EFH+Bfy2zgdC
 NCt0FUGZkAvZUE8e38NsfH6mWBRZKy/5dWi2fRxk5UQt23y3oOPAJccCdPImtKmU25T+
 JbSA==
X-Gm-Message-State: ANhLgQ1hffrgsezEFfsFmr1gLGeGUU02CkayFtyshRfjrAK/uDswHgjv
 6p0LXPjHqnxXEPGtPouBDHXyww==
X-Google-Smtp-Source: ADFU+vuU7aA2moxG0tbzibZ6qR77dGIj+dzVr37QpTQa4MjhQ67tVPECKIRxafVKMX7XzMD/CpXXyA==
X-Received: by 2002:a7b:cd11:: with SMTP id f17mr3243910wmj.6.1583488582036;
 Fri, 06 Mar 2020 01:56:22 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m25sm12484502wml.35.2020.03.06.01.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 01:56:21 -0800 (PST)
Date: Fri, 6 Mar 2020 10:56:14 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200306095614.GA50020@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-2-jean-philippe@linaro.org>
 <20200224190056.GT31668@ziepe.ca> <20200225092439.GB375953@myrica>
 <20200225140814.GW31668@ziepe.ca> <20200228143935.GA2156@myrica>
 <20200228144844.GQ31668@ziepe.ca> <20200228150427.GF2156@myrica>
 <20200228151339.GS31668@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200228151339.GS31668@ziepe.ca>
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

On Fri, Feb 28, 2020 at 11:13:40AM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 28, 2020 at 04:04:27PM +0100, Jean-Philippe Brucker wrote:
> > On Fri, Feb 28, 2020 at 10:48:44AM -0400, Jason Gunthorpe wrote:
> > > On Fri, Feb 28, 2020 at 03:39:35PM +0100, Jean-Philippe Brucker wrote:
> > > > > > +	list_for_each_entry_rcu(bond, &io_mm->devices, mm_head) {
> > > > > > +		/*
> > > > > > +		 * To ensure that we observe the initialization of io_mm fields
> > > > > > +		 * by io_mm_finalize() before the registration of this bond to
> > > > > > +		 * the list by io_mm_attach(), introduce an address dependency
> > > > > > +		 * between bond and io_mm. It pairs with the smp_store_release()
> > > > > > +		 * from list_add_rcu().
> > > > > > +		 */
> > > > > > +		io_mm = rcu_dereference(bond->io_mm);
> > > > > 
> > > > > A rcu_dereference isn't need here, just a normal derference is fine.
> > > > 
> > > > bond->io_mm is annotated with __rcu (for iommu_sva_get_pasid_generic(),
> > > > which does bond->io_mm under rcu_read_lock())
> > > 
> > > I'm surprised the bond->io_mm can change over the lifetime of the
> > > bond memory..
> > 
> > The normal lifetime of the bond is between device driver calls to bind()
> > and unbind(). If the mm exits early, though, we clear bond->io_mm. The
> > bond is then stale but can only be freed when the device driver releases
> > it with unbind().
> 
> I usually advocate for simple use of these APIs. The mm_notifier_get()
> should happen in bind() and the matching put should happen in the
> call_rcu callbcak that does the kfree.

I tried to keep it simple like that: normally mmu_notifier_get() is called
in bind(), and mmu_notifier_put() is called in unbind(). 

Multiple device drivers may call bind() with the same mm. Each bind()
calls mmu_notifier_get(), obtains the same io_mm, and returns a new bond
(a device<->mm link). Each bond is freed by calling unbind(), which calls
mmu_notifier_put().

That's the most common case. Now if the process is killed and the mm
disappears, we do need to avoid use-after-free caused by DMA of the
mappings and the page tables. So the release() callback, before doing
invalidate_all, stops DMA and clears the page table pointer on the IOMMU
side. It detaches all bonds from the io_mm, calling mmu_notifier_put() for
each of them. After release(), bond objects still exists and device
drivers still need to free them with unbind(), but they don't point to an
io_mm anymore.

> Then you can never get a stale
> pointer. Don't worry about exit_mmap().
> 
> release() is an unusual callback and I see alot of places using it
> wrong. The purpose of release is to invalidate_all, that is it.
> 
> Also, confusingly release may be called multiple times in some
> situations, so it shouldn't disturb anything that might impact a 2nd
> call.

I hadn't realized that. The current implementation should be safe against
it, as release() is a nop if the io_mm doesn't have bonds anymore. Do you
have an example of such a situation?  I'm trying to write tests for this
kind of corner cases.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
