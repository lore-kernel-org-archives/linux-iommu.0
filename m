Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0450D1CD06
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137088; cv=none; b=k95ya51ml/P7gjHU0KmfKEX6UQIBmq+oQADq9DvDQsn6DBDip1TuGG5pkyANNSn85sqk5MCB5LD5DsMI+tkRQlvOQXOV+y4pxfddcC/UMneHBSnGqlV/qee12EB+4hN27D3ZP4zJnnBNEd9hi6O9RPvVFN/+2oYStfWIVou4Ih0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137088; c=relaxed/simple;
	bh=ktk5uls8+VQKen6nzE+FFUqKq6RxsIWtcJ3E+R5lRY0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ddVhBVJtebUY96ZiHmicI/EI76IkgY1vhdkzdi5mp45JLVIRcsFh3a7yMQZWp1fLlUliEwkZAk1PMlTyfiMl8CgHBrYJwSt0CalHgKYKowjuubwqB3R6UCjDzh1DihJxf0vOMjCzVNM2poIxmZI51KT7liD6DjhPf1uhxRlfZ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SfgI6dya; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SfgI6dya"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so6170916a12.2
        for <iommu@lists.linux.dev>; Mon, 05 Feb 2024 04:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707137085; x=1707741885; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AEEyQX8Zrc0nz3qhc1w4P/1GQXWcIBKqImTSuFhzWD8=;
        b=SfgI6dyagItOkg39IuNGe9srOWIAiX3tgw6pR3055oDEYTTw6GYFp9Al0AaSZPtui/
         +oR8qmhX1RE5GOcp/ozP8PBgoDgDnyq9t7Bh/Tx4Pg6eVz49MHNmsy4mP4gdB76AqFG+
         h7K1mZ+mwn1yTxndK+TNngunyQcw+1v6GuhxBtjLr50opANUDTJG/nLAZFxax7RXQHfr
         TndaVjmfDfbzXloEKLQFJrB+mCyZyeZrvAxWWnet2QdPFs07P1r3HzrRmgRgrO8yPwRf
         1TC0zgHhaOV5MsklM6otx8c/pO37gZoaD9RQmnTiZq8BdqKSOdx2ZR4gBei7QNDtmEfg
         VSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137085; x=1707741885;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEEyQX8Zrc0nz3qhc1w4P/1GQXWcIBKqImTSuFhzWD8=;
        b=Ge8+oBkYZJnh26sQZwFBZfzIsiqv40M2QTBJ1JnSHyl1iGjIiNmU628y8GVYTNEXwk
         7QeXc32jhm0lyznnrdJXRX9WFlU6Z+HaCrorm+7J92XVKzVTRmovNK3A1MKcN/+Ts8pz
         U3nBntj+sULVv5Z0aQUUCPvDDGrhSAoJBrHUEvxjD4T2Jy73RP4kRKv059JrayaeKcMG
         fDz3nvH3oJHqIm2y3mTTpzrLiJPGu6znMHJk61Yk91a3P3VjnhA6Qye4hVhMEdEvqoFn
         9Ku6l51R6lKDQsY3Mq1K2yo1la9Vd1yaHX759wAREnnddME4YnODXTyPQkCxUYrutx32
         sgnA==
X-Gm-Message-State: AOJu0YzEu2AEvHUrnXg3yzoFHl0IjVMY0b1kkBKfJDGIAdPUdDHZgxI2
	ZlAwdB5R+f0vK5j/lrvMeg4YaBCVb80blMp92RFU2tkCU/bsiegRUVT/70X91G8=
X-Google-Smtp-Source: AGHT+IGaUOYwkGGdNx1nXaNoarcUdB6uE0bLX9IJsGoVG9MhixiJrglo/2qu2wW502ka4Kp3rfTA9w==
X-Received: by 2002:a17:906:338c:b0:a36:95cd:5e64 with SMTP id v12-20020a170906338c00b00a3695cd5e64mr6665721eja.62.1707137085213;
        Mon, 05 Feb 2024 04:44:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWM6VkVU2kPSsnXCk1Ij3OelUa80AJ0anA6BRRR6UnJetybzQSeJ8ZFVrcHPyTFUSG9QicPB/4O+fdRTR0X+mrRq21OnpHoExw=
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906640d00b00a35d7b6cb63sm4262363ejm.28.2024.02.05.04.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:44:44 -0800 (PST)
Date: Mon, 5 Feb 2024 15:44:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: ashish.kalra@amd.com
Cc: iommu@lists.linux.dev
Subject: [bug report] iommu/amd: Clean up RMP entries for IOMMU pages during
 SNP shutdown
Message-ID: <1be69f6a-e7e1-45f9-9a74-b2550344f3fd@moroto.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Ashish Kalra,

The patch f366a8dac1b8: "iommu/amd: Clean up RMP entries for IOMMU
pages during SNP shutdown" from Jan 25, 2024 (linux-next), leads to
the following Smatch static checker warning:

	drivers/iommu/amd/init.c:3820 iommu_page_make_shared()
	error: uninitialized symbol 'assigned'.

drivers/iommu/amd/init.c
    3803 static int iommu_page_make_shared(void *page)
    3804 {
    3805         unsigned long paddr, pfn;
    3806 
    3807         paddr = iommu_virt_to_phys(page);
    3808         /* Cbit maybe set in the paddr */
    3809         pfn = __sme_clr(paddr) >> PAGE_SHIFT;
    3810 
    3811         if (!(pfn % PTRS_PER_PMD)) {
    3812                 int ret, level;
    3813                 bool assigned;
    3814 
    3815                 ret = snp_lookup_rmpentry(pfn, &assigned, &level);
    3816                 if (ret)
    3817                         pr_warn("IOMMU PFN %lx RMP lookup failed, ret %d\n",
    3818                                 pfn, ret);
    3819 
--> 3820                 if (!assigned)

assigned is uninitialized if snp_lookup_rmpentry() fails.

    3821                         pr_warn("IOMMU PFN %lx not assigned in RMP table\n",
    3822                                 pfn);
    3823 
    3824                 if (level > PG_LEVEL_4K) {
    3825                         ret = psmash(pfn);
    3826                         if (ret) {
    3827                                 pr_warn("IOMMU PFN %lx had a huge RMP entry, but attempted psmash failed, ret: %d, level: %d\n",
    3828                                         pfn, ret, level);
    3829                         }
    3830                 }
    3831         }
    3832 
    3833         return rmp_make_shared(pfn, PG_LEVEL_4K);
    3834 }

regards,
dan carpenter
