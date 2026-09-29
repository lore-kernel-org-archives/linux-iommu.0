Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83511381AF
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 00:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790640130; cv=none; b=iuv2TUjDdE1Gbgt3wNGZWESPAdSMxilebRX1McmjVgRWbZSS0PxueJeUeGoAZPT9juNtQrvY7KuR6iUr0+vki7a1VBr3YMNVzj6B2GM4z8ZDkBjBweXVwPvoFdmZSwU1c1vqGEMTdR3GYGeve+NtWa85hKICx0pfDn5S8ttkEs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790640130; c=relaxed/simple;
	bh=EABWZ24IxIct0Mhf1uXCrghBWDfhCoX7TCulKmtg4xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FikjQ5PNNdkdXRez20VbWeh0Z0TiAhpeMjSRXjh+z7J6d46H2M6/zerP1LzGLjRXn2MZ4aosUW4UEDGwyK8RLHykVwVKSTIr6G+Yu+XPbWbv672tqEyjwCQfA44tjiTpC9sFREOESfV/hma6hm6HNHzDBgGSyex7s5sEvJ8r+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IwobL6nK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IwobL6nK"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so9765ad.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 17:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790640129; x=1791244929; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bl0AjuwmuTt9b9m42lFEHpaVtMv37QnWF5BqITX5uS4=;
        b=IwobL6nKzLdELVZ1cNLIDS/ZdcFtrVhKA7REAmWM1Jmg6juejZx8QqwL0L2kjcjCwu
         Iu3WLMjlu4LTb37PmSSR+FaogniQya+yBBYmViJdOMeNvDrIPAjJD5Vs9yMBei8V2v0L
         768WVbobGv0iLkXaV4nxz7nV1cVMoCuu+O5BgoEt8jNqu6brjm5q72b6+EPoc5TyIodA
         KYRlh1/Bemw7s0PTABzS2uBbZUGc+t/JT8xfhamiveieU4BE5364zuFlauM2Y4/df3DQ
         3X725J3KQvsvVb2XFXCZVpzEntMC1YMnIU8gjzUwJ7IzvvROpXg+cVhemHxsys1LlprM
         +JKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790640129; x=1791244929;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bl0AjuwmuTt9b9m42lFEHpaVtMv37QnWF5BqITX5uS4=;
        b=YA2Vw3DVm7JOCoYxll8T2sxA8/UfTKAbewjgta59TZ9n3s8DuGEFOcrM0aEcXVdt0O
         0rzuliiILyfqjS6r1gTnkqwu1vWMwrku69OU8QulTCJ+Sky9eNUnqoLG52+pIXDSHZd1
         EERe0bZI0JhPG7N76mjVVEhZr5B+Cq6rAil7+CwUXSr6VWqCZX/34e5aDnECyRdHqQsD
         QRmGy531HDXxAPb1gk5aQ3a6g1YdRF9rWpdZo3FzJ63efPim3CvLtGsHXfA6+tDSby2w
         0hw846YFLiEP6+DdvwJbMXu4JojX2KsXAohZ1NkYiKuwR6f4HZzTDxykWoXq1hB15EIv
         LZdw==
X-Forwarded-Encrypted: i=1; AKwUvBz5bnE8fbnt0SobuZRksDg+OAOnn9uQqssaEkf/ucUjjtlcedTy65ffzuUn+2M14j6IOG0iTg==@lists.linux.dev
X-Gm-Message-State: AFq9FYL/SfM5F1z/Ae7zJYPTeaHK1pcRkrnuBHg7taCDDgbKhPvcGkv9
	TRstoiRuA1vPaMudD6TIMNRDCdKbDpnb9k13VB2ojTHjjSnAbOtlcu/EKHZ3Cd78zg==
X-Gm-Gg: AYBFou3aVrB1cfas5bgMcwhUVfP1oF9olSyFbIE8M0g8Ei8uGjAmFfXJtnW8yyg4WlT
	LfhfLqky0jXbH+ArtOjXmNNT2MCq7FcpOQCm3VKyTCvlBtKq8oTvCK7+fHHy/9lku0uhqUw0JTH
	IXeJlJsDXQjRtQenjZrtoZzutmzVtefwDdGo8Qv6s7+gH515My/ALTFUsPcHVRi3kTS5o16rcfU
	p/mIzBGxFh3TwMfDHLGEl6JAqVdSBmJsErzDnklzm73CVPd3I8BVPEfRjt54eOcPLeKAzhyjckQ
	cNgjkFOxthgH3cjmSsAkapXoMWJCevhMInhdm/G8j4tjJpzR1nf6nIi1hJAhZb3xG33KTjGO4CX
	l617bgCMY/MhSqsTTEhDGgAZh8+yZx9U/guJTR334yxFVUz2/NPkzMcc3GEfaqpkoqbNA+uyAPw
	P8rfDwoG/mBU7iEviaDrFdwGJ4gaZlRI0Gz6snEqc2TAjPFb2vDdFq5NGUibIqfHhD8kPdkjRzo
	tvhuqvK2iM4AE5xr5ZnGQOIJx84jaCk59Lr796Qou524kU=
X-Received: by 2002:a17:903:986:b0:2df:8e89:3bff with SMTP id d9443c01a7336-2e2c7ab83e7mr1395595ad.17.1790640127941;
        Mon, 28 Sep 2026 17:02:07 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a498179081sm1843895a91.14.2026.09.28.17.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 17:02:07 -0700 (PDT)
Date: Tue, 29 Sep 2026 00:02:01 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
	nicolinc@nvidia.com
Subject: Re: [PATCH v2 3/5] iommu/arm-smmu-v3-test: Add missing error checks
 for inv array
Message-ID: <arr_-bvl3qGR14BZ@google.com>
References: <20260924085616.300650-1-smostafa@google.com>
 <20260924085616.300650-4-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924085616.300650-4-smostafa@google.com>

On Thu, Sep 24, 2026 at 08:56:14AM +0000, Mostafa Saleh wrote:
> arm_smmu_invs_merge() and arm_smmu_invs_alloc() can return NULL or
> errors which are checked by the driver but not the test.
> 
> Add KUNIT_ASSERT_NOT_ERR_OR_NULL() after calling them to fail the
> test instead of accessing NULL or ERR pointers.
> 
> Fixes: 15a2a5645ad7 ("iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array")
> Reported-by: Sashiko <>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
