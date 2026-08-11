Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDAB446834
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456206; cv=none; b=Yr9yu9DEnnHs53yhCUG0nRgnwXMxJse0kyiIKE11XL0ca+k0TRbM0aT+pbSyRDveMfJmcKIB0WXoXiWo3fkA435lYOKqzYv8hP0A06mU1zKs/nx+nAsW6RAS9txHIkR1vi76cpoHVQ6YxIKsEuzB1ZOFQp4BVQxY0iWMwDoYJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456206; c=relaxed/simple;
	bh=01U+LqYVImVC/Ue0VBeheMYmOyd8HOqsFdMr4nxw1JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6QT7diQiWi9ElAoxs+szKH4ENdtfO6qCG7/Y2ETQwwo9RFe0TfU9pSd33w8hsDqudS2aTkHj4X0/6J2K6pzzAFLMplstdCsz5M+fxUWWEnDH6d2DbvpXrbUXb+9vjSxeChvQ6GslusjCudypuQ4/iNZ0lNeqn7ZNfWCxDy7rlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XcpPcXgR; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XcpPcXgR"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c8e2e39easo31276771cf.0
        for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 06:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786456195; x=1787060995; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4KIzCZA+VrHZ+YDvuG8FfScXQL2hTLG1y7Jskg7GmM=;
        b=XcpPcXgRZNpSX75bH9sUnnXsu0xTgQjS5ZHmlylw6TcoIsrpp1lnP3vEoVNjPg6HxX
         vYbA2L5VC9ABE2yzWZEJrKKr240b/5mbyPRp2cApZ+bThwA7yAPYWLXzMeXT30nfpKdN
         E/GULP2D3kdg6usA/GiaU6rTi6IAq5TcTYkxAEfMQoUQvoH/OR1/e4jhPtnQ7FPVEOG2
         ODzyifAVGa2OiqeSWrf29eH3gYBu1z/xhWRyCUJyM5yrsSqQb034y3DPStE8PuR4cq2x
         5nbTvXLJ/iycOhBO/XUUQyHAjq93nG8Y769CCQi9AXWackyw7FmHicUvCU9yXn8Iqnz5
         ROGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786456195; x=1787060995;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4KIzCZA+VrHZ+YDvuG8FfScXQL2hTLG1y7Jskg7GmM=;
        b=kRWzmPF9MYkKyrRtwk8Y0NraGeZoyLnvrlkjLq0dvCMBvrE1ih5KPHKxMEgAPYGGLV
         a2MTmN1OIPOqXLcWHGGK3qbx/bw2gBWxG7fpKC3ltdXYjZTreDIbsBoC3Pjdc3Ovc721
         wB6PvJhwezSwtc2/G2ioKf3KsY6kKsNHWz+3kTONBsepURPHBn99M+B4nhofLYDC2XxC
         KvtLtr7AxpbJ7+Dz+S7+IPVHCqzVAvwEwVOjFAfd2iYVgW7/5pXK9W5Y8jFd4uC77jF0
         +6fuyiaa2RulDqOerN19H3OqSkr3sR5DWVQrpXNkXo5kVTehXypetuf40y7HQ8xX692p
         UKAg==
X-Forwarded-Encrypted: i=1; AHgh+RqAw8S8D7jLa4w+XtonWTcCs+FMj3GxyinyZad4jUEYJ018W80LUGEqIucm/97/9FSsTbCZCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpNp+/G6aRVheEffOJIlUmlIS/nQNGgkITCWVpVMZe4vcPvSfi
	ctmMlui6p32j+XfYag/VmFVfKQz2oX8ksV/4EPNahkkTX3MY/9vyVdS2ZHaKZmAOyiM=
X-Gm-Gg: AR+sD10b5zIGzcheparc2Mzl0qV9/RDa0OS2xLN2OXA4vjyRCbZKrs+3ZZhR9hT6Ow5
	RUpo2aniXmncg1dV68gAdN+vV+gLwUafk61x+MgBARSunJbsWsGHWxRGl3YSY1Qv+hrxjOFQcmN
	3JWUpfZIMtaT+rqcyE7G9vDlZDLcR9yrlWJiuhjM7vCJfKX+zgWhFSD1AS2SJq3c+rjLTSGcxQl
	FxNqsYEAVgPVqWvfpKuIEpbU8viIIjdK0LPuuOkjnXNbmrFwH4EUeqfPIlNoQJreRb8t3ax8JdF
	DF0l4EiwA3Gbj/vxw7Kt+7gqdPTJTPdMLP+Me9KQwKMK+bjq3wrdfpUGNPjBg0LLuOQsbgCSWg5
	94yOE7S2tt5ynLcXuJbxPqmYk9V/EOtUa5m02rS9oTyYxsVpnVp1Tw4dW9rbGJONXL2zmKp3tBD
	8rr1mjkiCZBbKoLu6egKl8FMIqSIacoq6VQMHb7g==
X-Received: by 2002:a05:622a:c81:b0:51c:d52:6049 with SMTP id d75a77b69052e-52d5860ffffmr33969911cf.28.1786456195117;
        Tue, 11 Aug 2026 06:49:55 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d5763df66sm11828221cf.0.2026.08.11.06.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:49:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtmrZ-00000002UZj-3U7x;
	Tue, 11 Aug 2026 10:49:53 -0300
Date: Tue, 11 Aug 2026 10:49:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	syzbot <syzbot+90c2d711b5218d10ce61@syzkaller.appspotmail.com>,
	baolu.lu@linux.intel.com, dwmw2@infradead.org,
	iommu@lists.linux.dev, joro@8bytes.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in free_iova
Message-ID: <20260811134953.GB544626@ziepe.ca>
References: <6a7910da.9c11d2ce.289b96.00da.GAE@google.com>
 <68eebaf3-2427-48c0-93d3-87455ff266fb@arm.com>
 <20260810173230.GQ200537@ziepe.ca>
 <anrv1SUHgtx_ELb8@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anrv1SUHgtx_ELb8@willie-the-truck>

On Tue, Aug 11, 2026 at 10:48:05AM +0100, Will Deacon wrote:
> On Mon, Aug 10, 2026 at 02:32:30PM -0300, Jason Gunthorpe wrote:
> > On Mon, Aug 10, 2026 at 11:50:28AM +0100, Robin Murphy wrote:
> > > > Freed by task 5327:
> > > >   kasan_save_stack mm/kasan/common.c:57 [inline]
> > > >   kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
> > > >   kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
> > > >   poison_slab_object mm/kasan/common.c:253 [inline]
> > > >   __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
> > > >   kasan_slab_free include/linux/kasan.h:235 [inline]
> > > >   slab_free_hook mm/slub.c:2677 [inline]
> > > >   slab_free mm/slub.c:6377 [inline]
> > > >   kmem_cache_free+0x182/0x650 mm/slub.c:6504
> > > >   free_iova_mem drivers/iommu/iova.c:237 [inline]
> > > >   put_iova_domain+0xcc/0x100 drivers/iommu/iova.c:454
> > > 
> > > ...except that right in between here we've called iommu_dma_free_fq() which
> > > would have already invoked timer_delete_sync() and freed the queue itself.
> > > Wut?
> > 
> > I've been feeding syzkaller riddles to the best AI I can get and it is
> > surprisingly good.. So, for this it guesses:
> 
> Huh, that's a pretty good idea. Do you just dunk the report in verbatim,
> or do you have a cleverly crafted prompt that you're having more success
> with?

I usually take the email into a file, download any reproducer and just
feed it to it. 'Here is a bug description in xyz.txt what could be
wrong' and play the lottery. On this one it could understand the http
links and it fetched down the console logs and other information from
the dashboard on its own (This was GPT Sol 5.6)

Even if it isn't right out of the gate it is usually still interesting
and points at new things to think about

Like this theory about concurrent unmap is a good guess, but there is
a big gap between that guess and finding the source of the unmap.

Jason
