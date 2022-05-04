Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B93C4332F
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 14:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B366760AB9;
	Wed,  4 May 2022 14:37:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GmNgB3M-jXZV; Wed,  4 May 2022 14:37:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2584460625;
	Wed,  4 May 2022 14:37:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7A68C0039;
	Wed,  4 May 2022 14:37:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1DD6C0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 14:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE06B402A4
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 14:37:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dy9C8hHd6Dv9 for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 14:37:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 25E634029A
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651675031; x=1683211031;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=x8yNkRPcszEI2c/X3ll8pl0xnbd8y7LswHd7vWavS3A=;
 b=TB0Z/Ze5JXZl5fMTAENeHpxDVYB0crjMu48zy2X/rKN8GdlNvgE6GcfS
 tkiID/NwZgp0MHFurqXysc5KBUNmsgUO0/7zfULiGWnb11i1AdG7PYUGW
 H+lgFZJkY5Tl8pni+/CU3JWGktdaiHjjmBHKwaAryTt5g9eAe13Fnyyga
 Bdt/bs3SAmnNTmRpdeZFuP2OBTUr0oL3ZKG7UpzmOzsXi9Q/WvYc5D8fU
 Cv3qYtH8a6afk2UF6mM+F1uaWWtBRHTwGrqzkdv3zzhtP3UufK1WCJZxC
 24/LsNEG0OtK1Bu65QnPjno4U1/gu19BMV5/nNDlxRc5Cmcn/XGTwZKQt g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267937110"
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; d="scan'208";a="267937110"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 07:37:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,198,1647327600"; d="scan'208";a="734423264"
Received: from yanc1-mobl.ccr.corp.intel.com (HELO [10.255.30.223])
 ([10.255.30.223])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 07:37:08 -0700
Message-ID: <16365887-3034-c4b8-da91-eee6a9f976b2@linux.intel.com>
Date: Wed, 4 May 2022 22:37:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/5] iommu/vt-d: Set SNP bit only in second-level page
 table entries
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
 <20220501112434.874236-3-baolu.lu@linux.intel.com>
 <20220502130546.GI8364@nvidia.com>
 <74172660-e9e9-6589-7755-50bcd8b0aca6@linux.intel.com>
 <20220504133142.GE49344@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220504133142.GE49344@nvidia.com>
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

On 2022/5/4 21:31, Jason Gunthorpe wrote:
> On Wed, May 04, 2022 at 03:25:50PM +0800, Baolu Lu wrote:
>> Hi Jason,
>>
>> On 2022/5/2 21:05, Jason Gunthorpe wrote:
>>> On Sun, May 01, 2022 at 07:24:31PM +0800, Lu Baolu wrote:
>>>> The SNP bit is only valid for second-level PTEs. Setting this bit in the
>>>> first-level PTEs has no functional impact because the Intel IOMMU always
>>>> ignores the same bit in first-level PTEs. Anyway, let's check the page
>>>> table type before setting SNP bit in PTEs to make the code more readable.
>>> Shouldn't this be tested before setting force_snooping and not during
>>> every map?
>>
>> The check is in the following patch. This just makes sure that SNP is
>> only set in second-level page table entries.
> 
> I think you should add a 2nd flag to indicate 'set SNP bit in PTEs'
> and take care of computing that flag in the enforce_no_snoop function

Yours looks better. Will add it in the next version.

> Jason

Best regards,
baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
