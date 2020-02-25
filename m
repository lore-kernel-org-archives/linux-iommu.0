Return-Path: <SRS0=zhz4=4N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F465C35E01
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 14:08:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 429D521744
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 14:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Isrj4uis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429D521744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E2A89877B1;
	Tue, 25 Feb 2020 14:08:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ToxHIndop-VG; Tue, 25 Feb 2020 14:08:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3673085C6F;
	Tue, 25 Feb 2020 14:08:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24F1BC18DA;
	Tue, 25 Feb 2020 14:08:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9865C0177
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 14:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B0A2285F43
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 14:08:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o4kKx3KIrLOn for <iommu@lists.linux-foundation.org>;
 Tue, 25 Feb 2020 14:08:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 67DC885F3D
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 14:08:16 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id u124so11952795qkh.13
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 06:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rt78zreyzIjHr6yoxlPIHQMecYqp6DqMRSSz9rYV7h8=;
 b=Isrj4uisk1xkziFhawt/8rlAzaSUqp8STgmAQtTr204aEqpvtn33NNz3uBRGlTILtq
 mpyWpAoD6uNduHiL7HXHOhB8Qp4ymOGS5Sd+60cEBCq3seKkCyTFJierH2ip6ln3uFci
 ZA+aKPd1I1h+Bh7pYxiUdietKO7JVJzBXIz4XxcSE7+5Dfq2KFPATR8B2FbQa3Sb1OlF
 nlQLPzC3RedPDaZvQ+JqD/+8di3hj2TnyEdtdmjyjKXPSFHPmttr85IhBJwlgllvLlB2
 T3nZ6tG0sC/VDVBGYuQXY8FZ2FoIiQqFOAwhEGveqrKT84L0zsl1StN0KLacxl6FiNWQ
 1dfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rt78zreyzIjHr6yoxlPIHQMecYqp6DqMRSSz9rYV7h8=;
 b=tWZlIamrVmVVFi7ushhV8H7vuiA01xe7aVVg3vtT6PGsRyNjswB27D9kSmnFOxFhf1
 jdG/eHyYrrnKRGpQsfi08G8Vaecl0dk52HOH3h/LoMbZgAFynMy4hwosDxqeyFZs4Opi
 s+JJFCS14uSIHDVtYLsIVqxOTW6TmacJlHW5/z/5x/ZEhcxzonkh+skIIPpmmFRyUydW
 ZHMgSTOQtGhHZZHNr/LXhqMqHmAC4230NrpCGwRsGCFogYrLvnNESdY8rWikPVxoiZkY
 gWABtNl47UwGEtetsECo8x6g/o9APm5W2d2KinITYdeDj1/7lzyRRkAzrcpJCEyX7m8k
 PpBw==
X-Gm-Message-State: APjAAAViblTzClp+RROdFQcxhOPC7BMSX+boHMSoTFXhJQUp0VmGoeKa
 X1pJHh+HmSMwTs1+DvYVkfIW5g==
X-Google-Smtp-Source: APXvYqzoKfzZQNX2DE6QpwzMJc/kJ1wZx8yapE9f3rFQlORpnW5yrsgC7Cf2AglgqNASds83iDpsag==
X-Received: by 2002:ae9:e711:: with SMTP id m17mr13060092qka.393.1582639695367; 
 Tue, 25 Feb 2020 06:08:15 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id x14sm4057470qkf.99.2020.02.25.06.08.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 25 Feb 2020 06:08:14 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1j6asg-0000Vc-2U; Tue, 25 Feb 2020 10:08:14 -0400
Date: Tue, 25 Feb 2020 10:08:14 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200225140814.GW31668@ziepe.ca>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-2-jean-philippe@linaro.org>
 <20200224190056.GT31668@ziepe.ca> <20200225092439.GB375953@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200225092439.GB375953@myrica>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: mark.rutland@arm.com, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 will@kernel.org, Dimitri Sivanich <sivanich@sgi.com>, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, devicetree@vger.kernel.org, kevin.tian@intel.com,
 Arnd Bergmann <arnd@arndb.de>, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>,
 robin.murphy@arm.com, christian.koenig@amd.com
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

On Tue, Feb 25, 2020 at 10:24:39AM +0100, Jean-Philippe Brucker wrote:
> On Mon, Feb 24, 2020 at 03:00:56PM -0400, Jason Gunthorpe wrote:
> > On Mon, Feb 24, 2020 at 07:23:36PM +0100, Jean-Philippe Brucker wrote:
> > > The new allocation scheme introduced by 2c7933f53f6b ("mm/mmu_notifiers:
> > > add a get/put scheme for the registration") provides a convenient way
> > > for users to attach notifier data to an mm. However, it would be even
> > > better to create this notifier data atomically.
> > > 
> > > Since the alloc_notifier() callback only takes an mm argument at the
> > > moment, some users have to perform the allocation in two times.
> > > alloc_notifier() initially creates an incomplete structure, which is
> > > then finalized using more context once mmu_notifier_get() returns. This
> > > second step requires carrying an initialization lock in the notifier
> > > data and playing dirty tricks to order memory accesses against live
> > > invalidation.
> > 
> > This was the intended pattern. Tthere shouldn't be an real issue as
> > there shouldn't be any data on which to invalidate, ie the later patch
> > does:
> > 
> > +       list_for_each_entry_rcu(bond, &io_mm->devices, mm_head)
> > 
> > And that list is empty post-allocation, so no 'dirty tricks' required.
> 
> Before introducing this patch I had the following code:
> 
> +	list_for_each_entry_rcu(bond, &io_mm->devices, mm_head) {
> +		/*
> +		 * To ensure that we observe the initialization of io_mm fields
> +		 * by io_mm_finalize() before the registration of this bond to
> +		 * the list by io_mm_attach(), introduce an address dependency
> +		 * between bond and io_mm. It pairs with the smp_store_release()
> +		 * from list_add_rcu().
> +		 */
> +		io_mm = rcu_dereference(bond->io_mm);

A rcu_dereference isn't need here, just a normal derference is fine.

> +		io_mm->ops->invalidate(bond->sva.dev, io_mm->pasid, io_mm->ctx,
> +				       start, end - start);
> +	}
> 
> (1) io_mm_get() would obtain an empty io_mm from iommu_notifier_get().
> (2) then io_mm_finalize() would initialize io_mm->ops, io_mm->ctx, etc.
> (3) finally io_mm_attach() would add the bond to io_mm->devices.
> 
> Since the above code can run before (2) it needs to observe valid
> io_mm->ctx, io_mm->ops initialized by (2) after obtaining the bond
> initialized by (3). Which I believe requires the address dependency from
> the rcu_dereference() above or some stronger barrier to pair with the
> list_add_rcu().

The list_for_each_entry_rcu() is an acquire that already pairs with
the release in list_add_rcu(), all you need is a data dependency chain
starting on bond to be correct on ordering.

But this is super tricky :\

> If io_mm->ctx and io_mm->ops are already valid before the
> mmu notifier is published, then we don't need that stuff.

So, this trickyness with RCU is not a bad reason to introduce the priv
scheme, maybe explain it in the commit message?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
