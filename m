Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054B2FC0E
	for <iommu@lists.linux.dev>; Sun, 24 Dec 2023 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EuEZGic0"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-35ffc781b3bso58615ab.1
        for <iommu@lists.linux.dev>; Sun, 24 Dec 2023 13:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703453845; x=1704058645; darn=lists.linux.dev;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pVxyPMcJnzxVjqwUrIgqhLO2uo1Gd7uHiOR5G5u7XjE=;
        b=EuEZGic0D0L5d2WqudTQ14IslebIiHGJi4tb0lNGZv02akFKmXaio9K4jxHz8HsL4r
         w1phuoiLqt0pUfXOaK+fM/RuLj5+2n3qlFIswIWWOjkORvcQjrpyERSgJlmkoepbRGIm
         R0uLwMWMrykBsHTehkK9zCrXf7APPk5j+0VWWda2TF+YFXtqwN/9VgHriQ3dzGeVP5xd
         XVu4UFIVFz70dLmWrHQiBCks4wp2CRG+Csq7vnQyfhm8wDGngKB+kkBF6Rl4pWfEYZmr
         ncA/QQFRxFMfZA0WY33NLFlCP8cfDy8Jm+FcTDqisR96qW33XWc2r+CavZ2mdJrCS38j
         2b/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703453845; x=1704058645;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVxyPMcJnzxVjqwUrIgqhLO2uo1Gd7uHiOR5G5u7XjE=;
        b=m1FNKXrtafayJyosmhMIRuU6X1zbTrGehoBMcx+/Tuap50wJihVZrMdcbOENDBdATV
         JUXtBUiPRmRgm3Qq2j6aqn0QCw7CFSX19LosGmZfmitMLT4+TYJEfNHPhlEtL3vxQg/P
         VkPTjxzQCxwwQACnP+1mnEbavOA1Qaoxr2gvABb+ahKe5BBF748vhgFgu3uVWk8DWEB8
         Kyl8BtGxmQEHO9AJvggGq9CbhQm7no2ZXsErNlhbyUSOUYIqpkBI93HBbXtoiqI1vq0o
         raqnHlTWk9rRQe8tHUNF+OL0b9IpC0+OTSA3tBajbNackeiHqiP5kr+CMUv0TJUJEtT7
         y4pw==
X-Gm-Message-State: AOJu0YzhxltWmASvfac02wMa5/MuS2txWDXlvEXd1cfMCvyM8nBe75kz
	jYB9PK63P5Ilu8v+GI5ZXEv/+4op3m+i
X-Google-Smtp-Source: AGHT+IEltSw2it/AyEQL4TJEReIP7j1yGavDmVQF3lJZLlbsuLGoO+wANiaULFEhAWOlUQIZqn8B1g==
X-Received: by 2002:a05:6e02:1110:b0:35f:eb24:6e67 with SMTP id u16-20020a056e02111000b0035feb246e67mr189109ilk.7.1703453845125;
        Sun, 24 Dec 2023 13:37:25 -0800 (PST)
Received: from [2620:0:1008:15:c723:e11e:854b:ac88] ([2620:0:1008:15:c723:e11e:854b:ac88])
        by smtp.gmail.com with ESMTPSA id x2-20020aa784c2000000b006d99cbe22f5sm3116025pfn.217.2023.12.24.13.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 13:37:24 -0800 (PST)
Date: Sun, 24 Dec 2023 13:37:23 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
    asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
    cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
    dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
    iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
    joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
    linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
    linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
    mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
    rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
    suravee.suthikulpanit@amd.com, sven@svenpeter.dev, 
    thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com, 
    vdumpa@nvidia.com, wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [PATCH v2 05/10] iommu/exynos: use page allocation function
 provided by iommu-pages.h
In-Reply-To: <20231130201504.2322355-6-pasha.tatashin@soleen.com>
Message-ID: <5c2d33b4-3360-10f3-7d97-5cdcb29e4d73@google.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com> <20231130201504.2322355-6-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Nov 2023, Pasha Tatashin wrote:

> Convert iommu/exynos-iommu.c to use the new page allocation functions
> provided in iommu-pages.h.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: David Rientjes <rientjes@google.com>
