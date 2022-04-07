Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDF4C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 13:22:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 344CB41A1D;
	Thu,  7 Apr 2022 13:22:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nerVIAT5mGf9; Thu,  7 Apr 2022 13:22:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E07C541A1F;
	Thu,  7 Apr 2022 13:22:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8907C002C;
	Thu,  7 Apr 2022 13:22:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8F76C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 06:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F760404AF
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 06:55:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=goldelico.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xQuHXfkwEdrh for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:55:58 +0000 (UTC)
X-Greylist: delayed 00:09:24 by SQLgrey-1.8.0
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.52])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6E7A40133
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 06:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649313836;
 s=strato-dkim-0002; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=H7+9xv89JRCjOioZu+oNk24ZKTOcaRFzOuoirztpIDI=;
 b=VH6VEmwzugb8k2cwHtpWrQIq5pSGRR88jWGOtMu10YOPF4ZgwCH/VYvsXCr5jt21qF
 au9sRD9ReVr1s2wmH9MJTXbW5GSxdmm2abE946vxsFhfXP7R0fHrFN8Wa5huEXFkD/7z
 Tj96+h8yu/WDqH1aU5mJRTjA1Ka/JvpoSq+HG5uXInQSwoMRGbY8bQ+vd/fILHSCFiJC
 WVpE/BiiPxZUYalpfay/LAovg/5QVsqiwzKS0SrL4vjt2tTQJUfbJXT4fuM/PyzU/FTv
 bs2pxCf77FOHlZEy9TJiTZoto1J5ASRxcqDN69QNYAnqE4q0jynW2skx1XAW+jw462Tf
 UJ2g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3i8MRqg=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
 with ESMTPSA id k708cfy376htiMC
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Thu, 7 Apr 2022 08:43:55 +0200 (CEST)
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH] iommu/omap: Fix regression in probe for NULL pointer
 dereference
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <Yk54+S0iaMueWN63@atomide.com>
Date: Thu, 7 Apr 2022 08:43:54 +0200
Message-Id: <F4D607DA-EA0E-4044-B700-546CF764CD4D@goldelico.com>
References: <20220331062301.24269-1-tony@atomide.com>
 <Yk54+S0iaMueWN63@atomide.com>
To: Tony Lindgren <tony@atomide.com>
X-Mailer: Apple Mail (2.3445.104.21)
X-Mailman-Approved-At: Thu, 07 Apr 2022 13:22:06 +0000
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

Hi,

> Am 07.04.2022 um 07:39 schrieb Tony Lindgren <tony@atomide.com>:
> 
> Hi,
> 
> * Tony Lindgren <tony@atomide.com> [220331 09:21]:
>> Commit 3f6634d997db ("iommu: Use right way to retrieve iommu_ops") started
>> triggering a NULL pointer dereference for some omap variants:
>> 
>> __iommu_probe_device from probe_iommu_group+0x2c/0x38
>> probe_iommu_group from bus_for_each_dev+0x74/0xbc
>> bus_for_each_dev from bus_iommu_probe+0x34/0x2e8
>> bus_iommu_probe from bus_set_iommu+0x80/0xc8
>> bus_set_iommu from omap_iommu_init+0x88/0xcc
>> omap_iommu_init from do_one_initcall+0x44/0x24
>> 
>> This is caused by omap iommu probe returning 0 instead of ERR_PTR(-ENODEV)
>> as noted by Jason Gunthorpe <jgg@ziepe.ca>.
>> 
>> Looks like the regression already happened with an earlier commit
>> 6785eb9105e3 ("iommu/omap: Convert to probe/release_device() call-backs")
>> that changed the function return type and missed converting one place.
> 
> Can you guys please get this fix into the -rc series? Or ack it so
> I can pick it up into my fixes branch?
> 
> Without this fix booting is failing for a bunch of devices.

Yes, I can confirm that v5.18-rc1 does not even boot the GTA04 (omap3)
and OMAP5UEVM to any activity without this patch.

Seems to be an urgent fix.

BR and thanks,
Nikolaus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
