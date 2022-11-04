Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CE5A47
	for <iommu@lists.linux.dev>; Fri,  4 Nov 2022 01:45:40 +0000 (UTC)
Received: by mail-qv1-f48.google.com with SMTP id o8so2363042qvw.5
        for <iommu@lists.linux.dev>; Thu, 03 Nov 2022 18:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=idTS4SelBRvz9HEBMSJGvE/A1qHqs1yN4on3ybwNC48=;
        b=OjBnP9x2dKU/TwQkPcpAefniTLnh89qNp0UZAZEcxTJgMM58mGfFQzaX621zsY5Nck
         ojldyt/w1Mp/fw3IvEb4nFNkFczmPgS8rCXVvyEManOZPfKibqdAyj2TqJz12i+/0zvD
         Ao31Q6GvcP3uoAid5T5ydbO4eiU3YR+OXDByETT64y49+Jvy5YZzWGpuJI1//a9LsfM+
         Y/c3wGC2hOgBDqc7+4emqRJphavau+7wvhKwNODuxJgWfXXtCkyQqYuqY9Szt95If0o0
         JPJBq8eU7RcxwIUCJ8nVEW8BPz7YatV+Lux05ccZzKHU/cYjSSlwmr/+LOb84VRXRfi+
         LXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idTS4SelBRvz9HEBMSJGvE/A1qHqs1yN4on3ybwNC48=;
        b=PD7FWRKkRQp0T60p6RreZ2nst57w1Qc/RRs3Oy80wy73ou9rfEpgYplalNv0TvWotP
         U5g/mmI5N6jrfFjRBsx8mbDzKesd4gdysjgf5Z6m71YraZrYP3zJ60UUW8C5vRz3bXfi
         tiy7WWVMcDtTKhrrEQ/OE1qpQZ4L+ayr6pfeux5hAnJgZgX/btFMAd3lHInY/qCZToNQ
         kcLXuOgr9MzO1boXgCRqLcqUjH2InN+/f1Y/z5zoNCJTWZF87crE6B6Wj6p/oeZNFZRM
         BEBwF5qaxvoPGfGHyhWCXD6uWcuW3Ms1qLYoyJDqzzKPcdpTEaHop5TQmyDFG4tKEu8v
         SZzg==
X-Gm-Message-State: ACrzQf0IV90xtNgv5/A3mrrazXH9ZPdCnJEalhwKHHKChyefn4Ne0jfm
	VW7APoAgBFDTg8zLOl4eqKG8Eg==
X-Google-Smtp-Source: AMsMyM5+T0lH6IliHmdWswvFwDwmXCa63u4RyjwkNBrqSnB0voVqyMdUppgaAB0i0IVqxZZcy9gF0w==
X-Received: by 2002:a05:6214:268a:b0:4bb:62a8:990 with SMTP id gm10-20020a056214268a00b004bb62a80990mr29273628qvb.75.1667526339806;
        Thu, 03 Nov 2022 18:45:39 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:da2a:9e7e:ddb5:dfa1? ([2601:586:5000:570:da2a:9e7e:ddb5:dfa1])
        by smtp.gmail.com with ESMTPSA id g14-20020a05620a218e00b006ce580c2663sm1865195qka.35.2022.11.03.18.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 18:45:39 -0700 (PDT)
Message-ID: <bac94304-794f-79ee-5ad3-0363121e0305@linaro.org>
Date: Thu, 3 Nov 2022 21:45:38 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 1/2] dt-bindings: iommu: arm-smmu: add sdm670
 compatible
Content-Language: en-US
To: Richard Acayan <mailingradian@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>, Vinod Koul
 <vkoul@kernel.org>, Emma Anholt <emma@anholt.net>,
 Rob Clark <robdclark@chromium.org>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20221103232632.217324-1-mailingradian@gmail.com>
 <20221103232632.217324-2-mailingradian@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103232632.217324-2-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/11/2022 19:26, Richard Acayan wrote:
> The Snapdragon 670 needs the IOMMU for GENI I2C. Add a compatible string in
> the documentation to represent its support.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>

There is ongoing rework of these bindings, so something needs rebase,
but FWIW:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

