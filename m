Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004912;
	b=rbO0aTMUpG3LpOu0GDM4dwwjA81JybswkRbEC5mFhRYtufdTz962CqhhcYehFFQI+MuB
	 iQxff2SveSdG7DMD7Gt8cVFcJ4D/8ANLsF6ouPPOdqnj6ShaV83Yo7VEEwigIAho+1ojK
	 1z1x/PZm3yopNOFQRAZQaQ95leWQ0ZdL6ba4YgpdEq1Po7JJgw6+i4+0jN2+Mp9ophfhH
	 jmYxXoIDGRocOaIkQdc/pqU8ELTXfWxMe8nbjB+MVhfQBtmBO07R1zhLLtAZ1TJm/jms8
	 RbMYWIzqg7/597j9SELbb+1eHysyTPN3J2EkYs/qwWN38m3zWu3lOVFh+6gf1pZ6lUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=fApH6YF8/olwr8rszx1618Se8LLbeSsWPgcCTgBcSzQ=;
	b=svgPFWoMObaK4w0kLdoA3fyl4zwjuwZY7wpaieOAxZCACNcJP2bEc0qHLPweuNm+y5j4
	 SUy7zBJgGao5atEUgm/WfoFEk+2pbMFwH9mGh9Eak+4mOnA333T2dpP0pNuu6ztG2dA7t
	 5zLtwkRGBtlJB6zkbrD3vbB8GXei+ejwsk/x/wgD4GyY84WawStoqRd9aCUY9pCUtuonh
	 GHdtqrQ7WseYsNUnIuatNf7DF0m+0ftDYOZ78SIPqJubsT8JKsTHNZEJE3kfL4+jO34zj
	 q18cF3LGvy4+4dcE7KJubq4JzhkMkybSSHM7+/cv0JVn4Wg+zezcbPFUKhgCke9YvPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=f6miOyBV;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C307606A330
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 12:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C307606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=f6miOyBV
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-491971ac844so871160f8f.2
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 04:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795004911; x=1795609711; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fApH6YF8/olwr8rszx1618Se8LLbeSsWPgcCTgBcSzQ=;
        b=f6miOyBVQlF/USL2Rffh1peMrTrQIgSHPXoIA92qR1Vh4if5LJHta7OMuFlHYLVCuY
         9mUE3IFTtjhSkV8/zT09LQDb9uN7XgyR57flfyRRMtfmqVd0m5umx8aY9Z46pZxUuNfa
         9qGHe68oxxO47jV8BaEpO2Axe8GgeEhoh+pzNJuABQYNFaSMiKc59ljq/cfGIY49zgLK
         9X4MI7tE0I9IPTf0D0Pkek21IbEaizwyBM2uvNfrEf/YvbKnsGDZSyg9TG9PQOq3gKYJ
         gwAnMKw39vYx2HjRehAN7qSwa87tnBZb03kzFOxEKMNUZ5kYFvnX9MgqjxnUjTgrYRxN
         w9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795004911; x=1795609711;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fApH6YF8/olwr8rszx1618Se8LLbeSsWPgcCTgBcSzQ=;
        b=dY16KgFJpL59rMjxaAnHLPAUWcsxUYzLi7IriwaLTV5Y0PAL83fD/DMmzGUO4Esu+3
         jggipqtjJEEnzJVn2lpIP5NoPEpeqsEBbIWit+141W9gx2g9H+pf8eO3KFzCpPYDRno0
         /D1b33N/MX5g3FrY3wCtWxaOC9y6dbbjniz+nR7nF4fGb9Yl8213VCkAccfJimUSYLLP
         tT5OeDSx+JnvmXgr0Auzydpq/Yh0kRbNJy4W4+4kEE+4Wo0Q6C31CN2nhnrgURmzIm0I
         M6Q0ICUTqPbbmGetIi4y/BMGfJrfQls/2QHdoJ2+VI+Wyj7IQQiBOJz00q1rwwb2ahFL
         A4dA==
X-Forwarded-Encrypted: i=1; AL+hErHhocN39qdbhE1B4fv+au8DXyVtbBHaIDGQ+8A64Z3HdNgDf+75ebDo9/5lTfR9NVwWPrDVUg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8REzr0SDrKzYsG51S95qEcNLzNYBeC/OESQ3vXsetKuQ38qSF3
	9pucQMiyaqA97cYpcecM0dPhE4DvfYPpDYcvXsaHucK8YAdVhvL4ElRpXvEm8LvlS3A=
X-Gm-Gg: AZFdTZfmMGDX208pVKWwbEhb6mUrVzlLxoFdvu6oFliEb7zS4ZMRV4TkVLj7e5OY7Uz
	aGwNVSYkH7/sCXij5j8BBucvJJCcZ7SSlcSi0E7oH+wa3/GvfgOccQ4J7a0gdqcBSg7vcj2h9th
	f6yZTjtERRY7Tz/0rvgt/6yFha2uXAetUbuvt5x7hvB2KvsIiL0veztETnpNkueJLVk+JwQvAuI
	HERSWttoceX6K/1Pa5/hZ3Jd/8Y3XRv7l1JoTXzmJkGS+QpYpvLE9t/1cEKPWQkML7X6+YPDp2L
	wDa7RMr5jpOsFGQunlcQqV8g594/L7W0JFtEnIcFPfIwCAnGmh4EUD0Ya1gXfkZ303f0qmwKliP
	XKu3KIGNzTAX0nHy6dK6nOb5IIMYRm4rZ2Dh8TPRmrHQC9f7vJ/eledo/YP5qaSLnwrR2G6gWbY
	GYoEAcJonFRrk1iclUZ8h7Aoe0KQHilf+Ec9n+pkMSeOQQ6rolBv7YG2PNC69I0UJ9FzkGYu5OU
	s/DO6IEd/xCCK/8QK+eEIpprpmL2BVrFidnMijnrCKe5RNhke79aBy45wWBSgqhLvB4aIj4uWJO
	mYqLDrGc3pJsXCGgeLnaibTbEcMku95Nl4nGuRY3eO892B5I1M+D568f3FZu32HrParaphsLYeG
	afQ==
X-Received: by 2002:a05:6000:2f86:b0:4a6:63cf:99a6 with SMTP id ffacd0b85a97d-4a663cf9ae8mr4421294f8f.23.1795004910709;
        Wed, 18 Nov 2026 04:28:30 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183? ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c406sm4567452f8f.14.2026.11.18.04.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 04:28:30 -0800 (PST)
Message-ID: <15dbc800-ab4a-4b98-8f6a-95d2ae80819b@baylibre.com>
Date: Wed, 18 Nov 2026 12:28:28 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Drake <ddrake@baylibre.com>
Subject: Re: [PATCH v17 12/12] arm64: dts: rockchip: enable the NPU on
 rk3576-rock-4d
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, ulf.hansson@oss.qualcomm.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, shawn.lin@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1794615324.git.gahing@gahingwoo.com>
 <c0d64d55586774802bdd70defa016be6912ab83e.1794615323.git.gahing@gahingwoo.com>
Content-Language: en-US
In-Reply-To: <c0d64d55586774802bdd70defa016be6912ab83e.1794615323.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14/11/2026 03:05, Jiaxing Hu wrote:
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> index f068794e48d4..72b251d396fe 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
> @@ -779,6 +783,24 @@ wifi_en_h: wifi-en-h {
>  	};
>  };
>  
> +&rknn_core_0 {
> +	npu-supply = <&vdd_npu_s0>;
> +	status = "okay";
> +};

I can't figure out which code actually acts on this npu-supply
regulator, even after considering the patches in the "pmdomain:
rockchip: RK3576 NPU domain supply and settle delay" series. What am I
missing?


