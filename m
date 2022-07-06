Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DFFC433EF
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 11:45:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF0AF607B5;
	Wed,  6 Jul 2022 11:45:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF0AF607B5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KMVJJ+Ju
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tFmsL27inKrX; Wed,  6 Jul 2022 11:45:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D4EFE60C08;
	Wed,  6 Jul 2022 11:45:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D4EFE60C08
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0A78C0035;
	Wed,  6 Jul 2022 11:45:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1104C002D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 11:45:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6DACD40921
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 11:45:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6DACD40921
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=KMVJJ+Ju
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wvS5Y1zqhKpA for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 11:45:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9621B40289
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9621B40289
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 11:45:45 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3DEC861EE5;
 Wed,  6 Jul 2022 11:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51827C3411C;
 Wed,  6 Jul 2022 11:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657107943;
 bh=aBdtVMhRidxJCeoJx5DEXlpzuQlURSLwQpWLFBNxTts=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KMVJJ+JukHbibk6ztwsiqZjPY7NNGnu5ye/kkkr65U8rnR50ws1YnUZgNFk5+4LZc
 qrbPtRrZznfI6mp0+7/SBCTIuK0aG3D3ThJ7VLx2nNaiiNl9OpsfDK46GwzWVI7h2s
 5Ddwh1l7nAR/g30vK7bn6t3ky+UZJFIeAD7s8RkA/GT1UGOlPd+fv2yaHwJZYA+LeP
 oGdC0e0RO7pFN3Q/dmlVtqZVcVLeIuY7H1u1dOPKEtzBve5qL1g19QKv7seksr02zn
 lbmy3N4magjeo+Y2st5Z7HoMGPOHMilLgnLHgoDR52kgWGTLrcjbXaeFhwRj7HJn5l
 E+rKgbU5XqcVA==
Date: Wed, 6 Jul 2022 12:45:37 +0100
From: Will Deacon <will@kernel.org>
To: Luca Weiss <luca@z3ntu.xyz>
Subject: Re: [PATCH v2 1/4] dt-bindings: qcom-iommu: Add Qualcomm MSM8953
 compatible
Message-ID: <20220706114536.GA2403@willie-the-truck>
References: <20220612092218.424809-1-luca@z3ntu.xyz>
 <20220612092218.424809-2-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220612092218.424809-2-luca@z3ntu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 phone-devel@vger.kernel.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Sun, Jun 12, 2022 at 11:22:13AM +0200, Luca Weiss wrote:
> Document the compatible used for IOMMU on the msm8953 SoC.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes from v1:
> - new patch
> 
>  Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> index 059139abce35..e6cecfd360eb 100644
> --- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> @@ -10,6 +10,7 @@ to non-secure vs secure interrupt line.
>  - compatible       : Should be one of:
>  
>                          "qcom,msm8916-iommu"
> +                        "qcom,msm8953-iommu"

I'm assuming Andy or Bjorn will pick this up.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
