Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035944A99C5
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595253; cv=none; b=oGtRzcYEh7J0NOByh6iRdpDD1/x56ruCXqstiic6fZ7VP+ksFCutcVhgO1ARojlYcN1Xevla5ZO3cTRmhu38dsNSOUBi18zqm6MPIPVUMG+XX43uD7lC3EeNUTuJqZK9bf9O8HOgHj1o4tnsC8Xsu7eVr/kqa67XREEcsH93xLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595253; c=relaxed/simple;
	bh=Jt7kPh9XkqywM/6h7nDHDZz6YThHu04q3E5/FsPi8vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp4i8kIYGMwtErQK66RRDIxJHB2DkdMTwBT8NMG86E6OFvy0Oep3m2E3cng6I4+IzpSGNxUeGcLZI945XeD9nObJlpUY67MizjKFL+UZDTcwlsZXv1YQh2sku4Wn6/AiDO3GhnFViXTrHyxXXd+yuKggjyFe6LlViVzN8KunZQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iLfw62dF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLfw62dF"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d8facae850so80075ad.0
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 04:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790595251; x=1791200051; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bqZIT4CuwAtsItk7lmKS5Bq3DdAgNyIdg2q2F0jacX0=;
        b=iLfw62dFtaB57AuLygdspTv2YK73OW5lPf4P9rFNrk4zCTCfwPqi5zfWZpcH7KsVue
         1IJaA42qx6X0od9lvtWZwOCnjfwxhuxywto195l/4u4YOKDydCUz8EaYbf1cah4yvQ2M
         uysmgMuAP841ut3idQrkQwvni+UZniU7q3Q9x19+OW93JXomtV51ELu1kbkUSp8+xcyy
         wiqqpvtHP+oWmAl1zbEuzG6SEfapKaSWVNC7HowEuoNCvbx0wP5PhOjf5rdAFLL+LfRY
         o6Lq4Ygpo4iIYPmO8YIjm+5Em7lPavEFzlNWeQxCqfe8WlnPGxyKJjrbqRgFP64Prs7S
         9cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595251; x=1791200051;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bqZIT4CuwAtsItk7lmKS5Bq3DdAgNyIdg2q2F0jacX0=;
        b=wpTk26taQg/gtjIR7Lbztte0ooiSR07pHMsaiEDfgNU5PDudnK5Kr97fIf78mHbie/
         PFdMo8+9ir4HGg3rL/OnE8Si1tG5+D6E4NaOt6yl7GJo/Wg0HWHytcRB2okPhjXm0U7/
         ARC8bYKlXk4fy9CG9jnFJwxF51zHRjmP+r9gTqodX/mbW7ZEFCKVefyKcV/EPLXk2vTP
         X5w9O/j6oQwA5Ya9WOEMWH50mGTHkatZbsVZ42EJuFSDZc+e21gcvrEkeTBrHqCCQ222
         vc7sUqfQV4fm6gNbe4/04EIhiWyXcfKkksTAfnEC0CIa5hw/7GPK5p56VDM8QWuluA+v
         Oo+w==
X-Forwarded-Encrypted: i=1; AKwUvBwq/dRUOeUKu2yttrhiPjy3oOaBFGHDBXvdPEDPxyPp+r+rgmG4RXzd0A+Jw2Zkc82ovTpOXA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLFHoiteSE7dcTv4kB+tRVaYYrrf5F6g4Fekus+Y5YsB1meJ64u
	hm1FQazyZ9BrXkoN0++lr0/QtOjj86l4pOMMyZkFaikRFhlmOAgqRUa3DaE22JgaRg==
X-Gm-Gg: AYBFou0sGAngbrgzzDTzBGnIPauyRgIeA09S4w6f1glwrGRCstyPqDpyg7MmGRmr72S
	c1r/WVuVfanaP8fZLCnawpXTUacS/+HLr8xY4cKY5YmcGfNAt85G9JdXSussxAO0ltkREjdEh9l
	qKUcOvayeALRCsHVGgbe7a9yDBKWezE18EgFuH/e3yh8h+zua8vXdczIBoIbcjJEZU8+XlPoX0l
	TREeRe3NWRLrXMjIHyiNBTBGXUrOTBE8VkVuFAYXSJ+1cVCu1QHvmHZGZLor7MNQoj39T+XeagX
	H4De4s3PTv7uwVKeiQuCuJAOapjK42y2GcFf7vBGX/aRomI2u/8Sr57ZNGsGXxdUGKPf8exZN0I
	mvKt3UosuBJgCto1peyxgOOH2M+TksW1nVXLmotmeXHNf3Ivg0l8jBASDNDYdTrLIadt9uZqfaE
	NhSJn+tD4mtnfQzSvAQ5MP93WyDE020vUcMBDwYpLXJlXhJQL1MTsp1Zki5UIvWjAsJL4coalve
	trCsF1fxwmvEVUYPvbmVBOka6PHSYyY0VVj
X-Received: by 2002:a17:902:d54f:b0:2d5:c090:3810 with SMTP id d9443c01a7336-2dfa615a5b9mr4545925ad.2.1790595250807;
        Mon, 28 Sep 2026 04:34:10 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972f111csm26688235a91.2.2026.09.28.04.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:34:10 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:34:01 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, David Matlack <dmatlack@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org,
	Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: Re: [PATCH v7 2/9] iommu/arm-smmu-v3: Pass the parameters for the
 invalidation in a struct
Message-ID: <arpQqQXkdkNRBn-l@google.com>
References: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
 <2-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>

On Mon, Sep 21, 2026 at 08:55:10PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@ziepe.ca>
> 
> These parameters go to a lot of different functions and the next patches
> will add more. Put them into a struct to keep things tidy.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>
