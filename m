Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7F8190
	for <iommu@lists.linux.dev>; Thu, 15 Dec 2022 15:14:20 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id b9so10217209ljr.5
        for <iommu@lists.linux.dev>; Thu, 15 Dec 2022 07:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKBX4dCAGxM9FIuN9j+5uOON5e07EkYesLemjwlfmRc=;
        b=jqn4qm5AQpP3pXvXfNliwLe7ReHlO3yIHYcnTzDqLfHZgOwC6WadMZBme+JdN8Gkv6
         /vxPZyh2V3v9oYIFj3/3kwY2F9FV0aO87kSiQ6MTjUbP41o2odJf48YT0QN6+hKZJavQ
         iIZ0Qo3q1fa1Skc5gFObSpyjXV40tVK1zBX1OAUgcRzUU6u7swwq2uPqxpXGRYzOpRHp
         uSs01A6CQyZAhyrWmYlbjhs2edJRSWNSroK9l2tqX57M7PQKZMn17PX4XBl48dPyQa9B
         dfRkOdAouTe1CGXiJhlfozBXWe+xweUJvhIcG/xMbXqKi1jiVwE+7D1ZHeeQr3HAc+dw
         omQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKBX4dCAGxM9FIuN9j+5uOON5e07EkYesLemjwlfmRc=;
        b=qmJHgpsqE1KxL0SAHzhQnaNli7GAhm5ipWww0aSm2kE2KADx4L0qmPnScvdc4yIl3A
         62WsWTDd8qDa9YdTdJWP03zMnAMILvoDBn3/SP2i1FAUtPJ5m4q3OgF3BuNi83Jq6F5F
         2R0ert3ntNndn9UmxsIGVVE+ly9DwdkEw42x9QNLp997uk6xbC0TLDoksPfelcmwbAWU
         hoA4wOjgoRoQynsM/3Mth129p+eR5POuapkMs5bByxlpODP60V81pZ2xxO7zg9c1kbIv
         0gQxgMMt8Gp+gyeISATrqpn5CIoEvA/Bv6Nx/v0kM0aSQ0ZTFn6oSuMHRp1yA/zXEC4y
         VaEg==
X-Gm-Message-State: ANoB5pn2Xy0ihkI+0THErZuL7RHPRJXQTNatlbLFuHWXGgc3YxtqwIth
	tac78Wo5F3n9UGaOPABz+Edbeg==
X-Google-Smtp-Source: AA0mqf638NFbBfGyPPGUbiWU9jAZwDUrabmGYbZxWlmgWMVwFUJj7vPxpXSFyFHzx/HqOpwBT5wIvg==
X-Received: by 2002:a2e:a809:0:b0:278:ed26:60e3 with SMTP id l9-20020a2ea809000000b00278ed2660e3mr7180275ljq.25.1671117258550;
        Thu, 15 Dec 2022 07:14:18 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q18-20020a2eb4b2000000b00279f213302bsm859063ljm.57.2022.12.15.07.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 07:14:18 -0800 (PST)
Message-ID: <3134ba66-27bb-7015-8988-6c8dec046b0f@linaro.org>
Date: Thu, 15 Dec 2022 17:14:17 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 5/8] iommu/arm-smmu-qcom: Add SM6115 support
Content-Language: en-GB
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Iskren Chernev <iskren.chernev@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 Adam Skladowski <a39.skl@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>, Emma Anholt
 <emma@anholt.net>, Rob Clark <robdclark@chromium.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
 <20221030094258.486428-6-iskren.chernev@gmail.com>
 <9e94c0b9-f901-5ac9-2abb-40e958cbe5a2@linaro.org>
In-Reply-To: <9e94c0b9-f901-5ac9-2abb-40e958cbe5a2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/12/2022 17:10, Dmitry Baryshkov wrote:
> On 30/10/2022 11:42, Iskren Chernev wrote:
>> From: Adam Skladowski <a39.skl@gmail.com>
>>
>> Add the Qualcomm SM6115 platform to the list of compatible,
>> this target uses MMU500 for both APSS and GPU.
>>
>> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> 
> This needs to rebased on linux-next (or 6.2-rc1 once it's out).

To add on top of that. linux-next has the following comment:

/*
  * Do not add any more qcom,SOC-smmu-500 entries to this list, unless 
they need
  * special handling and can not be covered by the qcom,smmu-500 entry.
  */

So, hopefully you can skip this patch completely by depending on the 
generic "qcom,smmu-500" compatible.

-- 
With best wishes
Dmitry

