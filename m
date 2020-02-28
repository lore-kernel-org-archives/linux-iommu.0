Return-Path: <SRS0=BxgK=4Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DC5C3F2D2
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 15:04:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF30C24699
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 15:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QmD58Jr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF30C24699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 14FE588180;
	Fri, 28 Feb 2020 15:04:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fspg8E0-Jue2; Fri, 28 Feb 2020 15:04:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2945D8817D;
	Fri, 28 Feb 2020 15:04:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10324C1D84;
	Fri, 28 Feb 2020 15:04:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98035C0177
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 15:04:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7C20485FC7
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 15:04:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pAoggYbASKRz for <iommu@lists.linux-foundation.org>;
 Fri, 28 Feb 2020 15:04:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E7C3785FB4
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 15:04:36 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id v4so3282772wrs.8
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 07:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2wX7TVsRPWlph7pT/yUYa9EScRJx6Bt/ZtuI3MJeqc0=;
 b=QmD58Jr5s6XBLi75aKomne6pIfi3eAwBW2uYAgqcgi9rYL6G2b64JBuAhhJ1f4te+t
 YMUkbgfFABgR0aUFU4JS096/XwdfBA48niRJ6aEs7tCqepHjgsV+l2E6wcg2Pjfx8yDo
 nf2skHBkoT9WNffr5CVK3OP/PqPaYbv3aLmg1bq6Ck4RCaCb9gSeMd1pwHi25t4XMDZ2
 wTbnbrTrIL7bSS1pZZd4ftBNuWdi6gB3+KHzkO3i4r62kLW9iRm0F/3xPVeufpfeXlyV
 F/ABlN3x4IYUOzxYknE1CmZaru7JzdyANO9LsTAgaHuR2Jzumx6YW0C7y8C7WKLy44Wn
 wxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2wX7TVsRPWlph7pT/yUYa9EScRJx6Bt/ZtuI3MJeqc0=;
 b=YUb5btM5k4mXU7US/pNe6DSZnWdg1pcw7yippjDj5y6rwUS44B5ZVs+yIYc5SjKmJ1
 kAF6stpE5rYC5DblUlz9JWCC/bVQZwVx2H9SbXa6tSyCL6UotY3eGpu7F5YfZHzMTEde
 rMoUoP77cvLsGeW6fa1A7lRQT74Gk+OlcAXUaqmmeEw6S32aDhHv7Uctmi3pyijMpLPO
 wFM76nYEo+zUxWbRXUjQkUInYfUdiewSG66eDpOklqSTQuktQPqHYA4gvw5DQEKr0as8
 Nl4Bf3KGY1dqsozED5f8FctfX3RFQ+dI7MdCWtz4eaRy4Hn8egNFCHxCXZ2zbvdwHaMn
 A8Rw==
X-Gm-Message-State: APjAAAVjeNLHrrPKQwlouQbIpwMun/PzrY/SpHEtOQGIKq9EQ4F3xUwM
 2aHI9zbU+LQ1RddlO7JaSLg5Lw==
X-Google-Smtp-Source: APXvYqy8YEE7PhfU6kfB6vVMG12QSn14jY2m/pgfxhc5df3Dfge/vtzS0lAN1v8FM3HtzCFu1cbkug==
X-Received: by 2002:adf:b19d:: with SMTP id q29mr5140671wra.211.1582902275442; 
 Fri, 28 Feb 2020 07:04:35 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id w19sm2377341wmc.22.2020.02.28.07.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 07:04:34 -0800 (PST)
Date: Fri, 28 Feb 2020 16:04:27 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200228150427.GF2156@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-2-jean-philippe@linaro.org>
 <20200224190056.GT31668@ziepe.ca> <20200225092439.GB375953@myrica>
 <20200225140814.GW31668@ziepe.ca> <20200228143935.GA2156@myrica>
 <20200228144844.GQ31668@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200228144844.GQ31668@ziepe.ca>
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

On Fri, Feb 28, 2020 at 10:48:44AM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 28, 2020 at 03:39:35PM +0100, Jean-Philippe Brucker wrote:
> > > > +	list_for_each_entry_rcu(bond, &io_mm->devices, mm_head) {
> > > > +		/*
> > > > +		 * To ensure that we observe the initialization of io_mm fields
> > > > +		 * by io_mm_finalize() before the registration of this bond to
> > > > +		 * the list by io_mm_attach(), introduce an address dependency
> > > > +		 * between bond and io_mm. It pairs with the smp_store_release()
> > > > +		 * from list_add_rcu().
> > > > +		 */
> > > > +		io_mm = rcu_dereference(bond->io_mm);
> > > 
> > > A rcu_dereference isn't need here, just a normal derference is fine.
> > 
> > bond->io_mm is annotated with __rcu (for iommu_sva_get_pasid_generic(),
> > which does bond->io_mm under rcu_read_lock())
> 
> I'm surprised the bond->io_mm can change over the lifetime of the
> bond memory..

The normal lifetime of the bond is between device driver calls to bind()
and unbind(). If the mm exits early, though, we clear bond->io_mm. The
bond is then stale but can only be freed when the device driver releases
it with unbind().

> 
> > > > If io_mm->ctx and io_mm->ops are already valid before the
> > > > mmu notifier is published, then we don't need that stuff.
> > > 
> > > So, this trickyness with RCU is not a bad reason to introduce the priv
> > > scheme, maybe explain it in the commit message?
> > 
> > Ok, I've added this to the commit message:
> > 
> >     The IOMMU SVA module, which attaches an mm to multiple devices,
> >     exemplifies this situation. In essence it does:
> > 
> >             mmu_notifier_get()
> >               alloc_notifier()
> >                  A = kzalloc()
> >               /* MMU notifier is published */
> >             A->ctx = ctx;                           // (1)
> >             device->A = A;
> >             list_add_rcu(device, A->devices);       // (2)
> > 
> >     The invalidate notifier, which may start running before A is fully
> >     initialized at (1), does the following:
> > 
> >             io_mm_invalidate(A)
> >               list_for_each_entry_rcu(device, A->devices)
> >                 A = device->A;                      // (3)
> 
> I would drop the work around from the decription, it is enough to say
> that the line below needs to observe (1) after (2) and this is
> trivially achieved by moving (1) to before publishing the notifier so
> the core MM locking can be used.

Ok, will do

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
