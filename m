Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512889;
	b=4jcEnt76ljcOESGQ3r9b/FkrJw2pzb5gpX8dMtVMEMxIHSnRWY7WVnzoW0XVTPgBbESD
	 nNs8cEx+WRDzN0c7Ch+YHLal5g6puoy3WYXrjd0Erq9X7Dq4a2yCCTwYzS0PXQBMUIUYl
	 rD5YHptKqpYJCpAFl+jX0Xq16hikp2y2x5uYshTTyUVwxrh7lt30XB16aqllDH+XK4sUo
	 JDcTOpvTee7ax8HOdGLHd/RhmMLv2ncQygkp4ejyc5luvd+wvz72juo7wgQTMNDb+2RBS
	 6EjkgG8hVMVNh4tXhzRDw00XaLx8xAVxNoXOSG32OBajpdM/FBXBLlF58gewZBTrozA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dzlULNiaNZ0xXGdWA1rlfP/03H+C6Hi4qgErNRy8s+Y=;
	b=4Bs+8cGYSNjOk8Ck0ajWKZQAD2avzlCgoyeQ0vsTrAHSNeNZ1uKR0P9J5Aj84b0JJVnz
	 dqIIkhrTsHsdHGvYnH14wAZH5o4S3wo5qATgu08H4J5aeETpBK4Qrn0IPB7BIaRIvZj7H
	 rru1v12xPSq3mmspEZZ5hobMI+icBKga6yB5s/NBWbZGp96K1JsMk2vy/yg3O0NHAw/jt
	 2eTL5jc8e3NLq16Cjan/ZTqB1jp9FtI7uU4bW8I0mGKrWDhLvb/qQZ7cyjIrsqh2APdUH
	 kAcmpQUlaHtXmDiglaG0o42BHFtzGM6tU1QXJF4N1rR9g19zHOeOgLM4q17SP9rT9GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="eO/Jkuse";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4FE606A31E
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 09:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D4FE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=eO/Jkuse
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so33721145e9.3
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 01:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795512887; x=1796117687; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dzlULNiaNZ0xXGdWA1rlfP/03H+C6Hi4qgErNRy8s+Y=;
        b=eO/JkuseOmOeshFOovOwdp8IAuc76UPn2kfB2Q5QDKM1Ft3A82BEilifsTwruFWZVT
         pgyI0A8WdzSrZum08vHSpmirWGdnKIR7d1xXh8zfiavYTYlBJPdiiSBpLIfHHMeqdnEk
         CTGiGDAymm7hbdAMqZbB/WFLek1Ts9vIyqswddUUPjUMQ/mHTTqGkES8RDi+5+5aQc4G
         EbTBP/V5tPYq9z03ugrEb6rtj9GRcooba8ktYvNBISETooeST9m7d8lFGkIG/NQzDjOt
         o2AZaU8cHok6ZmuwtFmz6eoT7g6tt8eWVS+MsnssEMUosSEC1u/TQ/X4CJTn1eZrxIv2
         rP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795512887; x=1796117687;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dzlULNiaNZ0xXGdWA1rlfP/03H+C6Hi4qgErNRy8s+Y=;
        b=yiczYzB1ov1Yl7sppRLNfPI1f38aI+to+z8NT1z7h1/PcMQfcBGKu/u28gJyK4IovJ
         lJj2tx3d3/sRma1epN1GDIDIkAmzuHCvBjY/Yv+mWPBr5dQP30yeN/67wmAWLy9eLMI/
         GXrDlaC02a6akv4FtQW6WLK0p1kTjAG68g5Z1bD3h7SUhi+o89pz68Nttxa7t902hBK5
         +hCQidKtTBYIUnk++Oh00K55/GUGEJDoMTpWsCumf2u4KCzHGplehM1kIq2h43EhMDJj
         qb8tnWFrWjcoYLUyrj5kIrjdPEP75IP6qujtkWCQzGI//vxdIomXfYhJz9zm755h1noj
         m6CA==
X-Forwarded-Encrypted: i=1; AL+hErE1XyYtxddf+e/JGSYWuUeSS86coaqKpaD0Sw9LiBOgX9rHyb/bqzrplOuyJiF9Qant4LU4IQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8QFXIOLfO9KAk7sBKIF6Y4tETagFYwg8uyxccUk4mD7+YROViL
	v6a344x8E5KEtU4yA7q3+uMDaUdLIEEmOTIdyvcqDy+V7ywGUXjp8LCOVWKjgublNfU=
X-Gm-Gg: AZFdTZcti8rmjzgoy2dJWB50dcCabjtQWeSLFfa7F24sqSCIp3FRg70XXREWtZzA9I/
	uN6eR2BxFqPZvl11Nj4d6unEf6U65psRBKd3lDc75nSPaQkH2eCVw3yqD7iBoz55U2AKrjnRY7U
	8tVsk0cjI9i8WFtzS6BcRcn1bWqvi/aj+zyl5bu/bsLm12EUhgCMpe5dWlmRwBQTpBh2vo64mNI
	NUGMANOUMpGwREfO+MbVNqRlwvMH0N+JdKlVoC/gFDmH4sKBYrfRqk8RBEdtJ6qz6CaRxvFkomM
	/57Drakk1rfDEP0ryjaYD/sNoS8Aj1EjRftqH7tGvu+GyafnCedoW1cmKz0sPxtFFB0Fqq9R7Db
	Quj93IyJvtmDnIPMx8Ybso5FHlOAnir7Q/12/+pTeGWHDuSkrBjXQJhvHZ7XR4+i2ZLbSbzbXjP
	22JELvzt4v8uAr3p3PaICUdbBb0/GrULoSqhqM+o0n5W1Gp6dj9xLEMUJGRd8+J8ahtloNzNHan
	FllAcVZ15jD2veAsfQCU1yyB1fYURV+fzVa4jBp7du6rv8IoM2GDK49SrpQT5dW6Xr0pXF/0F5D
	6i7wSl7ezQ7Qw4Pt23UnF1XfTgvDdlsui0l/0++4bIr4UkLkYOt8L8C+qWC75UxcrybCuP/fgW9
	2NQ==
X-Received: by 2002:a05:600c:5251:b0:4a1:f8cb:7d70 with SMTP id 5b1f17b1804b1-4bb8881e837mr267264845e9.24.1795512886893;
        Tue, 24 Nov 2026 01:34:46 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183? ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c50sm26488815f8f.37.2026.11.24.01.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 01:34:46 -0800 (PST)
Message-ID: <57582334-45ef-421c-a460-314f5b5ece74@baylibre.com>
Date: Tue, 24 Nov 2026 09:34:44 +0000
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
Subject: Re: [PATCH v18 4/8] accel/rocket: take the core clocks and resets
 from the devicetree
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
 <82329b6681958350294846c830598ebde29b874a.1795478392.git.gahing@gahingwoo.com>
Content-Language: en-US
From: Daniel Drake <ddrake@baylibre.com>
In-Reply-To: <82329b6681958350294846c830598ebde29b874a.1795478392.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/2026 00:01, Jiaxing Hu wrote:
> The RK3576 NPU core has six clocks and one reset, the RK3588 core four
> clocks and two resets. Take all clocks and resets the core node lists
> instead of naming and counting them per SoC; the binding defines them
> and dtbs_check enforces it. The driver only uses them all together.
> 
> On the RK3588 the resets are now deasserted in devicetree order, srst_a
> then srst_h; before it was the reverse.
> 
> Suggested-by: Daniel Drake <ddrake@baylibre.com>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>

Reviewed-by: Daniel Drake <ddrake@baylibre.com>

