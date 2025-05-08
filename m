Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6801ACED9
	for <iommu@lists.linux.dev>; Thu,  8 May 2025 04:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746679892; cv=none; b=WK0NdAF916UR4y9hZeYgtvhbs6Q/bJn2f/HUbMUSaMMPZectlgGBik57bFSs4rSsFzZ/AR0b26/F1yc51LVo5PUBFZ0EpZDWEAa9avSljPPBxOnSEjnCiiDzoARgnnclNerqF/o6YhpFF5SIN5P/lx+RVhiBfuUxBic5nhLLErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746679892; c=relaxed/simple;
	bh=vH8pZApZwCxXj/zcKr2DuVOpsesqXZ3FpznsuRlEkIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u33k4Uq8eF2zk6hYZ22PW2pm3avGxyCRnOUGyyQ3J2GzJNMV9HaUv0W0CpEnHVcfuJFqHukFBu8MWILwFcJuTlzRUdwxCXj+Al+Tv6XZfb4C6cqgKPwiySSs9ENd4baDEjdIBg6OTHWWxZMq2oIcqKnaWDmUQeU+8oBatpMC7JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kOnqYknG; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kOnqYknG"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736b0c68092so550439b3a.0
        for <iommu@lists.linux.dev>; Wed, 07 May 2025 21:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746679889; x=1747284689; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vH8pZApZwCxXj/zcKr2DuVOpsesqXZ3FpznsuRlEkIQ=;
        b=kOnqYknGAyW89KSslgYIIFw8aAmPuZGOGThiHpUNR3vEHYA/Bn+izoeZEzaIzGG1lH
         m2BSy/s1BmTkPHB1bIbsB1DneRJ4IGOzydOQ7d54iEa58K0V2Hr1PMAuc5Da5BANX0cw
         IKM5d4lEQmXxVHND8zsnE12ZXos/VDwSqaUkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746679889; x=1747284689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vH8pZApZwCxXj/zcKr2DuVOpsesqXZ3FpznsuRlEkIQ=;
        b=hBR3muKUrRCcDQl/oinOYAukSwuaSRS/w7lzBdbNjvxI1mv1Lld0n+gEXg9Tqbzz6K
         ooKdwd7jPlIx3X//iQMVpvkioJPUp4Bo/gi8Qou70aXsrS2M7U1QvHc64JMEjQosJsdd
         Ycg1ajK8ppQgqYmotGKIUrQfb/LR1JuygxVghBV4B6aK/Wk4da/qEETaXXc3xlMJ0czp
         mVDYFNAuTCKF1WDg0UMJHKKpH8avxVtnwZAwwJahNBaRCwVghmMg/IaA1paO7RmDX0dO
         P/oIn/PLtZOnOjyffyCd1jkxXY5/6TmcGPYr0VVqpLPVRBOkX0QrZAd3+GrmxJ2JFfJ6
         HeTA==
X-Forwarded-Encrypted: i=1; AJvYcCXVogB0p0vrYM7QVSVPNKfRHmxGsMntnlzSpjjQoqvuDNf1NzjklPh74Eepg7IHz+O4D6qPuw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+Thfg86R+axn1fIkg3ASjs1N7o1o8NuTKrsfId9TGZJ0b7X+y
	c+dV4hUNDuSVUlIRmkdWnrUFaoxq1KCveyp5D48ProjMyilgbAHJ9gvYwEvIHA==
X-Gm-Gg: ASbGncs08YWvkQW5HGPSq1XE24eYJYJfjiI6nX0vpoxyAOYY+QZijuwr6TtCWmY5Y3w
	k+hXoZwUZIo/EombBp7NxYvcdq4UxichiXPXwBP7T+EcG4uJTiiXoWSzZrAyOXzkzFE1SNEDx4a
	kzOV1WYpjEuabTyPuA3VJKlXleCiKekwB57amc0XOaFMV+SjCALGxzVieCimICiv6t2CbefNgTe
	7dJxCZ3m49dEs99iZi0fmjhQYf3IpBxF1uYiRLkaCk40PH5JqEAIWrAAsqwrLcoKr3EcDN+uS1a
	xbQumPElZOUC99u6SmgSvGdtDm023XtuI8mpOKsydRHe
X-Google-Smtp-Source: AGHT+IHJt3oTtWnZHdDl97ybd6P+Hsv2F0EjcCAUaLYDnkgYwSOPmPUSLh8gTCh3PPuM9rSSslwTKw==
X-Received: by 2002:a05:6a00:1bca:b0:736:5504:e8b4 with SMTP id d2e1a72fcca58-7409cfaf3a7mr7364505b3a.19.1746679889147;
        Wed, 07 May 2025 21:51:29 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:c794:38be:3be8:4c26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405905ce9fsm12728777b3a.136.2025.05.07.21.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 21:51:28 -0700 (PDT)
Date: Thu, 8 May 2025 13:51:23 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, Tomasz Figa <tfiga@chromium.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] media: videobuf2: use sgtable-based scatterlist
 wrappers
Message-ID: <ravkxkfx6du2uovpfqwugtmm3ymmuswkusfiry3erslpgnvaz2@2gwxofmdfjye>
References: <20250507160913.2084079-1-m.szyprowski@samsung.com>
 <CGME20250507160921eucas1p2aa77e0930944aadaaa7c090c8d3d0e73@eucas1p2.samsung.com>
 <20250507160913.2084079-2-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507160913.2084079-2-m.szyprowski@samsung.com>

On (25/05/07 18:09), Marek Szyprowski wrote:
> Use common wrappers operating directly on the struct sg_table objects to
> fix incorrect use of scatterlists sync calls. dma_sync_sg_for_*()
> functions have to be called with the number of elements originally passed
> to dma_map_sg_*() function, not the one returned in sgt->nents.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
