Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795220195;
	b=kRUA+aKIPUPlF0vm4cc9DbVw8qA1G3UsawBmzWohtkM3zBNviynHSf6hLAMEsq1NEVnp
	 62Czl2KhyAtU7OkEu9p9Py9VC0mtRtkUrQ8K/9htMB5i+2I7KqKyrH7CXEu93vmVCrAcJ
	 3kP/pt4I/nzg+bTyQBpnC7Mf5A3a82Tx6DGdDNIMoD6QI3/Duv/xkleaTmjmqr9QqX7bb
	 9UiB4IkeJmJLipDmkTA6+O4Ed3cfXlG4nNJcYl6fE4TjNL3pEAPYkqy0FwrEUiFyv+EIn
	 yMvp7N13GP465B1K37sBMmO6G1VxTGfPHF5nVuqp1FzapF5w52nqooYFgc5XmE82JKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795220195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=74mngtbu0bh2Wb5wAzXvu9Way1o05aGhqD03WL1B//I=;
	b=zET0eHSHM0xUeynBBms10jaO1Dy9fL5aHjXVVK4DEEPrR1F3LHYVrLBc5sZ97IoH1QiH
	 jX/MX4DoIu5QgPjSoRnlgWJQgmv7AD9lp9tCdX7sFLzyfdy/AzsppGAlFG0qYPwl+p0dn
	 nz47wcFIa9AQS4FK4PiQc+89m8bgDm+y7SBgfeRUDnCLiyJqYH+mYBO2UDjsLFJTG4BwH
	 9zlw4uBJJer7GGdfaMi6eKWGdGN1k+27jzkVK/c6aEl/Lvqwcs2inK0AtsuBDnxI8u2ZF
	 /+7d11Jmooh5a31KcDdJSCPLTpRcEJvgMubaeD0QKVMQ7d5zgj12adnWusJUVqzThPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xkg3e2AH;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCF0606A687
	for <iommu@lists.linux.dev>; Sat, 21 Nov 2026 00:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CCF0606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xkg3e2AH
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c511cdd5a82so185289166b.3
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 16:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795220190; x=1795824990; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=74mngtbu0bh2Wb5wAzXvu9Way1o05aGhqD03WL1B//I=;
        b=Xkg3e2AHYRrkUa+Kg1i5XuaQBwrEDxeZ1l176kb2n1DunYgFxBJ/BCJWRForw5dwM0
         i/4GFESJa2nrE9s8B5iCHyB2W+W0KZ4SOFzhiUSRAx33hQpRGAJa0k++oJJ3yPkGGLEW
         1FccIzsN0lA2CwV9cvhI8s04ln+lNlJtOjwbc8HUVp+QM3br8Ajy9rXKUx9go+g5zXEM
         Y5ZBIjryUUyinXALUFcJ+wWSs0/YHWenqXzWlGPo6yrYR4MCXL/WFToWkfDJ0U9+GBo2
         01kF3FeDncG0qLMO/1HmRQe9wQK43wPpmJCFywNieOcrwYcPIC3hFe0YyzxidCtE6Goy
         aI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795220190; x=1795824990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=74mngtbu0bh2Wb5wAzXvu9Way1o05aGhqD03WL1B//I=;
        b=taTG7wxNRRXFDcgdWFG8smVTROKMXaYBIJBvVa1HzMxT/2aggdjuDtAj46ca0YIuzT
         G7r5FjdwBP12tIZSfczIvoRihEIh4G7sTHhb1quUSdYP8JTpmesS11roqGWqzM2jZfOJ
         ivCb1mSpMaBjVg396E5DDj/bbZg/HlRrxx1/inibkmKbD09fbHk3ROj+sx5Y7tVrGbGc
         IvQIlRxvxHhIM6a+teVZ9nQl/vIbuRMRh0Q8SF1ewjTqz9z3VIiJzwLDICz2fQIu25JK
         pmCSpNbnxIdyXQQgeiXbZc+n7IhQI2+obIOT2X/gg8l/KlzHSqDw0zNusVs79P28yMhI
         1PgA==
X-Forwarded-Encrypted: i=1; AL+hErH9bnXMt1JJcpX6FzsGlb/UAwz6ihctIMqOnKjJPdiQy3OMcUBFnQRmvI7V6K7lD1wJ1G6dcA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9yceCpSjhn9V+E1PN/qPnBPmVjfaeHWmnuzLkW3qyl9b4iQ2mJ
	6sTEBmfT/twSbOZd6nVesg++D6IIud9kGuB5S7KjLSNjrYTsequzoYI=
X-Gm-Gg: AZFdTZepScYfexcYkNyZqLDdoa5XlajParPj8sKz9VQKJLtF0V2bnD0sZQqMwS+u2T4
	wjpeaPjMIN/6p/VGkmTacn0/Whv+AXHJP+ZGOr/+YIj1GEXXSf5HQYVo7tGujpmzzTusTZonZQr
	aiCvPkPsIJ0dqYjvUKdF9AeCu4bKKgprkY+Gy817VxD6ziwRw/wC2r0KWdW6OCg2ZWYZw4IRo4p
	2xaY4zInuGrcjJROOVDOmsXSkuE8X9CRbSfcCQi7W98EiswKVSpKTalzj1laiNGnGrbt+w1J634
	KK2Vc4xpcTDTfWa5j/bBCkpd+pmeeUpEfixUyqn/qjMjh/DMmMrxxC3uiTEbq8AR/RgVyXzXQbu
	M2Pnm6IgeBebbzX9JHvKHjBJLD3yBT0WXTBO2maHJ4On/RuLg9AGkUds1LZbXDZNT6oHu3LiAEt
	qGTb3DvkKlBh84pFAoTO/MVqodjaS/9gXkJoogLlAd47Lt+1aTR6B2ibhlhfYHK9JtdZ/88cnp4
	DcmEFaaizhGYvmI7jKqHkBxGRj0i1+Ye8C1ZEBOn3de1Or0seKAsPGRjU3h42frNkYDqsu/DRMa
	CoyzZO34Xf18mLsfDjK9CAb/c2c6eH09yxPifjTo2DfpHsGM0a+zx8Eu9HQFU0rBhMHzu0x3fG3
	7hqT/koz189mVOOgr8AD7gvYKrNcxCN3WRP0vaV2gYeDfHw==
X-Received: by 2002:a17:907:ea94:b0:c50:aa10:d888 with SMTP id a640c23a62f3a-c513acab9d6mr426725766b.40.1795220190364;
        Fri, 20 Nov 2026 16:16:30 -0800 (PST)
Received: from sohrab-omarchy.fritz.box (2a02-a44e-4ae7-1-c0e-6d5a-8ae2-915.fixed6.kpn.net. [2a02:a44e:4ae7:1:c0e:6d5a:8ae2:915])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae6663esm146454466b.21.2026.11.20.16.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 16:16:29 -0800 (PST)
From: Majid Hajiheidari <majidhhdri@gmail.com>
To: Nizat Mikayilli <nacht@dxdmail.cc>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Add SM8550 MDSS compatible
Date: Sat, 21 Nov 2026 01:16:27 +0100
Message-ID: <20261121001627.4091340-1-majidhhdri@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107-b4-smmu-sm8550-v1-1-777d0a41170b@dxdmail.cc>
References: <20261107-b4-smmu-sm8550-v1-1-777d0a41170b@dxdmail.cc>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Nizat,

On Sat, 07 Nov 2026 21:00:50 +0100, Nizat Mikayilli wrote:
> Add the SM8550 MDSS compatible to the clients list, as it also needs an
> identity domain at boot. Otherwise the scanout of the bootloader's
> splash screen causes unhandled context faults and the screen goes
> black.

Same on a OnePlus 11 (SM8550), booted from the bootloader's splash on
next-20261120: without this patch there are ten unhandled context faults
from the MDSS stream (SID 0x1c00) at addresses inside the splash buffer
before msm takes over; with it there are none, and the panel comes up
normally.

Tested-by: Majid Hajiheidari <majidhhdri@gmail.com> # OnePlus 11

Thanks,
Majid
