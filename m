Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795004887;
	b=k+fjXB++6Ikeme2mVbnMjwEwq9nRGc3ptufi+jt4mqWg5velAIdTsAOPXR57v7cqRkoE
	 ND5JuF1LWcfgLp45PWsr1arJ0LYOLP1QAwEuRe6+n6vW3Xvj8ufuWwKhHzj5Y3cRYSalU
	 nt6xbwYAr/qeVUX6mYD58aZEhs5y8nODfcTM18Eaov+Eo4Uxhpu8I/Th8G7ae8NjOJjzD
	 0vxnRYPx3wm5o82b6wJAgx44Co8p3dclFt+d4UMvvQQs/H1DE4gJGN1CNuVRzMvfQd5eq
	 VOXQw+p9H57nvcnFPzvVDrLq7RxtT2+ARUw0/biCz7em9i3gvbSegDNLWajmGpYoJKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795004887;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=8ByWoUJOn8xt5bIjc/DgDVb/Znhr0IJHP27C3VPG/e4=;
	b=4oQY0CnAk1/Iqh+CS4hOhpVPMzMdat0wJc/We9ZqOZnVPnNoZrrGvt8ghgtt2g4QjAAu
	 MLcNc5VD8Th4dLDCV8mhxvgXKLEzba2yZdbfgjbHbZIpNP5sraw1UCh14UOdZ34z18b2s
	 R2c8ASNSIkGV9YNHg/4cZXGIVeQ5JLbvlPWXEkMdI74BIaDbwYBNLcNE3oTZhtTLGK4Ga
	 20D/3vZZxlwtMFXc/7izT2CvUhZOsTtonvG6+i2q7H8oSWyF8extOX7GbUzWauWuZaCLs
	 iJ43gk3jOqlUl3ZR0oj8eyWsUwMR2TRF+lx8MgfovT3bLkIQWndcPHo0NDrRMxOroXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=W0tCMrQE;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEE0606A320
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 12:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEEE0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=W0tCMrQE
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so757134f8f.1
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 04:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795004885; x=1795609685; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ByWoUJOn8xt5bIjc/DgDVb/Znhr0IJHP27C3VPG/e4=;
        b=W0tCMrQETPSDRkFi9HVXcTrXRUG4NCXMB7qnmKHZzVc7yocoejV6JlCD3eeqN0VDYa
         hIQLdONHWHOQPR1I1w5MHF2BjQg1lnlRcM0xiD1zByO+MJf++FPsVTr+KKsLAm7QgpUW
         sBzUpQCNSlBY7REJL1XlNGq4DrjPZPsZCnA1k3k/+WXECsOaiQv3cpN+7Hfd46Gh6USk
         2yuF7DmDqaxX7jFvh0DshPh4/26boV+LKYRMqUB1oVYno4IxT7MTB/pOwVkvDdbnPoj9
         7GEtKtoWXMvZdHX7BiMMZdNykiTyTRuElGMCOYzAZWHNn9pI5uZkehKKVPpxE8/W2jPg
         WwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795004885; x=1795609685;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ByWoUJOn8xt5bIjc/DgDVb/Znhr0IJHP27C3VPG/e4=;
        b=aS6SbzQpUjsfaRvVD9fjbzUHDuysh2NAZbWRjiAX1+KPnFe5PZ+n+BmSdw7jyiaAxo
         TXbI09XA70fmyVrdixd4uKATU1j/Rw0OlLPXcQqT8tezpY13GkZaYwVXukNjS/QCLL15
         IO/Ym/XE30liXR0oAlZsrjLPAB64T6cEgqAne6qZiph1IDzI7lSrkWz8Gt22VZwHYdxQ
         u1oW2L9yf7Yb/yltAJQd20WnkX6vEPe7bJO+PM/RybkPE1W8c97cFdNrjrsf5ZJXCBF/
         xovRARk9wr+ZoeyhazilHvLz//uY51jelAPj0A5+djUI7dc2Ak4q8/CnsMCD0qdDabhX
         +xMw==
X-Forwarded-Encrypted: i=1; AL+hErEauMx6PXjhpMLB7esr7MMLODqEsHR2+XxrlT0CyQ+cNOCms/eWQQbkZc3cAzT7gMClzrwReA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/PyZg/EV2WvGtcK/+SeCaOPmlnJEzn/YMRYODTqs5tsFgXrSLg
	7Fi+eHeWh30HWyJC++SwLoHLmzz6ucFIgE42os+iGon70N6C63T/3PP4cG5E5dgRPHs=
X-Gm-Gg: AZFdTZfVVgAPluZAV3STnkt46WoCblb2rJK9jZRUt0Cq8RgpJIQYxiTEqXZ2dSO3J7b
	ya+CBv+HqBzu0RgpOGWb4tWOX1LlRY5uQ1l6SFzwR+f8jrntqeej2WcAH7W/NJKPR6xRm8Mcx+J
	R7z4Tl6oPJgdUfl+ff4nfZInkmgiLfGB28Jyiw7CRdButhbuFPKT4Wbgv6jkhjzytRCwqHdwa3F
	Dr8SACZm4BvFBiiaJgORC2p99B3vp77DoeXNcUOlJEXJao49mCS6PjJLldpbf1EUzqgrYHSJYQN
	YW4QpbkHk17q9uGmwjb4D6cKhQUt1rgOh1lwCo80NptRUVwvUBVRWoJssCskdthOolRoimAX6vC
	R+VcIrYplsPz6FEazEwz8l+jS9KspZQsyr07LVvvJtz6CpAJ1OACLXGS7fW6eeWLFU//EGpTFpj
	X6mySn3JEwKYpUmgENthQvwaoDa5mbsNWu6mAXY4GuxYNjF9/tLVMMsUu7foG7JmfRg8CW+zWRf
	t/cIFYuMLOhW5FSW1FyRfL+OTAG154PtTNL7OY6qHVFbCbU6PWiuO+CniLRa9Ve+6rPBFL4C5y7
	tzCHsHsiWzS/Luus6FWY8J+FLCr7JUNYx6fFTZlLjjP0kFZDwndQ4wfhtVDh4VGPGejazwTClVJ
	zKA==
X-Received: by 2002:a05:6000:2608:b0:4a6:8012:198 with SMTP id ffacd0b85a97d-4a6801202dbmr3938687f8f.31.1795004885474;
        Wed, 18 Nov 2026 04:28:05 -0800 (PST)
Received: from ?IPV6:2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183? ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4011448f8f.12.2026.11.18.04.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 04:28:05 -0800 (PST)
Message-ID: <c5068359-e155-4374-9f3a-1b89106c6fb4@baylibre.com>
Date: Wed, 18 Nov 2026 12:28:02 +0000
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
Subject: Re: [PATCH v17 09/12] accel/rocket: add RK3576 NPU (RKNN) support
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
 <57874e7459ed84ad47b2e31a62871ff535da249b.1794615323.git.gahing@gahingwoo.com>
Content-Language: en-US
In-Reply-To: <57874e7459ed84ad47b2e31a62871ff535da249b.1794615323.git.gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14/11/2026 03:05, Jiaxing Hu wrote:
> # Conflicts:
> #	drivers/accel/rocket/rocket_core.c
> #	drivers/accel/rocket/rocket_core.h

This needs to be removed from the commit message.


> diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
> index db137e2ec15e..868af86d00ce 100644
> --- a/drivers/accel/rocket/rocket_device.c
> +++ b/drivers/accel/rocket/rocket_device.c
> @@ -9,6 +9,7 @@
>  #include <linux/of.h>
>  
>  #include "rocket_device.h"
> +#include "rocket_drv.h"
>  
>  struct rocket_device *rocket_device_init(struct platform_device *pdev,
>  					 const struct drm_driver *rocket_drm_driver)
> @@ -27,7 +28,7 @@ struct rocket_device *rocket_device_init(struct platform_device *pdev,
>  	ddev = &rdev->ddev;
>  	dev_set_drvdata(dev, rdev);
>  
> -	for_each_compatible_node(core_node, NULL, "rockchip,rk3588-rknn-core")
> +	for_each_matching_node(core_node, rocket_dt_match)
>  		if (of_device_is_available(core_node))
>  			num_cores++;

I think it would be a little cleaner to do the counting in rocket_drv.c,
and pass it in as a parameter to rocket_device_init().
Then you don't need to share the dt_match over two files.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> index 68df1596014e..59a6f548e108 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -31,6 +31,11 @@
>  /* Bits 3:0 of PC_BASE_ADDRESS hold the mode selection bit and reserved bits */
>  #define ROCKET_REGCMD_ALIGN	16
>  
> +#define RK3576_PC_TASK_CON_TASK_NUMBER(n)	((n) & 0xffff)
> +#define RK3576_PC_TASK_CON_PP_EN		BIT(16)
> +#define RK3576_PC_TASK_CON_COUNT_CLEAR		BIT(17)
> +#define RK3576_PC_TASK_CON_LAST_LAYER_CLEAR	BIT(18)

This introduces an inconsistency in the way registers are handled. All
other reg definitions are in rocket_registers.h (originating from mesa
xml) but this one is placed here.

I think you should add it to mesa as some kind of register variant, and
then regenerate rocket_registers.h

