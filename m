Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47ABDC433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 14:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF58E41B81;
	Thu, 28 Apr 2022 14:55:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oRZXPuPSi_ri; Thu, 28 Apr 2022 14:55:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4036041B7E;
	Thu, 28 Apr 2022 14:55:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14A0CC0032;
	Thu, 28 Apr 2022 14:55:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39176C0032
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:55:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C570860B69
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:55:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RYWBOjy76iWm for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 14:55:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA8D960F96
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651157747; x=1682693747;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TymbHLQLOivBB5TuFgZIkk0oRKZgOsSXpf3tD9EpOrU=;
 b=IjBbgL6GAxmiLubWRHk2F8rwricNGp88WZpAvSyhtpANnykRjIVtWq5l
 yColHW9LG02A1oRL7Lv3XYm4NTJx8pm30LK7V6Tcwr6Woatu2lbzbDBy5
 T4VUWUDIOONTpnKnZ5o+BXDAJP/B4agVX3dZVU/n6DsBc7fAtOB8k9Okc
 vqH6WNM3N32mA+N8bzwt00CnuEw6BMpJ0QuwmQIqRz2w2d81hfc15a9+F
 IugPdfySxkh4iArr5hdwsqmuJsBp/wJKL4mkJHKB58bSbRSCU0QyxzRG2
 apSzSd8iHer4QebELHpuYl72NRp4Yw7axk9eJndkloylZm6Fq6pEGa9cB w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="329257698"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="329257698"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 07:55:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; d="scan'208";a="651252042"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.19.92])
 ([10.209.19.92])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 07:55:44 -0700
Message-ID: <1517d2f0-08d6-a532-7810-2161b2dff421@linux.intel.com>
Date: Thu, 28 Apr 2022 07:55:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 1/2] swiotlb: Split up single swiotlb lock
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>, Robin Murphy <robin.murphy@arm.com>
References: <20220428141429.1637028-1-ltykernel@gmail.com>
 <20220428141429.1637028-2-ltykernel@gmail.com>
 <e7b644f0-6c90-fe99-792d-75c38505dc54@arm.com>
 <YmqonHKBT8ftYHgY@infradead.org>
From: Andi Kleen <ak@linux.intel.com>
In-Reply-To: <YmqonHKBT8ftYHgY@infradead.org>
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com, wei.liu@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 linux-hyperv@vger.kernel.org, Tianyu Lan <ltykernel@gmail.com>,
 linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
 iommu@lists.linux-foundation.org, andi.kleen@intel.com, brijesh.singh@amd.com,
 vkuznets@redhat.com, kys@microsoft.com, kirill.shutemov@intel.com, hch@lst.de
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


On 4/28/2022 7:45 AM, Christoph Hellwig wrote:
> On Thu, Apr 28, 2022 at 03:44:36PM +0100, Robin Murphy wrote:
>> Rather than introduce this extra level of allocator complexity, how about
>> just dividing up the initial SWIOTLB allocation into multiple io_tlb_mem
>> instances?
> Yeah.  We're almost done removing all knowledge of swiotlb from drivers,
> so the very last thing I want is an interface that allows a driver to
> allocate a per-device buffer.

At least for TDX need parallelism with a single device for performance.

So if you split up the io tlb mems for a device then you would need a 
new mechanism to load balance the requests for single device over those. 
I doubt it would be any simpler.


-Andi


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
