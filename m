Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481CC339383
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 00:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640047; cv=none; b=jYbHoVMX1344g+Egq2sUdjP3uGj8BU2hdh05Uj79RSqqL6xhn4QmJFbilENyetrXBeF9G3/+sNA/9wLx8OJ6cKzb1gSHd562VM63LPJZhMfna36x6NpxlhHzqexuVwjzsKK/AhBKRVHtuI2OLGPXoKV4C2BOEODW2Dbtnjrv7/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640047; c=relaxed/simple;
	bh=icFQDtMBWHvhzEuFV6Sw9+Gnf9f+xqXBwwTEeaepzbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icJnlYnfckdBga+APn78+CxrL2zc0Av3VGEowNKc8xLdfUG0ZJQjCGRMa8MRo545/bgp7yIdIviDk26Q12e+wY1Ufop1nN0EcNGRzssljMIBBAOYOKTFL5/BsOAfl/NWbOF9b99GUIWFAxN+2tzZuxid3fAahHv5pqXLevhD3iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZKwZrHBI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZKwZrHBI"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d8facae850so18425ad.0
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 17:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790640046; x=1791244846; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=65cGZDz7HoPxstY7x2L7my2DOQ4uQMu696sLtL8irMg=;
        b=ZKwZrHBIxVHaMjsXKbnZqzkFnFD1O1mTsm6Bjs1intRvFJ/EkvV4EhzV0eIgAzeRNm
         oSWMtbJyPe7uloiMjOmKzulN9O3TuYCtp+YoEOVqQStVu1YEETBmntgMywW+pV/wnlY5
         3SDSmvqoG/beK/DMIOvigdIE/v06XP/d0/+lOv2tdxQYozvMRrcxp2DoyiWIjtrsHvH1
         lcFTzRNzr809KjtWeIPDQjT7Sn/VREqZlyRhzqBEyTFjCFQtS32SnXxb7FFvsd0D1dCx
         lhenJeJvKu7TDkz8/BzL7Eq0D93cp7QC9T60BgeWqnfcljPRdUJF0uCzWM7DQhU5kdXT
         MUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790640046; x=1791244846;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=65cGZDz7HoPxstY7x2L7my2DOQ4uQMu696sLtL8irMg=;
        b=qLzZ2mmdhc+bzoBuKvnujfoswwC2HL2xpbtxD6LwvhA+HVUwbe7BGf2Zr2++wHHPoI
         jzGh0iqYzffkba7xnHwkow8CMXxZTUa9MF/hU74ijGXxaAfUKbQoabsauvm6UyvIXZpp
         vqEa1yeqjXxB0xQnu3OOoSL84CsTTm4x9ZTfCRa25P+KAEWgduUEanW2aSjuVmaO3Wka
         2OVPhEo8BykDmntts6uJ+lFYTr8GWs17Akq6RBlXIPMWVVssFJD+UvlA6qcYsB41YxUV
         mbXENq7dHoBHcPfRUniRsmDq5D47dVCU/Rj+f0P2k6Zd7keJ5YSnLL6pf8d9Bod6PW4X
         GbOg==
X-Forwarded-Encrypted: i=1; AKwUvByGoqpxKGbbrV228p8/AoVdLSFE1kVuTYcbrap4gsB2Z0Ih/dVgyRt0txzsr6G2Wz968/CNlg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIpphqEjqS6T7IgUEZUllp6cjGDIFyyod/ATWta6pfk3cLsj6b1
	6eUfaCR5Z2sbbdn8KWtcfWZdccn9XEagS8AmOc5fdxeZdTq/6Qu6u4Y2Hlk7X7y71A==
X-Gm-Gg: AYBFou1V+Re9ucdXdDAuBw0J5Jgg43StnFMXEjEwVdZnPP5KXmqM9SAwtElPOyd2ko3
	X3hTiev3FT2Ma+cvPl2ggpe2HAoRW6fc+f4r1aIpYeFLwGueQmFVD8KqMUGL2lQAPGWLvxenvb/
	DzN3GEx5Ahoq4FqT5Zb40wl00iSZ8NyMxyMxlvloEXl/XRHHKUuwfxk5draTu6Hq0SKgtXz1tvo
	soNb+Fcx6MrBdCfO8TVqVlo3spdIi5zohVny6kO4Jaxft833ox63BAPEdkF02vLCZ3ZH+w8Jx2f
	pHWXlpQTErO0etMC2nw1tz/9DKe3KCbFDzkjE9iixmygxsm775sWuVhMRN9gChks1eIk2HeyuGQ
	Y3gRqSnuy+Q3gjWR6wUHhk1ThdCE0BQI2D7xLBpnH4/C6jNjlsl/wKtpJawWUkmu/rQwTj2xSEA
	59uwTbomDZ8R6NA5OX/A71kAg07dYUV5oD+b67dbnBYArqUOLGvp+w6oToQf6w5eNSRhK0UrJmh
	jWb47kU4elH0n6SHZX//NL4FMK2Y7//VzmNDPBAhFNoUr7a7oChVM+yDFM=
X-Received: by 2002:a17:903:26c6:b0:2d7:1cc3:a69c with SMTP id d9443c01a7336-2e2c7a664e1mr1000575ad.7.1790640044876;
        Mon, 28 Sep 2026 17:00:44 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9143a3aasm47233445ad.53.2026.09.28.17.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 17:00:44 -0700 (PDT)
Date: Tue, 29 Sep 2026 00:00:39 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
	nicolinc@nvidia.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 2/5] iommu/arm-smmu-v3-test: Fix
 arm_smmu_v3_test_debug_print_used_bits()
Message-ID: <arr_pyGyKNH7Fbqb@google.com>
References: <20260924085616.300650-1-smostafa@google.com>
 <20260924085616.300650-3-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924085616.300650-3-smostafa@google.com>

On Thu, Sep 24, 2026 at 08:56:13AM +0000, Mostafa Saleh wrote:
> arm_smmu_v3_test_debug_print_used_bits() hardcodes arm_smmu_get_ste_used()
> instead of using the provided writer->ops->get_used() callback.
> This caused Context Descriptors to be incorrectly parsed as STEs.
> 
> Fixes: 56e1a4cc2588 ("iommu/arm-smmu-v3: Add unit tests for arm_smmu_write_entry")
> Reported-by: Sashiko <>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
