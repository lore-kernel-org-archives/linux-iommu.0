Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CE02F26
	for <iommu@lists.linux.dev>; Tue, 16 Aug 2022 09:22:04 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id c28so10003762lfh.3
        for <iommu@lists.linux.dev>; Tue, 16 Aug 2022 02:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Cc5a/Z1OZQ/Sp4oex9dmkDkQnrPr8Y8hlCBI2uCYHzA=;
        b=fiDRi2HZhnLH0aZUZxx5zMFYg+kRxqfZ8b/gbzXvdbEOMUSsLkKCvcNynL4hySDQxA
         m1GK8w5qxNUXZbhnbUOAb/RWoVguEnK7mq6wmLTVFwGDw++AVwE97trf0cZJGRUKHk4B
         ugdqIQgEN/iEh8C4L4b5JRrnQ/26tifMaIyc4O7HpNoSyICCI3YfXHi6BEJAVxkwfsoC
         4dXDHxU+eadTKBUHD1fgqE6Zq3Hmseu0E10W0cwd/dRDKo7b7wWBN7zhjkCK4R6N9lSf
         qRZ/bk+TKFGA2FewRcrhJcWB7mn/MYynRQCArUicMErP3l3KcqAYTACWZ1/r4jHH8EoE
         HRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Cc5a/Z1OZQ/Sp4oex9dmkDkQnrPr8Y8hlCBI2uCYHzA=;
        b=0gKWzHaMzQcl4g3VYlkC8IOlMzkQ8zKqaCrs80LHMrVqDEvjaS/QpjIup7Ur8i82qb
         bVZsVDMsNcDhMHS3Jjypl6/wytrCDbqo+Mp3bysOWuEi09Gv9noS1EI4ZFXH6CpeJxt9
         GAc53zpQE/Fp8tIugFGaA7EHL+dDUt/YQY9gT/i5cRmLnnZBeDZDT0lSizX3x77bLQOw
         C0Wtz0tr/UtI/7faTe9V9+Lpz6iJd3NO245OIsgKBfbuPadtSZQoX/nkv2UkK+J0c3cS
         vtxXsMQIsH4ToK6VAflcdaj2mJkz6RyzXYNyKNeL+NI/4B40uCG3ExolwaEoJehzpVVa
         y+Vw==
X-Gm-Message-State: ACgBeo1MG4eZ3TTaQV8Z+wLnGw1N9eCjiSKu2qqPwrcLZT0ymUKTAE98
	2MFDX6okKwNuohNtMPYRD+DpGA==
X-Google-Smtp-Source: AA6agR7LFK/9gYrW8u+lnQRIAyItIlW8HzneqHrf3znVQXnPj5MscIKAG/LghM5wSDnWni05dkHGvg==
X-Received: by 2002:a2e:80da:0:b0:25e:6d34:6169 with SMTP id r26-20020a2e80da000000b0025e6d346169mr6447417ljg.531.1660641722837;
        Tue, 16 Aug 2022 02:22:02 -0700 (PDT)
Received: from krzk-bin.. (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id s17-20020a056512215100b0048aea84fa80sm1335691lfr.87.2022.08.16.02.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 02:22:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: yong.wu@mediatek.com,
	robin.murphy@arm.com,
	lee@kernel.org,
	angelogioacchino.delregno@collabora.com,
	robh+dt@kernel.org,
	tinghan.shen@mediatek.com,
	mandyjh.liu@mediatek.com,
	will@kernel.org,
	joro@8bytes.org,
	krzysztof.kozlowski+dt@linaro.org,
	matthias.bgg@gmail.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v4 02/20] dt-bindings: memory: mediatek: Update condition for mt8195 smi node
Date: Tue, 16 Aug 2022 12:21:59 +0300
Message-Id: <166064169630.37858.3837655509098916044.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220729063208.16799-3-tinghan.shen@mediatek.com>
References: <20220729063208.16799-1-tinghan.shen@mediatek.com> <20220729063208.16799-3-tinghan.shen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 29 Jul 2022 14:31:50 +0800, Tinghan Shen wrote:
> The max clock items for the dts node with compatible
> 'mediatek,mt8195-smi-sub-common' should be 3.
> 
> However, the dtbs_check of such node will get following message,
> arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: smi@14010000: clock-names: ['apb', 'smi', 'gals0'] is too long
>          From schema: Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> 
> [...]

Applied, thanks!

[02/20] dt-bindings: memory: mediatek: Update condition for mt8195 smi node
        https://git.kernel.org/krzk/linux-mem-ctrl/c/9f8fb8032febf594914999c33493c682eaf138cb

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
