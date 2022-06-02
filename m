Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC02C43334
	for <iommu@archiver.kernel.org>; Thu,  2 Jun 2022 14:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8FFA82662;
	Thu,  2 Jun 2022 14:17:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e9_urAj6HAT3; Thu,  2 Jun 2022 14:17:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7586982423;
	Thu,  2 Jun 2022 14:17:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C965C0039;
	Thu,  2 Jun 2022 14:17:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8E2EC002D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 14:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E8C0825FE
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 14:17:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M-RXCczx1v0C for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 14:17:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 04F1782423
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 14:17:35 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 61-20020a9d0bc3000000b0060b9bfcfe76so3476152oth.9
 for <iommu@lists.linux-foundation.org>; Thu, 02 Jun 2022 07:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TCCwJv6EhxWlaEc1Brd2505WQxC3GVxol8XUS0Q3iIQ=;
 b=xrOqntUPbTKnorCwHC+9fRhKBmE2AlsyCyE9yckDwrf+1hnnCLVWNL7BaDZpxu3f1a
 lWVHmpeVLa2OMt3Rd0GL6Z73JvrLg5ji11kmcki4pAkstARUfegue0LdFbF8LXzZwJ3f
 bLLxL6FN1TixHc5eg7vZ3d0b0WjwmtC+b2qYg/3PD2bt2vRchnSo5mG3THaqRTusi3IF
 EFmwHFk2sUke5HnSyWdJ63Cj9kDYEHbMIPW5vgV2NXdPW1jJ6MA5szNywuMUzqRdS78L
 765uEO0BhSJ/2YcpCGlz5tBuh7rOLwRv26qOaIIYcVKDuTP3nO+uZWlawydJFWX6dJDE
 mzCw==
X-Gm-Message-State: AOAM533GhYNr7D81blnFWC0xTPSI3QBZVAkSm8O+/6F9geVsK+eRhSwh
 X6qIDerhCnAGXC36La2ZNw==
X-Google-Smtp-Source: ABdhPJxYVbALGE594K0AOIrngTP0BTDjw28b1fwlQJNHJriJPoZ+rLecoT8+hiuf2AyA7nCY83K4nA==
X-Received: by 2002:a9d:5f16:0:b0:60b:4fbb:ac5a with SMTP id
 f22-20020a9d5f16000000b0060b4fbbac5amr2120193oti.189.1654179454963; 
 Thu, 02 Jun 2022 07:17:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 gu23-20020a056870ab1700b000f5d765bc02sm2098115oab.8.2022.06.02.07.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jun 2022 07:17:34 -0700 (PDT)
Received: (nullmailer pid 2234679 invoked by uid 1000);
 Thu, 02 Jun 2022 14:17:33 -0000
Date: Thu, 2 Jun 2022 09:17:33 -0500
From: Rob Herring <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 4/6] iommu/qcom: Add support for AArch64 IOMMU pagetables
Message-ID: <20220602141733.GA2227595-robh@kernel.org>
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-5-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220527212901.29268-5-konrad.dybcio@somainline.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, jamipkettunen@somainline.org,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
 martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 angelogioacchino.delregno@somainline.org, marijn.suijten@somainline.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>
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

On Fri, May 27, 2022 at 11:28:59PM +0200, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> Some IOMMUs associated with some TZ firmwares may support switching
> to the AArch64 pagetable format by sending a "set pagetable format"
> scm command indicating the IOMMU secure ID and the context number
> to switch.
> 
> Add a DT property "qcom,use-aarch64-pagetables" for this driver to
> send this command to the secure world and to switch the pagetable
> format to benefit of the ARM64 IOMMU pagetables, where possible.
> 
> Note that, even though the command should be valid to switch each
> context, the property is made global because:
> 1. It doesn't make too much sense to switch only one or two
>    context(s) to AA64 instead of just the entire thing
> 2. Some IOMMUs will go crazy and produce spectacular results when
>    trying to mix up the pagetables on a per-context basis.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../devicetree/bindings/iommu/qcom,iommu.txt  |  2 +

Bindings should be separate patch.

As you are making multiple changes, please convert this to DT schema 
first.

>  drivers/iommu/arm/arm-smmu/qcom_iommu.c       | 54 +++++++++++++++----
>  2 files changed, 47 insertions(+), 9 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
