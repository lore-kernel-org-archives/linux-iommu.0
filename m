Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7295617C9
	for <iommu@lists.linux.dev>; Thu, 22 Jun 2023 01:51:07 +0000 (UTC)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-340b48c180bso30570875ab.0
        for <iommu@lists.linux.dev>; Wed, 21 Jun 2023 18:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687398666; x=1689990666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kq1ENgepBlp0mPUx1MFk9e+JFejzz2BH+QBOgxDDQfM=;
        b=Gscq8MCKonFxaJGZCWgGyYHPJeBeRTevWSSpHkl2Q/f4D3lZHOAql6PDnHX7QfHIH6
         k1pDTdHf1Aj8nKtF1WTcoL41ClKAVm4efFrbPNaqaCrc312r9+OkMd0J+f9QxnLPzk8J
         xKeaMAO+rBT7Vv8zVe+vWT2yJW/o179ujQpXks7KtUyUOb70OyRyZInGZLL8JYy7sRPj
         6S0jjwXwIYaDCCYoGNBCK941ey2UvMhhmX/Oi2yVcVQoHPlsn/Ye2PbPEe1OqDXKrk7M
         erQ4bsJXFEXQBzM1Kn2u6WXjPz6WD7L4LgbF90/aWQ88Y6vRvIl1PBOe+ReLqWzPA2UY
         cDVQ==
X-Gm-Message-State: AC+VfDw8RSENcfS4kzvFFjGH8D0vzJQAHQQOAE51RHlg6mJIw8QHeFb6
	NzQUda9Wgaxc5XdZehRaaQ==
X-Google-Smtp-Source: ACHHUZ7V0MbDp5bngrHcOwo2f+hetLBQ/eR1lDweuJphcSDdwc2Xc9JDpGKLsSIcOLt5l2829t2Svg==
X-Received: by 2002:a92:dc0a:0:b0:340:4e87:9947 with SMTP id t10-20020a92dc0a000000b003404e879947mr15448720iln.9.1687398666267;
        Wed, 21 Jun 2023 18:51:06 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j25-20020a02cb19000000b0042890b8c2bbsm101312jap.50.2023.06.21.18.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 18:51:05 -0700 (PDT)
Received: (nullmailer pid 41286 invoked by uid 1000);
	Thu, 22 Jun 2023 01:51:03 -0000
Date: Wed, 21 Jun 2023 19:51:03 -0600
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: will@kernel.org, robdclark@gmail.com, linux-arm-kernel@lists.infradead.org, conor+dt@kernel.org, robin.murphy@arm.com, agross@kernel.org, iommu@lists.linux.dev, dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org, andersson@kernel.org, joro@8bytes.org, devicetree@vger.kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, kernel@collabora.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] dt-bindings: iommu: qcom,iommu: Add QSMMUv2 and
 MSM8976 compatibles
Message-ID: <168739866325.41226.10001696049187967541.robh@kernel.org>
References: <20230620095127.96600-1-angelogioacchino.delregno@collabora.com>
 <20230620095127.96600-6-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620095127.96600-6-angelogioacchino.delregno@collabora.com>


On Tue, 20 Jun 2023 11:51:26 +0200, AngeloGioacchino Del Regno wrote:
> Add compatible string "qcom,msm-iommu-v2" for the inner node,
> along with "qcom,msm8976-iommu" as a first user of it and
> "qcom,msm-iommu-v2-ns" and "qcom,msm-iommu-v2-sec" for the context
> bank nodes to support Qualcomm's secure fw "SMMU v2" implementation.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/iommu/qcom,iommu.yaml   | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

