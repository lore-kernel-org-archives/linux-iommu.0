Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94ABDC433F5
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 05:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4553C81307;
	Tue,  8 Feb 2022 05:00:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kEQqCyZrZgMS; Tue,  8 Feb 2022 05:00:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2AA67812F2;
	Tue,  8 Feb 2022 05:00:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04046C001A;
	Tue,  8 Feb 2022 05:00:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69237C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 05:00:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 470D081305
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 05:00:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QGrtBMk7ngoy for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 05:00:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5979A812F2
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 05:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644296400; x=1675832400;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=8B0fvJxEJCgZ1XGBKcnyZvyWKeanluy4HXPYaaurdAY=;
 b=g6E19+cNVWBhbpP0O7lnGTx/9PjxpZnXjPoNfgDOfm+1eOEoqyQ++gtv
 cHzg84qRW5BkpvpEutMxjymjSUU/iB7EdGPEqoN/cJcSL4DjFaLyZ9TGO
 YFo1W3sNwdHsFaf1+c2yHO7xV2SgitUeqRpwN8/9zRfBNiMq0X5D313RB
 edM3q/OdbJ+lrQpc4ItMU2dzuhfJcNUYjuE8cNGmrKlZSF9v3q7KQuDzd
 LgETmmJqTkKVCSyXTCz/qOpMa+Jg5FSMF9QoPi7bi4zpMGnhA6kNdUbTj
 MH5zr7w2r+ZgvbGQfEMkjpiCpkc8BRqTpKdzOGqLKdAFfsZN93ai9xpgc g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="335273928"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="335273928"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 20:59:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="677989172"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 20:59:56 -0800
Message-ID: <5ed59b2d-8d19-fd15-6fad-3572beabe4c2@linux.intel.com>
Date: Tue, 8 Feb 2022 12:58:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 10/10] iommu/vt-d: Some cleanups in iommu.c
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220207064142.1092846-11-baolu.lu@linux.intel.com>
 <20220207071544.GH23941@lst.de>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220207071544.GH23941@lst.de>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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

On 2/7/22 3:15 PM, Christoph Hellwig wrote:
> On Mon, Feb 07, 2022 at 02:41:42PM +0800, Lu Baolu wrote:
>> Move macros and inline helpers to the
>> header file.
> 
> Why?  This just means they get pulled into other source files and
> create overhead.

I supposed that they could also be used elsewhere. But no use cases so
better to keep them and avoid overhead. Thanks!

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
