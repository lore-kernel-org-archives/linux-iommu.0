Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D852D1FCF41
	for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363227; cv=none; b=m6o7L5ZgdB04V52r6pNVKWudhNCA6YhW5x5ROmqAGPqhPZZxDs7kgEBqo0R71l4LVlzI04j84xDlAtVC5PugdbBiL4cTUts/k3pAkA64q4Z14LtCGwCZugwlkU608tkklPPZwox3a9tMo2patViOL9u6/gHExPxjDAfXoUKwQjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363227; c=relaxed/simple;
	bh=iDX+GOiJ6TCs1UpxSiq/4pzSZTQS1uP2AgzGAapeeqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1Nmr5XXHDFcGzM0m3IgkW1FAz684N2OAsIpGmSu+Z2KpMo1Z4bmxUcXlrI8vF43g5hxelOr4Z/tdoEVTQ3n0JwECcQWb1VPsG04pwu0HxSBSM4jdxRFPYmTBivgEKSyle0b82xg6ASLoByfNs3xoZgT4LSpNziM/G+e+xAvo1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VmyRYPRU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VmyRYPRU"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aeab6ff148so80355ad.1
        for <iommu@lists.linux.dev>; Tue, 24 Mar 2026 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774363224; x=1774968024; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OIVar2XSUD8cxHHwMjaGV6t1yc3VT/8+s3ndQMtgs74=;
        b=VmyRYPRUa9jwjIy1Os0veATREhsiRosmcVoOu6/ZlL1mKGL+ckTyE6d3Yt8eFsLgHn
         6dHQSrU1zzAySgRV1r4S/QfAdjQf/nOhTC/I1b9AgKJqTPqInbV8LoLAQMsX2sJzLG7e
         afkHktWQvD2Fqj18HEkwbi5zowI22EUNoxFTpqbjxNsILrsIyqj2JfBs0iZnmPVfWxn5
         7aqjjjdLG+3QnBgURnkmIoBtwzBlO/4vLMR50i03HhP1eRTIevCz3kPuaonMInX8jXVe
         kN8CdHESIo3ngwHMZSonGgMe2850FDBsQYhPB2of4nQvykTdH7Q/Ojj9CmrXMfsw8mtf
         z7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774363224; x=1774968024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIVar2XSUD8cxHHwMjaGV6t1yc3VT/8+s3ndQMtgs74=;
        b=T2OJKod1y4A1AUGJOcXMAcIHT/tjVJ5+B7cIZ0ufPh6lMYmCvIO4zpbOsDMS3q+eHv
         lDsflQvnPf5+z8GoTzrzuPz4Z4NI/Btl7GW6u27S8mde1WhrqcKAWfv5oF4vlmGu+Bq9
         a8rM0+TOMfKh/7dsBHMLgbJqgwPxCW/20gu2VKjL7VfXGxU1aa2ZdOCW982eFnHqLZ96
         GNK64kvb1H2fUTIyiCTzQzx9t1u5oGDmpXOtbBBZrMYldsbjVPp464os4Vxw2y3JyVhW
         7I/8X5YKQLoA1ai0ciVtH4bzFIHs1W2o4iBJDDS77nacFawRxTGKm1GtwEjX0aEv4+/M
         5/dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFghFm1lwGc/yh4L12hCpmX2XqwdnYqpaiZWRYQLidWaMLH/ieukhr2dA99FgrtBJXXchc2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzH4GmaNc6tXDPamCHxdQT9oDxkEpiZuIoOdLK0e0JsjFFqvVTI
	j9M9bxfn/HSPC5iYYqxVHV8ILn62kyHrh9sP4dTHiYEatqkszORSikA+Abt4GjCeZg==
X-Gm-Gg: ATEYQzwyVptn0dx2HyXggDFAT3nmGFUlj5WgMTi56TlWYuzP0ZgMCoIsS3Nu6C9IQer
	oD3ygpa0P7IiLgZ1fkzCYixS/hfgyYBmS0JK8e0F55gTS7iNsOf3eImR07koT7ZcNNOwkyhatSC
	5F3TVx9VYlOjtO9YRSA4NMDe558pxd9bSGcyW6hB5hl8I0R72Y5PE920zLoYppRmY2wQrAmP3Il
	GdEQbZ9/36xJnm6lHEPdQADYkv2v3HnkjmON9+TJa4GMAhj0PLbfGoy1PtIyzqyDJ9kVte4olgp
	qN/RTbE2bz2YxZjiAl76BDRsAkgGWLgb5sEuDiddW9bkZjqV0+z9w11NCIE4uAPafuFZeZHR1qv
	hNdC+/xGQ7scYZqzEFI3wui8ZlK0FsqdISpNN9oVoiHLy4nU4q7QkE3ktG9TBbhIE8uJVc2Si5G
	ANVQYzh/XTAfdcC6T2rtVurhN0+bZdykidGE/wkZgmRWRx/4TX2kqRZLwORQ==
X-Received: by 2002:a17:902:f652:b0:2ae:575b:2345 with SMTP id d9443c01a7336-2b0a6707a09mr2261445ad.9.1774363223664;
        Tue, 24 Mar 2026 07:40:23 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0ac5b287sm719016a91.4.2026.03.24.07.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 07:40:23 -0700 (PDT)
Date: Tue, 24 Mar 2026 14:40:18 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Do not continue in
 __arm_smmu_domain_inv_range()
Message-ID: <acKiUrnbe5ZGvPIl@google.com>
References: <20260321225041.11090-1-nicolinc@nvidia.com>
 <20260321225041.11090-2-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321225041.11090-2-nicolinc@nvidia.com>

On Sat, Mar 21, 2026 at 03:50:40PM -0700, Nicolin Chen wrote:
> The loop in the __arm_smmu_domain_inv_range() is a while loop, not a for
> loop. So, using "continue" is wrong that would fail to move the needle.
> 
> Meanwhile, though the current command is skipped, the batch still has to
> go through arm_smmu_invs_end_batch() to be issued accordingly.
> 
> Thus, use "break" to fix the issue.
> 
> Fixes: 587bb3e56a2c ("iommu/arm-smmu-v3: Add arm_smmu_invs based arm_smmu_domain_inv_range()")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
