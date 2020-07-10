Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85729C433E5
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 12:31:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382BA20772
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 12:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382BA20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 022388993C;
	Fri, 10 Jul 2020 12:31:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qL-0DaOiegVB; Fri, 10 Jul 2020 12:31:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 476288993B;
	Fri, 10 Jul 2020 12:31:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B991C077B;
	Fri, 10 Jul 2020 12:31:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E3E0C016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 12:31:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4732789C4F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 12:31:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gFfAHBC3NLAq for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 12:31:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E881B88A83
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 12:31:06 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 83BE420C; Fri, 10 Jul 2020 14:31:03 +0200 (CEST)
Date: Fri, 10 Jul 2020 14:31:00 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sebastian Ott <sebott@amazon.de>
Subject: Re: [PATCH v2 0/3] iommu/amd: I/O VA address limits
Message-ID: <20200710123059.GF27672@8bytes.org>
References: <20200630093039.GC28824@8bytes.org>
 <20200630224634.319-1-sebott@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200630224634.319-1-sebott@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Benjamin Serebrin <serebrin@amazon.com>, Filippo Sironi <sironi@amazon.de>,
 iommu@lists.linux-foundation.org
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

Hi Sebastian,

On Wed, Jul 01, 2020 at 12:46:31AM +0200, Sebastian Ott wrote:
> The IVRS ACPI table specifies maximum address sizes for I/O virtual
> addresses that can be handled by the IOMMUs in the system. Parse that
> data from the IVRS header to provide aperture information for DMA
> mappings and users of the iommu API.
> 
> Changes for V2:
>  - use limits in iommu_setup_dma_ops()
>  - rebased to current upstream
> 
> Sebastian Ott (3):
>   iommu/amd: Parse supported address sizes from IVRS
>   iommu/amd: Restrict aperture for domains to conform with IVRS
>   iommu/amd: Actually enforce geometry aperture

Thanks for the changes. May I ask what the reason for those changes are?
AFAIK all AMD IOMMU implementations (in hardware) support full 64bit
address spaces, and the IVRS table might actually be wrong, limiting the
address space in the worst case to only 32 bit.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
