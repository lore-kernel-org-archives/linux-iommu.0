Return-Path: <SRS0=TfYV=XM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83517C4CEC9
	for <iommu@archiver.kernel.org>; Tue, 17 Sep 2019 18:56:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3E62189D
	for <iommu@archiver.kernel.org>; Tue, 17 Sep 2019 18:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2afMEBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3E62189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 17150C6D;
	Tue, 17 Sep 2019 18:56:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 14DC8A7F
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 18:56:26 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C841D76D
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 18:56:25 +0000 (UTC)
Received: from kernel.org (unknown [104.132.0.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 8A4A8214AF;
	Tue, 17 Sep 2019 18:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568746585;
	bh=mbODalGRNQoWNnowm2tS1pcY2EbwBFAWll84phPGxbA=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
	b=X2afMEBspYqrVXT0KNPzGo8hs6SqE7bnObaYtDnvMs7z38QOJlK4gbKabuaAqCbOP
	ECW6wcm77plYCjJXgCBwwyyI+0OSQOARJZVVveEUXUP3MPVeTbryP4q99Pt9Jmw6Ld
	HKuDFOJ+H+7HjkuwaGkz3B4DI6P4W2cia6BT6KaQ=
MIME-Version: 1.0
In-Reply-To: <1566327992-362-3-git-send-email-jcrouse@codeaurora.org>
References: <1566327992-362-1-git-send-email-jcrouse@codeaurora.org>
	<1566327992-362-3-git-send-email-jcrouse@codeaurora.org>
To: Jordan Crouse <jcrouse@codeaurora.org>, freedreno@lists.freedesktop.org
From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/7] dt-bindings: arm-smmu: Add Adreno GPU variant
User-Agent: alot/0.8.1
Date: Tue, 17 Sep 2019 11:56:24 -0700
Message-Id: <20190917185625.8A4A8214AF@mail.kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Quoting Jordan Crouse (2019-08-20 12:06:27)
> Add a compatible string to identify SMMUs that are attached
> to Adreno GPU devices that wish to support split pagetables.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 3133f3b..3b07896 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -18,6 +18,7 @@ conditions.
>                          "arm,mmu-500"
>                          "cavium,smmu-v2"
>                          "qcom,smmu-v2"
> +                       "qcom,adreno-smmu-v2"

Is the tabbing weird here or just my MUA is failing?

>  
>                    depending on the particular implementation and/or the
>                    version of the architecture implemented.
> @@ -31,6 +32,12 @@ conditions.
>                    as below, SoC-specific compatibles:
>                    "qcom,sdm845-smmu-500", "arm,mmu-500"
>  
> +                 "qcom,adreno-smmu-v2" is a special implementation for

Heh, special.

> +                 SMMU devices attached to the Adreno GPU on Qcom devices.
> +                 If selected, this will enable split pagetable (TTBR1)

Is this selected? Sounds like Kconfig here.

> +                 support. Only use this if the GPU target is capable of
> +                 supporting 64 bit addresses.
> +
>  - reg           : Base address and size of the SMMU.
>  
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
