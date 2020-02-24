Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38F8C38BE1
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 19:01:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7899A20838
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 19:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FnR6SEUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7899A20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 48C5085C4C;
	Mon, 24 Feb 2020 19:01:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uLoF6yOVD53x; Mon, 24 Feb 2020 19:01:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CA99B85C19;
	Mon, 24 Feb 2020 19:01:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2B91C18DA;
	Mon, 24 Feb 2020 19:01:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F864C0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 19:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6B61486E1A
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 19:01:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0mm5jwvnb5qF for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 19:00:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com
 [209.85.219.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B51F085EE8
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 19:00:59 +0000 (UTC)
Received: by mail-qv1-f66.google.com with SMTP id y8so4599388qvk.6
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 11:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=nS4y9b6My/7+JIxHts6eLm8z0C4thsb5l3wuyiXD29Q=;
 b=FnR6SEUSqjm6pva9hmjZjjMQWlNtH8BimVmLzNHoyK5KObnwJJd4v62FvcucQXR613
 Vs8HRCZGupCTQ5IZ0JUUxDfBksnOmCrAaBY+t9FVQ6WaO9/f1nfENMH64EtLf6mQOl3A
 ULGnEHBvxwQ+J67AeNEUPMlBMuj+D9qb1H5X2oBhmsBZnIHcb4yro7ts8Lp+wdj45jEW
 v76e8KPBbvQd89kU+MetflzO8JQksrPwRwleGV8a9HuL+52ruaZpjBkc9Ny6pYP+Y1YO
 IlJp1zbAGL4jPjja65grNuAP/DFEdsR9iZ2aPGrstIS0jUFiDV/TkZWtZDP/2nIWRKh9
 659A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nS4y9b6My/7+JIxHts6eLm8z0C4thsb5l3wuyiXD29Q=;
 b=FPE9a7jtrg/y9XgfEgU52fZoz45tf5uWZqOE7JpFMa4BfCYbJ6P1eNaLJS7sdSatZs
 64HbcCPiRLPRHzICoD1may8Z68zqlpbJ3xqAbcKAnwEyy0iFYBiR0GZhS1leZUE6CZMS
 45KMpnNfQKkrOOOFke4tsVVs9X/3KQdjLtzwMGEfWCehXbYZ2glqKO8WHyitcEYXB0+F
 QOba1bKeDWQsHt6wvcjtHyedHUefB+dFTuCQl4CZ9nSiEjPtbRFk7iNKJC6+x++CJ4Mo
 PBbIO93G/g0m4tCT1/rhqycReAmmQiQ2O6PltdxkUqj1XkZpUcu/0++n9I1Jz4+rEi2i
 CFWA==
X-Gm-Message-State: APjAAAUk6xtb4E+Ovowhe9bQGaznaujbY/svPk02n60IYj/nHWasTAIu
 1bE2Jm8XV9WTGyvIC0u77xr7yw==
X-Google-Smtp-Source: APXvYqyNbYKidHbzZ1XJJ2LbIhIEjWa9RFdUt4bTzm6wm+o3ErpK3Y9OIJTvmpvQbXJ0sVD9TGvEfA==
X-Received: by 2002:ad4:4b21:: with SMTP id s1mr47274639qvw.81.1582570858491; 
 Mon, 24 Feb 2020 11:00:58 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id m17sm6086872qki.128.2020.02.24.11.00.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 24 Feb 2020 11:00:57 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1j6IyO-0005Dy-Tk; Mon, 24 Feb 2020 15:00:56 -0400
Date: Mon, 24 Feb 2020 15:00:56 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200224190056.GT31668@ziepe.ca>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200224182401.353359-2-jean-philippe@linaro.org>
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

On Mon, Feb 24, 2020 at 07:23:36PM +0100, Jean-Philippe Brucker wrote:
> The new allocation scheme introduced by 2c7933f53f6b ("mm/mmu_notifiers:
> add a get/put scheme for the registration") provides a convenient way
> for users to attach notifier data to an mm. However, it would be even
> better to create this notifier data atomically.
> 
> Since the alloc_notifier() callback only takes an mm argument at the
> moment, some users have to perform the allocation in two times.
> alloc_notifier() initially creates an incomplete structure, which is
> then finalized using more context once mmu_notifier_get() returns. This
> second step requires carrying an initialization lock in the notifier
> data and playing dirty tricks to order memory accesses against live
> invalidation.

This was the intended pattern. Tthere shouldn't be an real issue as
there shouldn't be any data on which to invalidate, ie the later patch
does:

+       list_for_each_entry_rcu(bond, &io_mm->devices, mm_head)

And that list is empty post-allocation, so no 'dirty tricks' required.

The other op callback is release, which also cannot be called as the
caller must hold a mmget to establish the notifier.

So just use the locking that already exists. There is one function
that calls io_mm_get() which immediately calls io_mm_attach, which
immediately grabs the global iommu_sva_lock.

Thus init the pasid for the first time under that lock and everything
is fine.

There is nothing inherently wrong with the approach in this patch, but
it seems unneeded in this case..

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
