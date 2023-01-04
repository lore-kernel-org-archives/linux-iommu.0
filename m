Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84705BA53;
	Wed,  4 Jan 2023 22:07:29 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id u9so86136586ejo.0;
        Wed, 04 Jan 2023 14:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhoWMiObP+lGi7qDb0lfYkefrU81cw9zmlAnNgHY45E=;
        b=Pvr9GZNKmNncfbwqbIASOIHTIuaa1J+6+CplGDFGy7Wy5yOGmIKhYpa5M1nqaPHMHl
         +9wr7Ei9wTkLpzwEIwtngV4TFPUJjcV9au0r2BtTYQ6xqIfVMqdTzr6mVwvckK3zTB7G
         4Jd8jiu0bhXJDpA3aEAcmzw9P8HdS6dzM1UWWtXFJxG1Q3DhslmQIX3F21GI2Z4WXU/s
         yylSMxw16ndHA6AG/tsD9TdJKSZj+FcG1xoaewnY+54UnCtdkOVyb+1lDO8RB/YeHmUf
         ujpfFbrtgISNF72Uq48KVg7KQqO4HdkLKiEMBGb7MQ5sNZUvpL7muyLhhG13POs/Cd9L
         F49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhoWMiObP+lGi7qDb0lfYkefrU81cw9zmlAnNgHY45E=;
        b=u0Wdp11lsXm7HMJVi0a6PBY/8E2dJdADkial9Y/6q/POtoxh4yzH/P7c9OirQRltOa
         hXRSuJEE/uV1DpCiasebnmfLvvxovCX7QMJZdJsYkbGwDz7PjU8rvhXTZAHL3xGw22sL
         XO4e5sFL9TAiyJRsx2qW3qawduaTG7q3ywPk5Un+kj32kYZq0NOsHilz20ZbvVy1d53C
         r495U+ETnsbBzOTCtJVfxoVZLI7p8kbgIznX+t7J9I6jhwQh2qhxYk2B0vLOPZYqVqYP
         qtirM3jZgi2RSWDtrTxK82dZ6BsX5yD6UphxnNRFgTZM7DFWYGu76L6zg2ELp0eZ57XR
         KkdQ==
X-Gm-Message-State: AFqh2kpdQjLj8YmwtEg+6xrCpBDcaHhotsHHk4NZXvrPbmaexzA+gWQl
	XoWK70+aUjgTWMfgR9qWaUc=
X-Google-Smtp-Source: AMrXdXs51RVJi2p23UPs8+iGyH2XmtJRRIrud1/3hjnvoCBObJGAnahuCFZj3MqB7w6cSO+O9+Xj9w==
X-Received: by 2002:a17:907:2061:b0:7c0:dfbd:5a1a with SMTP id qp1-20020a170907206100b007c0dfbd5a1amr43992128ejb.33.1672870047733;
        Wed, 04 Jan 2023 14:07:27 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id l22-20020a1709065a9600b00780982d77d1sm15713189ejq.154.2023.01.04.14.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:07:27 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Samuel Holland <samuel@sholland.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 6/6] riscv: dts: allwinner: d1: Add the IOMMU node
Date: Wed, 04 Jan 2023 23:07:25 +0100
Message-ID: <22917211.6Emhk5qWAg@jernej-laptop>
In-Reply-To: <20230103010903.11181-7-samuel@sholland.org>
References:
 <20230103010903.11181-1-samuel@sholland.org>
 <20230103010903.11181-7-samuel@sholland.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne torek, 03. januar 2023 ob 02:09:03 CET je Samuel Holland napisal(a):
> D1 contains an IOMMU for its video-related hardware. Add the node, and
> hook it up to the masters which are already described in the devicetree.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


