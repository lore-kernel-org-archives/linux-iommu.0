Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B161C283
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 15:34:01 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9ad8bba8125so887484566b.3
        for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 08:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695656040; x=1696260840; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2L03FGrPsmK9pE8qPoIamtRCHF+HO5YW5i6ifzgGmQ=;
        b=KY02cwVRFjSTE2VDZIm3I66LeME8rQQSM7se4CCPV3CIQN0QWZgxNLp1hqDPwA7xtZ
         ctVWFwLrkAXJAcVFdHN6uVabrae9S9MWue1HH6VFOvltsEdHXK6YBkTf3xM3lpTwcM74
         RtrQc2KU1nHkf+ca6CaGpfi8G7jHd3vCvIBJ7389Go5hMrvhwWd9MX0mk+iXkVmGmttR
         i3V2Uw5qM/KArITlPXSw6505SPfUZ6IPonmIFJJ2j3+7UkjD3js+2pxLTaCSBGdRO+u+
         hDx8OW3zcL98UH25nt0opdBGaoHoyBRgJDc6Cg1v6gYUhH2sK43YCHNF6pG5QQe7DBTa
         SwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656040; x=1696260840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2L03FGrPsmK9pE8qPoIamtRCHF+HO5YW5i6ifzgGmQ=;
        b=WxS+O05NThn2uLo8FGHQ7A2/GLjN/COSshELYbbNHExyvs6OVUDLbswxRbe23/PbIs
         wEjJzKsEET0OpUGnRYLaEFLaje4CrY+TLaCinVexKlOo8EN7qmwMRqURGjCfYpPyQtGe
         lWTuK1lD12fpHBwC8yOI02G+qFK4CuarmczfLZYt+XsRfxD5I9qsmaLQ71auUNj8iiYx
         vux3JJCxLoMQ7/T0kU+md4cH4A7+h0IOmSt0TydgKUZFQ2oHx+B/VVr8N6kxfuTdP03J
         hx8p+2GKl0tyfW3gQKiLr1udfY+rvmm8eRevh9XxC+trGZdQ7FDr7hms1iBFORjBjxV7
         Vt2Q==
X-Gm-Message-State: AOJu0Yw2QxvFBs6XtetiMbakmLViuYGqhC0J7bocbJbSBZfkzTgX5vpF
	x8RELzXpKiNNiww2om8nhwc=
X-Google-Smtp-Source: AGHT+IHtsiZC0gfUad5sYk+77UafUFwVufnw/g5MTmoNDrHlzSH3yXfEnrQECaxdaToCO9IaW6K9TQ==
X-Received: by 2002:a17:907:2e02:b0:9b2:7f8c:ac09 with SMTP id ig2-20020a1709072e0200b009b27f8cac09mr3478259ejc.6.1695656040221;
        Mon, 25 Sep 2023 08:34:00 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id z27-20020a1709060adb00b00993cc1242d4sm6465468ejf.151.2023.09.25.08.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:33:59 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: will@kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
 heiko@sntech.de, thierry.reding@gmail.com, vdumpa@nvidia.com
Subject: Re: [PATCH 0/8] iommu: Clean up map/unmap ops
Date: Mon, 25 Sep 2023 17:33:58 +0200
Message-ID: <2360630.NG923GbCHz@jernej-laptop>
In-Reply-To: <ZRFbbyxB0AwC-V_5@8bytes.org>
References:
 <cover.1694525662.git.robin.murphy@arm.com> <ZRFbbyxB0AwC-V_5@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 25. september 2023 ob 12:05:35 CEST je Joerg Roedel napisal(a):
> On Tue, Sep 12, 2023 at 05:18:36PM +0100, Robin Murphy wrote:
> > Robin Murphy (8):
> >   iommu/exynos: Update to {map,unmap}_pages
> >   iommu/omap: Update to {map,unmap}_pages
> >   iommu/rockchip: Update to {map,unmap}_pages
> >   iommu/sun50i: Update to {map,unmap}_pages
> >   iommu/tegra-gart: Update to {map,unmap}_pages
> >   iommu/tegra-smmu: Update to {map,unmap}_pages
> >   iommu: Retire map/unmap ops
> >   iommu: Improve map/unmap sanity checks
> 
> Applied all except the tegra-gart patch. Tegra-gart has been removed by
> Jason in a previous patch. Thanks Robin.

sun50i is meant to be placeholder (as mentioned in cover letter). It's
replaced by:
https://lore.kernel.org/linux-sunxi/20230912181941.2971036-1-jernej.skrabec@gmail.com/

But I didn't get any feedback if it's ok or there is anything to fix.

Best regards,
Jernej



