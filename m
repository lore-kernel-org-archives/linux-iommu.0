Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72794BA53;
	Wed,  4 Jan 2023 22:04:47 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id ud5so86061076ejc.4;
        Wed, 04 Jan 2023 14:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAgESyffyGfL2EhiYgHo7ieKIsVwn7XJhQmStMSRKhc=;
        b=phZ4NEuz02LsQ6So2V3GDbdOgwyUdlRwWhE5T2GTNM/a5pN71DO/CDYus16Rv/B0ZK
         pJ0qqJvDjI4bKk9DQPd/Lrk5Jjy9BrpWHESRd9N09T8gtnRjrW9MoNVa+KtRnr4zLubD
         7tTmunNmEQ3JXQcKYJ05+jf/lTcKuELd6zucImxruAGzLylewyGpovnNdY3icMfC3m7E
         n7hW6kSKL78yD7ihTeiIvHudmokzhrkGqT0vsMGR08nr0JnlWzpLRS9K2VxR0fvV6LYA
         ZXe2NwMbfNEoNtoJ/Gjw8WW2adAZM36yGRp+BE6Vx39jQA4BQqJJ8ifhw03MCZAgOd1R
         T59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAgESyffyGfL2EhiYgHo7ieKIsVwn7XJhQmStMSRKhc=;
        b=wtq8l1+VBX5LhvioqOsv2AB/xXom8DMhfrrVd4tLsaP+ML+Cnj1KGQv+osROIVqZuF
         OlQTgRKdij4b+1LIN/oGcj4aApnZRJ2woKOp7zHxeuQSGnaOQYvX6rC8cXrfYhRtp4WM
         NMk6gMRCH0HeEQS0gjWhxIwd8absyhlcFeD5SVg0p9F/1MmAlxp7rX7HL5rTySe8HsZm
         o+cLNEtBnmiy8JXHa0vwdpFudybomAMRp/7NiAOUKn/8wSiFOpuiMQp6UPRdpT4sm5nD
         RrOr40XS1JIWfrJz//j6x/SDeQVpXPzitqGlq/DJSwD52hRlmTit9Yxz+X9OK9MvQhVr
         dJwQ==
X-Gm-Message-State: AFqh2kp4KD1BO5Ydpad2eJ8I64fHZOb3KBM7PMr89F7BcByWGm5MoPlx
	CB4GvaCMi03aa+EBZ/Wmw1M=
X-Google-Smtp-Source: AMrXdXueZ4a9lP4WZD0oUUo0ysvovdN+8hgWpPMcryijlJBywkg9NIsmu669fcPxczi1QTbkkiMVIw==
X-Received: by 2002:a17:906:ecf7:b0:7c4:f6e4:3e92 with SMTP id qt23-20020a170906ecf700b007c4f6e43e92mr49873730ejb.31.1672869885740;
        Wed, 04 Jan 2023 14:04:45 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id jg34-20020a170907972200b0084cb8589523sm5336958ejc.139.2023.01.04.14.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:04:44 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Samuel Holland <samuel@sholland.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 2/6] iommu/sun50i: Track masters attached to the domain
Date: Wed, 04 Jan 2023 23:04:43 +0100
Message-ID: <8201525.NyiUUSuA9g@jernej-laptop>
In-Reply-To: <20230103010903.11181-3-samuel@sholland.org>
References:
 <20230103010903.11181-1-samuel@sholland.org>
 <20230103010903.11181-3-samuel@sholland.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne torek, 03. januar 2023 ob 02:08:59 CET je Samuel Holland napisal(a):
> The refcount logic here is broken. The refcount is initialized to 1 with
> no devices attached, so it will be decremented back to 1 when the last
> device is detached. However, refcount_dec_and_test() returns true only
> when the refcount gets decremented to zero, so the domain will never be
> cleaned up, and the hardware will never be disabled.
> 
> Replace the refcount with a mask of masters attached to the domain. The
> domain can be cleaned up when the last master detaches. This mask is
> also necessary to correctly set the bypass register.
> 
> Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


