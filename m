Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EE7382291
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477932; cv=none; b=rM6s4v9rx+9AquHhyGPDmn7EszNWVZyb2w51iNBza0hfZjSkAuOZIrkeWerxXklsD0yG05HRU2PmCGbEO/mmkGXQODwPOnSi2wFYTY7Jkb2uD84fIx3mr/5SNa9kOQMQqlC82/cyEu+tctppEuxFl5apU+sZqdZZfOnob8CQ79Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477932; c=relaxed/simple;
	bh=aWJJYsImjMlpCgcuTspHg9B1jrZFFSK8m1eqcj4coS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQ+deUS5LiX8/R6fpcIBAn/KjJMP8Vxotdo203ZGgT2Xib8N1NiygUhE74jVuqGFQXTakgyOtf5HjFETB6bkKBrvMvmsrwKtFeEjIIVqTyliSyiz5b7Q9kwg1mOrl8liwhi3k1ucGkfW2TcJ5gxuBPFfM6SNz237hHm8U/20zGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=txQYHfDN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="txQYHfDN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0b1a48855so60205ad.0
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 02:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780477930; x=1781082730; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SX4ayXZOGYaHHJyUgP6DHUBZW5VCIsd9Cb8QwmYDehQ=;
        b=txQYHfDNW0z+HyzHRq4H4Q2bbfJ2lc/Tm8rbpxF2hh4UrthTcyPv9/Xl/KY4RP2kO1
         UT7EAwc9SzuuWiDwQQvtzfWpuoHKJuPWtfjJee0leiQqpGHGKhkSmgrNGE1go8UfbMyz
         OFZVmrQ8292hsor+c9FT4cncjuNgLazncv3c6YGKBovd3egFrxkTQLLNdkHZsxqJv6iQ
         yKGT7WOQG7cCgcSQaCYAFnpE+7RVwjBZ50SKLiRkzEnmqSZVjBExyn+KA18Y5RgrDywt
         AaFV3Kn+xbRcV3THMaq/GyeWiaMJAQ3MNR3BoNKUDcf/fpSuAREF7Q5WkSaQxAakH/Yg
         lPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780477930; x=1781082730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SX4ayXZOGYaHHJyUgP6DHUBZW5VCIsd9Cb8QwmYDehQ=;
        b=GGIG0yAjWE0QM928GkFdLGivm6Ku0lZtvFTashmVLjXPlVcgYbXWtee1g/0vMkVnOo
         ELmLFxeh6kdojNLPF/2WpLylRyRp4aqP48YzakYVs9lXlyrkEuOI3+1JY0E/sbEcgXEq
         FhJZh/oIXCU8kXa7zLzoqDJYneYEXICHUfTNlrg0NdERj3FJc5YJrgnbRmjEIS7tOck4
         fM0mOaao1t4DACKoC3GQzHoXq36X8KxzwXysppbdy27uBh1YxLk68/KskjmxudAT1MYw
         e9f9xQ7mS1u3bVWPMa6qVWr70f1dhK+n+PGWcxH4jCMCxPoWl9i3/2rVNoAiHlZlUWmQ
         5FyQ==
X-Gm-Message-State: AOJu0YyJjX95w4xs/R9FCOf3FDK0HGZC5djLqr6MpsY4oppXIKF9z04m
	45cTqcYujdUHz38F3arVxsdi3zQVTyQdhCryr2Stw9IcEy4IJXoePcCmgGX8C7eDLw==
X-Gm-Gg: Acq92OFNgXL2ar+6RXTnHAJ7P30V4OK/N4207x/sDiZH8EjkE6uoVoB3tVwHJeydFTR
	2YaAdZdpvsQatbXQbLVb7Z4nexJ9A/cvmYkxJ8+84plvAp9lNiPnsLrTqarMKW5ub5IaYR1aqIk
	Nw1J16evEcsJ5i3A7L0o/y4r8uv79+w1HqVNNGeH31ybym3iYMeJR/cFLzG4ZyqjL1aJrcWyNEc
	vGfm0LLCYrDlFo/S3r9Jk6ZS21GRuvm8oWK7XGFk8slkGAtgU6D7/u8nli9/NRYbq+JFaxEh2Eq
	XdMnmkS5ivoAtu/mE196bW8dJ2V0TdlHyGFGemX+/tWN/DmxQyulqX7bU376gNwXL6GQx+sRm9d
	AtyEXSHyyhThY7F/fHpbP4hcVpIDau4dLGoIylagCFqZMY/rU31fdWi6TaG4f5fKaXRIikZYehX
	LsmZcwgtO9136Ar3fFoh4pTIN1IRuIsnXwMXHe+bI2imPHw0aNpDofPWfzMbrK5KPDi2kmIjg=
X-Received: by 2002:a17:902:c405:b0:2bd:5fc9:27b9 with SMTP id d9443c01a7336-2c16fa720bamr937125ad.3.1780477929972;
        Wed, 03 Jun 2026 02:12:09 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad172sm18571895ad.83.2026.06.03.02.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 02:12:09 -0700 (PDT)
Date: Wed, 3 Jun 2026 09:12:03 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v7 4/5] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Message-ID: <ah_v48zPNHoZb8D9@google.com>
References: <20260601143644.2358771-1-praan@google.com>
 <20260601143644.2358771-5-praan@google.com>
 <DM6PR11MB3690D6851AE3354AC55CA2368C132@DM6PR11MB3690.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3690D6851AE3354AC55CA2368C132@DM6PR11MB3690.namprd11.prod.outlook.com>

On Wed, Jun 03, 2026 at 07:34:14AM +0000, Tian, Kevin wrote:
> > From: Pranjal Shrivastava <praan@google.com>
> > Sent: Monday, June 1, 2026 10:37 PM
> > 
> > Update arm_smmu_enable_ats() to wrap the pci_enable_ats() call in
> > WARN_ON(). Since probe-time checks now preclude configuration errors
> > any failure during hardware enablement is considered a kernel bug.
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 54c7f1ae3a84..dfb2b0d2d2a5 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -2956,7 +2956,12 @@ static void arm_smmu_enable_ats(struct
> > arm_smmu_master *master)
> >  	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
> >  	 */
> >  	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
> > -	if (pci_enable_ats(pdev, stu))
> > +
> > +	 /*
> > +	  * Since pci_prepare_ats() has already verified the HW capability
> > +	  * and programmed the STE, pci_enable_ats() should not fail here.
> > +	  */
> > +	if (WARN_ON(pci_enable_ats(pdev, stu)))
> >  		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n",
> > stu);
> >  }
> > 
> 
> looks smmu driver doesn't check return value of pci_prepare_ats() too.

It does check the reval of pci_prepare_ats() now with the a recent 
patch [1] (merged in Joerg's tree) that adds a new 
"arm_smmu_master_prepare_ats" helper function.

Thanks,
Praan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git/commit/?h=core&id=5ff98a0da6b48d8722eac0080e4185c417925d05
