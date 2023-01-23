Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E102AA4F
	for <iommu@lists.linux.dev>; Mon, 23 Jan 2023 09:06:49 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id d2so10078603wrp.8
        for <iommu@lists.linux.dev>; Mon, 23 Jan 2023 01:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kx6lFX3j04Q0LzfM4ypmKaDgLGfR8Nzb5Ptw2ZM7Ai0=;
        b=Q9rwXWmKNkh3imiVeAMPf9xbwXOYzS7OVZYehFEOJ/w+VMwzKWrPZYoPrhwR2pXsyI
         jFLgfo1o1ekaQz6y7hGp52dlEWnTRW8R2jMCu42nzRvTPdLJXcGxxQLjEj4Pg3yic8o2
         /u75y734LDoHV1i9uEGxH2Fq30hy/0A84M52eyEIKRjEATC5IAFzU1wIq3Gq2xbyU0zH
         nCtjnU00n5sSbj0KccAK9oySkL0t8prqLXbZTyW7ClXDFwLsLjqkFbT5FlvlyzsxYm5P
         xLz3TdTKqpb71HcvBzwT3WrWD1Ifqo1nTw4HFu7hpcsz7091YugF8xLsa6I0ESn4+Mer
         RDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kx6lFX3j04Q0LzfM4ypmKaDgLGfR8Nzb5Ptw2ZM7Ai0=;
        b=KvrPQuv/RKfywRKRysCefH4MiGEF5QigDNTeXZmT3aDoaS/k3Qoaf2LvxwvfC7E/7q
         I8OndflX0oElL03ZysIjPh4s2FO0ZC0/jycKRCkcCeeKQ6E75meDdUIV0frI4dQ1x9s3
         TUCaiV+WSPHUxpCosmPKYkKBAJ4li/6WiyRpkUb4zjJoTe4c28dC3ok405fAFt51LlCB
         DyBvGYNEZ/2uO8YNVOTCh+Dp6UeohvfQ/ycMUiGSTu2qXcB/Un6KDZhEr9/1MGpluKLP
         knbHyN9qCF0bTNTVAV7L2r1cVoh2BmeSLl0h08agV1ofM01K7toJ8c3I+4FhmKdR3ID9
         e3FQ==
X-Gm-Message-State: AFqh2krTjVr5QjgL2sRKTB0U74Df+BDC6NLaq7/ShYagHH+ANu0NFDuh
	8x96RzipBUJyx+/ZAhhJ87JaUA==
X-Google-Smtp-Source: AMrXdXsFjvmYYKBk3lKGUaDn6ljTehr4S0fyGsCTso32csm32DOPPv4UKuqI0VryfPqFx1JBDLOXVw==
X-Received: by 2002:a5d:4842:0:b0:2bd:eccd:7ea4 with SMTP id n2-20020a5d4842000000b002bdeccd7ea4mr21041451wrs.47.1674464808207;
        Mon, 23 Jan 2023 01:06:48 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d554c000000b00275970a85f4sm4120891wrw.74.2023.01.23.01.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:06:47 -0800 (PST)
Message-ID: <be938064-60dc-e54c-473d-f7acd799c959@linaro.org>
Date: Mon, 23 Jan 2023 10:06:45 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] dt-bindings: iommu: renesas,ipmmu-vmsa: Update
 descriptions for R-Car Gen4
Content-Language: en-US
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org
Cc: iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20230123012940.1250879-1-yoshihiro.shimoda.uh@renesas.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123012940.1250879-1-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2023 02:29, Yoshihiro Shimoda wrote:
> Since R-Car Gen4 doens't have the main IPMMU IMSSTR register, but
> each cache IPMMU has own module id. So, update descriptions of
> renesas,ipmmu-main property for R-Car Gen4.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  The old R-Car S4-8 datasheet had described IPMMU IMSSTR register, but
>  the latest datasheet undocumented the register. So, update the propeties
>  description. Note that the second argument is not used on the driver.
>  So no behavior change.
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

