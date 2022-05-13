Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6ADC433EF
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 12:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D333E60E2E;
	Fri, 13 May 2022 12:57:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dQQ_payMvjM4; Fri, 13 May 2022 12:57:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B161960B57;
	Fri, 13 May 2022 12:57:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82F6CC0039;
	Fri, 13 May 2022 12:57:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D217C002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 12:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A38981D0C
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 12:57:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XwGPVnDFbaWH for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 12:57:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7F08E81C2F
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 12:57:23 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 439244D2; Fri, 13 May 2022 14:57:20 +0200 (CEST)
Date: Fri, 13 May 2022 14:57:19 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Miles Chen <miles.chen@mediatek.com>
Subject: Re: [PATCH v3] iommu/mediatek: Fix NULL pointer dereference when
 printing dev_name
Message-ID: <Yn5VrzVrzDLmpmdr@8bytes.org>
References: <20220505132731.21628-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220505132731.21628-1-miles.chen@mediatek.com>
Cc: Joerg Roedel <jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Will Deacon <will@kernel.org>,
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

On Thu, May 05, 2022 at 09:27:30PM +0800, Miles Chen wrote:
>  drivers/iommu/mtk_iommu.c    | 6 ++++++
>  drivers/iommu/mtk_iommu_v1.c | 7 +++++++
>  2 files changed, 13 insertions(+)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
