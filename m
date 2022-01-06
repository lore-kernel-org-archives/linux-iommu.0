Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245CAC433F5
	for <iommu@archiver.kernel.org>; Thu,  6 Jan 2022 03:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AF0694093F;
	Thu,  6 Jan 2022 03:44:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IQVtLIVPbdBC; Thu,  6 Jan 2022 03:44:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3CC404091A;
	Thu,  6 Jan 2022 03:44:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F892C002F;
	Thu,  6 Jan 2022 03:44:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E17DC001E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 03:44:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 43C46428E6
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 03:44:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fILlKiPcR4qt for <iommu@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 03:44:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8EBB0428E4
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 03:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641440651; x=1672976651;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=izTXx3R6T91KwPw+mhLreSSPy1JtAl4lGGpkT1QKBWE=;
 b=EGzFvJZKZ53/2mUyn37cDQ3cAf5jbhD7cvZTygyjDPsXoRtiyfKFHZMT
 TG8niEaEfIB8qoybR2u0ZaBfXFpLoXrcCGQrSmkPB9MKnjBa4HAuxuuPC
 NiB9/1iqnHQCnk0A4EktWoT+wiE2N7z7Pg1QFPTOrApoQnHn1G56fbc/v
 jJiCJ/s8nJFhTt2cTAoYvO61QW7c96L2zuKZRFElj5L1IKTsn1JDDr5iB
 5dzIo4OxCJGtjItvvcotpksn69StbOeTarN2BHMDFSbQJHdM1MdlKiGGH
 tjeUo/48AIbfx4lL79YPSIcz4HgqQocM6y/P1hdreLQadRGgNXbCRW4L4 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242539649"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="242539649"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2022 19:44:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; d="scan'208";a="526814111"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Jan 2022 19:44:03 -0800
Subject: Re: [PATCH v5 01/14] iommu: Add dma ownership management interfaces
To: Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@infradead.org>
References: <20220104164100.GA101735@bhelgaas>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5a2fdbe2-da57-eac4-f115-c5f434080b36@linux.intel.com>
Date: Thu, 6 Jan 2022 11:43:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104164100.GA101735@bhelgaas>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Bjorn,

On 1/5/22 12:41 AM, Bjorn Helgaas wrote:
>>> This adds dma ownership management in iommu core and exposes several
>>> interfaces for the device drivers and the device userspace assignment
>>> framework (i.e. vfio), so that any conflict between user and kernel
>>> controlled DMA could be detected at the beginning.
> Maybe I'm missing the point because I don't know what "conflict
> between user and kernel controlled DMA" is.  Are you talking about
> both userspace and the kernel programming the same device to do DMA?

It's about both userspace and kernel programming different devices
belonging to a same iommu group to do DMA. For example, PCI device A and
B sit in a some iommu group. Userspace programs device A for DMA and a
kernel driver programs device B. Userspace may intentionally or
unintentionally program device A to access and change device B's MMIO
with P2P DMA transactions which cause the kernel driver for device B
result in an inconsistent state.

This may not be all, just an example.

Best regards,
baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
