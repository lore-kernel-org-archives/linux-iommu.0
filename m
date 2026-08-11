Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F80442B72B;
	Tue, 11 Aug 2026 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441692; cv=none; b=CZDDYqBfUh71n+8YMQJVLa39QDnOQoqBUNxgVwXxPOM2LXkkz5QL3jdOP6/67LcQIjdHNQIyrpZcRRltIgR97ajRrD17foK7jFusnsZXopeG9oBSdJJrOWx9Qh3GHlUBIpfisW3IcVrbrQ+hTWDFN8vPusparTpM8qyj39nuXUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441692; c=relaxed/simple;
	bh=pzTB6fx6II0dM+4U2KkvT0UmPSQxFwksXrmPn5RscKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmNGH39kSsGUXgZqjyzcwWPrMnUIqFdvFwYsBw7oVvBBrCvrglLkJAkzeIjqJNxBZ5uRLgSfgaDzI0zCiZdioyqYALT/pNzXTDxpNm0JlAxyFs2uAEwT8E1kTIjoacZIIjwYyVkNkaH1R7V4v8J70P3Uj4wL75vuTkvcHSrpeew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkihLUr3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkihLUr3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2569E1F000E9;
	Tue, 11 Aug 2026 09:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786441689;
	bh=r5HhHJTSxF8KEOU8nDBiXAdeJpO4bhZrn1tx/eSEIJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OkihLUr3hCXVZYuBq3UdDGZOGuvtQH4LoONxO01+QW12CCPziEhG/CmCx0iOdk/2e
	 cmZZiHgB2xhg055c8BWfTiq5RlyCHQErKgw6cmuinV0gM9deM5qBvomMQAsHmCyqTt
	 kZSdwjhzRQIy93kOUjOPsJsGN56+IjogNQme4S87G0ZQDFFtzU+y+U1WuM5pVIRurN
	 hjD+Sr9BCLIkqRWgOhCkM6J/rCleTbHBlut9TsdsvX6MrW4Hjua7nlvECJiHS1j7eB
	 TsV6Nbjd/iVjQpZyc3fjOh1Bmd38/sA8y6biCyx/4WD968GqSafhovoCXKHc+bc+rK
	 p4b6euG/VnvkQ==
Date: Tue, 11 Aug 2026 10:48:05 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>,
	syzbot <syzbot+90c2d711b5218d10ce61@syzkaller.appspotmail.com>,
	baolu.lu@linux.intel.com, dwmw2@infradead.org,
	iommu@lists.linux.dev, joro@8bytes.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in free_iova
Message-ID: <anrv1SUHgtx_ELb8@willie-the-truck>
References: <6a7910da.9c11d2ce.289b96.00da.GAE@google.com>
 <68eebaf3-2427-48c0-93d3-87455ff266fb@arm.com>
 <20260810173230.GQ200537@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810173230.GQ200537@ziepe.ca>

On Mon, Aug 10, 2026 at 02:32:30PM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 10, 2026 at 11:50:28AM +0100, Robin Murphy wrote:
> > > Freed by task 5327:
> > >   kasan_save_stack mm/kasan/common.c:57 [inline]
> > >   kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
> > >   kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
> > >   poison_slab_object mm/kasan/common.c:253 [inline]
> > >   __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
> > >   kasan_slab_free include/linux/kasan.h:235 [inline]
> > >   slab_free_hook mm/slub.c:2677 [inline]
> > >   slab_free mm/slub.c:6377 [inline]
> > >   kmem_cache_free+0x182/0x650 mm/slub.c:6504
> > >   free_iova_mem drivers/iommu/iova.c:237 [inline]
> > >   put_iova_domain+0xcc/0x100 drivers/iommu/iova.c:454
> > 
> > ...except that right in between here we've called iommu_dma_free_fq() which
> > would have already invoked timer_delete_sync() and freed the queue itself.
> > Wut?
> 
> I've been feeding syzkaller riddles to the best AI I can get and it is
> surprisingly good.. So, for this it guesses:

Huh, that's a pretty good idea. Do you just dunk the report in verbatim,
or do you have a cleverly crafted prompt that you're having more success
with?

Will
