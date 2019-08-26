Return-Path: <SRS0=vyM6=WW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73CCC3A59E
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 08:32:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B552080C
	for <iommu@archiver.kernel.org>; Mon, 26 Aug 2019 08:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B552080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4DF58118C;
	Mon, 26 Aug 2019 08:32:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DC5F71185
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 08:30:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 58A6089B
	for <iommu@lists.linux-foundation.org>;
	Mon, 26 Aug 2019 08:30:28 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	26 Aug 2019 01:30:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; d="scan'208";a="379573481"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2019 01:30:26 -0700
Subject: Re: [RFC PATCH] iommu/vt-d: Fix IOMMU field not populated on device
	hot re-plug
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
References: <20190822142922.31526-1-janusz.krzysztofik@linux.intel.com>
	<00f1a3a7-7ff6-e9a0-d9de-a177af6fd64b@linux.intel.com>
	<7536805.yzB8ZXLclH@jkrzyszt-desk.ger.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <790a4a20-7517-fe54-177d-850b9beeb88e@linux.intel.com>
Date: Mon, 26 Aug 2019 16:29:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7536805.yzB8ZXLclH@jkrzyszt-desk.ger.corp.intel.com>
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

Hi Janusz,

On 8/26/19 4:15 PM, Janusz Krzysztofik wrote:
> Hi Lu,
> 
> On Friday, August 23, 2019 3:51:11 AM CEST Lu Baolu wrote:
>> Hi,
>>
>> On 8/22/19 10:29 PM, Janusz Krzysztofik wrote:
>>> When a perfectly working i915 device is hot unplugged (via sysfs) and
>>> hot re-plugged again, its dev->archdata.iommu field is not populated
>>> again with an IOMMU pointer.  As a result, the device probe fails on
>>> DMA mapping error during scratch page setup.
>>>
>>> It looks like that happens because devices are not detached from their
>>> MMUIO bus before they are removed on device unplug.  Then, when an
>>> already registered device/IOMMU association is identified by the
>>> reinstantiated device's bus and function IDs on IOMMU bus re-attach
>>> attempt, the device's archdata is not populated with IOMMU information
>>> and the bad happens.
>>>
>>> I'm not sure if this is a proper fix but it works for me so at least it
>>> confirms correctness of my analysis results, I believe.  So far I
>>> haven't been able to identify a good place where the possibly missing
>>> IOMMU bus detach on device unplug operation could be added.
>>
>> Which kernel version are you testing with? Does it contain below commit?
>>
>> commit 458b7c8e0dde12d140e3472b80919cbb9ae793f4
>> Author: Lu Baolu <baolu.lu@linux.intel.com>
>> Date:   Thu Aug 1 11:14:58 2019 +0800
> 
> I was using an internal branch based on drm-tip which didn't contain this
> commit yet.  Fortunately it has been already merged into drm-tip over last
> weekend and has effectively fixed the issue.

Thanks for testing this.

Best regards,
Lu Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
