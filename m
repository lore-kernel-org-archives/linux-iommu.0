Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0C20E3
	for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 12:04:03 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso1864341wms.0
        for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 04:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4k/Nc+vbxM1mE6/adaioEXR7QTUOYEWnVbj4IhswtU=;
        b=kUVVk0Qo3KVIzL0lbkWQGeoXMGZLnOmnIBkOywzB3qf6dCsF7RxVxMu4san75cEg/W
         tUoXfvlDKLrDvVxvZDaXy7j+ZQXKjujcuBzMBbNnWILBMgjaQ2ZHvr1FJLCogUMo3MTQ
         9/JqstAUzQzcK98MeszrwfL6oJDjtjC83cp8QTUqkWlbtJ8v5ufBAWafuTvO6azfZYVC
         s58Rtf0pb4KbnPxnaKab5Vs3B5TjnCy4k8LwKEj/zysJaiLxSVdKJlsCCrxoiVjuRCil
         V6L7TH50uTrB9qyN0y1dSHGxTW0dkMHyEgfvH5jcFRCq2sMTmWmHJazuUk4oUSUrpJY2
         n6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4k/Nc+vbxM1mE6/adaioEXR7QTUOYEWnVbj4IhswtU=;
        b=l+e34T7A22/QXOk+U6RKSSmYQhYwzpxf0+ci5inx2M1JjFnoiyx412ALp2ODUCLx5U
         Ssl+/ZJYuzfpJPHRfHM48Av/1GFTrHREgFcBc+la8cLMwWI4/Z2UrVmTBzccistjnoER
         x+2hFpIPS1VMfEgMD7zHOfVU3n98erlh9qjHbV1+HUQe6mRmanp+MidQcWlyJMn30Ka8
         7+8bHdyLXijEM7iE3P1bFF5JRi3DyVNzBUZs0XNOYpypiX4N5Fq2QC7VA2fS86fCUACt
         jMwkCe5MzMPxNnlrV2y+kv4qWvKi0SFo1rTlFFdiStBAYNzT/Rj8foMwTxFhd8IEutXQ
         I2HQ==
X-Gm-Message-State: AFqh2kp5/UDtw6sxrSezp7WQvud+W95lrjlih7vcAVDLP6lto/DooSKx
	ZGTqrKIAjptP54OwP3ejSsWztQ==
X-Google-Smtp-Source: AMrXdXszvEIL/pKpL72DqLBqbSkAybsWNTlkDzADohEONJssb8T5yk+kO3rPc5tPFLreuiK5WEAq2A==
X-Received: by 2002:a05:600c:5390:b0:3d9:a145:4d1a with SMTP id hg16-20020a05600c539000b003d9a1454d1amr46068952wmb.34.1675080241399;
        Mon, 30 Jan 2023 04:04:01 -0800 (PST)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c180a00b003daf672a616sm12320077wmp.22.2023.01.30.04.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 04:04:00 -0800 (PST)
Message-ID: <30201eff-0339-da85-cf01-d0001af0d03f@baylibre.com>
Date: Mon, 30 Jan 2023 13:04:00 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] iommu: mediatek: Add support of unmanaged iommu
 domain
Content-Language: en-US
To: Alexandre Bailon <abailon@baylibre.com>, yong.wu@mediatek.com,
 joro@8bytes.org, will@kernel.org
Cc: robin.murphy@arm.com, matthias.bgg@gmail.com,
 krzysztof.kozlowski@linaro.org, robh+dt@kernel.org, iommu@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230130102722.133271-1-abailon@baylibre.com>
 <20230130102722.133271-3-abailon@baylibre.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230130102722.133271-3-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/01/2023 11:27, Alexandre Bailon wrote:
> Currently, the driver can allocate an unmanaged iommu domain.
> But, this only works for SoC having multiple bank or multiple iova region.
> This updates the driver to also support unmanaged iommu domain if
> MTK_UNMANAGED_DEVICE is set in the iommu id.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
