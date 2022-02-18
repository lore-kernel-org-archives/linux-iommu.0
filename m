Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB342C4332F
	for <iommu@archiver.kernel.org>; Fri, 18 Feb 2022 12:52:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5AAF940AAE;
	Fri, 18 Feb 2022 12:52:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QIM730KqfmdD; Fri, 18 Feb 2022 12:52:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 11B59405CB;
	Fri, 18 Feb 2022 12:52:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD684C0021;
	Fri, 18 Feb 2022 12:52:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1ACB1C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:52:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EF9E341DBC
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:52:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mJKqyNwOOKFu for <iommu@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 12:52:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4485441DB9
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 12:52:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 539721F469B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1645188749;
 bh=tGSf/pth4T/62+a3wtoLcmdEh6+MDWX12/pzQsxIz+0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lBjwh7yJuYAoaAT+I6wUQ2YXt8niYeOxV/bGvQpiOq4KemuD4k6omY4dhN8nZd8SM
 yDk9tq3tXaUEaPUbNNhw1CHDWAVmWfpuMeEpL6JBprCAqF1bJvyudHHVjpHk89b+i4
 PJYhPTEVccobQNSR5iS5aZlN7zLFDYBwbSgolvbi0SAnKi33bUYyX7/CwL/e0+v/H2
 MFQOx36w1EG4gkYLgCueqgDhhDyjnEfwHqxa6dBQ7zVjcXvsIlC8BLz3QMGjjU/aOM
 OcwIAWkkIYi1CXSM4/+vqcKT4fX6lxT39bzrHaTLoUGza+jUwNC/ZYbNo45HItl2pN
 in1BAZHn/9hDQ==
Message-ID: <81cd0888-b202-feae-1c54-99ad2ef3f8cb@collabora.com>
Date: Fri, 18 Feb 2022 13:52:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 21/34] iommu/mediatek: Add PCIe support
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>
References: <20220217113453.13658-1-yong.wu@mediatek.com>
 <20220217113453.13658-22-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220217113453.13658-22-yong.wu@mediatek.com>
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 yf.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
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

Il 17/02/22 12:34, Yong Wu ha scritto:
> Currently the code for of_iommu_configure_dev_id is like this:
> 
> static int of_iommu_configure_dev_id(struct device_node *master_np,
>                                       struct device *dev,
>                                       const u32 *id)
> {
>         struct of_phandle_args iommu_spec = { .args_count = 1 };
> 
>         err = of_map_id(master_np, *id, "iommu-map",
>                         "iommu-map-mask", &iommu_spec.np,
>                         iommu_spec.args);
> ...
> }
> 
> It supports only one id output. BUT our PCIe HW has two ID(one is for
> writing, the other is for reading). I'm not sure if we should change
> of_map_id to support output MAX_PHANDLE_ARGS.
> 
> Here add the solution in ourselve drivers. If it's pcie case, enable one
> more bit.
> 
> Not all infra iommu support PCIe, thus add a PCIe support flag here.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
