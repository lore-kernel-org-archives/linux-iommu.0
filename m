Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AB53D332C
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740647; cv=none; b=FxEjn1x2ptxd3d0iycUg5qNDED9jzVIhjWrixY77JQC+LD+Bn0MVEp7odfN3IxgC6rhETPZ0dXjM96M1WR3rtXrsPXFl95gVokk8YFwmd9OiLchbGtsuHpkoP9dPqrT+Ya3FhpxU3Gqvh/s98ylQCVBzh2A5vXmxmegzz7Ov8qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740647; c=relaxed/simple;
	bh=b3ZQqWB4DIOdA8ELef1wmecmX41m8LiC52rMj6FfX6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=intFu/vcJONfmj3GYMMIY+ljXFDIsNpLegwDbBaWRXKWQv2leqfAANkqczF365gMOTMKcswgmeEXCH++IHvTTZox2ZO0KKz24Kqe9GAyTaM+bseRtpLkYJojTJEysF3vbFDPuQPWpRnNf22SYM81KEosDiCoaQfS0dHhsnkoN8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WPTkw2eu; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WPTkw2eu"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89cc797547fso10525696d6.2
        for <iommu@lists.linux.dev>; Thu, 09 Apr 2026 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775740643; x=1776345443; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C6vWnIbJNN7QWjov2VMlLT+LGdvblxosg4zhgXkV61E=;
        b=WPTkw2eukb+2FE3Uf91xDNgkQuHitLIf46U7/M/Q+6ZvT+tYEoxG0l243jO6IETWmY
         AzqDQ1WhDwjUSNJD9ORUKkLl7lkCHrI7dXNq0jhUDXlwkYDi5UgB5KfE+gaGaYK8p7em
         bULOoVjOPssvDO5ysCUC2oi7l7JF5MKTd8PGnNefFp6qAbUvwzNx6MBUDiG5roxQ6tmz
         puu+fRZgPjccLtaGrpC7TzAWk9tkmFsldudmbKXMuRX6cuJ4Fspwajn1BtwcxD1up5bQ
         WIu5RDl5bicYfF7MPiUrFmBLOfEe7BV6R4hmE+QGjG9iOn1jQQRKyJ5SNhZPufuKbOaG
         d8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775740643; x=1776345443;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6vWnIbJNN7QWjov2VMlLT+LGdvblxosg4zhgXkV61E=;
        b=chHiUncrXk8gDr0QilfaVrfaOh11wn1GBn9zYZvEer9eAtUcFAVaWDvx00TdHbvyIS
         HLHDy57xBJoll+oNEoiMbYa6eksXBlghwYrga0WNUnlzIbE8qy0YEWjF7GXcG2TWR2Om
         nvnKPNC3/g2jszvrdaVruEhf9HplPnnSbuWVqI7FZyVJuwl+00Jd2yfIyBYW1MfXccoy
         QnvBp7fBFlzBHSgJfQ6mtHkSs0bPaMPFl+RqhErECXTU8mW0wE3OrcocPD8D5z9HvTYR
         tMCeOR6513KBK+LhgVL2UpaWsQAfZI5ZS3Tf3ermA3b3FkMTxf6IxPqawupD3OeknC9S
         /Jsg==
X-Gm-Message-State: AOJu0YzlLBoQXd3P7eTX6pA0afEfle0A5O2KbGkvPv4+HwJVWx0Li75R
	ZlPhYzA9xGZiCmcnCVLn4VTw7xHHsWOgZWx4yP/7ru/91IwqZT+LwLAXgAR2awwMO9k=
X-Gm-Gg: AeBDiesC0w6f/wP6+Jd7LUy9BJV8vuQMFy+z0BwfMZDSB6+Hi4vtolqv00oolUjZPBD
	3L3wGIIPLVwvEDaNUUhT6mRSHv3H7JqBL/mOGGZBLB+BIqQrzXQRqEeuaQ+JBxfcQEIPcceFV42
	V16PKiZV2dh/CqhMnB86esOFUawwwMbJZrqcv3z3IJ+YpSYL1ZenCthbM0JQjz+wbL1THJpdxNL
	jhSkUzSXsRCzOUQD9iL9yQ935jiS8QxQ5++8FHSW8eM1Y/jEoDPcZ7Jg2XZYmARuzmlbiFHLF8V
	ajbBkaoAQ8wTm8MVGOrQqsjHz6aBjZqcSlBTwyKMZN6xZ7CqEMmk3RgjOuLvhS164nXkiFwo4Lj
	E+zXOAIfdFIgRDTXVDwiOzHFogPCP3V690KD8KltonoqzvEqjUhr5lLZ2g/jHZRCujRrreU0gmE
	617tO0adO+Jz/GeSG8yKVNXoGDnyCuJcXcTxwtSmZDTlt7bIZNIIT6LClsA9FallwfWUqLBg==
X-Received: by 2002:a05:6214:262f:b0:8a2:18b4:79ca with SMTP id 6a1803df08f44-8a703c26750mr415275106d6.34.1775740643189;
        Thu, 09 Apr 2026 06:17:23 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5977e00b4sm197193996d6.47.2026.04.09.06.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:17:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wApG5-00000007axo-2fVL;
	Thu, 09 Apr 2026 10:17:21 -0300
Date: Thu, 9 Apr 2026 10:17:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Weinan Liu <wnliu@google.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, josef@toxicpanda.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kpsingh@kernel.org
Subject: Re: [PATCH] amd/iommu: do not split domain flushes when flushing the
 entire range
Message-ID: <20260409131721.GQ2551565@ziepe.ca>
References: <20260326220512.GA245789@ziepe.ca>
 <20260409081227.2149181-1-wnliu@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409081227.2149181-1-wnliu@google.com>

On Thu, Apr 09, 2026 at 08:12:25AM +0000, Weinan Liu wrote:
> > On Thu, Mar 26, 2026 19:05:12 -0300 Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > On Sat, Mar 14, 2026 at 02:24:11PM -0400, Josef Bacik wrote:
> > > On Thu, Mar 12, 2026 at 9:40 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Wed, Mar 04, 2026 at 04:30:03PM -0500, Josef Bacik wrote:
> > > > > We are hitting the following soft lockup in production on v6.6 and
> > > > > v6.12, but the bug exists in all versions
> > > > >
> > > > > watchdog: BUG: soft lockup - CPU#24 stuck for 31s! [tokio-runtime-w:1274919]
> > > > > CPU: 24 PID: 1274919 Comm: tokio-runtime-w Not tainted 6.6.105+ #1
> > > > > Hardware name: Google Google Compute Engine/Google Comput Engine, BIOS Google 10/25/2025
> > > > > RIP: 0010:__raw_spin_unlock_irqrestore+0x21/0x30
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  amd_iommu_attach_device+0x69/0x450
> > > > >  __iommu_device_set_domain+0x7b/0x190
> > > > >  __iommu_group_set_core_domain+0x61/0xd0
> > > > >  iommu_detatch_group+0x27/0x40
> > > > >  vfio_iommu_type1_detach_group+0x157/0x780 [vfio_iommu_type1]
> > > > >  vfio_group_detach_container+0x59/0x160 [vfio]
> > > > >  vfio_group_fops_release+0x4d/0x90 [vfio]
> > > > >  __fput+0x95/0x2a0
> > > > >  task_work_run+0x93/0xc0
> > > > >  do_exit+0x321/0x950
> > > > >  do_group_exit+0x7f/0xa0
> > > > >  get_signal_0x77d/0x780
> > > > >  </TASK>
> > > > >
> > > > > This occurs because we're a VM and we're splitting up the size
> > > > > CMD_INV_IOMMU_ALL_PAGES_ADDRESS we get from
> > > > > amd_iommu_domain_flush_tlb_pde() into a bunch of smaller flushes.
> > > >
> > > > This function doesn't exist in the upstream kernel anymore, and the
> > > > new code doesn't generate CMD_INV_IOMMU_ALL_PAGES_ADDRESS flushes at
> > > > all, AFAIK.
> > > 
> > > This was based on linus/master as of March 4th, and we get here via
> > > amd_iommu_flush_tlb_all, which definitely still exists, so what
> > > specifically are you talking about? Thanks,
> > 
> > $ git grep amd_iommu_domain_flush_tlb_pde | wc -l
> > 0
> > 
> > The entire page table logic was rewritten. The stuff that caused these
> > issues is gone and the new stuff doesn't appear to have this bug of
> > passing size == CMD_INV_IOMMU_ALL_PAGES_ADDRESS.
> > 
> > If it does please explain it in terms of the new stuff without
> > referencing deleted functions.
> > 
> > I don't know how you get something like this into -stable.
> 
> I believe the function Josef is referring to on linux/master is amd_iommu_domain_flush_all().
> https://elixir.bootlin.com/linux/v7.0-rc7/source/drivers/iommu/amd/iommu.c#L1820

That does seem to be an issue, but it is not going to be triggred by a
VFIO trace like Josef is showing. I've already fixed this properly in
my series:

https://lore.kernel.org/all/3-v2-90ddd19c0894+13561-iommupt_inv_amd_jgg@nvidia.com/

+	if (likely(!amd_iommu_np_cache) ||
+	    unlikely(address == 0 && last == U64_MAX)) {
+		__domain_flush_pages(domain, address, last);

By fully getting rid of the wrong use of
CMD_INV_IOMMU_ALL_PAGES_ADDRESS as a size in the callers.

So there is a small window when this patch could land with a commit
message to address amd_iommu_domain_flush_all() and be backported
before it all gets reworked and backporting will become hard. Respin
it quickly?

Jason
