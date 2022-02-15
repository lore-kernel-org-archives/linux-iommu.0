Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC849C433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 01:26:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FB22410E7;
	Tue, 15 Feb 2022 01:26:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IseH8sceM61G; Tue, 15 Feb 2022 01:26:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4EA53410D4;
	Tue, 15 Feb 2022 01:26:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FB06C001A;
	Tue, 15 Feb 2022 01:26:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1F4AC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 01:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77BED410E7
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 01:26:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yDq89FKhJSxj for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 01:26:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1BA8D411C6
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 01:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644888368; x=1676424368;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=cB516WHICBMVCfyEMJJW3zZzqDHx0ua5ykKXoZ04vNk=;
 b=evL/LBnqr0wMDcEH4o99ddEX2RtUgBETrFCgQLBGPXV8qIa9FvH0yrcl
 pE0TZT/3mfxE1Gn/GNo2iPWvQ5ZNfIHVoGdBo/fhRGTmuYh9ctOcgkyh8
 sXhRe3/yat4vDzXEKBYP3Vh3eV+45jj5HRxTOPSfp3SGNxFGRhJgcGi+Z
 wykKnBIA8ESdOAd9T+uCmk7OZ7EkWlz0O3MDNAXKATgrB2G6IclZRj9km
 c6G1Cda3zynOeJUiy/mUmF4K2KX+2e9JRYldAzo6lJN/IK8hSCQgiSy9W
 bADW+GkeL1IogeK9Oj5zPI8LOAmxCM3Rx5HLKa9Ze6P8OAqgtOhStcRVC w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="247818100"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="247818100"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2022 17:26:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; d="scan'208";a="680785249"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 17:26:04 -0800
Message-ID: <464ca69f-7f59-bb1e-45f9-f352d80fbcbe@linux.intel.com>
Date: Tue, 15 Feb 2022 09:24:46 +0800
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
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <CAHKZfL3os22ADrC=C3JVO-4h-hAa_cLYNq7c3_+vo3jkbtrCrg@mail.gmail.com>
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

On 2/14/22 5:32 PM, Huang Adrian wrote:
> Hi Baolu,
> 
> On Mon, Feb 14, 2022 at 8:35 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> Hi Adrian,
>>
>>> The solution is to prevent from allocating pasid table if those
>>> devices are subdevices of the VMD device.
>>
>> Thanks for your patch!
>>
>> Is this the only patch that is needed to make VMD devices work in VT-d
>> scalable mode?
> 
> Yes, it is. With this patch, the system can boot successfully and the
> RAID device connected to the VMD device can be recognized by the host
> OS. I also ran a simple IO stress on the RAID device by compiling
> kernel `$ make -j $(nproc)`. Everything looks good.

Thank you! So how far should this patch be back ported? Can you please
add a Fixes tag?

> 
> -- Adrian

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
