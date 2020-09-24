Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63664C4346E
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 09:09:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6263206FB
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 09:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6263206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7AEB886A10;
	Thu, 24 Sep 2020 09:09:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1z0yQSVWSlLU; Thu, 24 Sep 2020 09:09:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1E4A6869F4;
	Thu, 24 Sep 2020 09:09:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01A99C0889;
	Thu, 24 Sep 2020 09:09:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 740F8C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 09:09:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4CAA127E4C
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 09:09:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gfDovfFuy85q for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 09:09:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id A82682045D
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 09:09:00 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id C04143D1; Thu, 24 Sep 2020 11:08:58 +0200 (CEST)
Date: Thu, 24 Sep 2020 11:08:57 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] Revert "iommu/amd: Treat per-device exclusion ranges as
 r/w unity-mapped regions"
Message-ID: <20200924090857.GG27174@8bytes.org>
References: <20200923022655.750-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200923022655.750-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, ahuang12@lenovo.com,
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

On Wed, Sep 23, 2020 at 10:26:55AM +0800, Baoquan He wrote:
> A regression failure of kdump kernel boot was reported on a HPE system.
> Bisect points at commit 387caf0b759ac43 ("iommu/amd: Treat per-device
> exclusion ranges as r/w unity-mapped regions") as criminal. Reverting it
> fix the failure.
> 
> With the commit, kdump kernel will always print below error message, then
> naturally AMD iommu can't function normally during kdump kernel bootup.
> 
>   ~~~~~~~~~
>   AMD-Vi: [Firmware Bug]: IVRS invalid checksum
> 
> Why commit 387caf0b759ac43 causing it haven't been made clear.

I think this should be debugged further, in future IOMMUs the exclusion
range feature will not be available anymore (mmio-fields get re-used for
SNP). So starting to use them again is not going to work.

Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
