Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E8B1E32D7;
	Fri, 13 Jun 2025 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829473; cv=none; b=XmXUVHFOJrYRiBY4kESgYyUzZysraZ3CYAcFMFSeQeUBVYUZgZK4HXy7POFa6B6S7lLoFkblX52p6USRpNKG3lIhwqnwNxQPVF4Niroa2nLx7xqIBx/bp3JW0PAFZIux3zxAKoLxsrX2TCjnNp5yqkMrJakr2mS68RCCdbfcDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829473; c=relaxed/simple;
	bh=cNXTOY+jw0QaNec5Dnl+hrHqpRXE5eXNgvUeICWzwy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0mxhTpJ3adQXlin/g7RdVXSgOdobdWFgbZ8NtYONHVBCut7D6dpPscbf956MiW6YTnDbIijHB4gG9J73L0IFX4OKrxeutnyBzXMzoOJd8/Bxpcutdlt4gqxwb+RbMe7sB08apA+Gj5FWIMIAZ/daNuhME5kA8anmmkfc9UUnkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1jNK5jx; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1jNK5jx"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so2166770a91.1;
        Fri, 13 Jun 2025 08:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749829471; x=1750434271; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqIM8HZnplhZGKcbWU5pZbbMLNhFw2iwzIjxpnBgMKw=;
        b=G1jNK5jxwLXl7glyWQlnlzMmtty33w4a1zwY+aeduA+pOP8y4UylDHjIUBKama3BqR
         eRPiqwt7xrlykrZLWn37eYB5LkZ3whaqN9/4ea+dTKVYT3PBRNf8J3h9LUEG1Cz1Lqmv
         dPbwf55IGhTlgEY6amFZSD5exIjqCjVtun5917KM2oZdPQU0IVijN/rzcMIkHHZJvrXM
         ChqTXhyHXcRsKOGRVVTL7LZxUOn4wbnajm1JIrI1vs23qqhW81qXgx+ve2TNKkHGCYCQ
         pNJmGiYmyxUwVLtMhcNfu8/YGvN8Y7lZS3/HegiFmncXe7J9Am/u8tidl7Y63cxFy215
         s7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749829471; x=1750434271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HqIM8HZnplhZGKcbWU5pZbbMLNhFw2iwzIjxpnBgMKw=;
        b=e/D9ckYon6wFEilVIYviWjDOtW7Hbp6HAhdjwqTZgOJFOMNjJR0SAZIDB01JGE85VS
         owe6870mAk+bY4oYJGIhJEoDinsT/IiqXMbcdwHREreuxJILS6zo34SYNQXgE9v1W0UB
         uNKNVrwDqtWsZeNecGWsDQ27gzHYkHYrdLnKh7kTwqL+EDsIUIId4RTGqyZF4mnRDKIX
         Koy/BG1/65iNC1V04XJuwV7B1E3BbS21QmL9x+EdWfhGPap/LncC2YyAcVce9OPfrL73
         YklvedYXWMb4a06H58hlc/LXczi6xuzkaiDOF2mZHyTHt2MvgcJm2JWbMcWwlJ4FUACd
         lDBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEcsilY2klqL6pR7f3cQrxVo8KSODE/myAMzHInzkv2C0WtQQP4SETfRsQn3HigTVdjcrZoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzonIcZfPS9l8TbpPnJCGtpTek8eosaX71q9lrJFlI75+UqzV/L
	NrS3F4sFCtIkR4WF2SLGtis8vi8cv5tZP28UlW8wzvyHfMc41k+mheBW
X-Gm-Gg: ASbGncso+JBUVJtQWIrTKFvKnFStmZYeoHhND7NmUvMzHJnk2NZvS0wk6rIB6z733zP
	kPFMOFe5uOONP0KsaIJFxuXgecrV+1Wrf1HGbVZtPLGimkcH/Aga0Ofi6R0WYR1gzLqqd9QWwm+
	CJNCF1G0XDnlFJPQGr47sQW5p13B8NDRk7JVfQYTPUv+bLd9EcSn29fxRjpsq2LTRRobBZyah3n
	IZ6krWwMRnZfXyJE/Cgs7NEIL367dCZPUjQjObwlSA+FkRm8RoR6fxx55+dliJcqxRpMxjRfZWj
	Ei7eUqjsAMf50dcNsR3Ik3o7C442xfu+C4p/+Yky8DCP8PUhR4Vm/+iJNeZM1rpcZe+Hlui8Co3
	+tg9M/2h//cB46TE5pvR+
X-Google-Smtp-Source: AGHT+IETWJC1IioWtKneuXgORMThHBGBuRQvos+ZKLhO3L/RBVH0UX1pCYDwIQm0SyCgDHjVsMUOBA==
X-Received: by 2002:a17:90b:350a:b0:2ee:6d08:7936 with SMTP id 98e67ed59e1d1-313f1d58ba9mr197515a91.20.1749829471051;
        Fri, 13 Jun 2025 08:44:31 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dea8fe6sm15767125ad.164.2025.06.13.08.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 08:44:30 -0700 (PDT)
Message-ID: <b99e93dd-6cee-4c9f-83a2-faf66828f6cd@gmail.com>
Date: Fri, 13 Jun 2025 23:44:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] arm64: defconfig: Enable Apple Silicon drivers
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org, iommu@lists.linux.dev,
 linux-input@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-sound@vger.kernel.org
References: <20250612-apple-kconfig-defconfig-v1-0-0e6f9cb512c1@kernel.org>
 <20250612-apple-kconfig-defconfig-v1-11-0e6f9cb512c1@kernel.org>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250612-apple-kconfig-defconfig-v1-11-0e6f9cb512c1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Sven Peter 於 2025/6/13 清晨5:11 寫道:
> Enable drivers for hardware present on Apple Silicon machines.
> The power domain and interrupt driver should be built-it since these are
> critical for the system to boot, the rest can be build as modules.
>
> Previously, many of these drivers were accidentally configured as y
> such that this actually decreases the size of the kernel image:
>
> vmlinux 163628520 -> 163330632 (-297888)
> Image    48388608 ->  48384512 (-  4096)
>
> Signed-off-by: Sven Peter <sven@kernel.org>

[...]

I think you missed these drivers (all of which should be m):

BACKLIGHT_APPLE_DWI DRM_PANEL_SUMMIT DRM_ADP NVMEM_APPLE_SPMI

Nick Chan

