Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520960;
	b=QmcP5mgDIjDVk5CcSCUrGKgzsaa+ZT4chF8WGxLwVK1KQLwcW0BaDHqdCd1FpnoOBbYd
	 LnvL+gpi0M41Wj5gtxIHQ/RZ9znSb0d0t7JdTO0blSfjn0hLXHYXDt7CAsZ9yzRTxY4ia
	 mujI8jhFlAJk3NK3H8PJiJHOiPO1wkwGLtetT9YzxNLZsTD8QngNqdHhk2l91D2Pald7A
	 QeqXWGEVdvMWMk6B/dLrdCw1YtfNzXYjk9EtcX93S9UOBuMwwnWyUK9nqppSAr9cuqFb+
	 UiiBBQTmy+w9hS8pn0GkxLXw2ajEu7LxaLcNSijZql4hcMGBLC+F5HYPu2RmWqXz2iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=J1NeJEfZebfbcpy8hj3dQLRnIcpIwRmtjjuLE6tESEc=;
	b=2haBPnAncT7bQnGczrgcM5bJcgYkZocgYK31FN54CmQAoWll2xrx8PGxtYScXYoPperd
	 zIHMHsv7PAc2LB5VXYgB1cBTZVAHUJg+zPuYI1sunaXppxRvBug9pPlTEfBZRDHwFGpoH
	 wtJfLy3kkMoKzTgRq96n99GVY8hBh7ySB3npwpUcCkz/84pKyot0KuaR+041wlcxn6MV5
	 7Qln+eqccZo7w4qQ8v80uo4XLz3aAXbaXlNhjJU6+sCevd51m/F/KMU6WMRGodz5gK77T
	 ws3ilznoHHxxz3QHYbNb+nkmiwG7eYMsRanCLTcXYS/ZqJ4ahh4hZ9Pm24VZ24Qa9YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="M3nEu/BO";
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F751606A31E
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 11:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F751606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=M3nEu/BO
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso48120865e9.0
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 03:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795520958; x=1796125758; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J1NeJEfZebfbcpy8hj3dQLRnIcpIwRmtjjuLE6tESEc=;
        b=M3nEu/BO66cD5VBBYCADR5XVKzldnLj1cQhFdif50NC56fVSjbI1489KRKgJE5a+SG
         0mWtaGLuKTEVQJMd6bMrR95YrNqEuztei2/s+wgMmGRf4xnpHPKJ3XKbSuv8FRy6EBb4
         CT04k5n1JcxgyyPcg56jaUnFruMLS6RR6mvsZoQ6IdJtbSAnfGbPwWCFzyIqeZNaGl1M
         sYQmuYBNcoYh2QDDI1lCSGb/KEPvh58+hWDKojIKhxiJTxQMP7k+2Bi5cqbfUmp/V0hY
         cVBy8ubhVlgQwg3KQ8K0WrjgSFXCExhTnpsjPKOx0/klQuynlEo61SuWVu4UUK9mxZOg
         TvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795520958; x=1796125758;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J1NeJEfZebfbcpy8hj3dQLRnIcpIwRmtjjuLE6tESEc=;
        b=uNt8+13gwtyCssZelzC/NX2xDsEBe399JumACRkr4ozVa3XwtRqp1B5gl1orC3f2NA
         3+kAg54B7SyZNJ3MDQ5GhWqzoq2VIgdT5JY13JXxzxOLCWui1X1/Lpn7EW1n2M3gi/su
         qre3pklAmVXX1f2QYaU7zeQ/Is0lmtzpOjQZx7vWY/xOaiS9h9khb065/gwOGH0yEH30
         Ixix233SNuCER2p2BLEkopl/aUVXphMbfqmzmaDT16Rb/lHQ/4dt0vRwCy3TUgJhMoiU
         RnXHMaxB8t+7ikUtRFnsDRUL3sW2L1wV3UmBw5sm4X1jwnRmnpqpOj7TwqME+3V/RWv1
         LqIA==
X-Forwarded-Encrypted: i=1; AL+hErFmTgcvmN6l4bJrsYulCAx1DnxazKJb9TKjmRpqnPUZoWANHLGS/cfqbHaINEREuWXPMqtvFg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+ogKKCIsD8M/b0gX5BuiDDv1TkWYHVSC6fwVMtA3UqGUb07p3Q
	lz3H2MdW4GYEAXGgYAKoUoLDlJmN4MRrTU5lS3ZvPGEOxP7+1/Twsuuub5A/wpPujMY=
X-Gm-Gg: AZFdTZeqSttAEePYZPkXWZUAA8+wCHyn+PcY5hsyq0rBLVchEgv1qgzFykMFNiBpA2i
	zUjJrIZf/elNC4H9NXubK7Y0AVkArkCGA712LR0Z8R5gZx0Jl+5fbXsUVIDeDfRhzpENBmSEQ7C
	VX7R4QQFSOxRbMQcdCUY6x0j0k4ITHlBH0rL6uExpOTuUhIFTLQzUTKRvoYATNQu/x3nG/2aehR
	GT2LmF+k7pTY1jGFlNnPUpJAvNdsjDJ3y49S3wtBRZ8ARxcvbncLnVldsZzJA75CshwdO77l8Nz
	B+ppzw9eZvCtfBkPchHsb3AKFVAWaaRTw+COJVHAW1h+sOHAkMqZLVy3kIcgBOIJ77CeIToKq2n
	aInSA3kJO1RoTX3PxLerNPUdIOIt8U+w1r+fyLpa/8gxW6JFUQwqE4yWND1PuZRLhvsREhxvbfj
	yU9Rfux7pW11O15dfcKpZRl0oqK3F91vjC7JyNzGQlp63u8wNzks6WDMpOBDb+AetKCqmK4ZPXO
	Y+gtLGrIK00SoUAY+vw1yBJ8Ks+ZEOuRdFjETcOpf5NFQ8SNEeDLPaEZXnC15j/4wtiCAWvwCrz
	mazOQsQ8jzmvL1zc1ItRZ+YntLDT/OouI7dyBC3oZZXWBJyyyrhEgWmzGw67QU98H7SqcfCNRh7
	74SQ99CX9B6lyDn1u/L/uuIY=
X-Received: by 2002:a05:600c:b8a:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4bb88818156mr290637705e9.16.1795520957605;
        Tue, 24 Nov 2026 03:49:17 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183? ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm416542295e9.10.2026.11.24.03.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 03:49:17 -0800 (PST)
Message-ID: <99f6fa65-33f1-4865-9745-c092fff2e032@baylibre.com>
Date: Tue, 24 Nov 2026 11:49:14 +0000
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
Subject: Re: [PATCH v18 7/8] arm64: dts: rockchip: add NPU (RKNN) nodes to
 rk3576
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, sidong.yang@furiosa.ai,
 ulf.hansson@oss.qualcomm.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, chaoyi.chen@rock-chips.com,
 shawn.lin@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1795478392.git.gahing@gahingwoo.com>
 <f1d20ec832e10a80dc813aa10697632e8024a685.1795478392.git.gahing@gahingwoo.com>
Content-Language: en-US
From: Daniel Drake <ddrake@baylibre.com>
In-Reply-To: <f1d20ec832e10a80dc813aa10697632e8024a685.1795478392.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/2026 00:01, Jiaxing Hu wrote:
> Add the two NPU cores and their IOMMUs, disabled by default. Core 0 is
> in PD_NPU0, core 1 in PD_NPU1. Label PD_NPU so that boards can give it
> the NPU supply.
> 
> Set CLK_RKNN_DSU0 to 594 MHz. Nothing scales the NPU clock or voltage in
> mainline, and the boot rate of 786 MHz at the boot voltage of 750 mV is
> outside the vendor OPP table and gives wrong results; that table runs
> up to 600 MHz at 725 mV.

I still struggled to understand this (particularly the choice of 594
MHz) even with your notes, but I think I got it now. Suggested rewrite
that will hopefully make it easier for others:

---
Set the DSU0 clock to 594 MHz for now. Radxa ROCK 4D boots with the DSU0
clock at 786 MHz with a voltage of 750 mV, however this gives wrong
results and the vendor OPP table suggests this voltage is only workable
up to 700 MHz. The rocket driver does not control the voltage yet, so
594 MHz (GPLL/2) is selected as the highest rate that we can select for
this operating point. Voltage and frequency scaling could be implemented
in future to more closely match the vendor driver behaviour.
---

Please tweak something along those lines, you can add my reviewed-by.

