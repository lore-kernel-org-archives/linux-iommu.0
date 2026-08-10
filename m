Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12854298CAF
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383154; cv=none; b=NkdTRCmRRul1ftMOJJbs8F7BGlon5L8swG28ocrRyq5dn1dvGdpx6h5AL3JxmysHl8+P/k62Xp8OjYIYfB3bJjogTFdIec4YAok+YcesUPO29E/s0V8sWtQlKZK9XFVaHt+/nF9A+fVsTTtJnoDBwiyrumN+TrcuS5C8POvlHzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383154; c=relaxed/simple;
	bh=zjJIWqNtwF0cifNRQPhnYI2EfeYf2B2tY/WqOA+v0m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh6PZ73yFYb/npIOTJsN86fnRqVZf8dCNhQeCBcIP5YVUNJG5kH7tZFEjB9k0vtXAeWE2pPUyrqfKpvow5C3XfrFBC6l0NosscbKPIKyfypxu4R5dq+LrG2BAWS4yav4j1JsxftYHZ1ZM9XpOJPnWr48vogKGGzVyOCmQs6lqr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cLiXYgBK; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cLiXYgBK"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8efec2c28f8so13148406d6.2
        for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 10:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786383152; x=1786987952; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VBWupQnXAvbyYBXOH1+tP3/NFYquot2qJ912f9iatvM=;
        b=cLiXYgBK9TSiwdbbfdD/d1GkqsUbZKH6l0aSVwuFxhtBvAamP2EB2mrCgx9UfpGN1k
         3O4MhFM8zj1E8p8nCmrCTFuDFME8DbR1XlMHjeFIpk2F8H6aYsryhum5jOhriiZ35Z1p
         Q9AKvCpmIbINHTnyHJHzx79nPZ4GjMXJ+BP9VaHspmNs9+OiVFuN9CUlL3VCzf3Je172
         zT8v3d+rM69levSqK17pzlAU/kE+HVadByNQo4G6pIT1fhE8827RWsukhzkhg8W0w3I4
         rrBi4qJCFgx7yHHuLqY++DWCl6/KSBwdt6wAwHwpWCTPxxAzZ+Zco33Hvx5wcvDHF166
         UbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786383152; x=1786987952;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VBWupQnXAvbyYBXOH1+tP3/NFYquot2qJ912f9iatvM=;
        b=Jmic3MdA/HlHchxGRbSPF9p1V5Gqo1FjkgGfAn7uG3X2tQxm46GikBaPT+loLmsh8e
         0iT6K8Cw365OclQTAfYzwQyLZqQE0hynq3A2qnbvxUWvMFqQRim7ftELEO6NG0Q9AZOM
         D6bhVPojIWTpojOe5UbX/J8BJZ5iAhYv5Fh2eXMaPFT2IC0iQQ58c47/d+j9oqy8yPRU
         wN7TAdV3AVu9NaSzUGpIiaAfIgnvZemsnDpOP5T6WeC2eKfeTn8AoTMirVgkJ6pEzi9g
         qrFgm/j68jusqZuGL7efXnbyExh4yfhsGpE38MGhkcMDCo1uEOjpp90EeNcu+rPinMvd
         15kg==
X-Forwarded-Encrypted: i=1; AHgh+RqLWy7FyhihV/yU+kIJOy3D+NK3Vo29hXEl5hcatprwwf3gAqhv1WtMmGD6l+LHrfoAQreEbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUjwtQqRW+NhGRXVxbHu14H4qHn7ZXG54GvXVbKsYAsBLP1X11
	bza8XQp+2W8iH943VJnvHXAF033Xa0TIxWqA7IDEBzWHpXYITPKkvrnkN7HDjbiMvCg=
X-Gm-Gg: AR+sD12L/zlKNtXUmLdIkFfyGwPaO6hMbwKy3WHuQwVIDxbAhN16/JDLNOoKRkENJMh
	Psd0tv+HULtKCfY0CByUHCCR9CJzjshq4tLGEZNAPhe4w2kba+EDECY+stInQdEgbCC4yYyD+Ts
	1vcdyjAfoW8VZGWze8A9llNl8pTlryO9EtCf5z/6M3zMkx4+fe9KcYyWEZBdeyybOZPwovtVuaP
	8Ltz30N5CqPIZsRJ6VSbe9/q1geBYXHzP7Y7XYgf1Qxddugb95AWwh2VBZ6dpy0h99eXCIjCrOv
	oIJeFMxamhmtqGua6lmwOjtkERCNnWShyaYpQgYrvrYCRHlc8vaXsBYBVOdsiM+5gLxhRQAcYGv
	/qRfB888vjjH3wG5ql2Nz/UTkepYLdWbFILfuqXapCuoFzfHqZSLSpody9/56efCFJgvIqVI78J
	HJ2U+OQ0Wl4mP96mkvME6RXYj55C3aLD8dssGD268sQRtzIr3L5Im2ng8MSGRC
X-Received: by 2002:a05:6214:540e:b0:907:37d3:1ed1 with SMTP id 6a1803df08f44-908a7100249mr312771366d6.28.1786383151603;
        Mon, 10 Aug 2026 10:32:31 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a91d6ad8sm77283546d6.18.2026.08.10.10.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 10:32:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtTrS-0000000282q-1SzL;
	Mon, 10 Aug 2026 14:32:30 -0300
Date: Mon, 10 Aug 2026 14:32:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: syzbot <syzbot+90c2d711b5218d10ce61@syzkaller.appspotmail.com>,
	baolu.lu@linux.intel.com, dwmw2@infradead.org,
	iommu@lists.linux.dev, joro@8bytes.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	will@kernel.org
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in free_iova
Message-ID: <20260810173230.GQ200537@ziepe.ca>
References: <6a7910da.9c11d2ce.289b96.00da.GAE@google.com>
 <68eebaf3-2427-48c0-93d3-87455ff266fb@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68eebaf3-2427-48c0-93d3-87455ff266fb@arm.com>

On Mon, Aug 10, 2026 at 11:50:28AM +0100, Robin Murphy wrote:
> > Freed by task 5327:
> >   kasan_save_stack mm/kasan/common.c:57 [inline]
> >   kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
> >   kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
> >   poison_slab_object mm/kasan/common.c:253 [inline]
> >   __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
> >   kasan_slab_free include/linux/kasan.h:235 [inline]
> >   slab_free_hook mm/slub.c:2677 [inline]
> >   slab_free mm/slub.c:6377 [inline]
> >   kmem_cache_free+0x182/0x650 mm/slub.c:6504
> >   free_iova_mem drivers/iommu/iova.c:237 [inline]
> >   put_iova_domain+0xcc/0x100 drivers/iommu/iova.c:454
> 
> ...except that right in between here we've called iommu_dma_free_fq() which
> would have already invoked timer_delete_sync() and freed the queue itself.
> Wut?

I've been feeding syzkaller riddles to the best AI I can get and it is
surprisingly good.. So, for this it guesses:

---
timer_delete_sync() does stop already scheduled work, but it does not
prevent a future mod_timer() from re-scheduling the now-deleted timer.

The probable sequence is:

1. A DMA unmap queues an IOVA and sets fq_timer_on = 1 at dma-iommu.c
   (line 243), but has not yet executed mod_timer().

2. Concurrent PCI removal frees the device's default IOMMU
   domain.

3. iommu_dma_free_fq() calls timer_delete_sync() at dma-iommu.c (line
   274). Because the timer is not pending at that instant, it returns.

4. Teardown frees the flush queue and all IOVA-tree nodes through
   put_iova_domain() (line 446).

5. The unmap path resumes and executes mod_timer(), rearming a timer
   embedded in the soon-to-be-freed DMA cookie.

6. fq_flush_timeout() later runs and calls free_iova_fast(). It
   traverses the already-destroyed IOVA rbtree, producing the reported
   UAF in private_find_iova() (line 275).
---

Which seems plausible to me.. So it is a bug in a driver allowing a
dma API operation to be outstanding after it has been removed?

syzkaller console showed it did trigger a remove of a PCI function:

open("./sys/bus/pci/devices/0000:00:01.0/remove", O_WRONLY)
write(fd, "1", 1)

But I couldn't guess what device that was, if someone from syzkaller
land can clarify what they have plugged in there it might help.

The AI guessed on a GCE VM it was a display adaptor, but I don't see
how it could know that.

It would be a nice improvement to the CONFIG DMA DEBUGGING to keep
track of the driver bound state and blow up directly on all these
forbidden combinations.

Jason
