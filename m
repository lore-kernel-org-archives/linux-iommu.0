Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CC210797
	for <iommu@lists.linux.dev>; Sun, 24 Dec 2023 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1pB829ut"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36000a26f8aso25545ab.0
        for <iommu@lists.linux.dev>; Sun, 24 Dec 2023 13:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703453674; x=1704058474; darn=lists.linux.dev;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TfM2Ozc84jVU4EjDuheFZr1xJI8bldYDvajnMAoQpG8=;
        b=1pB829utQoTJYP8/9dY3xR82WGE6I5LcEJnJZgDIbP1wANu8FZdHW5eKKbUUWt6KxE
         xWUIVa+HAW9KcStKkNe+cp3Pyppl33XRMJk0NHnPOty6Or7CM+M6+wCVKh/J6ZAD53Ro
         O9eR55j5MyEYP5CkdqbgKKBvRvf2bG0y0BfVCGh4smCb/veh1osG8sHh/07KgGo/JNSf
         8RtCfX+fDt4hI3lyGGKvlA5NdVKxTX9Kx53UEjg5wnxKG0U1r3sFSCuyJ525ws2FILou
         FrQzbBb6tanWgRXyFw1ucJsqrf0nFY/oMVrd7EsCnK7FJ16PF4VZNPS9ADEnsyYIPFLe
         mDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703453674; x=1704058474;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfM2Ozc84jVU4EjDuheFZr1xJI8bldYDvajnMAoQpG8=;
        b=Q21x2QNYNkwlO+0hv9KtDcQpJ48SQucAaBgqy7Bac0zTXshF4tdvKZqx2hyzBFugcv
         cTkgHjZai2srRDhFbWMOWXIFVvDa5mdhl7xWhUHszeQfoCivlyknMoDeBZixr1pNcKym
         wNPIpMpiVjXBtf7O8XrCocUSCjJXHmE2boNzH1QI1AsuhpLPlNxQbGKL3+pjR48HxqqX
         5NKOOkYbNOSe9DAUMGtc4IFPNpgyriV3dfXKsbx7/viS7dw+2Hbd7o0Mh7oIcnL4nnQl
         iFjSQ15tKb7GXLRZTRFdlsaCkTk+O8BZZUGbQgsND77uujlGNTGjBA8PKg1T9ul2MfL1
         BnKg==
X-Gm-Message-State: AOJu0Yzwd7lfT654yWhz26ZNegMkpKTwq20hPia8v3+z2Vjig4lwVY+Y
	JsGZ9jtO8nbrQzWzEg0QCeZZca5sR4PD
X-Google-Smtp-Source: AGHT+IG3cVdgoPXJNOP0FoX9QP3AtXmf/dh4TZ34AQ57wFrWDSmH4MJwWcFfrokVe6jo4lwlGVdhWA==
X-Received: by 2002:a92:6802:0:b0:35f:ff76:2d40 with SMTP id d2-20020a926802000000b0035fff762d40mr25383ilc.28.1703453673759;
        Sun, 24 Dec 2023 13:34:33 -0800 (PST)
Received: from [2620:0:1008:15:c723:e11e:854b:ac88] ([2620:0:1008:15:c723:e11e:854b:ac88])
        by smtp.gmail.com with ESMTPSA id h16-20020aa79f50000000b006d9ab1e15c3sm2281753pfr.129.2023.12.24.13.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 13:34:33 -0800 (PST)
Date: Sun, 24 Dec 2023 13:34:32 -0800 (PST)
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
Subject: Re: [PATCH v2 03/10] iommu/io-pgtable-arm: use page allocation
 function provided by iommu-pages.h
In-Reply-To: <20231130201504.2322355-4-pasha.tatashin@soleen.com>
Message-ID: <f36a5a1e-f28f-c25b-337b-8c67ccd46943@google.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com> <20231130201504.2322355-4-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Nov 2023, Pasha Tatashin wrote:

> Convert iommu/io-pgtable-arm.c to use the new page allocation functions
> provided in iommu-pages.h.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: David Rientjes <rientjes@google.com>
