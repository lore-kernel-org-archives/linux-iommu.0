Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2A48447
	for <iommu@lists.linux.dev>; Thu, 22 Sep 2022 06:39:43 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id j24so9268685lja.4
        for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 23:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Y9it4dxu8zLENQhpiztD0qTlsy9XVvm5wGeuzw4ftH8=;
        b=OQ9KVALrZqkz/x7hew6GkzX4KKF13X8o5JJaAiZQ20KoDNp8yTjux3FBvRSA4rpDvO
         xtJYChGki+NkDKgUMnk82VBSC1HYqGcUXFcjHtMxge/PNa8pvDZjFyqgSpeJ/NWv5h/v
         39U7x2LhsYePSL3BTkCO5YSl2I3hAab2kw17MDECHgdp/FilQ50ZdmuKDf1Z+lvuYfDM
         9WgAHT9EMrJHexeKuosW9Tqvknp+Ss7MB9BXTC7EtJrkfmJrcqgsjPEXV26hsa8Zodhr
         eE4lP7HaIJLQRZFoKK5tdRUsdvA2dNnDX+m/+Gkrv9GDxEPa36hwd+rL4M0xypU9iADl
         51Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Y9it4dxu8zLENQhpiztD0qTlsy9XVvm5wGeuzw4ftH8=;
        b=r+r++bvllX33PAwnFDZY10yO161DCA+L6BsUHSjJgVX+Ll967TSmUWrtxOuCssIlZu
         vj/dQ/71mSNN7+POmkcxjGNmvRTVx/mdiJezyxpovmeQKE9uykzMVi2AvCZhA2wnudQf
         fT4JeJpn8zOD8kiahm2/YAgsqNWi8xkvaiqMsXiFkd9NUfeGVv9v7Rq73duNt+JtK5kJ
         3hDLN/1ZOIBz6KbrGBtZRBFfC+tItRMl9/tokvhW4S7uJMl0KLHMDzHD0ci3n717COEV
         IFk5dE5Leol+Fp1TnmF6Iin5fdvf/LwId0XMrRS9eHjHaksw+zhJBkaTKAeJ442fkCnB
         w+2w==
X-Gm-Message-State: ACrzQf1y3fuZ5nCgY9twz49Xlu6eXmr5rDcfDf72WK9M+5cyeX4Z0nad
	81vbVFaEuKN5TYbRqEqNrghrbA==
X-Google-Smtp-Source: AMsMyM4NcODEXdqj7wdcU9cj2VvWWAhTr0alCSdk3U0Cy+ArQQf1phMq6WHSoi06VLJ2WCKmFbVUug==
X-Received: by 2002:a05:651c:239d:b0:26c:4eac:d64e with SMTP id bk29-20020a05651c239d00b0026c4eacd64emr610482ljb.167.1663828781456;
        Wed, 21 Sep 2022 23:39:41 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t7-20020a05651c204700b0026acd11cd51sm749995ljo.59.2022.09.21.23.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 23:39:40 -0700 (PDT)
Message-ID: <26271806-df86-393c-bddf-75c82d54fe53@linaro.org>
Date: Thu, 22 Sep 2022 08:39:39 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] iommu: arm-smmu-qcom: add sdm670 compatible
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@somainline.org>,
 Richard Acayan <mailingradian@gmail.com>, linux-arm-msm@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Clark <robdclark@chromium.org>, Sibi Sankar <sibis@codeaurora.org>,
 Loic Poulain <loic.poulain@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 iommu@lists.linux.dev, devicetree@vger.kernel.org
References: <20220920223955.151507-1-mailingradian@gmail.com>
 <20220920223955.151507-3-mailingradian@gmail.com>
 <77b7d58f-ba85-86de-8635-6efbb1354a08@linaro.org>
 <5c25dc95-d7a4-0b15-5514-6fe3a48e899c@somainline.org>
 <f98ccf6b-34e7-d15f-63f9-928827b52eb8@somainline.org>
 <30980ac8-1386-d284-8452-fdc5b7da8343@linaro.org>
 <5f629a95-8ee4-7cf8-f471-0b50e311d3b7@somainline.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5f629a95-8ee4-7cf8-f471-0b50e311d3b7@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/09/2022 23:14, Konrad Dybcio wrote:
>> Unfortunately I don't get this explanation... you mean some other
>> firmware requires Linux drivers to use specific compatibles instead of
>> one fallback?
> No, perhaps I misunderstood you.
> 
>>
>> All of these do not have driver data, so they are essentially compatible
>> for Linux driver. Growing this list in the driver seems pointless. What
>> is the benefit of growing driver with same entries, except more patches?
> Compatible lists in smmu-impl files allow matching driver quirks for SMMUs themselves
> and consumer devices (such as MDSS). The situation is more complicated, because some
> qcom SMMUs also require more quirks than others (think 8974 vs 8994 vs 8996/pro&660&8998
> vs 845+ vs adreno smmu in various flavours), so all qcom SMMUs need to use
> `qcom_smmu_impl` and some others need even more quirks on top of that (that generally
> hurt performance or functionality, so we don't want them when they're unnecessary).
> If all generations of qcom SMMU implementation that bear the same name behaved anywhere
> near consistent, there would be no need for keeping this around, instead requiring only
> "qcom,broken-smmu" or something".

So where are the quirks? Again: driver data is empty.

Best regards,
Krzysztof

