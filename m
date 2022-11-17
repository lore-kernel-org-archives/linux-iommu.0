Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1372729AC
	for <iommu@lists.linux.dev>; Thu, 17 Nov 2022 13:07:10 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id a15so2603506ljb.7
        for <iommu@lists.linux.dev>; Thu, 17 Nov 2022 05:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTMuaBfKCMZXSl9LUyd4MIB5DqyeQyzncHYThdTUxqc=;
        b=FrCOZ6nVXao0w5awL8iRMvlXfEYyNRkTaPpnAujQjsIOw03r6wIvF6HBvR7ZDd2EyM
         aCROBjtDlRd7G2k4+P4mJDkl1uQsNj2IONW5BiM+a+EJJr9QP6N39PZb0eGaJs8awrB5
         qIkMrwWAJCjpRU2gWSG40wnLdTjg9i17NsQ6jaS0gOAfDwgh/zns8o1ittbgVaTQ01b8
         4xI+m78UCRp63u+03o1okyoXjzbYlAK7QqX2TYZeDmBhlvcWGyLjJQXVi5au8TLqasBu
         3/RlO4q7QDNVwdhP60FwiXTeqNIaJSvEBIJHTRn1Oq1xJhLCAGVz7G4pjI7J4M700S+V
         UAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mTMuaBfKCMZXSl9LUyd4MIB5DqyeQyzncHYThdTUxqc=;
        b=Ltou35reBxyfA0GOZ8Sc98F26UvvBaWV/nkqgrdCRpTHGzfv0N6HhXfJhR2kb72FfS
         1JG0d1Qp9pjhSSvAxb9oNZcbDv5PJ/qxGzYXPDFTcddaGIxgN8ogSAY0/rqGKDRIKrCE
         +rTtVZAlohso4vJOAsHJ3xTWmMEyZ1f7ptZgLzIL1zz+g6sZ4wbQpc8SAbx1zgy6bxOY
         kjalvTPapxmL4dBlkY2H1Vxz14Jj689Gzm5VyVaizQjR+Oe0Yojae1FpUoHiKMfAydGx
         C5QS2GpxvOBNa7y1cua0BayrbrN7S/K5msiD9zJJCoA+au0EeHbYwxG+/VavgC0a2svT
         2ikQ==
X-Gm-Message-State: ANoB5plEeB1rbkEr6zN8lWYKeX5BCIVKhcVI7J5KFpa/IOcY1Qt06o87
	l74tQj+3NGv8l/DMJeTBw3IPZw==
X-Google-Smtp-Source: AA0mqf75w4xQTmMedpWhD/8OvEx6h6E/KKGgAMpDrEd5hZKxX3G1odg3r90a7WzY1EkIFjWmWmh6sA==
X-Received: by 2002:a2e:a58b:0:b0:277:278:de24 with SMTP id m11-20020a2ea58b000000b002770278de24mr928223ljp.388.1668690429153;
        Thu, 17 Nov 2022 05:07:09 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id j7-20020ac253a7000000b004acb2adfa21sm136918lfh.297.2022.11.17.05.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 05:07:08 -0800 (PST)
Message-ID: <306064c9-1b8a-03e5-97b5-6cb2dbb6d8a4@linaro.org>
Date: Thu, 17 Nov 2022 14:07:05 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add SM6350 GPU SMMUv2
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org, agross@kernel.org
Cc: patches@linaro.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221117094422.11000-1-konrad.dybcio@linaro.org>
 <20221117094422.11000-2-konrad.dybcio@linaro.org>
 <77805b04-2724-dc93-eae7-21d9c7caf0a4@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <77805b04-2724-dc93-eae7-21d9c7caf0a4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/11/2022 13:55, Krzysztof Kozlowski wrote:
> On 17/11/2022 10:44, Konrad Dybcio wrote:
>> SM6350 has a qcom,smmu-v2-style SMMU just for Adreno and friends.
>> Document it.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> (although this might need rebase later on Dmitry's refactoring)
Oh, I forgot to mention this patch was made on top of Dmitry's work. But 
it's good that you pointed that out!

Konrad
> 
> 
> Best regards,
> Krzysztof
> 
