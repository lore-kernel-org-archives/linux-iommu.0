Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B336C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 02:29:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D343141CB5;
	Thu, 23 Jun 2022 02:29:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D343141CB5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QJ7pTJEP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AhT_d4zxU2GV; Thu, 23 Jun 2022 02:29:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2A4E141780;
	Thu, 23 Jun 2022 02:29:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2A4E141780
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D59F7C0039;
	Thu, 23 Jun 2022 02:29:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65732C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 02:29:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3915B845C3
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 02:29:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3915B845C3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QJ7pTJEP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ccXNv_ULCaHA for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 02:29:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52811845BC
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52811845BC
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 02:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655951384; x=1687487384;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=O8dTk/EyqAi+/URxBU6KCoV1F2X9CZR61Iaxw/z5tl0=;
 b=QJ7pTJEPoQGVdLBY8BmS+Seq4pH0SF9cMrvGOOSrC2uzpMzIJtkYZxjf
 CXtavYPUjLCslhKQfHf69NCYi3CqEhrW5Ai7r9zTfdR0Utrvjw5MpSi4E
 uAfkVDMQH3S0iqnTPz479N7W5zQAHy0qpf7UmbSHtyJEYm8PrhodoZeSU
 OK1hR3/tZ2cR/rHREfanDNaQ2vxdZjJ+fGgUWHwwU6MS/Uka8UIg19kqz
 2xwGvzL7akyhaQ+99T0aPP1bFNlEYoPfGaPzxKO1+MpoaxXvPWuteNKJh
 PVQFZTvkH9xXixcgfzhZHgy/klLIkLrEHScTxB3pbie+4zXvwIpJP0Jpm w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281331581"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; d="scan'208";a="281331581"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2022 19:29:43 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; d="scan'208";a="644501698"
Received: from yutaoxu-mobl.ccr.corp.intel.com (HELO [10.249.172.190])
 ([10.249.172.190])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2022 19:29:38 -0700
Message-ID: <f0e4adc8-5d67-b76a-d0f1-2df83bd69a82@linux.intel.com>
Date: Thu, 23 Jun 2022 10:29:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Content-Language: en-US
To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <9d6177ac-802f-eb11-4307-b0e49d8126b5@linux.intel.com>
 <20220615183650.32075-1-steve.wahl@hpe.com>
 <96984350-3a04-812a-60f1-a09138014fac@linux.intel.com>
 <CALzcdduhpOebY18hiOpMcXLcH83bY_u4fZT09pBcoz2ObqXnGg@mail.gmail.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CALzcdduhpOebY18hiOpMcXLcH83bY_u4fZT09pBcoz2ObqXnGg@mail.gmail.com>
Cc: Dimitri Sivanich <sivanich@hpe.com>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <jroedel@suse.de>, Russ Anderson <russ.anderson@hpe.com>,
 Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Kyung Min Park <kyung.min.park@intel.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>
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

On 2022/6/22 23:05, Jerry Snitselaar wrote:
> On Wed, Jun 22, 2022 at 7:52 AM Baolu Lu<baolu.lu@linux.intel.com>  wrote:
>> On 2022/6/16 02:36, Steve Wahl wrote:
>>> To support up to 64 sockets with 10 DMAR units each (640), make the
>>> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
>>> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
>>> set.
>>>
>>> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
>>> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
>>> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
>>> remapping doesn't support X2APIC mode x2apic disabled"; and the system
>>> fails to boot properly.
>>>
>>> Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
>>> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
>>> ---
>>>
>>> Note that we could not find a reason for connecting
>>> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
>>> it seemed like the two would continue to match on earlier processors.
>>> There doesn't appear to be kernel code that assumes that the value of
>>> one is related to the other.
>>>
>>> v2: Make this value a config option, rather than a fixed constant.  The default
>>> values should match previous configuration except in the MAXSMP case.  Keeping the
>>> value at a power of two was requested by Kevin Tian.
>>>
>>> v3: Make the config option dependent upon DMAR_TABLE, as it is not used without this.
>>>
>>>    drivers/iommu/intel/Kconfig | 7 +++++++
>>>    include/linux/dmar.h        | 6 +-----
>>>    2 files changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>>> index 39a06d245f12..07aaebcb581d 100644
>>> --- a/drivers/iommu/intel/Kconfig
>>> +++ b/drivers/iommu/intel/Kconfig
>>> @@ -9,6 +9,13 @@ config DMAR_PERF
>>>    config DMAR_DEBUG
>>>        bool
>>>
>>> +config DMAR_UNITS_SUPPORTED
>>> +     int "Number of DMA Remapping Units supported"
>>> +     depends on DMAR_TABLE
>>> +     default 1024 if MAXSMP
>>> +     default 128  if X86_64
>>> +     default 64
>> With this patch applied, the IOMMU configuration looks like:
>>
>> [*]   AMD IOMMU support
>> <M>     AMD IOMMU Version 2 driver
>> [*]     Enable AMD IOMMU internals in DebugFS
>> (1024) Number of DMA Remapping Units supported   <<<< NEW
>> [*]   Support for Intel IOMMU using DMA Remapping Devices
>> [*]     Export Intel IOMMU internals in Debugfs
>> [*]     Support for Shared Virtual Memory with Intel IOMMU
>> [*]     Enable Intel DMA Remapping Devices by default
>> [*]     Enable Intel IOMMU scalable mode by default
>> [*]   Support for Interrupt Remapping
>> [*]   OMAP IOMMU Support
>> [*]     Export OMAP IOMMU internals in DebugFS
>> [*]   Rockchip IOMMU Support
>>
>> The NEW item looks confusing. It looks to be a generic configurable
>> value though it's actually Intel DMAR specific. Any thoughts?
>>
>> Best regards,
>> baolu
>>
> Would moving it under INTEL_IOMMU at least have it show up below
> "Support for Intel IOMMU using DMA Remapping Devices"? I'm not sure it
> can be better than that, because IRQ_REMAP selects DMAR_TABLE, so we
> can't stick it in the if INTEL_IOMMU section.

It's more reasonable to move it under INTEL_IOMMU, but the trouble is
that this also stands even if INTEL_IOMMU is not configured.

The real problem here is that the iommu sequence ID overflows if
DMAR_UNITS_SUPPORTED is not big enough. This is purely a software
implementation issue, I am not sure whether user opt-in when building a
kernel package could help a lot here.

If we can't find a better way, can we just step back?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
