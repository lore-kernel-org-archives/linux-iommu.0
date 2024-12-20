Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A422321A458
	for <iommu@lists.linux.dev>; Fri, 20 Dec 2024 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713751; cv=none; b=K+90D4dGuip4jcjT9ezu26iwD/KddRgWBLH+Y525yyCxprNdltulYXsnE7ZypOHMCLqB3FU331TDPba1lXRC0p3lVah0e+9vb/jNStNp3YTj9bndGA7SaPtCfunbxlnti+3lWt05wfG1AFjAdBHRe2OViBiT4rsCkW3kQkXQSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713751; c=relaxed/simple;
	bh=ZJ6BlFTh6Cd2QrVCVjLhtbcAD4DALAZMyCALpAZOwdY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s2R5MngI0H6JuPhn8we5mx4ydReQNOhEwncJ6Ghq3uw9EK3qepUzaVRZDByK+tw+dONW+NdbXVtndLLZrGiLE+l2HWAFEiW1WADTGFEMjh1lpJrzdgQiMi4ZqyFrVUI8K5ReGW/+pvgfnzu1RoxhuKxcY0KhHXvwz2EKkiHHnHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h/okHk+0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/okHk+0"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43623f0c574so14885575e9.2
        for <iommu@lists.linux.dev>; Fri, 20 Dec 2024 08:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734713748; x=1735318548; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRMVd2Ct+RJM9mKq4M10JLL1AVbRbgv8gECSUOI9cfA=;
        b=h/okHk+0xPpYgZEjbrU9Oue86ll5MkZQwcooqaTZhM/qax82IkvJUtWdo6bpSfrzkT
         jCYYTp15P+Q3W6tggHaoggdElNkyzdGH17wQV2ICpx4OgwooxXbodr4oe+NYrxC125vh
         iNZgGS17EziBfv3uwwxYg8c90z2Z6slHI1BBjI+sjzFknM94FWDJ8dvaFwBz1ozHWCRC
         riRcPTOkS2nP0oOMlF1kwQ0eBuJBsSZouER2PmWjWeB8J6IAK7OJj/5fC2EzGmqhUU//
         G2cbQGcQw74lCRbHnHONxxO0fX1lt4FW38xShzOIPL3+2Tm9I/xg8cg+kkrGiitDu1SS
         68qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734713748; x=1735318548;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRMVd2Ct+RJM9mKq4M10JLL1AVbRbgv8gECSUOI9cfA=;
        b=thLwL2HhtWP4IokxgPEYxa/ihtiuGzHuQfaJPFjxFLpyF5AiPZhHe37Ao8waOk+yaX
         i3nNEbOrUi2eUWKED5fgy68IVuk+8IC6IAkIbeWIsTU4XzbxvfHLDvMIQ4RpH7BWANIp
         rxutDsVBg3lgRIcZPECJYAl+2LGHHEuQ3wmjusQKJO2n8Kw3enO6NT646eydPugrKnCc
         S2LysQyti5bSlcqwc2wR8vlf/bUW71RW3qlkValZZPlMqy75RO6CfBe2+xCWvMBrQUeJ
         w4eXqJduzjvTzyAB9cJcfLvbXh2Mds+60EzJVg4Ws/4DrK7q8/t69S57fwc5y70xkI0W
         Cwqw==
X-Forwarded-Encrypted: i=1; AJvYcCV7RzitFrS4RB10Cg4rBNLnO58l3g8qhCY9r/Ors4aTGJIBawTZGQZo+K34PSiJfoVZZAHL2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzSk7sjjtN0n1HYsP7RmMujopapwq+L5FH+uCqgqtr6QZfQ/qF
	0TH0Wd6dFu+ucCCgx8TXVSAaI1XZsnJKzr5L+/4URG9umM6BpuKzGpZPCXCogR4=
X-Gm-Gg: ASbGnctiGjeSnh1r4+AFmyctVVsldQcFc90poR4OBJyPw3g9HuYPihN9/NEj/R54sQ+
	hUm/MvOCZP2mnzND70Do40rpci7OYPY3WsAPXmrqglYORzUJ0c662zESZp3LyShPPoi/COrFnt6
	cau8U5+bF9MblaXe6RwFQrhApzDE2pEgg7WXTsmV4MBA/1jdXKtc3HAUPF1CQQl+dtDBhCe1ZVa
	in0SyRYqOy7pEo44jbmNPPEUwnnIWFuHe9BuINetb0cvxNP31SEWqTPEPi8zbCI1H5pBbzMWBw=
X-Google-Smtp-Source: AGHT+IEdH/GxYvmGV9OhqkZ4EH1vTHNkVaouX931hJminJB7ZTbk13vFQOd2dc1W1czg+c63hAfImg==
X-Received: by 2002:a05:600c:1c87:b0:434:a10f:c3 with SMTP id 5b1f17b1804b1-4366864320emr36500145e9.9.1734713748019;
        Fri, 20 Dec 2024 08:55:48 -0800 (PST)
Received: from [192.168.68.114] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e261sm4491454f8f.76.2024.12.20.08.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 08:55:47 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
 Dang Huynh <danct12@riseup.net>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241220-msm8917-v10-0-35c27f704d34@mainlining.org>
References: <20241220-msm8917-v10-0-35c27f704d34@mainlining.org>
Subject: Re: (subset) [PATCH v10 0/5] Add MSM8917/PM8937/Redmi 5A
Message-Id: <173471374655.224301.13708019576127725452.b4-ty@linaro.org>
Date: Fri, 20 Dec 2024 16:55:46 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2


On Fri, 20 Dec 2024 12:26:13 +0100, Barnabás Czémán wrote:
> This patch series add support for MSM8917 soc with PM8937 and
> Xiaomi Redmi 5A (riva).
> 
> 

Applied, thanks!

[2/5] dt-bindings: nvmem: Add compatible for MS8917
      commit: be7eb69d5db54ac9ce794c4dc7d278890a78e0fe

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

