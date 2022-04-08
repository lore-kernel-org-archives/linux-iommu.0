Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A867C433F5
	for <iommu@archiver.kernel.org>; Fri,  8 Apr 2022 08:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED56F8434F;
	Fri,  8 Apr 2022 08:25:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X872F0pusAmh; Fri,  8 Apr 2022 08:25:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DECBC8434E;
	Fri,  8 Apr 2022 08:25:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C07E2C0033;
	Fri,  8 Apr 2022 08:25:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C198C002C
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 08:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 784418434F
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 08:25:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PM-VbdTpReQW for <iommu@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 08:25:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E75C68434E
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 08:25:34 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 59F172E3; Fri,  8 Apr 2022 10:25:32 +0200 (CEST)
Date: Fri, 8 Apr 2022 10:25:31 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] iommu/omap: Fix regression in probe for NULL pointer
 dereference
Message-ID: <Yk/xe3Wq34V/0AJf@8bytes.org>
References: <20220331062301.24269-1-tony@atomide.com>
 <Yk54+S0iaMueWN63@atomide.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yk54+S0iaMueWN63@atomide.com>
Cc: linux-omap@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Thu, Apr 07, 2022 at 08:39:05AM +0300, Tony Lindgren wrote:
> Can you guys please get this fix into the -rc series? Or ack it so
> I can pick it up into my fixes branch?

Sorry for the delay, Covid catched me so I was away from email for
almost 2 week. This patch is picked-up now and I will send it upstream
for -rc2.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
