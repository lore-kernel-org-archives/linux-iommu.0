Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91488C54FCB
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 13:57:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF512070B
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 13:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mkrf0mj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF512070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 343E187D46;
	Mon, 20 Apr 2020 13:57:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RzkAyoxz1xDj; Mon, 20 Apr 2020 13:57:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3146E87D17;
	Mon, 20 Apr 2020 13:57:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 089B0C07FF;
	Mon, 20 Apr 2020 13:57:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AF1AC0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 13:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 79E5D85E91
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 13:57:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 70Z_STLgROQd for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 13:57:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 601C485E8D
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 13:57:29 +0000 (UTC)
Received: by mail-qt1-f193.google.com with SMTP id l13so8442554qtr.7
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2Y6perFiVeQ3QgWqLdIJUPsNvFY3EZijv/H4bCO6lY4=;
 b=mkrf0mj2uMHggYNoMXheWws/vfopgkKMdOj2sk/jq91aSFV+FBOaAWfRgYM4xhELk7
 anpstJTVDOqB4qOo0kIzlwP5u+6LnNpFVukNArZe7hoXCLYhFl026KWaIuXtr4kZkZid
 IJPXMEIC09IH6YOe2rwd+xfDBeWBnrWSySHhYgTBZSWTKpo9IqVk8fy6bXSM56vwA15i
 B+iFKjqNtcVfDZUiEh19W3zpSzKpdAhDy9qMwP2cjBEKkXw0Ag44wC60d6gA72lrJVpw
 SXd4MaW5F4oNRRxVYpJvgy0d14clAWod3shTlEIMW54sI5mktrnVJXVbeAuYZDLtCCXN
 7OQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2Y6perFiVeQ3QgWqLdIJUPsNvFY3EZijv/H4bCO6lY4=;
 b=LpFowDsH2egGlmQmXir0StQUB283A45JCTbJeC/tD0Tta4uy0oZOJhhAJjPV6CAvIq
 2sbUGhjVmz+JjBvgBGwW0v6mbD5NEeJBTCJfLUNg+KFsqKT+Jpcs0/Yw5JV7WewQzHfI
 YuUgyouWm2q4QXGGYJk785iGlV+Qi1ZfKuVyZ9eFEvw3mIYp27+JkdKMTWf9f8eaBJK3
 EhurPsdbVmEE2zGJifc37UvUnX9pEBF13jtmDZ06qoSKlDxpEPIYX3TR93O+J3O0iz5x
 N1GUJLzopRf1Xr38VOLcdqZBS6fdrXJuMxgoZAt8ilc0/GSrtcu8mfDKIYZYAGi2oOjy
 UDFw==
X-Gm-Message-State: AGi0PubcDdFzTAmSaDvcBt7K3BUnQCn+iiitGq9FUp2xj69AnaWAQuTf
 9/k7bAFyoaa8eSBiv72CbuviGA==
X-Google-Smtp-Source: APiQypIj1R9FcMRfRka1KKXW7j9di+d85e9nm7Td/03CCkb8wDdEAIcizkSgGYTTocgktyzsVQW4zw==
X-Received: by 2002:ac8:82f:: with SMTP id u44mr15905874qth.198.1587391048363; 
 Mon, 20 Apr 2020 06:57:28 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id g14sm550791qtb.24.2020.04.20.06.57.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 20 Apr 2020 06:57:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jQWvP-0002ax-4d; Mon, 20 Apr 2020 10:57:27 -0300
Date: Mon, 20 Apr 2020 10:57:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
Message-ID: <20200420135727.GO26002@ziepe.ca>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org>
 <20200416085402.GB1286150@myrica>
 <20200416121331.GA18661@infradead.org>
 <20200420074213.GA3180232@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200420074213.GA3180232@myrica>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, linux-pci@vger.kernel.org,
 robin.murphy@arm.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 catalin.marinas@arm.com, zhangfei.gao@linaro.org, will@kernel.org,
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

On Mon, Apr 20, 2020 at 09:42:13AM +0200, Jean-Philippe Brucker wrote:
> On Thu, Apr 16, 2020 at 05:13:31AM -0700, Christoph Hellwig wrote:
> > On Thu, Apr 16, 2020 at 10:54:02AM +0200, Jean-Philippe Brucker wrote:
> > > On Thu, Apr 16, 2020 at 12:28:52AM -0700, Christoph Hellwig wrote:
> > > > > +	rcu_read_lock();
> > > > > +	hlist_for_each_entry_rcu(bond, &io_mm->devices, mm_node)
> > > > > +		io_mm->ops->invalidate(bond->sva.dev, io_mm->pasid, io_mm->ctx,
> > > > > +				       start, end - start);
> > > > > +	rcu_read_unlock();
> > > > > +}
> > > > 
> > > > What is the reason that the devices don't register their own notifiers?
> > > > This kinds of multiplexing is always rather messy, and you do it for
> > > > all the methods.
> > > 
> > > This sends TLB and ATC invalidations through the IOMMU, it doesn't go
> > > through device drivers
> > 
> > I don't think we mean the same thing, probably because of my rather
> > imprecise use of the word device.
> > 
> > What I mean is that the mmu_notifier should not be embedded into the
> > io_mm structure (whch btw, seems to have a way to generic name, just
> > like all other io_* prefixed names), but instead into the
> > iommu_bond structure.  That avoid the whole multiplexing layer.
> 
> Right, I can see the appeal. I still like having a single mmu notifier per
> mm because it ensures we allocate a single PASID per mm (as required by
> x86). I suppose one alternative is to maintain a hashtable of mm->pasid,
> to avoid iterating over all bonds during allocation.

I've been getting rid of hash tables like this.. Adding it to the
mm_struct does seem reasonable, I think PASID is a pretty broad
concept now.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
