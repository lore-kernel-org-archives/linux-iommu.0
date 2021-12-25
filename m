Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CC3C43217
	for <iommu@archiver.kernel.org>; Sat, 25 Dec 2021 14:49:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38153408C3;
	Sat, 25 Dec 2021 14:49:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rnviX5fJf2CK; Sat, 25 Dec 2021 14:49:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1EB7E40890;
	Sat, 25 Dec 2021 14:49:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00411C001E;
	Sat, 25 Dec 2021 14:49:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF543C0012
 for <iommu@lists.linux-foundation.org>; Sat, 25 Dec 2021 14:49:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD45883131
 for <iommu@lists.linux-foundation.org>; Sat, 25 Dec 2021 14:49:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hXnItDsEBtwI for <iommu@lists.linux-foundation.org>;
 Sat, 25 Dec 2021 14:48:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 936A682FA5
 for <iommu@lists.linux-foundation.org>; Sat, 25 Dec 2021 14:48:59 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id l11so10519616qke.11
 for <iommu@lists.linux-foundation.org>; Sat, 25 Dec 2021 06:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=WwY+LxRGYjmGy4RNrns234zbmxymS+OanKyxEXrqH0s=;
 b=0gbAErLWOZpVtEqP8oK3BIKiPAmiyJOs2eFui7FYFZfL4NaZZLpNirjAFZ1cKINf2I
 IFXg67jhBdlCkCftoao0mSdXwQxyHzu2loBg++pmzd8Rj553VU5DiDZFtlRD4lL9YtZ7
 xM79UTi7dZS9LNg1ZCnHYLgf3cBiGpnKiMmri8ZDI/X4u38EEMe7Z3k8hmhvjvQtwk0y
 pWcOZz24rB+bjmB8DmxK3ETYWj4ffj3aWgCenZrvSdoAhViWXeC5NQdHmP/YWl9p5TQe
 g3Dn5mnUw0s6LVCD9vwm5Cen4T8MoiFWNTi4tL4KzQVFR2SyZEyKUIgcfiQjkBFwr4eB
 lrdw==
X-Gm-Message-State: AOAM531bLXQAHw7pPYM4cIW81sGjZifMJUsa3a7JHYxPBPEMIOgWsdl2
 biY5leomH4ynkxdkAuWk6A==
X-Google-Smtp-Source: ABdhPJz2jdWWd9BmP30Ev0PdnQc4+holyBZlfI1eeuU3s9w4SZsAkposD7j9PHDAyPUIfts91rRKUw==
X-Received: by 2002:a05:620a:948:: with SMTP id
 w8mr7409911qkw.475.1640443738482; 
 Sat, 25 Dec 2021 06:48:58 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
 by smtp.gmail.com with ESMTPSA id q21sm3743646qtw.26.2021.12.25.06.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Dec 2021 06:48:57 -0800 (PST)
Received: (nullmailer pid 363343 invoked by uid 1000);
 Sat, 25 Dec 2021 14:48:42 -0000
From: Rob Herring <robh@kernel.org>
To: David Heidelberg <david@ixit.cz>
In-Reply-To: <20211224165014.56308-1-david@ixit.cz>
References: <20211224165014.56308-1-david@ixit.cz>
Subject: Re: [PATCH] dt-bindings: iommu: Convert msm,iommu-v0 to yaml
Date: Sat, 25 Dec 2021 10:48:42 -0400
Message-Id: <1640443722.906705.363342.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 Will Deacon <will@kernel.org>, ~okias/devicetree@lists.sr.ht
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

On Fri, 24 Dec 2021 17:50:14 +0100, David Heidelberg wrote:
> Convert Qualcomm IOMMU v0 implementation to yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/iommu/msm,iommu-v0.txt           | 64 -------------
>  .../bindings/iommu/qcom,iommu-v0.yaml         | 96 +++++++++++++++++++
>  2 files changed, 96 insertions(+), 64 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
>  create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/iommu/qcom,iommu-v0.yaml#
Documentation/devicetree/bindings/iommu/qcom,iommu-v0.example.dts:37.26-43.11: Warning (unit_address_vs_reg): /example-0/mdp@5100000: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/iommu/qcom,iommu-v0.example.dt.yaml:0:0: /example-0/mdp@5100000: failed to match any schema with compatible: ['qcom,mdp4']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1573077

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
