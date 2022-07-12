Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AC34414
	for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 16:19:11 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id bp17so6937016lfb.3
        for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uJ9dVi90hK+YLTAhE7H/lF4J6uUbmiWH1N0eWZR3ZwA=;
        b=TTsXZieu32r3wAaawionSAU7zpQZb8eC0dCJ0JhkT+ecFFSbVnbKVkFmXYyw1029m2
         1GR6KJ4SPcmGBcdCugUqdzSuiNXVea9CTYsurcpyvnfKcrCP7dSeuna0fEgPg5N5WJpD
         hoPACOrCuHbt3ZcML4hZ20i24O19ZQr24EAH14GvGBlggtLW+lL1HkwjutpMHinCzuj5
         iN4Lls3rZp95yjTD9gF2Le10PFvVzjWghz8ngg9LNvxKb8q9hVejhorDbYGxej2kIjIs
         fgoS9+T0y/ecsMzfml0R8/b8EhS/ku/nwBqiBlm0Q7x2mdRB8R2ZT/bhEPUavPo1s4Td
         P02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uJ9dVi90hK+YLTAhE7H/lF4J6uUbmiWH1N0eWZR3ZwA=;
        b=a2QYzg+0li+POqhOQCFc/WnJi7LxVxgYrJZZjKIqQdbKFg9v+CxYVQRACd/TY+yiiA
         32gXUZGpak+u2DLEu24oAboBBTd91d2wE/LqwBQsQo3/q8J1tgeHjuQLtPXBlZzDbJ0A
         I4nvDKatpU7yItgFi6ZX6OP+eY3GJsyAucE4nZLdMoIjXG5V3UQbiUtzDFbB326dffij
         uRLCBKWVvkLwNG8hyVgPjwSqYgFL7TjH25nGm6a/g+ANy9mOMqzDUTx1/Lsduh6Sr2tc
         3nRYUh+iASlHRdG0BKHojeDrQlK2CedRMWnH7wcI/AtbYvlJZo+cle6rXHXNiklnfGRe
         sZcA==
X-Gm-Message-State: AJIora/Fc4DQJ0F1cblIYEmTnWPdkv8hFV+0E60Zv2pLcjfF7QRIg7QL
	aBZz7U11+q2DKg3By25O6k8Xog==
X-Google-Smtp-Source: AGRyM1uGiF4reCluBJM1q38YblixcNGVUMf8QXzKeopoBX/HMPUAtrhZDOIADX//FSe4WDjod3mUAw==
X-Received: by 2002:a05:6512:682:b0:489:16b3:14e1 with SMTP id t2-20020a056512068200b0048916b314e1mr16035039lfe.132.1657642749316;
        Tue, 12 Jul 2022 09:19:09 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id k13-20020ac257cd000000b00489db767c89sm1552945lfo.271.2022.07.12.09.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 09:19:08 -0700 (PDT)
Message-ID: <257c64a7-db27-301c-f724-f8c771092466@linaro.org>
Date: Tue, 12 Jul 2022 18:19:05 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/7] iommu/exynos: Reuse SysMMU constants for page size
 and order
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Janghyuck Kim <janghyuck.kim@samsung.com>,
 Cho KyongHo <pullip.cho@samsung.com>, Daniel Mentz <danielmentz@google.com>,
 David Virag <virag.david003@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
 <20220710230603.13526-2-semen.protsenko@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220710230603.13526-2-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/07/2022 01:05, Sam Protsenko wrote:
> Using SZ_4K in context of SysMMU driver is better than using PAGE_SIZE,
> as PAGE_SIZE might have different value on different platforms. Though
> it would be even better to use more specific constants, already existing
> in SysMMU driver. Make the code more strict by using SPAGE_ORDER and
> SPAGE_SIZE constants.
> 
> It also makes sense, as __sysmmu_tlb_invalidate_entry() also uses
> SPAGE_* constants for further calculations with num_inv param, so it's
> logical that num_inv should be previously calculated using also SPAGE_*
> values.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
