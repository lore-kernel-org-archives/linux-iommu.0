Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8D279C9
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 17:07:51 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id a15so14045384ljb.7
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 09:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fM40YsHG69XSps9sYkKuoIaYvYZTcDub0ndtXX1Pvw=;
        b=kjSmJdC6Mfa9wOoKRy+htVdYDPOpvub0TN6pbQE+j8u4+a+UM/QFiVHrLsrjWUNnbD
         UHDvGNmiHaesMZ50QWLs3OchlpqHvtTPMTy7DpM0P170FKAQMhlRlTec/Vi7rb3hwN3z
         zhMyNmte5yxkxqAODU9OtCXZW8QiisaWfz6HgA90DbUYs2TQ9T7dc1aOJZ1znOVIPQZ0
         LeHpQl7HWNM8ycNYI/70mYxKICSUeBDHh7RA4tsncsLBtwB8+TnxotIJpjVXxRpv1zLh
         y8sIxJTperHHwqKIeTLjLkSMDM0k3akxb5oZfUKI58WjMu6CyDdQoUaOUtbux+/bbBas
         s6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fM40YsHG69XSps9sYkKuoIaYvYZTcDub0ndtXX1Pvw=;
        b=UMoukuyRavUqhhM5dh0/Qs9WlzeSr2PJ/LH5DQUvASTfhNPozJ1yOoePG+Q1AgemOT
         U3gwdDywFjs9OgZmjWojCq6T3PMiu0YFxddL4EgumkrXgrhfRgrVDYMncPc3UzNfsSw2
         H4Ids0sc8wpuhFtjjeBPiZcCr1waS6WjW6CFrSSihUjFTI7X7Jkk7vxtEieA5VfQmKFN
         hNv70Xc8epju7A4e2WduznSjbla78Y3M/GYBxZSqBUJbPkSgLVHDxqoX2T88tyWnwx4R
         rHm6+AK+XpcdvXNctjncMtgKm7ddwXIBS7UO/qoBCHtXKiOk6zZahDb9wDsTy24VArU4
         OjsA==
X-Gm-Message-State: ANoB5pla0zhgtLs0Jgg53OekLGTVk9Pj21AM5PpErQ4g1uBI7zbSKU7v
	wA5rExLdevZuez+VCxIfY6O80g==
X-Google-Smtp-Source: AA0mqf4lEIKNad99guFwwYc4jeiWore22u9FDVNQkYDR6JMjsV1sTvL7Q9zluHk9OLGTXJjxMQr3LQ==
X-Received: by 2002:a05:651c:210a:b0:277:1295:31ca with SMTP id a10-20020a05651c210a00b00277129531camr4422149ljq.280.1668445669605;
        Mon, 14 Nov 2022 09:07:49 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b10-20020a056512070a00b004948378080csm1886391lfs.290.2022.11.14.09.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 09:07:49 -0800 (PST)
Message-ID: <47ff366c-c860-e9ad-c5ad-485eff6f649b@linaro.org>
Date: Mon, 14 Nov 2022 20:07:48 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH v2 00/11] iommu/arm-smmu-qcom: Rework Qualcomm SMMU
 bindings and implementation
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>, Rob Clark
 <robdclark@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 freedreno@lists.freedesktop.org
References: <20221102184420.534094-1-dmitry.baryshkov@linaro.org>
 <20221114142326.GH30263@willie-the-truck>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221114142326.GH30263@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/11/2022 17:23, Will Deacon wrote:
> On Wed, Nov 02, 2022 at 09:44:09PM +0300, Dmitry Baryshkov wrote:
>> The main goal of this patchset is to define a generic qcom,smmu-500
>> binding to be used by newer Qualcomm platforms instead of defining each
>> and every SoC line with no actual differences between the compats.
> 
> Thanks for doing this, I really like the cleanup and the possibility
> that we can stop adding all these pointless strings every release!
> 
> It looks like Bjorn picked up patch 1, so could you please rebase the
> rest of the series onto my SMMU bindings queue:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/bindings
> 
> and address the minor review comments you had so that I can pick this up?

Done, thank you!

https://lore.kernel.org/linux-arm-msm/20221114170635.1406534-1-dmitry.baryshkov@linaro.org

-- 
With best wishes
Dmitry

