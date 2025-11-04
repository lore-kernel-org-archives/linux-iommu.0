Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4302F90C4;
	Tue,  4 Nov 2025 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262920; cv=none; b=e8pI2WZFWytFNtzPc4iTXyupdTg0/+ix4BVKPqDhYPzzOcFFAn2PuoSHrQXPI6RLR73Ew6HDkNBPnd+iPfPBbvdpXSC1ElbGAWs/JesB61A0eB/PwKopAnYsgsQXsXreFc5v8aJ3Btu04CKTV6oVs2fp+dhQaqL4YpnKcVTp0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262920; c=relaxed/simple;
	bh=9CvQGqPY0E1C22RS/IR+Yxy6Dan0xzS9zSeM6da8C7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWXpiYdyQ/AZuts5I4gJTewnPQA1Lgrt3ZIciKz2TRLXKoqPGasYxGTm6T7oPy9aHmypHikuQVZHhvtfBAi/PW9OpRsdKWwzfGreuPqCZjqkzD1DODohW4TQRdk/97izQIxyywaP1ZTH/CM9VlnfRVZRfUHI1Ulx7y9QNuYNtkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJJK7T9K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJJK7T9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08ABC4CEF7;
	Tue,  4 Nov 2025 13:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762262920;
	bh=9CvQGqPY0E1C22RS/IR+Yxy6Dan0xzS9zSeM6da8C7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJJK7T9K54xBsqZQr5dsd4VEMZACpRsO7HakgkbUqfJIJfLkI7iQdBNdlWmONsLOk
	 qGBj8Opmm0i4OIwOcyM1SJTbqkx81shX+Ch8SAsmTj4sL68SdFtplJiY41K1+xhwRS
	 NeCVF7x7cgcGnbETmt22SLAPuShwctTrzzVKIoGeQZYwyyu1Dx+EsAaZEQpWrzEFuj
	 ZjxmhNcArococH+9vfHluIuBNRnm8snNrp/CYU+IZ/yegE/u5MTZXPZvtIkFvfjoQq
	 9vWpe8EckGts5TBkhDj+drcvEzlOdM9g4HhUyW4HCKRGi4G66ZGANowSHRF+UAGzpQ
	 AxzKRGwEhMKPw==
Date: Tue, 4 Nov 2025 13:28:35 +0000
From: Will Deacon <will@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pranjal Shrivastava <praan@google.com>,
	Liviu Dudau <liviu.dudau@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Implement .iotlb_sync_map
 callback
Message-ID: <aQn_g85KI_uuYpJh@willie-the-truck>
References: <20250927223953.936562-1-danielmentz@google.com>
 <aNp5sS7VpPirrRGE@google.com>
 <CAE2F3rB6TYjy0a9yecW4zwBLraaj75YBafEz3DUh8zrLChnuCg@mail.gmail.com>
 <aNuelC9K24z_Ph_G@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNuelC9K24z_Ph_G@google.com>

On Tue, Sep 30, 2025 at 09:10:44AM +0000, Mostafa Saleh wrote:
> On Mon, Sep 29, 2025 at 02:00:09PM -0700, Daniel Mentz wrote:
> > On Mon, Sep 29, 2025 at 5:21 AM Mostafa Saleh <smostafa@google.com> wrote:
> > > On Sat, Sep 27, 2025 at 10:39:52PM +0000, Daniel Mentz wrote:
> > > > @@ -582,6 +582,69 @@ static int arm_lpae_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
> > > >       return ret;
> > > >  }
> > > >
> > > > +static int __arm_lpae_iotlb_sync_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
> > > > +                           size_t size, int lvl, arm_lpae_iopte *ptep)
> > > > +{
> > > > +     struct io_pgtable *iop = &data->iop;
> > > > +     size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> > > > +     int ret = 0, num_entries, max_entries;
> > > > +     unsigned long iova_offset, sync_idx_start, sync_idx_end;
> > > > +     int i, shift, synced_entries = 0;
> > > > +
> > > > +     shift = (ARM_LPAE_LVL_SHIFT(lvl - 1, data) + ARM_LPAE_PGD_IDX(lvl - 1, data));
> > > > +     iova_offset = iova & ((1ULL << shift) - 1);
> > > > +     sync_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
> > > > +     sync_idx_end = (iova_offset + size + block_size - ARM_LPAE_GRANULE(data)) >>
> > > > +             ARM_LPAE_LVL_SHIFT(lvl, data);
> > > > +     max_entries = arm_lpae_max_entries(sync_idx_start, data);
> > > > +     num_entries = min_t(unsigned long, sync_idx_end - sync_idx_start, max_entries);
> > > > +     ptep += sync_idx_start;
> > > > +
> > > > +     if (lvl < (ARM_LPAE_MAX_LEVELS - 1)) {
> > > > +             for (i = 0; i < num_entries; i++) {
> > > > +                     arm_lpae_iopte pte = READ_ONCE(ptep[i]);
> > > > +                     unsigned long synced;
> > > > +
> > > > +                     WARN_ON(!pte);
> > > > +
> > > > +                     if (iopte_type(pte) == ARM_LPAE_PTE_TYPE_TABLE) {
> > > > +                             int n = i - synced_entries;
> > > > +
> > > > +                             if (n) {
> > > > +                                     __arm_lpae_sync_pte(&ptep[synced_entries], n, &iop->cfg);
> > > > +                                     synced_entries += n;
> > > > +                             }
> > > > +                             ret = __arm_lpae_iotlb_sync_map(data, iova, size, lvl + 1,
> > > > +                                                             iopte_deref(pte, data));
> > > > +                             synced_entries++;
> > > > +                     }
> > > > +                     synced = block_size - (iova & (block_size - 1));
> > > > +                     size -= synced;
> > > > +                     iova += synced;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     if (synced_entries != num_entries)
> > > > +             __arm_lpae_sync_pte(&ptep[synced_entries], num_entries - synced_entries, &iop->cfg);
> > > > +
> > > > +     return ret;
> > > > +}
> > >
> > > Can't we rely on the exisiting generic table walker "__arm_lpae_iopte_walk",
> > > instead writing a new one, that is already used for iova_to_phys and dirty bit.
> > 
> > The performance gains of .iotlb_sync_map are achieved by performing
> > CMOs on a range of descriptors as opposed to individually on each
> > descriptor in isolation. The function __arm_lpae_iopte_walk is
> > inherently incompatible with this, because it calls the .visit
> > callback once for each descriptor it finds in the specified range. I
> > guess I could work around this limitation by saving some state in
> > io_pgtable_walk_data and developing a .visit function that tries to
> > coalesce individual descriptors into contiguous ranges and delays CMOs
> > until it finds a break in continuity. I'm afraid, though, that that
> > might hurt performance significantly.
> 
> Exactly, I think that would be the way, I don’t have a strong opinion
> though, but I’d avoid open coding a new walker unless it’s necessary.
> Also, the current walker won’t do ranges, it needs some more changes,
> I did that as part of (half of the patch doesn’t apply for this case):
> https://lore.kernel.org/all/20241212180423.1578358-38-smostafa@google.com/

I'm inclined to agree that it would be better to avoid open-coding a
new walker here and if we're able to reuse/extend the generic walker
then that would be cleaner.

If that's not workable (due to Daniel's performance worries), another
option is to bring back the ->map_sg() hook (removed by d88e61faad52
("iommu: Remove the ->map_sg indirection")) and implement an optimised
version of that, preferably sharing as much code as possible with the
existing map path.

Will
