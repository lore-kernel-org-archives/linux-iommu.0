Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DB9C3A59D
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 18:05:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FCC321743
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 18:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yclaVWCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCC321743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5CC3DC7D;
	Fri, 16 Aug 2019 18:05:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 78736C75
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 18:05:29 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 31F36786
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 18:05:28 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 7830C20665;
	Fri, 16 Aug 2019 18:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565978727;
	bh=ATa8fe0CxhAbQASCjl6IYhzQjKdSYeQNhdmBcA2ZRlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yclaVWCYpQyvh9OaGQPrYfiMYsvcW/o5PkOIV7eQUmhstIzpx2ZZ0sSjiKcxqnMgv
	7z+Jikxzq4/ZIHpHnEO2nuFXbcvpn1v46HdwXjYNwayNZxp8x1aicBOflxg1CSeLTk
	vayH5O/ix+LVeWKI9G785+H8RXwq5z7rEAqzMsfo=
Date: Fri, 16 Aug 2019 19:05:22 +0100
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/6] arm64: document the choice of page attributes for
	pgprot_dmacoherent
Message-ID: <20190816180522.gocqeayajlbu4gzp@willie-the-truck>
References: <20190816070754.15653-1-hch@lst.de>
	<20190816070754.15653-7-hch@lst.de>
	<20190816173118.4rbbzuogfamfa554@willie-the-truck>
	<20190816175942.GA4879@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190816175942.GA4879@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: Shawn Anastasio <shawn@anastas.io>, linux-m68k@lists.linux-m68k.org,
	Guan Xuetao <gxt@pku.edu.cn>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, linux-mips@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Paul Burton <paul.burton@mips.com>,
	Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Fri, Aug 16, 2019 at 07:59:42PM +0200, Christoph Hellwig wrote:
> On Fri, Aug 16, 2019 at 06:31:18PM +0100, Will Deacon wrote:
> > Mind if I tweak the second sentence to be:
> > 
> >   This is different from "Device-nGnR[nE]" memory which is intended for MMIO
> >   and thus forbids speculation, preserves access size, requires strict
> >   alignment and can also force write responses to come from the endpoint.
> > 
> > ? It's a small change, but it better fits with the arm64 terminology
> > ("strongly ordered" is no longer used in the architecture).
> > 
> > If you're happy with that, I can make the change and queue this patch
> > for 5.4.
> 
> I'm fine with the change, but you really need this series as base,
> as there is no pgprot_dmacoherent before the series.  So I think I'll
> have to queue it up if we want it for 5.4, and I'll need a few more
> reviews for the other patches in this series first.

Ah, I didn't think about the contextual stuff. In which case, with my
change in wording:

Acked-by: Will Deacon <will@kernel.org>

and feel free to route it with the rest.

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
