Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE081C433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 01:33:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A27D826C2;
	Tue, 15 Feb 2022 01:33:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JeyLlKC2cUIm; Tue, 15 Feb 2022 01:33:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 27A8182695;
	Tue, 15 Feb 2022 01:33:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0BDEC001A;
	Tue, 15 Feb 2022 01:33:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52A04C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 01:32:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C00840543
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 01:32:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I8hDoNzgak1q for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 01:32:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7E52E4036E
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 01:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644888778; x=1676424778;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=0ctRTJZZNVcCzZj/wNrnn1QyWEQDzBeLXyFmEOHK8r4=;
 b=X1si7ryfkt0jAnEGQ5VHy+Nbf0yzxaZMwR8yDmToOfdd91jpoCFyCWnE
 HADpdnaBCIwNpPF1lLKh1OtPma3kOQmmBfC6nhCuJ4KsJHVCAJvd2OBPN
 bj6Wn4enSzXvC3znlkpN0zs+QpKo14/o5q/VlJ0tYmENgkM3Yb+h+9Zhz
 uYXCO7jEI+C12meulyhgz0w/3q7Trx5EpuXJZ95veahyiGTNHvkqdWuX5
 OUSNN9i1mYWMTFr11Am6RT3oX8A9TENoDJimE9yw9BefZxJn/KImnIF5u
 ytbCH0cRU2aaXR4xasF9ZPAVE3lPZL4OnmH1oHAuuO+1JFzL6Vr4+Njqg Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="274798665"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="274798665"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2022 17:32:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="680786710"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 17:32:56 -0800
Message-ID: <30e45a7e-088d-7479-a284-68effadf3cbe@linux.intel.com>
Date: Tue, 15 Feb 2022 09:31:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Move intel_iommu_ops to header file
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220207141240.8253-1-andriy.shevchenko@linux.intel.com>
 <YgpY1IIBkFIxxjbm@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <YgpY1IIBkFIxxjbm@8bytes.org>
Cc: Joerg Roedel <jroedel@suse.de>, David Woodhouse <dwmw2@infradead.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

On 2/14/22 9:27 PM, Joerg Roedel wrote:
> On Mon, Feb 07, 2022 at 04:12:40PM +0200, Andy Shevchenko wrote:
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index 69230fd695ea..1036c1900b5c 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -813,6 +813,8 @@ bool context_present(struct context_entry *context);
>>   struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
>>   					 u8 devfn, int alloc);
>>   
>> +extern const struct iommu_ops intel_iommu_ops;
>> +
> The intel_iommu_ops symbol is only used in drivers/iommu/intel, so I
> would prefer a header in that directory. But I leave that up to Baolu to
> decide.

Agreed. I also have a plan to split them out into a internal header.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
