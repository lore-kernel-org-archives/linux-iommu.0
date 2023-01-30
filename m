Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD14746A
	for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 19:37:14 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id r9so10985412oig.12
        for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 11:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SY8t9rjZvKksjjObUfSr/JlHFAVlEcQD+wuQnMYT6og=;
        b=zs3NALKQRDwMDvYpDyu2CH9lkBq0zsk2Lb07QB9GS0FtTp/DF/27gK4yNA3mYsFDEM
         7pwe6WSJET3u0KHPAHk1fkaGXGU7qH6V1Fbd92n07FNcP0SF33Th3g7nN3Wk+NPkXbcC
         UhRIYNjCFP4CYHiIWVJQt3rlH7ZmwSY1BDeWTfeLiYMAPkesfG9uxGuaHPt/EeJOXEdN
         N0/5slRG7f1TQS7DIh/D1TfHd9ZOCn0EkMDjGo1YTFEs08otcZSx21J+KlgxsphLU79u
         JHyGdV3P9KYl7iuE/ifH+Vfg/rVYYc2+vJoH/M3r0Y43fa6OAHH5o0kwv1z894e6WK1M
         wYsw==
X-Gm-Message-State: AO0yUKX8e0nvYIxXqcdn9Rvj827JgYCPV5I+aVhesi9wddbQ+Q1GO++c
	oQaftM/k2qeeDIPLaQ/hnw==
X-Google-Smtp-Source: AK7set+LExoVClMVHa7Z2AUHvHd9asnN4InRgfJ7HTs+KkGhNtYD+t+SMJiiR4ca0LFwjquj/JKapg==
X-Received: by 2002:a54:4497:0:b0:378:330d:84ef with SMTP id v23-20020a544497000000b00378330d84efmr2906173oiv.0.1675107433889;
        Mon, 30 Jan 2023 11:37:13 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c82-20020acab355000000b003645b64d7b3sm5139410oif.4.2023.01.30.11.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:37:13 -0800 (PST)
Received: (nullmailer pid 3234988 invoked by uid 1000);
	Mon, 30 Jan 2023 19:37:13 -0000
Date: Mon, 30 Jan 2023 13:37:13 -0600
From: Rob Herring <robh@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, krzysztof.kozlowski+dt@linaro.org, iommu@lists.linux.dev, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iommu: renesas,ipmmu-vmsa: Update for
 R-Car Gen4
Message-ID: <20230130193713.GA3213851-robh@kernel.org>
References: <20230127140446.1728102-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127140446.1728102-1-yoshihiro.shimoda.uh@renesas.com>

On Fri, Jan 27, 2023 at 11:04:46PM +0900, Yoshihiro Shimoda wrote:
> Since R-Car Gen4 doens't have the main IPMMU IMSSTR register, update
> the renesas,ipmmu-main property which allows to only set the first
> argument for R-Car Gen4.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
> Changes from v1:
> https://lore.kernel.org/all/20230123012940.1250879-1-yoshihiro.shimoda.uh@renesas.com/
>  - Change number of argument for R-Car Gen4 instead of "module id".
>    On the discussion, using 'minItems' is a solution. But, it causes
>    "too short" errors on dtbs_check. So, using "oneOf" instead.

What was the schema you had?


I've commented on v1.

Rob
