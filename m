Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364D9C433FE
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 01:21:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A1D4940539;
	Tue,  7 Dec 2021 01:21:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rckAs5O8qTtO; Tue,  7 Dec 2021 01:21:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5E3654014C;
	Tue,  7 Dec 2021 01:21:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F4D8C002F;
	Tue,  7 Dec 2021 01:21:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0F63C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 01:21:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E460740524
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 01:21:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L1GjLw2g__ln for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 01:21:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 949824014C
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 01:21:46 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="237392955"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; d="scan'208";a="237392955"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2021 17:21:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; d="scan'208";a="515020741"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 06 Dec 2021 17:21:38 -0800
Subject: Re: [PATCH v3 03/18] driver core: platform: Rename
 platform_dma_configure()
To: Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
 <20211206015903.88687-4-baolu.lu@linux.intel.com>
 <Ya3BYxrgkNK3kbGI@kroah.com> <Ya4abbx5M31LYd3N@infradead.org>
 <20211206144535.GB4670@nvidia.com> <Ya4ikRpenoQPXfML@infradead.org>
 <20211206150415.GD4670@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <33f088b2-19c6-c8fe-38f6-f3016ff13f26@linux.intel.com>
Date: Tue, 7 Dec 2021 09:21:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211206150415.GD4670@nvidia.com>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
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

On 12/6/21 11:04 PM, Jason Gunthorpe wrote:
> On Mon, Dec 06, 2021 at 06:47:45AM -0800, Christoph Hellwig wrote:
>> On Mon, Dec 06, 2021 at 10:45:35AM -0400, Jason Gunthorpe via iommu wrote:
>>> IIRC the only thing this function does is touch ACPI and OF stuff?
>>> Isn't that firmware?
>>>
>>> AFAICT amba uses this because AMBA devices might be linked to DT
>>> descriptions?
>> But DT descriptions aren't firmware.  They are usually either passed onb
>> the bootloader or in some deeply embedded setups embedded into the
>> kernel image.
> Pedenatically yes, but do you know of a common word to refer to both
> OF and ACPI that is better than firmware?:)

If the firmware_ name is confusing, how about common_dma_configure()?
Or, copy the 6 lines of code to amba bus driver?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
