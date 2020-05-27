Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABFEC433DF
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 12:36:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C46B20873
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 12:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C46B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 02A88204DD;
	Wed, 27 May 2020 12:36:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q4a8l3YZfHRX; Wed, 27 May 2020 12:36:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 600D1203CA;
	Wed, 27 May 2020 12:36:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 375AAC0881;
	Wed, 27 May 2020 12:36:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFCDFC016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 12:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B5591204DD
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 12:36:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SwlPblqFVlhS for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 12:36:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 57F08203CA
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 12:36:27 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 78345247; Wed, 27 May 2020 14:36:24 +0200 (CEST)
Date: Wed, 27 May 2020 14:36:22 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 0/4] PCI, iommu: Factor 'untrusted' check for ATS
 enablement
Message-ID: <20200527123622.GI5221@8bytes.org>
References: <20200520152201.3309416-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200520152201.3309416-1-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alex.williamson@redhat.com, ashok.raj@intel.com, linux-pci@vger.kernel.org,
 robin.murphy@arm.com, hch@infradead.org, iommu@lists.linux-foundation.org,
 bhelgaas@google.com, will@kernel.org, dwmw2@infradead.org,
 linux-arm-kernel@lists.infradead.org
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

On Wed, May 20, 2020 at 05:21:59PM +0200, Jean-Philippe Brucker wrote:
> IOMMU drivers currently check themselves if a device is untrusted
> (plugged into an external-facing port) before enabling ATS. Move the
> check to drivers/pci. The only functional change should be to the AMD
> IOMMU driver. With this change all IOMMU drivers block 'Translated' PCIe
> transactions and Translation Requests from untrusted devices.
> 
> Since v1 [1] I added tags, addressed comments on patches 1 and 3, and
> fixed a regression in patch 3.
> 
> [1] https://lore.kernel.org/linux-iommu/20200515104359.1178606-1-jean-philippe@linaro.org/
> 
> Jean-Philippe Brucker (4):
>   PCI/ATS: Only enable ATS for trusted devices
>   iommu/amd: Use pci_ats_supported()
>   iommu/arm-smmu-v3: Use pci_ats_supported()
>   iommu/vt-d: Use pci_ats_supported()
> 
>  include/linux/pci-ats.h     |  3 +++
>  drivers/iommu/amd_iommu.c   | 12 ++++--------
>  drivers/iommu/arm-smmu-v3.c | 20 +++++++-------------
>  drivers/iommu/intel-iommu.c |  9 +++------
>  drivers/pci/ats.c           | 18 +++++++++++++++++-
>  5 files changed, 34 insertions(+), 28 deletions(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
