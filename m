Return-Path: <SRS0=BH3E=XF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F259C49ED8
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 14:53:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E41A2168B
	for <iommu@archiver.kernel.org>; Tue, 10 Sep 2019 14:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E41A2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E6851BBC;
	Tue, 10 Sep 2019 14:53:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3C66F481
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 14:53:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C1D9B8A2
	for <iommu@lists.linux-foundation.org>;
	Tue, 10 Sep 2019 14:53:26 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 04377BDE; Tue, 10 Sep 2019 16:53:24 +0200 (CEST)
Date: Tue, 10 Sep 2019 16:53:23 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v9 0/5] iommu: Bounce page for untrusted devices
Message-ID: <20190910145322.GB24103@8bytes.org>
References: <20190906061452.30791-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190906061452.30791-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Juergen Gross <jgross@suse.com>, kevin.tian@intel.com,
	Stefano Stabellini <sstabellini@kernel.org>,
	mika.westerberg@linux.intel.com, ashok.raj@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	alan.cox@intel.com, Jonathan Corbet <corbet@lwn.net>,
	Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	pengfei.xu@intel.com, Ingo Molnar <mingo@redhat.com>,
	jacob.jun.pan@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
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

On Fri, Sep 06, 2019 at 02:14:47PM +0800, Lu Baolu wrote:
> Lu Baolu (5):
>   swiotlb: Split size parameter to map/unmap APIs
>   iommu/vt-d: Check whether device requires bounce buffer
>   iommu/vt-d: Don't switch off swiotlb if bounce page is used
>   iommu/vt-d: Add trace events for device dma map/unmap
>   iommu/vt-d: Use bounce buffer for untrusted devices
> 
>  .../admin-guide/kernel-parameters.txt         |   5 +
>  drivers/iommu/Kconfig                         |   1 +
>  drivers/iommu/Makefile                        |   1 +
>  drivers/iommu/intel-iommu.c                   | 310 +++++++++++++++++-
>  drivers/iommu/intel-trace.c                   |  14 +
>  drivers/xen/swiotlb-xen.c                     |   8 +-
>  include/linux/swiotlb.h                       |   8 +-
>  include/trace/events/intel_iommu.h            | 106 ++++++
>  kernel/dma/direct.c                           |   2 +-
>  kernel/dma/swiotlb.c                          |  30 +-
>  10 files changed, 449 insertions(+), 36 deletions(-)
>  create mode 100644 drivers/iommu/intel-trace.c
>  create mode 100644 include/trace/events/intel_iommu.h

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
