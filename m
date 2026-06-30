Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F2299927
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 05:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795699; cv=none; b=nCx7DboWSC66hbw8iOHvDlsQfNSNtlAOoGQJpm2Rko9gfzoHOmlmKPTqhxNeLIYEjLqxKZGjrQ8N10uQAMErMPG6R00BxVER4luVZ8B+qLpDQ4AcE5QWhSWWm89H2VuwrMs7hs+KSITFE1nweeTI2BMLunNgz7InlmjQoLX2hqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795699; c=relaxed/simple;
	bh=LbBL6mPFjg+PWrpu211fjZc7jz53pUAwVRjjUNY3QVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knqmwOIoqvSzuITshyBGh1gKSxcaKwDPe6QOd8DHdNogbnFIuQEYg7kkQ+OHUbQhfgC/za3s6QUFHKd9NeyxZgl0GHV8dPakHuSVcCEHOi35aFyGIPEUv5YgRFgL9RJOnNqAEumHZ+OHCQkdz3Jigdx3IXRJySulzqq6dGcLT8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OTDQnW3c; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OTDQnW3c"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c9df229032so17915ad.1
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 22:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782795698; x=1783400498; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PUHXAQhop2N6I4yFe6BAtOJ0PNQXYFAlD9Rf6jdS8+4=;
        b=OTDQnW3cFX7KAOjOAxAkpcPOy0oeoXhytu61Z8Z3NogTmoEAhevx5918morZYdq/HG
         y9P1gvNCZoL4WFMzth9xGooS8J7QRpRFgH1/JTQHBjNl0asiNFJCBoPonQnOPK849jmH
         fwVXcqN2blKp/AqFCUa9A91jYojSWM383mor786qkP8ERifnq58xEeTJj66W5ksUpVGs
         zzq65opdpFUUeEuf5ImeQQjMPuRbBIDS50jn2+Srm7E/rRwRAdiwDiX9uGTpnD6O4/Mw
         HM/hzAmk4Zpx7IOBDK1cfQbicw27n+Q7w/XlxoK/Nsf4IYX4QTRSgkPtXZgK/WTOs518
         k/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782795698; x=1783400498;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PUHXAQhop2N6I4yFe6BAtOJ0PNQXYFAlD9Rf6jdS8+4=;
        b=qm6QOe+x1nboSR42aB1MP0zJMoeTGz05Vv/1H3V0xAohmw+DFOo4IuHg+hQXpVhIYZ
         ruxm6+j0DDzQyS9jZ/3155KN08EwH8zUuW1qjPeL3vB+bZzYiAK6qOBr+s3bW/h9uTlI
         /ZKvpFG5JMuZ3n/zkWWHfNycxz6qN3zI9Wk+GfEVMc6AIDapmRewuKzUognB1f6Xe9IV
         v1Y+H6Mj8cuKITBWcEGBoK5Vbts4B+aEkkO0zdOhqisNnZcEpDXKp3DDJ1iuAj8I4NlO
         ekcZpDN1Iqfsh8Y96hHgIxhysXeDRxriMm+3L/tW+dy6FB8YfEeK0MbpF+1vqJN8mEZ2
         1Apg==
X-Forwarded-Encrypted: i=1; AHgh+Rp4sN97X4lrPlGOwXnQSetQX5h6jjq5BLX+KTCMGIsfQdrfagyl0VC0bk3jxAEF5pvqYFuYlw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4caB5Bgkh97RsrUbIq3uF0Ck4OCCZqWhMUwu46mmPJQfCFVqz
	FyAl1YcD+25eCjIZgA8X2L3s8jHKzXT34gQz/4vMghR9fcRscNl5ARMzD7lWenTenA==
X-Gm-Gg: AfdE7cnysKzwD6oGb9jsRAS80T3fQYeLJt48yrfRDaKkPwDk9b5PA+VN+7SZ9P7tscK
	X7+oBAtqhP7TCrlTJRsWeroT47TOpBYn3WjQvaCTv9J9q2qIl9ruebrsqIzCz5N3u2VipHhE2CT
	C/JQxyhA8f+2gaaKvstf1wurgM9eov30bRcSmEYcJlMY80eWIu/1F4VlQA6ZpE87AH3m90sSLMk
	U9fXU9Uvs22jgYKZ6tTF9ZrTyYEiXc2zwIdpcY/1Vb+uZQZaX8lg28qFQC67NlXLiZf5rA6rpSy
	/OsLFYaMSfsTfFJrcxwpA417iUcAXb9clUnc2vT2bHtUONWu/LJlhMQ4xsVrErekSmIqYKyE0fl
	Xv1h+/+8MwWkd4ur7RzzzjP18umYvYh2X1zHuprPTQaIrZMHmJQ+xRAock+2tXsG0Bl8nSB9qHp
	8i98DCRKKvd1/6+7B0cr/TfRMDd8QCeOj0WYFMWGAf2pyakvk=
X-Received: by 2002:a17:903:4b4b:b0:2bd:6dad:3dfb with SMTP id d9443c01a7336-2ca3def6034mr542235ad.25.1782795697347;
        Mon, 29 Jun 2026 22:01:37 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37a70a21sm5627295ad.7.2026.06.29.22.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 22:01:36 -0700 (PDT)
Date: Tue, 30 Jun 2026 05:01:31 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v6 4/7] iommu/arm-smmu-v3: Skip EVTQ/PRIQ setup in
 kdump kernel
Message-ID: <akNNqx_aEp35h0Ys@google.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <1280ac4fdb37f998fd6dcb2bf8f4437283279395.1779265413.git.nicolinc@nvidia.com>
 <akKMCYsdH4lVSyf7@google.com>
 <akNDZM7n/EpBmajY@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akNDZM7n/EpBmajY@nvidia.com>

On Mon, Jun 29, 2026 at 09:17:40PM -0700, Nicolin Chen wrote:
> On Mon, Jun 29, 2026 at 03:15:21PM +0000, Pranjal Shrivastava wrote:
> > On Wed, May 20, 2026 at 10:03:21AM -0700, Nicolin Chen wrote:
> > > +	if (!is_kdump_kernel()) {
> > > +		writeq_relaxed(smmu->evtq.q.q_base,
> > > +			       smmu->base + ARM_SMMU_EVTQ_BASE);
> > > +		writel_relaxed(smmu->evtq.q.llq.prod,
> > > +			       smmu->page1 + ARM_SMMU_EVTQ_PROD);
> > > +		writel_relaxed(smmu->evtq.q.llq.cons,
> > > +			       smmu->page1 + ARM_SMMU_EVTQ_CONS);
> > > +
> > > +		enables |= CR0_EVTQEN;
> > > +		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
> > > +					      ARM_SMMU_CR0ACK);
> > 
> > Nit:
> > I believe only the write_reg_sync(CR0) should be under this if condition
> > do we see any weird behavior if we perform the reg writes in
> > kdump_kernel?
> 
> Since CR0_EVTQEN isn't set, the other three writes are dead code.
> 
> So, I skipped them.

Ack,

Praan
