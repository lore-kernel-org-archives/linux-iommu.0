Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4748933C6
	for <iommu@lists.linux.dev>; Thu,  8 Sep 2022 14:17:54 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id bt10so27983136lfb.1
        for <iommu@lists.linux.dev>; Thu, 08 Sep 2022 07:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8/WneAIH4doGZWwalQYiIRIPWbn6dY3tzQchBDy6uq8=;
        b=FW3NoVsk/D0Nf3JbkkTKy/wW5LGJUF6TucHDO5cDKLvBTnSC1Yi10PBSCfzXp5kIvj
         VF/j/gCFY5s6lhqw4xknnQn92Z74hzDmuxlxblmy8IQyrUbpvjuM/VCZsHFnEogQWFPQ
         h5yRCq3kYolxf8LMP759YSutYbxuix/6DjulZfkDB93YBSMqI3vg3S1QlTJtBEDW5Yh8
         Xcb+KZRu70DtccNSnYn57w5eCiCEXMsgze0Nc7XcF6e/8W2d9Z0FiSKY6vhE6XUqTits
         d1jQVqWO5WIwxAecj9clvgBRR6YS8BsnmRFEmFrfs1ALQC9Wdi/fs8MSC0eC9NE0tPvA
         D7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8/WneAIH4doGZWwalQYiIRIPWbn6dY3tzQchBDy6uq8=;
        b=HM2krzDKYUDxrJ7uqGePzZC5r/oRhQ2VhVZFxBJmAV8vJuM53+GS7QclFq8pPTWmfi
         5ZYLSagZtrQcsEZnhLvzO/7hrsF/tEH2GAsqoT68rdi4Bx6pr/EFyupGGKX5k0FVITOI
         D9Ksv8vOpTw/tI3MfKQSBxe7pG2l7imMxcNKmrQOwbsj2DRxBdGvFncnP3P6Yh1k8tWZ
         CEpO9weAKu5wrYq/FWtSGn0lrBz5JwKxc5YrwZwBI0pUvN1G0AMBzryqevjwJnep7Lnu
         bAKyBF634xv1d2EkF2gJnKHrFqD7ISO3lPFkalScBNnwmYm8aWlesnCzcc2YUwZvMk2r
         gR/Q==
X-Gm-Message-State: ACgBeo2dg0RnwXBSYyra47S7wwtFDxCzJBYu0kJbvsVN5PWyaZfW4iAB
	ag3qpg1wmqj7eu5snaHQlxX+lP4PfyUYzw==
X-Google-Smtp-Source: AA6agR4mHUGqtjIx4fWu+AWyjmDlfv8bavpAUqYbTfxi3wJ8vaWjQj312qDOFEZGYwmEJx35Mt6jZQ==
X-Received: by 2002:a05:6512:2201:b0:492:f874:39fa with SMTP id h1-20020a056512220100b00492f87439famr2713913lfu.365.1662646670821;
        Thu, 08 Sep 2022 07:17:50 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k5-20020ac257c5000000b00492e98c27ebsm3049186lfo.91.2022.09.08.07.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 07:17:50 -0700 (PDT)
Message-ID: <83818ffc-bc38-0d3a-b225-d6671c6a1f3c@linaro.org>
Date: Thu, 8 Sep 2022 16:17:49 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] dt-bindings: iommu: mediatek: mt8195: Fix max
 interrupts
Content-Language: en-US
To: matthias.bgg@kernel.org, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Matthias Brugger <mbrugger@suse.com>
References: <20220908141529.1478-1-matthias.bgg@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220908141529.1478-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/09/2022 16:15, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> The mt8195-iommu-infra has five banks and one interrupt for each.
> Reflect that in the binding.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
