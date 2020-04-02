Return-Path: <SRS0=urD1=5S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFBBC43331
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 06:56:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC48820784
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 06:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p8hZI5g2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC48820784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9729820425;
	Thu,  2 Apr 2020 06:56:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F3pNhJsdhqfF; Thu,  2 Apr 2020 06:56:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1052320423;
	Thu,  2 Apr 2020 06:56:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04551C089F;
	Thu,  2 Apr 2020 06:56:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A79D3C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 06:56:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9186287EC0
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 06:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QtcE-WnJ22gt for <iommu@lists.linux-foundation.org>;
 Thu,  2 Apr 2020 06:56:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 13D3387EBB
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 06:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=MifLacyZ11MXEQpqNAKw1gbH0S9sMv1empiHGWRbuAk=; b=p8hZI5g2yxLDWSFmOhjHQCg3Jo
 h0+RaCI6TyhawQRO5zJaBaiX9wQgVhKe6YkQygiw7Xl+KK0bJxa4vvWf4sQ9Fz/k88IRwtSSyMbbO
 BC86cofSIwi4QDSEZ8jzM8bxqt61KY7/FIhkyYcKAFtpzz5JPvBMyqvV7ChgaOJ/LzTA88ob9zOs2
 lzwDd0+6jcd6Al+wZb4RLti0cQ7/re3n3QgWmi/prAuqc2Dg6bfTMslUobd/kFz6JXnQUcFnSSDDa
 rJZpsrLiTqnklo671iZOjx1kBFtt2VGg1c76YpTUge7FM8hUlxXb2H8pqMKjPSTKpmDhgGQDIX/u7
 wGwzayoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jJtm7-0000Ll-7I; Thu, 02 Apr 2020 06:56:27 +0000
Date: Wed, 1 Apr 2020 23:56:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH] iommu/vt-d: add NUMA awareness to intel_alloc_coherent()
Message-ID: <20200402065627.GA23242@infradead.org>
References: <1517438756.3715.108.camel@gmail.com>
 <20180202185301.GA8232@infradead.org>
 <CANn89i+FBn3fttEyU_znAd-+8BgM7VZogFeeZPA7_zubChFpBA@mail.gmail.com>
 <34c70805-44f5-6697-3ebf-2f4d56779454@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34c70805-44f5-6697-3ebf-2f4d56779454@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Benjamin Serebrin <serebrin@google.com>, netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, David Woodhouse <dwmw2@infradead.org>
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

On Wed, Apr 01, 2020 at 03:53:38PM -0700, Eric Dumazet wrote:
> 
> 
> On 2/2/18 10:59 AM, Eric Dumazet wrote:
> > On Fri, Feb 2, 2018 at 10:53 AM, Christoph Hellwig <hch@infradead.org> wrote:
> >> I've got patches pending to replace all that code with
> >> dma_direct_alloc, which will do the right thing.  They were
> >> submitted for 4.16, and I will resend them after -rc1.
> > 
> > I see, thanks Christoph !
> > 
> 
> Hi Christoph 
> 
> It seems 4.16 has shipped ( :) ) , and intel_alloc_coherent() still has no NUMA awareness.

Actually, that code went in and then got reverted again..

> Should I respin https://lore.kernel.org/patchwork/patch/884326/

Maybe.  We are still hoping to convert intel-iommu to the dma-iommu
framework, but I'm not sure how long that is going to take, so maybe
just respin it for now.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
