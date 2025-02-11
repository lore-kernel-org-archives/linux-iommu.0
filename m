Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F94F1E500C;
	Tue, 11 Feb 2025 06:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254064; cv=none; b=BGy0+a/MUzENQU1MDqytha8kGo4GbCWjuKKmMv6LFj/+/TCVviB9pnxMtbBtds3PzYxePfV+ZPi0Rx96RCIjaWP8Jfw233hQ2poKPIdSRmCR1ijkY6mslxX2nOmvE0l8KKk8Zqr8rX2iO6dtvxfuoo9ADP/mRZqegEJ8zUaej0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254064; c=relaxed/simple;
	bh=eZCYBoaijxw4u7sSmxmhwO3Ew2yN/pa2fTKBphMnoEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2GGZ9vePH1wnxGjUWbwBFbajkWua6SqhX3be+clpLFWwfZ+i9XEUDgGgYHlJrXbacD4s+nzE6NqjoXEIydLOfoMlavWFsV2VMuVpG68s+Li46qr/IX8uKaJ2F7cfFCPqDvXQR+rVP50yxc5G2hTjNuq1dyEc2CTGYadRyeL2aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCcKrxki; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCcKrxki"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f3e2b4eceso97362255ad.2;
        Mon, 10 Feb 2025 22:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739254061; x=1739858861; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZCYBoaijxw4u7sSmxmhwO3Ew2yN/pa2fTKBphMnoEU=;
        b=YCcKrxkiMFH9set6SEtp0zUQDse1EMS/fwu6G0/q0Dv5dZy4lUImFhY3z8/0Qpvo4m
         aciVU5V63/vN8QpsYrJfbKMU0nu4dTxGGS8UftzpIUljgcmofUqTf1lH6MkaXCYZGjKU
         8OwAfg5in42ECZk96YYruZx86UDP9IG3Xcvw4oaB7BW1mUxiYqQH2ZJaKIoA32/mHZDt
         NAMYh5+1iCtBbZotEvHhmS/bVGPNEBdHkmnGG9p9zIPPZxMsjPwAkA7ucACuNRxW5Puy
         3vkDpTfxIF7I4D4S6U/PBhoGZM/0oOeCsFntQfETYrc+jFdqiMHNVlvv1F5mJ0Yw2Ois
         om2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739254061; x=1739858861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZCYBoaijxw4u7sSmxmhwO3Ew2yN/pa2fTKBphMnoEU=;
        b=I3t4RuSZMJFpgwRrK0AjiDwveg05n/V7/2+k0ORcAJcbC/8VwrZ+IZKjNgIJ7XYZgx
         0qiaIbRxVn8Y4Pji2K9XY4Xfqg1Vh47gb9CMygIAOQjL0BRcqpONnSX3yUmvIOAwmP56
         tkz4ynhNAg7wTPuTRuDs3I+k5TvB7daupndQ4tdwg2O9IyqoT1KrqylCcuOZZDh50AMx
         gs+oClQNlUQugSc0wTlpKL9NwKpJwKb0LMfoLtHDD7JLNZatPc9Bq7Rxn1LP/NgY7Bsf
         W1KcioQ2zE23Mi6dgb3Ep3xE+7+OpEYvNhVKe2kR1psyyzQ/kmlUz+R9adzFjOS1ZRlD
         eX8w==
X-Forwarded-Encrypted: i=1; AJvYcCXeeTz9A6XAsktYNYTxU4sFPWlEvAOn3JkB5uDT1GuJRg7tzm7BWec/ERdLAJUQi/YS8PO74g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+91lH8Cj0Rysl+6bS3s/+HMMXRmsnVQOwW6Js3Torsq90Yw6o
	mfRwsLDzty73rojFC+K/BfexhwZnbISzGtG3VcyXVfZdENkNoRd2
X-Gm-Gg: ASbGncvqWfu1okYsf49ofYj5hJBBs8941L/MA5NkxaHXS+WXSJSdmtxiKy2Vf7i+Va9
	klFs/npiPKvQxeZkZGIPuB5VbstsjzJhMgNea1yVYg5OT3c26bTwAMJ/qM6W9bcSBKKy4+qe6S4
	TwIIperK8FtCmD9MlfTDgsJUu4bDAQqKvpujBBgN1gfAIabXgaRX4/padSVNCFzi5uMB1bPP+Bp
	zqRGzQDdHaJ14Ua8ADGK9fr28DPZGnKuk6AFq5zuyBVU7EpIR7EPrj4alrZ9zEnw5+Pf74AoUiP
	GsNctbmWgX6HcxA2jqAoyYJGNsgTttCVJf1f1Xwly4Tg1g==
X-Google-Smtp-Source: AGHT+IEXZbVvFHUebNOQTZZuCtmrL4QARTAUGAoCZ0Io2NendW61xrPGBTihSLTOMP+6ldmhBpF1jA==
X-Received: by 2002:a17:902:f60a:b0:212:63db:bb15 with SMTP id d9443c01a7336-21f4e75e5famr272057935ad.38.1739254060656;
        Mon, 10 Feb 2025 22:07:40 -0800 (PST)
Received: from [10.89.236.32] (wf126-032.ust.hk. [175.159.126.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683dc35sm87436575ad.126.2025.02.10.22.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 22:07:40 -0800 (PST)
Message-ID: <5d82d549-663f-4438-922a-6831e57e80b5@gmail.com>
Date: Tue, 11 Feb 2025 14:07:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] iommu/dart: Reject identity domain for locked DARTs
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Sven Peter
 <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
 <20250210-locked-dart-v1-4-5d97fe247f35@rosenzweig.io>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250210-locked-dart-v1-4-5d97fe247f35@rosenzweig.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Alyssa Rosenzweig 於 2025/2/11 凌晨3:39 寫道:
> This cannot work.
>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Signed-off-by: Janne Grunau <j@jannau.net>
The submitter's sign-off must be the last sign-off. It appears that you are the author
of this patch, so drop Janne's sign-off.
[...]

Nick Chan

