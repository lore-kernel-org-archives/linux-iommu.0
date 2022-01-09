Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73490C433FE
	for <iommu@archiver.kernel.org>; Sun,  9 Jan 2022 02:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0139813FB;
	Sun,  9 Jan 2022 02:47:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gNlpuVyzhxAQ; Sun,  9 Jan 2022 02:47:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E1EB1813AC;
	Sun,  9 Jan 2022 02:47:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B26ACC0030;
	Sun,  9 Jan 2022 02:47:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 665CCC001E
 for <iommu@lists.linux-foundation.org>; Sun,  9 Jan 2022 02:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 59FB6403EA
 for <iommu@lists.linux-foundation.org>; Sun,  9 Jan 2022 02:47:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6283sBdiuhMi for <iommu@lists.linux-foundation.org>;
 Sun,  9 Jan 2022 02:46:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20FAD4014D
 for <iommu@lists.linux-foundation.org>; Sun,  9 Jan 2022 02:46:56 +0000 (UTC)
X-UUID: 76def63b6d2841baa0155eb7c3a2a142-20220109
X-UUID: 76def63b6d2841baa0155eb7c3a2a142-20220109
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 474611172; Sun, 09 Jan 2022 10:46:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 9 Jan 2022 10:46:50 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 9 Jan 2022 10:46:49 +0800
Message-ID: <214831c674c23d6733d372b5970d8c6754d55b1d.camel@mediatek.com>
Subject: Re: [PATCH v3 26/33] iommu/mediatek: Add mtk_iommu_bank_data structure
From: Yong Wu <yong.wu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Date: Sun, 9 Jan 2022 10:46:49 +0800
In-Reply-To: <5ac9dd6b-43cd-0f76-eb34-906ab84196c1@collabora.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-27-yong.wu@mediatek.com>
 <5ac9dd6b-43cd-0f76-eb34-906ab84196c1@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 yen-chang.chen@mediatek.com, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Hi AngeloGioacchino,

Thanks very much for reviewing whole the patchset.

On Tue, 2022-01-04 at 16:53 +0100, AngeloGioacchino Del Regno wrote:
> Il 23/09/21 13:58, Yong Wu ha scritto:
> > Prepare for supporting multi-banks for the IOMMU HW, No functional
> > change.
> > 
> > Add a new structure(mtk_iommu_bank_data) for each a bank. Each a
> > bank have
> > the independent HW base/IRQ/tlb-range ops, and each a bank has its
> > special
> > iommu-domain(independent pgtable), thus, also move the domain
> > information
> > into it.
> > 
> > In previous SoC, we have only one bank which could be treated as
> > bank0(
> > bankid always is 0 for the previous SoC).
> > 
> > After adding this structure, the tlb operations and irq could use
> > bank_data as parameter.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---

[...]
  
> > -struct mtk_iommu_data {
> > +struct mtk_iommu_bank_data {
> >   	void __iomem			*base;
> >   	int				irq;
> > +	unsigned int			id;
> > +	struct device			*pdev;
> 
> `pdev` may be a bit misleading, as it's conventionally read as
> "platform device"
> and not as the intended "parent device"... perhaps calling it
> parent_dev would be
> more appropriate.

will rename it. Thanks.

> 
> > +	struct mtk_iommu_data		*pdata;   /* parent data */
> 
> Same here, pdata -> parent_data

Will fix.

> 
> > +	spinlock_t			tlb_lock; /* lock for tlb range
> > flush */
> > +	struct mtk_iommu_domain		*m4u_dom; /* Each bank has
> > a domain */
> > +};
> > +
> > +struct mtk_iommu_data {
> > +	union {
> > +		struct { /* only for gen1 */
> > +			void __iomem		*base;
> > +			int			irq;
> > +			struct mtk_iommu_domain	*m4u_dom;
> > +		};
> > +
> > +		/* only for gen2 that support multi-banks */
> > +		struct mtk_iommu_bank_data	bank[MTK_IOMMU_BANK_MAX];
> > +	};
> 
> Sorry, but I really don't like this union... please, update
> mtk_iommu_v1 to always
> use bank[0] or, more appropriately, dynamically allocate the bank
> array with a
> devm_kzalloc call (as to not waste memory on platforms with less
> available banks).
> 
> In that case, you would have...
> 
> >   	struct device			*dev;
> >   	struct clk			*bclk;
> >   	phys_addr_t			protect_base; /* protect memory
> > base */
> >   	struct mtk_iommu_suspend_reg	reg;
> > -	struct mtk_iommu_domain		*m4u_dom;
> >   	struct iommu_group		*m4u_group[MTK_IOMMU_GROUP_MAX];
> >   	bool                            enable_4GB;
> > -	spinlock_t			tlb_lock; /* lock for tlb range
> > flush */
> 
> 	struct mtk_iommu_bank_data	*banks;
> 	u8				num_banks;
> 
> ... where `num_banks` gets copied from the same in
> mtk_iommu_plat_data, defined
> for each SoC, and where `banks` is dynamically allocated in
> mtk_iommu.c and
> mtk_iommu_v1.c's probe() callback.

Thanks for this idea. I will try this to see if the code will be too
complicate after changing this. If it is, I will use bank[0] always in
mtk_iommu_v1, this looks simpler.

> 
> >   
> >   	struct iommu_device		iommu;
> >   	const struct mtk_iommu_plat_data *plat_data;
> > 
> 
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
