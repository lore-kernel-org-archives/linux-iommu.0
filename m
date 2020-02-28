Return-Path: <SRS0=BxgK=4Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65ACC3F2D4
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 14:39:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884312468E
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 14:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v7jFCl7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884312468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 516AC851A4;
	Fri, 28 Feb 2020 14:39:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SRJ9HKzy06NT; Fri, 28 Feb 2020 14:39:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 955C685092;
	Fri, 28 Feb 2020 14:39:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DF38C08A0;
	Fri, 28 Feb 2020 14:39:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A843C0177
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:39:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 72D9B86DCA
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:39:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oToNCzSDp2Ef for <iommu@lists.linux-foundation.org>;
 Fri, 28 Feb 2020 14:39:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4A4E886DC5
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 14:39:44 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id r17so3199994wrj.7
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 06:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=0bZtBK6HC94nIEacPL+V6SajMXEMTp9BAFVguJlaz+Q=;
 b=v7jFCl7OdeBWLjzPqqQAjqPrO/bujVk3YQ+hyShHLUfXRhZTEjht+G1EeKmiALwmrF
 +K7WW2uAYpZmtBzezuv2w6JdJBKpUdrsVHMYifTW3ola4TSC2f9DFxhquGsIb9CwsYcj
 I013dyyZ6/sIBNapnY1ANl/WmtPXa7OasfQA2NEYVXDTycNT7T/szrd8fPkyKttzDOhS
 AkrRy0wJlbcKiLL14UW8NPqnhuTmdqHG+yqHosj5GBL25ODsv4IeTcjj/P24pxnowkqO
 vgOp2+gPP2nbd/AjqXRm5VyhdRF+ZL9iukIU6Y4I/BilXyOX38XdNblyty+GogNj1crk
 MH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0bZtBK6HC94nIEacPL+V6SajMXEMTp9BAFVguJlaz+Q=;
 b=Ac7mWCwsYR+u1bk+0phXeKPou2+vAjoGpOeMgps6w5Impj4yoO1m5nhwwNaAs261Ob
 CRUBOi+z3PAxmNyI88ZaPUdybGuHXkblvR4nYxiRtQdTOJcX27f//MikIhMdTIKeoQuw
 eVpN1q1zKXq4m5OVPsjKM9j6Gyfrmf7oFfQntwyabqmNV0h29fNwL1PgfUsn/7DNnuE+
 bQrPzAFSYyvrlbwSorYnfbMObhSYfEGyISq83T408tmlktqg20RoN1Co0XlfNeXDp+/D
 qu6b7VeFboMXxdyPESmUpgskSW/NOaEH8Beu66bjtI7z/FSRSoPI6tI+i7AMAIv2NgJD
 nJIw==
X-Gm-Message-State: APjAAAW7aL3rClLNFnBBxUY561Xlmg7djqpBriLXyrcJzF4FQjXAn1/I
 q7Ta41sIoDDkaVrqIfGCcNIFJg==
X-Google-Smtp-Source: APXvYqy36tgbgxq6aX9f3yrenPgU8REug1w3SCjW1FgRUfJhNgTMxVBJWR+Ek+IeYzLIg7r0rI/Bvg==
X-Received: by 2002:adf:ec0e:: with SMTP id x14mr4896046wrn.270.1582900782663; 
 Fri, 28 Feb 2020 06:39:42 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id a7sm2294800wmj.12.2020.02.28.06.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 06:39:42 -0800 (PST)
Date: Fri, 28 Feb 2020 15:39:35 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200228143935.GA2156@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-2-jean-philippe@linaro.org>
 <20200224190056.GT31668@ziepe.ca> <20200225092439.GB375953@myrica>
 <20200225140814.GW31668@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200225140814.GW31668@ziepe.ca>
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

On Tue, Feb 25, 2020 at 10:08:14AM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 25, 2020 at 10:24:39AM +0100, Jean-Philippe Brucker wrote:
> > On Mon, Feb 24, 2020 at 03:00:56PM -0400, Jason Gunthorpe wrote:
> > > On Mon, Feb 24, 2020 at 07:23:36PM +0100, Jean-Philippe Brucker wrote:
> > > > The new allocation scheme introduced by 2c7933f53f6b ("mm/mmu_notifiers:
> > > > add a get/put scheme for the registration") provides a convenient way
> > > > for users to attach notifier data to an mm. However, it would be even
> > > > better to create this notifier data atomically.
> > > > 
> > > > Since the alloc_notifier() callback only takes an mm argument at the
> > > > moment, some users have to perform the allocation in two times.
> > > > alloc_notifier() initially creates an incomplete structure, which is
> > > > then finalized using more context once mmu_notifier_get() returns. This
> > > > second step requires carrying an initialization lock in the notifier
> > > > data and playing dirty tricks to order memory accesses against live
> > > > invalidation.
> > > 
> > > This was the intended pattern. Tthere shouldn't be an real issue as
> > > there shouldn't be any data on which to invalidate, ie the later patch
> > > does:
> > > 
> > > +       list_for_each_entry_rcu(bond, &io_mm->devices, mm_head)
> > > 
> > > And that list is empty post-allocation, so no 'dirty tricks' required.
> > 
> > Before introducing this patch I had the following code:
> > 
> > +	list_for_each_entry_rcu(bond, &io_mm->devices, mm_head) {
> > +		/*
> > +		 * To ensure that we observe the initialization of io_mm fields
> > +		 * by io_mm_finalize() before the registration of this bond to
> > +		 * the list by io_mm_attach(), introduce an address dependency
> > +		 * between bond and io_mm. It pairs with the smp_store_release()
> > +		 * from list_add_rcu().
> > +		 */
> > +		io_mm = rcu_dereference(bond->io_mm);
> 
> A rcu_dereference isn't need here, just a normal derference is fine.

bond->io_mm is annotated with __rcu (for iommu_sva_get_pasid_generic(),
which does bond->io_mm under rcu_read_lock())

> 
> > +		io_mm->ops->invalidate(bond->sva.dev, io_mm->pasid, io_mm->ctx,
> > +				       start, end - start);
> > +	}
> > 
> > (1) io_mm_get() would obtain an empty io_mm from iommu_notifier_get().
> > (2) then io_mm_finalize() would initialize io_mm->ops, io_mm->ctx, etc.
> > (3) finally io_mm_attach() would add the bond to io_mm->devices.
> > 
> > Since the above code can run before (2) it needs to observe valid
> > io_mm->ctx, io_mm->ops initialized by (2) after obtaining the bond
> > initialized by (3). Which I believe requires the address dependency from
> > the rcu_dereference() above or some stronger barrier to pair with the
> > list_add_rcu().
> 
> The list_for_each_entry_rcu() is an acquire that already pairs with
> the release in list_add_rcu(), all you need is a data dependency chain
> starting on bond to be correct on ordering.
> 
> But this is super tricky :\
> 
> > If io_mm->ctx and io_mm->ops are already valid before the
> > mmu notifier is published, then we don't need that stuff.
> 
> So, this trickyness with RCU is not a bad reason to introduce the priv
> scheme, maybe explain it in the commit message?

Ok, I've added this to the commit message:

    The IOMMU SVA module, which attaches an mm to multiple devices,
    exemplifies this situation. In essence it does:

            mmu_notifier_get()
              alloc_notifier()
                 A = kzalloc()
              /* MMU notifier is published */
            A->ctx = ctx;                           // (1)
            device->A = A;
            list_add_rcu(device, A->devices);       // (2)

    The invalidate notifier, which may start running before A is fully
    initialized at (1), does the following:

            io_mm_invalidate(A)
              list_for_each_entry_rcu(device, A->devices)
                A = device->A;                      // (3)
                device->invalidate(A->ctx)

    To ensure that an invalidate() thread observes write (1) before (2), it
    needs the address dependency (3). The resulting code is subtle and
    difficult to understand. If instead we fully initialize object A before
    publishing the MMU notifier, we don't need the complexity added by (3).


I'll try to improve the wording before sending next version.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
