Return-Path: <SRS0=xflu=WZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DF4C3A59F
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 09:09:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160752073F
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 09:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160752073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B9B2645E0;
	Thu, 29 Aug 2019 09:09:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AC6F1459B
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 09:09:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1A5E3EC
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 09:09:38 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	29 Aug 2019 02:09:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; d="scan'208";a="380707285"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2019 02:09:36 -0700
Subject: Re: [RFC PATCH] iommu/vt-d: Fix IOMMU field not populated on device
	hot re-plug
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
References: <20190822142922.31526-1-janusz.krzysztofik@linux.intel.com>
	<3275480.HMaYE7B3nd@jkrzyszt-desk.ger.corp.intel.com>
	<0cf4e930-1132-1e7f-815b-57a08a1fe5de@linux.intel.com>
	<3255251.C7nBVfOIaa@jkrzyszt-desk.ger.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ccb1434d-281c-abae-0726-7fd924041315@linux.intel.com>
Date: Thu, 29 Aug 2019 17:08:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3255251.C7nBVfOIaa@jkrzyszt-desk.ger.corp.intel.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	=?UTF-8?Q?Micha=c5=82_Wajdeczko?= <michal.wajdeczko@intel.com>,
	David Woodhouse <dwmw2@infradead.org>, intel-gfx@lists.freedesktop.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi,

On 8/29/19 3:58 PM, Janusz Krzysztofik wrote:
> Hi Baolu,
> 
> On Thursday, August 29, 2019 3:43:31 AM CEST Lu Baolu wrote:
>> Hi Janusz,
>>
>> On 8/28/19 10:17 PM, Janusz Krzysztofik wrote:
>>>> We should avoid kernel panic when a intel_unmap() is called against
>>>> a non-existent domain.
>>> Does that mean you suggest to replace
>>> 	BUG_ON(!domain);
>>> with something like
>>> 	if (WARN_ON(!domain))
>>> 		return;
>>> and to not care of orphaned mappings left allocated?  Is there a way to
> inform
>>> users that their active DMA mappings are no longer valid and they
> shouldn't
>>> call dma_unmap_*()?
>>>
>>>> But we shouldn't expect the IOMMU driver not
>>>> cleaning up the domain info when a device remove notification comes and
>>>> wait until all file descriptors being closed, right?
>>> Shouldn't then the IOMMU driver take care of cleaning up resources still
>>> allocated on device remove before it invalidates and forgets their
> pointers?
>>>
>>
>> You are right. We need to wait until all allocated resources (iova and
>> mappings) to be released.
>>
>> How about registering a callback for BUS_NOTIFY_UNBOUND_DRIVER, and
>> removing the domain info when the driver detachment completes?
> 
> Device core calls BUS_NOTIFY_UNBOUND_DRIVER on each driver unbind, regardless
> of a device being removed or not.  As long as the device is not unplugged and
> the BUS_NOTIFY_REMOVED_DEVICE notification not generated, an unbound driver is
> not a problem here.
> Morever, BUS_NOTIFY_UNBOUND_DRIVER  is called even before
> BUS_NOTIFY_REMOVED_DEVICE so that wouldn't help anyway.
> Last but not least, bus events are independent of the IOMMU driver use via
> DMA-API it exposes.

Fair enough.

> 
> If keeping data for unplugged devices and reusing it on device re-plug is not
> acceptable then maybe the IOMMU driver should perform reference counting of
> its internal resources occupied by DMA-API users and perform cleanups on last
> release?

I am not saying that keeping data is not acceptable. I just want to
check whether there are any other solutions.

Best regards,
Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
