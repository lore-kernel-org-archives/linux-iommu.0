Return-Path: <SRS0=AFVC=6N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FB6C83006
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 05:42:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6312072A
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 05:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6312072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1CC14871F4;
	Wed, 29 Apr 2020 05:42:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zL1CxXFZe-rW; Wed, 29 Apr 2020 05:42:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5E10A8708C;
	Wed, 29 Apr 2020 05:42:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44F06C0864;
	Wed, 29 Apr 2020 05:42:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49096C0172;
 Wed, 29 Apr 2020 05:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 34483871F4;
 Wed, 29 Apr 2020 05:42:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KvSWnKpJxaAg; Wed, 29 Apr 2020 05:42:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6C4F88708C;
 Wed, 29 Apr 2020 05:42:21 +0000 (UTC)
IronPort-SDR: J0SB+HmbF+jr9rPMyEps5hbojuGSOpyr4yz5pd2eVTs81yap9o016VBx3reDKEduO0ytk/+KW2
 0uvap25e1ijw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2020 22:42:20 -0700
IronPort-SDR: M3YsKHaDWz7UDbX8ZjfR5lNn57yOKCtKJGxNvx0P6bF/G4LQXMY+brLeZaZvU9OmE76njqtSIJ
 FJ4I9ZUu56qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,330,1583222400"; d="scan'208";a="404933646"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.254])
 ([10.254.210.254])
 by orsmga004.jf.intel.com with ESMTP; 28 Apr 2020 22:42:14 -0700
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
Date: Wed, 29 Apr 2020 13:42:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429004531-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org, will@kernel.org,
 konrad.wilk@oracle.com, jan.kiszka@siemens.com, jasowang@redhat.com,
 Srivatsa Vaddagiri <vatsa@codeaurora.org>, christoffer.dall@arm.com,
 pratikp@codeaurora.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com,
 alex.bennee@linaro.org, linux-kernel@vger.kernel.org
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

On 2020/4/29 12:57, Michael S. Tsirkin wrote:
> On Wed, Apr 29, 2020 at 10:22:32AM +0800, Lu Baolu wrote:
>> On 2020/4/29 4:41, Michael S. Tsirkin wrote:
>>> On Tue, Apr 28, 2020 at 11:19:52PM +0530, Srivatsa Vaddagiri wrote:
>>>> * Michael S. Tsirkin<mst@redhat.com>  [2020-04-28 12:17:57]:
>>>>
>>>>> Okay, but how is all this virtio specific?  For example, why not allow
>>>>> separate swiotlbs for any type of device?
>>>>> For example, this might make sense if a given device is from a
>>>>> different, less trusted vendor.
>>>> Is swiotlb commonly used for multiple devices that may be on different trust
>>>> boundaries (and not behind a hardware iommu)?
>>> Even a hardware iommu does not imply a 100% security from malicious
>>> hardware. First lots of people use iommu=pt for performance reasons.
>>> Second even without pt, unmaps are often batched, and sub-page buffers
>>> might be used for DMA, so we are not 100% protected at all times.
>>>
>>
>> For untrusted devices, IOMMU is forced on even iommu=pt is used;
> 
> I think you are talking about untrusted *drivers* like with VFIO.

No. I am talking about untrusted devices like thunderbolt peripherals.
We always trust drivers hosted in kernel and the DMA APIs are designed
for them, right?

Please refer to this series.

https://lkml.org/lkml/2019/9/6/39

Best regards,
baolu

> 
> On the other hand, I am talking about things like thunderbolt
> peripherals being less trusted than on-board ones.



> 
> Or possibly even using swiotlb for specific use-cases where
> speed is less of an issue.
> 
> E.g. my wifi is pretty slow anyway, and that card is exposed to
> malicious actors all the time, put just that behind swiotlb
> for security, and leave my graphics card with pt since
> I'm trusting it with secrets anyway.
> 
> 
>> and
>> iotlb flush is in strict mode (no batched flushes); ATS is also not
>> allowed. Swiotlb is used to protect sub-page buffers since IOMMU can
>> only apply page granularity protection. Swiotlb is now used for devices
>> from different trust zone.
>>
>> Best regards,
>> baolu
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
