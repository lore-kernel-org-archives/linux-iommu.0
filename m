Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26C3EC3
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 08:35:44 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id a11so22243106lji.6
        for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 01:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680251743;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkRYc2zjcEMTlLfWoSafrc84uzK9JDYRl9kYpG33h9E=;
        b=VDtYvpS72Cb8trEdZVmOD4XrZGTI0kgWf9WAirmYAqK6YXUnVdbBn7gj/IO2OKTFMX
         awun/DZKunVF7yFL/NqDphNreCz9VxqbyYMCF7ql9WgGuC7y0RN1peGeCe0PPyLga5c7
         BZ6tUgHyw6X7uxVpo8xxqAcNIHvIbY41ndFtvBqZEa6Em626CPuObX1Cwu7mYtJUtcU+
         2J4Y5KwVcOR1ufbnbEJ9pJr37KFGNqI1BJ/BUmjyd3mzvaQxEPIDD9A4rlK/Uo22kdik
         KN4jn7SuA+Yz9+i0bytGyuoa9xckYg4hAOhUp1YsfMUEY9LwZ6tip9uSwTJouX3bHfRJ
         /Ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680251743;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkRYc2zjcEMTlLfWoSafrc84uzK9JDYRl9kYpG33h9E=;
        b=3GXGiGVk59tkbeNomAl8HGpf5N5+ifIPJ/7aesGWb3rW0UTp8P/NEQ7MCEQ6obbeMn
         y9TPhThep1IQHyt3tf8PuDiOizKfmUyScyBJ/IQNETjCPP7wgkgOS9xAW1JdRvf4il8n
         pmHs4Rh+wdNRqxRX0c/C+60Eat1ie6yX+XWEQz+7GFLw1ieInlNSfG4JJI2hWKUYzfqb
         pbBJqOR0G+wmDRF5UGqvNFkYLa0UM+ah8VXIPD3QHzf4+uOHkE30SQfbrrCzz4i/HB/R
         HkBAME7xYIEhyPqXpPNfom1VQaSL4ZzaTPjps3grkgaxDd+0kpiq5HbCaFbiCQDd2E09
         VsVA==
X-Gm-Message-State: AAQBX9cvH/rqrfvoqXccPNYovFg0jMXdEqY/23NMQLZPE9CmMtyqDRYp
	QVh2LSIQ248lQ0c5Cv0cmJYuFg==
X-Google-Smtp-Source: AKy350biiEiYoHvXX4oy8SYpu5pCoC47zLNvMj4u1cmjiV2eNr3bJd7RLJ2vrzmFKZJOHU5xx0I7dw==
X-Received: by 2002:a2e:aa8b:0:b0:2a1:ed00:4b9e with SMTP id bj11-20020a2eaa8b000000b002a1ed004b9emr2503411ljb.1.1680251742960;
        Fri, 31 Mar 2023 01:35:42 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f25-20020a2e6a19000000b002a03f9ffecesm262405ljc.89.2023.03.31.01.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 01:35:42 -0700 (PDT)
Message-ID: <7a81fe59-7076-9ebd-d574-e4f2d55c8ebe@linaro.org>
Date: Fri, 31 Mar 2023 10:35:41 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/3] dt-bindings: iommu: rockchip: Add
 rockchip,disable-device-link-resume
Content-Language: en-US
To: Jagan Teki <jagan@amarulasolutions.com>, Heiko Stuebner
 <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: iommu@lists.linux.dev, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-amarula <linux-amarula@amarulasolutions.com>
References: <20230330131746.1475514-1-jagan@amarulasolutions.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230330131746.1475514-1-jagan@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/03/2023 15:17, Jagan Teki wrote:
> Rockchip iommu is trying to enable the associated device at runtime
> resume however some devices might enable the iommu during their pm
> runtime resume operation which indeed leads iommu to use the wrong
> domain and this leads to device iommu page fault.

That's not a DT property. You now described system behavior and want to
encode policy in DT.



Best regards,
Krzysztof

