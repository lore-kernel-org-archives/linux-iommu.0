Return-Path: <SRS0=f2Pc=WY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C40C3A5A4
	for <iommu@archiver.kernel.org>; Wed, 28 Aug 2019 00:57:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1042F2064A
	for <iommu@archiver.kernel.org>; Wed, 28 Aug 2019 00:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1042F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C26EF1AB0;
	Wed, 28 Aug 2019 00:57:38 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9A7A91545
	for <iommu@lists.linux-foundation.org>;
	Wed, 28 Aug 2019 00:57:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1B46CEC
	for <iommu@lists.linux-foundation.org>;
	Wed, 28 Aug 2019 00:57:37 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	27 Aug 2019 17:57:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,439,1559545200"; d="scan'208";a="380223132"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga005.fm.intel.com with ESMTP; 27 Aug 2019 17:57:35 -0700
Subject: Re: [RFC PATCH] iommu/vt-d: Fix IOMMU field not populated on device
	hot re-plug
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
References: <20190822142922.31526-1-janusz.krzysztofik@linux.intel.com>
	<7536805.yzB8ZXLclH@jkrzyszt-desk.ger.corp.intel.com>
	<790a4a20-7517-fe54-177d-850b9beeb88e@linux.intel.com>
	<29020717.Hl6jQjRASr@jkrzyszt-desk.ger.corp.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8f505c10-6256-c561-1aea-b3817388c5b2@linux.intel.com>
Date: Wed, 28 Aug 2019 08:56:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <29020717.Hl6jQjRASr@jkrzyszt-desk.ger.corp.intel.com>
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

On 8/27/19 5:35 PM, Janusz Krzysztofik wrote:
> Hi Lu,
> 
> On Monday, August 26, 2019 10:29:12 AM CEST Lu Baolu wrote:
>> Hi Janusz,
>>
>> On 8/26/19 4:15 PM, Janusz Krzysztofik wrote:
>>> Hi Lu,
>>>
>>> On Friday, August 23, 2019 3:51:11 AM CEST Lu Baolu wrote:
>>>> Hi,
>>>>
>>>> On 8/22/19 10:29 PM, Janusz Krzysztofik wrote:
>>>>> When a perfectly working i915 device is hot unplugged (via sysfs) and
>>>>> hot re-plugged again, its dev->archdata.iommu field is not populated
>>>>> again with an IOMMU pointer.  As a result, the device probe fails on
>>>>> DMA mapping error during scratch page setup.
>>>>>
>>>>> It looks like that happens because devices are not detached from their
>>>>> MMUIO bus before they are removed on device unplug.  Then, when an
>>>>> already registered device/IOMMU association is identified by the
>>>>> reinstantiated device's bus and function IDs on IOMMU bus re-attach
>>>>> attempt, the device's archdata is not populated with IOMMU information
>>>>> and the bad happens.
>>>>>
>>>>> I'm not sure if this is a proper fix but it works for me so at least it
>>>>> confirms correctness of my analysis results, I believe.  So far I
>>>>> haven't been able to identify a good place where the possibly missing
>>>>> IOMMU bus detach on device unplug operation could be added.
>>>>
>>>> Which kernel version are you testing with? Does it contain below commit?
>>>>
>>>> commit 458b7c8e0dde12d140e3472b80919cbb9ae793f4
>>>> Author: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Date:   Thu Aug 1 11:14:58 2019 +0800
>>>
>>> I was using an internal branch based on drm-tip which didn't contain this
>>> commit yet.  Fortunately it has been already merged into drm-tip over last
>>> weekend and has effectively fixed the issue.
>>
>> Thanks for testing this.
> 
> My testing appeared not sufficiently exhaustive. The fix indeed resolved my
> initially discovered issue of not being able to rebind the i915 driver to a
> re-plugged device, however it brought another, probably more serious problem
> to light.
> 
> When an open i915 device is hot unplugged, IOMMU bus notifier now cleans up
> IOMMU info for the device on PCI device remove while the i915 driver is still
> not released, kept by open file descriptors.  Then, on last device close,
> cleanup attempts lead to kernel panic raised from intel_unmap() on unresolved
> IOMMU domain.

We should avoid kernel panic when a intel_unmap() is called against
a non-existent domain. But we shouldn't expect the IOMMU driver not
cleaning up the domain info when a device remove notification comes and 
wait until all file descriptors being closed, right?

Best regards,
Baolu

> 
> With commit 458b7c8e0dde reverted and my fix applied, both late device close
> and device re-plug work for me.  However, I can realize that's probably still
> not a complete solution, possibly missing some protection against reuse of a
> removed device other than for cleanup.  If you think that's the right way to
> go, I can work more on that.
> 
> I've had a look at other drivers and found AMD is using somehow similar
> approach.  On the other hand, looking at the IOMMU common code I couldn't
> identify any arrangement that would support deferred device cleanup.
> 
> If that approach is not acceptable for Intel IOMMU, please suggest a way you'd
> like to have it resolved and I can try to implement it.
> 
> Thanks,
> Janusz
> 
>> Best regards,
>> Lu Baolu
>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
