Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533FD20E3
	for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 11:57:17 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id m7so10801556wru.8
        for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 03:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XmcsKjHOKYvrUOUyXFN2fyX5681YPhZugfu38EMuB08=;
        b=H2FPuCMk/NF+fT6BAcIMqqiJEBfns65LIpOPsw5l2IRunMicVdx3XMV5/qZ+gvz80o
         c2ym7rtY3PllyRlph6/nAcDVro7vxo5QN37nVetUJ8fnIhYKNcNYT36gON1zlwpkhfKm
         TqyJLZKKFYc9gomPikcHOSM/Fh+IIAhxBYRllJTJ5B9ZarX1C4CLORSnT8Q9qWSyRx+M
         SarrGtpFcNeORELwQaDTH87A9GuMt0YwGJKiBRYhjyZqi0/aPRb9w3/rPvoVSi0AM3td
         qpRwW2J7Xg+vy7C8cVsDH0kwHXosXoncBm0nLFU/oaAdQdioTu2E/pc95qo4vOQ+CITZ
         t+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XmcsKjHOKYvrUOUyXFN2fyX5681YPhZugfu38EMuB08=;
        b=jfOh3mwn4ScIg4m9xEntjWtnMMiQ2yU49ydN4eOkXRrfKFn5VPQ5A+bdP4iI5lGsdW
         3O8XgOzP701rw7D+eh+ry2b5oHYRd+hlyNL7hbt0LCw3h3pcf9UnMp85JSoGV+VwWjCJ
         agA3CkhgLko1FIFATR928QZQhJVvZTile290+1sbe4dKblqcwNRXMbWgfBZkkwkhjn+f
         OlfgdLdvvM4GDa4zlL73hvVPGcHqFdKZk1CyUli3GX8GYlkXOcn1twXalYHelkjEx2ox
         e+7O+zbpoKt8rZCL0OHvt3QUMHWdjgtcYP9FKKGNXonCOdofHsMZCQUBkX0g6P2mFH8F
         WlAA==
X-Gm-Message-State: AFqh2koT7v5gm/tub4hhdbo7qH7jMr1Umqm6ALPb+3RDvM4ZafAW4Fm2
	si0Du70XT3dh/lkQ6ZTq36KByg==
X-Google-Smtp-Source: AMrXdXvY1RmKLr2Gv1YwpANPagILR9MGIr+duSCkotDjClMAoKjRsaSW02r6KnsoxsJY+EfDL1FMlA==
X-Received: by 2002:adf:8bd6:0:b0:2bf:95d0:fa5d with SMTP id w22-20020adf8bd6000000b002bf95d0fa5dmr32299686wra.9.1675079835446;
        Mon, 30 Jan 2023 03:57:15 -0800 (PST)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id m2-20020a056000180200b002bfb5618ee7sm11648461wrh.91.2023.01.30.03.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 03:57:14 -0800 (PST)
Message-ID: <921aa473-b2a6-0905-2b52-1acf84ed399a@baylibre.com>
Date: Mon, 30 Jan 2023 12:57:13 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] dt-bindings: memory: mediatek: Add support of
 unmanaged iommu domain
To: Alexandre Bailon <abailon@baylibre.com>, yong.wu@mediatek.com,
 joro@8bytes.org, will@kernel.org
Cc: robin.murphy@arm.com, matthias.bgg@gmail.com,
 krzysztof.kozlowski@linaro.org, robh+dt@kernel.org, iommu@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230130102722.133271-1-abailon@baylibre.com>
 <20230130102722.133271-2-abailon@baylibre.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230130102722.133271-2-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/01/2023 11:27, Alexandre Bailon wrote:
> Currently, the only way to have an unmanaged domain for a device
> is having a dedicated iova region or bank.
> This adds a new bit to MTK_M4U_ID that allows defining devices
> that needs unmanaged iommu domain.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>   include/dt-bindings/memory/mtk-memory-port.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/dt-bindings/memory/mtk-memory-port.h b/include/dt-bindings/memory/mtk-memory-port.h
> index 2f68a0511a257..86896c776691a 100644
> --- a/include/dt-bindings/memory/mtk-memory-port.h
> +++ b/include/dt-bindings/memory/mtk-memory-port.h
> @@ -7,11 +7,14 @@
>   #define __DT_BINDINGS_MEMORY_MTK_MEMORY_PORT_H_
>   
>   #define MTK_LARB_NR_MAX			32
> +#define MTK_UNMANAGED_DEVICE            (1 << 31)
>   
>   #define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
>   #define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0x1f)
>   #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
> +#define MTK_M4U_UNMANAGED(id)		((id) & MTK_UNMANAGED_DEVICE)
>   
>   #define MTK_IFAIOMMU_PERI_ID(port)	MTK_M4U_ID(0, port)
> +#define MTK_M4U_UNMANAGED_ID(larb, port) (MTK_M4U_ID(larb, port) | MTK_UNMANAGED_DEVICE)
>   
>   #endif

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
