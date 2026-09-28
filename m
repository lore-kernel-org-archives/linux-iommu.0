Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446173CF1E5
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790637395; cv=none; b=q2cDhQeTuXp7lWIemg4ZEBzQoI7qYEgxlidN915CKDh2saqJpqAK0rT2oGOW9KBYmNzqz7pmchdCyphuahN5IIAWCKhj66l1A1N9gp5sLFTEJzFYoSk3IjzoJoDtiKv0MlmU87eoHQgbVPWFlttDafSaypwuyCuFwFINfLC4blE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790637395; c=relaxed/simple;
	bh=4rJz1QddBFCOKaFtHqcH9VzDRR8WPKOL3D1OOtTj3S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGouSE9uxOFABhpdCV2qaRqmf1U1/Q9+q2D5KnFfjFdDfg5eGw7i+6jaqzM9dvbyj44DPB9/Mkn7AKh1uJVK/3YDBTYsYHBJcbUYPVpMAj0vu3AIaiAG6RefQjl1WqR+3HR7uivciXUkwU3BNV/AzWeGwBGM9zljNZFzxebnAIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m2LJxE4H; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m2LJxE4H"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2db33db4de9so22675ad.0
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 16:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790637393; x=1791242193; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YTzG2AG2lQdERz5R0R9LywAO1UeZk+G4W/mfALEjtno=;
        b=m2LJxE4HP08wk5q3io4Cwyn3hkRVRjb8J0+s52O7wOMhPqMKR9Y4c0IazSj+EswuLU
         tSLRI2xzh/YdMmPU5mciboSpCUcp5ICGvhyKlkWtu96ChyHpyHp4MEA/OLfvs48Ns0Wu
         ZnESabUGadXyAtYsSxjOGNOG6eJdC0SmyhOOkon2XHzy7Hp5Pj0lWL5Sg3OwSYVIX21f
         hPic/bbg11AzZWoDEIFXnsZGQLmQ2BKjPgUGJKBTBRsDmSlc7qQhK85Z1ZpB4ehcMwwB
         3SId3BdHft713OMDfDTn5valX9gRr305+fuydOugNDNVHUT0IJncRfqAKf8QZPyA+REy
         xlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790637393; x=1791242193;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YTzG2AG2lQdERz5R0R9LywAO1UeZk+G4W/mfALEjtno=;
        b=YU13PE5kw9QuYGiaEOkXQNEpOUVlE+DTPJJFc7cv3muXH7Sv+aR82lwYXSPOhYTg3I
         gRlCFsPw1ZvUvlJfWFPOp25Vkyl2G0oPokbotfAgtfkuha2+wvRWXYa6D5J5jV7iPjad
         oQy+9+AJ5jyoEOKwTzF1tWltz+SY1gHt80nsxRSJlTPDSKyzuM1gPwdiX1ClNIYKI+Op
         YY5hSLQefh31WxA1AqLuFjoIRVyw2JgXlzjMHOlQsJaJQUpxqEmrSghIQdXV6KgiFCWx
         cpSZ7mIn8gIzzJSGBzCovn2TVHJq13DZNUGmb8LN/JaRAOI4SJ9l1koynyYWB+bmijO7
         OSdg==
X-Gm-Message-State: AFq9FYLXmMcuJcW9mRCDUFB6IQoan6VX1jzfEfEcTrUfzjeIB6zk6hzk
	Bmn/tp4Ss5Tlh8cAGMu8xr7y+yN3fr0Gml751SbxSMmBOekqkFZyenjnaSMpMqc6mqJtGsBewuN
	qfaDzHa1X
X-Gm-Gg: AYBFou0xXwecSVL0kf8WIjJxOWGnCbZfjhcX2HVlCGKWYMGjOCvLag7tfSvuLIy8DyJ
	eptd2CaKjbVGbI9gJ4j9mC/wE0aDfspKQCvwIViNoKH5biCcXzGuBoHwK0FHdZNcSKnWzVoWT47
	PcGyBZSDXz4Sgzwyq0yfQNULLdZtvv8kNsO2HxiY0Oc6ErWQtmkMrkcpw1etcjuoIOdCeJWfXUR
	ExK2JgwuFGNB7kvCv6Z624pEd6r37w/7M9EC4G7VRI1J19AEbRG8zYDkrbH1W7Quz0mfT35t360
	ZAx8VFDLYxr9C94bNAezD1ukBWUucLEZsCbnEk48dJ2ESsMzO7GLUds0HkR50/jcczjV1ultsuu
	F4oqdBruYMe59Vii8xH44Te+nQkRlwcpLTogdAUk9HKsFXS9nIrtusVyqHiqzHir6b64kfV+5xL
	VSqHKnhcHVs+Pf9s4qE4GLBIWuk23pGUwzsigYSLvJHPOu/LWCjPLg/3XjUrsrAX9RXVDeK7/3m
	c+V6sPnY1BxsZGDJhJMoRd/9/PclIuw7xXuXAe0zhXJB80=
X-Received: by 2002:a17:903:244a:b0:2cf:4353:f117 with SMTP id d9443c01a7336-2e2c5a8e99fmr1398225ad.0.1790637392723;
        Mon, 28 Sep 2026 16:16:32 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a498726d63sm1582327a91.17.2026.09.28.16.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 16:16:32 -0700 (PDT)
Date: Mon, 28 Sep 2026 23:16:25 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v2 2/9] iommupt/kunit: Skip test configs without
 supported features
Message-ID: <arr1SdQI-s46qG20@google.com>
References: <0-v2-563ee63886f0+1209-iommupt_armv8_jgg@nvidia.com>
 <2-v2-563ee63886f0+1209-iommupt_armv8_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v2-563ee63886f0+1209-iommupt_armv8_jgg@nvidia.com>

On Wed, Aug 12, 2026 at 05:09:18PM -0300, Jason Gunthorpe wrote:
> Some of the tests configs can test features we don't currently enable,
> like TTBR1 on ARMv8. Instead of blowing up, skip the test. When
> CONFIG_DEBUG_GENERIC_PT is set all features are force enabled during
> the build so everything can be tested. That is the normal mode for the
> kunit.py runner.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/generic_pt/kunit_iommu.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/generic_pt/kunit_iommu.h b/drivers/iommu/generic_pt/kunit_iommu.h
> index 79d7f9c8e7868f..558e161eacb05f 100644
> --- a/drivers/iommu/generic_pt/kunit_iommu.h
> +++ b/drivers/iommu/generic_pt/kunit_iommu.h
> @@ -134,6 +134,16 @@ static int pt_kunit_priv_init(struct kunit *test, struct kunit_iommu_priv *priv)
>  
>  #ifdef kunit_fmt_cfgs
>  	priv->cfg = kunit_fmt_cfgs[((uintptr_t)test->param_value) - 1];
> +	/*
> +	 * Without CONFIG_DEBUG_GENERIC_PT only the format's compiled-in
> +	 * PT_SUPPORTED_FEATURES are available, so cfgs requesting bits outside
> +	 * that set cannot be tested.
> +	 */
> +	if (priv->cfg.common.features & ~KUNIT_PT_SUPPORTED_FEATURES)
> +		kunit_skip(
> +			test,
> +			"cfg requires features not built into this format (enable CONFIG_DEBUG_GENERIC_PT)");
> +

I can't quite build this as I can't find this macro:

drivers/iommu/generic_pt/fmt/../kunit_iommu.h:129:35: error: use of undeclared identifier 'KUNIT_PT_SUPPORTED_FEATURES'
  129 |         if (priv->cfg.common.features & ~KUNIT_PT_SUPPORTED_FEATURES)
      |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  CC      drivers/tty/tty_port.o
  CC      drivers/clk/clk-fixed-factor.o
  AS      arch/arm64/lib/strrchr.o
1 error generated.
make[5]: *** [drivers/iommu/generic_pt/fmt/Makefile:30: drivers/iommu/generic_pt/fmt/kunit_iommu_armv8.o] Error 1
make[4]: *** [scripts/Makefile.build:551: drivers/iommu/generic_pt/fmt] Error 2

Am I missing a series it was defined in? Can't find anything on lore,
but I did find a commit on your github [1] that is supposed to preclude
this, I guess?

With that dependence defined/linked in the cover letter:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
