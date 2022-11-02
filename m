Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB6527708
	for <iommu@lists.linux.dev>; Wed,  2 Nov 2022 20:55:05 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id u7so13301581qvn.13
        for <iommu@lists.linux.dev>; Wed, 02 Nov 2022 13:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OXUvCOmLRFj9V68bWV7FWt2GZPLPNIKne6rJYA5H4CU=;
        b=D1CQ9NtJXqPYE+vCPKr8iASAXv0p5iWoGL9eZG4QDqTyTmWqwJVNEiW5+qYfkXIug/
         uRYLmM+HHhEKiy+JI4h9xhHI5G+pPndloIVCl5zf8Zwp8ApcFy43qMjZY+8bkYoHHrm2
         8090vMlfGQbJ1ivIbwh641L4kkj3x3MTfHHuVEdRnurml6Wz1CSAPfqheOjqDjJ2HhV9
         Vxb8pMk/NhjW/KJChu7uDe8HkHsHG1Vb94KUnX1C2WzeslOB++L0imyHYV6mvKbyi0tk
         Tlv9rCGXBpAOIJ0jQOKiRN3EYsFMBNAiNj+cPWxv7EuCC98qp0Ch/SyScpW8xRzjmojQ
         OCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXUvCOmLRFj9V68bWV7FWt2GZPLPNIKne6rJYA5H4CU=;
        b=HlfCHzTKgeDR0iI/wOTeSZRpKrY1iI8ttwwqXrWMCXpjA7cIh/S8nLDcLOT+Xq3flf
         pMBbJguzzqFwfoEZ8JH2ccTji6cvpyTObU7X7Paktswi4aXLD960liwJueobgIUYdRE5
         WDKUYoFRJgGRefxiIgaM9zipvuM37A0PVVSEjGYH5kf6fbETnv5J/ESawG6HfCrRl0yQ
         aZFFNOIurdQzyoe00ncgnYF3gucWAnhr9A3GZXErRpw++E/GhSTizpAmUGwA2ll/iz4i
         uNZUdnWFrXzI9VjYsmiP2D1VHfDCEH0jQs8STmyw58KmC06DI13CTIjY77ScOEG/EHW4
         2eDQ==
X-Gm-Message-State: ACrzQf0y09UePnjiAm2hnugrbRojrMw9ZWDIwp6cXslI/rbJsM8khDRT
	StNaM4z06i6AW9gcGRu8jUJSaA==
X-Google-Smtp-Source: AMsMyM7+29i6Elah2pR6EE8TlOoJQ4k6UjG6XeeZiHQ3jSqRDTJWquBOM9BrGIlRXeploqkyfUUhpg==
X-Received: by 2002:a05:6214:5182:b0:4bb:a323:4ca5 with SMTP id kl2-20020a056214518200b004bba3234ca5mr23147068qvb.121.1667422504780;
        Wed, 02 Nov 2022 13:55:04 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006eed75805a2sm9176959qko.126.2022.11.02.13.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 13:55:04 -0700 (PDT)
Message-ID: <1af9189f-2a59-7c4d-6582-ee222051ee8c@linaro.org>
Date: Wed, 2 Nov 2022 16:55:02 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH v2 01/11] arm64: dts: qcom: msm8996: change order of
 SMMU clocks on this platform
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>, Rob Clark <robdclark@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 freedreno@lists.freedesktop.org
References: <20221102184420.534094-1-dmitry.baryshkov@linaro.org>
 <20221102184420.534094-2-dmitry.baryshkov@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221102184420.534094-2-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/11/2022 14:44, Dmitry Baryshkov wrote:
> Change order of SMMU clocks to match the schema.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

