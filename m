Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B76C433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 09:02:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9767284355;
	Tue, 22 Mar 2022 09:02:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N1wZ4W-bw5_I; Tue, 22 Mar 2022 09:02:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 77CBF84349;
	Tue, 22 Mar 2022 09:02:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 168B8C001A;
	Tue, 22 Mar 2022 09:02:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 274BBC000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 09:02:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F1F2E41762
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 09:02:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YsU2jVJmMrkJ for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 09:02:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 650BF41760
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 09:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=5+Lip+vSIUKtuIuzX9cI5mo/X5+lo2z7ecTSReE/c+U=; b=1p53Jd215lw9+Vfo3GycLOHLfe
 U73gr9/kUGPzYTV2ryQt6fvk4N7bit35T/3aAxeqnPzDVfo2u1si0l9whgww0ObY+G0KumaL/QRIF
 oYnQ9EsOEnOEBjWFAl1wmK59jbvvQRe+swwi9eBT5EUPCNZ6tq2C9sA9m4JlvVwMPbqeW45sizA2f
 66AaVjCWQHlJhU2QW7acl2Ie/H6T6Oy1AnqG7f7kQUD2AS+peHM7zTbzcnyIYYcMMsHrRRjx97rJT
 QhZMiVR9kLspsZxffQPhMRLOt5+MiX/HewPa/0e2401/9R7W3K8FbBPyXHdZKt9PK0feFg9+04lDz
 q0dV0unA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nWaPT-00AW9u-VP; Tue, 22 Mar 2022 09:02:35 +0000
Date: Tue, 22 Mar 2022 02:02:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4 1/2] PCI: Rename "pci_dev->untrusted" to
 "pci_dev->poses_dma_risk"
Message-ID: <YjmQq1DvWnJwUh6R@infradead.org>
References: <20220320062907.3272903-1-rajatja@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220320062907.3272903-1-rajatja@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rajat Jain <rajatxjain@gmail.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Pavel Machek <pavel@denx.de>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Oliver O'Halloran <oohall@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Jesse Barnes <jsbarnes@google.com>, Dmitry Torokhov <dtor@google.com>,
 Len Brown <lenb@kernel.org>
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

On Sat, Mar 19, 2022 at 11:29:05PM -0700, Rajat Jain wrote:
> Rename the field to make it more clear, that the device can execute DMA
> attacks on the system, and thus the system may need protection from
> such attacks from this device.
> 
> No functional change intended.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v4: Initial version, created based on comments on other patch

What a horrible name.  Why not untrusted_dma which captures the
intent much better?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
