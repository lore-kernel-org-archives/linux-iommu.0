Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE0AC433F5
	for <iommu@archiver.kernel.org>; Thu, 24 Feb 2022 05:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DA3360BF3;
	Thu, 24 Feb 2022 05:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OtS1sZWfJyp3; Thu, 24 Feb 2022 05:18:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C923260B33;
	Thu, 24 Feb 2022 05:18:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1499C0021;
	Thu, 24 Feb 2022 05:18:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32FFFC0011
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 05:18:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F25F40920
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 05:18:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mrkDzK3uwHwa for <iommu@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 05:18:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B4584091F
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 05:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645679908; x=1677215908;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=egRbENubkOkUmSuijD6lu7Tlla0i2tXbS3AogDwESqU=;
 b=KlVyzEvu2fGkg67Et9YuHNVWodqfF6X/3ecEVuygQojt3s8BlevZrWwm
 S9kl2qzXW8A2BZubB4ELjkW61EVCsLRkzd//gCkOWm/fyKRBMFQPYbm6F
 +Dt4cG0V2COONoRzDJoFyTrrwiBFVKJXmL5TN3cHxCqg5Wzf2SIZjnQzH
 Dzf8XT8yKUhuPuVWL3+lAp4dJzL+gfZbJ8ij+M4hy1xmxJ94jq6LNEwQ/
 ce1eXKkiDpGWnY/5bSzXIdSKwYn6Mb9g/DKlzayrv/KiJ6AuYrnHvL+on
 WgCZXugYbvtX4Cw6t1uadJ5gulmPaqwyQnbPJ5pHDACggvx3IucY/mqAs w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="315378575"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; d="scan'208";a="315378575"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2022 21:18:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; d="scan'208";a="684158911"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2022 21:18:20 -0800
Message-ID: <dd944ab4-cf25-fa41-0170-875e5c5fd0e8@linux.intel.com>
Date: Thu, 24 Feb 2022 13:16:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 01/11] iommu: Add dma ownership management interfaces
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
 <20220218005521.172832-2-baolu.lu@linux.intel.com>
 <f830c268-daca-8e8f-a429-0c80496a7273@arm.com>
 <20220223180244.GA390403@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220223180244.GA390403@nvidia.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

Hi Robin and Jason,

On 2/24/22 2:02 AM, Jason Gunthorpe wrote:
> On Wed, Feb 23, 2022 at 06:00:06PM +0000, Robin Murphy wrote:
> 
>> ...and equivalently just set owner_cnt directly to 0 here. I don't see a
>> realistic use-case for any driver to claim the same group more than once,
>> and allowing it in the API just feels like opening up various potential
>> corners for things to get out of sync.
> I am Ok if we toss it out to get this merged, as there is no in-kernel
> user right now.

So we don't need the owner pointer in the API anymore, right? As we will
only allow the claiming interface to be called only once, this token is
unnecessary.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
