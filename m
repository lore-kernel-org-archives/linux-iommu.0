Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F37BC31E40
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 10:18:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB737208C2
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 10:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB737208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 99D1510FD;
	Thu, 15 Aug 2019 10:18:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C72C510F9
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 10:18:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [1.203.163.81])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 97D9687B
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 10:18:51 +0000 (UTC)
X-UUID: 320ceda1c3274245bf1a01ca9a4c4a64-20190815
X-UUID: 320ceda1c3274245bf1a01ca9a4c4a64-20190815
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(mailgw01.mediatek.com ESMTP with TLS)
	with ESMTP id 1914054432; Thu, 15 Aug 2019 18:18:47 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
	(172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
	Thu, 15 Aug 2019 18:18:39 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
	(172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Thu, 15 Aug 2019 18:18:42 +0800
Message-ID: <1565864318.14278.4.camel@mhfsdcap03>
Subject: Re: [PATCH v9 08/21] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB
	Mode
From: Yong Wu <yong.wu@mediatek.com>
To: Will Deacon <will@kernel.org>
Date: Thu, 15 Aug 2019 18:18:38 +0800
In-Reply-To: <20190815095123.rzgtpklvhtjlqir4@willie-the-truck>
References: <1565423901-17008-1-git-send-email-yong.wu@mediatek.com>
	<1565423901-17008-9-git-send-email-yong.wu@mediatek.com>
	<20190814144059.ruyc45yoqkwpbuga@willie-the-truck>
	<1565858869.12818.51.camel@mhfsdcap03>
	<20190815095123.rzgtpklvhtjlqir4@willie-the-truck>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E025A19421E7A1D3E1417135ABBC09AAB1F444894762B73446C1A1D4F4AC54C82000:8
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

On Thu, 2019-08-15 at 10:51 +0100, Will Deacon wrote:
> On Thu, Aug 15, 2019 at 04:47:49PM +0800, Yong Wu wrote:
> > On Wed, 2019-08-14 at 15:41 +0100, Will Deacon wrote:
> > > On Sat, Aug 10, 2019 at 03:58:08PM +0800, Yong Wu wrote:
> > > > MediaTek extend the arm v7s descriptor to support the dram over 4GB.
> > > > 
> > > > In the mt2712 and mt8173, it's called "4GB mode", the physical address
> > > > is from 0x4000_0000 to 0x1_3fff_ffff, but from EMI point of view, it
> > > > is remapped to high address from 0x1_0000_0000 to 0x1_ffff_ffff, the
> > > > bit32 is always enabled. thus, in the M4U, we always enable the bit9
> > > > for all PTEs which means to enable bit32 of physical address. Here is
> > > > the detailed remap relationship in the "4GB mode":
> > > > CPU PA         ->    HW PA
> > > > 0x4000_0000          0x1_4000_0000 (Add bit32)
> > > > 0x8000_0000          0x1_8000_0000 ...
> > > > 0xc000_0000          0x1_c000_0000 ...
> > > > 0x1_0000_0000        0x1_0000_0000 (No change)
> > > 
> > > So in this example, there are no PAs below 0x4000_0000 yet you later
> > > add code to deal with that:
> > > 
> > > > +	/* Workaround for MTK 4GB Mode: Add BIT32 only when PA < 0x4000_0000.*/
> > > > +	if (cfg->oas == ARM_V7S_MTK_4GB_OAS && paddr < 0x40000000UL)
> > > > +		paddr |= BIT_ULL(32);
> > > 
> > > Why? Mainline currently doesn't do anything like this for the "4gb mode"
> > > support as far as I can tell. In fact, we currently unconditionally set
> > > bit 32 in the physical address returned by iova_to_phys() which wouldn't
> > > match your CPU PAs listed above, so I'm confused about how this is supposed
> > > to work.
> > 
> > Actually current mainline have a bug for this. So I tried to use another
> > special patch[1] for it in v8.
> 
> If you're fixing a bug in mainline, I'd prefer to see that as a separate
> patch.
> 
> > But the issue is not critical since MediaTek multimedia consumer(v4l2
> > and drm) don't call iommu_iova_to_phys currently.
> > 
> > > 
> > > The way I would like this quirk to work is that the io-pgtable code
> > > basically sets bit 9 in the pte when bit 32 is set in the physical address,
> > > and sets bit 4 in the pte when bit 33 is set in the physical address. It
> > > would then do the opposite when converting a pte to a physical address.
> > > 
> > > That way, your driver can call the page table code directly with the high
> > > addresses and we don't have to do any manual offsetting or range checking
> > > in the page table code.
> > 
> > In this case, the mt8183 can work successfully while the "4gb
> > mode"(mt8173/mt2712) can not.
> > 
> > In the "4gb mode", As the remap relationship above, we should always add
> > bit32 in pte as we did in [2]. and need add bit32 in the
> > "iova_to_phys"(Not always add.). That means the "4gb mode" has a special
> > flow:
> > a. Always add bit32 in paddr_to_iopte.
> > b. Add bit32 only when PA < 0x40000000 in iopte_to_paddr.
> 
> I think this is probably at the heart of my misunderstanding. What is so
> special about PAs (is this HW PA or CPU PA?) below 0x40000000? Is this RAM
> or something else?

SRAM and HW register that IOMMU can not access.

(sorry, My mailbox has something wrong.)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
