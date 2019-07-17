Return-Path: <SRS0=5D8q=VO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D44C76192
	for <iommu@archiver.kernel.org>; Wed, 17 Jul 2019 14:23:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC81121848
	for <iommu@archiver.kernel.org>; Wed, 17 Jul 2019 14:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEGGSoDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC81121848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 785E6EEB;
	Wed, 17 Jul 2019 14:23:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 54D2FEC5
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Jul 2019 14:23:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 02A1D756
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Jul 2019 14:23:46 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 8568E21743;
	Wed, 17 Jul 2019 14:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563373426;
	bh=GlgM6Flb7U5FvLBrim3MfffxSY9Cf03irtwOwK4KS08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nEGGSoDItNpMBm7fRxdhPxrr5B8dn0+K1xshnV+ZF9QLHM9kqfyNzbDovXpkWgi6k
	L1J4PtnDOWbmj7aboaApmgn03y0Svo7KOZS+F8Ko1wo7KUVWvLev86ahSBecZnjw41
	6fwNTWZl/I9y305D5xAlquohPhYf8EeD99abhAPI=
Date: Wed, 17 Jul 2019 15:23:40 +0100
From: Will Deacon <will@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v8 07/21] iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB
	Mode
Message-ID: <20190717142339.wltamw6wktwixqqn@willie-the-truck>
References: <1561774167-24141-1-git-send-email-yong.wu@mediatek.com>
	<1561774167-24141-8-git-send-email-yong.wu@mediatek.com>
	<20190710143649.w5dplhzdpi3bxp7e@willie-the-truck>
	<1562846036.31342.10.camel@mhfsdcap03>
	<20190711123129.da4rg35b54u4svfw@willie-the-truck>
	<1563079280.31342.22.camel@mhfsdcap03>
	<20190715095156.xczfkbm6zpjueq32@willie-the-truck>
	<1563367459.31342.34.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1563367459.31342.34.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream@mediatek.com, Tomasz Figa <tfiga@google.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	Evan Green <evgreen@chromium.org>, chao.hao@mediatek.com,
	iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	yingjoe.chen@mediatek.com, anan.sun@mediatek.com,
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

On Wed, Jul 17, 2019 at 08:44:19PM +0800, Yong Wu wrote:
> On Mon, 2019-07-15 at 10:51 +0100, Will Deacon wrote:
> > On Sun, Jul 14, 2019 at 12:41:20PM +0800, Yong Wu wrote:
> > > @@ -742,7 +763,9 @@ static struct io_pgtable
> > > *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
> > >  {
> > >  	struct arm_v7s_io_pgtable *data;
> > >  
> > > -	if (cfg->ias > ARM_V7S_ADDR_BITS || cfg->oas > ARM_V7S_ADDR_BITS)
> > > +	if (cfg->ias > ARM_V7S_ADDR_BITS ||
> > > +	    (cfg->oas > ARM_V7S_ADDR_BITS &&
> > > +	     !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT)))
> > >  		return NULL;
> > 
> > I think you can rework this to do something like:
> > 
> > 	if (cfg->ias > ARM_V7S_ADDR_BITS)
> > 		return NULL;
> > 
> > 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT) {
> > 		if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
> > 			cfg->oas = min(cfg->oas, ARM_V7S_ADDR_BITS);
> > 		else if (cfg->oas > 34)
> > 			return NULL;
> > 	} else if (cfg->oas > ARM_V7S_ADDR_BITS) {
> > 		return NULL;
> > 	}
> > 
> > so that we clamp the oas when phys_addr_t is 32-bit for you. That should
> > allow you to remove lots of the checking from iopte_to_paddr() too if you
> > check against oas in the map() function.
> > 
> > Does that make sense?
> 
> Of course I'm ok for this. I'm only afraid that this function has
> already 3 checking "if (x) return NULL", Here we add a new one and so
> many lines... Maybe the user should guarantee the right value of oas.
> How about move it into mtk_iommu.c?
> 
> About the checking of iopte_to_paddr, I can not remove them. I know it
> may be a bit special and not readable. Hmm, I guess I should use a MACRO
> instead of the hard code 33 for the special 4GB mode case.

Why can't you just do something like:

	if (!(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_EXT))
		return paddr;

	if (pte & ARM_V7S_ATTR_MTK_PA_BIT33)
		paddr |= BIT_ULL(33);

	if (pte & ARM_V&S_ATTR_MTK_PA_BIT32)
		paddr |= BIT_ULL(32);

	return paddr;

The diff I sent previously sanitises the oas at init time, and then you
can just enforce it in map().

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
