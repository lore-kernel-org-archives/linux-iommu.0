Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE07C43334
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 01:51:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BD8214053E;
	Tue, 14 Jun 2022 01:51:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FJXkhoJRiNeV; Tue, 14 Jun 2022 01:51:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 836AC4061C;
	Tue, 14 Jun 2022 01:51:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 223B5C0039;
	Tue, 14 Jun 2022 01:51:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D628AC002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 01:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CBABD4053E
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 01:51:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Svn0nBV3f4C for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 01:51:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 173C3408D1
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 01:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655171476; x=1686707476;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xR9+0H/9OiLAA9Tu6kOW3uyO/wnTrUEpnpUyHCYRC8k=;
 b=M85SZ4R5l5NXCJszWq3A6UM8H8wXFuqa+f9Vlv1f2OHUGHorhlkapkSw
 NvEDV4oYaFALpPKKpQhzTk0HYJLbmgldWGkM4OQaJx1rDbr542ZPrR0Hs
 VmdBOlq+ipItT87YkXeYxKNFobxhNbw9r50VUHOg1d3NqwhJEBQRkmibM
 lvaOqcyZQlPh46fSHbc5hWx0VFyK7GhkAu0ozuAZO4tnUa9YIP/IXVZ4j
 cTfVzRe531yTBoU1zBvX9ggSblOkUcJmGmcHiArFpvo+6sY/oBYyLfmc+
 /7bdV5/2xhA6zZaVkWn5tlx8MmKYI/DxiJ+TYWLTMHfOvjhlSqtQ77ZQZ g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="261502742"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; d="scan'208";a="261502742"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 18:51:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; d="scan'208";a="910701088"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39])
 ([10.255.29.39])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 18:51:10 -0700
Message-ID: <9c943703-0c2f-b654-a28b-f594bf90bec9@linux.intel.com>
Date: Tue, 14 Jun 2022 09:51:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Content-Language: en-US
To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
 <20220613205734.3x7i46bnsofzerr4@cantor>
 <673eb011-94f4-46b0-f1b4-24a02a269f4e@linux.intel.com>
 <CALzcddsXciFgKOLSkXxx4Rv_rwh21qe8hkyiEET280D8orP6Vw@mail.gmail.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CALzcddsXciFgKOLSkXxx4Rv_rwh21qe8hkyiEET280D8orP6Vw@mail.gmail.com>
Cc: Dimitri Sivanich <sivanich@hpe.com>, Joerg Roedel <jroedel@suse.de>,
 Russ Anderson <russ.anderson@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
 Mike Travis <mike.travis@hpe.com>, David Woodhouse <dwmw2@infradead.org>,
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

On 2022/6/14 09:44, Jerry Snitselaar wrote:
> On Mon, Jun 13, 2022 at 6:36 PM Baolu Lu<baolu.lu@linux.intel.com>  wrote:
>> On 2022/6/14 04:57, Jerry Snitselaar wrote:
>>> On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
>>>> To support up to 64 sockets with 10 DMAR units each (640), make the
>>>> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
>>>> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
>>>> set.
>>>>
>>>> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
>>>> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
>>>> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
>>>> remapping doesn't support X2APIC mode x2apic disabled"; and the system
>>>> fails to boot properly.
>>>>
>>>> Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
>>>> ---
>>>>
>>>> Note that we could not find a reason for connecting
>>>> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
>>>> it seemed like the two would continue to match on earlier processors.
>>>> There doesn't appear to be kernel code that assumes that the value of
>>>> one is related to the other.
>>>>
>>>> v2: Make this value a config option, rather than a fixed constant.  The default
>>>> values should match previous configuration except in the MAXSMP case.  Keeping the
>>>> value at a power of two was requested by Kevin Tian.
>>>>
>>>>    drivers/iommu/intel/Kconfig | 6 ++++++
>>>>    include/linux/dmar.h        | 6 +-----
>>>>    2 files changed, 7 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>>>> index 247d0f2d5fdf..fdbda77ac21e 100644
>>>> --- a/drivers/iommu/intel/Kconfig
>>>> +++ b/drivers/iommu/intel/Kconfig
>>>> @@ -9,6 +9,12 @@ config DMAR_PERF
>>>>    config DMAR_DEBUG
>>>>       bool
>>>>
>>>> +config DMAR_UNITS_SUPPORTED
>>>> +    int "Number of DMA Remapping Units supported"
>>> Also, should there be a "depends on (X86 || IA64)" here?
>> Do you have any compilation errors or warnings?
>>
>> Best regards,
>> baolu
>>
> I think it is probably harmless since it doesn't get used elsewhere,
> but our tooling was complaining to me because DMAR_UNITS_SUPPORTED was
> being autogenerated into the configs for the non-x86 architectures we
> build (aarch64, s390x, ppcle64).
> We have files corresponding to the config options that it looks at,
> and I had one for x86 and not the others so it noticed the
> discrepancy.

So with "depends on (X86 || IA64)", that tool doesn't complain anymore,
right?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
