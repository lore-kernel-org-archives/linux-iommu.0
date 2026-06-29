Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7120A44E040
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 16:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782750509; cv=none; b=gJlRQTEhbL2K42yquMBGXLl1MB7YBXQHIQhfb1wBG3VCy/ISJ/TgecxNSwZobWe9NUDxNFfJHy4CZVg/4rnpuFrGwI0ZdYzE5/2w3dgJcw+0fq+fhsWyL4Tqfiybi6HYTcxqZHVQ+rUKjdiEos5Pe18SKP3bd/c00ZTY+tkwXyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782750509; c=relaxed/simple;
	bh=HoZdwkQCUZWVoOYy4+KgRStt8L7Oi0ubrdBnrNiil7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuLbD+q9dIPtFACiYVwA//+u4svXQwFe/5N4i21/L9k/GMB+5lQJH4blBpZZF2COJ4BKNOfNrFKxquHgGjt4hvxwiEvL66uk6+iU3PjKLMZUxSDeyvs6HjqR/YOOqB9JX/A/hPC+MGtW5WOY0l6VX0Z0BU49HDfJQvJxvkcDMdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vGGvNVp+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGGvNVp+"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c9b2ac97cdso61805ad.1
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782750508; x=1783355308; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bio6F01mW1uhzjb2Qp+Xy8h4WP35qzyJOdcn1fRlVDM=;
        b=vGGvNVp+Ya5K9qzGuDgOiNNtHjXfWPt66JkxDZ+MzSyNJHFWdL7uxVSm9c792ZAPkz
         G4Qdo/21d4UjoXxRhnR04Q0BOkwBIIfAG4O/qcywh+j1oV2JxoImWwkXCq6AKzNh69PR
         1yUsNh+mPloEFbb1zlCHrfCGsFc7j+5qE+x7G4iiZcHiwdp/eFJkaw4n9DekqimH2wMZ
         BMDu96KeapUApIbf4fGCRfZaXfUdWwfjLEsKhIqjVbTQDvq95tCpDvWFwgIDPW0uz4GG
         WzqdaGlRohXiVWfKEaQwfQpmZipZl48e1Tvx6kg2HTkhhNy1YgSz6xgKCsSdOU3+YMC7
         1qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782750508; x=1783355308;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bio6F01mW1uhzjb2Qp+Xy8h4WP35qzyJOdcn1fRlVDM=;
        b=CMcR4CKKWqCKKg2ABtdtD/Hgl2Ni66iMDRN6ZpdzmKfW6Qr87gY5oZ9hITn0D1qsdI
         xPbbJYqcD5YSKvDJ2c+81neTusK4OAbSY8vyRdnwxBDaHa4w5aBrn5wCxrGyq+qhKDL7
         l1mk9YDRj9EA0xAAN0upixSjlVGUFmNABmrNT5197iy9KWW4dZOOAKr0BV0ufIdFPwBI
         G0CaZ6B+DMU1Cekjo9LySExy1yIoGJO+PGfNyKHldv3VsiV7w+HjuE+1yMXiPYnECbi7
         vs/PrTQchmbJ9l/8wOtHx62YgIg++81NnqddqYsv7kSI95mxVEXV43B0NAHtES7S8YJy
         FCvg==
X-Forwarded-Encrypted: i=1; AHgh+Rr1Z+oI0v+Q7CiEJPrgvcbTNAwTP0mI3ieK3wQwFn0GGsn/yYq8dEpN1xHnK0zCZwGnB76WRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIQqIqKuQ1nJy8a/NodYlapkjg8wDaa7qoxda48ynGf2pMlzP1
	eXBLyYP6Q1yYQCEVVYtBlb3XKmpZQmNUa8cJzCW1L+R45fvP/wqnYoPUw+Urr5rCiQ==
X-Gm-Gg: AfdE7ckD7c5P5htAuN+Rg9gQ+kTpJfnaFHWY58ypKqX8xqbGudtZjWd497HmfIJdOtu
	CxevpFx8aMnP/8OFgw/vkJ4FiSNQghqUfNq0NfdTlDd6A5w8ZoBzc2QLTnJ+Zi4yOGhFOJFxFIu
	FjjLyq5s63L180MGgJx0WXgHLaazXApa2ZMbyELPQFjcplQSEKNenOpmwxbHQGFvj030l8P91OM
	D2lVEHJ6E0CDSnKuSrqX7gaag7VVVSe3ttox78cvSIKoDOTeP9F5SpCvhB1OlAQr4VIuQgSbqxf
	OF5AzlL8pvFdyyCH1zd27qe0Oeys2/PjE470s5DEz1bAMAqaair+cNBoGiSiH8kPVccDCAUAil/
	7cc7/cGj5NEzB6qErtI9r2NMSShnxexTUsUTX6pENfpCVNn5MUwdulxE7gyc0UdqQuiTxhCglEh
	jR7mvuDG7EuuYvJhyJM4Ju+J6N1nGRLtBnX0Zpms68HcJQLX4=
X-Received: by 2002:a17:902:fdaf:b0:2c7:debf:2146 with SMTP id d9443c01a7336-2ca2cf9c2c1mr251595ad.9.1782750507162;
        Mon, 29 Jun 2026 09:28:27 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38052f4789dsm10213a91.14.2026.06.29.09.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:28:26 -0700 (PDT)
Date: Mon, 29 Jun 2026 16:28:20 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v6 6/7] iommu/arm-smmu-v3: Skip RMR bypass for kdump
 adoption
Message-ID: <akKdJFx7zhWtpjBT@google.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <88e75018e94adc2eb3db8c1fd97c3cc738c170bb.1779265413.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88e75018e94adc2eb3db8c1fd97c3cc738c170bb.1779265413.git.nicolinc@nvidia.com>

On Wed, May 20, 2026 at 10:03:23AM -0700, Nicolin Chen wrote:
> RMR bypass STEs are installed during SMMUv3 probe for StreamIDs listed by
> IORT RMR nodes. A normal boot switches the driver to a fresh stream table
> whose initial STEs abort, so those RMR SIDs need bypass entries before it
> becomes live. This preserves firmware/guest-owned traffic, including vSMMU
> guest MSI cases built around RMR-described SIDs.
> 
> ARM_SMMU_OPT_KDUMP_ADOPT is the opposite case: the driver keeps SMMUEN set
> and adopts the crashed kernel's stream table, so RMR SIDs already have the
> only translation state known to be safe for active in-flight DMA. Replacing
> an adopted STE with bypass can turn translated DMA into physical DMA, then
> point it at the wrong memory.
> 
> arm_smmu_make_bypass_ste() also rewrites the STE in place after clearing it
> first. While the table is live, a concurrent hardware STE fetch can observe
> V=0 or mixed old/new state.
> 
> Leaving the adopted STE unmodified keeps the kdump kernel using the crashed
> kernel's translation. That gives the endpoint driver a chance to probe and
> quiesce the device.
> 
> If the old STE was already abort or invalid, installing bypass would create
> new DMA permission; leaving it alone is a safer failure mode. Later domain
> setup still gets the RMR direct mappings through the reserved-region path.
> 
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
 
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
