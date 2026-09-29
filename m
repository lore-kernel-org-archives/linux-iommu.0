Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC049620
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 00:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640163; cv=none; b=Nx+9RypigQ7GO857Jfv2tmRIrs0QkGEWPe9IinqhoF4yjfNAIGxSyko1V5mNKL641qgd/U8Ksq5r+PqcmThkHvU7xSMFFjmdw0ixazMdDiqjagTpWEfPWXlPweibv2DZISrc6MHf+HE0mWaQJgaN2a6OA7IF1aB8l6/Gv7EamzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640163; c=relaxed/simple;
	bh=qCF4YDD/XsuzUV4vVc2CamBK9oEkCoUqKNTtLhL93p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3FPMYgiZDxsJVrWLEuywayUZVEuQyPKRAYDU0H5T6a+CPHM82uGMj6LXlIn6cxHdGGO04IXTSvRARRwLagj6i/nXGwwzujKvRlHzPgvIVMSCBYYaZdAiS7q2uN0VCP9568OoC0OSxuuXN1TNOrfOeME4XVKMTTAhMMxCELb+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2Nw43fl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2Nw43fl"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d8facae850so18565ad.0
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 17:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790640162; x=1791244962; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DCH2PLXbYkrNsME+2zyrKMJYI/Q00cD/tf6UVMp0Gq8=;
        b=I2Nw43flud/arlYbprkcrvRkDNVlogHBQbYOa2oad0MXjKeD2HjcG0Uh83AS8BPq9H
         DvqjQ3JofBtWjopsottWx5RZmeGgAiLbLjalHA3OYVztWGIHjZJ+r7PSQGKKT7wfjEsa
         4uknxcY8d62B1c2UX7N2IkmYItCOntETwlpbthUs/oE7c3x9TKnCh0qO77u4lDbY5nzs
         Jhzi2wWWlmjfjNvtQqK1p53XURxwVvDEPtyc73QrgbCdSHySaDAh6yk0AYVAVo1baCTq
         1SATAkjt+iDkF/6SbYxM6TLHo83aoAe0zMNzJvP1U9E7mBQ95Mc/qJ1tX+GpVgn3matU
         bdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790640162; x=1791244962;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DCH2PLXbYkrNsME+2zyrKMJYI/Q00cD/tf6UVMp0Gq8=;
        b=f6Kj68xaoAEMZlVEwqP/VrAKfFVIhL6Bzx2v2TmvA6U0aUSesUh8WC3BCYrCRz/NxW
         TzwqU0hWBF/5w5/QEGUU9Qm/rGOWwDArqZmkso5yKxkodX2g7g9Y6zQ+UbXZj1AiDOr0
         btiyf+ftyF39LuZL6OOhjohVomHjZ+mWj+9XwPnwNcKl4B83GCoHWCPl4wuEVatyv0iI
         IOZ+MCXrRseGaFVdwQ7g5GwvUSAJReNyyOjS7hB4s/fFhkncV5dITbwXAXMYpaBQcGIX
         PfVr0NT0r8wUTDGmd/RNaAuTsmPNWRBmu/+obb9LNiYKLhmyNA8Rv/ay5Bar/eTegmAL
         JAEw==
X-Forwarded-Encrypted: i=1; AKwUvBxNrUMyzjf14H9BK/IQdzgfwQWgNux3fuqixWUn0Ke737sh31o8Wh0/SSxwQLfcCRufyTq1kw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJSDt5R7pdXI3Twy17CeTXwceKoRBdAHx21yIBvYI/YLODUCL9U
	WYU7KDX9Reid2f1dREJPidPiEexsS2DgiHOkRTg9eheEMaRyPwJ4pfgncUwTiQjhYg==
X-Gm-Gg: AYBFou2qmyCo5xxidhqCyYsSOk1p08sLSuF5QyuMdN60vjU2L1XDBLSLHwe3stgTIrp
	XDgbuSPhGm9OqnLdYG7BGr3kXVPRrJK6JFu6H/Yov94bYPsMcWOpRMxM6SheILLm/Ff53m4P072
	FgzL6D7aps6/hj5uU5tGzTgDJYbdYM1czRI78BIHZcCnTySpsvps/BLXdYwR+VUtQwQXTjIr8N0
	6KDd8neQlnP6o95w86B3pcyWh8oCbj/2xpW9mFnZM+GnSidDXmjdEQfP5fbd1qU0IlA8POUUVvw
	O/2IhDkRMNAOVDKL3a/RNZU5dvaHcMHLqhRHnr0hDYsjrUUNZ1LqvT5Ymgz1G/PeTOohpWHf3Mo
	wi3PG6EwiajD2+FLd7dVpft7rQPf+eXpSoxZa4+lo/xg6XSBxm1xi4CqjYZrv6/4BLD9CiviDJ4
	qmEF27oIdN5hw7lZ8iifGDjRVf9fcAvkyeziIOwNx8ljFZsGjkqyiSSwnEvnIiix/5cXgLayXlt
	OoOypcVpyLO5H3GORZ0tpk8qoI1xPCS7CI8BoGvEkqp44g=
X-Received: by 2002:a17:902:ce10:b0:2b9:e831:5e5c with SMTP id d9443c01a7336-2e2c6307fbdmr1665605ad.4.1790640161333;
        Mon, 28 Sep 2026 17:02:41 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea18ff85sm4796244b3a.19.2026.09.28.17.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 17:02:40 -0700 (PDT)
Date: Tue, 29 Sep 2026 00:02:35 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
	nicolinc@nvidia.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 4/5] iommu/arm-smmu-v3-test: Fix OOB in
 arm_smmu_v3_invs_test_verify()
Message-ID: <arsAGwY09NywKcqK@google.com>
References: <20260924085616.300650-1-smostafa@google.com>
 <20260924085616.300650-5-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924085616.300650-5-smostafa@google.com>

On Thu, Sep 24, 2026 at 08:56:15AM +0000, Mostafa Saleh wrote:
> arm_smmu_v3_invs_test_verify() validates the array bounds using
> KUNIT_EXPECT_EQ(), which triggers a failure and continues execution.
> If invs->num_invs was smaller than expected, the next loop over
> num_invs would blindly read past the end of the invs->inv[] array.
> Switch to KUNIT_ASSERT_EQ() to fail and stop the test on bound errors.
> 
> Fixes: 15a2a5645ad7 ("iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array")
> Reported-by: Sashiko <>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> index 366dcb2b5554..244cf34e5a0b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> @@ -643,7 +643,7 @@ static void arm_smmu_v3_invs_test_verify(struct kunit *test,
>  					 const int *ids, const int *users,
>  					 const int *ssids)
>  {
> -	KUNIT_EXPECT_EQ(test, invs->num_invs, num_invs);
> +	KUNIT_ASSERT_EQ(test, invs->num_invs, num_invs);
>  	KUNIT_EXPECT_EQ(test, invs->num_trashes, num_trashes);
>  	while (num_invs--) {
>  		KUNIT_EXPECT_EQ(test, invs->inv[num_invs].id, ids[num_invs]);
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
> 
