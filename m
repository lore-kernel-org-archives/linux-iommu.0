Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC5156E045
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094393; cv=none; b=GI3hEt/n537Hg70gWbblOAd2f81zUwH1GixwlMibtaZKzsrbsYz/0X0GAPzDgIM2Nq6JMpm2uNYhfvGQUb0a2ijlT5/4YaTb1R1K5eauLZU2ER6eEc7o+d4FXqb3Cj27gcfJSJWhWEb/CCicccb3YpJXTzl/KXBe8bAnEZDQB+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094393; c=relaxed/simple;
	bh=6gRDVabS7sEgoC5YbuU/p3+usRnz+cBBnRvd0bHzcp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AlZ3G6lj2pjm5LrAqxqiMC12w2djZF3yfAbVPyWYS6WnUuiDnlNDSiUOjjE7MX5m7SFL70WJFTY8XBA/S2U9ntfPm5OzKAhErggzlKHg1MQyXAQK0MGmPDwYp1F7K/ddG1+oH9fBZRAjGpBKu4/+aoEiym3SM51PzfnRyeQ+xNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqY2cYmQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqY2cYmQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so51747205e9.1
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 12:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792094387; x=1792699187; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6gRDVabS7sEgoC5YbuU/p3+usRnz+cBBnRvd0bHzcp4=;
        b=NqY2cYmQNjMkSfXlrgMJsWRC4w9RwHnkjb02yQhiNiiwTpK3jnRQmjtGP8xdl7MvxS
         zebNh/ZNyT/buDnbIjBBYaL9c/s+cm+kRYQXVIMZ8shJt3Ti6FLEXNm18S2zYR5iy9bz
         av6Tcd3jFLrbSQv0G+ZVZAo1Q30fcflqH3P3CQ4m9OtXbOO+biidhURaLsL01qUYaIIU
         /okhaLHepmsSEkbthWIPHCkQCRPYJNSNO/zZ8qfJYq+NaquCP1Sr25PbCDy4JstjUZV8
         ACkeGjgJ9nOgeXXjvzUwn+lh/5u4YFvq5NQeOK+xDVlKTpA9MI+yI/zWFt3PyXcL8clv
         FKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792094387; x=1792699187;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6gRDVabS7sEgoC5YbuU/p3+usRnz+cBBnRvd0bHzcp4=;
        b=rwJFcv9rBP791z9VdOMjLxp9TCkw54uNv+eRNEfpmh3EimmbM8MdSzp0ALB950zT+G
         aaDfxz4082LPqKcdK+qg7oNk59BlI2dgHtXfiSBmwmmXUoasI3vyNp4ZeEe7udYJkB3P
         UOKRU2URyEzuIB2PzSA5hwRh1DZGNgeD1/bIyKoJFDB6D8nydZA3u59xSicyxclU98/e
         yntkpr+430ccru1PRz8ZrttY1PYhA6xivpykDIfK620bva5XSPygBk3dCmX1Bg+Po7qh
         RJI6bVcbEArhNp8r8CVP0iUAWq5MWJyvRzdL+VSpbXRI5VCqXz1cs56FUVUcFNxa0nGW
         /krg==
X-Forwarded-Encrypted: i=1; AKwUvBzCPvmfGFPyOy2Bcrx5Xtt6C21U99Y3NAKzw7ckqlqab1ho8nu54irlt36eujj01dA5/aAKRg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKrbNYiDV1LI37724miP5uf4rXxiOpUIC044GOD9gxYF6SLhe3h
	mxHtK9VJ0ENxh+n/UMbRinF9xZ6G0xfjClv6IZGMCwqYj5QJ+9bFafMz
X-Gm-Gg: AYBFou3vztH//j6qI0PWIVVm3Ge3EDjyPvzEh1/HLSwjowOE3A8C55hhNvjt5sEKNsU
	wHLO5Jq72Bis44Nbe96ttMQzs+uRTD55aV0Ju7DmhaG1oLZNsv13knj/emUgnDAVUdOz/7PaYgp
	TdlK5ui3Z7fu9jtnMw1qdMcity7UZlHjoeDIeDxiFqIJvIpa0rLBqF7FluvtbODfu029I/xbX8P
	tAK72oojCVHNJ72hmnvPwM2YOszMDydDAzWOTJzLHqEFxKOFCvyJ19aKSIW/zLOmYSnyoC6xB3X
	nTPpTjcLFmEJhQBH3FApR12b7GbGgE9Hf3HdP7+1RMHBQnDfStW+HttWNgiOd5aChhl1jyYZYwn
	HLR9cENPeOUCTbHArAr94i6q6IW3eIkMMNACU7awOKIVXoLgMJDHRFVqmhwMTIXnYNPPA1zQrxX
	s5NA6tiBRggfveIfMffLY8aPm1EFz0eCH7zDmOJV6USY1istdXvqXDUDzXFwZt8AQUU4fk7RhvI
	ldc3hzQ2pqWMU48ytWpQhs=
X-Received: by 2002:a05:600c:3f1a:b0:4a1:ac66:6ac6 with SMTP id 5b1f17b1804b1-4a1ac667160mr205111165e9.26.1792094386716;
        Thu, 15 Oct 2026 12:59:46 -0700 (PDT)
Received: from [192.168.69.3] ([91.189.216.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471877sm202635f8f.1.2026.10.15.12.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 12:59:46 -0700 (PDT)
Message-ID: <1a469aa9-e4c2-4d13-b544-104f4065a14a@gmail.com>
Date: Thu, 15 Oct 2026 21:59:44 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] iommu: qcom_iommu: implement support for instances
 on MSM8974
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
Content-Language: pl-PL, en-US
From: =?UTF-8?Q?Micha=C5=82_Szczepaniak?= <m.szczepaniak.000@gmail.com>
In-Reply-To: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/08/2026 22:15, Dmitry Baryshkov wrote:

> Qualcomm MSM8974 platform has five SMMU instances, used by display, GPU,
> Venus, VFE (camera) and JPEG encoder. Each of them follows ARM SMMU v1

Hi Dmitry,

sorry to barge in but I just wanted to let you know that I 
gave this series a try on the Motorola Moto X 2014 (victara,
MSM8974PRO-AC, PM8941 + PM8841) on top of v7.3-rc7 with the
msm8974-mainline patches and "clk: qcom: mmcc-msm8974: add
GENPD_FLAG_NO_STAY_ON".

Display (command mode panel) works through the MDP IOMMU. The GPU
works too: the Sailfish OS compositor renders on freedreno (Mesa
25.1.8) through the GPU IOMMU, and I don't see the reboot reported
on FP2. I tried 3D acceleration, and it works without issues.

Hope that helps!

Thanks,
Michał

