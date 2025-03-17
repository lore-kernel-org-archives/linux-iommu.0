Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFD214A4C6
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742193775; cv=none; b=rh9FFQnlRoqkkjtSJPVMV5Hvlkk6aC76B5JVo/2eEytNRfZnX1wPRUHuVqSW/4S+hGt7RQtagSoxckag7vLxIVgbjM4Vz+AoBPe0cItfq+X2gEvITpIhDNvysvM8qZdIL7A9UoXeKI9sLCma73gOx4FSsH+0UHDUEUfr5Mzko2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742193775; c=relaxed/simple;
	bh=tmuz3S8QS2CK1Do0ifyQigpJ/ofdqUE49XrcsC1JGjo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lFBT3LPyhujsnwZvXZGNHxGsnzUb0f9WKC7IetOyOLp0JGz9/vOZTuDpaeEa27OgSz4FQLwnO1e2c1BdyhHcHDkPBWRWIq3Oh2N4onWFygDdIR8dZemXJmSGnEfEIzLWr1ABv72tiK1VhTbXm3lMPY3tTyibV+AGW0fcBajz1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ViCMEaaG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ViCMEaaG"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso17252785e9.0
        for <iommu@lists.linux.dev>; Sun, 16 Mar 2025 23:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742193772; x=1742798572; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F5FewJ6YzHvRF4+9HsRWOweevFbmaLN9395N1HxAjAI=;
        b=ViCMEaaGFdMlXhQxDA5nomatDouGgzl2eXoGD7SrH1Y4Ztz/bgHeB9yhr44TvCSvg0
         JfF9YNZUKhPfuV8KV3OqR0tM3lMp0AgGFjqpbhnSzimNeESZOGIJpBnJiGlcEsUqioJ/
         FpbTEE9QGeg1v6vaW4RjTdDS2xuFaGjqV3ktrmpbRT8G3bUI/s0Xc77k6WyXH5KXTQbI
         lbLcFhIamKW3a9Sc70gngqcRWYnnNy661adW/+cDqMdXJq+Hq0qdRYNfRNBjVNpPbTP9
         10ZsAv5yJvLj4f41aNbQBZRwiyXjFDUKeP26j2vk2bNvABJvT2b8uKt9/mSKX1b8vOaF
         lhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742193772; x=1742798572;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5FewJ6YzHvRF4+9HsRWOweevFbmaLN9395N1HxAjAI=;
        b=P+LkMB7OiC+mjBRpEj9nJbvSzbbC1vyjpGY1idQtQRWqix3KlYEWby+NJyk5YyMzhy
         NBPqrid0ATg/OKvpNMGjJbQtsueXehN4LLVi1gBm/jVlrrR8GdJdxAgdyLt4lkailmfT
         46NiDzNjiG19Xgd3JT1eeRY8/Vf1Vzqx3Mma6UXLY3VwnVOl0Sjn9m8Vt3tItam4Ad27
         AzjyfDOU2cWe7EtFIPvHiMLztzhnmeDO/1zgxJwiJWTtI2PaTrFgB+wjidYLQ9jGoO//
         MlX3OJwqnTofHKSp+xk0+PXJVg30nhukg84NkAOtEOXcKfozbEqQ5meBLVYvxzxwG+Zx
         L56g==
X-Gm-Message-State: AOJu0Yx74tsjR6rhVFhxJLVCxpq1JHfEkLbYHwDjj1pr1maMBvkD8Mt3
	QMFDGCIKbkgx1cgs8XD5IazSX2zaeklPmwFOVYtYLv8RtJ7ZrycOeVrnFBK+4Nc=
X-Gm-Gg: ASbGncuEkqSig5n+5YnEDihsAFnykcFUpfbqkRZxaNMi111R1b0VQZKn4yjcUhBn89j
	C+/zT7fbYwr+Vgf1WiopoHMfrl0okxsqXBkYIQ4mfY9f99A1ZOuiV9L4pr3hfvIdBIsWmX1OkGA
	ABSF71Ytk7j2JYu5G9RLdhhQy7XGo065VhLnRx387ivHLmmPlJgv6etnZa2RST4m45YUgo66Lbg
	50cJk/6IxFnsqhIWVoUr6RvUbUZsQybhIOquA3Q8clSA0//MW1Ue02ozna00RaJns7TDf9O7Asp
	ptyykJbzXRUg5q20S7JoCUbyKPfG2uA0mEjbUgMJJbb4oSdz1A==
X-Google-Smtp-Source: AGHT+IHxu9xjH7mhApYVVv9e3tygFxjACr3/rHNOhNNTZEZVnWCwgxdXUjJa6ONf3FkbXFANSKR7sw==
X-Received: by 2002:a05:600c:1994:b0:43d:b51:46fb with SMTP id 5b1f17b1804b1-43d1ec622b5mr110644745e9.2.1742193771884;
        Sun, 16 Mar 2025 23:42:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d2010e0bfsm94729805e9.36.2025.03.16.23.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:42:51 -0700 (PDT)
Date: Mon, 17 Mar 2025 09:42:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 0/2] iommu/amd: two tiny cleanups
Message-ID: <960a6d1a-63d6-49e8-890c-5e8a66e50c45@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Delete an unnecessary NULL check and return a literal zero instead
of "ret" (where ret is zero).

Dan Carpenter (2):
  iommu/amd: Delete unnecessary NULL check
  iommu/amd: Return a literal in init_gcr3_table()

 drivers/iommu/amd/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.47.2

