Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E4730FC03
	for <iommu@lists.linux.dev>; Sat, 30 May 2026 21:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780177188; cv=none; b=FVI8L8bwj4U7JH1xyeVsWWDoZB8KFDfAVbZuQPFidMk9K7kbe2pgW+ANpXbNl1pD/PO/qctn7Gj/IKJl5a3Dwnubs4ofCsDRZsMuasV2fnkV5+Kg00U69J57o1g3vc0Ago7uxs9fwcK0+HGT+lEf2OofmHcNRzUVcDz/x/auD/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780177188; c=relaxed/simple;
	bh=CkAwCQ70kgagdEEU0IM9lUp5FDHJMlhvJgev/qc90gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bN+oFwPnPkKE1hM30pfXLjXod0aQkuqEAWE7tRPgOrIK1lEq4Exk7eIFjZq5pO/Geh0jrgWZQckA3MpH8uXvkm8gTAgHS+t1+Vr9+KrJM/t9KdQhqHTrPDQ4wauDV3ZX1MfsNh/Q4idUyrzs9jR8eod1WxyeG6m32sLP0MqquxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gKEIyIDp; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gKEIyIDp"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3965f215817so11311411fa.3
        for <iommu@lists.linux.dev>; Sat, 30 May 2026 14:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780177185; x=1780781985; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHjLm5yZVaqWyJ02pwhoH7CQXdVKY/DTm5HnPQmN1y8=;
        b=gKEIyIDphFv/wYK8RUfG+eC6p/aC5PeS3SkAjkFTBvlnhiuzb1T6u5Wjf/YSDLDd4m
         KkgoyQDgvSkuJTh4YWPTLjkk5wl1N6ouipIblD+5lhH/sftU8ri/91YqkkrcNSNRhBHs
         yxbCKoNfBO1WYkf7nxxN6764BRRDBTDfXwgzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780177185; x=1780781985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uHjLm5yZVaqWyJ02pwhoH7CQXdVKY/DTm5HnPQmN1y8=;
        b=fcqyNLJYBjw/MLbaKCkqi/ivda+pYgZdUx9aV3ZxT6wcvrCM0QdxMM+/OdWrCx+ecZ
         BQTEeYsPs00uwMYhYcBh+TTAR9u2dEqOzl5tWec1EzKduXGOfj3xdBiVik6L864+KN63
         Al3r1QXYdibcvExcUFF0u6GRZ89JDslCtKNsA4gyZBZS0QFRSI8kiXxBWNaZFzO6X0V1
         UpGzxp/nxWSisrtq29QvKu5qtpNWn1hMIGVuTS2MVyBB1Nc2HsAnYdA0ralcV4tXDAdO
         k0oIM/23ebXM8baSEoXCYt5DrHpPFakoczSD8eazuBQNzxjtRx3gFsPnV+niidl8d8IG
         pLnA==
X-Forwarded-Encrypted: i=1; AFNElJ8YFScMFGcuj/NsQDk9iCUlS6SuNINWvfoQoKRi87x/2FY2zQn4XETuAxrkccNkasF3leRZnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLSwmxJ81f2POlG4FtX76on9Tsy9dz42FLqWDaioGWWg7u60zU
	TgbJiuen189zXu/0CiVso3jSS8XoZ8nM877o4tPeCrhDLpwQoAR1vAdSy0jjn9IyUg==
X-Gm-Gg: Acq92OGy6HOwLkifvfJiS8Z7SaQlexEWJCLwsFgYwziA7L0BuyxIn6ASi0OsD012jbK
	YWc8wwuvkbY8xT4umNFnuGsnA4UjOeO6Tc03QBhVzb6mS0x8gIuKUhGVWjPgnOM3TkKJnx+4bPC
	yJ7Bj0lF+PLP29IlfIc/ZMk5x0DZvjf3PsPe/39i6OtHbtxnrsKhrvijxnO0em6Ew2jvZX0OePJ
	RQTfFeydeq1zoexCu/Viq5gxE8rZW0ROQc7kMfMg8EUT79HS3LuxBxjcLTRe2nk4rkZxwXTpA2v
	Sn9lk+FadBFUe7oPfyjkIex9baZaYsBR74mAQGe7UpLpGlEEkRZjM/VmwNfnyGb6XXT6Tl6Ng+W
	qGHIxidLN7xzpMbCSma7KveWhqnclY65qqnwaLaopbr1ZNrlrazsr7hsZav7ggWqI1ATmV69zFT
	RpAuNBxeaEAFwI8pBozm/eF9KvYOA0PFnQ33PG
X-Received: by 2002:a05:651c:1198:b0:393:e571:277a with SMTP id 38308e7fff4ca-39664f0be9bmr10766131fa.9.1780177184987;
        Sat, 30 May 2026 14:39:44 -0700 (PDT)
Received: from google.com ([2a02:a31b:20c3:6680:a425:7ae:4d82:6214])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39661e708ddsm9882101fa.22.2026.05.30.14.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 14:39:43 -0700 (PDT)
Date: Sat, 30 May 2026 23:39:34 +0200
From: Dmytro Maluka <dmaluka@chromium.org>
To: kan.liang@linux.intel.com
Cc: joro@8bytes.org, will@kernel.org, baolu.lu@linux.intel.com,
	dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
	rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, yu-cheng.yu@intel.com,
	vineeth@bitbyteword.org, aashish@aashishsharma.net,
	jaszczyk@chromium.org
Subject: Re: [PATCH V4 2/7] iommu/vt-d: Retrieve IOMMU perfmon capability
 information
Message-ID: <ahtZFmndygWdQU3r@google.com>
References: <20230128200428.1459118-1-kan.liang@linux.intel.com>
 <20230128200428.1459118-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128200428.1459118-3-kan.liang@linux.intel.com>

Sorry for the late reply, I've just stumbled upon this code and a few
things look confusing to me:

On Sat, Jan 28, 2023 at 12:04:23PM -0800, kan.liang@linux.intel.com wrote:
<...>
> +	/*
> +	 * Check per-counter capabilities. All counters should have the
> +	 * same capabilities on Interrupt on Overflow Support and Counter
> +	 * Width.
> +	 */
> +	for (i = 0; i < iommu_pmu->num_cntr; i++) {
> +		cap = dmar_readl(iommu_pmu->cfg_reg +
> +				 i * IOMMU_PMU_CFG_OFFSET +
> +				 IOMMU_PMU_CFG_CNTRCAP_OFFSET);
> +		if (!iommu_cntrcap_pcc(cap))
> +			continue;
> +
> +		/*
> +		 * It's possible that some counters have a different
> +		 * capability because of e.g., HW bug. Check the corner
> +		 * case here and simply drop those counters.
> +		 */
> +		if ((iommu_cntrcap_cw(cap) != iommu_pmu->cntr_width) ||
> +		    !iommu_cntrcap_ios(cap)) {
> +			iommu_pmu->num_cntr = i;
> +			pr_warn("PMU counter capability inconsistent, counter number reduced to %d\n",
> +				iommu_pmu->num_cntr);

1. AFAICS according to the VT-d spec section 11.4.13.2 (about the global
Counter Width in the PERFCAP register): "If per-counter capabilities are
supported, the counter width indicated in the PERFCNTRCAP registers
overrides this value."

which, I'd assume, means that a per-counter Counter Width is allowed
to be different from the global one (i.e. it is not necessarily a HW
bug)?

2. By truncating the number of counters here, we disregard all
subsequent counters, including possibly valid ones (which would pass
this check)?

3. If we disregard all subsequent counters anyway, why don't we break
from the loop here?

> +		}
> +
> +		/* Clear the pre-defined events group */
> +		for (j = 0; j < iommu_pmu->num_eg; j++)
> +			iommu_pmu->cntr_evcap[i][j] = 0;
> +
> +		/* Override with per-counter event capabilities */
> +		for (j = 0; j < iommu_cntrcap_egcnt(cap); j++) {
> +			cap = dmar_readl(iommu_pmu->cfg_reg + i * IOMMU_PMU_CFG_OFFSET +
> +					 IOMMU_PMU_CFG_CNTREVCAP_OFFSET +
> +					 (j * IOMMU_PMU_OFF_REGS_STEP));
> +			iommu_pmu->cntr_evcap[i][iommu_event_group(cap)] = iommu_event_select(cap);
> +			/*
> +			 * Some events may only be supported by a specific counter.
> +			 * Track them in the evcap as well.
> +			 */
> +			iommu_pmu->evcap[iommu_event_group(cap)] |= iommu_event_select(cap);
> +		}
> +	}
<...>
