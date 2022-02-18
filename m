Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CA9C433EF
	for <iommu@archiver.kernel.org>; Fri, 18 Feb 2022 02:30:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81E138141C;
	Fri, 18 Feb 2022 02:30:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Inglh-OO3Ihl; Fri, 18 Feb 2022 02:30:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 83E2B8402B;
	Fri, 18 Feb 2022 02:30:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 260F1C0011;
	Fri, 18 Feb 2022 02:30:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A0DDC000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 02:30:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 181A383FF2
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 02:30:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 983dPB4Zvo10 for <iommu@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 02:30:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CFF7283FEA
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 02:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645151432; x=1676687432;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=W/lLmC9Ydf9L1mo7yCL/PULM6j/JCrlXT96rJzTiRH8=;
 b=J2ZTcQV1YUcl+GROXPzchVCEOTlzkbuqSNCCq/URs0L30mpY8Dg8JE3D
 SzYm58ku9fVQtO5/HKjpRkU701pgvlkbBvjsCs7BL5yYXuuUSpw+ujkG8
 p2/bm1mmjyRogAttBNgcQSWLapZd7ddJIa9FjwfAUApSnnm049kkUhNZT
 FZMz7LawcWC16Zkg9OsjSSRJ3FAkqSIn0J4TDw3Iawh+JusVIGMNPLaGs
 H2bPvRC/D41YzJJuFjAUGQ6/D3B0P6OshnkEd8U6IsBYg/XsSDnmZHj6R
 wpWUQMuoNPh+1UccShVot2bmjNirY2Tstt616uUDppbOFkg2C+ZURK/7N g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="238437937"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; d="scan'208";a="238437937"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2022 18:30:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; d="scan'208";a="682305963"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 17 Feb 2022 18:30:28 -0800
Message-ID: <989cf124-13d7-5601-a942-e515c81a72a9@linux.intel.com>
Date: Fri, 18 Feb 2022 10:29:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Fix list_add double add when enabling
 VMD and scalable mode
Content-Language: en-US
To: Adrian Huang <adrianhuang0701@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
References: <20220216091307.703-1-adrianhuang0701@gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220216091307.703-1-adrianhuang0701@gmail.com>
Cc: Kevin Tian <kevin.tian@intel.com>, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, Adrian Huang <ahuang12@lenovo.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 Nirmal Patel <nirmal.patel@linux.intel.com>
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

On 2/16/22 5:13 PM, Adrian Huang wrote:
> pci_real_dma_dev() in pci_for_each_dma_alias() gets the real dma device
> which is the VMD device 0000:59:00.5. However, pte of the VMD device
> 0000:59:00.5 has been configured during this message "pci 0000:59:00.5:
> Adding to iommu group 42". So, the status -EBUSY is returned when
> configuring pasid entry for device 10000:80:01.0.

So the VMD subdevice (pci 10000:80:01.0) is an alias device of the "pci
0000:59:00.5", and it uses the Source-ID of "pci 0000:59:00.5" for DMA
transactions. Do I understand it right? If so, it makes sense to skip
setting up pasid entry for VMD subdevices.

Another thing I am still concerned is about the context entry setup.
What does the context entries look like for both VMD and subdevices
after domain_context_mapping() being called?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
