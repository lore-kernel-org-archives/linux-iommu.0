Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64071C433F5
	for <iommu@archiver.kernel.org>; Mon, 18 Apr 2022 11:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D33960BDA;
	Mon, 18 Apr 2022 11:37:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vqhwT7YLMb2d; Mon, 18 Apr 2022 11:37:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BAFDC60B03;
	Mon, 18 Apr 2022 11:37:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86FA2C002F;
	Mon, 18 Apr 2022 11:37:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79F06C002C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 11:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5843940297
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 11:37:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oRH6uwPd_i4J for <iommu@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 11:37:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7AEE400F8
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650281845; x=1681817845;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=QbdV17HFyoNuctqfGiYLR8ES3+m65lg3wiD/rXJX7uE=;
 b=lKPSGBZlV/oXeVgVUPFcoHcpxGJUuUObMD8MDADU5O9Fjq8GEjguhrZJ
 sgCYgyUtdyjrSQI9LTjdN6z/bzlAbPmNAPYiAjPUQanxPmzp3aVsTTi5L
 FKFvQ3K8AR23SzNUK5a6EdyrWwFlVIL+z4YGVDF6/wTFUJyUIZU+2Hiut
 DEEaOFoQINd83yb7KUWr1/Lyg0mozo95S6iWTu7Mi9gq3vwE3co1J6iAT
 ckEw2xNndUJrVz/B8hdeXb4wMn8NlGQS+9UHyU+PzAR70bkBGXRdtNFq7
 L7Dmeske+pu/QV65gdkyv/Jx/3yUmpLT8nNgVnhvgOckL5SvLZvNgLX1+ w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="263259964"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; d="scan'208";a="263259964"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2022 04:37:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; d="scan'208";a="575540119"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.231])
 ([10.254.208.231])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2022 04:37:22 -0700
Message-ID: <15089cab-f896-3c4f-1986-2f84d418696b@linux.intel.com>
Date: Mon, 18 Apr 2022 19:37:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Raj, Ashok"
 <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>
References: <20220416123049.879969-1-baolu.lu@linux.intel.com>
 <20220416123049.879969-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52767F7FCE2E82106ABDEBBA8CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/3] iommu/vt-d: Drop stop marker messages
In-Reply-To: <BN9PR11MB52767F7FCE2E82106ABDEBBA8CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On 2022/4/18 14:58, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Saturday, April 16, 2022 8:31 PM
>>
>> The VT-d driver explicitly drains the pending page requests when a CPU
>> page table (represented by a mm struct) is unbound from a PASID according
>> to the procedures defined in the VT-d spec. Hence, there's no need to
>> report the stop-marker message in prq_event_thread(). The stop marker
>> messages do not need a response. This drops stop marker messages silently
>> if any of them is found in the page request queue.
> The comment for iommu_queue_iopf says:
> 
>   * This module doesn't handle PCI PASID Stop Marker; IOMMU drivers must discard
>   * them before reporting faults. A PASID Stop Marker (LRW = 0b100) doesn't
>   * expect a response. It may be generated when disabling a PASID (issuing a
>   * PASID stop request) by some PCI devices.
> 
> So obviously the current vt-d driver behavior violates that requirement.
> Then should this be a bug fix instead?
> 

Our platforms have no devices issuing Stop Marker messages yet. But in a
virtualization environment, a device might be emulated with this
capability. Yes! Let me make it as a fix.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
