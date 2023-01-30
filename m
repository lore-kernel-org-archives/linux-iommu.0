Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B99160
	for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 22:50:34 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id n25-20020a9d7119000000b0068bd8c1e836so761717otj.3
        for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 14:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNYhsjqG2sWgs2gWLKftBwFAL6CYNRc5b+6o4KuBP3k=;
        b=h9syQGIJ1mJt7D/ZNOadz1n9J0OW2AnHvUaUIgnoIM8HlRleplKW2stuLvr0YOcEdB
         IW5y4Y03XtyzhSLnXC9xuTwKyYd1Yjj/FZOnrgAxxPJ8xb9W3hMmYCD8Rq53cNei26Um
         x77aDX6QYDAqtDButH18zGoE1vsJoQjnb1bZYUJwqN5qNFh0cnOY/LfIpfiuWGpOzj6i
         PbP2amwdEnDvEHd0a1aAQtYgRYXnYUiXuyMF5n0fnsmAg5NJo0yDkpQfqiWe0jXvtQ/5
         KpgXkq/258YGlKEksvZgtKFsMtqwuyOGIH1Qs6NpSnoMl1fB6Zgf3RTQmkK5aU+0jXc7
         +Asw==
X-Gm-Message-State: AFqh2kowcAN3OALKqlCSYrsntZGOzwJ/BFiwWl4+xkIZI5iQh1OlrJJA
	7zPZ7xaf+Ux/qkjdAfDmIQ==
X-Google-Smtp-Source: AMrXdXtNhfsgDIvcAEdKu4kp+ybHhn5D1DqJVvcgUAHM5OWYY9UuqtZ807Orrl5sp6zWPu6BiNyBAg==
X-Received: by 2002:a9d:7614:0:b0:66e:c863:ea94 with SMTP id k20-20020a9d7614000000b0066ec863ea94mr21399528otl.27.1675119033197;
        Mon, 30 Jan 2023 14:50:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b17-20020a056830311100b006863ccbf067sm5954261ots.74.2023.01.30.14.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:50:32 -0800 (PST)
Received: (nullmailer pid 3670295 invoked by uid 1000);
	Mon, 30 Jan 2023 22:50:32 -0000
Date: Mon, 30 Jan 2023 16:50:32 -0600
From: Rob Herring <robh@kernel.org>
To: Alexandre Bailon <abailon@baylibre.com>
Cc: yong.wu@mediatek.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, matthias.bgg@gmail.com, krzysztof.kozlowski@linaro.org, iommu@lists.linux.dev, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: iommu: memory: Use unmanaged iommu
 domain for the APU
Message-ID: <20230130225032.GA3667757-robh@kernel.org>
References: <20230130102722.133271-1-abailon@baylibre.com>
 <20230130102722.133271-4-abailon@baylibre.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130102722.133271-4-abailon@baylibre.com>

On Mon, Jan 30, 2023 at 11:27:22AM +0100, Alexandre Bailon wrote:
> This updates the iommu id to use unmanaged iommu domain for the APU.
> This is required by remoteproc to use the iommu.

Explain how a mixture of DTs with or without this value changed would 
work with kernels with or without support for unmanaged domains? Looks 
like a compatibility problem to me.

> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  include/dt-bindings/memory/mediatek,mt8365-larb-port.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/dt-bindings/memory/mediatek,mt8365-larb-port.h b/include/dt-bindings/memory/mediatek,mt8365-larb-port.h
> index 56d5a5dd519e7..86d82a8f6017d 100644
> --- a/include/dt-bindings/memory/mediatek,mt8365-larb-port.h
> +++ b/include/dt-bindings/memory/mediatek,mt8365-larb-port.h
> @@ -24,8 +24,8 @@
>  #define M4U_PORT_MDP_WROT0		MTK_M4U_ID(M4U_LARB0_ID, 7)
>  #define M4U_PORT_MDP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 8)
>  #define M4U_PORT_DISP_FAKE0		MTK_M4U_ID(M4U_LARB0_ID, 9)
> -#define M4U_PORT_APU_READ		MTK_M4U_ID(M4U_LARB0_ID, 10)
> -#define M4U_PORT_APU_WRITE		MTK_M4U_ID(M4U_LARB0_ID, 11)
> +#define M4U_PORT_APU_READ		MTK_M4U_UNMANAGED_ID(M4U_LARB0_ID, 10)
> +#define M4U_PORT_APU_WRITE		MTK_M4U_UNMANAGED_ID(M4U_LARB0_ID, 11)
>  
>  /* larb1 */
>  #define M4U_PORT_VENC_RCPU		MTK_M4U_ID(M4U_LARB1_ID, 0)
> -- 
> 2.38.2
> 
