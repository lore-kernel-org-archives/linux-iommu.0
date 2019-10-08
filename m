Return-Path: <SRS0=3Hvu=YB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6C0ECE58C
	for <iommu@archiver.kernel.org>; Tue,  8 Oct 2019 02:30:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6FB3206BB
	for <iommu@archiver.kernel.org>; Tue,  8 Oct 2019 02:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FB3206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 56DD2CC7;
	Tue,  8 Oct 2019 02:30:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7FCC0CC2
	for <iommu@lists.linux-foundation.org>;
	Tue,  8 Oct 2019 02:30:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1D2FE8B4
	for <iommu@lists.linux-foundation.org>;
	Tue,  8 Oct 2019 02:30:12 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 Oct 2019 19:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; d="scan'208";a="192457101"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2019 19:30:09 -0700
Subject: Re: [RFC PATCH] iommu/vt-d: Fix IOMMU field not populated on device
	hot re-plug
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
References: <20190822142922.31526-1-janusz.krzysztofik@linux.intel.com>
	<52fbfac9-c879-4b45-dd74-fafe62c2432b@linux.intel.com>
	<2674326.ZPvzKFr69O@jkrzyszt-desk.ger.corp.intel.com>
	<7739498.9tyZrNxj5X@jkrzyszt-desk.ger.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0131be21-0ae3-ac1e-6ee3-c256e3d2a38f@linux.intel.com>
Date: Tue, 8 Oct 2019 10:27:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7739498.9tyZrNxj5X@jkrzyszt-desk.ger.corp.intel.com>
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

On 10/1/19 11:01 PM, Janusz Krzysztofik wrote:
> Hi Baolu,
> 
> On Tuesday, September 3, 2019 9:41:23 AM CEST Janusz Krzysztofik wrote:
>> Hi Baolu,
>>
>> On Tuesday, September 3, 2019 3:29:40 AM CEST Lu Baolu wrote:
>>> Hi Janusz,
>>>
>>> On 9/2/19 4:37 PM, Janusz Krzysztofik wrote:
>>>>> I am not saying that keeping data is not acceptable. I just want to
>>>>> check whether there are any other solutions.
>>>> Then reverting 458b7c8e0dde and applying this patch still resolves the
>> issue
>>>> for me.  No errors appear when mappings are unmapped on device close after
>> the
>>>> device has been removed, and domain info preserved on device removal is
>>>> successfully reused on device re-plug.
>>>
>>> This patch doesn't look good to me although I agree that keeping data is
>>> acceptable.
> 
> Any progress with that?  Which mailing list should I watch for updates?\

We had a holiday last week. I will go ahead with reproducing it locally.
Feel free to let me know if you have any new proposal.

Best regards,
Baolu

> 
> Thanks,
> Janusz
> 
>>> It updates dev->archdata.iommu, but leaves the hardware
>>> context/pasid table unchanged. This might cause problems somewhere.
>>>
>>>>
>>>> Is there anything else I can do to help?
>>>
>>> Can you please tell me how to reproduce the problem?
>>
>> The most simple way to reproduce the issue, assuming there are no non-Intel
>> graphics adapters installed, is to run the following shell commands:
>>
>> #!/bin/sh
>> # load i915 module
>> modprobe i915
>> # open an i915 device and keep it open in background
>> cat /dev/dri/card0 >/dev/null &
>> sleep 2
>> # simulate device unplug
>> echo 1 >/sys/class/drm/card0/device/remove
>> # make the background process close the device on exit
>> kill $!
>>
>> Thanks,
>> Janusz
>>
>>
>>> Keeping the per
>>> device domain info while device is unplugged is a bit dangerous because
>>> info->dev might be a wild pointer. We need to work out a clean fix.
>>>
>>>>
>>>> Thanks,
>>>> Janusz
>>>>
>>>
>>> Best regards,
>>> Baolu
>>>
>>
>>
>>
>>
>>
> 
> 
> 
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
