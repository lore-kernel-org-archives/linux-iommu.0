Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F972C433EF
	for <iommu@archiver.kernel.org>; Fri, 20 May 2022 07:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4232460AA3;
	Fri, 20 May 2022 07:57:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MXVXOqLxY3wX; Fri, 20 May 2022 07:57:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 179BD60797;
	Fri, 20 May 2022 07:57:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E007AC0039;
	Fri, 20 May 2022 07:57:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BDCCC002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 07:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0403E842ED
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 07:57:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wTsJmDmvR7cq for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 07:57:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 700E7842CD
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 07:57:48 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 66298820; Fri, 20 May 2022 09:57:45 +0200 (CEST)
Date: Fri, 20 May 2022 09:57:44 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH] iommu/s390: tolerate repeat attach_dev calls
Message-ID: <YodJ+OwxsP5PPO3V@8bytes.org>
References: <20220519182929.581898-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220519182929.581898-1-mjrosato@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, kvm@vger.kernel.org,
 schnelle@linux.ibm.com, cohuck@redhat.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, alex.williamson@redhat.com, jgg@nvidia.com,
 gerald.schaefer@linux.ibm.com, borntraeger@linux.ibm.com, will@kernel.org
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

On Thu, May 19, 2022 at 02:29:29PM -0400, Matthew Rosato wrote:
> Since commit 0286300e6045 ("iommu: iommu_group_claim_dma_owner() must
> always assign a domain") s390-iommu will get called to allocate multiple
> unmanaged iommu domains for a vfio-pci device -- however the current
> s390-iommu logic tolerates only one.  Recognize that multiple domains can
> be allocated and handle switching between DMA or different iommu domain
> tables during attach_dev.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  drivers/iommu/s390-iommu.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Applied to the vfio-notifier-fix topic branch, thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
