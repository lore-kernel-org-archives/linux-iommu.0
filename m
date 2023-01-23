Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D9733C0
	for <iommu@lists.linux.dev>; Mon, 23 Jan 2023 15:49:25 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id bk16so11205444wrb.11
        for <iommu@lists.linux.dev>; Mon, 23 Jan 2023 07:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRrlO1y0MQCgeVJ1C8FCZsk1QyUHS9Bge/H7XBbj9NE=;
        b=swDVpyA/cOqgd3BzwtL9dhxt8H4pjMIL0rkk6nBLIs34KHHA1zYpIAqLXYNFxrRLhn
         VWjyFKwr33BcWOCn2AcobEf1bcI1u5v+3/KQqdD9uTIn6jyX/uK3VdIYAAxov0Tv7HOA
         fLi9bCDGGW8azvBu5b075KGms0op8mme1Jhm0BBUY4ndfcThuVLAMoZOQ5+Zw4IK3w+Z
         vCA3PD4QELkUITjrC/cnvYHRs4/9i03RpTGOmvscyHjuWSNlBEcbmAgcPWSwlwrrwBBg
         zOSCOWyKzS2u4qgUXHE0xwXQQ/PbW+ev8hLSlz5HCUAjRF6kLSUJWfcuFw8zGu0gO+Eg
         rZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRrlO1y0MQCgeVJ1C8FCZsk1QyUHS9Bge/H7XBbj9NE=;
        b=hJ6EmYIBD4lt5AXrXwAF+4chO/NF6Lzqw2kJvLhsNI7zrDGmD0hzUR/mHTirIX8U0R
         zackb5g+R2AnlvOVDo/gaSfb2jTQnNpPMUwGjDvv1O159lTFCeY9oEqWEW+OFHzHnz1Q
         wkmrgXKopUKuWwpJanQLqcDdqK8gevnW5u5C5FigQa+BGmwFaWMiVoJOC56QZtq4HqKf
         Sc0od8CxkDXfr/Gf3Shstxm3+zRcLEFl7wac70uUs9LCC9llBOWci5424HSPzRTjf7rl
         IrwPAiyeZh9/0dGunySh8fi2UupIUgJEIpTBj6qEQCMJdtOS7tTXu1ueH32M5UEmHE/e
         0CpA==
X-Gm-Message-State: AFqh2kroldjxWRkkEhR4M2MMDfN01rZynNobTDidRcUuRDl/1TRRHiUh
	z033Yd5M9XsfOZKluqZV/lGBCA==
X-Google-Smtp-Source: AMrXdXvj7CKw9kx7uw6aIqK5wdSyxxpICiQJ8Y8+j8LTwjVqZp2eJmwSRdZfJ2o5Nu3o2AvA1xlLSg==
X-Received: by 2002:adf:dd84:0:b0:2be:4fbe:42d5 with SMTP id x4-20020adfdd84000000b002be4fbe42d5mr13917911wrl.5.1674488963364;
        Mon, 23 Jan 2023 07:49:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w5-20020adfcd05000000b002bdc914a139sm35089639wrm.108.2023.01.23.07.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 07:49:23 -0800 (PST)
Message-ID: <ee531a81-8ba8-b436-ddee-44a512c7be17@linaro.org>
Date: Mon, 23 Jan 2023 16:49:21 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/3] dt-bindings: arm-smmu: Fix binding for SDX55 and
 SDX65
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 andersson@kernel.org, will@kernel.org, joro@8bytes.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org
Cc: konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, dmitry.baryshkov@linaro.org
References: <20230123131931.263024-1-manivannan.sadhasivam@linaro.org>
 <20230123131931.263024-2-manivannan.sadhasivam@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123131931.263024-2-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2023 14:19, Manivannan Sadhasivam wrote:
> Both SDX55 and SDX66 SoCs are using the Qualcomm version of the SMMU-500
> IP. But the binding lists them under the non-qcom implementation which is
> not correct.
> 
> So fix the binding by moving these two SoCs under "qcom,smmu-500"
> implementation.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

