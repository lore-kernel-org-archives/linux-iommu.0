Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA4EC433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 08:21:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568AC20775
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 08:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ScsXCOaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568AC20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 208DB87775;
	Tue, 30 Jun 2020 08:21:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 77aRbGl-oINS; Tue, 30 Jun 2020 08:21:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1137B86354;
	Tue, 30 Jun 2020 08:21:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 069AEC088F;
	Tue, 30 Jun 2020 08:21:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4C29C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 08:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DCDCB8651C
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 08:21:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oRoZQgacoxuv for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 08:21:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6512B86354
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 08:21:21 +0000 (UTC)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efaf5f40000>; Tue, 30 Jun 2020 01:21:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 30 Jun 2020 01:21:21 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 30 Jun 2020 01:21:21 -0700
Received: from [10.26.75.203] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 08:21:16 +0000
Subject: Re: [PATCH v8 2/3] dt-bindings: arm-smmu: Add binding for Tegra194
 SMMU
To: Krishna Reddy <vdumpa@nvidia.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-3-vdumpa@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <06f4e802-11a2-3fb3-e334-9ba8533c9bcf@nvidia.com>
Date: Tue, 30 Jun 2020 09:21:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630001051.12350-3-vdumpa@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593505268; bh=DQaMRKB84VIKK0yEyIitEMeud5u93A+msqcYYHv6p/c=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=ScsXCOaLR7lc84hWPVEkKR7E/79SU8nX+bqRxSLfL/2V4nL+Zx/gBQ+Vwu19FaVh8
 y3vbFKJNcnF3Z1Z3KCH7OFroY7Et5HnG7MW+4fky7SqrHTGcv+fO17r6Yo3sxM5TwP
 n7Wf4FBuEZlJZA1ulq60Je/Fv/stOxXCoRHkCyE5giLyo/1Epac4aHJI1JPPdlWtDq
 VKlUSdI+yAkt5YCoBV4JVO5desmwc/UFk3A4JGtO0JvjmKX+jz37tJXtMhkzH93O3a
 Aah61KXLRl3NUSrR7YeGq18JT/vR8IewKg1lV2exSe/BVCVxTWm8ICICHMq6lTCHH8
 kQ/MrXaQMQGmQ==
Cc: snikam@nvidia.com, nicoleotsuka@gmail.com, mperttunen@nvidia.com,
 bhuntsman@nvidia.com, will@kernel.org, linux-kernel@vger.kernel.org,
 praithatha@nvidia.com, talho@nvidia.com, iommu@lists.linux-foundation.org,
 nicolinc@nvidia.com, linux-tegra@vger.kernel.org, yhsu@nvidia.com,
 treding@nvidia.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 bbiswas@nvidia.com
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


On 30/06/2020 01:10, Krishna Reddy wrote:
> Add binding for NVIDIA's Tegra194 SoC SMMU topology that is based
> on ARM MMU-500.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index d7ceb4c34423b..5b2586ac715ed 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -38,6 +38,11 @@ properties:
>                - qcom,sc7180-smmu-500
>                - qcom,sdm845-smmu-500
>            - const: arm,mmu-500
> +      - description: NVIDIA SoCs that use more than one "arm,mmu-500"
> +        items:
> +          - enum:
> +              - nvdia,tegra194-smmu

s/nvdia/nvidia

Jon

-- 
nvpublic
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
