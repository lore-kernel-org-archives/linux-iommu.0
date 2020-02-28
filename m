Return-Path: <SRS0=BxgK=4Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD59C3F2D4
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 15:13:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C432469D
	for <iommu@archiver.kernel.org>; Fri, 28 Feb 2020 15:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ljgpp5xG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C432469D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 21B3D88183;
	Fri, 28 Feb 2020 15:13:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A8xTteh7FaV0; Fri, 28 Feb 2020 15:13:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5826988180;
	Fri, 28 Feb 2020 15:13:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C0B7C1D84;
	Fri, 28 Feb 2020 15:13:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3A1BC0177
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 15:13:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B8F3088182
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 15:13:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GvVdQ0xFTcDb for <iommu@lists.linux-foundation.org>;
 Fri, 28 Feb 2020 15:13:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com
 [209.85.219.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id F3F4C88180
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 15:13:41 +0000 (UTC)
Received: by mail-qv1-f66.google.com with SMTP id l14so1456945qvu.12
 for <iommu@lists.linux-foundation.org>; Fri, 28 Feb 2020 07:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Wq8nlNbsnwZz9fji3Cl/zgmv4zDoBKk4NoZF3W2wkDQ=;
 b=Ljgpp5xGPFtER1NGPwiitpNKYovODnCioFFOFLTyn2Ck/JR8HVTOx6j2p+g2nfn+c7
 ZZ4POl/CTaYoux0tyCmDMX6rtKyDdXnlMSGlJzLw9GbBTTzDfneWvjGmL5R0O0CGmHup
 2kp9E5S8Nxk8bHWYOZucZY6zoQaHVHi1zuuqGFV82FSHWkJZ4RoRvoylWAS0Wx4bc8K9
 VTIK4BTuE9ZYLVtjSIRYLN6ZaAkL0DcdWHFg4QbbWrjltc2/+KxfoeQyempXAsF7sI0A
 w3wliYOLVxCpNm799lBmqygk+nsWvEVxFVFJ7Lj2RQ/PkFIeGuOpHh4CgFZttaO2QJlZ
 F0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Wq8nlNbsnwZz9fji3Cl/zgmv4zDoBKk4NoZF3W2wkDQ=;
 b=g6OfH4abBi55mKbddaWCf+0I57zSYPNNAT/KDOzqdK7z5P57d+iVrOy6d6LOKjCzYD
 OEJkyCZJmwX7lq87Ys47TwTZfw8CkhpK/H3Q6P96nrJqVzEoMtKkhXeMnK55TvOG7OHD
 geUq3gsz3+BtjLeqq6SayqbNGiluwPqvmgE5uU/CRs1woXyXOfpG4CpkBlYmVVeG3ega
 o01S7dMVyQHsxn0bMvIcjmaBeQhsg9FKuu0rhMQzCYdtzSVdoQkPswgurc376R+P/Se5
 IVppINoYPxQE9MV+lqbKvgX8iQWLJG1Ro2NTTmu65UuvoQrN3C7ginn+ZTAXQFx5sosn
 LEGA==
X-Gm-Message-State: APjAAAXPHmdTuXpFsiOAE8DJD0pB7ZH2UNZ6XblVW/sS+mbYOt+ANiHz
 U9CPDzxRjNYHEwL9zwLBKIyX1A==
X-Google-Smtp-Source: APXvYqzNk6wZcWW+lmBBUW/lZq2ZIkoXwN/aWaAwf7XC2b5DqYukekLVZ6CR2bhdZGkTfI1iTFM0Cw==
X-Received: by 2002:a05:6214:a62:: with SMTP id
 ef2mr3484481qvb.109.1582902820845; 
 Fri, 28 Feb 2020 07:13:40 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id a128sm5296832qkc.44.2020.02.28.07.13.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Feb 2020 07:13:40 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1j7hKe-0005qo-0Q; Fri, 28 Feb 2020 11:13:40 -0400
Date: Fri, 28 Feb 2020 11:13:40 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200228151339.GS31668@ziepe.ca>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-2-jean-philippe@linaro.org>
 <20200224190056.GT31668@ziepe.ca> <20200225092439.GB375953@myrica>
 <20200225140814.GW31668@ziepe.ca> <20200228143935.GA2156@myrica>
 <20200228144844.GQ31668@ziepe.ca> <20200228150427.GF2156@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200228150427.GF2156@myrica>
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

On Fri, Feb 28, 2020 at 04:04:27PM +0100, Jean-Philippe Brucker wrote:
> On Fri, Feb 28, 2020 at 10:48:44AM -0400, Jason Gunthorpe wrote:
> > On Fri, Feb 28, 2020 at 03:39:35PM +0100, Jean-Philippe Brucker wrote:
> > > > > +	list_for_each_entry_rcu(bond, &io_mm->devices, mm_head) {
> > > > > +		/*
> > > > > +		 * To ensure that we observe the initialization of io_mm fields
> > > > > +		 * by io_mm_finalize() before the registration of this bond to
> > > > > +		 * the list by io_mm_attach(), introduce an address dependency
> > > > > +		 * between bond and io_mm. It pairs with the smp_store_release()
> > > > > +		 * from list_add_rcu().
> > > > > +		 */
> > > > > +		io_mm = rcu_dereference(bond->io_mm);
> > > > 
> > > > A rcu_dereference isn't need here, just a normal derference is fine.
> > > 
> > > bond->io_mm is annotated with __rcu (for iommu_sva_get_pasid_generic(),
> > > which does bond->io_mm under rcu_read_lock())
> > 
> > I'm surprised the bond->io_mm can change over the lifetime of the
> > bond memory..
> 
> The normal lifetime of the bond is between device driver calls to bind()
> and unbind(). If the mm exits early, though, we clear bond->io_mm. The
> bond is then stale but can only be freed when the device driver releases
> it with unbind().

I usually advocate for simple use of these APIs. The mm_notifier_get()
should happen in bind() and the matching put should happen in the
call_rcu callbcak that does the kfree. Then you can never get a stale
pointer. Don't worry about exit_mmap().

release() is an unusual callback and I see alot of places using it
wrong. The purpose of release is to invalidate_all, that is it.

Also, confusingly release may be called multiple times in some
situations, so it shouldn't disturb anything that might impact a 2nd
call.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
