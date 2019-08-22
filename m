Return-Path: <SRS0=jB4a=WS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DF9C3A5A3
	for <iommu@archiver.kernel.org>; Thu, 22 Aug 2019 17:14:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE89A233FE
	for <iommu@archiver.kernel.org>; Thu, 22 Aug 2019 17:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTshqoq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE89A233FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A7416B7A;
	Thu, 22 Aug 2019 17:14:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 97F0049F
	for <iommu@lists.linux-foundation.org>;
	Thu, 22 Aug 2019 17:14:23 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 60DC289B
	for <iommu@lists.linux-foundation.org>;
	Thu, 22 Aug 2019 17:14:23 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 13B182089E;
	Thu, 22 Aug 2019 17:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494063;
	bh=vqE2N/zi1fzhDJw+o9xdlWk9123wTSi4CKCbyRiWtHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTshqoq99M9s6kEqnvExZ9y43tJZ5RG6H7DJicnyp4xB0EEyG3E8dxsEeD+mtCaSN
	tPOnriBlWjBj6t3b/aXGqSnI7for4nxNhTc101nzXmKDqt5n+5VHe7Jxkot9Q6CAmx
	WfjOx+T5BTnDWixtTIskYdTH9FZDyzwtT6bJ2aG0=
Date: Thu, 22 Aug 2019 18:14:16 +0100
From: Will Deacon <will@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v10 09/23] iommu/io-pgtable-arm-v7s: Extend to support
	PA[33:32] for MediaTek
Message-ID: <20190822171415.475yg7pmy6gfj35l@willie-the-truck>
References: <1566395606-7975-1-git-send-email-yong.wu@mediatek.com>
	<1566395606-7975-10-git-send-email-yong.wu@mediatek.com>
	<20190821152448.qmoqjh5zznfpdi6n@willie-the-truck>
	<1566464186.11621.7.camel@mhfsdcap03>
	<10d5122d-3375-161b-9356-2ddfc1c835bd@arm.com>
	<20190822101749.3kwzd5lb7zinsord@willie-the-truck>
	<e6652176-763d-5298-9e10-8c1fbe1b3c0d@arm.com>
	<20190822112836.efodtwu3souq3uwa@willie-the-truck>
	<1566475533.11621.18.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1566475533.11621.18.camel@mhfsdcap03>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream@mediatek.com, Tomasz Figa <tfiga@google.com>,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
	chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
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

On Thu, Aug 22, 2019 at 08:05:33PM +0800, Yong Wu wrote:
> On Thu, 2019-08-22 at 12:28 +0100, Will Deacon wrote:
> > Ok, great. Yong Wu -- are you ok respinning with the above + missing
> > brackets?
> 
> Of course I can.
> 
> NearlyAll the interface in this file is prefixed with "arm_v7s_", so
> does the new interface also need it?, like arm_v7s_is_mtk_enabled. And
> keep the iopte_to_paddr and paddr_to_iopte symmetrical.
> 
> 
> Then the final patch would looks like below, is it ok?

Looks good to me:

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
