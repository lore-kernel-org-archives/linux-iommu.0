Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C46DC4332F
	for <iommu@archiver.kernel.org>; Tue, 19 Apr 2022 09:01:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F10B94186D;
	Tue, 19 Apr 2022 09:01:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xpNtVnhooF15; Tue, 19 Apr 2022 09:01:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3A1814161A;
	Tue, 19 Apr 2022 09:01:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14059C002F;
	Tue, 19 Apr 2022 09:01:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E4D0C002C
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 09:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B70B4107D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 09:01:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UfR3oELo660o for <iommu@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 09:00:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EDA1B41078
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 09:00:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 043701F41F4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1650358857;
 bh=vSObtpwN/NrN2SG7r1nxYbjAQ+m9PuPNXDpx4u79Ua0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=P8xTLXqJmMh8r2BGZRrueWKjl8Bhi+jGCK2T9VUIenRwsEZMEHpnTcv4ARxvQdWOh
 QTHfvRFUH0dfhrDbpNGOh3l2Ay7J06J5W3FRCFmE2aC190YQ9wo3gGcQ55GnK0NbiU
 gA6Q72AjZEmw2R8ucY0bGITpvb3WMjPZg296mbVw6JmW2K575izqrQu1R+6oE3QfQO
 BVHWyl17k6/vi7epxNeRDdrqxyv9C4Oq7jS31Th7gYsazjTU6xJ86tVvO/ZhmY7BVO
 VoaJH17OQCN290iXozEE1nlXLajxcAzARVgxCw2sAZiGtBxvW4zEPlCDbXxYrGqnQh
 LCBzCibyjhplg==
Message-ID: <d18394b7-7293-8e66-ed2e-649b771f0db6@collabora.com>
Date: Tue, 19 Apr 2022 11:00:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 00/34] MT8195 IOMMU SUPPORT
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>
References: <20220407075726.17771-1-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220407075726.17771-1-yong.wu@mediatek.com>
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

Il 07/04/22 09:56, Yong Wu ha scritto:
> This patchset adds MT8195 iommu support.
> 

Hello maintainers,
This is a friendly ping to avoid forgetting about this fully reviewed and
fully tested review.

Cheers,
Angelo


> MT8195 have 3 IOMMU HWs. 2 IOMMU HW is for multimedia, and 1 IOMMU HW is
> for infra-master, like PCIe/USB.
> 
> About the 2 MM IOMMU HW, something like this:
> 
>          IOMMU(VDO)          IOMMU(VPP)
>             |                   |
>        SMI_COMMON(VDO)      SMI_COMMON(VPP)
>        ---------------     ----------------
>        |      |   ...      |      |     ...
>      larb0 larb2  ...    larb1 larb3    ...
> 
> these two MM IOMMU HW share a pgtable.
> 
> About the INFRA IOMMU, it don't have larbs, the master connects the iommu
> directly. It use a independent pgtable.
> 
> Also, mt8195 IOMMU bank supports. Normally the IOMMU register size only
> is 0x1000. In this IOMMU HW, the register size is 5 * 0x1000. each 0x1000
> is a bank. the banks' register look like this:
>       ----------------------------------------
>       |bank0  | bank1 | bank2 | bank3 | bank4|
>       ----------------------------------------
>       |global |
>       |control|         null
>       |regs   |
>       -----------------------------------------
>       |bank   |bank   |bank   |bank   |bank   |
>       |regs   |regs   |regs   |regs   |regs   |
>       |       |       |       |       |       |
>       -----------------------------------------
> All the banks share some global control registers, and each bank have its
> special bank registers, like pgtable base register, tlb operation registers,
> the fault status registers.
>   
> In mt8195, we enable this bank feature for infra iommu, We put PCIe in bank0
> and USB in bank4. they have independent pgtable.
> 
> Change note:
> v6: Rebase on v5.18-rc1.
> 
> v5: https://lore.kernel.org/linux-iommu/20220217113453.13658-1-yong.wu@mediatek.com
>     1) Base on next-20220216
>     2) Remove a patch for kmalloc for protect buffer. keep the kzalloc for it.
>     3) minor fix from AngeloGioacchino, like rename the error label name
>     (data_unlock to err_unlock).
>     Note, keep the TODO for component compare_of[26/34].
> 
> v4: https://lore.kernel.org/linux-iommu/20220125085634.17972-1-yong.wu@mediatek.com/
>     1) Base on v5.16-rc1
>     2) Base on tlb logic 2 patchset, some patches in v3 has already gone
>     through that patchset.
>     3) Due to the unreadable union for v1/v2(comment in 26/33 of v3), I
>     separate mtk_iommu_data for v1 and v2 totally, then remove mtk_iommu.h.
>     please see patch[26/35][27/35].
>     4) add two mutex for the internal data. patch[6/35][7/35].
>     5) add a new flag PM_CLK_AO.
> 
> v3: https://lore.kernel.org/linux-mediatek/20210923115840.17813-1-yong.wu@mediatek.com/
>      1) base on v5.15-rc1
>      2) Adjust devlink with smi-common, not use the property(sub-sommon).
>      3) Adjust tlb_flush_all flow,
>         a) Fix tlb_flush_all only is supported in bank0.
>         b) add tlb-flush-all in the resume callback.
>         c) remove the pm status checking in tlb-flush-all.
>         The reason are showed in the commit message.
>      4) Allow IOMMU_DOMAIN_UNMANAGED since PCIe VFIO use that.
>      5) Fix a clk warning and a null abort when unbind the iommu driver.
> 
> v2: https://lore.kernel.org/linux-mediatek/20210813065324.29220-1-yong.wu@mediatek.com/
>      1) Base on v5.14-rc1.
>      2) Fix build fail for arm32.
>      3) Fix dt-binding issue from Rob.
>      4) Fix the bank issue when tlb flush. v1 always use bank->base.
>      5) adjust devlink with smi-common since the node may be smi-sub-common.
>      6) other changes: like reword some commit message(removing many
>         "This patch..."); seperate serveral patches.
> 
> v1: https://lore.kernel.org/linux-mediatek/20210630023504.18177-1-yong.wu@mediatek.com/
>      Base on v5.13-rc1
> 
> Yong Wu (34):
>    dt-bindings: mediatek: mt8195: Add binding for MM IOMMU
>    dt-bindings: mediatek: mt8195: Add binding for infra IOMMU
>    iommu/mediatek: Fix 2 HW sharing pgtable issue
>    iommu/mediatek: Add list_del in mtk_iommu_remove
>    iommu/mediatek: Remove clk_disable in mtk_iommu_remove
>    iommu/mediatek: Add mutex for m4u_group and m4u_dom in data
>    iommu/mediatek: Add mutex for data in the mtk_iommu_domain
>    iommu/mediatek: Adapt sharing and non-sharing pgtable case
>    iommu/mediatek: Add 12G~16G support for multi domains
>    iommu/mediatek: Add a flag DCM_DISABLE
>    iommu/mediatek: Add a flag NON_STD_AXI
>    iommu/mediatek: Remove the granule in the tlb flush
>    iommu/mediatek: Always enable output PA over 32bits in isr
>    iommu/mediatek: Add SUB_COMMON_3BITS flag
>    iommu/mediatek: Add IOMMU_TYPE flag
>    iommu/mediatek: Contain MM IOMMU flow with the MM TYPE
>    iommu/mediatek: Adjust device link when it is sub-common
>    iommu/mediatek: Allow IOMMU_DOMAIN_UNMANAGED for PCIe VFIO
>    iommu/mediatek: Add a PM_CLK_AO flag for infra iommu
>    iommu/mediatek: Add infra iommu support
>    iommu/mediatek: Add PCIe support
>    iommu/mediatek: Add mt8195 support
>    iommu/mediatek: Only adjust code about register base
>    iommu/mediatek: Just move code position in hw_init
>    iommu/mediatek: Separate mtk_iommu_data for v1 and v2
>    iommu/mediatek: Remove mtk_iommu.h
>    iommu/mediatek-v1: Just rename mtk_iommu to mtk_iommu_v1
>    iommu/mediatek: Add mtk_iommu_bank_data structure
>    iommu/mediatek: Initialise bank HW for each a bank
>    iommu/mediatek: Change the domid to iova_region_id
>    iommu/mediatek: Get the proper bankid for multi banks
>    iommu/mediatek: Initialise/Remove for multi bank dev
>    iommu/mediatek: Backup/restore regsiters for multi banks
>    iommu/mediatek: mt8195: Enable multi banks for infra iommu
> 
>   .../bindings/iommu/mediatek,iommu.yaml        |  20 +-
>   drivers/iommu/mtk_iommu.c                     | 955 +++++++++++++-----
>   drivers/iommu/mtk_iommu.h                     | 101 --
>   drivers/iommu/mtk_iommu_v1.c                  | 235 +++--
>   .../dt-bindings/memory/mt8195-memory-port.h   | 408 ++++++++
>   include/dt-bindings/memory/mtk-memory-port.h  |   2 +
>   6 files changed, 1244 insertions(+), 477 deletions(-)
>   delete mode 100644 drivers/iommu/mtk_iommu.h
>   create mode 100644 include/dt-bindings/memory/mt8195-memory-port.h
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
