Return-Path: <SRS0=F9Hu=YP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96A1CA9EA0
	for <iommu@archiver.kernel.org>; Tue, 22 Oct 2019 17:56:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D732184C
	for <iommu@archiver.kernel.org>; Tue, 22 Oct 2019 17:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D732184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 505F1C87;
	Tue, 22 Oct 2019 17:56:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5E4C5C83
	for <iommu@lists.linux-foundation.org>;
	Tue, 22 Oct 2019 17:56:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (unknown [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 08D878AE
	for <iommu@lists.linux-foundation.org>;
	Tue, 22 Oct 2019 17:56:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7C71161B;
	Tue, 22 Oct 2019 10:56:32 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CE643F718;
	Tue, 22 Oct 2019 10:56:30 -0700 (PDT)
Subject: Re: [PATCH v3 3/7] dt-bindings: arm-smmu: Add binding for Tegra194
	SMMU
To: Krishna Reddy <vdumpa@nvidia.com>
References: <1571441492-21919-1-git-send-email-vdumpa@nvidia.com>
	<1571441492-21919-4-git-send-email-vdumpa@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <76513c1a-2fec-0b84-a9fb-f485f5fcbb78@arm.com>
Date: Tue, 22 Oct 2019 18:56:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1571441492-21919-4-git-send-email-vdumpa@nvidia.com>
Content-Language: en-GB
Cc: snikam@nvidia.com, thomasz@nvidia.com, jtukkinen@nvidia.com,
	mperttunen@nvidia.com, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org, praithatha@nvidia.com,
	talho@nvidia.com, iommu@lists.linux-foundation.org,
	nicolinc@nvidia.com, linux-tegra@vger.kernel.org,
	yhsu@nvidia.com, treding@nvidia.com, will@kernel.org,
	avanbrunt@nvidia.com, linux-arm-kernel@lists.infradead.org
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

On 19/10/2019 00:31, Krishna Reddy wrote:
> Add binding for NVIDIA's Tegra194 Soc SMMU that is based
> on ARM MMU-500.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>   Documentation/devicetree/bindings/iommu/arm,smmu.txt | 4 ++++

Rob (+cc) is in the process of converting the SMMU bindings to schema, 
so we might need a bit of coordination here...

Robin.

>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 3133f3b..1d72fac 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -31,6 +31,10 @@ conditions.
>                     as below, SoC-specific compatibles:
>                     "qcom,sdm845-smmu-500", "arm,mmu-500"
>   
> +                  NVIDIA SoCs that use more than one ARM MMU-500 together
> +                  needs following SoC-specific compatibles along with "arm,mmu-500":
> +                  "nvidia,tegra194-smmu"
> +
>   - reg           : Base address and size of the SMMU.
>   
>   - #global-interrupts : The number of global interrupts exposed by the
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
