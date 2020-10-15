Return-Path: <SRS0=+Hy+=DW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A08AC433E7
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 11:17:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A4A62076D
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 11:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4A62076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B4E878829F;
	Thu, 15 Oct 2020 11:17:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RgujDtqJak82; Thu, 15 Oct 2020 11:17:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A630188266;
	Thu, 15 Oct 2020 11:17:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96A58C0052;
	Thu, 15 Oct 2020 11:17:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E6A5C0051
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 11:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4BC842E62A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 11:17:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ea4SBkABOWpd for <iommu@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 11:17:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 870D82E629
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 11:17:21 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 26C4ADE1; Thu, 15 Oct 2020 13:17:18 +0200 (CEST)
Date: Thu, 15 Oct 2020 13:17:12 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] IOMMU Updates for Linux v5.10
Message-ID: <20201015111711.GC3635@8bytes.org>
References: <20201013160353.GA19438@8bytes.org>
 <CAHk-=wirdKHYK_T=Pdx7eLP7z04P_q4zrT3uOod=dCWtmYPe8g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wirdKHYK_T=Pdx7eLP7z04P_q4zrT3uOod=dCWtmYPe8g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu <iommu@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Oct 14, 2020 at 12:15:55PM -0700, Linus Torvalds wrote:
> As a result, "git show" doesn't ever really understand the notion of a
> "merge conflict", and all it shows is really "whee, this end result
> looks like neither side" as a kind of pseudo-conflict diff.

Ah okay, that makes sense. Thanks for the explanation.

> Anyway, thanks for the describing the conflict, it was indeed not
> complicated, this email is just to explain your "but somehow git
> [show|log] didn't show it to me" thing.

Yeah, next time I try to get the diff before commiting the merge, that
probably works better. A diff is better than describing conflict
resolutions verbally.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
