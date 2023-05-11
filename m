Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA27A38
	for <iommu@lists.linux.dev>; Thu, 11 May 2023 09:50:02 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-956ff2399b1so1575937866b.3
        for <iommu@lists.linux.dev>; Thu, 11 May 2023 02:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683798601; x=1686390601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZeuJxcLYHvnducoUZ2tfN6ldpdzeLGAaTYjya3TOvfo=;
        b=NFXGriYCOSUh+Lw7dIdqAPCMJ29f5l043OJhVsEeEP4U5lPIAu8F9ns0tM9PoNJs9e
         A5P4fNhWdJrw9ATAPy1aCfihrLmMBIwBp2vHqPJ9TpNE+fKFnqmI1BwDHged0cezzPEG
         wNdWRNr6Lz45V33NaZWsTqYIiL0afuSpLRdlRgo9szDyIEte41n2XgVbQXwoZjhEiQwA
         //EpOg9jzrD2r+dRHovI6H/I/xSj/3GEruXCtIxiBceaaXleRNCETiIy9C/j4+fjq235
         0AHhv7BLiuHiPB18sqgpErsRyVPPZ+zRakAJs27z17BzsfaMrJ2GrIPatVrRX2PGgXOd
         zwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683798601; x=1686390601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeuJxcLYHvnducoUZ2tfN6ldpdzeLGAaTYjya3TOvfo=;
        b=iuJYJL70ri6CT0n1AOOwOytZQ4hRYUEZmkPVLyGfmLqEex7Kwwqp9ZVC+92GnnDlpu
         HaAXWiAVF43JRIUG5wXR++tlHSe4uc2f6Ah3H7cO9nmanvYsehce+p79XSzzwFFVV8pt
         CFwm+iVyO9c70mrdbRucuDDR+qIMwsQHZ2uUJI1SA5FAYF/7+7cUVqPW8B9w8Mt16RmL
         al1u6PRn0t632pf0F3epTy+unZULv+Cp5C4z67lpwqFdP83P/3X9jJs3f8dQWObw9vU0
         r9PHCRlfkxkkjuYo5mdDFDzN6AWDFPw2vf/vwe2+rZoGsSCj0lC2Ul0EjMXKcA0474B/
         cJOg==
X-Gm-Message-State: AC+VfDxzwe2ctJmR2EzcnxWFYlsBiOEnCQgDnWfCBFb1qMAt9Yt9FaBP
	0dy8868/Yo8F3vBPfdU8XJXw4Q==
X-Google-Smtp-Source: ACHHUZ7Ea2uusu9jGNU3bGYWIa2nIX2TkmMJmfdXAah2FwXvUQkusDiywyoV8u4oAqkUEMD6Z3cmBw==
X-Received: by 2002:a17:907:9495:b0:96a:7a75:aa44 with SMTP id dm21-20020a170907949500b0096a7a75aa44mr364203ejc.4.1683798600971;
        Thu, 11 May 2023 02:50:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7e61:f14a:c3a4:809e? ([2a02:810d:15c0:828:7e61:f14a:c3a4:809e])
        by smtp.gmail.com with ESMTPSA id d19-20020a1709061f5300b009596e7e0dbasm3723120ejk.162.2023.05.11.02.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 02:50:00 -0700 (PDT)
Message-ID: <9dc6c0d8-fb49-6242-3863-8040e43e52e1@linaro.org>
Date: Thu, 11 May 2023 11:49:59 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 04/11] dt-bindings: interrupt-controller: Add RISC-V
 incoming MSI controller
Content-Language: en-US
To: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: Atish Patra <atishp@atishpatra.org>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, iommu@lists.linux.dev
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-5-apatel@ventanamicro.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508142842.854564-5-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/05/2023 16:28, Anup Patel wrote:
> We add DT bindings document for the RISC-V incoming MSI controller
> (IMSIC) defined by the RISC-V advanced interrupt architecture (AIA)
> specification.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../interrupt-controller/riscv,imsics.yaml    | 172 ++++++++++++++++++
>  1 file changed, 172 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

