Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4208D2908
	for <iommu@lists.linux.dev>; Tue,  8 Nov 2022 03:02:47 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id fz10so8049562qtb.3
        for <iommu@lists.linux.dev>; Mon, 07 Nov 2022 19:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wTgvsmQCgbUJy/uyEBLIwEwJeivJlDp4X00FjEbm73U=;
        b=KpGOTlZpFF56PAJz4Zyiyj1+AE/0+obLPnwKtXkayi9BgHyMd1LEnld1njeN3AVfgp
         9UT1CWH3HOhFEJzbQVxOzORHS5x6yip2l+gMDq/lFqFvzbdTS152Ur80e0112btw6Bt1
         XB1mDSrtSD2Gz1yQEEmuhqap1RdI8vGjsaVVoe0MRVarxfgS/cSUw6cb1rN4+YZL7tWr
         aLK8X9eTQg/KDyhYNBD1uyNc74TH6V5SsdcM7Wfw6O2f6fp71is/cQY0P/fnaZGgDQzV
         7Ov6CJDUXtgzHjoOPsEYHR5WQt6vgYzBRZk2+OYc6boRZB3obYz8k5TB6LAU1hh40RrY
         6+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTgvsmQCgbUJy/uyEBLIwEwJeivJlDp4X00FjEbm73U=;
        b=NH27BkJ/rJTCLgwFhPBdc1+NixZm/aOAT27GuXEvwadUMF5QcbWJEnqnXZ6E1mdaOa
         YNDCELW21ShqPznO7Zv96Uehv9b58Dq0CAuVv8jpo29otVS+qy0dRg726JQRqsAwDBLU
         uuVG8ktZxwBBmjZ4zhJnlhURePfySBehqRBprpnTdRzODoM+jQtp3CiXorZ6L0HHaklq
         4mPzu745u69xJsfebqHjjD6B1xW18TTQt5E+2lHLdMjgrG+0h5s4S4n3JSjAOK2BmEWq
         U0I7FqBzHH5FnGxl1OCHoHl09ETqiRf65u2HE5rZND8VZrte+fxrWqyIu+kdeF9P8TBS
         Og3Q==
X-Gm-Message-State: ANoB5pllI/jVxv7ANEpifxU48/8nxvWtjflHmHsODabmmxPaNp4hohM9
	aigXs8EvvffoAbHXP6Ftifg=
X-Google-Smtp-Source: AA0mqf5kH5sVly/98XYjDeDQdqiaVJGNbUetyTPauSbsmbjnkjfzzoiUBE6uGJvjanAM9rKdnAswHg==
X-Received: by 2002:ac8:5c07:0:b0:3a5:946e:8b7e with SMTP id i7-20020ac85c07000000b003a5946e8b7emr4462095qti.385.1667876566133;
        Mon, 07 Nov 2022 19:02:46 -0800 (PST)
Received: from localhost ([2607:fea8:a2e2:2d00::61cc])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05620a178e00b006bb366779a4sm8347893qkb.6.2022.11.07.19.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 19:02:45 -0800 (PST)
Date: Mon, 7 Nov 2022 22:02:44 -0500
From: Richard Acayan <mailingradian@gmail.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 0/1] iommu: SMMU for SDM670
Message-ID: <Y2nG1ExgpYVm2sY+@mailingradian>
References: <20221108025847.58352-1-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108025847.58352-1-mailingradian@gmail.com>

On Mon, Nov 07, 2022 at 09:58:48PM -0500, Richard Acayan wrote:
> Changes since v3:
>  - drop driver patch

This is v4. I forgot to increment the version in the subject header. My
apologies.

> 
> Changes since v2:
>  - rewrite driver patch (2/2)
>  - rebase on (1/2):
>    https://lore.kernel.org/linux-iommu/20221102184420.534094-1-dmitry.baryshkov@linaro.org/
>  - reset review process (1-2/2)
> 
> Changes since v1 (no emails related to this series since last week):
>  - accumulate tags (both were added because it seems like the discussion
>    ended in agreement to keep adding compatible strings to the driver)
> 
> This adds the compatible string for the Qualcomm Snapdragon 670's SMMU. The
> SMMU is necessary for GENI I2C, included in initial bringup because it
> doesn't need non-trivial patches except for patches conventionally added
> before the initial device tree (global clock controller and pinctrl).
> 
> Richard Acayan (1):
>   dt-bindings: iommu: arm-smmu: add sdm670 compatible
> 
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> -- 
> 2.38.1
> 
