Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13921C433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 01:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4F7260FD5;
	Wed, 15 Jun 2022 01:38:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yvUqhIe-yPjj; Wed, 15 Jun 2022 01:38:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 908BB60F90;
	Wed, 15 Jun 2022 01:38:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6ABF8C0032;
	Wed, 15 Jun 2022 01:38:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B556C002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 01:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F066B60F9E
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 01:38:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uPm-hn_ei6u4 for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 01:38:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 12AFF60F90
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 01:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655257122; x=1686793122;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=F5FruFQBqBnDQJ0qsMlb0vjNU8I29/Dq4OsbDKGrAdw=;
 b=dGHNPl5PzHB1s21qj18anNtAcCaF7LmyTbjuqn3mUFh06u2VlDLfb4fe
 ZzPwz6RM7CW59LheuTKcjwxoiDr4RSZ8YRQVEd7Mc786siwnqzfgBJR5v
 OQpHb/lvMeHUxAjmGYJe3I0MlhhGllP7LlQIJVpcR9dEGz0qluK+iIE7p
 9huS05xkQB6B9tTL3rm2hrQ/fSYfCdysBTzPESVQPY2g7YlWXMCqNRQir
 WvGTZoGLHb7SbLhth06enoaGwYzQPVCDfKcmmxOWfewj/Pkyk9O5yP6ed
 xpjEtHpWfTqCtywF2x+T08M7uVpBstFRfa+VW8d2/g1fh7Wn7m70X99xT g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="261825578"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; d="scan'208";a="261825578"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2022 18:38:40 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; d="scan'208";a="588809497"
Received: from leitan-mobl.ccr.corp.intel.com (HELO [10.255.31.142])
 ([10.255.31.142])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2022 18:38:37 -0700
Message-ID: <9d6177ac-802f-eb11-4307-b0e49d8126b5@linux.intel.com>
Date: Wed, 15 Jun 2022 09:38:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Content-Language: en-US
To: Steve Wahl <steve.wahl@hpe.com>, Jerry Snitselaar <jsnitsel@redhat.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
 <20220613205734.3x7i46bnsofzerr4@cantor>
 <673eb011-94f4-46b0-f1b4-24a02a269f4e@linux.intel.com>
 <CALzcddsXciFgKOLSkXxx4Rv_rwh21qe8hkyiEET280D8orP6Vw@mail.gmail.com>
 <9c943703-0c2f-b654-a28b-f594bf90bec9@linux.intel.com>
 <CALzcdduU-baVF9VV-NnYD2rKn0YC5hzS_F9udExRE7guvMqXWg@mail.gmail.com>
 <616dc81c-dfc6-d6c6-1eab-de0e9ba4411f@linux.intel.com>
 <Yqi7L9A/ADXpIvN6@swahl-home.5wahls.com>
 <20220614190145.dkdwjnqnd7lv6y4n@cantor>
 <Yqj5q1Yps9JVlyyH@swahl-home.5wahls.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yqj5q1Yps9JVlyyH@swahl-home.5wahls.com>
Cc: Dimitri Sivanich <sivanich@hpe.com>, Joerg Roedel <jroedel@suse.de>,
 Russ Anderson <russ.anderson@hpe.com>, Mike Travis <mike.travis@hpe.com>,
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

On 2022/6/15 05:12, Steve Wahl wrote:
> On Tue, Jun 14, 2022 at 12:01:45PM -0700, Jerry Snitselaar wrote:
>> On Tue, Jun 14, 2022 at 11:45:35AM -0500, Steve Wahl wrote:
>>> On Tue, Jun 14, 2022 at 10:21:29AM +0800, Baolu Lu wrote:
>>>> On 2022/6/14 09:54, Jerry Snitselaar wrote:
>>>>> On Mon, Jun 13, 2022 at 6:51 PM Baolu Lu <baolu.lu@linux.intel.com> wrote:
>>>>>>
>>>>>> On 2022/6/14 09:44, Jerry Snitselaar wrote:
>>>>>>> On Mon, Jun 13, 2022 at 6:36 PM Baolu Lu<baolu.lu@linux.intel.com>  wrote:
>>>>>>>> On 2022/6/14 04:57, Jerry Snitselaar wrote:
>>>>>>>>> On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
>>>>>>>>>> To support up to 64 sockets with 10 DMAR units each (640), make the
>>>>>>>>>> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
>>>>>>>>>> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
>>>>>>>>>> set.
>>>>>>>>>>
>>>>>>>>>> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
>>>>>>>>>> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
>>>>>>>>>> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
>>>>>>>>>> remapping doesn't support X2APIC mode x2apic disabled"; and the system
>>>>>>>>>> fails to boot properly.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>> Note that we could not find a reason for connecting
>>>>>>>>>> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
>>>>>>>>>> it seemed like the two would continue to match on earlier processors.
>>>>>>>>>> There doesn't appear to be kernel code that assumes that the value of
>>>>>>>>>> one is related to the other.
>>>>>>>>>>
>>>>>>>>>> v2: Make this value a config option, rather than a fixed constant.  The default
>>>>>>>>>> values should match previous configuration except in the MAXSMP case.  Keeping the
>>>>>>>>>> value at a power of two was requested by Kevin Tian.
>>>>>>>>>>
>>>>>>>>>>      drivers/iommu/intel/Kconfig | 6 ++++++
>>>>>>>>>>      include/linux/dmar.h        | 6 +-----
>>>>>>>>>>      2 files changed, 7 insertions(+), 5 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>>>>>>>>>> index 247d0f2d5fdf..fdbda77ac21e 100644
>>>>>>>>>> --- a/drivers/iommu/intel/Kconfig
>>>>>>>>>> +++ b/drivers/iommu/intel/Kconfig
>>>>>>>>>> @@ -9,6 +9,12 @@ config DMAR_PERF
>>>>>>>>>>      config DMAR_DEBUG
>>>>>>>>>>         bool
>>>>>>>>>>
>>>>>>>>>> +config DMAR_UNITS_SUPPORTED
>>>>>>>>>> +    int "Number of DMA Remapping Units supported"
>>>>>>>>> Also, should there be a "depends on (X86 || IA64)" here?
>>>>>>>> Do you have any compilation errors or warnings?
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>> baolu
>>>>>>>>
>>>>>>> I think it is probably harmless since it doesn't get used elsewhere,
>>>>>>> but our tooling was complaining to me because DMAR_UNITS_SUPPORTED was
>>>>>>> being autogenerated into the configs for the non-x86 architectures we
>>>>>>> build (aarch64, s390x, ppcle64).
>>>>>>> We have files corresponding to the config options that it looks at,
>>>>>>> and I had one for x86 and not the others so it noticed the
>>>>>>> discrepancy.
>>>>>>
>>>>>> So with "depends on (X86 || IA64)", that tool doesn't complain anymore,
>>>>>> right?
>>>>>>
>>>>>> Best regards,
>>>>>> baolu
>>>>>>
>>>>>
>>>>> Yes, with the depends it no longer happens.
>>>>
>>>> The dmar code only exists on X86 and IA64 arch's. Adding this depending
>>>> makes sense to me. I will add it if no objections.
>>>
>>> I think that works after Baolu's patchset that makes intel-iommu.h
>>> private.  I'm pretty sure it wouldn't have worked before that.
>>>
>>> No objections.
>>>
>>
>> Yes, I think applying it with the depends prior to Baolu's change would
>> still run into the issue from the KTR report if someone compiled without
>> INTEL_IOMMU enabled.
>>
>> This was dealing with being able to do something like:
>>
>> make allmodconfig ARCH=arm64 ; grep DMAR_UNITS .config
>>
>> and finding CONFIG_DMAR_UNITS_SUPPORTED=64.
>>
>> Thinking some more though, instead of the depends being on the arch
>> would depending on DMAR_TABLE or INTEL_IOMMU be more appropriate?
> 
> At least in my limited exploration, depending on INTEL_IOMMU yields
> compile errors, but depending upon DMAR_TABLE appears to work fine.

DMAR_TABLE is used beyond INTEL_IOMMU, so depending on DMAR_TABLE seems
better.

Steve, do you mind posting a v3 with this fixed?

Best regards,
baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
