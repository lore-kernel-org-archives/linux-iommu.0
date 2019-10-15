Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2180BECE58F
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 11:35:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A4421848
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 11:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A4421848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C36DECA4;
	Tue, 15 Oct 2019 11:35:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F357AC97
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 11:35:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 83F0E6C5
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 11:35:39 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 878EF2D9; Tue, 15 Oct 2019 13:35:37 +0200 (CEST)
Date: Tue, 15 Oct 2019 13:35:36 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 0/4] User API for nested shared virtual address (SVA)
Message-ID: <20191015113536.GI14518@8bytes.org>
References: <1570045363-24856-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1570045363-24856-1-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Jonathan Cameron <jic23@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed, Oct 02, 2019 at 12:42:39PM -0700, Jacob Pan wrote:
> Jacob Pan (2):
>   iommu/ioasid: Add custom allocators
>   iommu: Introduce guest PASID bind function
> 
> Jean-Philippe Brucker (1):
>   iommu: Add I/O ASID allocator
> 
> Yi L Liu (1):
>   iommu: Introduce cache_invalidate API
> 
>  drivers/iommu/Kconfig      |   4 +
>  drivers/iommu/Makefile     |   1 +
>  drivers/iommu/ioasid.c     | 422 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/iommu.c      |  30 ++++
>  include/linux/ioasid.h     |  76 ++++++++
>  include/linux/iommu.h      |  36 ++++
>  include/uapi/linux/iommu.h | 169 ++++++++++++++++++
>  7 files changed, 738 insertions(+)
>  create mode 100644 drivers/iommu/ioasid.c
>  create mode 100644 include/linux/ioasid.h

Applied for v5.5, thanks everyone who worked on this!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
