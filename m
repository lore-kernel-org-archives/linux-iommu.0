Return-Path: <SRS0=DRkM=JE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA178C433B4
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 10:01:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1F46135D
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 10:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1F46135D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB39940E82;
	Wed,  7 Apr 2021 10:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JGEaqp41joJs; Wed,  7 Apr 2021 10:01:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 947B140E78;
	Wed,  7 Apr 2021 10:01:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6314CC000C;
	Wed,  7 Apr 2021 10:01:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE881C000A
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 10:01:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C6EA405BD
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 10:01:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id er1bhdKh1S5K for <iommu@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 10:01:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0BF5C405C1
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 10:01:12 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 3C04A2A6; Wed,  7 Apr 2021 12:01:09 +0200 (CEST)
Date: Wed, 7 Apr 2021 12:01:07 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] iommu/amd: page-specific invalidations for more than one
 page
Message-ID: <YG2C42UdIEsWex2L@8bytes.org>
References: <20210323210619.513069-1-namit@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210323210619.513069-1-namit@vmware.com>
Cc: Nadav Amit <namit@vmware.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, Jiajun Cao <caojiajun@vmware.com>,
 linux-kernel@vger.kernel.org
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

On Tue, Mar 23, 2021 at 02:06:19PM -0700, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Currently, IOMMU invalidations and device-IOTLB invalidations using
> AMD IOMMU fall back to full address-space invalidation if more than a
> single page need to be flushed.
> 
> Full flushes are especially inefficient when the IOMMU is virtualized by
> a hypervisor, since it requires the hypervisor to synchronize the entire
> address-space.
> 
> AMD IOMMUs allow to provide a mask to perform page-specific
> invalidations for multiple pages that match the address. The mask is
> encoded as part of the address, and the first zero bit in the address
> (in bits [51:12]) indicates the mask size.
> 
> Use this hardware feature to perform selective IOMMU and IOTLB flushes.
> Combine the logic between both for better code reuse.
> 
> The IOMMU invalidations passed a smoke-test. The device IOTLB
> invalidations are untested.

Have you thoroughly tested this on real hardware? I had a patch-set
doing the same many years ago and it lead to data corruption under load.
Back then it could have been a bug in my code of course, but it made me
cautious about using targeted invalidations.

Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
