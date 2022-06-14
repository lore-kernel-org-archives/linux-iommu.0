Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC2FC43334
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 01:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3843F409ED;
	Tue, 14 Jun 2022 01:36:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mElzBGt8tVZV; Tue, 14 Jun 2022 01:36:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A96DB409F1;
	Tue, 14 Jun 2022 01:36:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BF94C0039;
	Tue, 14 Jun 2022 01:36:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24975C002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 01:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F254C40644
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 01:36:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S7eV3YyXepL3 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 01:36:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4BBFB40A0F
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 01:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655170581; x=1686706581;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ewivjPZum4J8cY2UdxwQKYE+RjVPBMMFr8E5bpfsPXc=;
 b=UGc3du+UML2M5P7EUB703gu8lwBWOEz8sOahnKttvSdXgw/18DsMxr8+
 7mTuAHiOX3B+3lYJ/ob/+ookqR/tXMfGCwxflVlk+FVH1yO8u8PCbID1a
 /SIovODCI+NtaB69brlXlibidb7icUMVT5dnaLkXzzqwldziCO3sRCPF2
 TEz2IL6jzUU2DzHnq5RqFMZGrIqwQDgUBA7kBRuZvHuk/UsXsubP74dcc
 url2w9H5ejB8TPjoTDnZm+9v9V5T4uSlew6KpN/HgEZl/MQfpos4I2YeD
 28ZD9AmTiYC28On1m0JEpvJ56rQhdECr61uf7wd5fBaMWv9KpeOSioxfC Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258297879"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; d="scan'208";a="258297879"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 18:36:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; d="scan'208";a="910696441"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39])
 ([10.255.29.39])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 18:36:17 -0700
Message-ID: <673eb011-94f4-46b0-f1b4-24a02a269f4e@linux.intel.com>
Date: Tue, 14 Jun 2022 09:36:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Content-Language: en-US
To: Jerry Snitselaar <jsnitsel@redhat.com>, Steve Wahl <steve.wahl@hpe.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
 <20220613205734.3x7i46bnsofzerr4@cantor>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220613205734.3x7i46bnsofzerr4@cantor>
Cc: Dimitri Sivanich <sivanich@hpe.com>, Joerg Roedel <jroedel@suse.de>,
 Russ Anderson <russ.anderson@hpe.com>, Mike Travis <mike.travis@hpe.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Kyung Min Park <kyung.min.park@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On 2022/6/14 04:57, Jerry Snitselaar wrote:
> On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
>> To support up to 64 sockets with 10 DMAR units each (640), make the
>> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
>> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
>> set.
>>
>> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
>> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
>> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
>> remapping doesn't support X2APIC mode x2apic disabled"; and the system
>> fails to boot properly.
>>
>> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
>> ---
>>
>> Note that we could not find a reason for connecting
>> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
>> it seemed like the two would continue to match on earlier processors.
>> There doesn't appear to be kernel code that assumes that the value of
>> one is related to the other.
>>
>> v2: Make this value a config option, rather than a fixed constant.  The default
>> values should match previous configuration except in the MAXSMP case.  Keeping the
>> value at a power of two was requested by Kevin Tian.
>>
>>   drivers/iommu/intel/Kconfig | 6 ++++++
>>   include/linux/dmar.h        | 6 +-----
>>   2 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>> index 247d0f2d5fdf..fdbda77ac21e 100644
>> --- a/drivers/iommu/intel/Kconfig
>> +++ b/drivers/iommu/intel/Kconfig
>> @@ -9,6 +9,12 @@ config DMAR_PERF
>>   config DMAR_DEBUG
>>   	bool
>>   
>> +config DMAR_UNITS_SUPPORTED
>> +	int "Number of DMA Remapping Units supported"
> 
> Also, should there be a "depends on (X86 || IA64)" here?

Do you have any compilation errors or warnings?

Best regards,
baolu

> 
>> +	default 1024 if MAXSMP
>> +	default 128  if X86_64
>> +	default 64
>> +
>>   config INTEL_IOMMU
>>   	bool "Support for Intel IOMMU using DMA Remapping Devices"
>>   	depends on PCI_MSI && ACPI && (X86 || IA64)
>> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
>> index 45e903d84733..0c03c1845c23 100644
>> --- a/include/linux/dmar.h
>> +++ b/include/linux/dmar.h
>> @@ -18,11 +18,7 @@
>>   
>>   struct acpi_dmar_header;
>>   
>> -#ifdef	CONFIG_X86
>> -# define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
>> -#else
>> -# define	DMAR_UNITS_SUPPORTED	64
>> -#endif
>> +#define	DMAR_UNITS_SUPPORTED	CONFIG_DMAR_UNITS_SUPPORTED
>>   
>>   /* DMAR Flags */
>>   #define DMAR_INTR_REMAP		0x1
>> -- 
>> 2.26.2
>>
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
