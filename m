Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9734D2E2665
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381496; cv=none; b=r9jzFhkfsHMs9KiRqJyc4OUbhrVW9pf4k76uHn2SFC/lq6VOyIpFA4GhEQbEHR2fPAFV8lFZktcpPg9eIFJuPIpT5kINQ9XAMVWu572GhwvNQysZS3rBTr9a2/12ftMFEnbnb5K19ghqAxHaNhJ6iY5wO/rfZ0BOJ+oL1U8V+LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381496; c=relaxed/simple;
	bh=mYa+0dMQQhtZWhZaJhSYBpE/0MlR7qxtBz6iFV3h+2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4iny444NnBZevCkC5L7iEaFwsMz5S7ksefAdwbq9Ib/j1uJMeAMV/rlaCHuq0zjRHge+q8fgw+v86WMGl7EjglsbIrc167kz9Wp/cUtWgAwFjc4cjdWqo1bRIeOwBfV9D2uy5MQsd2+OG4kWrzcdgkKP6J6AFMVx/kDc7Wfgxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KLA6GJZg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KLA6GJZg"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf2911f93cso1595ad.1
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 23:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780381495; x=1780986295; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhEw5DiSYpz62UgZllWX9BsqQC/TZl5aB/QiWr0aWdI=;
        b=KLA6GJZgPHPDIqS0zfKJ74BiY9rkdF3K1XCdPoqI/SFCoojUchI8rgpX5te97UZOQQ
         eSFkEoKaSZvJSsUJLycu+3UfwQ5GhwzTRWvAcCs2jS9b+luL3eddEw5ed01b17xK3/HK
         ChD/RjmTpehWD9wG2/T5BE6ySrbunQTtcaSHYx+1ljkqW77NBK12YBhz0Zat2LURqP9F
         mVGdPxmYfI6BJK1+GhxYwmEzFC/WK9wrnhLBp+1Boj0QO/qT0rODoSi7K3z+TDVxaLR3
         zeoXy8aJlRkXxW8ygtytbNkOOS8GFN/o6v/ozI+/p7rgy+gS9n3vL9GpOlWUoPSWb2jV
         pdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381495; x=1780986295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhEw5DiSYpz62UgZllWX9BsqQC/TZl5aB/QiWr0aWdI=;
        b=Bg6iKlWrJ57rPNtxsxDiLMnjamCACYD5RI+hv8m2Ar75v3kauODvdAeJeICra+jm21
         muzF5zu4RHDTAobSf2XiuCdLaugzAKYxGrK2H6/1/hqJ+Rwqa+Llac0zXr15htnrAoYd
         N/yTbwmiPHwKw12bD1b7YMUgd7Y9jfrfi293ylrzBZkmnsnmjGAoZF1++aRTO4Gb8SCn
         UWvBnjzesGuoBZU0iCKg6TYophHoIxlTcNxYeXdyzq9d89yGcsju70VJ1OzVQE6mATKX
         sfiFn0pE0ofVwaL17vfRs3FcmWg3G7wW22LGgnrDgkCud14m2ZwsiA8QtzafAjfurQEi
         yilg==
X-Gm-Message-State: AOJu0Yz/jodo5GlDESSrXTlT1dOSxvuEJG2lYM0Gh6f8ZYIwNhayXHue
	OWAHqFKGy9lSW525LSng/rCWPQc0eV/g1OnYAkgkHgdWZPN7AoMjK89W7vL4OnHPmQ==
X-Gm-Gg: Acq92OE1coBdBUoZu0ZNsl8SM/4eVcvMdmlbX2PjWQG7Y65jIMDu89T4ojuKN4bhlL1
	GmOywMd7VotHQWQ5qWSklg+B+xFTqw98YZr5n135JvcOK9i6LCzml3P399cVCyAekTW7NRawzt+
	QtE5tlnPSLi7T51uPLl5z2mxOIAyExV1fbGiMIDMBqy/UVoWbRLkv7Nap8yL5F2J7Uyf3sFTDHs
	4+AaWWVat5mbAPzKlDqfD0hNSHG4HBNDKnjIHix5cfEbDeRC90hLS8jyEpj5ZHwpSOJKG1WhZUk
	1MXuV02CGRXNePp1iLYNe3pn8So0Yy2+QezZX5ffe/ZTji6slL+zYj5fi9U0H5AyjlKTDjYD7YV
	aVdzS/PumlO9wMqO7odQZUolq27ryMUOY0FDB+HdM9U0a/jIVp3kFU3PS9NiYcN1VFROVlRBOV+
	9kYviUjuciGa/Su4ZAfbsa24dPcL0QkIN1bE5WT0OP//BeKxdY1n0Hs0HwWm6FWZsEZukkSrQ=
X-Received: by 2002:a17:903:3848:b0:2bd:6dad:3dfa with SMTP id d9443c01a7336-2c10eb301ddmr2110195ad.24.1780381494066;
        Mon, 01 Jun 2026 23:24:54 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc9bff159sm5459516a91.0.2026.06.01.23.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 23:24:53 -0700 (PDT)
Date: Tue, 2 Jun 2026 06:24:46 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 11/12] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <ah53Lq8DTAsVUY0n@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-12-praan@google.com>
 <ah4isiGhSScKMotO@Asurada-Nvidia>
 <ah5VOE5vuEPwr4oQ@google.com>
 <ah5vZl3zcC6YPeZ5@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah5vZl3zcC6YPeZ5@Asurada-Nvidia>

On Mon, Jun 01, 2026 at 10:51:34PM -0700, Nicolin Chen wrote:
> On Tue, Jun 02, 2026 at 03:59:52AM +0000, Pranjal Shrivastava wrote:
> > On Mon, Jun 01, 2026 at 05:24:18PM -0700, Nicolin Chen wrote:
> > > On Mon, Jun 01, 2026 at 09:59:08PM +0000, Pranjal Shrivastava wrote:
> > > > -static inline bool arm_smmu_can_elide(struct arm_smmu_device *smmu)
> > > > +static inline bool arm_smmu_cmdq_can_elide(struct arm_smmu_device *smmu)
> > > >  {
> > > >  	return !!Q_STOP(READ_ONCE(smmu->cmdq.q.llq.prod));
> > > >  }
> > > 
> > > Can it be named perfectly at the beginning?
> > 
> > Ack.
> > 
> > > 
> > > And again, should it check Q_STOP in vcmdq?
> > 
> > I don't think so.. the primary CMDQ's STOP_FLAG should act as a proxy for
> > the SMMU's global power state. Since all queues (primary and secondary)
> > are gated synchronously during suspend after SMMUEN=0, and ungated before
> > SMMUEN=1 (i.e.before the caching can begin). Checking the primary queue 
> > should suffice..
> 
> Should leave a note inline to elaborate why we only check primary
> cmdq only.

Ack. 

> 
> [...]
> > We can also decide to drop the can_elide checks from invs_array and
> > atc_inv_master altogether, leaving gerror & page_response the only
> > remaining call-sites, both of which don't use secondary queues.
> 
> That's not true.. In the host mode, any command will be issued to
> vcmdq. IOW, primary queue might not be used at all.
> 

Alright, I see the supports_cmd is a Guest-only thing. I'll add not to
the can_elide helper.

Praan
