Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436732C8E
	for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 03:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736996712; cv=none; b=rpB6CHdGBUJSQSkKoCkjTEensUSxN7ZyG3ZtdGx0dw4RANBCa/L3K2duzVxU7JTzyyekLGHELdKf0MwoWUlCcD+tR/EP/Xeb/YauwHG1bNE7fszVswXMWBxxBp0HTA0uv5uQ1mXICfOMqL6jHy8CDwSSWUfRow64vk6bhv4/1K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736996712; c=relaxed/simple;
	bh=ndokzHfK9DjzvnQLuIY2/EkLk5z5jVFlw8qOBGX6ASE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYSP/hcOPY1jvYyzNuxcILHSDbHbkRx+E+AJ2DwJhICVNwl6S5rtxN5rbhNhjrPuQ6BGK111BD3+uklbzHS5RjeU3YSImEqwlL1r7w2JTzxzpWt6KN/sDei0Uscyx4fDWT8/FhV0mq7pgVrLjzPTGupc9poMpu56w/YDdx84uCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mJNmIP7g; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJNmIP7g"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21625b4f978so61655ad.0
        for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 19:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736996710; x=1737601510; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7cuWckv2mg3iIR5MCaEBEb/4QCrqfrfbJmqZ9RuoMko=;
        b=mJNmIP7gwDj23KUUEaE3F4HcvGWJUiAWhpupPwRGrTCK8wNo8Yv3iYsvXdKUDUjwCe
         0wHDPnIzR7VJuKlJRCNrko3XEXPjuCjlaGP6+ntVIjYvNzH9Ts2KagUY+wOD/Hwf4cri
         7fX1FKhAjFlrV36gMmfGUeUFNmbOhB4hluixKJFfhfTL/AQAV9ph2iDIJkNaOTg47IZK
         yjwQiIKOhTXFPe7RreR9pPafc8d8fZYqUcEGdffqY878KU33/eZnE9+bSMt+jINB2esJ
         2j7bLWuSbKNIb7J9Emf9u9UKzFxBwaAWONZHiUeQuZjCemcU/1k6mLa/Oj3yyNgTGCaH
         somA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736996710; x=1737601510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cuWckv2mg3iIR5MCaEBEb/4QCrqfrfbJmqZ9RuoMko=;
        b=s0P8K3E++UVVCQFuuhEdNx+05zIG79K5km0DmNPaMlcDZqR9cNpxnmFMZCU4gGC93H
         R89hsL6kMUmej+sRq9u3JCJF1wK67eGsP5KBpJJjz5pJDpUZkUI4/BUFbJ4N7e4ZmVSS
         WfWdMIqGCM0z9YGVKMOu26PC47Vm25yZ1Cf0FlMy4Ne6TPdHLaCPediPwsCwJuGyXPQo
         CcUr3ud3+ZCLzMEm5wqyH0XiPGb387/PgzXuql8ZVsYed7EQlImYOVPsn/Uf613fk4hO
         mOB55blCZmazHtYdT2iEwfPfpaOopJleuWoOGXNZKeXAiQa5zqTZnZPluZzz4QUwHs8g
         f4lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXBZqMPymlGzjpyr45ttXUzqRKU97LxWFswSIQsfm+6HDColAFv+wPIGJqNI/nZCfFuaf0Vw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRtAooYWWUf+mW+PZyvBxfRQb2yuDEVRw38fJG9NK7AwB3PBFw
	kBkLyvfuCbE/fsVbWVzDlHkaQxTfJ0TiKqfkxhxA2Oqs0wVHxwBD3l+FZDhbFg==
X-Gm-Gg: ASbGnctJDpZkqXg2O6iFy4gv6/RLnbA+OlBJFPyDL9vuYu/hc+l80FbNHUobaTyZbnJ
	BzxenMw9Pa/WMxEl9crw8mj2rurat3/GQIlgoDis1qH6hg5O9PoDVexIr5PPQuOnyOdj1MWda9E
	Ugnj/0Hfp6DtH7Inv7YYJFjQSQ40Zs7sb6sLxas7ca8BdXpQhZQ9mx7XQ9HVO82LcypMLvjjiUL
	Kj8n04IOVHE40PJNE8xi2jUwpgd/if55cuD2k98dv3dV0LAP0TYLL1cSnzylRyRHKdF6TkySXnz
	0Q6W7NJ2H1ya
X-Google-Smtp-Source: AGHT+IGgvey12XcQ8iP4n+eaUVK+cmvSLWMH2UIplRse6X8rSW8rrU74w2Bbqndq54XuqjUDHEawSg==
X-Received: by 2002:a17:902:f785:b0:215:69a3:1c94 with SMTP id d9443c01a7336-21c12cfe139mr1268815ad.28.1736996710051;
        Wed, 15 Jan 2025 19:05:10 -0800 (PST)
Received: from google.com (1.243.198.35.bc.googleusercontent.com. [35.198.243.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c151cbfsm2135397a91.6.2025.01.15.19.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 19:05:09 -0800 (PST)
Date: Thu, 16 Jan 2025 03:05:00 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Yong Wu <yong.wu@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] iommu: Use str_enable_disable-like helpers
Message-ID: <Z4h3XHrzB53IAvys@google.com>
References: <20250114192642.912331-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114192642.912331-1-krzysztof.kozlowski@linaro.org>

On Tue, Jan 14, 2025 at 08:26:42PM +0100, Krzysztof Kozlowski wrote:
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 ++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 3 ++-
>  drivers/iommu/mtk_iommu.c                   | 9 +++++----
>  drivers/iommu/mtk_iommu_v1.c                | 3 ++-
>  drivers/iommu/rockchip-iommu.c              | 3 ++-
>  5 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 0e4cbb2c64d7..358072b4e293 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -26,6 +26,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-ats.h>
>  #include <linux/platform_device.h>
> +#include <linux/string_choices.h>

JFYI, this include was merged in the arm/smmu/updates branch recently,
hence it shouldn't cause any trouble while merging.

>  #include <kunit/visibility.h>
>  #include <uapi/linux/iommufd.h>
>  
> @@ -4321,7 +4322,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  	 */
>  	if (!!(reg & IDR0_COHACC) != coherent)
>  		dev_warn(smmu->dev, "IDR0.COHACC overridden by FW configuration (%s)\n",
> -			 coherent ? "true" : "false");
> +			 str_true_false(coherent));
>  
>  	switch (FIELD_GET(IDR0_STALL_MODEL, reg)) {
>  	case IDR0_STALL_MODEL_FORCE:
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 79afc92e1d8b..de205a34ffc6 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -34,6 +34,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/ratelimit.h>
>  #include <linux/slab.h>
> +#include <linux/string_choices.h>
>  
>  #include <linux/fsl/mc.h>
>  
> @@ -2106,7 +2107,7 @@ static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
>  	}
>  
>  	dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
> -		   cnt == 1 ? "" : "s");
> +		   str_plural(cnt));
>  	iort_put_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
>  }
>  

For the arm-smmu part.
Acked-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
