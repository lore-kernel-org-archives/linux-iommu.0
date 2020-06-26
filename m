Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA20C433E1
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 20:56:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F84E2088E
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 20:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F84E2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4822F87B39;
	Fri, 26 Jun 2020 20:56:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mVUbuhmTyKUJ; Fri, 26 Jun 2020 20:56:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C122387AFF;
	Fri, 26 Jun 2020 20:56:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9342EC0895;
	Fri, 26 Jun 2020 20:56:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65BE2C016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 20:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4990586D82
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 20:54:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S7yTJUluwdgW for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 20:54:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from smtp4.emailarray.com (smtp4.emailarray.com [65.39.216.22])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 712EF86BDC
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 20:54:17 +0000 (UTC)
Received: (qmail 99814 invoked by uid 89); 26 Jun 2020 20:54:15 -0000
Received: from unknown (HELO localhost)
 (amxlbW9uQGZsdWdzdmFtcC5jb21AMTYzLjExNC4xMzIuMw==) (POLARISLOCAL) 
 by smtp4.emailarray.com with SMTP; 26 Jun 2020 20:54:15 -0000
Date: Fri, 26 Jun 2020 13:54:12 -0700
From: Jonathan Lemon <jonathan.lemon@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: the XSK buffer pool needs be to reverted
Message-ID: <20200626205412.xfe4lywdbmh3kmri@bsd-mbp>
References: <20200626074725.GA21790@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200626074725.GA21790@lst.de>
X-Mailman-Approved-At: Fri, 26 Jun 2020 20:56:36 +0000
Cc: netdev@vger.kernel.org, iommu@lists.linux-foundation.org,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
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

On Fri, Jun 26, 2020 at 09:47:25AM +0200, Christoph Hellwig wrote:
>
> Note that this is somewhat urgent, as various of the APIs that the code
> is abusing are slated to go away for Linux 5.9, so this addition comes
> at a really bad time.

Could you elaborate on what is upcoming here?


Also, on a semi-related note, are there limitations on how many pages
can be left mapped by the iommu?  Some of the page pool work involves
leaving the pages mapped instead of constantly mapping/unmapping them.

On a heavily loaded box with iommu enabled, it seems that quite often
there is contention on the iova_lock.  Are there known issues in this
area?
-- 
Jonathan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
