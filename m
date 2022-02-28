Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB50BC433F5
	for <iommu@archiver.kernel.org>; Mon, 28 Feb 2022 01:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7815F82B08;
	Mon, 28 Feb 2022 01:00:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fqiNF6Csbp5d; Mon, 28 Feb 2022 01:00:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4C07D82B1A;
	Mon, 28 Feb 2022 01:00:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19186C0077;
	Mon, 28 Feb 2022 01:00:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6771C001A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 01:00:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 90A3240929
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 01:00:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q_IMC8Au6gfq for <iommu@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 01:00:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC7074091F
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 01:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646010041; x=1677546041;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5ATRL4rQ1IyZjNEW/fMNHknvLJWziKwt7KwEQHMNLqg=;
 b=Pb29J0F0u4X1f7W9oXBVQ/4hk/fHzPDW4K9w8ZJ7iN/z1wFlbkiNDLsf
 M+AIsO24VEngASbwKnX1XjsB8t8Ak9iAVR338sAWt4HsyR5wignG1LK0b
 9mg97WiRpZ+a5q429t73nXOUDAr0ZO+jNyYdPO5opi30pcSdMAbCUhHBm
 CNMH0JTNpl0f/9m4QzI4Pgn8gDh5O0x/zPgxf5owXrpaSifOPlBRoMPce
 KUOa6gsC8nxjLTDGssM1ZuX+duinmHF975nR0oeRdXjjWKwzLCW06YZAe
 IB3f0LnjkGo0YIHbfdaambiF6sA+0JnObTD9QOyKrumX0cunhokEIXuRB A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="250355478"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; d="scan'208";a="250355478"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2022 17:00:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; d="scan'208";a="534251537"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 27 Feb 2022 17:00:30 -0800
Message-ID: <f78b3bce-513a-a14c-d12e-1a328d5ddc87@linux.intel.com>
Date: Mon, 28 Feb 2022 08:58:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson
 <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220218005521.172832-1-baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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

On 2/18/22 8:55 AM, Lu Baolu wrote:
> v6:
>    - Refine comments and commit mesages.
>    - Rename iommu_group_set_dma_owner() to iommu_group_claim_dma_owner().
>    - Rename iommu_device_use/unuse_kernel_dma() to
>      iommu_device_use/unuse_default_domain().
>    - Remove unnecessary EXPORT_SYMBOL_GPL.
>    - Change flag name from no_kernel_api_dma to driver_managed_dma.
>    - Merge 4 "Add driver dma ownership management" patches into single
>      one.

Thanks you very much for review and comments. A new version (v7) has
been posted.

https://lore.kernel.org/linux-iommu/20220228005056.599595-1-baolu.lu@linux.intel.com/

If I missed anything there, please let me know.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
