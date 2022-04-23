Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B55DC433F5
	for <iommu@archiver.kernel.org>; Sat, 23 Apr 2022 07:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1C5EF40169;
	Sat, 23 Apr 2022 07:32:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RHOewovsQqFL; Sat, 23 Apr 2022 07:32:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DDB2740012;
	Sat, 23 Apr 2022 07:32:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1764C0039;
	Sat, 23 Apr 2022 07:32:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7789AC002D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 07:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F28A40105
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 07:32:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wbUe9tY94RA6 for <iommu@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 07:32:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5A7540012
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 07:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650699146; x=1682235146;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=x/c3raDa5wSKoz1iB1BvOoz+NWGUFUCKRADdevodsx0=;
 b=mUl+0tVZxxWOkE9IgLVMqLIPQP6TT6IRWGMScp1mJ7qTZcdZIPf3wvrT
 DMVFD9r6v+NcgSOF9/VUCdYa+x9DlF/+e1ZbTw8Jr3jQEWrbsoXtfHIfG
 PmfFPOpKIZWCK1+WCx/MrH0waGJBOdbeMBmH1kZ35oSdxIeLZU/PLSUhV
 QFbgtu+6QhSd0X7D7e52vtl2nWMzQ2dWxKflaCsfG6rR0E97gCM7g8Gpz
 NsZpfGSDFuW6679uV24EliGhu8PMmYBG2kX+GChM7vRo2vRT+tadF14El
 7IrYcyPIAyb3buTBn6DU93qUrg+ABv8yQwyfDKYindzP4r5I/hHTJfG2q Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289992762"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; d="scan'208";a="289992762"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 00:32:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; d="scan'208";a="578307252"
Received: from yjsun1-mobl.ccr.corp.intel.com (HELO [10.255.31.217])
 ([10.255.31.217])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 00:32:22 -0700
Message-ID: <936ce4a6-4574-9fc4-ad4a-2e93adca3c16@linux.intel.com>
Date: Sat, 23 Apr 2022 15:32:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/4] iommu/vt-d: Drop stop marker messages
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Raj, Ashok"
 <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
 <20220421113558.3504874-4-baolu.lu@linux.intel.com>
 <BN9PR11MB5276D83DF086871587743E378CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276D83DF086871587743E378CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/4/22 11:05, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Thursday, April 21, 2022 7:36 PM
>>
>> The page fault handling framework in the IOMMU core explicitly states
>> that it doesn't handle PCI PASID Stop Marker and the IOMMU drivers must
>> discard them before reporting faults. This handles Stop Marker messages
>> in prq_event_thread() before reporting events to the core.
>>
>> The VT-d driver explicitly drains the pending page requests when a CPU
>> page table (represented by a mm struct) is unbound from a PASID according
>> to the procedures defined in the VT-d spec. The Stop Marker messages do
>> not need a response. Hence, it is safe to drop the Stop Marker messages
>> silently if any of them is found in the page request queue.
>>
>> Fixes: d5b9e4bfe0d88 ("iommu/vt-d: Report prq to io-pgfault framework")
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> Reviewed-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> 

Thank you, Kevin. I will queue this patch to Joerg as a fix for v5.18.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
