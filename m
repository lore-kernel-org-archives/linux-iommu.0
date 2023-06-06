Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB64A2119
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 06:06:24 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-977d0288fd2so350666266b.1
        for <iommu@lists.linux.dev>; Mon, 05 Jun 2023 23:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686031583; x=1688623583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvDh5BsnU3tF3jOG1nk9VooktqarbPV+7D1/4gVZFeU=;
        b=PpVLxDUIMRzQlN/pvWtGQLa7SpeCYQ1H05zs/yOGO3P5SXkR578MQ6gxdfls1LX2JA
         tDI7ct04Oi0CT28GjgsHsiK7mRRuKjbGb//3UVagqp3/aQt++aFXnlYQZKyNwZcgEyFE
         xm0r94rVOqhHBF6/xyAgKLdIEK7TrQ7zMdkGpcPAID5NEtg+PepBl9qRq3q3UD92AT1H
         h8FJB4EhBj/Rpw5UWx5/yROTKn0YhbUWlKyUqRMJlfJ6Je+8yN24Lzvz6fuTKMqfRHu6
         /8G+q8JVBV2AFFFfrNxjA3JCTV02cM20YojRv43SXusj9tbtZWjfhIJC+64Iip3XL+wJ
         ypPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686031583; x=1688623583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvDh5BsnU3tF3jOG1nk9VooktqarbPV+7D1/4gVZFeU=;
        b=dDG9o5CM9dqsg27V/ZVQXZs4lRBpNMWQDJUctxNm0CvlScQdJkcNWCLe4wu1SU07UD
         sseMwBBgjSOjxzAXgIcxAT8IBrKB2AeIpe11M2X/zVZ9NOPUg3Y7z2afPKdUB14GKIOi
         2cYJKrdNRnK5/x63Gv7s5mrsuF6WhEhBg7Q6/NZIbPtfc2azP2Ye3W+RtfE72JFvcsxC
         oAf61UgL01Ah4EKST6EHjM3kNx7wtCywBPJH5o3pg6eJ/v4AU+W6OZxy9AXmet7Q0gp5
         vuvZKTUxIGuyZBWfkNy6+gu3y/imRc9yQY/1BqA85vq2WHrRclAu05RmMkG/BntTa+AO
         Y0ww==
X-Gm-Message-State: AC+VfDwZtLnmpkMgWklFlSjxZzr2C7ew6Sq3cZV4erPk+exB5N8FqpIe
	pz0dgaWGvPh0AQndZ1UmqxsTiA==
X-Google-Smtp-Source: ACHHUZ7aR5/H9xX8f558HHUOk+j277NWhkqZokqLSzVflv5qVSUKTBACmv4OYehJ9JH+WgM8BErYQQ==
X-Received: by 2002:a17:907:3d93:b0:977:c7f6:4e9e with SMTP id he19-20020a1709073d9300b00977c7f64e9emr1096759ejc.33.1686031582796;
        Mon, 05 Jun 2023 23:06:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id o12-20020a170906358c00b00966447c76f3sm5179810ejb.39.2023.06.05.23.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:06:22 -0700 (PDT)
Message-ID: <7a6544b0-5c8d-8b61-71e8-32f59e93c2d4@linaro.org>
Date: Tue, 6 Jun 2023 08:06:19 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 08/10] arm64: dts: qcom: Add QUPv3 UART console node
 for SDX75
Content-Language: en-US
To: Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, rafael@kernel.org,
 viresh.kumar@linaro.org, tglx@linutronix.de, maz@kernel.org,
 will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, mani@kernel.org,
 robimarko@gmail.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
 <1685982557-28326-9-git-send-email-quic_rohiagar@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1685982557-28326-9-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/06/2023 18:29, Rohit Agarwal wrote:
> Add the debug uart console node in devicetree.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sdx75.dtsi | 49 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)

GCC and UART are parts of basic DTSI and do not make sense on their own.
Otherwise, what exactly boots on your "basic DTSI" commit if you do not
have any clocks and serial console?

Best regards,
Krzysztof

