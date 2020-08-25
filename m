Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE53C433DF
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 03:18:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E3C207D3
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 03:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E3C207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 56A8A87DF2;
	Tue, 25 Aug 2020 03:18:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zTlyrDu9lpwA; Tue, 25 Aug 2020 03:18:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EED468794A;
	Tue, 25 Aug 2020 03:18:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E04FCC07FF;
	Tue, 25 Aug 2020 03:18:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A27BC0051
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 03:18:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2657887B94
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 03:18:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9utjdcPqWWD7 for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 03:18:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5AA3187B5B
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 03:18:38 +0000 (UTC)
IronPort-SDR: w2CnpUrot15vv4dejxBLEYdo+PoRS81lG4tU5H6yTOLSepyJEwtpSSb4Jy314pGh0Gu0CndVY3
 9J1BXAi7ebWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="153450675"
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; d="scan'208";a="153450675"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2020 20:18:37 -0700
IronPort-SDR: JAxBwfPxBJxqHiuWgjooPlP0PKKHpV1jccNd0dqL8Y1KDhRFDcblAA1ocnzcCLuPd8yErURvlh
 BIByxsbA6JjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; d="scan'208";a="322591044"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2020 20:18:34 -0700
Subject: Re: [PATCH v4 07/15] iommu/vt-d: Delegate the dma domain to upper
 layer
To: Chris Wilson <chris@chris-wilson.co.uk>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
 <20190525054136.27810-8-baolu.lu@linux.intel.com>
 <159803479017.29194.1359332295829225843@build.alporthouse.com>
 <65125687-14ae-182f-da07-7d29b4910364@linux.intel.com>
 <159825811140.30134.5347490249201789397@build.alporthouse.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a6288e81-76de-956a-77e9-bccbcbba366f@linux.intel.com>
Date: Tue, 25 Aug 2020 11:13:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159825811140.30134.5347490249201789397@build.alporthouse.com>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, dima@arista.com,
 tmurphy@arista.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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

Hi Chris,

On 8/24/20 4:35 PM, Chris Wilson wrote:
> Quoting Lu Baolu (2020-08-24 07:31:23)
>> Hi Chris,
>>
>> On 2020/8/22 2:33, Chris Wilson wrote:
>>> Quoting Lu Baolu (2019-05-25 06:41:28)
>>>> This allows the iommu generic layer to allocate a dma domain and
>>>> attach it to a device through the iommu api's. With all types of
>>>> domains being delegated to upper layer, we can remove an internal
>>>> flag which was used to distinguish domains mananged internally or
>>>> externally.
>>>
>>> I'm seeing some really strange behaviour with this patch on a 32b
>>> Skylake system (and still present on mainline). Before this patch
>>> everything is peaceful and appears to work correctly. Applying this patch,
>>> and we fail to initialise the GPU with a few DMAR errors reported, e.g.
>>>
>>> [   20.279445] DMAR: DRHD: handling fault status reg 3
>>> [   20.279508] DMAR: [DMA Read] Request device [00:02.0] fault addr 8900a000 [fault reason 05] PTE Write access is not set
>>>
>>> Setting an identity map for the igfx made the DMAR errors disappear, but
>>> the GPU still failed to initialise.
>>>
>>> There's no difference in the DMAR configuration dmesg between working and
>>> the upset patch. And the really strange part is that switching to a 64b
>>> kernel with this patch, it's working.
>>>
>>> Any suggestions on what I should look for?
>>
>> Can the patch titled "[PATCH] iommu/intel: Handle 36b addressing for
>> x86-32" solve this problem?
> 
> It does. Not sure why, but that mystery I can leave for others.

It's caused by left switching 36 bits operation against a 32-bit
integer. Your patch fixes this by converting the integer from unsigned
long to u64. It looks good to me. Thanks!

> -Chris
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
