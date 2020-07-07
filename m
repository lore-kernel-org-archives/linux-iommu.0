Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E306C433DF
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 07:24:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4CEB20702
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 07:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CEB20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B676F84949;
	Tue,  7 Jul 2020 07:24:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TzcumUS-mM20; Tue,  7 Jul 2020 07:24:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1639281C6B;
	Tue,  7 Jul 2020 07:24:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06AC2C0893;
	Tue,  7 Jul 2020 07:24:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9B26C016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 07:24:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F332B8263D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 07:24:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zC1uDvaqK0E4 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 07:24:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 34F8B87F0A
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 07:24:04 +0000 (UTC)
IronPort-SDR: Y8+qWbnqkCHDPTQBzQGxmlpsv7l1HGhx03vE0SlYIt5ytRbnRrXPCge7QDfXnlXQgEzt8om+tX
 a6lD9XajlFbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="135795668"
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; d="scan'208";a="135795668"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 00:24:01 -0700
IronPort-SDR: 7lweS80P5ckMtp50mbg/VWoNPyMhE1JXIAcCTP7xmfNweRPorTbuXso1wFZuqw7JY7k/BIyFQx
 XPJxxdHE0MdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,323,1589266800"; d="scan'208";a="357701412"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.170.85])
 ([10.249.170.85])
 by orsmga001.jf.intel.com with ESMTP; 07 Jul 2020 00:23:58 -0700
Subject: Re: [Issue]platform/x86: iommu: System can't shutdown because iommu
 driver keeps checking the status of DMA_GSTS_TES
To: Koba Ko <koba.ko@canonical.com>
References: <CAJB-X+Ww=bZN2qZ=e=4EkN_RUTiZxHxkdnHh50y9iVqZmT_XQg@mail.gmail.com>
 <111dde48-8018-6d74-5df8-1534143f4de6@linux.intel.com>
 <CAJB-X+WgjKR3PgoF_tn_g__+agCSGJpyB8sh+A62gs0qztDuVQ@mail.gmail.com>
 <66cacbab-b04d-33f3-053e-4d554ac7c662@linux.intel.com>
 <CAJB-X+Uo2yw+SC6X2sfDsG9YusyL9iJAuR0wG_L+KYtSkz=Cmg@mail.gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1b559268-5bf7-a185-4492-c34023b78689@linux.intel.com>
Date: Tue, 7 Jul 2020 15:23:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJB-X+Uo2yw+SC6X2sfDsG9YusyL9iJAuR0wG_L+KYtSkz=Cmg@mail.gmail.com>
Content-Language: en-US
Cc: "Sun, Jian" <jian.sun@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Kai Heng Feng <kai.heng.feng@canonical.com>,
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

Hi Koba KO,

On 2020/7/7 11:27, Koba Ko wrote:
> Dear Baolu,
> On Tue, Jun 30, 2020 at 3:52 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> Hi Koba,
>>
>> On 2020/6/30 15:31, Koba Ko wrote:
>>> On Mon, Jun 15, 2020 at 3:20 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>>
>>>> Hi Koba Ko,
>>>>
>>>> On 2020/6/15 11:19, Koba Ko wrote:
>>>>> hi All,
>>>>> I have a machine and there's only intel gpu.
>>>>> the secureboot and vt-d is enabled in BIOS.
>>>>> On the Ubuntu desktop, I do s2idle first and restart the machine.
>>>>> The machine can't restart successfully, so I need to press the
>>>>> power button to shutdown.
>>>>> I tried  each of the following and the issue can't be triggered.
>>>>> 1. disable secure boot in BIOS.
>>>>> 2. intel_iommu=off.
>>>>> 3. intel_iomm=igfx_off.
>>>>> 4. nomodeset
>>>>> 5. i915.modeset=0.
>>>>>
>>>>> After I investigate further, find inte_iommu keeps checking the status
>>>>> of DMA_GSTS_TES.
>>>>> During the procedure of restart, the driver would disable iommu
>>>>> translation and
>>>>> check status of DMA_GSTS_TES until status of DMA_GSTS_TES is 0.
>>>>>
>>>>> If you need more information, I can provide it.
>>>>
>>>> Do you mind telling what platform is it?
>>>>
>>>> Best regards,
>>>> baolu
>>> Hi Baolu,
>>> Sorry, i missed your email.
>>> I'm running on TGL.
>>> My colleague has reported this on bugzilla.
>>> Have tested your patch and it works fine.
>>> https://bugzilla.kernel.org/show_bug.cgi?id=208363
>>>
>>> Could you explain more about these patches!? Why do we need  a flag
>>> for active iommu!?
>>>
>>
>> We're still investigating this issue. If we find out more, I'll let you
>> know. Thanks a lot for the reporting.
>>
>> Best regards,
>> baolu
>>
> Sorry for disturbing,
> Do you have any updates for this issue?!
> https://bugzilla.kernel.org/show_bug.cgi?id=208363

We are in process of collecting what kind of platforms are affected. I
will push the workaround patch to the community as soon as we are done.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
