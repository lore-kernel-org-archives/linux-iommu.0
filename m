Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9592560
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 08:55:04 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id dn12so9355223edb.5
        for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 00:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ms/iLQOf6WZ9kdAbvZ5kczj2Q3S8/Va+SZXQUp0aFpI=;
        b=kyzKIEWzCOJNIjmoYP09ulmEIikLSDcsMAPktcU/zWhA8o+CjPafc5vCUetue3nzNw
         yZJajUL3OKiOn4cPunKJmdk6bY8dn/9B/wqP/ak4CccyAwha4eEfTZIFRto1eQHfZR5T
         hbmWXWAAUNSa2k987EgtNHckC0Uk5yEaGLndg17UBttAMDoSLQZN0Z3NpEbY6U+6qyiS
         RQ9cuKe0Nys02eKGay+6fVitO/IfdcfyZJeKiqELcsQW6jUD5c03QeweZNTK3qNNvjby
         QRbDy/hBo5yJT8Lo5l6ouL05JQEk4g3y03z2phQE7necbjVx6yWeXzvgZDGkjwwiuMLj
         Ok1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ms/iLQOf6WZ9kdAbvZ5kczj2Q3S8/Va+SZXQUp0aFpI=;
        b=dG33v9xjNKbPU7l6gMe8uZ4OGsZJoH4jEHb0tYWq60QfVNjcTyX4BKES/qkIkDujth
         a4SgeBLzSXo5bQYy0PW7rkzdym+ArzJuwbq2WXr5FF0/iNWkRBqZvJz/FUuSezeKBMwy
         98EE2toZE0T/3fkPThMdl0EnFE6/J0Xtog3VFFtrNuCa7uz1f3zmnDz572WMdLjLmZRu
         gvo/HvLAipe4HuNhFE9ealjo9/Huxjef4t/ugigYd0ayxsmLzeK9salMg8PGtbh+GS0G
         5EjOOrPl/eSuJ/ycwtYTH8VJhY0/4bKO/8rWVPD3KbLrhWsZKsB+WMeDnBiIlBq9L1NS
         nyig==
X-Gm-Message-State: AO0yUKWym/Tz+9p9WEX3wdoRTIJOJzofWF937i1lwRPeBZF27TKWpiUU
	TLSb1ZPusPZLYOB+68vww4BIHA==
X-Google-Smtp-Source: AK7set+IEv2TbISTklidgD6uq9zlJmbOrq7lhiGovewXGe1Rb+O6Stn+ccGdmM+r+kEvUce/0FYZYg==
X-Received: by 2002:a05:6402:784:b0:4ab:4411:2f71 with SMTP id d4-20020a056402078400b004ab44112f71mr156745edy.37.1676624102715;
        Fri, 17 Feb 2023 00:55:02 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a36-20020a509ea7000000b004a7e9ec2087sm1964054edf.76.2023.02.17.00.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 00:55:02 -0800 (PST)
Message-ID: <2d2290c3-e4ac-aee3-f2cf-496c6d29a188@linaro.org>
Date: Fri, 17 Feb 2023 09:55:00 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/5] dt-bindings: arm-smmu: Add SM8350 Adreno SMMU
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org,
 andersson@kernel.org, agross@kernel.org
Cc: marijn.suijten@somainline.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230216145646.4095336-1-konrad.dybcio@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230216145646.4095336-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2023 15:56, Konrad Dybcio wrote:
> Document the Adreno SMMU present on SM8350.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

