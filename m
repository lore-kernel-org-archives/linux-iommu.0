Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7FB20E3
	for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 12:04:33 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id h12so10811286wrv.10
        for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 04:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oAiFVbIhL8pBpzXj74ThQPQ3uZWC/mGuF3NSlIBvnlc=;
        b=h/AWH6uICOrL3YXbnDeUDxX7BGfTyv9M2TjUZ2KopvdqMLKpSbM2AR1DEyTUoR7gX/
         LCmfKMQq902Byo67s8SbF54HfmBdXqvOavNgYdSMVM0QKVgQ02OrGSDbc7Wy9v0LHNeP
         gbgIvTmOyKvcgyLFlQPdomsHC/vbzgxhMKsl0fPRFNJ5wplsxkavrcm0MoRDcyDigzmj
         DJC4El+dxYR6bRO05SezJOr2v53RAZ1Ur0XPNGBa7aphMP5DCIWLTmLfuFM8I3n7noAs
         65n2G+sr6sCQusEtHKCIDHaEDmvx18oCntir+P/ZpINxDRkIBTWhPlEx8dzM05CbfSpu
         HvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAiFVbIhL8pBpzXj74ThQPQ3uZWC/mGuF3NSlIBvnlc=;
        b=MLKBZ21/9RjWj5Bj67medhTdx98q0iw8WyMklJU+VGXVW6ig5aNF3zzUsH0whqrRc/
         ASSjlWe70e8M3JgTrlkKC/Rs8ERL3nggcQZXPaFmDGCR6cnc8Wauce0uC2h67cZMLROF
         u3Mp6prPs1zjB2ZpOYnXuYU0sfXpyiVjjWGSskRJWqPJVjOto+g4FPV11hu/ZP7Vhf1v
         D7z3Zmq94j/UWmAULdG75PV4qBL7qFrcdWbKMFgSU04uyXD8zg3v7w6jawXVzxW3eb3G
         goMwYGMAMYEcEggqbTBJfb5B4JrEgMSSrB8PXhJVlJnn2n5iFzeVuiC1qnd8jKuQlKXM
         J2NQ==
X-Gm-Message-State: AO0yUKX6G53lVJlk+QYv13g8pqgpX6ruyCi1legKjMDWtv4Znf8yJtvE
	NfYvRdepQTPgq3MfmeL61Htsmw==
X-Google-Smtp-Source: AK7set+HjgFg9eVMoCGF9nRtNIbwCr+z58262n9G4v5RdsFaXE6jeiu/4i9y1ZVHnuh2i6pbgt5Nug==
X-Received: by 2002:a5d:59a4:0:b0:2bf:ef3b:d072 with SMTP id p4-20020a5d59a4000000b002bfef3bd072mr2968016wrr.0.1675080271619;
        Mon, 30 Jan 2023 04:04:31 -0800 (PST)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id h12-20020a056000000c00b002bdd96d88b4sm11869268wrx.75.2023.01.30.04.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 04:04:31 -0800 (PST)
Message-ID: <ca32d9a1-8a1e-c65a-7e52-c065b31c0e4c@baylibre.com>
Date: Mon, 30 Jan 2023 13:04:30 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] dt-bindings: iommu: memory: Use unmanaged iommu
 domain for the APU
Content-Language: en-US
To: Alexandre Bailon <abailon@baylibre.com>, yong.wu@mediatek.com,
 joro@8bytes.org, will@kernel.org
Cc: robin.murphy@arm.com, matthias.bgg@gmail.com,
 krzysztof.kozlowski@linaro.org, robh+dt@kernel.org, iommu@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230130102722.133271-1-abailon@baylibre.com>
 <20230130102722.133271-4-abailon@baylibre.com>
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230130102722.133271-4-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/01/2023 11:27, Alexandre Bailon wrote:
> This updates the iommu id to use unmanaged iommu domain for the APU.
> This is required by remoteproc to use the iommu.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

