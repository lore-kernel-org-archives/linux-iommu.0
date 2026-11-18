Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004877;
	b=h+6t4shiJ1IIuIFyKHy6uI/9RvYxVw+mhb2VQGbCGVq5W2Bbya26f0BdMkR+j3C3648S
	 K0j1ULBTeZUsGFcazm9E0kTd9oT5c8woJfdY/m29d0BP09fr/yooFKkj7J2awpPbSGCAj
	 mp4YHYJ26HZg7aOOOcMzJzCZlZvn7Vh7A4GvvYtWux3jiCrvMff7AMkqvz1xtQzphy5pv
	 a4VOXGyTvqaPb9fQ06MibVNoOWoI7zs+EGKtPdabt5Et53INCTqcN89aHT7o30kbWi9bM
	 0fYbM9iDfbBhPEU0MhKHJDrwT/JGDg+Lkgl2KYDEhmz8JgkI2SbzwDHDBx+0KsF8i9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004877;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=pWhnfvWenZjOfquzYUSnlcmZobUEBcHEFf7Qs3x3jIo=;
	b=ytdOX7fSgVl3DELOQxRx01HpIuTn++sOSJT/zUwNimshiF7kM+od0ekCPlCNn2JG19Mq
	 xFnM6EmtSdzectWfLOCU1iG9fWaH7ua/MCdtlpiDDDv4tjf0H6iLRmtd3PdLXZH0Bd2tr
	 6FqviWT6KY2X73M0xFR+IU8vRUnAJQInGg/bunyQBuzK/foHQbqRnUoVwOV3ATjcq3fBF
	 ydNn4J1q3aht6QZJmYPXCr/4VmzrRXEBc6LE92gPRdnrtCylnMqF5g3K8ONnpY1b977rL
	 WB8uidtJv0g129j3b8a5z/YURFrNcpXFScFY8rW4+r78UF0uVtldURHCciaJ619f2Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=I7gtpXV6;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B34D606A32A
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 12:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B34D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=I7gtpXV6
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-492f0a1b685so603441f8f.0
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 04:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795004875; x=1795609675; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pWhnfvWenZjOfquzYUSnlcmZobUEBcHEFf7Qs3x3jIo=;
        b=I7gtpXV6Z09Hlg+VoZ6JvCrViZoQ5SavmRGaStAKPhAzCJz8A0lAknNHIWcJcBokvD
         jPc05y8N37yK8r2K/UJnShTEN632WiU2MTnebx+SFLTaMzagtMkyrk9nwwe061T2YXd0
         Zr0pF4NmbaMOcdpoT4h12HExeqYkrRvZ9mcUWc/uf8uVwTFvYkFEkWqSbkZ77j+Lr5ih
         Rac54fnyln4FpJrB56LZrhKhKpk4a9SFiyF+tuLEozbkwzT8/KsoeaNq4gCK5DgExDBO
         38RIcOjguv2q2zdfX8Bx/OhE8NMfMu/FrAGDCyCCfooi70tNPS7bsbQ5CApVTTr0Nnhn
         CZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795004875; x=1795609675;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pWhnfvWenZjOfquzYUSnlcmZobUEBcHEFf7Qs3x3jIo=;
        b=lmiGFyZR9EE9ujM4rLjfcqm1sWWF6Yk7tjC0T6t41o5CkO5IiBKRgX0vOMeLaGvOa6
         gIwov4nB0t7Zh/VrYy+ilzBAPn56yLaS2P56aATajdGE+Y0RzadIxMDsp5LZeeqCMcrz
         acINm4si3NRWCdoJJzR10Xg4crOOTonavXnBXohCIE8UkETXtp921IkrsuZ6Hm2TvL90
         6ROn7huY+4jz8gJ5ASloxLl1GOoyRbbcEtaD63CR39kPHabLUQ4l+tezMCSp0XMDpMvE
         ws2RgbCmuDBD8osG5QqbtdbPPswOjSMZEbPVH7A29TUs+l47VL+a9gl9fRe+j/ATbLmL
         GQxg==
X-Forwarded-Encrypted: i=1; AL+hErENWworqBn6hhkNI/UsoGEqWD/8ZCIRQtFJmUDyo1UfmZffvdSleOfpxgK6L+j5Af4iNRgLMA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+3JE4mkm4dzJiSQ+8ynDdqD893D87PFdJaD5a39w6KMt+/E35F
	jR4PPYLY5C0CN8qtPXaPu3jowfPkiO/MOhP2nXIoBvcDdCgeb2bIiCPT+lCh0SL/4vc=
X-Gm-Gg: AZFdTZcbOHAFz9T6KI/8w3hAVPnMUEoWeJE+oKITnY05v0ozETsJWGjkKDlJi2RpR40
	68unegQR2SPBaRc1bss3m80KNiiGZxFM+PFB+JcpmKdtlm40TFEQc1HKwMgFrkhu4m3qADHN6yl
	NvEgdjmkhbgvCZn+sSjroitNVnHc1Wi6+iyT+9NTkaOK1baNazAbRTZ2W9yFa7cJwoa4k3CX+2C
	zAMm1bcAQab5E40YARfeUjkRqqhiIDACd1B2aBoN3jRCtXnjUaJXwxN2Zlu9Q3+GZ2gwRoddMlA
	xehzqxSVgELyLxPvkeqXJ/1MGhVyrOIQ8EfvJoWcZ9Rj7qkhmXCkP925g1XSl+GhiB+0c5LUwNv
	n1znXy963xZWK+NHnAHy5qoMs8TroQtkdChlryQfdBWCzSJXGA7yvskaEPWu00E+Eigsy49OIWW
	EcltIQ4ALsNEyz7wLMBky9SFXc94ZnIUBtmaJRjiOFvIpJztKAvNpcciRziqixyyNJwg6j7ZAce
	44037wDesep3LPW5ctG6NsEbYNpy+7s9AYDm6c+Oj+v2aje61t9aprn+Z9etYt9Nbiw5WclA+YZ
	k4laKbyzsj0AFqdcNuZD4DE1p1w3tENn9ry19YTw0JVNF5xD+N3GMLIqRktFHMh280D9DwMs5yF
	0L6F0xyCHTosqBLwhRBOm9xM=
X-Received: by 2002:a5d:5d0f:0:b0:4a7:9630:7b32 with SMTP id ffacd0b85a97d-4a7963080d9mr2359433f8f.46.1795004875475;
        Wed, 18 Nov 2026 04:27:55 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183? ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a655f9f4a7sm4675322f8f.34.2026.11.18.04.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 04:27:55 -0800 (PST)
Message-ID: <0bcd84bb-6a87-453f-9b68-04dfa95f34a4@baylibre.com>
Date: Wed, 18 Nov 2026 12:27:53 +0000
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
Subject: Re: [PATCH v17 08/12] accel/rocket: select the per-core clock and
 reset counts from match data
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
 <fcdd7117d3d7fe99ea1658c39b6d1a05428823f4.1794615323.git.gahing@gahingwoo.com>
Content-Language: en-US
In-Reply-To: <fcdd7117d3d7fe99ea1658c39b6d1a05428823f4.1794615323.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/11/2026 03:05, Jiaxing Hu wrote:
> The RK3576 and the RK3588 use the same NPU block, but with different
> numbers of clocks and resets.
> 
> Take the number of clocks and resets for each core from soc_data in the
> match data, so the driver uses the right count on each SoC.


Rather than these clock and reset count rules via soc_data here, can we
just rely on the DT validation that is almost equivalent?

Then we can use devm_clk_bulk_get_all() and
devm_reset_control_array_get_exclusive() and not worry about checking
counts and names within the driver.

dtbs_check will already catch cases where the wrong number of clocks or
resets is provided, or where the names don't match the ones expected in
the bindings.

>   static int rocket_probe(struct platform_device *pdev)
>   {
> +	const struct rocket_soc_data *soc = of_device_get_match_data(&pdev->dev);
>   	int ret;
>   
> +	if (!soc) {
> +		dev_err(&pdev->dev, "no match data for this device\n");
> +		return -ENODEV;
> +	}


Since this would only be caused by a programming error, no print is
necessary.

