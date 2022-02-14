Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002BCC433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 00:27:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8F67C40463;
	Mon, 14 Feb 2022 00:27:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b_a3Xm1lfa_i; Mon, 14 Feb 2022 00:27:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4852640469;
	Mon, 14 Feb 2022 00:27:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 173EBC001A;
	Mon, 14 Feb 2022 00:27:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 926FDC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 00:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 64F0640469
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 00:27:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MF7GOkpcq5jn for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 00:27:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 12F00400F1
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 00:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644798471; x=1676334471;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=kcElbae+RGFK/QaqPxibrAKD4Hv4dczBgQ4u6tcccQU=;
 b=RQ6x2cKzJBNzC2W01mJQ5PY4tRYncrG00Io7agkcU5gEvj/+KhzwMfOF
 hoBzk5zKWOagYlmhxtTpG+kAvPz2+FEUdfD2iIF9RIxFFaKXpx5A/VAx/
 mBGf3e3lFKjJVzUJI5Dlf08a/oB+BXfCLPQkdW8IMxeHIYuXcBatqBT4p
 ecvhXD7YV0KilSsc7mUdmzPY9dlDQDDJLXDTYnB461OewA75Je0rSg+Gy
 7NYZB4U5dsPz69Dad+XvG0ZMtqttLJkH4N+ifjmrCwT8btR+mpYE7XtLK
 FrIobjmu2dN0QDWHGxPCxuOfBpIbBXI8eJOjF3/7SNOvRXoJyANSE56mo w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="336411067"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="336411067"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2022 16:27:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="680101107"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2022 16:27:48 -0800
Message-ID: <574b5298-005e-a083-284b-9b6b52c600f5@linux.intel.com>
Date: Mon, 14 Feb 2022 08:26:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 00/10] iommu/vt-d: Some Intel IOMMU cleanups
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220211130144.GM4160@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220211130144.GM4160@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Hi Jason,

On 2/11/22 9:01 PM, Jason Gunthorpe wrote:
> On Mon, Feb 07, 2022 at 02:41:32PM +0800, Lu Baolu wrote:
>> Hi folks,
>>
>> After a long time of evolution, the drivers/iommu/intel/iommu.c becomes
>> fat and a bit messy. This series tries to cleanup and refactor the
>> driver to make it more concise. Your comments are very appreciated.
> 
> I wanted to take a closer look at what you are trying to do with rcu,
> but these patches don't apply. Please always sent patches against a
> well known tree like v5.17-rc or the iommu tree, or something.
> 
> Anyhow, I think you should split the last 4 patches out of this series
> and send them seperately.

Sure! I will resend this series soon.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
