Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7241760
	for <iommu@lists.linux.dev>; Sat, 27 Apr 2024 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714202257; cv=none; b=qwCRNCUFx0vC+OlmvGzERj+K+62yE5tdYPStbaKWWdS9gtCrAj065E3ep1vd2zt36VwWK8HktbDxCPqwNd3nwEZYE1TPaTme+suhcdAWzdb21n37NEHURdBWbbZRVanCYC7mOLRCFmBLsW57n88jdXhFRkWlIx0NCIzIV1GS1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714202257; c=relaxed/simple;
	bh=KsZOuxYIuzP2B3Mk5ljXHJfuM1664KIpR3QMseySPms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVO21Opim6vnE1gn16Yt2ef73dtCUJ5CylG44Npe/kVyCoqdhKriuouLos0Br+cWmnLc5kncYUw3cB1JGbHqXpGfzuAaC3JcNGsI1z2pAlOTjK4B/YIHZhg7JzfPyhdPnTfIN48Yvm4ho+d88W1JiTeKh0rSetVOAbs01ksZAL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lR3MOz47; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR3MOz47"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2021909a12.3
        for <iommu@lists.linux.dev>; Sat, 27 Apr 2024 00:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714202255; x=1714807055; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8kCB3I1nqc74i13dcnZcbSCBOzeY8bK9si08l2dEgE=;
        b=lR3MOz47NIiwrqpSDCIne/k2mN8FbDUhGOrb3ftprqg6n1ZvuYh+tmCuZVHSeFnJAf
         KNxh64PSXxgV7YNtbFd4comSMWxl1yrQCyTOujy+dwD3yAtyq/E+HwAMy0LxpvR1V4+T
         DY4Wziq6QuNfe6S5s6XOLbu4lM0kJcG/UdXuv4f8La/qD4rcfdBl5uYqBBOpSPO2Hma/
         gucpLwULN7gpRbHGbDAWa7Yl9j/cgJj1jul7dP+9MgZ5Qxsh125NeK9aZ9uQ2aEJrQQf
         cGvx9AORqOHmiEQMb/vw1GgkzaVfkljQhlvBO+spXn6JuX1ABXSUeGmJWAYamocdoq9m
         6iQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714202255; x=1714807055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8kCB3I1nqc74i13dcnZcbSCBOzeY8bK9si08l2dEgE=;
        b=kd2OjLuAf0MxTBJLtmcUAqmArfTCbVrYBr7st/vje0UP095nKRC+/cC3OxHwfBguiv
         CjZKdkM+r+mW8ciCoiVOUfRMU6PXVcjY9graiyV/Gz4SKmTWnrcebjteSPYp9h4oKXXU
         Wb8Sx+Y6a6XTq+UsJxYDSqt4bbtDBLBqAXTFxp2QwCDmtFQxIzGo0GsJfu67mq1nOY2A
         RmVzmoteQwG5vk6dYQIYndwkk+LdvfUH/b8IB3d4Quvt1VjPkXFgZgzlkDdZSo+YYWZu
         TxXFkpzzj6on71AVHUS60lYGpiCVGRxrtHIg21ff/6pm6pDE+WL0Xy4a2uaKbW+dWFxo
         mTzg==
X-Forwarded-Encrypted: i=1; AJvYcCWVWuCGCQEWhqwZzbzAJllgdp/da0xPxmp0YS/oQK8WGX1lwGivHLNRGWO28lbmk1IgwqPJAApsYE43HkkuJxo9m9RF420=
X-Gm-Message-State: AOJu0YyedDyprq77u2AMFwe3eUAiTVotzj+DSrAVmMU1r6ojdamtx+s5
	7/lmr4FRd7BKMthDXRHTM9HwrzfPooNo539mITrg3no7olmxL9+B
X-Google-Smtp-Source: AGHT+IHWfWgdcQqxoTVmFJIu2SLzNm3A0qQRERzEXLa7neH1QrNrTJ0T8DF6bh4XJ6eY6mQO553c/Q==
X-Received: by 2002:a17:90b:1d01:b0:2a2:bd4b:764f with SMTP id on1-20020a17090b1d0100b002a2bd4b764fmr4481541pjb.3.1714202255374;
        Sat, 27 Apr 2024 00:17:35 -0700 (PDT)
Received: from toyko-2.5 ([45.32.55.39])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090ab38e00b002a03456ccabsm17233086pjr.30.2024.04.27.00.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 00:17:34 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linkmauve@linkmauve.fr
Cc: andy.yan@rock-chips.com,
	conor+dt@kernel.org,
	cristian.ciocaltea@collabora.com,
	devicetree@vger.kernel.org,
	dsimic@manjaro.org,
	ezequiel@vanguardiasur.com.ar,
	frattaroli.nicolas@gmail.com,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	macromorgan@hotmail.com,
	mchehab@kernel.org,
	p.zabel@pengutronix.de,
	robh@kernel.org,
	robin.murphy@arm.com,
	sebastian.reichel@collabora.com,
	shreeya.patel@collabora.com,
	will@kernel.org,
	sigmaris@gmail.com,
	nicolas@ndufresne.ca
Subject: Re: [PATCH v4 0/2] Enable JPEG encoding on rk3588
Date: Sat, 27 Apr 2024 15:16:38 +0800
Message-Id: <20240427071638.79915-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418141509.2485053-1-linkmauve@linkmauve.fr>
References: <20240418141509.2485053-1-linkmauve@linkmauve.fr>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Emmanuel,

On Thu, 18 Apr 2024 16:15:04 +0200, Emmanuel Gil Peyrot wrote:
>- Only expose a single VEPU121, since the driver doesn’t yet support
>  exposing them all as a single video node to userspace.
I'm also doing work with the hantro node on rk3588 which has both vdpu
and vepu. Discussions can be found here[1]. If I enable the jpeg encoder
at feb50000, would it cause any side effects if other jpeg encoders in
your patch are enabled? And what's the disadvantage of enabling multi
jpeg endoers in devicetree?

[1] https://patchwork.kernel.org/project/linux-rockchip/patch/20240418111002.83015-3-liujianfeng1994@gmail.com/

Best regards,
Jianfeng
