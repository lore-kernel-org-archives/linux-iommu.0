Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2CA37F8D5
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409950; cv=none; b=VYfY+Yk22PvKe1Vi/2bh8P+/oEyCHLURNTjsNXsf46kA7HLFLhc3A1zEu+ozXwtYK0N1JMXCZKUKic+pvn3XVUpOIPek/F1EzYgsHM6hdL6H+YdNpQ+wQnpQdZ9NBplyjykD7D78o2edR8+Av5iYPhd6k/gKBFHoAJxk1/kf5Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409950; c=relaxed/simple;
	bh=DjpdDDJbM/IsjFMrq1EcksQWZkZ6ktdKQa8/EaVmO2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3zSFRwCnvS+Sg27buv2nonBS2Q3ajvA30PiAgKkACgS8Jp06vc/0tz9ncxBonXPVP8wiW2iVQlvKWYxngKuUCmbjSYRRtPBPusBGRQyYXdaDVtVYaJplghmfwMnxl/fyzOurNoFhs7mZF6xhdJkaN5XRc6/uppJ70GdL0+Nu90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VvkslXcH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvkslXcH"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a35ae38bdfso82555ad.1
        for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 08:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768409948; x=1769014748; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nvlZDl7Sj74xagDLD4MC5KELnDbe4Vh9GRDyybbfdBA=;
        b=VvkslXcHMByO/QEPVYwfKNdG7YLOEyG7p9kwIB8/e8+djYGRdP3QJvjYjEGRAINd1L
         wB6yxigk9nIxFWfMBeWhRekHCDuLaDk4rrpgJqN04DjBu4Sq408M5819O+qm+mXXsrhF
         UrHS/5K7wundV78coBg9wq8wPx2juUgewuwYCpEhs7Xc3bsUSAG64EfZkQvenmWCQxHW
         7cNbnXdjsyubHA/6ftfgh8YlMxwr2XJjQadjMTf0x/i23zxyQ7XojTM63PfjnHqYpByz
         XsBXIm1xFuIgmVvO8n9DtasCqx7jDJXbvdKxSb52YFGvOcIKGs/4M9e/WfFwDNnhHcnQ
         j6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768409948; x=1769014748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvlZDl7Sj74xagDLD4MC5KELnDbe4Vh9GRDyybbfdBA=;
        b=d6bIuMGUYFfEPXfFjisYi0R/G+K2668rIIF77FrUpI8IEFkuMgC2npI25Nujd9x8kh
         FSFQ267t/ZNGwwNpuW15sLgioMH2gb0Vhk1v9s117PMo2qg74zKECjCCkLcQFsqyWXjY
         T8/4hZITnINz+lvndb6vOjDvNTM/LiToW4fbwysyjpEIqI5fARb5R0oEidTPYMhwtRNy
         SbVQScX05FQjb+qvbfbBa6SHbsfTlb3kGvAGYRcbyJNcaF4uK+TaGwCQgHnQjuE5uCYx
         0e+fUL9ehloEYjVJ9P/ZfVTKeTJGgOJXnsRbxbupf4/EXg/y1WT2eDsdATrrO/ZiRh8a
         z0Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWhhDvXi7vOnA/ofJ69LsEwo8YwwuJMHeYiOPYV/tkMwjCfiipiZBeHraxGHBhTRAgchb5c7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpdUXo3L0m68iqVwHKyLIkn+qeUpELzc6i4HxHciLsxyugLJ0b
	d92mEYmzRb0/2lbMppaHs/VOynfxvWf8+C9078Imm1OF2jGE4Ee8EthB3nHT7KvLHA==
X-Gm-Gg: AY/fxX75CR6RXpOoXS2gKhCVUK4T7GEnqbgHTjADdhDr2uOkShnak0QazzlIQouTLgE
	9dvzinX8odIpDEA+jFb5gYq5mSz8GPpnViGItqPYrSOfzC3rp4yfA8y1ZecJoyi5w7cA8Xh0QcK
	mJbR8pxKxOVez8zs72G/mVt2hZbVL8oXtgQScSlEA0gBXw3P7QUzKdo1DgxgYowQ+54HJ/tzfd0
	vX+19EseNDQO5oX9rGgLRuXt9KbYnNg44YTC5bl3mpsiVCOwL56ggR/m33nuptMvP+bUQLlma6M
	Jtpy/38tCoTOlZN8/cAqdrsPNmooigrxoBAZ7o2MsejKoY4PDcsnYy8qXTtRP6+REXoSL3AXnEP
	VwZG3KEIypxSpOMc8OAxMdGKn4QASgjWLEilF1AtZp08bwGQTcVGqb7Eng47xV7GbhY4FrqLbER
	icKLiFzfFqCKqv8MrRZJyppUU5S9Z6mmYACPYebHqH52iPkqie
X-Received: by 2002:a17:902:e890:b0:265:e66:6c10 with SMTP id d9443c01a7336-2a599a24a2amr3823475ad.4.1768409948061;
        Wed, 14 Jan 2026 08:59:08 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8e381d7csm135568b3a.0.2026.01.14.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 08:59:07 -0800 (PST)
Date: Wed, 14 Jan 2026 16:59:02 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, skolothumtho@nvidia.com,
	xueshuai@linux.alibaba.com, smostafa@google.com
Subject: Re: [PATCH rc v6 3/4] iommu/arm-smmu-v3: Mark STE EATS safe when
 computing the update sequence
Message-ID: <aWfLVlDNZR5ecesC@google.com>
References: <cover.1768248467.git.nicolinc@nvidia.com>
 <b8055e0f0f1b4473db2583586350b4f7aa8f3b4c.1768248467.git.nicolinc@nvidia.com>
 <aWe9C8wwfszvqxR6@google.com>
 <20260114161557.GB961588@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114161557.GB961588@nvidia.com>

On Wed, Jan 14, 2026 at 12:15:57PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 14, 2026 at 03:58:03PM +0000, Pranjal Shrivastava wrote:
> > > +
> > > +	/*
> > > +	 * When a STE comes to change EATS the sequencing code in the attach
> > > +	 * logic already will have the PCI cap for ATS disabled. Thus at this
> > > +	 * moment we can expect that the device will not generate ATS queries
> > > +	 * and so we don't care about the sequencing of EATS. The purpose of
> > > +	 * EATS is to protect the system from hostile untrusted devices that
> > > +	 * issue ATS when the PCI config space is disabled. However, if EATS
> > > +	 * is being changed then we already must be trusting the device since
> > > +	 * the EATS security block is being disabled.
> > > +	 *
> > > +	 *  Note: Since we moved the EATS update to the first phase, changing
> > > +	 *  S2S and EATS might transiently set S2S=1 and EATS=1, resulting in
> > > +	 *  a bad STE. See "5.2 Stream Table Entry". In such a case, we can't
> > > +	 *  do a hitless update.
> > > +	 */
> > > +	if (!((cur[2] | target[2]) & cpu_to_le64(STRTAB_STE_2_S2S)))
> > > +		safe_bits[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
> > 
> > I understand what we're trying to do here but isn't this implicitly
> > saying it is safe to transition hitlessly to any non-zero EATS value,
> > including S1CHK or RSVD. S1CHK might have other config dependencies?
> 
> Will pointed this issue with S1CHK, Nicolin has a suggestion to fix it here:
> 
> https://lore.kernel.org/linux-iommu/aWarF90zBqxD0Gef@Asurada-Nvidia/
> 
> It would block RSVD too.
> 

Ohh okay, sounds good then, my client dropped it somehow. I'll defer
this to Will.

> Thanks,
> Jason

Thanks,
Praan
