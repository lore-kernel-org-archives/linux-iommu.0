Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE13C433F5
	for <iommu@archiver.kernel.org>; Mon, 28 Feb 2022 13:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D2A6440592;
	Mon, 28 Feb 2022 13:50:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gd6xqt6_h1Th; Mon, 28 Feb 2022 13:50:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2A5ED40112;
	Mon, 28 Feb 2022 13:50:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5FE0C0077;
	Mon, 28 Feb 2022 13:50:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A59EC001A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 13:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7143B40217
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 13:50:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZQpMPxrzcQ13 for <iommu@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 13:50:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2179D40112
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 13:50:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id C45121F438C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1646056242;
 bh=01LHGkJJ+DpNYyT1azd35ZIb6hFj6cZ6HVkPFWhLSpg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EVphFN2nlSfP7QnVMQPprWeHY3LGcr4CNLIyJwc93JAON0XRrHPUEBxJtTps4YWN/
 teZLX3YIek+zUtUDvBSoQrBSI/MMaewUqah04AgMl1Q2EoUcX49lKK3o3X3lDFTBeQ
 Ciwc4QZJbinmesi65g4Cksnl/DPy8HmKBYR1dBf3CG73Y2GP3KeK5HTIkqXRSKZgHR
 6g7KLIla/2XXP7PKHafiVilugVgEELIR4r3POzlUd375pz3+5AaS+yT3BOAkd7enBY
 wLsHX+VBenM5SuXKynOeeyhdGojSDhCTFd+XPt7gt+38YBVce7LBPgpfWq7bQghohU
 ob9f2ZHuNUTSg==
Message-ID: <7ba0ee87-c193-9834-d0b4-ff3e06ced82b@collabora.com>
Date: Mon, 28 Feb 2022 14:50:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 00/34] MT8195 IOMMU SUPPORT
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Yong Wu <yong.wu@mediatek.com>
References: <20220217113453.13658-1-yong.wu@mediatek.com>
 <YhzBSsn/zUlGg5JE@8bytes.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YhzBSsn/zUlGg5JE@8bytes.org>
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, xueqi.zhang@mediatek.com,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, yf.wang@mediatek.com,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
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

Il 28/02/22 13:34, Joerg Roedel ha scritto:
> Hi Yong Wu,
> 
> On Thu, Feb 17, 2022 at 07:34:19PM +0800, Yong Wu wrote:
>> Yong Wu (34):
>>    dt-bindings: mediatek: mt8195: Add binding for MM IOMMU
>>    dt-bindings: mediatek: mt8195: Add binding for infra IOMMU
>>    iommu/mediatek: Fix 2 HW sharing pgtable issue
>>    iommu/mediatek: Add list_del in mtk_iommu_remove
>>    iommu/mediatek: Remove clk_disable in mtk_iommu_remove
>>    iommu/mediatek: Add mutex for m4u_group and m4u_dom in data
>>    iommu/mediatek: Add mutex for data in the mtk_iommu_domain
>>    iommu/mediatek: Adapt sharing and non-sharing pgtable case
>>    iommu/mediatek: Add 12G~16G support for multi domains
>>    iommu/mediatek: Add a flag DCM_DISABLE
>>    iommu/mediatek: Add a flag NON_STD_AXI
>>    iommu/mediatek: Remove the granule in the tlb flush
>>    iommu/mediatek: Always enable output PA over 32bits in isr
>>    iommu/mediatek: Add SUB_COMMON_3BITS flag
>>    iommu/mediatek: Add IOMMU_TYPE flag
>>    iommu/mediatek: Contain MM IOMMU flow with the MM TYPE
>>    iommu/mediatek: Adjust device link when it is sub-common
>>    iommu/mediatek: Allow IOMMU_DOMAIN_UNMANAGED for PCIe VFIO
>>    iommu/mediatek: Add a PM_CLK_AO flag for infra iommu
>>    iommu/mediatek: Add infra iommu support
>>    iommu/mediatek: Add PCIe support
>>    iommu/mediatek: Add mt8195 support
>>    iommu/mediatek: Only adjust code about register base
>>    iommu/mediatek: Just move code position in hw_init
>>    iommu/mediatek: Separate mtk_iommu_data for v1 and v2
>>    iommu/mediatek: Remove mtk_iommu.h
>>    iommu/mediatek-v1: Just rename mtk_iommu to mtk_iommu_v1
>>    iommu/mediatek: Add mtk_iommu_bank_data structure
>>    iommu/mediatek: Initialise bank HW for each a bank
>>    iommu/mediatek: Change the domid to iova_region_id
>>    iommu/mediatek: Get the proper bankid for multi banks
>>    iommu/mediatek: Initialise/Remove for multi bank dev
>>    iommu/mediatek: Backup/restore regsiters for multi banks
>>    iommu/mediatek: mt8195: Enable multi banks for infra iommu
> 
> This doesn't apply cleanly, can you please send a version rebased to
> v5.17-rc4?
> 
> Thanks,
> 
> 	Joerg

Hello Joerg,

this series depends on the following series:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=592275

...which is also well tested and ready to be merged in.

Applying Yong's series without the mentioned series from Dafna would not work.


Thanks,
Angelo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
