Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2281E3E9F6E
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916968; cv=none; b=P85ymD4J677DeWdt57oKWWwT5P78qxJdIXU0t/04fUCstos6YRsT6D+ITcGa04s5zAcKULskvdCfL/y376ZxfB9csMdWHP4+kfeR9JnbfbP+o6h7FTr6q+YX2MJp6A4UR/JPKkVbUy3yArxhjblVHOlPxtzA/J4jMOHHReIjzcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916968; c=relaxed/simple;
	bh=KhIvR3889p1HTQfCBF3w3nKndwU9ce0t4peR252dtZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haJeVzcpaHNP2wGP2wQrU9mToWUz404P/xhTRY/zZ9VJL6O8miLlyvNfD/077Q7tgkXJjm+xZcaR9y3uaHDqSt5nN2J3BzR+kQtAGHXs/g8w8LyrQ3q9wEI4nSF3rURqdMlRmUcDY/PgknZJ53+l5xHMCPAQ22lOGyUnotLJ7hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KUkiK4LT; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KUkiK4LT"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b876798b97eso850449566b.1
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 05:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768916965; x=1769521765; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rrgUsOtMJYh6LFiukcDW6xx8+sO+QWx05n2GaEl7uC0=;
        b=KUkiK4LTgRFWJ1uUs2NujJ8nrIWKrypdzjVzLE0jjQv4CsdRhgSCqK66u2TLOFWaeW
         KI/1eFkGOHHxdg6PQsAwmjsmnKLpBXEbPD9DtiPeLnSwa7KL3B9cwG7lY1g4ReRGvUqX
         qT9TYFVUqQ1LQpdiC5HkCAf8J4GiKLakPWv5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768916965; x=1769521765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrgUsOtMJYh6LFiukcDW6xx8+sO+QWx05n2GaEl7uC0=;
        b=pPTl0Cr7H2ot/OqMtXAjhf1kTCvB+om4CQwtyh3p4bvJZKD8b6cF7jadqZA6xrQ+lB
         hYinDJXCmEvwh5JSBq5dD5catNtZ11E0NWCtvgoJRaxTg7KOpxYJwpJ0OlynV/XA09Gj
         zOfrx4ESv7MtJLNkbDkKYGEHKBajp19IXLt2QUYQP7y7kQzOvNFVIZEdI5AziZyZ9INP
         IqNqBtrZBw+J6qC79XUkll9x+p0LtRT+ApeHhPrdpmV8RiXQUEceA/QgdGUAKF9brvwI
         ibl0moCQmo3vV1Yg2t0uOn2ECxyW3Hgvt7KOYHoqV6xfmITnXKvXKazrF6xu9knfYg5o
         gjhA==
X-Forwarded-Encrypted: i=1; AJvYcCWdpaqZL+aZdSXFxIQleUCwswBPTEMaaUlk6Li9WU/7/TI9VjpsYQs6T5rRaKRZeJbxbFNmEA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzzm37vJV8cbKGhkd6Pt2ga2dlyip7zQOzoGVBdH07rThTD8vh9
	SFG3zFj5ni7z5RUv18DoKxnSIHRKlNtY7G3LKLjP7v408Py9sWTRD2LLmaWN9kObKBXJJ3QqaV6
	fwV8=
X-Gm-Gg: AZuq6aKUXep+OFkldC2P2j6Uc8PI7t+ZEwQDl6aruRdd2A3Ctp8i73uTTTaPMTFeVln
	Mupx4GPxoUuKA16X9smbvVrqET3KHgtS3uaTGbABtusRabmBdQH3cUo7r42+MuufJVudPw5FVk5
	WURnw/ur07O0RTjvjIoJQoIRMMxbBNBRQMO5hTQeC2Qq9WCwPlL1KqGRekTt6G18hAOSrGmJPVy
	kIEF0by5kQZCh3bXNKG22xVAk+zu+v/hyelHRFC219XwBL361UQWleIUfFS9KCLLQtHClMQMhaU
	Ha5oBtVIDn0N0Hyir3OLWp9Y/Up7IJw5gb6l9VkUxgJt1PF9+IjOUFhQ5Dm4H6pWosZyzREqK3T
	U8LpICs8a6JiOxhsA6uuwf5RgvbcxotTrBJ4CUZWGQ8XCQCttG0NAEf29t7pGC35OgBK1O1TQrw
	3maJe9wdAG9neBjdg=
X-Received: by 2002:a17:906:6a0a:b0:b87:778b:89b9 with SMTP id a640c23a62f3a-b8800656cefmr171951066b.35.1768916965470;
        Tue, 20 Jan 2026 05:49:25 -0800 (PST)
Received: from google.com ([2a02:a31b:20c3:6680:e571:3179:cb1d:9314])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879516900csm1501917266b.23.2026.01.20.05.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:49:24 -0800 (PST)
Date: Tue, 20 Jan 2026 14:49:21 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>
Subject: Re: [PATCH 2/3] iommu/vt-d: Clear Present bit before tearing down
 PASID entry
Message-ID: <aW-H4Qn2qV7QHeff@google.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-3-baolu.lu@linux.intel.com>
 <aWaeUJcAFQ_vbJtd@google.com>
 <8e232d7f-9436-401e-9abc-308492a1fcbf@linux.intel.com>
 <aWd6KIGBiE-nL2IT@mitya-t14-2025>
 <6c1888bb-83ff-4121-baef-4c3c93dcbf58@linux.intel.com>
 <aWldkApQ3C9pfZ3_@google.com>
 <59eb3d65-0962-4523-a4c9-8e4417217a0f@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59eb3d65-0962-4523-a4c9-8e4417217a0f@linux.intel.com>

On Fri, Jan 16, 2026 at 02:06:30PM +0800, Baolu Lu wrote:
> On 1/16/26 05:35, Dmytro Maluka wrote:
> > On Thu, Jan 15, 2026 at 10:45:12AM +0800, Baolu Lu wrote:
> > > On 1/14/26 19:12, Dmytro Maluka wrote:
> > > > On Wed, Jan 14, 2026 at 01:38:13PM +0800, Baolu Lu wrote:
> > > > > On 1/14/26 03:34, Dmytro Maluka wrote:
> > > > > > On Tue, Jan 13, 2026 at 11:00:47AM +0800, Lu Baolu wrote:
> > > > > > > +	intel_pasid_clear_entry(iommu, dev, pasid, fault_ignore);
> > > > > > Is it safe to do this with iommu->lock already unlocked?
> > > > > 
> > > > > Yes, it is. The PASID entry lifecycle is serialized by the iommu_group-
> > > > > > mutex in the iommu core, which ensures that no other thread can attempt
> > > > > to allocate or setup this same PASID until intel_pasid_tear_down_entry()
> > > > > has returned.
> > > > > 
> > > > > The iommu->lock is held during the initial transition (P->0) to ensure
> > > > > atomicity against other hardware-table walkers, but once the P bit is
> > > > > cleared and the caches are flushed, the final zeroing of the 'dead'
> > > > > entry does not strictly require the spinlock because the PASID remains
> > > > > reserved in software until the function completes.
> > > > 
> > > > Ok. Just to understand: "other hardware-table walkers" means some
> > > > software walkers, not hardware ones? Which software walkers are those?
> > > > (I can't imagine how holding a spinlock could prevent the hardware from
> > > > walking those tables. :))
> > > 
> > > You are right. A spinlock doesn't stop the hardware. The spinlock
> > > serializes software threads to ensure the hardware walker always sees a
> > > consistent entry.
> > > 
> > > When a PASID entry is active (P=1), other kernel paths might modify
> > > the control bits in-place. For example:
> > > 
> > > void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
> > >                                            struct device *dev, u32 pasid)
> > > {
> > >          struct pasid_entry *pte;
> > >          u16 did;
> > > 
> > >          spin_lock(&iommu->lock);
> > >          pte = intel_pasid_get_entry(dev, pasid);
> > >          if (WARN_ON(!pte || !pasid_pte_is_present(pte))) {
> > >                  spin_unlock(&iommu->lock);
> > >                  return;
> > >          }
> > > 
> > >          pasid_set_pgsnp(pte);
> > >          did = pasid_get_domain_id(pte);
> > >          spin_unlock(&iommu->lock);
> > > 
> > >          intel_pasid_flush_present(iommu, dev, pasid, did, pte);
> > > }
> > > 
> > > In this case, the iommu->lock ensures that if two threads try to modify
> > > the same active entry, they don't interfere with each other and leave
> > > the entry in a 'torn' state for the IOMMU hardware to read.
> > > 
> > > In intel_pasid_tear_down_entry(), once the PASID entry is deactivated
> > > (setting P=0 and flushing caches), the entry is owned exclusively  by
> > > the teardown thread until it is re-configured. That's the reason why the
> > > final zeroing doesn't need the spinlock.
> > 
> > I see. Am I correct that those other code paths (modifying an entry
> > in-place) are not supposed to do that concurrently with
> > intel_pasid_tear_down_entry(), i.e. they should only do that while it is
> > guaranteed that the entry remains present? Otherwise there is a bug
> > (hence, for example, the WARN_ON in
> > intel_pasid_setup_page_snoop_control())?
> 
> The iommu driver assumes that high-level software should ensure this.
> 
> > So, holding iommu->lock during
> > entry teardown is not strictly necessary (i.e. we could unlock it even
> > earlier than setting P=0), i.e. holding the lock until the entry is
> > deactivated is basically just a safety measure for possible buggy code?
> 
> There are other paths that may be concurrent, such as the debugfs path
> (dumping the pasid table through debugfs). Therefore, keeping iommu-
> >lock in the driver is neither redundant nor buggy.

I see, that makes sense: clearing the present bit before iommu->lock is
unlocked should prevent such read-only walkers like debugfs from trying
to further walk down the path (i.e. to page tables) after iommu->lock is
unlocked.

> Thanks,
> baolu
