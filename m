Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCDEC3A59D
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 07:22:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24ECE20644
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 07:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24ECE20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 04BADB50;
	Fri, 16 Aug 2019 07:22:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D395BACD
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 07:22:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 9A632E5
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 07:22:35 +0000 (UTC)
X-UUID: 43d757f4b0e946618d6cbab272d1ee3a-20190816
X-UUID: 43d757f4b0e946618d6cbab272d1ee3a-20190816
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(mailgw01.mediatek.com ESMTP with TLS)
	with ESMTP id 1470457894; Fri, 16 Aug 2019 15:22:30 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
	(172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
	Fri, 16 Aug 2019 15:22:24 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
	(172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Fri, 16 Aug 2019 15:22:23 +0800
Message-ID: <1565940140.20346.21.camel@mhfsdcap03>
Subject: Re: [PATCH v9 08/21] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB
	Mode
From: Yong Wu <yong.wu@mediatek.com>
To: Will Deacon <will@kernel.org>
Date: Fri, 16 Aug 2019 15:22:20 +0800
In-Reply-To: <20190815115021.7pbv5s2qbgsuitvh@willie-the-truck>
References: <1565423901-17008-1-git-send-email-yong.wu@mediatek.com>
	<1565423901-17008-9-git-send-email-yong.wu@mediatek.com>
	<20190814144059.ruyc45yoqkwpbuga@willie-the-truck>
	<1565858869.12818.51.camel@mhfsdcap03>
	<20190815095123.rzgtpklvhtjlqir4@willie-the-truck>
	<1565864318.14278.4.camel@mhfsdcap03>
	<20190815115021.7pbv5s2qbgsuitvh@willie-the-truck>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BA349197A457FBABF294C6AEA76C731A816F8C5D8247B147DB51393DA440EAB42000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream@mediatek.com, chao.hao@mediatek.com,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
	Robin Murphy <robin.murphy@arm.com>, Matthias Kaehlcke <mka@chromium.org>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, 2019-08-15 at 12:50 +0100, Will Deacon wrote:
> Ok, I think speaking to Robin helped me a bit with this...
> 
> On Thu, Aug 15, 2019 at 06:18:38PM +0800, Yong Wu wrote:
> > On Thu, 2019-08-15 at 10:51 +0100, Will Deacon wrote:
> > > On Thu, Aug 15, 2019 at 04:47:49PM +0800, Yong Wu wrote:
> > > > On Wed, 2019-08-14 at 15:41 +0100, Will Deacon wrote:
> > > > > On Sat, Aug 10, 2019 at 03:58:08PM +0800, Yong Wu wrote:
> > > > > > MediaTek extend the arm v7s descriptor to support the dram over 4GB.
> > > > > > 
> > > > > > In the mt2712 and mt8173, it's called "4GB mode", the physical address
> > > > > > is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
> > > > > > is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
> > > > > > bit32 is always enabled. thus, in the M4U, we always enable the bit9
> > > > > > for all PTEs which means to enable bit32 of physical address. Here is
> > > > > > the detailed remap relationship in the "4GB mode":
> > > > > > CPU PA         ->    HW PA
> > > > > > 0x4000_0000          0x1_4000_0000 (Add bit32)
> > > > > > 0x8000_0000          0x1_8000_0000 ...
> > > > > > 0xc000_0000          0x1_c000_0000 ...
> > > > > > 0x1_0000_0000        0x1_0000_0000 (No change)
> 
> [...]
> 
> > > > > The way I would like this quirk to work is that the io-pgtable code
> > > > > basically sets bit 9 in the pte when bit 32 is set in the physical address,
> > > > > and sets bit 4 in the pte when bit 33 is set in the physical address. It
> > > > > would then do the opposite when converting a pte to a physical address.
> > > > > 
> > > > > That way, your driver can call the page table code directly with the high
> > > > > addresses and we don't have to do any manual offsetting or range checking
> > > > > in the page table code.
> > > > 
> > > > In this case, the mt8183 can work successfully while the "4gb
> > > > mode"(mt8173/mt2712) can not.
> > > > 
> > > > In the "4gb mode", As the remap relationship above, we should always add
> > > > bit32 in pte as we did in [2]. and need add bit32 in the
> > > > "iova_to_phys"(Not always add.). That means the "4gb mode" has a special
> > > > flow:
> > > > a. Always add bit32 in paddr_to_iopte.
> > > > b. Add bit32 only when PA < 0x40000000 in iopte_to_paddr.
> > > 
> > > I think this is probably at the heart of my misunderstanding. What is so
> > > special about PAs (is this HW PA or CPU PA?) below 0x40000000? Is this RAM
> > > or something else?
> > 
> > SRAM and HW register that IOMMU can not access.
> 
> Ok, so redrawing your table from above, I think we can say something like:
> 
> 
> CPU Physical address
> ====================
> 
> 0G	1G	2G	3G	4G	5G
> |---A---|---B---|---C---|---D---|---E---|
> +--I/O--+------------Memory-------------+
> 
> 
> IOMMU output physical address
> =============================
> 
> 				4G	5G	6G	7G	8G
> 				|---E---|---B---|---C---|---D---|
> 				+------------Memory-------------+
> 
> 
> Do you agree? 

Quite right.


> If so, what happens to region 'A' (the I/O region) in the
> IOMMU output physical address space. Is it accessible?

No. IOMMU can not access region 'A' above.

> 
> Anyway, I think it's the job of the driver to convert between the two
> address spaces, so that:
> 
>   - On ->map(), bit 32 of the CPU physical address is set before calling
>     into the iopgtable code
> 
>   - The result from ->iova_to_phys() should be the result from the
>     iopgtable code, but with the top bit cleared for addresses over
>     5G.
> 
> This assumes that:
> 
>   1. We're ok setting bit 9 in the ptes mapping region 'E'.
>   2. The IOMMU page-table walker uses CPU physical addresses
> 
> Are those true?

Yes. Then this patch would be close to the one[1] I sent in v8.

Do I need to split this patch into 2 ones?:
a).the pagetable code that support 34bit PA when MTK quirk is enabled.
It only has the symmetric code handle BIT32/BIT33. Besides, I will add
CONFIG_PHYS_ADDR_T_64BIT in the iopte_to_addr as commented before.

b) MTK code that apply the special "4gb mode" flow. And the "oas" will
always is 34 bit since v7s has already supported our case.

[1]http://lists.infradead.org/pipermail/linux-mediatek/2019-June/020991.html

> 
> Thanks,
> 
> Will


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
