Return-Path: <SRS0=jB4a=WS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B27C3A5A3
	for <iommu@archiver.kernel.org>; Thu, 22 Aug 2019 14:16:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C60233FD
	for <iommu@archiver.kernel.org>; Thu, 22 Aug 2019 14:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C60233FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6F90DB8A;
	Thu, 22 Aug 2019 14:16:31 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 103715AA
	for <iommu@lists.linux-foundation.org>;
	Thu, 22 Aug 2019 14:16:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id F2901822
	for <iommu@lists.linux-foundation.org>;
	Thu, 22 Aug 2019 14:16:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ED5F337;
	Thu, 22 Aug 2019 07:16:29 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 686233F706;
	Thu, 22 Aug 2019 07:16:27 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] dt-bindings: iommu/arm, smmu: add compatible string
	for Marvell
To: Gregory CLEMENT <gregory.clement@bootlin.com>,
	Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org
References: <20190711150242.25290-1-gregory.clement@bootlin.com>
	<20190711150242.25290-4-gregory.clement@bootlin.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5208b371-c81a-23a0-0870-2810fce3c7fa@arm.com>
Date: Thu, 22 Aug 2019 15:16:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190711150242.25290-4-gregory.clement@bootlin.com>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Antoine Tenart <antoine.tenart@bootlin.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Hanna Hawa <hannah@marvell.com>,
	Will Deacon <will.deacon@arm.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?Q?Miqu=c3=a8l_Raynal?= <miquel.raynal@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 11/07/2019 16:02, Gregory CLEMENT wrote:
> From: Hanna Hawa <hannah@marvell.com>
> 
> Add specific compatible string for Marvell usage due errata of
> accessing 64bits registers of ARM SMMU, in AP806.
> 
> AP806 SoC uses the generic ARM-MMU500, and there's no specific
> implementation of Marvell, this compatible is used for errata only.

Forgive me for repeating myself[1], but:

"Given that, I think something more specific like:

	"marvell,ap806-smmu", "arm,mmu-500";

would be most appropriate. Otherwise, if some future Marvell SoC were to
ever come out with a *different* MMU-500 integration problem, you'd
already have painted yourself into a corner."

Robin.

[1] 
https://lore.kernel.org/linux-arm-kernel/3ce1d67a-4e3c-e8d8-f7fc-79649f1def68@arm.com/

> Signed-off-by: Hanna Hawa <hannah@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>   Documentation/devicetree/bindings/iommu/arm,smmu.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 3133f3ba7567..7ed58d51846e 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -16,6 +16,7 @@ conditions.
>                           "arm,mmu-400"
>                           "arm,mmu-401"
>                           "arm,mmu-500"
> +                        "marvell,mmu-500"
>                           "cavium,smmu-v2"
>                           "qcom,smmu-v2"
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
