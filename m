Return-Path: <SRS0=nwur=C6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEBAC4727C
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 22:23:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842C523A69
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 22:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CluYU3j+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842C523A69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3311C214E6;
	Mon, 21 Sep 2020 22:23:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TXeNGQpJ25Lj; Mon, 21 Sep 2020 22:23:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D40A520015;
	Mon, 21 Sep 2020 22:23:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD28CC0859;
	Mon, 21 Sep 2020 22:23:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8517DC0051
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 22:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 70A7A20522
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 22:23:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V0E8jRCPB1Fd for <iommu@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 22:23:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 9F33A20015
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 22:23:35 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7B21723A62;
 Mon, 21 Sep 2020 22:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600727015;
 bh=N9RzAc6C05t2rxlnw7lSRzYBzP947+Ts1bAKMsLmjEU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CluYU3j+OZ6XbzXp4elhUn92tatuqzSObk4WseHK3gulRNfFdoM3XXQ7GgS+G4xvK
 kvbtvWJXZAgYM3RJzYV8SaGS1CNoGPsNIvg1Xs/mnOCkm/yQVAzQJYYmJEmvpr+nPl
 7Rqin2VNlKQqbOYisp71I5TxrLYGu6uPZozrpNj8=
Date: Mon, 21 Sep 2020 23:23:30 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCHv4 1/6] iommu/io-pgtable-arm: Add support to use system
 cache
Message-ID: <20200921222329.GA4409@willie-the-truck>
References: <cover.1599832685.git.saiprakash.ranjan@codeaurora.org>
 <3b1beb6cf6a34a44b0ecff9ec5a2105b5ff91bd4.1599832685.git.saiprakash.ranjan@codeaurora.org>
 <20200921180318.GG3141@willie-the-truck>
 <9646dd4f-f1e6-992d-b8a0-0f2c14fa9fe8@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9646dd4f-f1e6-992d-b8a0-0f2c14fa9fe8@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm@vger.kernel.org, Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 "Kristian H . Kristensen" <hoegsberg@google.com>,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
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

On Mon, Sep 21, 2020 at 11:03:49PM +0100, Robin Murphy wrote:
> On 2020-09-21 19:03, Will Deacon wrote:
> > On Fri, Sep 11, 2020 at 07:57:18PM +0530, Sai Prakash Ranjan wrote:
> > > Add a quirk IO_PGTABLE_QUIRK_SYS_CACHE to override the
> > > attributes set in TCR for the page table walker when
> > > using system cache.
> > 
> > I wonder if the panfrost folks can reuse this for the issue discussed
> > over at:
> > 
> > https://lore.kernel.org/r/cover.1600213517.git.robin.murphy@arm.com
> 
> Isn't this all hinged around the outer cacheability attribute, rather than
> shareability (since these are nominally NC mappings and thus already
> properly Osh)? The Panfrost issue is just about shareability domains being a
> bit wonky; the cacheability attributes there are actually reasonably normal
> (other than not having a non-cacheable type at all, only a choice of
> allocation policies...)

Hmm, yes, this quirk _also_ changes the cacheability settings which isn't
what we need. It's a bit grotty having two different ways to configure these
TCR bits (i.e. a quirk and a format), but at least the mali format rejects
all of the quirks so I suppose it's not the end of the world.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
