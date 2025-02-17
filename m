Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4153216E30
	for <iommu@lists.linux.dev>; Mon, 17 Feb 2025 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787543; cv=none; b=SQDdK95wiaGIxnygRcxrgYnmFt4LDTMWHdJSphpWhmnrUg9rCZ8BpXNHpEBQwRfaoSTON+Uza/4L2YZOi0gv7nUmuNBjdJJRQ12RvhYUSxMY+N6JmnYEAv0o6X4PikeQ3X77ROWR0MkeGCWKEp7SgqedXCtvxw7eVLMy/tvTv1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787543; c=relaxed/simple;
	bh=6aGtaVpBLW3kX82mTVYH8G/6ueq7kvdSb7JTLpAZZLc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LcEL3ayET0svL1H8rRn2s/BMnNxUjnH/Zzq7oYbVUbOx3QE0XcFq5jYjOLr4ymj+5E4U6uZL3a1xZbjPHdiGJVvxNA2tjRNnsGfraO/L12qbT4iJM61n0KKv0MNwy/SU5YSzTpyVjobREVITExic6luuw+ipDbt+oiAaxwIqv90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E0Vp8QDq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0Vp8QDq"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4398738217aso5019645e9.3
        for <iommu@lists.linux.dev>; Mon, 17 Feb 2025 02:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739787540; x=1740392340; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I16xu1ecVLtS/758jqaD8vtXmxaLQ5I+Y1leyu/ANx0=;
        b=E0Vp8QDqSR53AnWSAjxee7iqxhNZq0G+Y1W+ZBWHgA0wHmlgI9nYV9o/Fc3mmBR1dl
         uQOY/CUVgexMMBDykovU4iHP5j3VwTLtxIkwTtfobLniYoWvIwnoxaAxnsrqAv9jyuv4
         ZATXgti101wTzeWCWe2f4ATHZ9tqn50RiCqLttn7Bj6Wv6pTC8yH85vsf5iBofVxHJjx
         ZiG7hj0euHVKR1m/6yyWFuCUUvzl1HC/9pAdMS9juhf54JnpMlnp7XwUPseQS11pzqQW
         RMgjhdzkTNhdmhWIuhPKc3yMTiST6UJfaV1arj3POK4JDT0+U6T7qVhKlmnroMo5QyBW
         tHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787540; x=1740392340;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I16xu1ecVLtS/758jqaD8vtXmxaLQ5I+Y1leyu/ANx0=;
        b=BGnxeSnO7wdJ4FL19YA1vw2TsfBEtMr42foq0alcegSBkMgGLtHeNLnmzfWIsXjOOm
         MBUEzG8oH4lSVmmsinGaDfmyUcq6gRYzvKwNo8UZOwt2DAUaVVvcLVFUIkvT2Gvq7XNA
         Nr7j0Xlamk+3U7chpb6/B7d0vnf+v8kityLfFxcEmYAE68wUcJLk6oKoDRIVhPolUew0
         CLOTKNuokYdv/UwmT3DHK5xYmL4Vbd77xVYYfIutNx2T0rLPbfhag+9H6R0433G1CXcJ
         MxtFdPzage0qujtBuvD60kmL+EuIOdb2ACF4Xrv7W/jl0ZHOwS8tcXJX0E7c7B5BmXCr
         pn+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXy/hHgpfbWkElFHAqtw5HlOam8BUSsdyDoHlKiRLzUp6oawzz3UJeWi11RsdolLow6NfaQhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxG9cE4ewxLvFgwN2K3Bg4gFZsT946JM16pd9frM6L7x8AJat3w
	SQtLojiLwOBpT2aUBHs1nF/YHehM0FxcN++dGbMxXlEyTz7JQvOmjupfgQ4q1Kk=
X-Gm-Gg: ASbGnctxOszCLtQ/Imqth9ioBzFHrGSUg8LHT8kvt6/bCnTvJqVdK204/f/AB2vrcNb
	yJuwWLzedmAslbCO9z6iwZKkIiDOnJuc3lheXZamNwmjnzgVeaVap/+Lu6BAectuaksk2f143VL
	PsBG0ohtUWZL1NwjTBfw9Z9VLeanCioJbhQZ3SM6V3zZtXacmjV/A8VYTM4zt+LUcNUcOh3Xh/5
	GJ/MGnfxahEmgzWHxCWhJchvEiYneAYeuCjuZGlPNrZ0vHJoFyT4bzJQd8WvWm5oVCG2HgXEoSh
	bhkDGnBA+KW/6HFT2r1dyP+wDschU7mkog==
X-Google-Smtp-Source: AGHT+IHCqlAmBeWIh3RQpDK/wqa/aOOAMFIkBi6CvjLI3mDlej3LMKvDj2NLspjgKzRYrxIEx1isLQ==
X-Received: by 2002:a05:600c:3b0f:b0:439:8c6d:7ad9 with SMTP id 5b1f17b1804b1-4398c6d7da4mr9647825e9.31.1739787540052;
        Mon, 17 Feb 2025 02:19:00 -0800 (PST)
Received: from [192.168.68.111] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43970c8fed9sm35658385e9.0.2025.02.17.02.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:18:59 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
 Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, iommu@lists.linux.dev, 
 Daniil Titov <daniilt971@gmail.com>, Dang Huynh <danct12@riseup.net>
In-Reply-To: <20250211-msm8937-v1-0-7d27ed67f708@mainlining.org>
References: <20250211-msm8937-v1-0-7d27ed67f708@mainlining.org>
Subject: Re: (subset) [PATCH 00/10] Initial support of MSM8937 and Xiaomi
 Redmi 3S
Message-Id: <173978753882.27418.10124969396742370731.b4-ty@linaro.org>
Date: Mon, 17 Feb 2025 10:18:58 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2


On Tue, 11 Feb 2025 23:37:44 +0100, Barnabás Czémán wrote:
> This patch series add initial support for MSM8937 SoC
> and Xiaomi Redmi 3S (land).
> 
> The series is extending the MSM8917 gcc and pinctrl drivers
> because they are sibling SoCs.
> MSM8937 have 4 more A53 cores and have one more dsi port then
> MSM8917.
> It implements little-big architecture and uses Adreno 505.
> 
> [...]

Applied, thanks!

[06/10] dt-bindings: nvmem: Add compatible for MS8937
        commit: 07d914dd683f9ccb62a530fad76c36d5d4e6d894

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

