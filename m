Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A31DC997
	for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766858770; cv=none; b=gbWhmKvXtoS4czCD1LfAOQh1DIVxVEa/B9HBGkgCQH7+VPkziQ4ggJEj5ucthnFxd3QKhQw2emx00yy3bGtYcX7++XJx5k5DhBRp/y5ag1irPbde/9v2IGqH4CZ9ZvN3iyHbRRSihMc+ubK5tcCetMuM1ewz0v5/4//j0zvPjOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766858770; c=relaxed/simple;
	bh=LeUb9b87hO3JYnam6vyZxs7ADNv5kA5A/VeH/0XCy50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVVep/QpYF4Ot17y6y2IMtPhLle9QdYmvXgz7KlQCAsmtK+dmQipcq9Zgke9Nje5t29dGdqKpM8yrbzRREfHNCuoU0IfK2Q8iNtVCtCzTHyrG2rfCgS8WWk4A2KoFCf9jSDYmpM6rh19vvlOT3aknRQARrWIJLPtx3jgfLuvNeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SXIjSkOt; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SXIjSkOt"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so8699620a12.0
        for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 10:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1766858767; x=1767463567; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JrCO1sgoIm4eBTYLvvypdWXDZ87M9Cpcmd2K9vmntjw=;
        b=SXIjSkOtwsNoXFs4Z0wRTiuffiH2A6NSK0z1HjYJmDcCtbAyanb7cWwpn6eVr9aaBO
         D5XFBrAgca+xiMS3F84IHeukgjPJjqpcIRs7VFSu1QrrKgq9fCXpazjby9rE/7Wy16oG
         aOOuQUyVD7hn/dubxx1RTl114UaRvT/37ghNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766858767; x=1767463567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrCO1sgoIm4eBTYLvvypdWXDZ87M9Cpcmd2K9vmntjw=;
        b=dzf+t7pHkLLdbkB49b92LE2YyyY0zqgNzO+wJbnHIrH7Z4v9qP4q+CzCBIrR15tJCb
         UScrtab4W7FjVsNCoOocFTv8OqpVRv16GOmfzeLsj7jceQ/ERYtaRBz3YE/a+JjKaQuv
         NPCjOHl62T4fn72FrSNIRLOscSbwgoslrJt1OQeTIEqajpMsIQRvH1+WoJA2nPfKxnS4
         yH2lSd1XSbX9uGByFxKlrrlaSgcc3WY2LxfoWI/wSRLSrvvAiPdZm2KYJinvboNdRJLl
         3EY6Imk8tLPg2m48sDpUhzBVO+TBsvLa5f6pmG5HXa1l/NlsMyv/uJO2hHf6XsrS31WW
         sExA==
X-Forwarded-Encrypted: i=1; AJvYcCWDDGyjA1E7YMbU8M47FPXsPeoG4EWMauRTrRFPfe3uFkyBAGV/PBPv5s5pYtAAH+zUfbtRhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMJsRrC6cW50dwKGxg1xR5Yn/7QQhedzZ1hx0a30thvwRNqaoE
	XxUqJ5MNtfNuEdzurSihIdXmSBH0YwuznodgpPk67FsCyVuAYP+KcphnxlXJnAiPBg==
X-Gm-Gg: AY/fxX7BXvF/C+eH50yxZ7+8eQ8oV9q2orVJzpxa9qLihJhGdNbDheZDBWfPepHi+6m
	JyP8mfwoPcJTP6N2ie3lW9cvjlQuOXRdMz8X49GlXNShjXoDlLjHeOySdTYMU/771Nz5WaYMQLW
	GTwVjXLvJNfjVfb0liv5FWkaZ85dOtCaXvPbMkX/mK+vMAT2OUfvEF9k+QHeU0LDx7ireUwVJ/D
	riLUyLF7qLONMjKWUwmhxsO6zlHEKWK0m0wKIKzm+pp30m61Q4LseAOuHjDrUqtrpMs/5Rrz40A
	9nMEihsGC3PHkGnbjjgqu07I8qwCymoJe67DvnPbom8s0rz4fIn60DCkqCm5Jdy7wSmgGdO8pbg
	JJM0+ygcpPFKLbsxgezLeASWBXRU0VC0UqREUglfJoKWfRXfsi5hYZ7wLRFGG7PwIo/q9iLvey+
	rKd2XijEpXhRNCCvkG5IkB
X-Google-Smtp-Source: AGHT+IH/5QF76dST+qUgMVrwgOvWi+w3BTNe4avm4/XQxOoN/xj1mZO4lOmC/OH/RU/a7R7ECgkHJA==
X-Received: by 2002:a17:907:940e:b0:b72:d577:11cc with SMTP id a640c23a62f3a-b8035641f7dmr3115325066b.12.1766858766594;
        Sat, 27 Dec 2025 10:06:06 -0800 (PST)
Received: from mitya-t14-2025 ([2a02:a31b:20c3:6680:3d12:d2ea:4ee0:347a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a60569sm2796394566b.4.2025.12.27.10.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 10:06:06 -0800 (PST)
Date: Sat, 27 Dec 2025 19:06:03 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>,
	Chuanxiao Dong <chuanxiao.dong@intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Ensure memory ordering in context entry
 updates
Message-ID: <aVAgC81PMN0gA32r@mitya-t14-2025>
References: <20251221014302.17738-1-dmaluka@chromium.org>
 <20251221014302.17738-2-dmaluka@chromium.org>
 <e51dbe16-49a1-4925-8b2b-56beb66de520@linux.intel.com>
 <aUfyBmPQfosuCDab@mitya-t14-2025>
 <e63edcfe-0ee9-4582-b29e-5beb549904ce@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e63edcfe-0ee9-4582-b29e-5beb549904ce@linux.intel.com>

On Tue, Dec 23, 2025 at 02:10:45PM +0800, Baolu Lu wrote:
> On 12/21/25 21:11, Dmytro Maluka wrote:
> > On Sun, Dec 21, 2025 at 05:04:27PM +0800, Baolu Lu wrote:
> > > On 12/21/25 09:43, Dmytro Maluka wrote:
> > > >    static inline void context_set_present(struct context_entry *context)
> > > >    {
> > > > -	context->lo |= 1;
> > > > +	context_set_bits(&context->lo, 1 << 0, 1);
> > > >    }
> > > 
> > > How about adding a smp_wmb() before setting the present bit? Maybe it's
> > > unnecessary for x86 architecture, but at least it's harmless and more
> > > readable. Or not?
> > > 
> > > static inline void context_set_present(struct context_entry *context)
> > > {
> > > 	smp_wmb();
> > > 	context_set_bits(&context->lo, 1ULL << 0, 1ULL);
> > > }
> > 
> > Maybe... And if so, then in pasid_set_present() as well?
> > 
> > Actually this would make a slight behavioral difference even on x86:
> > right now this patch only provides ordering of context entry updates
> > between each other, while smp_wmb() would add a full compiler barrier
> > here.
> > 
> > So this barrier may be redundant as long as we always use these
> > context_*() helpers (and thus always use WRITE_ONCE) for any updates of
> > context entries. On the other hand, it might make it more robust if we
> > still occasionally do that without WRITE_ONCE, for example in
> > context_entry_set_pasid_table() which I also changed to use WRITE_ONCE
> > in this patch.
> 
> Fair point. It is somewhat redundant. However, I would suggest adding a
> comment there. For example:
> 
> static inline void context_set_present(struct context_entry *context)
> {
>  	/*
> 	 * smp_wmb() is unnecessary here because x86 hardware naturally
> 	 * keeps writes in order and all context entry modifications
> 	 * use WRITE_ONCE().
> 	 */
>  	context_set_bits(&context->lo, 1ULL << 0, 1ULL);
> }
> 
> So that people are still aware of this when porting this driver to
> platforms with a weak memory model.

What I actually had in mind was to add smp_wmb() here anyway. It might
be useful as an extra safety measure in case we still forget to use
WRITE_ONCE in some cases, and its performance cost would be virtually
non-existent, I guess. Done in v2.
