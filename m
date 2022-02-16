Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A29FC433EF
	for <iommu@archiver.kernel.org>; Wed, 16 Feb 2022 07:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F21A2415FB;
	Wed, 16 Feb 2022 07:12:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I5SmWBbDHgtd; Wed, 16 Feb 2022 07:12:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ED6E24159E;
	Wed, 16 Feb 2022 07:12:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE855C0011;
	Wed, 16 Feb 2022 07:12:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6EDAC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 07:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 775F0408D8
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 07:12:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uS2S0EZ688WN for <iommu@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 07:12:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 64F4C4010E
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 07:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644995558; x=1676531558;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=f1SXQpu92IOX79PPCsU+PF8QzhMB5xnZr5Wm6Vd3XBk=;
 b=FPq3x+ywNajS37KJdJbW7Enep+IXXV04gLtjaMSe/6Eojy8TnR/dtuCn
 O4DDFoFn7uLzwsXMWDkPXHzsogyBsSuvj876kxXOqbQLAhhHrjX9oTl6a
 scAl0TOcZlq7I3nbVcbKDaxrhU3/z3tCD+zVNNZcgirgr0C2rOC3MZqFQ
 A+h+y8McVAKcPf0N9zMS18iNEKas2+aS/nvzptABici3XCNRJmnP+jkFV
 Ft5ZMf7HmmlHT5eumxPc9FKOl/th/DBzwL5pZo2W50637xyHZOSITrqvn
 OJrXAeaIExxfr36S6+jGoa0DXFjfTea52NW4CeqQt6IuyrvJNjV4o7SSF w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250740934"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; d="scan'208";a="250740934"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Feb 2022 23:12:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; d="scan'208";a="681390279"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2022 23:12:35 -0800
Message-ID: <fad3abe8-f69f-1339-7bca-e0283f9182d5@linux.intel.com>
Date: Wed, 16 Feb 2022 15:11:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 09/11] iommu/vt-d: Remove commented code
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Christoph Hellwig <hch@lst.de>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-10-baolu.lu@linux.intel.com>
 <20220214073424.GE17411@lst.de>
 <BN9PR11MB527698691A1DF10EEB514AA08C359@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527698691A1DF10EEB514AA08C359@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
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

On 2/16/22 11:45 AM, Tian, Kevin wrote:
>> From: Christoph Hellwig<hch@lst.de>
>> Sent: Monday, February 14, 2022 3:34 PM
>>
>> On Mon, Feb 14, 2022 at 10:57:02AM +0800, Lu Baolu wrote:
>>> This removes unnecessary commented code.
>> Removing dead code is always good:
>>
>> Reviewed-by: Christoph Hellwig<hch@lst.de>
>>
>> But someone might really want to take a look if draining makes sense here
>> or not.
> Looks that dead code has been there since intel-iommu driver was
> firstly introduced in 2007. I don't know whether we can dig out
> the reason (Baolu, can you have a check?) why it's only special
> cased for read draining but not write draining. I cannot find any
> such recommendation from VT-d spec.

Emm, I have no idea either. Let me check it with the architecture
experts.

> 
> Looking at VT-d spec it stated that since VT-d major version 2
> drain is conducted automatically by hardware and above flags
> are essentially ignored.
> 
> Given that possibly a safer option is to always set read/write
> draining flags before version 2 and skip it after.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
