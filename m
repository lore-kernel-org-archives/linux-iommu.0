Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA15746B
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 17:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b84478dd51so2716999b6e.1
        for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 09:55:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701107745; x=1701712545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L26i2R31YBB32RHwf8xEa95wnS6W9yDbV0iLws6hOL4=;
        b=nuCk7Qlq0dU2uF+IXvzb3FJcl6DrvQm5Lha/rknDBQDdwfPpNnC2ds0tNNt6nUMfux
         CP3ZlTm6SUgVw1X4xaDZR5fqvy/avVI6hlcQgRsjXNOC3iiG7hRps1Lb93RrFez1Or4V
         A6gzuKN56pMroPMYmHR4pUZIm0XYZcJszH2Xpq+7BZG/VI2urfh2tQjq5G77ZhL9CbEF
         d4JceBjnZReiz+qPmqtRPuGKfCa11InAF/5KTka8ztUHtsnICcZuHZLOPnOp7VRz7blA
         ldYlHcsOmzAMWh23l6LFfIa9z/ziYEJUpQHnQgIC8N/cfCji2E6f4IpzWp7FP3bDpaKy
         FBcQ==
X-Gm-Message-State: AOJu0YxENVLAEsPmsUIl/YQPtR+FCUux24e87jgSps54xecbYQXm5lNh
	TL20dmqHuw3BOrJMX+iBtA==
X-Google-Smtp-Source: AGHT+IHh5PLzpOWFfsx+tNMkyl2NpKyrg0r+4w5u4CMZNruFnsvNEiokfY7omCoyUGIRYIDk8GRdCQ==
X-Received: by 2002:a05:6808:10ce:b0:3ab:73a6:1469 with SMTP id s14-20020a05680810ce00b003ab73a61469mr18010811ois.14.1701107745157;
        Mon, 27 Nov 2023 09:55:45 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eh3-20020a056808274300b003b2e4b72a75sm1551295oib.52.2023.11.27.09.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 09:55:44 -0800 (PST)
Received: (nullmailer pid 1889222 invoked by uid 1000);
	Mon, 27 Nov 2023 17:55:43 -0000
Date: Mon, 27 Nov 2023 11:55:43 -0600
From: Rob Herring <robh@kernel.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org, vkoul@kernel.org, quic_gurus@quicinc.com, quic_rjendra@quicinc.com, abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, quic_tsoni@quicinc.com, neil.armstrong@linaro.org
Subject: Re: [PATCH V3 5/5] dt-bindings: interrupt-controller: qcom,pdc:
 document pdc on X1E80100
Message-ID: <20231127175543.GA1880474-robh@kernel.org>
References: <20231124100608.29964-1-quic_sibis@quicinc.com>
 <20231124100608.29964-6-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124100608.29964-6-quic_sibis@quicinc.com>

On Fri, Nov 24, 2023 at 03:36:08PM +0530, Sibi Sankar wrote:
> The X1E80100 SoC includes a PDC, document it.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v3
> * Rebased to the latest lnext. [Krzysztof]
> 
>  .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.
