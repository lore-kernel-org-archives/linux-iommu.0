Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527D57317F
	for <iommu@lists.linux.dev>; Sun, 28 Apr 2024 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714325444; cv=none; b=nxJ6yhRUrr8NWHsNUp/JsPRUrinf+cPhF5iIYlmmY29gnc1omib/N1qOxvGMLX/1v561LVu6CDzK9cGIsw5IXDOe0kURXjJkZeTbDMW+M8FIpKW57ujxp3bMMaiWcsB5jhSTjYawffshlO5FPm8iGEBYx2qN1qGLrcONeoV2ANA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714325444; c=relaxed/simple;
	bh=6C4iC5ro3NJyO5M+1IwRkJQ4c+Kk2vhMSEHiWNEkb7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4nOh5mZawDvb0BJJBdnRYuO7GYZI6ZBYkZH3nc74/+GIO25kjZn7C/oLIeSd2TCvHmXa5aFp08DiUQ/vF8/T5MCpTIMXjVVKxjKeWkkde+dL3pdELUvJlj2mQFJk2/QjImsJJngTe/43F8pcMqJCjepCjoEJJNhc1QutBaFWIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDWkXaWi; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDWkXaWi"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6eff9dc1821so3504173b3a.3
        for <iommu@lists.linux.dev>; Sun, 28 Apr 2024 10:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714325442; x=1714930242; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6C4iC5ro3NJyO5M+1IwRkJQ4c+Kk2vhMSEHiWNEkb7A=;
        b=UDWkXaWiP76EQfSImo1iCOVMZVm3oA3KXKVthTtQ3kmHvkdoh4/BbHPKk/1ouOEn/z
         lkiZbqqFQ8q4SU9BSf6IgjGkgMZa85WOJ7Mll7tPN/1R5kNKHGIb5EhhYVECiCjI+7lJ
         uG45wlWacSOnVoZzd6PqQLDwZBGP2thzVWSqZKe4neIfR05GE82OC99BbOWiYGw/xfa3
         nAINsdNspqgDHWwZDlP0xGjqDe+8pP2/Og4RWRmUNnuugD3Q7K6h5rByuwn2w+KYtCvd
         ALu4a8KADY6NiaLgJT1hpiI6kBTsNCpGiS49X7vSswnoJ1QsGqR1+koeSACu3p70LO3Z
         9JKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714325442; x=1714930242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6C4iC5ro3NJyO5M+1IwRkJQ4c+Kk2vhMSEHiWNEkb7A=;
        b=W5dRl6KiwtnNiRztTDA7Ha0PSSp2SyS6dZhS+7UR4lV0EeKqxCl3QE/6u1nPcjZw4k
         EkY9diEiPbhNFeoZzxc9b3YrhXaHd9BC0iRntTG9odFCNrM1Dx4yNPsU9iO/b9epSoT7
         VpjwYp+LLRTkErR2p1+KmwPtidvt7H6XNxnqOm9mk8k+VoG6qJ7Ld1MOXjutKn3b2dJu
         qoVluLQxfkcqD7W3dWe09YCds8CQuWejehRQdRJPWeb/UiQKj7fSLUUDYFGqcjMQ3Xq/
         cQwH2lkqBYVYuGFzTG0Wb7D+avulPBq28NhugdVhWTjPKYBDxSzICcZryI+FhqSL7rzO
         3h1A==
X-Forwarded-Encrypted: i=1; AJvYcCVo9X7vKdzQDS6jsHEIq5dicYa4Zus30bDHP9/yVAO2l8/Z7gUUMQp5OfdiAHf70sw8ilRKEz0Dor9772sTi2g9WzcPq/o=
X-Gm-Message-State: AOJu0YzCHMAJ6IBT9FdW5+t/ibMouH5sWFn7vW5k0gZuoftG3zqCgl+3
	rXlTkrIJ1OA7eLEtARwSTs3+Hsi8AZGDdkDy3TeS1IVxSHw2Cdnj
X-Google-Smtp-Source: AGHT+IEAHcZT2hqdPXrUrD9utnViKm/pFwS+gPtcpridRGIUu3is+jGvfjVMNz/1yOUWrCv/AUnT2A==
X-Received: by 2002:a05:6a20:430c:b0:1a7:73ed:7f8d with SMTP id h12-20020a056a20430c00b001a773ed7f8dmr6549978pzk.38.1714325442453;
        Sun, 28 Apr 2024 10:30:42 -0700 (PDT)
Received: from toyko-2.5 ([45.32.55.39])
        by smtp.gmail.com with ESMTPSA id b186-20020a62cfc3000000b006ecf56cb55fsm19089266pfg.96.2024.04.28.10.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 10:30:42 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: heiko@sntech.de
Cc: andy.yan@rock-chips.com,
	conor+dt@kernel.org,
	cristian.ciocaltea@collabora.com,
	devicetree@vger.kernel.org,
	dsimic@manjaro.org,
	ezequiel@vanguardiasur.com.ar,
	frattaroli.nicolas@gmail.com,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	krzysztof.kozlowski+dt@linaro.org,
	linkmauve@linkmauve.fr,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	macromorgan@hotmail.com,
	mchehab@kernel.org,
	nicolas@ndufresne.ca,
	p.zabel@pengutronix.de,
	robh@kernel.org,
	robin.murphy@arm.com,
	sebastian.reichel@collabora.com,
	shreeya.patel@collabora.com,
	sigmaris@gmail.com,
	will@kernel.org
Subject: Re: [PATCH v4 0/2] Enable JPEG encoding on rk3588
Date: Mon, 29 Apr 2024 01:29:19 +0800
Message-Id: <20240428172919.691602-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3784322.QJadu78ljV@diego>
References: <3784322.QJadu78ljV@diego>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Heiko,

On Sun, 28 Apr 2024 19:01:38 +0200, Heiko Stübner wrote:
>the basic problem is that exposing multiple jpeg encoders would require
>userspace to do the scheduling. Which is bad.
>I.e. all userspace programms would need to know the existence of
>all jpeg encoders and then somehow negotiate how to use all of them
>most efficiently.
>
>Think multiple different programs that would need to negotiate to
>spread across all of them in the best way.
>
>Doing this in the kernel, we just expose one encoder (and queue) all
>programs would just pile onto that one encoder and the kernel then
>would be on the hook to do the scheduling - which the kernel can do
>better (with relevant code implemented)

Yeah let kernel do the scheduling is indeed better. And I'm happy to
hear this method.

So I will keep the vpu at feb50000 with jpeg endoder disabled until
multi encoder scheduling is implemented.

Best regards,
Jianfeng
