Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F091854
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 12:54:10 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id p5so10816541ljc.13
        for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=6iOm3ykiEYCxC1y7MhUHMQ31n65A3mybmY95lFp43lM=;
        b=YMrrxM62da8qNRcPcsPM1f6j5pHpWSlnMRt/k9ArblV9TlykNySfRNF69BfT/CUnNS
         d1IgmIX8cBoGeK/KzeQKLk9snEUd//Z8IiuFzwStqnPErEbT6CVnJFSzxdZtZfr7a1wo
         ePKqfoJuLDVgA/ZdKIRApfAyd03xKvat/TKZDIeRdF9Lw65leabKONVnWVXEjKvleQ/I
         nzsPkPsQA427uSydpgtnwZz9JVyC3GUlHDuPIOTWvjvM+7EN7Ag3dwrNpDgwfVWonYqA
         GuhLJBaNq9DLDxKviqF9tAZ++Ad5NGIcGstVRhyOjY97y4VMRB7Mu0RBqSTLNiwVGcLX
         Nj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6iOm3ykiEYCxC1y7MhUHMQ31n65A3mybmY95lFp43lM=;
        b=RnNbvFghWxgHiqlR97E/DSa8UqEv6+VRDzEVEvJOFF4dhAECx5N9fYPmc+rdquJn/t
         RKB1kizxY+SLOCWcnp+zdCWyIdJkbBngbNVtXnJPzsUTzZYNXY92BejJvpDQf6b0wO2p
         UpzB58JVZHuGv0pKm2lj/ltD/p4NuviybjDmkGLymmWeNaB4wKoHitgmCzIW8n3UvdbF
         7savYrZgoxW0WUysdpjdWL9fCRUQuLEJrAox3pbRAK/dzm2vc9p1b9aUPr4e8YAHF7Wy
         yWVlx2VFVz/Pbx8HDu2Ne9osqSn4B7jIGpE9S66xI3L9dN+5fowitMp1PLoV19ltTWtT
         gedA==
X-Gm-Message-State: ACrzQf0foz8xX7Tjb8OQ51bUOFeEaHpIRWAADkoa5mbjyyumdKB7THIj
	bKBT60K304dmJJOu7idLatb5xA==
X-Google-Smtp-Source: AMsMyM6o08fe7EJUEoL9IZbLm9HzdOug3LCgJEjROkmEOsMLYtujzse2VqJjxZ68Gea+MQekuYjXKQ==
X-Received: by 2002:a2e:8496:0:b0:26b:f230:a55d with SMTP id b22-20020a2e8496000000b0026bf230a55dmr985734ljh.466.1663851248171;
        Thu, 22 Sep 2022 05:54:08 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u17-20020a05651220d100b0049ad2619becsm929038lfr.131.2022.09.22.05.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 05:54:07 -0700 (PDT)
Message-ID: <3c0c6932-89fe-5962-d1c3-57ab6ef577df@linaro.org>
Date: Thu, 22 Sep 2022 14:54:06 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] dt-bindings: iommu: arm,smmu-v3: Relax order of interrupt
 names
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, will@kernel.org,
 robin.murphy@arm.com
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220916133145.1910549-1-jean-philippe@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220916133145.1910549-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/09/2022 15:31, Jean-Philippe Brucker wrote:
> The QEMU devicetree uses a different order for SMMUv3 interrupt names,
> and there isn't a good reason for enforcing a specific order. Since all
> interrupt lines are optional, operating systems should not expect a
> fixed interrupt array layout; they should instead match each interrupt
> to its name individually. Besides, as a result of commit e4783856a2e8
> ("dt-bindings: iommu: arm,smmu-v3: make PRI IRQ optional"), "cmdq-sync"
> and "priq" are already permutable. Relax the interrupt-names array
> entirely by allowing any permutation, incidentally making the schema
> more readable.
> 
> Note that dt-validate won't allow duplicate names here so we don't need
> to specify maxItems or add additional checks, it's quite neat.

Nice explanation, much appriecated!

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

