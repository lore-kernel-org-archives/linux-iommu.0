Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D0CC43334
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 06:30:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38C8B848AB;
	Fri, 24 Jun 2022 06:30:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 38C8B848AB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i9qQhcdk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uiDpMHd1kgqB; Fri, 24 Jun 2022 06:30:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B6C0E848AA;
	Fri, 24 Jun 2022 06:30:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B6C0E848AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80C9EC0039;
	Fri, 24 Jun 2022 06:30:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F56BC002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 06:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0375E40423
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 06:30:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0375E40423
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i9qQhcdk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WSugMOybiOu8 for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 06:30:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 063F74032E
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 063F74032E
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 06:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=eM3nPBUw4PZqEb4da6i4+WfgBSGu0ZhJXRXjJDXCY9o=; b=i9qQhcdkZ9YRwP2xlPKLAlC1kE
 U5oCUS92EsXe4sMJC27RUPI4Jb2Sa1N/9Lny1UbMxaPjFJcwVtohB4yKHOzzN2iVAQZ/uq62Atrq6
 Sk1g9vIZ85uAzLvLlCM7x0W4p6r6AGnUbDBY1EoQ0CoIa1qjZATHx/6PvmNeYDF7oYYYEPMJdurML
 c+unsTDU5AmsUN+FD+NAt4iUFES+NPq27r20RJKcJMKiqRh3rbWg3Ra32s6m32ADTbywqxezpkIhT
 nJ0kDrIUxZKTCEVl8lCQAU9ckiK/HS1FzgOKCjwDjxbiWhZOzAFbf3X7tI2u5+wC5QGUP/XxTplYS
 Nxc6Zz0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1o4cpS-000qZQ-C0; Fri, 24 Jun 2022 06:30:06 +0000
Date: Thu, 23 Jun 2022 23:30:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] MAINTAINERS: Add new IOMMU development mailing list
Message-ID: <YrVZ7g3AKzoI0uMG@infradead.org>
References: <20220622082601.31678-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220622082601.31678-1-joro@8bytes.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
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

On Wed, Jun 22, 2022 at 10:26:01AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The IOMMU mailing list will move from lists.linux-foundation.org to
> lists.linux.dev. The hard switch of the archive will happen on July
> 5th, but add the new list now already so that people start using the
> list when sending patches.

iommu@lists.linux-foundation.org is also listed for various other
MAINTAINERS entries.  Can you please send a list to update all of them
to Linus ASAP, including for 5.19 and -stable?

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
