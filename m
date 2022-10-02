Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063723AA
	for <iommu@lists.linux.dev>; Sun,  2 Oct 2022 08:17:30 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id g1so12662902lfu.12
        for <iommu@lists.linux.dev>; Sun, 02 Oct 2022 01:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=u5vwi2mv0cJCBaFXR16xTWh3Sv0rQv1R6ZlbVcZs2s0=;
        b=Z25NH7UkqHJjPxoqbM8K0rUlPMCJlDJ8Rbzfk70/LuafFxXPRW8pq7GC9+7+PGDNcx
         ggOMYooosvzSkdDInDFtudXttiEGnDIDBybUm7hVQp895bEvpLH98MPepdY00j3DWusE
         00wVD/fraShm7516tBo6eF37sGuQHWHX492O0GUM9nja+x0OKJACldSfziOCFZcltNLx
         +V2y+YSr4ZLzK8SGenBTAO5xvHJdTed4EEeR0M9KsotzlbgGoIqUCr5D2raU5E65pNKY
         5XcO1aksk97dgT9iwAdRdfrxI7zwfRFKhxrN9W1dfxTRX2kxr/HcAd9X2Hk4ddD+Gwr7
         eIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=u5vwi2mv0cJCBaFXR16xTWh3Sv0rQv1R6ZlbVcZs2s0=;
        b=3bWrJQw7KMW4pNkoGddzkEAzyzE0O6/XlwoCy6zMW33mXbxJB4VVsc+4ID4SO5dnlo
         6zs8q83yxGFnHlS/JcHddOAAWRjO7NXgTSOE55DbiQTziMccHjtPBPs81rgyHTGQAGrW
         sgX5IaxlDzezDaoF/M73uszZUuvPZVuRDr9gHLPjd7+k2Y5WQdk0MXThIdXSCWgC21wz
         vDpYpswVIMfJeA6YSJSM8PgZ14WjJaDocMQdScQP5XeZmdp8H79qcbMkEPpvZGRyZrHy
         KZRPhU2fB/M8LEc61zbG1hlU8JMxFQejteBQTXsnsgCAScYCvgcpy18OtEwpA6InrNPn
         9DAw==
X-Gm-Message-State: ACrzQf2+pD2lXRnyYyblgbs4FAT+tWLQut21U1hqGOtmEMpWcyYUHb+k
	Iu3LBHEPmwm/iX0i7CsLfXPBVQ==
X-Google-Smtp-Source: AMsMyM7MPiVwZCk7siZV+RrnjBIXnhITNfmFjP1d0jPnDwzyRQpqWoWoaW4cduej8hxjsM3h643Jxg==
X-Received: by 2002:a19:4358:0:b0:49e:e545:3cbe with SMTP id m24-20020a194358000000b0049ee5453cbemr6278473lfj.551.1664698648739;
        Sun, 02 Oct 2022 01:17:28 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id n5-20020a0565120ac500b0048a9e899693sm1014899lfu.16.2022.10.02.01.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 01:17:28 -0700 (PDT)
Message-ID: <1f077808-9e04-3098-e78e-f9435bc954a9@linaro.org>
Date: Sun, 2 Oct 2022 10:17:27 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/1] dt-bindings: iommu: arm-smmu: Add binding for sm6125
Content-Language: en-US
To: Martin Botka <martin.botka@somainline.org>, martin.botka1@gmail.com
Cc: ~postmarketos/upstreaming@lists.sr.ht,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jami Kettunen <jamipkettunen@somainline.org>,
 Paul Bouchara <paul.bouchara@somainline.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001185715.495477-1-martin.botka@somainline.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001185715.495477-1-martin.botka@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/2022 20:57, Martin Botka wrote:
> This patch adds binding for sm6125 SoC

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

Fix it in all your patches, please. It is just "Add binding for SM6125 SoC".

In the same time, your commit subject has redundant binding - first in
prefix, second (redundant) in "Add binding for". So just:
dt-bindings: iommu: arm-smmu: Add SM6125

Please fix both in all your patches.

> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>

With subject and commit msg fixes:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

