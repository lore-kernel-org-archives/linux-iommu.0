Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1AEC433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 01:48:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8E66B40523;
	Tue, 15 Feb 2022 01:48:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ezYoM3RZXV2L; Tue, 15 Feb 2022 01:48:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2C5D840475;
	Tue, 15 Feb 2022 01:48:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 093CBC001A;
	Tue, 15 Feb 2022 01:48:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 958F6C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 01:48:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6FC8F60D51
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 01:48:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1A8vvJGTNAZa for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 01:48:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B1B7C60A6F
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 01:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644889699; x=1676425699;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=nV7806JD+BvncEFIlyRfAtuzlBcLLqH1yrxrTkQsvYc=;
 b=Oma3f4ax5G7osIZZpcGOyWWTjLoS6TxOOGXkubJBldqc2BCByvRV8Q1L
 YLm47x+QHiWgv2U4x+OI/bO07fxx9deh/5SQzejcVNzPZ9dKYk8dpkxen
 rek5ZIM1wPopLlmQ+S4SMvtOYcim3WQNFfPubHS+Yj074VBKpFRjYcAaI
 5SZipFGPAqiAxfsadM7KGgR6V+i3EACpwaeOs68k5lWNbVtNYWgLfDNXH
 RUl29yJERun91bbfO7h81+oRqb03nmW/AFgi5ktnriSWcAbZXyjWy0Esq
 1AFqmeHSrw0Y9kMZaucpTn4Hdvqv/lGCPvHqh59JbTwaTISLgUy1oM52C g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="233773304"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="233773304"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2022 17:48:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="680789537"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 17:48:14 -0800
Message-ID: <0dd0f4c9-37a6-0418-3f19-22c40ccc8265@linux.intel.com>
Date: Tue, 15 Feb 2022 09:46:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 07/10] iommu: Use right way to retrieve iommu_ops
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
 <20220214015538.2828933-8-baolu.lu@linux.intel.com>
 <YgpP7AhY5hd/DX/C@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <YgpP7AhY5hd/DX/C@8bytes.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
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

On 2/14/22 8:49 PM, Joerg Roedel wrote:
> On Mon, Feb 14, 2022 at 09:55:35AM +0800, Lu Baolu wrote:
>> +static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>> +{
>> +	/*
>> +	 * Assume that valid ops must be installed if iommu_probe_device()
>> +	 * has succeeded. The device ops are essentially for internal use
>> +	 * within the IOMMU subsystem itself, so we should be able to trust
>> +	 * ourselves not to misuse the helper.
>> +	 */
>> +	WARN_ON(!dev || !dev->iommu || !dev->iommu->iommu_dev ||
>> +		!dev->iommu->iommu_dev->ops);
> 
> There is no need for this WARN_ON, the code will oops anyway when one of
> the pointers checked here is NULL.
> 

We really don't need to WARN_ON intermediate null pointers. But I would
argue that we could add a WARN() on null dev->iommu->iommu_dev->ops, so
that callers have no need to check the returned ops.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
