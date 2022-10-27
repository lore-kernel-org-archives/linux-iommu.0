Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0099E2568
	for <iommu@lists.linux.dev>; Thu, 27 Oct 2022 15:27:11 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id a24so1351674qto.10
        for <iommu@lists.linux.dev>; Thu, 27 Oct 2022 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9LPbSDa+MBywOmjjYSQBrIxZtqwfqdklED3LdicRb30=;
        b=f1pJAPwVik75oeO3R9Cfh95P3uRLmnpTBaXmTyyd/nK6BAF40G2FI6QJQseH0ZpaMG
         o8NjePfWROUjrYN/H1rYKeLUwFQkzzMlrqHw5CHZuXIXpTQiDep23SYO8hpzqckGzVOu
         IJ38tor/aLMUvF9rtEfUHXoZrYNBli/Rk4gOxXN/r5qxiBk9JgB2tovGeHA0pG8ushbI
         eUQvauYPA9quKmhnbZhgksHvliu1Iy28aOmQWAq4ZppJJepsipSsNtdL+vXiPFLXR/wZ
         Ow3djaDWx0/1L85XReUGe10at7Z2g7e1P5rQHsuYAdIcRpUSEBlsB9kdjd6dqWQXgUic
         Yd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LPbSDa+MBywOmjjYSQBrIxZtqwfqdklED3LdicRb30=;
        b=B9rPm8UrLXQuSjDXtzawP2hb/QVl5KOVCi40GRaPjDImmkqqYzBAGWXRUVPbuha237
         rPfNLWjGPambrw1InK83f5qajPOaVEGDwvwfGCqs4BlbqAZGHEyXZCvdzAghMstB2TL4
         3wpn/122q8KUpju6yYvTQZSXOOo5nSKZHoLY/N7K+Qdsevrk8HkdG3a6jdGhLnc9xfqO
         rUvUlznI/HHMdYWZW7zWMyErhCQYNc8CofUfB4PiP7T1OQPzSIXl1+rbLiRijrr+8UsV
         o7JlYkAAikSUIpKfn2JUgGI+iyZ9+jVu9VZI0YfjujfioE19jkGJP95S62j5T+gltazT
         M2tA==
X-Gm-Message-State: ACrzQf3edUzB186J/mafmI2518+CFgbN6PggjBIQsKhXQgSLJMdkUbR8
	UhGWFTU3Bw3RAYpZLp0efzVsIQ==
X-Google-Smtp-Source: AMsMyM4V1nmDJiKVYlT4rp0C1d+f84x0+W0srdAfp3Co9LNggnrL3zdamZcPPzCK4mwZ/oGlcxTqMw==
X-Received: by 2002:a05:622a:1313:b0:39c:ff31:21e0 with SMTP id v19-20020a05622a131300b0039cff3121e0mr9149632qtk.274.1666884415437;
        Thu, 27 Oct 2022 08:26:55 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id o24-20020a05620a229800b006ee7923c187sm1140355qkh.42.2022.10.27.08.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 08:26:54 -0700 (PDT)
Message-ID: <b999144e-5137-6363-9792-8e6cf67e6a82@linaro.org>
Date: Thu, 27 Oct 2022 11:26:53 -0400
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/2] dt-bindings: arm-smmu: Add compatible bindings for
 QDU1000 and QRU1000
Content-Language: en-US
To: Melody Olvera <quic_molvera@quicinc.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221026190534.4004945-1-quic_molvera@quicinc.com>
 <20221026190534.4004945-2-quic_molvera@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221026190534.4004945-2-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/10/2022 15:05, Melody Olvera wrote:
> Add compatible bindings for Qualcomm QDU1000 and QRU1000 platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>

Drop second, redundant "bindings" from subject.

This applies to all your patches and all your patchsets which are for
the bindings subsystem.

Best regards,
Krzysztof

