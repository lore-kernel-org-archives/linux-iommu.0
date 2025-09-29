Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4877D136658
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759184656; cv=none; b=JqYAClQ99AKRonp+pW05ewpviLnbnZlL8kfQbu3laShDk9sOQ9oDnHkwra1Ke4mQ001wBgQotQSyrda7jKy8ep41XlZZ0DceShLbmAJ4rUBLLhEwLHxeZXvkQLKQ81ZG4l5/TH6mcNdS4RqubGmDYjfCOhWceFui25CqBD6WQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759184656; c=relaxed/simple;
	bh=+QkMh7n9U5/dhCCdFMn1w5z4Yn6XS22/kYuSo8EaVuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmx81dK2SPgpbth0i+LekMmt2y6dPP6dzpQqqlVSOUBS0lkbmnX469UtQnoRtdcUal31VC9M7Sk4jEKdnBmaK+Y3tY9V2hVZgII3E/+whGNShc65G+mgapQXRFT+mTAqkhgx1oprFLFcyzaieBp1LkhESvlIY7As9WynnTPzQ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGw0CE/r; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGw0CE/r"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2681645b7b6so34095ad.1
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 15:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759184654; x=1759789454; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N0RdJkud+E1SzNcaO56lEUH3WicvjYwTDzcVf+h8XfE=;
        b=NGw0CE/rdPnOMyRvk1guCSWiuYZeP5EPhH+VE78k0S58WAjwx9ZPPBhx+7FKFM3PJB
         oC1t20lMswupxOzCaEAZBBwxYcs/C5X7fG71HA/JkyRwSxxAfCZZ9p1zRa9XxlZPaHL1
         l2rmdBL/pDE4E5l29f+cUTwBdRIvfBDjBnilxQrrJ1JihKsZn0JTlyjBBwqJzeQ+b6wT
         mrrhLENg0mbCZ0SnBL0C25QCX3cY0i20LgfcIvGwYRBXiAR9wsKfdU6aWPGjypXnkNti
         bLqHzhGMUKYWJ3FMVMgM3r5k9JFWRoyW8JwclslZ+VF9I1vJzPEHaRPFrtifOvGCveMT
         iz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759184654; x=1759789454;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0RdJkud+E1SzNcaO56lEUH3WicvjYwTDzcVf+h8XfE=;
        b=cJf+v/P47GTsH9C+WKzXXV8IoPx4/Te6MtwuKy9QQB/Y58rf7skhYH92qEXnM8PPdz
         hyADE0nz5kz4f4CIh8iexvcWBYYYakVyxV0gp528AmFKLA44s5NhtcdukS1GI4+XR5GX
         bAtNMBvuQeucjqoqVBuKlRJZ/v00VDn6S5j3gGlhMghDd1X57dNQXRki+O7mblQXYM8V
         dCTwpjls/Ry/5d+VVpjJe+VE27FtwBrYdCYTEta2i5zJAtytmSc9vNxNETPHsF+2SDPJ
         9SiCFzP6MQuF2mZKqx01OL2+uXzcPRTBODZZ4VmPnzvVFompn6UsASZnrQq8kLcJgmD4
         AVTg==
X-Gm-Message-State: AOJu0YzdB+rvGl8cB8rfWE/uH+LcvqCn9nozQLRgAt05TsF6o/+XkkAh
	PZIEHA3Wo2V8VB6qA8EGISnalGMrqoZELmfsw+BP/AFQTmCNumftHWCNOKiCqCzHhQ==
X-Gm-Gg: ASbGncs4RtUg1nRRmwRBfBWa0iFhyKSP0ScLWD/br1VWO2jVZf9twINWnKECyftzyqj
	bQ5PdVbimpUiy38zIYH8xYneAs5KaFU4yQbmnpLDRVjlSkVQlx6vIihJ2dNboYWv8utrcXLVssT
	UZLPs4ZrUjj4rKGjuptDaV5MCzctLD8HhF7Rv7iWVyyYj1E7XJBS5ZulHRyi7FkmYBn0yoVIl/e
	mWPWptOb4qYbPdlTTWXtXa35TXhGVOROCn5Z7hn1CmzGuS/QFfe9Jrnfc87xNn8bvkKy0wn8jKt
	OaMdQvsE9Gzef83Hhz/N9ug0WGvgvzpqZkeE1Le5Q7QzJqwixXVh3lQ7gBuQR6BEaUeRqd2PwVR
	7Ie/CP18kykEXOj9zAt9gNCIVVZactoE/aLioBIa2mijdvaXfq1i0SfU3CJoezSg=
X-Google-Smtp-Source: AGHT+IF4474zNSE/tR3t5AlScavptaVirEjnqy6OeJgr7wLeMqENH4oVXUgbWMO/R26nxFDRknYApQ==
X-Received: by 2002:a17:903:2c07:b0:264:1805:df20 with SMTP id d9443c01a7336-28e147eab98mr2019975ad.4.1759184653958;
        Mon, 29 Sep 2025 15:24:13 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a33a8sm12092461a12.46.2025.09.29.15.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 15:24:13 -0700 (PDT)
Date: Mon, 29 Sep 2025 22:24:08 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>,
	Liviu Dudau <liviu.dudau@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Implement .iotlb_sync_map
 callback
Message-ID: <aNsHCKdfzQNh9GFj@google.com>
References: <20250927223953.936562-1-danielmentz@google.com>
 <aNrks8eXTfHyVhKl@google.com>
 <CAE2F3rCZhgLOPKMmAqvNaQt3mUdj0kez9_MDxM3nGVOpgr5wuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rCZhgLOPKMmAqvNaQt3mUdj0kez9_MDxM3nGVOpgr5wuA@mail.gmail.com>

On Mon, Sep 29, 2025 at 01:42:29PM -0700, Daniel Mentz wrote:
> On Mon, Sep 29, 2025 at 12:57 PM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Sat, Sep 27, 2025 at 10:39:52PM +0000, Daniel Mentz wrote:
> > > +static int __arm_lpae_iotlb_sync_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
> > > +                           size_t size, int lvl, arm_lpae_iopte *ptep)
> > > +{
> > > +     struct io_pgtable *iop = &data->iop;
> > > +     size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> > > +     int ret = 0, num_entries, max_entries;
> > > +     unsigned long iova_offset, sync_idx_start, sync_idx_end;
> > > +     int i, shift, synced_entries = 0;
> > > +
> > > +     shift = (ARM_LPAE_LVL_SHIFT(lvl - 1, data) + ARM_LPAE_PGD_IDX(lvl - 1, data));
> > > +     iova_offset = iova & ((1ULL << shift) - 1);
> > > +     sync_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
> > > +     sync_idx_end = (iova_offset + size + block_size - ARM_LPAE_GRANULE(data)) >>
> > > +             ARM_LPAE_LVL_SHIFT(lvl, data);
> > > +     max_entries = arm_lpae_max_entries(sync_idx_start, data);
> > > +     num_entries = min_t(unsigned long, sync_idx_end - sync_idx_start, max_entries);
> > > +     ptep += sync_idx_start;
> > > +
> > > +     if (lvl < (ARM_LPAE_MAX_LEVELS - 1)) {
> > > +             for (i = 0; i < num_entries; i++) {
> > > +                     arm_lpae_iopte pte = READ_ONCE(ptep[i]);
> > > +                     unsigned long synced;
> > > +
> > > +                     WARN_ON(!pte);
> > > +
> > > +                     if (iopte_type(pte) == ARM_LPAE_PTE_TYPE_TABLE) {
> > > +                             int n = i - synced_entries;
> > > +
> > > +                             if (n) {
> > > +                                     __arm_lpae_sync_pte(&ptep[synced_entries], n, &iop->cfg);
> > > +                                     synced_entries += n;
> > > +                             }
> > > +                             ret = __arm_lpae_iotlb_sync_map(data, iova, size, lvl + 1,
> > > +                                                             iopte_deref(pte, data));
> >
> > I think we must check the returned value here and break the loop on
> > error. Otherwise, we might burry a failure by continuing the loop.
> > We should add something like:
> >
> > if (ret)
> >         break;
> >
> 
> Now, I'm realising that __arm_lpae_iotlb_sync_map always returns 0, in
> which case I could change the return type to void. Would that work for
> you?

Ah, yes, I just realized that too. I guess we can simply change the
return type to void.

Thanks,
Praan
