Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07C3282F06
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780371472; cv=none; b=ZXHRJEO678FG+0JHgPid3DO1Pz8MDq4RaOScmB/uxvwQ8uJiEr6GAzzMRTGjJwiKPzcuAjJ2h75T0c299n3t/kZIBgP6dmBx+78LAbMRfHQzd9c9BDoZhOmWCikHAgSVbrvZRmg3g8O63ZbXRjc8YvR/JuXno3EHDR1Qc1dauWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780371472; c=relaxed/simple;
	bh=CTnpKKXUnR1Nevr5znqg1irj9vQslNRBpLvv91oTLus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Unzjz23Nb/UV0wR27w9gfFUtM3oW1ut1+dp8JD0OBE0S5gpXMPM96kZyf3x9kANicb3+VXGjFbtlw77NZDN9rY3GGuWgJ6220oKSrhwVsiimIDNREI56V7M8IvLa4RVF0bN7buaPv6y364jVNPS3GjD4W6ddgUANdg171OPMWWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sy1u7hJX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sy1u7hJX"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf22c18ad3so195ad.0
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 20:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780371471; x=1780976271; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/D3ZWx6zAJFAsJdaNfsvsIVkbBQo8N/NxdK+lpcSrQ=;
        b=sy1u7hJXNl46MHxBwHidqm/Yc7gt94KWEMuFHZE28DrWaMKb9vs2XI6Dqh+iC1XFcV
         2JWKP5Xmk/QkhIEdZ5Nx0eQHypor/ZXpCUKN4N2nCcQZCrllobxYQopALRZ0eEuhHsnc
         Detljp4740T4S0XuNK/ybx5gOoUZgqqs0/pU7DgfdB++541+qzc7FTqdGZISjR9Go5ik
         j8ET3KxbhuUfZo7c/+K7/UIZZK1IGr5HkallyJgT7RoqM57jpEcIXJCXgjXPx7q1LC4P
         PpgshDExcdJd1UiLreZ5HBiRJ09FvhCIZ63RGxE0Rt165IrCAJP/deFuGKXcOcXHd8Yj
         ethw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780371471; x=1780976271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/D3ZWx6zAJFAsJdaNfsvsIVkbBQo8N/NxdK+lpcSrQ=;
        b=OGbYLkD85maQRY95RTRI0e59NGOeyF1UDPo4vksdH+80ow3BHI5ICekJSGZwVJDkq3
         s36OQwFyU65a2fMuZ0qs46A7MAphqD6SdiiEg58dxBav0DudDaNpn9jv8RXXm8vsGe+E
         /sn+Ruewo9fcRD9U2yKaSVLrLKqAwpeJ/0fVgvceYpMKw8V88SD+urLxfEowDkLTDKVH
         cdBMV+4thZ1Mkhciw6qFB1HSelwAB9SR59SHOD9LvoZephvSV/HPdtEP/p3sGmAed/pv
         L2X3wIrWBKlDYXyHPiObKuDJRzpjIZCY9/6wbmEQqaqB+fVVaUGyCRTKpUctONIQMGwI
         lXug==
X-Gm-Message-State: AOJu0YwsveKtyPbhujfyGmvq32YfKIN89uYqeYTSxKrgP9EaMdyF3cIR
	vtQXeki8WWKzaCtPJspygUj0ZcmNhFrm6UXQM+Ti026++BiydW0bbvxIdWGVZ6/ZQA==
X-Gm-Gg: Acq92OHMc9+i7byuP2HKD82TMgo3P5jl1wno4nVggouT4SeOYr2sBcPJmKXeWHI4CNj
	T4+kzSS8Hg9UcxbYGopiekkWSif1uAq62u4drM5fzEZpugvAD6cH7f91jcGHmjGDse8qznWOxDi
	gFVukeKqxbmW2q5z/zmODRSTBw/eqUDDFgPuLOp96eiCQCbXSMQeASRyotOYj+BZ6zJl/WK0Ybl
	ItnhU2JFQZo5AHZ2z58TAvPV9s/QlWiaWqLzocq5xNV93zMQPExWO9yFZpc7X3DxpxHSAExWiGK
	fCC8wB5NigASRAieZXMPXkhkAatzvBFBMm8vjDMg+rLcx+SVuoJc3tWMCJD51bwEe9AJxKhKy9n
	2Dh57R0RgSN4jW0vefPZEa3FZZrKKqlNo9+PCGzwzbLXseJLo7noDMT0Tmen8ZihRRMTyZ+Sj0B
	cSNdMD8b199PRTus5c277ZgWuuveYxruXtegcDt0d1Z3GeUZHAAc2IU36puy3gwtNNlgZu5MY=
X-Received: by 2002:a17:903:249:b0:2b0:aee4:afe7 with SMTP id d9443c01a7336-2c10e85e5dbmr1892275ad.10.1780371470317;
        Mon, 01 Jun 2026 20:37:50 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842222e2394sm9752165b3a.2.2026.06.01.20.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:37:49 -0700 (PDT)
Date: Tue, 2 Jun 2026 03:37:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 08/12] iommu/tegra241-cmdqv: Add a helper to quiesce
 VCMDQs
Message-ID: <ah5QB0Hfpi9wZMLY@google.com>
References: <20260601215909.3958732-1-praan@google.com>
 <20260601215909.3958732-9-praan@google.com>
 <ah4gYCgSO1bBOUTj@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah4gYCgSO1bBOUTj@Asurada-Nvidia>

On Mon, Jun 01, 2026 at 05:14:24PM -0700, Nicolin Chen wrote:
> On Mon, Jun 01, 2026 at 09:59:05PM +0000, Pranjal Shrivastava wrote:
> > @@ -887,7 +887,7 @@ struct arm_smmu_impl_ops {
> >  	size_t (*get_viommu_size)(enum iommu_viommu_type viommu_type);
> >  	int (*vsmmu_init)(struct arm_vsmmu *vsmmu,
> >  			  const struct iommu_user_data *user_data);
> > -	int (*drain_queues)(struct arm_smmu_device *smmu);
> > +	int (*quiesce_and_drain_queues)(struct arm_smmu_device *smmu);
> 
> Hmm? What's the point in PATCH-3 adding drain_queues then?

Well, you suggested in the previous version that STOP_FLAG needs to be
set for the secondary CMDQs too

All we're doing here is renaming this function as it also sets the
STOP_FLAG on impl-specific CMDQs now. We can still call it drain_queues
if you prefer not renaming this.

On the other hand, we can add a dedicated queisce_queues() op too that's
called before draining queues. I found that to be unnecessary as I'd rather
have one impl-specific op handle everything for impl-specific queues.

Thanks,
Praan
