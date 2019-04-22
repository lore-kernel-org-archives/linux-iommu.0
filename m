Return-Path: <SRS0=kOFq=SY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C60C10F11
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 16:47:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9952C214AE
	for <iommu@archiver.kernel.org>; Mon, 22 Apr 2019 16:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9952C214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 44F7EA95;
	Mon, 22 Apr 2019 16:47:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 43DC57F6
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 16:47:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E30E6829
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Apr 2019 16:47:35 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 29FD568AFE; Mon, 22 Apr 2019 18:47:21 +0200 (CEST)
Date: Mon, 22 Apr 2019 18:47:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 07/10] iommu/vt-d: Keep swiotlb on if bounce page is
	necessary
Message-ID: <20190422164720.GB31181@lst.de>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
	<20190421011719.14909-8-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190421011719.14909-8-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: kevin.tian@intel.com, mika.westerberg@linux.intel.com, ashok.raj@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	alan.cox@intel.com, Mika Westerberg <mika.westerberg@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	pengfei.xu@intel.com, jacob.jun.pan@intel.com,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190422164720.F0VZff2buHZuFlHdOPH6PQi8kLDN0phZS7BDFgQJkgk@z>

On Sun, Apr 21, 2019 at 09:17:16AM +0800, Lu Baolu wrote:
> +static inline bool platform_has_untrusted_device(void)
>  {
> +	bool has_untrusted_device = false;
>  	struct pci_dev *pdev = NULL;
>  
>  	for_each_pci_dev(pdev) {
>  		if (pdev->untrusted) {
> +			has_untrusted_device = true;
>  			break;
>  		}
>  	}
>  
> +	return has_untrusted_device;

This shouldn't really be in the intel-iommu driver, should it?
This probably should be something like pci_has_untrusted_devices
and be moved to the PCI code.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
