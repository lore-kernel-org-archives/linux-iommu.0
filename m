Return-Path: <SRS0=gZYu=WK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCE7C433FF
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 08:24:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 105D02084F
	for <iommu@archiver.kernel.org>; Wed, 14 Aug 2019 08:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG1qK+Pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105D02084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CA8FE907;
	Wed, 14 Aug 2019 08:24:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 32E268DC
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 08:24:26 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EE342CF
	for <iommu@lists.linux-foundation.org>;
	Wed, 14 Aug 2019 08:24:25 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id AF69120843;
	Wed, 14 Aug 2019 08:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565771065;
	bh=dOIAznLWxzP0u+OSBAYPKB0yVmhsjJLY8I+qEiU4L9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RG1qK+Pt18ss2tHX2RNIruXp2UeFxF2bDhRkagJoZReWFhDZXfEow8U4TKl/u2GxN
	FENR3KwZzH+xJs6V8b8E+Ohi9E8ucLSz+ossd+rc+oGgpJmG4CckHXL9yVuGjvDcgq
	xabdFyMBFyhejTyori5x2p9Mwh+6uhFGWeunN1hU=
Date: Wed, 14 Aug 2019 09:24:20 +0100
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v9 00/21] MT8183 IOMMU SUPPORT
Message-ID: <20190814082419.tppi3o4x27qotkn6@willie-the-truck>
References: <1565423901-17008-1-git-send-email-yong.wu@mediatek.com>
	<20190814081825.GA22669@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190814081825.GA22669@8bytes.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
	srv_heupstream@mediatek.com, chao.hao@mediatek.com,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
	Robin Murphy <robin.murphy@arm.com>, Matthias Kaehlcke <mka@chromium.org>
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

On Wed, Aug 14, 2019 at 10:18:25AM +0200, Joerg Roedel wrote:
> On Sat, Aug 10, 2019 at 03:58:00PM +0800, Yong Wu wrote:
> > Change notes:
> > v9:
> >    1) rebase on v5.3-rc1.
> >    2) In v7s, Use oas to implement MTK 4GB mode. It nearly reconstruct the
> >       patch, so I don't keep the R-b.
> 
> Okay, this looks close to being ready, just the io-pgtable patches still
> need review.

On my list for today :) (Today is SMMU day for me. Send coffee.)

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
