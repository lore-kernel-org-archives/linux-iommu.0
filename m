Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED20C43334
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 12:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB95F60ADD;
	Thu, 16 Jun 2022 12:03:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eByxusXy1Wx4; Thu, 16 Jun 2022 12:03:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B700460ABA;
	Thu, 16 Jun 2022 12:03:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 792DEC0039;
	Thu, 16 Jun 2022 12:03:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C63A0C002D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 12:03:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B2FC360ADD
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 12:03:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V-cPwDEwigmJ for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 12:03:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E51D660ABA
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 12:03:38 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 279BB660163F;
 Thu, 16 Jun 2022 13:03:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1655381017;
 bh=W6TnXzN7tlg8HsJN6dq/ufsPn63iDCWZZX6PZhUj48w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=g6MVcgFlrnrif1J+IZnTY4MAvlm4tJWVrplsCk/XVWz0npsRRUxGRI449dqyXP1/Y
 GuQRxmQ/YkX+Ze8/RocIoEMNOnlGwpSPRVgXdOcf7lx2vKIDm1pngOb7yylYKNEu+P
 zA/5+v9NgCzNH0Xomjb3zqp5ufv213dVxr5htDNqJ8KCtyeAVz7O0/0ssa+7P+7J5L
 hwFXD5SNaPzyD0TksPWENoeuEwaO1kpYq2ZE1EGSCZMyoxQ4AJg68f7sv5hvaQBqPw
 N2H2NpmZb4OJSnDHALEaurOLRww3y5LBbb2fM7XdrES5qYAtPeWjH30WNgrVR420HQ
 vNoVgEsbxacmg==
Message-ID: <37676cad-bbe8-0e4b-6632-ab57d29bdb20@collabora.com>
Date: Thu, 16 Jun 2022 14:03:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 5/5] iommu/mediatek: Remove a unused "mapping" which is
 only for v1
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>
References: <20220616054203.11365-1-yong.wu@mediatek.com>
 <20220616054203.11365-6-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220616054203.11365-6-yong.wu@mediatek.com>
Cc: anan.sun@mediatek.com, chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 yf.wang@mediatek.com, libo.kang@mediatek.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Dan Carpenter <dan.carpenter@oracle.com>, Guenter Roeck <groeck@chromium.org>,
 mingyuan.ma@mediatek.com, linux-arm-kernel@lists.infradead.org
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

Il 16/06/22 07:42, Yong Wu ha scritto:
> Just remove a unused variable that only is for mtk_iommu_v1.
> 
> Fixes: 9485a04a5bb9 ("iommu/mediatek: Separate mtk_iommu_data for v1 and v2")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

The title isn't immediately clear, looks like you're removing some mapping, not
a struct member...

Perhaps... iommu/mediatek: Remove unused "mapping" member from mtk_iommu_data ?

After clarifying the commit title:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
