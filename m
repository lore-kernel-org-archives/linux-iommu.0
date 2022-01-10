Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ABFC433EF
	for <iommu@archiver.kernel.org>; Mon, 10 Jan 2022 11:44:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E84F60ACF;
	Mon, 10 Jan 2022 11:44:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id clwXWa01APbk; Mon, 10 Jan 2022 11:44:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 79F6560601;
	Mon, 10 Jan 2022 11:44:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53E20C002F;
	Mon, 10 Jan 2022 11:44:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62082C001E
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 11:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 424714092B
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 11:44:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mNB14vNvcU5U for <iommu@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 11:44:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 978A24092A
 for <iommu@lists.linux-foundation.org>; Mon, 10 Jan 2022 11:44:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 9DDD61F436F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1641815075;
 bh=bFgbf+SKJkohaV9z0g5mte5KBBwjvSAxwUBFmODWAhw=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=A36shmdnUkCoT+7gAJ2/CGJwPNCabWozqEZZ9fjIIuYwqcVPk/UMBvFRy2be4+kif
 S5I0K/Iwz86gHF8Jgf723v59h823VxwMt7ma+AaJY51gSC9x26au8pPG6FljzkjG3v
 dwuyNHdZJSBxuBW2lzEmTKIlGpsPwZs7qDd24ryylKt0dxtApNGE5kxriJngIilpOz
 aYQFNR6wXZ1X3F5+/9Q4xIj2RaSMJA7ZM9cT9L403tggtJS4BsdvreAtjhW6NDQFWq
 Znx+L7JLG9xCyjCLMxN5vByA+LB15SehaRO0wVwr2Smxl5oSP8kU5aDyL7tjaGkO4t
 TiiGHl+BI6daA==
Subject: Re: [PATCH v2 5/5] iommu/mediatek: Always tlb_flush_all when each PM
 resume
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
 iommu@lists.linux-foundation.org, Yong Wu <yong.wu@mediatek.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "moderated list:MEDIATEK IOMMU DRIVER" <linux-mediatek@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>, kernel@collabora.com,
 linux-media@vger.kernel.org, sebastian.reichel@collabora.com
References: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
 <20211208120744.2415-6-dafna.hirschfeld@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <02719a0f-9725-abc5-f5c4-acbb4bfac08d@collabora.com>
Date: Mon, 10 Jan 2022 12:44:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211208120744.2415-6-dafna.hirschfeld@collabora.com>
Content-Language: en-US
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

Il 08/12/21 13:07, Dafna Hirschfeld ha scritto:
> From: Yong Wu <yong.wu@mediatek.com>
> 
> Prepare for 2 HWs that sharing pgtable in different power-domains.
> 
> When there are 2 M4U HWs, it may has problem in the flush_range in which
> we get the pm_status via the m4u dev, BUT that function don't reflect the
> real power-domain status of the HW since there may be other HW also use
> that power-domain.
> 
> DAM allocation is often done while the allocating device is runtime
> suspended. In such a case the iommu will also be suspended and partial
> flushing of the tlb will not be executed.
> Therefore, we add a tlb_flush_all in the pm_runtime_resume to make
> sure the tlb is always clean.
> 
> In other case, the iommu's power should be active via device
> link with smi.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> [move the call to mtk_iommu_tlb_flush_all to the bottom of resume cb, improve doc/log]
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
