Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B0AC43334
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 07:32:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0F8B846BE;
	Thu, 23 Jun 2022 07:32:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0F8B846BE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kIweK9BNv2kH; Thu, 23 Jun 2022 07:32:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D0F1B83ED6;
	Thu, 23 Jun 2022 07:32:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0F1B83ED6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACA5EC0039;
	Thu, 23 Jun 2022 07:32:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDE66C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 07:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 80A8383EE4
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 07:32:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 80A8383EE4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bU6kRoDdk-Gy for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 07:32:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C8B0783ED6
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C8B0783ED6
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 07:32:55 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 5057C447; Thu, 23 Jun 2022 09:32:52 +0200 (CEST)
Date: Thu, 23 Jun 2022 09:32:46 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 0/5] mtk_iommu: Specify phandles to infracfg and pericfg
Message-ID: <YrQXHmFXMVinjDw9@8bytes.org>
References: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
 <YrMc2EUBDIxnoWiB@8bytes.org>
 <4023cf19-601c-a2ba-85b0-450fb2df9401@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4023cf19-601c-a2ba-85b0-450fb2df9401@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
 miles.chen@mediatek.com, will@kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

Hi Matthias,

On Wed, Jun 22, 2022 at 04:12:47PM +0200, Matthias Brugger wrote:
> I wanted to check if you took also 3 and 4, as these should go through my
> tree. Unfortunately you haven't pushed your tree (yet). In case you took the
> whole series, can you please drop the dts patches. I'll apply them now on my
> v5.19-next/dts64 branch.

Yes, I applied the whole series, will drop patches 3 and 4 now.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
