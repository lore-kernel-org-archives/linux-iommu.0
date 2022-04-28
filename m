Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFEEC433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 15:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1460F81392;
	Thu, 28 Apr 2022 15:16:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wLEHnv3JSc8a; Thu, 28 Apr 2022 15:16:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F8C281358;
	Thu, 28 Apr 2022 15:16:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F73EC002D;
	Thu, 28 Apr 2022 15:16:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B11CCC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E2C441B8F
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:16:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CEneQfkTOkHp for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 15:16:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8D97F41B99
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 15:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651158989; x=1682694989;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=pr+ey4rRc9gYEaidZyl/0OLhL2bGWJUaGv02tvBN1vQ=;
 b=XTy1BaP/iaSUjNBrGrzJuxCS9XnwlC9pOvppE0ALCJMFuHDl937BZ69N
 wU3CnLJGTib1ikLiq6bxJem+bs1Bo23FrsyUNoASgYOTERYDFoPRjKOgG
 tlWbS+auv4re7pRXe1CRBH2iang/Y4BpnvwXl09tmfwgnDPgTeMbHQfLw
 H7gNx9c2vvgLV+aBMEiLBa0oKq+0AfL+ygjpoaIFOywdw7uq+Lercb8P9
 0dMKIUPujmlCpkAV/aSlUmbCLumEvKiylG/h0rxgbM5lgVYm4qNguMvoS
 oDtKBGLNsXJf513HSveylikMOpk+BSF8MclbZOQnZL00sujJMVZV5IqZg A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="263908481"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="263908481"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 08:16:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="651259674"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.19.92])
 ([10.209.19.92])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 08:16:27 -0700
Message-ID: <25fdc11c-06b9-c16f-8427-77ac7673855c@linux.intel.com>
Date: Thu, 28 Apr 2022 08:16:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 1/2] swiotlb: Split up single swiotlb lock
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20220428141429.1637028-1-ltykernel@gmail.com>
 <20220428141429.1637028-2-ltykernel@gmail.com>
 <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
 <YmqonHKBT8ftYHgY@infradead.org>
 <1517d2f0-08d6-a532-7810-2161b2dff421@linux.intel.com>
 <YmqtJr5lxDruT/9s@infradead.org>
From: Andi Kleen <ak@linux.intel.com>
In-Reply-To: <YmqtJr5lxDruT/9s@infradead.org>
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com, wei.liu@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 linux-hyperv@vger.kernel.org, Tianyu Lan <ltykernel@gmail.com>,
 linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
 iommu@lists.linux-foundation.org, kirill.shutemov@intel.com,
 andi.kleen@intel.com, brijesh.singh@amd.com, vkuznets@redhat.com,
 kys@microsoft.com, Robin Murphy <robin.murphy@arm.com>, hch@lst.de
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


On 4/28/2022 8:05 AM, Christoph Hellwig wrote:
> On Thu, Apr 28, 2022 at 07:55:39AM -0700, Andi Kleen wrote:
>> At least for TDX need parallelism with a single device for performance.
> So find a way to make it happen without exposing details to random
> drivers.


That's what the original patch (that this one is derived from) did.

It was completely transparent to everyone outside swiotlb.c

-Andi

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
