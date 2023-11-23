Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C587C8E3
	for <iommu@lists.linux.dev>; Thu, 23 Nov 2023 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eH6Uk8Fg"
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id C740E6607390;
	Thu, 23 Nov 2023 08:51:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700729505;
	bh=75Gwo3kIBEkDKruOZT+UBq5pXMBZY7eBy6cWsyZVOVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eH6Uk8FgBKNIQIdYbqRHzV9FqqPJvp8VFpwg/shZf5rmDbo3oRI9fbgsy0vFvQ3ua
	 RMGUBEtPRCKFA/o/TblvyocRYc8eVUKXaBmU2DjvktA/iQnxq4R2XEgnKvXsscB9d+
	 FYrb5W/pD7RKLIsJ0Bmph0LKF8hJBmnt8NbzoSQ3FbvJuT2SgPDLkhagClq3cUj5Fk
	 ZptDnjsNK0GplhMrIGtKcJWzL8QqMink0nuOvTiOEE+itcYiUFN81dFjxAWM1jVuUu
	 +FO1h70UMkAjBUKtDpP/61vVvZWBjN94/C7OByp2fQzXGvS87rvfZTFAznovMoyZzG
	 7D6tksLC45ctw==
Date: Thu, 23 Nov 2023 09:51:41 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Rob Clark <robdclark@gmail.com>,
 Gaurav Kohli <quic_gkohli@quicinc.com>, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/2] iommu: Allow passing custom allocators to
 pgtable drivers
Message-ID: <20231123095141.19dc26d6@collabora.com>
In-Reply-To: <20231122175055.GI10140@ziepe.ca>
References: <20231110201652.629b7228@collabora.com>
	<20231110194215.GR4488@nvidia.com>
	<20231113101103.1cc05c8c@collabora.com>
	<ZVOgBBEetWf1PFxX@nvidia.com>
	<20231120140425.GA10140@ziepe.ca>
	<20231120153838.2166e7b8@collabora.com>
	<20231120144604.GD10140@ziepe.ca>
	<20231120161418.5eca178e@collabora.com>
	<20231120154536.GE10140@ziepe.ca>
	<6e74bd37-9e10-416e-9fbd-0cebb7948e2b@arm.com>
	<20231122175055.GI10140@ziepe.ca>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Wed, 22 Nov 2023 13:50:55 -0400
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Nov 22, 2023 at 05:23:34PM +0000, Robin Murphy wrote:
> > > Gaurav doesn't need a custom allocator, he needs a way to manage
> > > sharing page table memory with the hypervisor. A different set of ops
> > > that don't replace the entire allocator would be fine for them.
> > > 
> > > The issue with taking away the alloc_page is that it complicates the
> > > ability for the common code to use the struct page fields and more. We
> > > already know we are going to need those to do some of the things that
> > > are being asked for, eg RCU freeing and refcounting.  
> > 
> > Oh come on, for all the things you claim are simple, you don't think it's
> > trivial to make the fancy stuff conditional? (Hint: we already have control
> > flow all over which is conditional on the cfg and/or calling context, and
> > that future stuff may well end up wanting to be conditional in its own right
> > anyway since not all io-pgtable-arm users will need or want it).  
> 
> I really don't want to make it conditional! I'd want to have one
> common set of radix algorithms shared by the enterprise IOMMUs, so we
> can actually improve those drivers and get all the special features
> people want without writing everything 5 times.

Just because it's optional doesn't mean you can't have a common
implementation shared across drivers. Feels like you're stuck on an
all-or-nothing mindset instead of trying to progressively push stuff to
more drivers, until you end up with everyone using your caching system,
at which point you can decide to make it part of the mandatory/core
features.

> 
> > > Here I am not talking about perfection, I am concerned about messing
> > > up work that I now see as important for other iommu drivers related
> > > things by making a hack for a DRM driver (which as I've said has,
> > > unravelling these hacks has been traumatic for many of us
> > > historically)  
> > 
> > In your own words, this is a community effort. You do not own this code, and
> > you do not get to prevent the community from solving multiple problems they
> > have now, in a way which is reasonable now, just because *you* don't like
> > it, and *you* believe it might possibly make it harder to do something at
> > some indeterminate point in future. Your objection is noted, but as above, I
> > for one do not see a convincing basis for it anyway.  
> 
> I've said already it is my opinion, if you want to bring another one
> then you can particpate too. Thank you for noting my objection.
> 
> > You know what *the community* sees as important? Not having to maintain
> > multiple copies of near-identical pagetable code, because maintenance is an
> > established and very real concern.   
> 
> What I heard at LPC is we badly need to stop maintaining independent
> radix algorithms across at least the enterprise iommu drivers. This
> was clearly an articulated need for many different people *from the
> community*.

Can these people please raise their voice here? Or maybe LPC's IOMMU
discussions were summarized somewhere in an email sent to the IOMMU ML,
where we could discuss that, instead of this thread.

> 
> > This is why we have the io-pgtable
> > library in the first place, and why we adapted io-pgtable-arm to support
> > panfrost when that came along. If supporting panfrost and panthor as
> > io-pgtable users really does ever become a practical problem at some point
> > in the future, we will work to address that problem at that point.  
> 
> You mean Joao or myself will get stuck with it. Not "we". :(

Oh come on, I'm tired of hearing that argument. I proposed my help, and
am still happy to help in any way I can, including reviewing DRM
changes, or helping patching DRM drivers, if that's the main blocker.
If there's a set of specific DRM drivers you had problem with, please
name them, so we can discuss it with the rest of the DRM community in
order to try and find a solution.

> 
> > meantime, we can get on with the common goal of making Linux do the things
> > people want it to do, in the best way that the maintainers are happy to
> > maintain. This is not "a hack for a DRM driver", it's a simple and
> > convenient generalisation of part of io-pgtable, in keeping with the design
> > of io-pgtable (user-provided callbacks are nothing new), and
> > straightforwardly serving at least two completely different use-cases
> > already.  
> 
> I've already explained to Boris, and he agreed, that it is the *wrong*
> generalization because it is implementing a generally useful algorithm
> in the DRM driver and keeping it out of the core code.

Sorry, but I never said that. I said your approach was interesting (and
I keep thinking it is), tried to see how it'd fit in the panthor
picture, and said I wouldn't mind porting panthor to it when it's
ready. I still strongly disagree on the form though. Blocking
driver-merging/framework-evolutions for months just because you decided
how you want it done, and that nothing else can happen in the meantime
because it might get in the way, sounds like a single man decision, not
something widely agreed across the iommu community.

Beside, I think your objection that custom allocators are in the way of
this caching generalization is a bit of an over statement, especially if
custom allocators provide the same guarantees you get from existing
allocations (page-backed, no fields used in the page, etc). Worst case
scenario, you disable the generic cache for all users that pass a custom
allocator, and add a pr_warn() (or WARN_ON() if you want to be pushy)
to make sure driver owners take that into consideration quickly.

Last but not least, IIUC your approach implies explicit VA range
allocation/deallocation to work (through new API calls), which means
you'll need to patch all io-pgtable users get acks from their
maintainers. That includes IOMMU drivers living in drivers/iommu, which,
if I read behind the lines, should be easy peasy, but also external
io-pgtable users like DRM drivers, which, according to you, are
unresponsive and reluctant to change how they use the APIs. So, if I
follow your way of thinking, you'll just be stuck in the same place,
waiting for DRM drivers to accept the transversal changes you intend to
push.

> 
> If we deliberately do the wrong thing then, yes, it is a hack.

We don't deliberately do the 'wrong' thing. We do something that's
working but you consider to be wrong/inappropriate, and we commit to
revisit our implementation when the new/fancy thing is out. I don't see
how more constructive I can be here.

What I strongly oppose to though, is having someone say 'I have the
perfect solution for you', and then tell me, 'but you have to wait
another six months, maybe more, to see what it looks like'. I already
see your counter argument coming, that I can pick it up, and try to
implement it myself. Problem is, in this sort of situation, the guy
proposing his help (me) rarely has the same vision of what the
implementation should look like, and ends up spending a considerable
amount of time working on something that's, at best, barely matching
the original idea.

Regards,

Boris
