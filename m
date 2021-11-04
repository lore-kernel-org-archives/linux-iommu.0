Return-Path: <SRS0=75oM=PX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BF3C433EF
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 03:28:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC7C61053
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 03:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6AC7C61053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A2CC80E32;
	Thu,  4 Nov 2021 03:28:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dUz8NWOwk9BG; Thu,  4 Nov 2021 03:28:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CFBA080BE1;
	Thu,  4 Nov 2021 03:28:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4B40C0012;
	Thu,  4 Nov 2021 03:28:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B236C000E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 03:28:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73BEB402BE
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 03:28:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BQUaPrgF8lWR for <iommu@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 03:28:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E1E7402B9
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 03:28:46 +0000 (UTC)
X-UUID: c97709e09f3e451281f0b753048bd9b8-20211104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=obhkLKakLCXFFdtMrvJQpCX8waFJ6arRjOpKnMlEJDY=; 
 b=U6zaoP1mGU96Nokuy8oq1aI2tau0zHNR3Yxt4Y7okHdW2UZR7EqlN9PsDuksG1w2D6vRJw3bVpp4P962Juelz95P5eTZgZnomeBRu5D3Jttd11X3Y0bnZotvFGpy+JauBYOg+BzddzK4f0h6+kMjnk7YTxN0EwBqfSN37+jfPFw=;
X-UUID: c97709e09f3e451281f0b753048bd9b8-20211104
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 564425789; Thu, 04 Nov 2021 11:28:41 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Thu, 4 Nov 2021 11:28:39 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs10n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 4 Nov 2021 11:28:38 +0800
Message-ID: <e099c6e8af0b184f8e823fac325ea36329cb5709.camel@mediatek.com>
Subject: Re: [PATCH v3 13/33] iommu/mediatek: Remove the power status
 checking in tlb flush all
From: Yong Wu <yong.wu@mediatek.com>
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Date: Thu, 4 Nov 2021 11:28:38 +0800
In-Reply-To: <f0e2ebf98481ee2ae8b88565a337e773532ddffd.camel@mediatek.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-14-yong.wu@mediatek.com>
 <6cff0b97-b861-e02d-e76f-2510c962c452@collabora.com>
 <f0e2ebf98481ee2ae8b88565a337e773532ddffd.camel@mediatek.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Collabora Kernel ML <kernel@collabora.com>, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Robin
 Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 yen-chang.chen@mediatek.com, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Mon, 2021-10-25 at 12:03 +0800, Yong Wu wrote:
> On Fri, 2021-10-22 at 16:03 +0200, Dafna Hirschfeld wrote:
> > Hi
> > 
> > 
> > On 23.09.21 13:58, Yong Wu wrote:
> > > To simplify the code, Remove the power status checking in the
> > > tlb_flush_all, remove this:
> > >     if (pm_runtime_get_if_in_use(data->dev) <= 0)
> > > 	    continue;
> > > 
> > > After this patch, the mtk_iommu_tlb_flush_all will be called from
> > > a) isr
> > > b) pm runtime resume callback
> > > c) tlb flush range fail case
> > > d) iommu_create_device_direct_mappings
> > >     -> iommu_flush_iotlb_all
> > > In first three cases, the power and clock always are enabled; d)
> > > is
> > > direct
> > 
> > Regarding case "c) tlb flush range fail case", I found out that
> > this
> > often happens when the iommu is used while it is runtime
> > suspended. 
> 
> Which SoC and branch are you testing on?
> 
> > For example the mtk-vcodec encoder driver calls
> > "pm_runtime_resume_and_get" only when it starts
> > streaming but
> > buffers allocation is done in 'v4l2_reqbufs' before
> > "pm_runtime_resume_and_get" is called
> 
> This is the case I tried to fix in [14/33].
> pm_runtime_get_if_in_use should return when the iommu device's pm is
> not active when vcodec allocate buffer before pm_runtime_resume_and
> get.
> 
> Do you have the devicelink patchset in your branch? if not, the
> vcodec
> should call mtk_smi_larb_get to enable the power/clock for larbs,
> then
> the iommu's device is active via devicelink between smi and iommu
> device.
> 
> > and then I see the warning "Partial TLB flush timed out, falling
> > back
> > to full flush"
> > I am not sure how to fix that issue, but it seems that case 'c)'

Have your issue been fixed? or more information about it.

Thanks.

> > might indicate that
> > power and clock are actually not enabled.
> > 
> > > mapping, the tlb flush is unnecessay since we already have
> > > tlb_flush_all
> > > in the pm_runtime_resume callback. When the iommu's power status
> > > is
> > > changed to active, the tlb always is clean.
> > > 
> > > In addition, there still are 2 reasons that don't add PM status
> > > checking
> > > in the tlb flush all:
> > > a) Write tlb flush all register also is ok even though the HW has
> > > no
> > > power and clocks. Write ignore.
> > > b) pm_runtime_get_if_in_use(m4udev) is 0 when the tlb_flush_all
> > > is called frm pm_runtime_resume cb. From this point, we can not
> > > add
> > > this code above in this tlb_flush_all.
> > > 
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >   drivers/iommu/mtk_iommu.c | 20 +++++++-------------
> > >   1 file changed, 7 insertions(+), 13 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
