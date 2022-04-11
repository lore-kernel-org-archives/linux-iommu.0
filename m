Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DA6C433F5
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 07:27:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F8CE60803;
	Mon, 11 Apr 2022 07:27:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R7osserrzN5G; Mon, 11 Apr 2022 07:27:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E39EE60AB5;
	Mon, 11 Apr 2022 07:27:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B40D2C0084;
	Mon, 11 Apr 2022 07:27:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C27F3C002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98DB160AB5
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:27:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4p6YFR7Wsl1c for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 07:27:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3B7A60803
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 07:27:52 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id 2so14439330pjw.2
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 00:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dPQb2XUhCwirAl6RZqcjJK++gcgif/8kvwh+CadUz3I=;
 b=vk8tSK2SuBtu1pR68M+NpcoBAAxowa3wJlU3AMOY72md1Hscl+QNeJNVcx10ejkuuV
 NKZxxgnF1yldlX2MkwYMlndhvYLdVpauINzM1OJe7Gm4Ja0ONJJ+moREvoB2tju7IFxG
 S2uciJD12fnvlOYAOjli/Oc0252AsxXr19m7FjVkfEfVt7d+4W8EhVfPiayUUIK55VO2
 1OYinPvHp8r7yCmeTFS6M61kgx9Sby11bwnsIxYHeJC71r9vlPUoCggPbNqj876PY8KC
 MZ55RMC5eFxv0ZOnQF7zxi+0Nfwm8wE7DR3hGUQhMy9kF/pIKmngY7NXMpyUPOcxegs5
 ID2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dPQb2XUhCwirAl6RZqcjJK++gcgif/8kvwh+CadUz3I=;
 b=a6sEjbPFktPUWh9JOkKbqTAc9HXQ4DCzO5vjbalqVY+JXnCYMb8I3hRP16HTLune7h
 Q8Ahxm90OlviYZCHtQqIWPGn70ahbiJSPmrnw7YDkPq5NJyxr7iYkrhs/8ZqMLkezu3k
 gUyQBEayZ9+2NCxCxPPMD0pqdvFj/sZ5/AV7wh6u1yqkMLmBBfQYEY26MZ3KFbkv5Qge
 ePiIB0oP5cuyitgcLD3Xobx6JyC6wIthPssmg/otN+Hy6b8VMACWp6RDMUJ/1EbUZcGD
 prZjUN0UgOzwJub3TfJHkAUZebJPlie2wYvs5KuXpwpmJvmvB2+CIG5qj1BU48zTwP31
 ln/A==
X-Gm-Message-State: AOAM532RZN6dUfA+qhcO9TqNegf26O2exaXCWdrxV/UzdCl70ZI0U7Tr
 oPE6Lx/0jLpbW6gFLb1f39Oq
X-Google-Smtp-Source: ABdhPJwfZOmz7bn126D73jA4tU3ELBxulz6f/9h9UuNvv751oKovp9R+buhc7tnYmqMckMjra91bgA==
X-Received: by 2002:a17:902:f68e:b0:154:6518:69ba with SMTP id
 l14-20020a170902f68e00b00154651869bamr31399663plg.60.1649662072219; 
 Mon, 11 Apr 2022 00:27:52 -0700 (PDT)
Received: from thinkpad ([117.217.182.106]) by smtp.gmail.com with ESMTPSA id
 m1-20020a17090ade0100b001cb3feaddfcsm8828185pjv.2.2022.04.11.00.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Apr 2022 00:27:51 -0700 (PDT)
Date: Mon, 11 Apr 2022 12:57:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: Re: [PATCH 0/7] SDX65 devicetree updates
Message-ID: <20220411072743.GA24975@thinkpad>
References: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org,
 linux-kernel@vger.kernel.org, will@kernel.org, linux-mmc@vger.kernel.org,
 agross@kernel.org, iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, krzk+dt@kernel.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Apr 11, 2022 at 12:25:36PM +0530, Rohit Agarwal wrote:
> Hello,
> 
> This series adds devicetree nodes for SDX65. It adds
> reserved memory nodes, SDHCI, smmu and tcsr mutex support.
> 

Please CC me to all SDX65 related patches as I'd like to review them.

Thanks,
Mani

> Thanks,
> Rohit.
> 
> Rohit Agarwal (7):
>   ARM: dts: qcom: sdx65: Add reserved memory nodes
>   dt-bindings: mmc: sdhci-msm: Document the SDX65 compatible
>   ARM: dts: qcom: sdx65: Add support for SDHCI controller
>   dt-bindings: arm-smmu: Add binding for SDX65 SMMU
>   ARM: dts: qcom: sdx65: Enable ARM SMMU
>   ARM: dts: qcom: sdx65: Add support for TCSR Mutex
>   ARM: dts: qcom: sdx65: Add Shared memory manager support
> 
>  .../devicetree/bindings/iommu/arm,smmu.yaml        |   1 +
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |   1 +
>  arch/arm/boot/dts/qcom-sdx65-mtp.dts               |  21 ++++
>  arch/arm/boot/dts/qcom-sdx65.dtsi                  | 110 +++++++++++++++++++++
>  4 files changed, 133 insertions(+)
> 
> -- 
> 2.7.4
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
