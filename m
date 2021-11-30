Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEADC433EF
	for <iommu@archiver.kernel.org>; Tue, 30 Nov 2021 21:57:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CE9282786;
	Tue, 30 Nov 2021 21:57:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sDPrJZSatbyw; Tue, 30 Nov 2021 21:57:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6E2D782897;
	Tue, 30 Nov 2021 21:57:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BEDEC001C;
	Tue, 30 Nov 2021 21:57:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 879E6C000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 21:02:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A31560768
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 21:02:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TQWA9LivF0EL for <iommu@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 21:02:46 +0000 (UTC)
X-Greylist: delayed 00:06:13 by SQLgrey-1.8.0
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3C1CA60757
 for <iommu@lists.linux-foundation.org>; Tue, 30 Nov 2021 21:02:46 +0000 (UTC)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
 id 6F085261BA6; Tue, 30 Nov 2021 21:56:31 +0100 (CET)
Date: Tue, 30 Nov 2021 21:56:31 +0100
From: Janne Grunau <j@jannau.net>
To: Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH 0/4] iommu: M1 Pro/Max DART support
Message-ID: <20211130205631.GD28130@jannau.net>
References: <20211117211509.28066-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211117211509.28066-1-sven@svenpeter.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Tue, 30 Nov 2021 21:57:04 +0000
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
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

Hej,

On 2021-11-17 22:15:05 +0100, Sven Peter wrote:
> 
> This is a fairly brief series to add support for the DARTs present in the
> M1 Pro/Max. They have two differences that make them incompatible with
> those in the M1:
> 
>   - the physical addresses are shifted left by 4 bits and and have 2 more
>     bits inside the PTE entries
>   - the subpage protection feature is now mandatory. For Linux we can
>     just configure it to always allow access to the entire page.
> 
> Note that this needs a fix to the core pagetable code. Hector already
> sent a first version separately to the mailing list since the problem
> is (at least in theory) also present on other SoCs using the LPAE format
> with a large physical address space [1].
> 
> Sven
> 
> [1] https://lore.kernel.org/linux-iommu/a2b45243-7e0a-a2ac-4e14-5256a3e7abb4@arm.com/T/#t
> 
> Sven Peter (4):
>   dt-bindings: iommu: dart: add t6000 compatible
>   iommu/io-pgtable: Add DART subpage protection support
>   iommu/io-pgtable: Add DART PTE support for t6000
>   iommu: dart: Support t6000 variant
> 
>  .../devicetree/bindings/iommu/apple,dart.yaml |  4 +-
>  drivers/iommu/apple-dart.c                    | 19 ++++++++-
>  drivers/iommu/io-pgtable-arm.c                | 40 ++++++++++++++++++-
>  include/linux/io-pgtable.h                    |  2 +
>  4 files changed, 61 insertions(+), 4 deletions(-)

Whole series tested on M1 Max. Feel free to add
Tested-by: Janne Grunau <j@jannau.net>

best
Janne
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
