Return-Path: <SRS0=k9Qp=3L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE092C32771
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 05:00:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A482D21835
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 05:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A482D21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6829C20764;
	Wed, 22 Jan 2020 05:00:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ElAlB2RsN3gO; Wed, 22 Jan 2020 05:00:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2F30E20495;
	Wed, 22 Jan 2020 05:00:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 186C7C0176;
	Wed, 22 Jan 2020 05:00:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C42AC0174
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 05:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3E6B785F97
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 05:00:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KjmV6N1KgMBT for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jan 2020 05:00:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 80B8E85F7F
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 05:00:14 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Jan 2020 21:00:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,348,1574150400"; d="scan'208";a="215782796"
Received: from allen-box.sh.intel.com (HELO [10.239.159.138])
 ([10.239.159.138])
 by orsmga007.jf.intel.com with ESMTP; 21 Jan 2020 21:00:11 -0800
Subject: Re: [RFC PATCH 0/4] iommu: Per-group default domain type
To: John Garry <john.garry@huawei.com>, Joerg Roedel <joro@8bytes.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20200101052648.14295-1-baolu.lu@linux.intel.com>
 <ba7a7e6a-8b23-fca0-a8bb-72c4dbfa8390@huawei.com>
 <f417cd0b-1bf7-7da2-3a64-b8b74b03da02@linux.intel.com>
 <0fbcbd62-cf8a-1c3c-c702-f9bf59497867@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3bf07c3c-2a49-9aba-6835-53e4e80da4a2@linux.intel.com>
Date: Wed, 22 Jan 2020 12:58:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0fbcbd62-cf8a-1c3c-c702-f9bf59497867@huawei.com>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Hi,

On 1/21/20 6:14 PM, John Garry wrote:
> On 21/01/2020 00:43, Lu Baolu wrote:
>>>> An IOMMU group represents the smallest set of devices that are 
>>>> considered
>>>> to be isolated. All devices belonging to an IOMMU group share a default
>>>> domain for DMA APIs. There are two types of default domain: 
>>>> IOMMU_DOMAIN_DMA
>>>> and IOMMU_DOMAIN_IDENTITY. The former means IOMMU translation, while 
>>>> the
>>>> latter means IOMMU by-pass.
>>>>
>>>> Currently, the default domain type for the IOMMU groups is determined
>>>> globally. All IOMMU groups use a single default domain type. The global
>>>> default domain type can be adjusted by kernel build configuration or
>>>> kernel parameters.
>>>>
>>>> More and more users are looking forward to a fine grained default 
>>>> domain
>>>> type. For example, with the global default domain type set to 
>>>> translation,
>>>> the OEM verndors or end users might want some trusted and fast-speed 
>>>> devices
>>>> to bypass IOMMU for performance gains. On the other hand, with global
>>>> default domain type set to by-pass, some devices with limited system
>>>> memory addressing capability might want IOMMU translation to remove the
>>>> bounce buffer overhead.
>>>
>>> Hi Lu Baolu,
>>>
>>> Do you think that it would be a more common usecase to want 
>>> kernel-managed devices to be passthrough for performance reasons and 
>>> some select devices to be in DMA domain, like those with limited 
>>> address cap or whose drivers request huge amounts of memory?
>>>
>>> I just think it would be more manageable to set kernel commandline 
>>> parameters for this, i.e. those select few which want DMA domain.
>>>
> 
> Hi Baolu,
> 
>>
>> It's just two sides of a coin. Currently, iommu subsystem make DMA
>> domain by default, that's the reason why I selected to let user set
>> which devices are willing to use identity domains.
>>
> 
> OK, understood.
> 
> There was an alternate solution here which would allow per-group type to 
> be updated via sysfs:
> 
> https://lore.kernel.org/linux-iommu/cover.1566353521.git.sai.praneeth.prakhya@intel.com/ 
> 

Yes. My patch set just tries to do this statically during boot time.

> 
> Any idea what happened to that?

No idea. Sai might have more information. :-)

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
