Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145F2C43334
	for <iommu@archiver.kernel.org>; Thu,  9 Jun 2022 14:23:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E5EE410BA;
	Thu,  9 Jun 2022 14:23:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Cg-3PbbhlBF; Thu,  9 Jun 2022 14:23:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1FF16409AA;
	Thu,  9 Jun 2022 14:23:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E81B2C007C;
	Thu,  9 Jun 2022 14:23:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24161C002D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 14:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 057F8610F2
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 14:23:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SjkBE_7TjnvT for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 14:23:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com
 [209.85.166.46])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 201D96077D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 14:23:45 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id d123so3290170iof.10
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jun 2022 07:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=2euiQq6QHzcln0aEqodhVH6QsST6rRQ5WhOXirbniGc=;
 b=bkQ51+YCfbVy3PjqTEtn9w1t0/pEIlpslWbBvAg62ZkXUDDED901Rb3hedUglYnj+O
 oVyIlB/jPqGu+uhPzHcDb5y7JQuk+h/QjsHP0SHPfEpBHttCo3kYo8L75aQjgc1xi2qq
 rp6P5YsgiUNNeJe+yt0wHoNaNikwWtEpDaX6Yiw5K+1++43hWeJguNES7RojFRO8aIMV
 Pf8duwjGFD1OWAugjT+5+HSi/WKBJ+Ka4KBpjqgQRFOdQvpbkcyGUyfv9hnIH1HGXAzv
 8HtycxXHmV5K59XkRy/MHr2teNm+i4AWbfDpqRLVdzBhBn5MzzJ761toccs/80vu2mO0
 5wxQ==
X-Gm-Message-State: AOAM530jppyKXGeM+r2igXQgrySn3vAJnhP/6u4Q0RGxtHhbL3sruJAt
 RCpHHpnYrs6v5G+zK55GPQ==
X-Google-Smtp-Source: ABdhPJx6We98HCBCkzcUJThBhFBjHm+zyDlUhxvomrFQnfPjQxOhbwjj02lQhbBm75JyPLLuRR9NHQ==
X-Received: by 2002:a05:6638:1182:b0:32e:5c70:c89c with SMTP id
 f2-20020a056638118200b0032e5c70c89cmr21146904jas.45.1654784624025; 
 Thu, 09 Jun 2022 07:23:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a056638021000b0033195fabca4sm5974569jaq.175.2022.06.09.07.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jun 2022 07:23:43 -0700 (PDT)
Received: (nullmailer pid 3738851 invoked by uid 1000);
 Thu, 09 Jun 2022 14:23:41 -0000
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220609100802.54513-2-angelogioacchino.delregno@collabora.com>
References: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com>
 <20220609100802.54513-2-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: iommu: mediatek: Add mediatek,
 infracfg phandle
Date: Thu, 09 Jun 2022 08:23:41 -0600
Message-Id: <1654784621.700928.3738850.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
 matthias.bgg@gmail.com, will@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, 09 Jun 2022 12:07:57 +0200, AngeloGioacchino Del Regno wrote:
> Add property "mediatek,infracfg" to let the mtk_iommu driver retrieve
> a phandle to the infracfg syscon instead of performing a per-soc
> compatible lookup in the entire devicetree and set it as a required
> property for MT2712 and MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml           | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iommu/mediatek,iommu.example.dtb: iommu@10205000: 'mediatek,infracfg' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
