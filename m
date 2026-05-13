Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D209339281B
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698113; cv=none; b=ugIx9PKIrcaGjZuMjIwsdqYwD3T7yWuygjnEOS8+CsOQIkXo+WqIsMK1qw1cOeBKAXydjGvMgHnHIhORWnNnFIg0rHj+X6yxRm1i3cZXuL8e9tLA6wnnTRGHZf08ul7en0c+XAmkkeLSULnEntRwfLG9mREsTuHXP7Cg5Pck6sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698113; c=relaxed/simple;
	bh=aL2zYD6QLERED7wzbI8gk+iTUinoqfJpuO7sHvvFO88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRsmQvN4+wNjYl59xjKOrWxui2tKZrLa2PSefdCamMCB1ZfUFSJoJEgvVQ0vjhl7Uju4nvFiQ7ATSFVm7dT8KZ/GelF2JbS9RZwDppAeHk+SRt913lSQ5TKD0hHDg1lMZLXoiaAg5gE7GWLJZ5AWVbIWsq9mzcGmNXS+ZYMuq/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eqf1T+t0; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqf1T+t0"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c8d0945b3so18c88.0
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778698111; x=1779302911; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWJJS5PcKWqo9rQpzbwkNgjxbs/zQ0FlBBDO0W0FHcE=;
        b=eqf1T+t05kfu8JCbDkonfZ9XFIfGCR3Ad7e4diohRlBl6zJDue3Vgq7DoM3tPVGAoT
         1I1ta037RYmDcoMRlMKxIf7MBESM2rFXUAU2OUQYgUgeNjklZzNxSEKjAVWX35lsGvTx
         6dVRPhLZ5a0ua7xurTtIA+CK7CK0Hf8+nl6Npqo8OOzd5y/hHMgbIo33/IDJzrSi2OnJ
         BE4tLgaPykKo7LLjCtbUDYUByKne2v323q50FcXlV3oOtnk2Qhm3Ntp32RLEIN7oLK2j
         FoDFEpwn4AHpzboEpOkkM5zTUkycjPCwAm2RnD/jx3Se7+ast0sRceMLgQwK6kVu5gmz
         cI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778698111; x=1779302911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWJJS5PcKWqo9rQpzbwkNgjxbs/zQ0FlBBDO0W0FHcE=;
        b=iZTMaCY9jmMWAoe/fociLu94khifQtXURQQ7MZEFRx638v+9Id+L0pkWgNBNcrH/6T
         mnzNhHFISV4phpZzUBQ2q3U0UxNnbC4kKmnGmGdzjS0KZodTbMBu77Eu9qMDuUzmB1EV
         yvYI55iZDxEonAEAoAHHS49oxh5HrT5+bv0KMzMUHCaQWLZzbfxFpqXj5o1WWvHgHokn
         J2gDbkWYScwKFUKDwyv7aXDVj+7Um/aKfzVGLmfsaKhM3fMWKWQ/GlCkKmEejOji/HOI
         a3mWMSXPEqcZkLntumzkgIVVuM8nsngm3GO8pq4g2d6xekczdb8Kfe7y+x8sIhZ/BYxa
         XlpQ==
X-Gm-Message-State: AOJu0YxpT45tjtvnHQd2nYVpN1Dl9j28qFFR8mRfYNJe8+F3hSL8CpFg
	B/mXpPktMAYMNKGO0B6F5UoOMS1BibEEEXGiFZO9AQe4eimVyjuw3D7g3G0hzaaDZg==
X-Gm-Gg: Acq92OFlhkIAU626G/kKduHbNYVoO7ZRpnSpD2a/SjtvbCkHU4hh9U1E8/jffFzNgAt
	owbC1dhf27tQRGnNVw7j6pL/7mKNOXOsg6BcezVEKjdhzi2GYvQyHS5EVYHqDSehqR/reBTT5GZ
	2jGIoO352iALRjILiYPwwxwXMVtwA3EmW1Kk+TXe3H3ohlrkpxyy+cYqcysTs8hc22zQYWr7iks
	RcD9sW+1e0XSrndPt1VPN00M9PoNqiUsujqu6W06NOQ9BF+pWvtkbqOU8msSq6edX4Y49dgcaiG
	Go9pfVkLOqth3AIxLFObjPyjMmZwFcis6ExugqXfuC7xNIcbzla75nbTjSbKVkcnWKnNZiNv4Vv
	qxXm2IersT+EumeL5BuDeSeAS2NvxFtuX/fH9f73qMTH/JwV34jtyQoMahNn31HzfLdk/6axH2p
	y5E5bTisMuUr391JazFnYEbZjswyYNKpWxxfl6H1wTdLJWgrphXJnPxs/Oedt0MIXvj4sIZw==
X-Received: by 2002:a05:7023:b8a:b0:12a:8cf4:6506 with SMTP id a92af1059eb24-134cb45845fmr51331c88.4.1778698110450;
        Wed, 13 May 2026 11:48:30 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847502fsm28400768eec.14.2026.05.13.11.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:48:30 -0700 (PDT)
Date: Wed, 13 May 2026 18:48:26 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joerg.roedel@amd.com>, Josua Mayer <josua@solid-run.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	patches@lists.linux.dev, Pranjal Shrivastava <praan@google.com>, 
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH rc 4/5] iommupt: Check for missing PAGE_SIZE in the
 pgsize_bitmap
Message-ID: <agS-MDCnoofhsBEe@google.com>
References: <0-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <4-v1-44b2fef88b25+d3-iommupt_map_rc_jgg@nvidia.com>
 <agS04F8UmZwWZNao@google.com>
 <agS6jQII_2PsAuZh@google.com>
 <20260513180607.GC787748@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260513180607.GC787748@nvidia.com>

On Wed, May 13, 2026 at 03:06:07PM -0300, Jason Gunthorpe wrote:
>On Wed, May 13, 2026 at 05:57:13PM +0000, Samiullah Khawaja wrote:
>> On Wed, May 13, 2026 at 05:46:22PM +0000, Samiullah Khawaja wrote:
>> > On Tue, May 12, 2026 at 01:46:16PM -0300, Jason Gunthorpe wrote:
>> > > Sashiko pointed out that the driver could drop PAGE_SIZE from the
>> > > pgsize_bitmap. That is technically allowed but nothing does it, and
>> > > such an iommu_domain would not be used with the DMA API today.
>> > >
>> > > Still, it is against the design and it is trivial to fix up. Lift
>> > > the PT_WARN_ON to the if branch and just skip the fast path.
>> > >
>> > > Fixes: dcd6a011a8d5 ("iommupt: Add map_pages op")
>> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>> > > ---
>> > > drivers/iommu/generic_pt/iommu_pt.h | 4 ++--
>> > > 1 file changed, 2 insertions(+), 2 deletions(-)
>> > >
>> > > diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
>> > > index 19b6daf88f2ab1..4877b05291c9d4 100644
>> > > --- a/drivers/iommu/generic_pt/iommu_pt.h
>> > > +++ b/drivers/iommu/generic_pt/iommu_pt.h
>> > > @@ -920,8 +920,8 @@ static int NS(map_range)(struct pt_iommu *iommu_table, dma_addr_t iova,
>> > > 		return ret;
>> > >
>> > > 	/* Calculate target page size and level for the leaves */
>> > > -	if (pt_has_system_page_size(common) && len == PAGE_SIZE) {
>> > > -		PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
>> > > +	if (pt_has_system_page_size(common) && len == PAGE_SIZE &&
>> > > +		likely(pgsize_bitmap & PAGE_SIZE)) {
>> > > 		if (log2_mod(iova | paddr, PAGE_SHIFT))
>> > > 			return -ENXIO;
>>
>> After thought nit:
>>
>> I wonder if the error handling of iova and paddr alignment should also
>> be deferred to non-fast path? Basically lift the iova and paddr check
>> in the parent if?
>
>That would break support for < PAGE_SIZE tables which I've tried to

I was also thinking about support of < PAGE_SIZE tables and wondering
whether the < PAGE_SIZE tables support is already broken. For examples
consider following:

iova = 0x12341800
paddr = 0x56781800
len = PAGE_SIZE (4k)

But pt_has_system_page_size() will be false in such a system.
>keep generic support for. Similar checks already exist in the generic
>code in a more general way, probably the first is
>pt_compute_best_pgsize().

I was suggesting to rely on the already existing checks in
pt_compute_best_pgsize() to do error handling, by only entering fast
path if iova and paddr are also aligned.
>
>Thanks,
>Jason

No change needed. Putting this here again:

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

Thanks,
Sami
