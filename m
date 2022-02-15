Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CEBC433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 05:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 820A040281;
	Tue, 15 Feb 2022 05:38:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RKEvTYLG5fP7; Tue, 15 Feb 2022 05:38:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4BA5F40271;
	Tue, 15 Feb 2022 05:38:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F2A1C0011;
	Tue, 15 Feb 2022 05:38:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91817C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 05:38:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7FE7860E55
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 05:38:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4NoagQuj6Pra for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 05:38:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 375D360E52
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 05:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644903482; x=1676439482;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=S5jQugc+I51W3SFtT+RXUJT1X5XBR5d3QSUdm3p2O9A=;
 b=imXH3ISFFWg4mIAQfouxGHCDnPlOf6NXjp+ekagiSJtnWNxkPNaqBRhh
 edvV3CBV6uFE0OFb++MzoDpDvD7OZRdfsxRS4miVtuSw+6NtWYzJixQCS
 xSZGCgq7LWHvdT7RjNSDcJB7IMKA2Q+IN1cOgwzcMuove0i8ACv3wgzVf
 ZMV2jc0kBbNP8MUr/uLsKEA1AhEqCdlnO5+cIZUaWEXLjKmaUZHIUT/JE
 BwwVGCicCaMKfYhkQMLWjHOQzhPAROT4awJ2nZSZ4tI0aB+9LM/Ef0Sv+
 SoqwA5EzykHocqK7wV+oU/DtqmkpgQ+egX74uOKgez5kuogt12jsBy0Ga A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="313528310"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="313528310"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2022 21:38:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="680848153"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 21:37:59 -0800
Message-ID: <9272df91-0406-63a6-47d3-a8ae16875fdb@linux.intel.com>
Date: Tue, 15 Feb 2022 13:36:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] iommu/vt-d: Fix list_add double add when enabling VMD and
 scalable mode
Content-Language: en-US
To: Huang Adrian <adrianhuang0701@gmail.com>
References: <20220211024515.21884-1-adrianhuang0701@gmail.com>
 <1627d563-ff48-6204-33be-361db75011f9@linux.intel.com>
 <CAHKZfL3os22ADrC=C3JVO-4h-hAa_cLYNq7c3_+vo3jkbtrCrg@mail.gmail.com>
 <464ca69f-7f59-bb1e-45f9-f352d80fbcbe@linux.intel.com>
 <CAHKZfL2xEybeVu=DWqX6okJd32hU3k4-sauRVA8v-JTedBPwnQ@mail.gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <CAHKZfL2xEybeVu=DWqX6okJd32hU3k4-sauRVA8v-JTedBPwnQ@mail.gmail.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
 Nirmal Patel <nirmal.patel@linux.intel.com>, iommu@lists.linux-foundation.org,
 Adrian Huang <ahuang12@lenovo.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 David Woodhouse <dwmw2@infradead.org>
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

On 2/15/22 12:28 PM, Huang Adrian wrote:
> On Tue, Feb 15, 2022 at 9:26 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> On 2/14/22 5:32 PM, Huang Adrian wrote:
>>> Hi Baolu,
>>>
>>> On Mon, Feb 14, 2022 at 8:35 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>>
>>>> Hi Adrian,
>>>>
>>>>> The solution is to prevent from allocating pasid table if those
>>>>> devices are subdevices of the VMD device.
>>>>
>>>> Thanks for your patch!
>>>>
>>>> Is this the only patch that is needed to make VMD devices work in VT-d
>>>> scalable mode?
>>>
>>> Yes, it is. With this patch, the system can boot successfully and the
>>> RAID device connected to the VMD device can be recognized by the host
>>> OS. I also ran a simple IO stress on the RAID device by compiling
>>> kernel `$ make -j $(nproc)`. Everything looks good.
>>
>> Thank you! So how far should this patch be back ported?
> 
> Thanks for the feedback.
> 
> Do you mean the CC stable kernel tag? Something like: "Cc:
> stable@vger.kernel.org # v5.8+"?
> 
>> Can you please add a Fixes tag?
> 
> Fixes: 0bbeb01a4faf ("iommu/vt-d: Manage scalalble mode PASID tables")
> 
> Do you want me to send a v2 with the CC stable kernel tag and Fixes
> tag? Or, do you just need to take the Fixes tag directly without
> sending a v2?

I don't think we can back port it as far as that. Probably,

Fixes: 2b0140c69637e ("iommu/vt-d: Use pci_real_dma_dev() for mapping")
Cc: stable@vger.kernel.org # v5.6+

Please verify whether v5.6 works with your patch back ported. If it
works, please send a v2 with above tags appended.

> -- Adrian

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
