Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DED5440E
	for <iommu@lists.linux.dev>; Wed, 27 Dec 2023 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PceDFWXj"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d47fae33e0so18935ad.0
        for <iommu@lists.linux.dev>; Tue, 26 Dec 2023 16:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703636859; x=1704241659; darn=lists.linux.dev;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tWB8GEfhgaG2StCZxtDIu7qsHSf/rZ4sNtnlAoGbWAQ=;
        b=PceDFWXjUyajDMM1VREY2KHfsmdfsBZTN7jlbquO0JD/NoXW9M12eEDKVV3srtDEqm
         l+JdPR3gUANBrk/F9yAO7XL8qHGa91l9O0xmP0LXXBk9EK7I80r7hF3n+KAgNxtEXPi0
         4zMQRsufJlnwi5KSx3zty7cL2zaiPhiC2Ty7dpe9tzU/b8SML8X/bGf7FvudZr4rGBuj
         LjJ9kNxk32HZ/6MdZr0rux+l4GdaVreuQT/PbDt/56P3VKH8UeGht225qkQnDg0gWJN7
         z9K8OM/SQKBAHOeGQXx2Z6ZmQ1D4Vh9GK/QZYFU6hDV4eWg3NtsRYY1BkYi734RvglgR
         hDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703636859; x=1704241659;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWB8GEfhgaG2StCZxtDIu7qsHSf/rZ4sNtnlAoGbWAQ=;
        b=IShM1aszdMWUtsoWCDSP9YJ+XCtZ4RkeRCUj2ox0METJtSeyHIRV3sFRk50MH2o5mH
         JJAVCFa/JhRyxly+78L8ayG0QjosO5IfXAT5yLU8Xyw7K6BxRtaYzWVTsVS7lAzxXk3h
         S0CRMDO3y13VPElA3fDT4JJ5JngQJ4lvvEykinYP6xSR7igGLG0tRfdpD4+FVFs0s5fr
         NQupoBKr6Qt4+urELpzui62kEmOsZihsLw7kxpRlFN+bknYSDPaamVXtL+KAifTO7yx6
         owmH1A+tQzvyKrxDuujjjNzWDps1tkUO0mDyx/xpZRIn3n2GSY6iUaAO8vrAX0iaM1WS
         BGJA==
X-Gm-Message-State: AOJu0YxaZkcFjuXD2eXXj9fJAPviaRGjsVbhMPxJOqURZ8vUlD1LeXXC
	c4afchx9T2V5bfQ9hKWSRmOpmR3BGiRm
X-Google-Smtp-Source: AGHT+IEt5kz+5IRUGXbqQvg0LHmZbhtvIOnJMwFJGwN1byHl8pOfJREKbeZKfGVR7i5FozKA6XE7xw==
X-Received: by 2002:a17:902:d508:b0:1d4:69f7:792b with SMTP id b8-20020a170902d50800b001d469f7792bmr170997plg.17.1703636858562;
        Tue, 26 Dec 2023 16:27:38 -0800 (PST)
Received: from [2620:0:1008:15:5a8c:89e6:ca2f:ea30] ([2620:0:1008:15:5a8c:89e6:ca2f:ea30])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b001d39af62b1fsm10527546plg.232.2023.12.26.16.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 16:27:38 -0800 (PST)
Date: Tue, 26 Dec 2023 16:27:37 -0800 (PST)
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
Subject: Re: [PATCH v3 01/10] iommu/vt-d: add wrapper functions for page
 allocations
In-Reply-To: <20231226200205.562565-2-pasha.tatashin@soleen.com>
Message-ID: <c8311c45-72e3-8ff2-c206-3dd21f6a9bed@google.com>
References: <20231226200205.562565-1-pasha.tatashin@soleen.com> <20231226200205.562565-2-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 26 Dec 2023, Pasha Tatashin wrote:

> In order to improve observability and accountability of IOMMU layer, we
> must account the number of pages that are allocated by functions that
> are calling directly into buddy allocator.
> 
> This is achieved by first wrapping the allocation related functions into a
> separate inline functions in new file:
> 
> drivers/iommu/iommu-pages.h
> 
> Convert all page allocation calls under iommu/intel to use these new
> functions.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: David Rientjes <rientjes@google.com>
