Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468E91DA38
	for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 11:14:25 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-31768ce2e81so6761253f8f.1
        for <iommu@lists.linux.dev>; Wed, 13 Sep 2023 04:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694603663; x=1695208463; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4j22lmDBEdz68x3qUhl5gJ0drA+YexofLKRZQjwWfs=;
        b=Bj/MnHcJzmRrSz4cnUNY2nfHc5HGKGwozMab3lv/6qTHtx0EC0RiWcwxro999wovFj
         4KJtdd8oLjJi8M0/1t939J3jpYvGwvUBMZuEPa6hFHRJ1oS7IH8/cet7ruiy03dn0MyV
         FxYwAd6/ceoLMk3/QmegjMZB+gq/3mU+hlBjgfM37ike1omWN+rRya7xe9xi/tj/rq7+
         U85QQkir6wHOUrANyCuWsAKzJdSoJOs1B9v/AR8eG4RaxDnmUZZu9NS1X/G6cko3duXe
         4cmjNztFOoqZO2vsEm4Ol1GRMDjirlKa/FHkDKP7ODYTsq8IQrfADQD9pvSii1QXCbuY
         CFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694603663; x=1695208463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4j22lmDBEdz68x3qUhl5gJ0drA+YexofLKRZQjwWfs=;
        b=nzAM0eseqEw/OXMhBKy1NbewmRB/0UKj6440knfSlCPReCnZ1WMGBxkH8BG9F1LkPb
         EogQueD81FC7H9ZSig2ZJ2w2sbA/rK4D1U9tRWL6aHLRmgbxNF4SY6FpCYeFbNiqIp1o
         UvFuVq01VvO3ZVm2VLPoO4Lo1sIT9atP4txrsK2dizSMleBzH1O5aKx/jo6TvkbzKzBm
         Bpj9tuR9tqLwkb7dlggahzEhTpGEpsu/Jlaq7/VI8Vhm4geJQLghc6hRCE+YCrQaluM8
         cLXqRqeLPduk5UHHfdIAHm/hU8FArtnVoFsG9bXdFYOG9sHxQU6fZv7n8yNKRaVJ0Lc3
         ZkhQ==
X-Gm-Message-State: AOJu0YzDUqp3MzB45gjvFFg/4vTl43jwx5tLhcTi0a63yjRO9Yk3uWof
	sSAwwtOIqXEUEaS87LSUcSXlQw==
X-Google-Smtp-Source: AGHT+IFJlSnmnVty++JAQlMdedVZw+ig39ydIHFfYUarwozinwRjAGGXz3bvVLJ7KKgGWK++b7J6OQ==
X-Received: by 2002:a5d:4a09:0:b0:317:70da:abdd with SMTP id m9-20020a5d4a09000000b0031770daabddmr1727674wrq.59.1694603663440;
        Wed, 13 Sep 2023 04:14:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id l5-20020adfe585000000b0031759e6b43fsm15246555wrm.39.2023.09.13.04.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 04:14:22 -0700 (PDT)
Message-ID: <30bb6068-6bb8-9a2c-af19-b989960d0be9@linaro.org>
Date: Wed, 13 Sep 2023 13:14:20 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 01/14] arm64: dts: qcom: msm8916: Drop RPM bus clocks
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Sibi Sankar <quic_sibis@quicinc.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-usb@vger.kernel.org
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
 <20230721-topic-rpm_clk_cleanup-v2-1-1e506593b1bd@linaro.org>
 <bd11d1b1-efe5-4f96-43e7-163fca5d3278@linaro.org>
 <ac501bcc-80a1-4b65-ba24-272152d1c95c@linaro.org>
 <7b500bba-3091-f425-a60d-e58a3d9e4c1a@linaro.org>
 <9a0ab5a9-d4d8-41b8-94b0-9c62bd686254@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9a0ab5a9-d4d8-41b8-94b0-9c62bd686254@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/09/2023 12:48, Konrad Dybcio wrote:
> On 13.09.2023 10:53, Krzysztof Kozlowski wrote:
>> On 13/09/2023 10:47, Konrad Dybcio wrote:
>>> On 13.09.2023 09:07, Krzysztof Kozlowski wrote:
>>>> On 12/09/2023 15:31, Konrad Dybcio wrote:
>>>>> These clocks are now handled from within the icc framework and are
>>>>
>>>> That's a driver behavior, not hardware.
>>> I believe we've been over this already..
>>>
>>> The rationale behind this change is: that hardware, which falls
>>> under the "interconnect" class, was previously misrepresented as
>>> a bunch of clocks. There are clocks underneath, but accessing them
>>> directly would be equivalent to e.g. circumventing the PHY subsystem
>>> and initializing your UFS PHY from within the UFS device.
>>
>> And every time one write such commit msg, how should we remember there
>> is some exception and actually it is about clock representation not CCF
>> or ICC framework.
> So is your reply essentially "fine, but please make it clear in
> each commit message"?

I am fine with this change. If commit msg had such statement, I would
not have doubts :/

Best regards,
Krzysztof

