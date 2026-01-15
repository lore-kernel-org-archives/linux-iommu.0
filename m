Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8896329B79B
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768512923; cv=none; b=JrPiWjmB6Jgr1eguyKF11aE2BCVcRuSLvqtMHs3ewXs/BFkUPwZYTnV/t0RXmKR1T/2Zo3Eei3l7E1hgrpQbq88GJguVtqgVABP+z11DVBXeAaabv42HDCjZls/uKFNB1YMVMzre3p7JkpgFesCamGYpsTTAlsIlM+RJhOu0IqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768512923; c=relaxed/simple;
	bh=B7gixzbrrqdimweQZbZsv59JjNeAwB5qHZvj7TRea7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szsNRc8IOfJ3A+5t0ykSGF+Ky8haxWNWzABOuCmqMt2BNITHpUNqddPrzEnGEqv1OBYdMCJ0oWxy1T1Eo9NA+kFQsWnbRtQzlOhObASyFeGe9LHNfyNvq4LeL554Zr+Gc6RVSS4WKHcT27eQT+e40CnSAQpy75xA7JttAlvSYxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WXZ14UuF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WXZ14UuF"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b86f69bbe60so200046366b.1
        for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 13:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768512920; x=1769117720; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiHzGqqdgUm1CaDgIPQZwZhhcVQqIL6nYbkx2vXd6fw=;
        b=WXZ14UuFKLFfEmpAOITm8mNTkTxwa/QThfpTVJJJrX0EU1pD2Fx2HpP6/JApy1oBBj
         qSKhnggurHWnHG3YOnT3vym2q+XsxZN7rWDpL3HlHlSlKt2aUlCWIrl3LQjY6/2wFZp/
         /kgzmtDMBtXya3h7KMbLYQGKZBoRbSz6o5tAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768512920; x=1769117720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZiHzGqqdgUm1CaDgIPQZwZhhcVQqIL6nYbkx2vXd6fw=;
        b=PAIlIvH735Y+1TShe3w8kROri2vlF9gpwVhsepDpJV1PGh82gvzGvp0bxMEFjh1uIU
         0v+4KzSy+X+t6Qq3R90NnSHucSxF5Dh2zVgrEfdZhOMEleLQeJlVEVpkrH12GZEo0nqJ
         JE0c4WN8aDOiZB6gcGkchQddRseZWkPmIReplo9mLYGyQl6sA5YQ0rAL9BHIxhmbzJtC
         51bte+u2kFxQ837uwgqj7aA0c+QvFshiC2nSm6axZ09Ij/G3GYYkMI0tIIpkpNJ30NhD
         2K4S4sVCkAgco27a1di1UKYDPhTBr9uwXTF8VZDMpnB+vHUtldkq+JcHRYA1oUcvQN1j
         ibZg==
X-Forwarded-Encrypted: i=1; AJvYcCWU8UuL3yEf/yyzELyCCn83xRmUQdrOAPJ5L086GWVHg0uPvpDuZPnYbz1oU/l3OXGOpULVgg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/sFxKb+j8gqnEWXA4E72usfExM+bF7l0N4a2tdMN1jmnvnI0Q
	GElUPA5vuFEbQbNhnvkfLL5+VzmN9XbhNVLTZpxEppDK/mEaYqu8ATH9aUTakNqIEg==
X-Gm-Gg: AY/fxX4ivXr8wb2ZCBX8Je/84b5HX9zhZanxWU/LK5VneH4vbemkl9r+QFqcbQWtEG6
	6XW73x0lOlAOZtaDnqPa88KiZtQewwi+oJ+9RxU9LEqVvDDgu8I+lSKJJc1yLuRWR5kcxaQGLiW
	lUcP7u83e842dBJbnEB/+v4wM8q4gWerB5ktBr8143k4mqi4qBp6f+oGOS5rtkPct+DHcg4uiF1
	+FesArShiJQU23woDGBtFMW1acBGydW4dIaccLPnpcFLkcOe9f6bZVdfoMGYdMnBJdLBAHNlEtB
	sShRGWGKegYdQLQUb7dlOCCZrrga4+EhAFAmkDZG/5i1y3Cea06+ixkJ6JaMQ0k1LCE4JOgHUh6
	jNC8KZtXGFzr6/X8sVc5F55rIIjG4utupYT2cSpTpT/Ct59xrj6GXHp5UbhyGEkeuBaih+Q==
X-Received: by 2002:a17:907:3da8:b0:b77:1a42:d5c0 with SMTP id a640c23a62f3a-b8796b3ed8cmr30461366b.43.1768512919845;
        Thu, 15 Jan 2026 13:35:19 -0800 (PST)
Received: from google.com ([2a00:79e0:a:200:865e:217c:17e6:88ed])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9a08sm43852666b.37.2026.01.15.13.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 13:35:19 -0800 (PST)
Date: Thu, 15 Jan 2026 22:35:12 +0100
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
Message-ID: <aWldkApQ3C9pfZ3_@google.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-3-baolu.lu@linux.intel.com>
 <aWaeUJcAFQ_vbJtd@google.com>
 <8e232d7f-9436-401e-9abc-308492a1fcbf@linux.intel.com>
 <aWd6KIGBiE-nL2IT@mitya-t14-2025>
 <6c1888bb-83ff-4121-baef-4c3c93dcbf58@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c1888bb-83ff-4121-baef-4c3c93dcbf58@linux.intel.com>

On Thu, Jan 15, 2026 at 10:45:12AM +0800, Baolu Lu wrote:
> On 1/14/26 19:12, Dmytro Maluka wrote:
> > On Wed, Jan 14, 2026 at 01:38:13PM +0800, Baolu Lu wrote:
> > > On 1/14/26 03:34, Dmytro Maluka wrote:
> > > > On Tue, Jan 13, 2026 at 11:00:47AM +0800, Lu Baolu wrote:
> > > > > +	intel_pasid_clear_entry(iommu, dev, pasid, fault_ignore);
> > > > Is it safe to do this with iommu->lock already unlocked?
> > > 
> > > Yes, it is. The PASID entry lifecycle is serialized by the iommu_group-
> > > > mutex in the iommu core, which ensures that no other thread can attempt
> > > to allocate or setup this same PASID until intel_pasid_tear_down_entry()
> > > has returned.
> > > 
> > > The iommu->lock is held during the initial transition (P->0) to ensure
> > > atomicity against other hardware-table walkers, but once the P bit is
> > > cleared and the caches are flushed, the final zeroing of the 'dead'
> > > entry does not strictly require the spinlock because the PASID remains
> > > reserved in software until the function completes.
> > 
> > Ok. Just to understand: "other hardware-table walkers" means some
> > software walkers, not hardware ones? Which software walkers are those?
> > (I can't imagine how holding a spinlock could prevent the hardware from
> > walking those tables. :))
> 
> You are right. A spinlock doesn't stop the hardware. The spinlock
> serializes software threads to ensure the hardware walker always sees a
> consistent entry.
> 
> When a PASID entry is active (P=1), other kernel paths might modify
> the control bits in-place. For example:
> 
> void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
>                                           struct device *dev, u32 pasid)
> {
>         struct pasid_entry *pte;
>         u16 did;
> 
>         spin_lock(&iommu->lock);
>         pte = intel_pasid_get_entry(dev, pasid);
>         if (WARN_ON(!pte || !pasid_pte_is_present(pte))) {
>                 spin_unlock(&iommu->lock);
>                 return;
>         }
> 
>         pasid_set_pgsnp(pte);
>         did = pasid_get_domain_id(pte);
>         spin_unlock(&iommu->lock);
> 
>         intel_pasid_flush_present(iommu, dev, pasid, did, pte);
> }
> 
> In this case, the iommu->lock ensures that if two threads try to modify
> the same active entry, they don't interfere with each other and leave
> the entry in a 'torn' state for the IOMMU hardware to read.
> 
> In intel_pasid_tear_down_entry(), once the PASID entry is deactivated
> (setting P=0 and flushing caches), the entry is owned exclusively  by
> the teardown thread until it is re-configured. That's the reason why the
> final zeroing doesn't need the spinlock.

I see. Am I correct that those other code paths (modifying an entry
in-place) are not supposed to do that concurrently with
intel_pasid_tear_down_entry(), i.e. they should only do that while it is
guaranteed that the entry remains present? Otherwise there is a bug
(hence, for example, the WARN_ON in
intel_pasid_setup_page_snoop_control())? So, holding iommu->lock during
entry teardown is not strictly necessary (i.e. we could unlock it even
earlier than setting P=0), i.e. holding the lock until the entry is
deactivated is basically just a safety measure for possible buggy code?
