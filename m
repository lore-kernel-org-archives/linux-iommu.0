Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E76C4332F
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 05:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DF68340181;
	Tue,  8 Feb 2022 05:56:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YPRaC7X1Ia_Y; Tue,  8 Feb 2022 05:56:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7C1D140102;
	Tue,  8 Feb 2022 05:56:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 528FDC0011;
	Tue,  8 Feb 2022 05:56:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CE01C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 05:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1BF2440888
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 05:56:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yD__CQmAIacL for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 05:56:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC4A540887
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 05:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644299807; x=1675835807;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/E3+XDZn+fI4PCSgbxMj37rovQtgfKS2C5AACs5xPYs=;
 b=jCcduvp0pUbuEiRKapBclLvfL+KNXXQGT7YvuehPp+76pQGAoyM11d+Y
 MJipUqKEkT2+PyfXT63WK9VHl/Hk7eXnloW5UZOqzuv4XSWoYymBudrn1
 ouGHuhhc5Kbhqvy8Vi4Zqk0S6brzcPyt7vee9+f5vqgUfgXbVPBsxihiG
 m5pmI7vV62ZLf4vFdu95zvfcBVOeRTaAigQDbzSKT1NVcemv+i22WgL9P
 j9IrHn81ljm8iEF8/YnFjaPLsJOhdVit+C6m5a5N28tMeyM9MEHdjpaxz
 jwJN3idf/DAH2QZW19Bwn5wv7uf8OoqRgm1l5yVFi3lpV58+gXHmLDVtL g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="309623926"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="309623926"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 21:56:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="678001282"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 21:56:39 -0800
Message-ID: <608192e0-136a-57fc-cb2c-3ebb42874788@linux.intel.com>
Date: Tue, 8 Feb 2022 13:55:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 02/14] driver core: Add dma_cleanup callback in bus_type
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20220104015644.2294354-1-baolu.lu@linux.intel.com>
 <20220104015644.2294354-3-baolu.lu@linux.intel.com>
 <YdQcpHrV7NwUv+qc@infradead.org> <20220104123911.GE2328285@nvidia.com>
 <YdRFyXWay/bdSSem@kroah.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <YdRFyXWay/bdSSem@kroah.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
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

Hi Greg,

On 1/4/22 9:04 PM, Greg Kroah-Hartman wrote:
> On Tue, Jan 04, 2022 at 08:39:11AM -0400, Jason Gunthorpe wrote:
>> On Tue, Jan 04, 2022 at 02:08:36AM -0800, Christoph Hellwig wrote:
>>> All these bus callouts still looks horrible and just create tons of
>>> boilerplate code.
>>
>> Yes, Lu - Greg asked questions then didn't respond to their answers
>> meaning he accepts them, you should stick with the v4 version.
> 
> Trying to catch up on emails from the break, that was way down my list
> of things to get back to as it's messy and non-obvious.  I'll revisit it
> again after 5.17-rc1 is out, this is too late for that merge window
> anyway.

In this series we want to add calls into the iommu subsystem during
device driver binding/unbinding, so that the device DMA ownership
conflict (kernel driver vs. user-space) could be detected and avoided
before calling into device driver's .probe().

In this v5 series, we implemented this in the affected buses (amba/
platform/fsl-mc/pci) which are known to support assigning devices to
user space through the vfio framework currently. And more buses are
possible to be affected in the future if they also want to support
device assignment. Christoph commented that this will create boilerplate
code in various bus drivers.

Back to v4 of this series (please refer to below link [1]), we added
this call in the driver core if buses have provided the dma_configure()
callback (please refer to below link [2]).

Which would you prefer, or any other suggestions? We need your guide to
move this series ahead. Please help to suggest.

[1] 
https://lore.kernel.org/linux-iommu/20211217063708.1740334-1-baolu.lu@linux.intel.com/
[2] 
https://lore.kernel.org/linux-iommu/20211217063708.1740334-3-baolu.lu@linux.intel.com/

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
