Return-Path: <SRS0=k9Qp=3L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B13C2D0DB
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 17:34:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D287C21835
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 17:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D287C21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 84716214E6;
	Wed, 22 Jan 2020 17:34:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yZXreHPKgWjW; Wed, 22 Jan 2020 17:34:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0F34D2034D;
	Wed, 22 Jan 2020 17:34:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAF93C0176;
	Wed, 22 Jan 2020 17:34:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DF9BC0174
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 17:34:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1D688842DD
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 17:34:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 58cJLR_b6ZRL for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jan 2020 17:34:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4C36E841E9
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 17:34:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C97D21FB;
 Wed, 22 Jan 2020 09:34:36 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1D233F6C4;
 Wed, 22 Jan 2020 09:34:35 -0800 (PST)
Subject: Re: [Patch v3 2/3] iommu: optimize iova_magazine_free_pfns()
To: Cong Wang <xiyou.wangcong@gmail.com>
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
 <20191218043951.10534-3-xiyou.wangcong@gmail.com>
 <8ce2f5b6-74e1-9a74-fd80-9ad688beb9b2@arm.com>
 <CAM_iQpXbjf8MuL17kZhxawXYBJm6t5-ho77F_VWR30L-9FS4Kg@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e8789016-858a-b354-aa98-637e1d453fc3@arm.com>
Date: Wed, 22 Jan 2020 17:34:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAM_iQpXbjf8MuL17kZhxawXYBJm6t5-ho77F_VWR30L-9FS4Kg@mail.gmail.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
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

On 21/01/2020 5:29 pm, Cong Wang wrote:
> On Tue, Jan 21, 2020 at 1:52 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 18/12/2019 4:39 am, Cong Wang wrote:
>>> If the magazine is empty, iova_magazine_free_pfns() should
>>> be a nop, however it misses the case of mag->size==0. So we
>>> should just call iova_magazine_empty().
>>>
>>> This should reduce the contention on iovad->iova_rbtree_lock
>>> a little bit, not much at all.
>>
>> Have you measured that in any way? AFAICS the only time this can get
>> called with a non-full magazine is in the CPU hotplug callback, where
>> the impact of taking the rbtree lock and immediately releasing it seems
>> unlikely to be significant on top of everything else involved in that
>> operation.
> 
> This patchset is only tested as a whole, it is not easy to deploy
> each to production and test it separately.
> 
> Is there anything wrong to optimize a CPU hotplug path? :) And,
> it is called in alloc_iova_fast() too when, for example, over-cached.

And if the IOVA space is consumed to the point that we've fallen back to 
that desperate last resort, what do you think the chances are that a 
significant number of percpu magazines will be *empty*? Also bear in 
mind that in that case we've already walked the rbtree once, so any 
notion of still being fast is long, long gone.

As for CPU hotplug, it's a comparatively rare event involving all manner 
of system-wide synchronisation, and the "optimisation" of shaving a few 
dozen CPU cycles off at one point *if* things happen to line up 
correctly is taking a cup of water out of a lake. If the domain is busy 
at the time, then once again chances are the magazines aren't empty and 
having an extra check redundant with the loop condition simply adds 
(trivial, but nonzero) overhead to every call. And if the domain isn't 
busy, then the lock is unlikely to be contended anyway.

Sorry, but without convincing evidence, this change just looks like 
churn for the sake of it.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
