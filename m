Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795515983;
	b=FTiCxAcUAbN7xfwa887AJElvLSVhEzaCyFGXWeGho6ia+JrYF7X39ajvTx9HNw5m++zs
	 Xkwz3FiD3bmjAdUg42tibVIUVOop7+UtWHYIObUx/zMPJbQu6hOXgl47IG2xObLgnGTcW
	 wX3gh2CvyqpwPoX3SGtKfsktNj5503LzrWNq7k75ecoIMCqyb19OPS3MMED9M9oSMJZKx
	 jNM+MW6C1mM1Lcsclw3cAokHevwBGx1sGif7Y0O4fwNieuP3El1qTodLpcyJ1iqL0QtO4
	 JXm+XanvQpo5I4d0ZOfbof3Nv0Tm+UyUeItIkTIx8XeMfrCIYlut+/yd8vxWjI2Lp3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=rjPQj6M4ULtn6j0AWEkFprT+kxdBF0dsfklPDyAkphE=;
	b=dkazxtm0+XMESUcdLUHFqe4nyebJMvs9N+n6y2hbnYCcN/Qpk08a+1H4FbY5tsdEANdT
	 h7kre2jtZ+5GDY1/g1BTSM2hqBFmBgFLDlFrBKNzDqtfSctXuljqhFnsiWTQlEKhBI4uO
	 qcrhqgEBSybzi9lwi/T/wZoZnawKjrf8/6x0hiUG1b7mz21SPQ8Mru01hfwlWBd03L2uF
	 lTYNt0ZLpdr7IHQdXQ1NL/upuK6E+wW/QBGtWRI4+jO1d8Pjo6X8JjWYEZc0bAcjIyllY
	 7QTNPOcllUFBrO3DN2XLoO/HfarH42rCPngKbEieEcY/arrM8G7q8Uwkgf3a3WLPc+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jkZ5repC;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2313606A32D
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 10:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2313606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jkZ5repC
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a42b34e930so3784038f8f.2
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 02:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795515981; x=1796120781; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rjPQj6M4ULtn6j0AWEkFprT+kxdBF0dsfklPDyAkphE=;
        b=jkZ5repCYdS7xuk7iWZX4ju3fTpLRms4FRL7mrxtljBht9AFImdsqO2GaUbLgmgi4K
         iqFWmQihdFO0eF7Zq3dHb6yoToqlwyaDtbknL6hYpVAmDiZb1hpIt1aHGCbNUfRXXlXF
         4P1UythgdqI7YHsYgMYEIUVnojSTDdP54+MG1/PZZZuQDP62Z09tbP46v8fC6xfWAuya
         S8tvlrcRGo05OyomwnDRHINiJE4wBFo3APxgMqctHG1VY8gv46oQBuSICqWCjSbOqgFV
         DhQNiOQdUYR9+2JnE3bqOgDThEbMfRPtKleibr8eCFXRErFrKcudYcYaxyHjci7kXn7c
         J9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795515981; x=1796120781;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rjPQj6M4ULtn6j0AWEkFprT+kxdBF0dsfklPDyAkphE=;
        b=br5ij65c1LY+aZrjd4ioLOaW5N9EU5KDTVQ62WEQvSCQCChfNNAxNIBnVayL9LwhoY
         o+mCZYNRNHOeLWuPuZNSJsfoRZmT4yBhY85H2eWAmH6DupdMyvgdSiUgZs8+aeuZgAbl
         /Laqn44Nqbmzv+kUFOdG0B7x0M2kSrwagAkX+aYgs+EzwZhc6qN7iqiwyh0Vm7hxevR5
         8ZVm68RPEZosxGOcBf5MgRlvxs+tdQSWqc+iyJ6ucT+AQZOqzbDPHRDtO+p0hHyGCRul
         w67bTZDnzivs2Z8Ph4NRKUqiK+eLyfLKXw/Eltu7u+aCdMESxm+Fqqb3ZLSCfsQ8ZNAp
         o5WQ==
X-Forwarded-Encrypted: i=1; AL+hErECNa6FMY8b1nFg1k+7pja5uN3zgwC1Fdv5GadAIReWd6Z8xgaAFWJdnm0DRGK4yVboNmIGKQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+krpDRooUXQlnXuNjVxyJ8Ub5/vUtSEnlFlzC3MHEHjDOW2PQa
	YlbZn/777PRhN8aoWKu1Ln9InLeqt6DCFCFta4sLX0t3Uz9vvSHZMaoTt0b8YpOm0nY=
X-Gm-Gg: AZFdTZfS/g73M49lTisYK/Xyonzo6tzDamBcSW5Lm+jxFjZJFt/56oaKCnfCx7TtgcR
	1mwcC19XuAxuXfO/tZKDmcBA+5L+WUAHFzKGtG8r4q/D+aqZCFMF27ACagHEOD+2XvhRilYA8IW
	sVwTRs5keUTTCxy5GCnxzTBs/OQjMtVrJHBr12fi4MP//nDK3YMxZTGINpbjKucnSV0MXxQoaKN
	wpWUtSEyHSL7Je2eMjajgXEtJAbd8tuYEuQ58vLiXg2+yH5ptPLFFZck1XRYceFl4zbrOhZfoG0
	2g7gnWSe7nep2klRs9dRVZIdFrg4w/24FrnUMXF80KdPNvSLcuCAFL+zxHhNg9kGU0RooGK9NEZ
	H2Q+5C/FBpi2OSCn5gVMr++dghnZpHAq212L9QwhQh+gEtL3jDGsdoR3UoRJncOXMmHTsn15fhx
	CjgQ8GSl0xMAeHlOtEPcuXiToCV+GBwGwgqMGpMPWLyL+yMI3E+LZPkEVm1J+AjOj9KOr+gd+QP
	cEjs7vctg+kh8lrP7uUJp7Z1KsKrIvY1n107hSZCpKUQ57mGTJ9hnqno/y9AxZSDID+ANfmIHrw
	UrMWthB8CZK9Q/J3DWmGtrdboGsFqFEcqsvWLGFRBv0aR4K2forTH1qVgaWztsfc8UpHde2oUce
	Wbg==
X-Received: by 2002:a05:6000:29d6:b0:48e:20f9:8d75 with SMTP id ffacd0b85a97d-4abb58ec00dmr16232655f8f.48.1795515980993;
        Tue, 24 Nov 2026 02:26:20 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183? ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989eesm27197538f8f.50.2026.11.24.02.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 02:26:20 -0800 (PST)
Message-ID: <13dfc467-1f95-4f86-9d01-8a5830007d51@baylibre.com>
Date: Tue, 24 Nov 2026 10:26:18 +0000
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
Subject: Re: [PATCH v18 6/8] accel/rocket: add RK3576 NPU (RKNN) support
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
 <c57db6883bb9c977f65d34569f1ed9cb5405bdda.1795478392.git.gahing@gahingwoo.com>
Content-Language: en-US
From: Daniel Drake <ddrake@baylibre.com>
In-Reply-To: <c57db6883bb9c977f65d34569f1ed9cb5405bdda.1795478392.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/2026 00:01, Jiaxing Hu wrote:
> Add the RK3576 NPU. Its PC_TASK_CON has a 16-bit task number, with
> pp_en, count_clear and last_layer_clear at BIT16, BIT17 and BIT18, as
> Chaoyi Chen confirmed:
> 
>   https://lore.kernel.org/all/4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com/
> 
> Add it to rocket_registers.h as TASK_CON_RK3576, generated from Mesa's
> registers.xml, and use it on the RK3576. Count the cores in rocket_drv.c
> against the match table, not only the RK3588 compatible.

In the corresponding mesa change:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/43804/diffs

You had to tweak the header generator to allow two register definitions
to exist at the same offset.

From what I can see, Mesa has another way of allowing hw-specific
variants of a given register: variants/varset used in freedreno register
definitions. Have you explored using that?

