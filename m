Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDAFC43334
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 01:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 724A160E5F;
	Tue, 14 Jun 2022 01:33:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z3SP31DMqZKb; Tue, 14 Jun 2022 01:33:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2FB8960644;
	Tue, 14 Jun 2022 01:33:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D650EC0039;
	Tue, 14 Jun 2022 01:33:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A36CBC002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 01:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A9C040A0F
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 01:33:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lHoOfxtc4nU4 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 01:33:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8956B40917
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 01:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655170425; x=1686706425;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=YvbS/tamQc78iYTNaH9LZbGIaWYjPi6QM3l/BEhgpzk=;
 b=VxFzd56Mb2yJYxIfktkTWGCcSVWyl/QPfUy2VOxf0VpTdK2ZJCbZ/uda
 CUD5We6Ws/NtXUnyNCtwYs6qC9jVirVZs/Mv/TIKxuiqa05bxeO0Be6uN
 eycvPU73/FHZp/Upm1+vcBS4bMSWrG68QitbY85V6+LuYXqBSXCeNxpCr
 LwikO/AVMD+hgVJ7wpyXfcXhMY+t24jznhgeCQys6wsHp/sEwFDI6qJUK
 Rsi9HZGcl3pqOzt/TpCDxG9f8rIMpRz99u4KpG/QltVE7oUblBoVdkl67
 W6O93RX7gkk0JjH7WtQOWvN8wFLEd0/VFakZ928JbVE9Y1/Fen4Si9i4s Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258913499"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; d="scan'208";a="258913499"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 18:33:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; d="scan'208";a="910695106"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39])
 ([10.255.29.39])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 18:33:35 -0700
Message-ID: <a827193a-2cd3-7d9f-1bb2-3f4be6ae193e@linux.intel.com>
Date: Tue, 14 Jun 2022 09:33:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Content-Language: en-US
To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
 <20220613203842.zyncvndwfauef2yh@cantor>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220613203842.zyncvndwfauef2yh@cantor>
Cc: Dimitri Sivanich <sivanich@hpe.com>, Joerg Roedel <jroedel@suse.de>,
 Russ Anderson <russ.anderson@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
 Mike Travis <mike.travis@hpe.com>, Will Deacon <will@kernel.org>,
 Kyung Min Park <kyung.min.park@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

On 2022/6/14 04:38, Jerry Snitselaar wrote:
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
> 
> Baolu do you have this queued up for v5.20? Also do you have a public repo where
> you keep the vt-d changes before sending Joerg the patches for a release?

Yes. I have started to queue patches for v5.20. They could be found on
github:

https://github.com/LuBaolu/intel-iommu/commits/vtd-next-for-v5.20

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
