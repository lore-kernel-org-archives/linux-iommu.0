Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118EB359A89
	for <iommu@lists.linux.dev>; Mon,  2 Mar 2026 23:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772495839; cv=none; b=hGrvTFbtog9eKTny/1MmmbsYl9TbTJKtHe8EXu3G0luaL6lcx12CIlnm9W12KNIalJ8wYXIiHbjjAUuCx2C7/hCN5M5FJCiegz3FpV+P+m7dfNWbJ6n6LYjehyoIhA6Bj9lnFctbFpI78MAL2xrbs+w2VqTCk5VHWbKoUPN3yqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772495839; c=relaxed/simple;
	bh=XOwQp8fCxwZrnpIAWNzpylcuQiqhpJOOIiqIw5Eykfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMpJGA3XF0w3YQEowfFuKZv2c/74mlxg6KS2lfxOSMR8I82Mu36Uanr9bXNBRwSEAknzeHC6DkcuESkReHAEprGEYzrGJ3K+ZE1A4x2fVLioSJ0+ULAJXXcU22LlEvB0qczxPkT5POEXdioptffn1NvaDRY92EQdRt4fBEwS9ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QfjFi+Vl; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QfjFi+Vl"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb39647a70so477014585a.0
        for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 15:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772495837; x=1773100637; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CvSEJRddK/yo1S/jf5w9749iA+Xc3WpWghb+BuNpnnc=;
        b=QfjFi+VlsPl4XJZLw287NCZ6D+FynIWaTqyBOe3qLZNqs/f1Q1N0/H219TY6LBAGo8
         GrHaUnCwC9P3wB6C37IpCgTvpWqXYOOuAJQiu7zUfc0UbVGlzdKBmRHbXeq7ZDeFx9Dw
         GGZn1uoMyTvH6NQRQ4Wwk7Z2jBzqVAx4CQL+FGsdt399VJ4gpWs4ZvuGEgzbWGkTN9wK
         zWY11EUUOZLNPntdkgoXgL52qfdskH2PEKS3rCJa/dKBV2evrg9Pu5kE9cmOQTckXb1a
         Ej4/maPsxX94kSzhOSicuuQiA7gbykvKaA6Gmh5hN4Honk/5kezwe1ZG4XOZGROgh3Lb
         sIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772495837; x=1773100637;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvSEJRddK/yo1S/jf5w9749iA+Xc3WpWghb+BuNpnnc=;
        b=lF+n8RsZ8xTW+aQAzHDAHDI/AnyNGCtBGYMPq0qHSGWha9PFurMkSmxRDQJypt8nml
         ijYkarS4Y4mrb8o4glb8zDaop8iY83NWRBVVnOI1a+5awG6Cqp1spbd9jR3zX46rk2QQ
         B3loA8q9YVAGdj/U4u0t+hL3JYJ+ZAWfXEPAo71JFSUNdOb5UYSzJ3NglVEQdATJNq4V
         dgpt6VEqDvW0Cz3Os+f9IOUjmikV0LZgR0rHStlpYLBfcf6A8qVwoK4O0HdwifI6dDld
         w5E36+vBCSvriD+bkcyHJWFLmTVQiR0LZynEbD9WdH4ai0H1L2vRfqLNCPtSg3my+BVS
         JwlQ==
X-Gm-Message-State: AOJu0YyrVHtlXdYuJWe7/EJdgG1juUwNlWzqKftRi8WHQGTjZY8NgedL
	tLWRs+Y8wPDI2qK9GhVufpmJwIEFealVaL0E3IBRD0BY9K0hkToeAh4KaUkSZiw7gpI=
X-Gm-Gg: ATEYQzy6CzhLCURHBKH2SX6h5KBqEH8Jjc/HusfqJIGnpVyTFSEnJZzEleaL3cdyps8
	Msv1hSU0+gQkClaxJd6D2L818E/fQPLCtzjiLyJHAylhAQRH3J4bRJR8g6Nftak0x4l7oDOHcsW
	jmDHwt/7la5U6zEHB4zTyop4fG0XJq7gn8xGyWk8LMu7qOd9W+J0UtYG+fosEM6N3fX29br9/Yl
	zhf75ETp94inAu09zHO4PsOrwC3++WR1GVhyx8VQkXMCAltQh9tiQIKKHMCaSoxmNeItnKUFwPw
	yBX8yzYdLvsQzM0+32uCibJV1srj1ED44V6zzQIPMApt2u7Sfb2KRfMRinJazeynmO8wLzcyW9R
	Ft9c70Y21ExMkMbAsKI3WsDBU8kET/QNRFcfADRnBY+9JPBFB68wz/0aNgOH4sLyo8grRwRCf+7
	HQKksRpFM9sRC+Zt+bNikEwda6UtRKp+LZwT17yriPK2/ecPAHNiCHRclcYIqsXGLyRjbayvzez
	td6kayk
X-Received: by 2002:a05:620a:4892:b0:8cb:71d4:d0fb with SMTP id af79cd13be357-8cbc8da54damr1643140185a.36.1772495836854;
        Mon, 02 Mar 2026 15:57:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf71ac86sm1260829385a.40.2026.03.02.15.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 15:57:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vxD8V-00000003wco-2EQO;
	Mon, 02 Mar 2026 19:57:15 -0400
Date: Mon, 2 Mar 2026 19:57:15 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, vasant.hegde@amd.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Adhere to IVINFO[VASIZE] for address limits
Message-ID: <20260302235715.GY44359@ziepe.ca>
References: <cf1a1e3d96c3571ac5caa528caa84751d40be1bc.1772208939.git.Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf1a1e3d96c3571ac5caa528caa84751d40be1bc.1772208939.git.Ankit.Soni@amd.com>

On Fri, Feb 27, 2026 at 04:58:04PM +0000, Ankit Soni wrote:
> +static u8 ivinfo_vasize_bits(void)
> +{
> +	u8 vasize;
> +
> +	vasize = FIELD_GET(IOMMU_IVINFO_VASIZE, amd_iommu_ivinfo);
> +
> +	/*
> +	 * IVINFO[VASIZE] encodes the log2 of the maximum virtual address
> +	 * processed by the IOMMU.
> +	 */
> +	switch (vasize) {
> +	case 32:
> +	case 40:
> +	case 48:
> +	case 64:
> +		return vasize;
> +	default:
> +		pr_warn_once("IVRS: IVINFO[VASIZE]=0x%x is invalid, defaulting to 64‑bit VA\n",
> +			     vasize);
> +		return 64;

Why check and limit it like this? 

> -	cfg.common.hw_max_vasz_lg2 =
> -		min(64, (amd_iommu_hpt_level - 1) * 9 + 21);
> +	cfg.common.hw_max_vasz_lg2 = amd_iommu_hpt_vasize;

This has no restriction, you can send it whatever size you want.

Shouldn't the v2 side respect this too? If there is some reason why
not it would be good to include it in a comment.

Jason
