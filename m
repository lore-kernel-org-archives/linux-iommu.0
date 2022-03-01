Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8B3C433F5
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 18:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F1EF740111;
	Tue,  1 Mar 2022 18:12:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s0v6GtuxShD6; Tue,  1 Mar 2022 18:12:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6C9304031D;
	Tue,  1 Mar 2022 18:12:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B2CEC0033;
	Tue,  1 Mar 2022 18:12:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54C41C001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 18:12:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5078E40887
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 18:12:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hMjCMOL8jqTX for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 18:12:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86F9940883
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 18:12:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3931D1042;
 Tue,  1 Mar 2022 10:12:15 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4019E3F73D;
 Tue,  1 Mar 2022 10:12:12 -0800 (PST)
Message-ID: <4a748c85-4fdb-0c10-19d8-0379b9e42ab5@arm.com>
Date: Tue, 1 Mar 2022 18:12:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 1/9] dt-bindings: host1x: Add iommu-map property
Content-Language: en-GB
To: cyndis@kapsi.fi, thierry.reding@gmail.com, jonathanh@nvidia.com,
 joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski@canonical.com
References: <20220301161455.4037062-1-cyndis@kapsi.fi>
 <20220301161455.4037062-2-cyndis@kapsi.fi>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220301161455.4037062-2-cyndis@kapsi.fi>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Mikko Perttunen <mperttunen@nvidia.com>,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-03-01 16:14, cyndis@kapsi.fi wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Add schema information for specifying context stream IDs. This uses
> the standard iommu-map property.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> v3:
> * New patch
> v4:
> * Remove memory-contexts subnode.
> ---
>   .../bindings/display/tegra/nvidia,tegra20-host1x.yaml        | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
> index 4fd513efb0f7..0adeb03b9e3a 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
> @@ -144,6 +144,11 @@ allOf:
>           reset-names:
>             maxItems: 1
>   
> +        iommu-map:
> +          description: Specification of stream IDs available for memory context device
> +            use. Should be a mapping of IDs 0..n to IOMMU entries corresponding to

Nit: maybe "context IDs 0..n" for maximum possible clarity?

Either way, though, I'm happy that if the simplest and most 
straightforward approach works, then it's the best choice.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Cheers,
Robin.

> +            usable stream IDs.
> +
>         required:
>           - reg-names
>   
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
