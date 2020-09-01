Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C1AC433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 15:23:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 252D0207D3
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 15:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UvqMRf/V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QlglmDYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252D0207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F07D286B2B;
	Tue,  1 Sep 2020 15:23:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wL9TMuixdL6U; Tue,  1 Sep 2020 15:23:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6DB4886AEC;
	Tue,  1 Sep 2020 15:23:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61924C07FF;
	Tue,  1 Sep 2020 15:23:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2560DC0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 15:23:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1328486FB5
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 15:23:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d-iPw3xSoE32 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:23:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com
 [66.63.167.143])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3E0A886FAA
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 15:23:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0E0068EE187;
 Tue,  1 Sep 2020 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
 s=20151216; t=1598973779;
 bh=oM6M8l0ba8Kwr86wVvWOr0ibc9GeoVF02RI3gdpRvZg=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=UvqMRf/V4bYGUnXRFYzHR0MoWszTvt72MUDJlkPgLVL7Z5C9ghIwUJJ5HYM5kfJ3n
 5VYFPt986TvN+zbqjMT6pkl+t9bvzRZjP81gXVEMiUig/anUDkmm0cM9tI1gLXtLCF
 UIwKWRUmpM4JixpLzQm9dVgj9tnlX6pm+UJWHqoc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id U-JPs2CIcW43; Tue,  1 Sep 2020 08:22:58 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net
 [73.35.198.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8B8B18EE0F5;
 Tue,  1 Sep 2020 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
 s=20151216; t=1598973778;
 bh=oM6M8l0ba8Kwr86wVvWOr0ibc9GeoVF02RI3gdpRvZg=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=QlglmDYfmn+LUmPHNl9G1vxZ4WANgTGEDBcv3VoTq5jkCobGzHRwV7MDXP/8CkPRF
 DlnAvyJzmngr5D0/wC86DqyXRPVdp/OwUQc4zsVd3Mrk54apOxtDVbGKnBnOuqrFqS
 /e8+ps58Vp9230FkQlqzYQQbltdvuVP33ee7Vxcw=
Message-ID: <1598973776.4238.11.camel@HansenPartnership.com>
Subject: Re: [PATCH 07/28] 53c700: improve non-coherent DMA handling
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Matthew Wilcox <willy@infradead.org>
Date: Tue, 01 Sep 2020 08:22:56 -0700
In-Reply-To: <20200901150554.GN14765@casper.infradead.org>
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-8-hch@lst.de>
 <1598971960.4238.5.camel@HansenPartnership.com>
 <20200901150554.GN14765@casper.infradead.org>
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
 linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>,
 linux-scsi@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>,
 Ben Skeggs <bskeggs@redhat.com>, Matt Porter <mporter@kernel.crashing.org>,
 linux-media@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 Pawel Osciak <pawel@osciak.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org
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

On Tue, 2020-09-01 at 16:05 +0100, Matthew Wilcox wrote:
> On Tue, Sep 01, 2020 at 07:52:40AM -0700, James Bottomley wrote:
> > I think this looks mostly OK, except for one misnamed parameter
> > below. Unfortunately, the last non-coherent parisc was the 700
> > series and I no longer own a box, so I can't test that part of it
> > (I can fire up the C360 to test it on a coherent arch).
> 
> I have a 715/50 that probably hasn't been powered on in 15 years if
> you need something that old to test on (I believe the 725/100 uses
> the 7100LC and so is coherent).  I'll need to set up a cross-compiler 
> ...

I'm not going to say no to actual testing, but it's going to be a world
of pain getting something so old going.  I do have a box of older
systems I keep for architectural testing that I need to rummage around
in ... I just have a vague memory that my 715 actually caught fire a
decade ago and had to be disposed of.

James

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
