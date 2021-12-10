Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037C1C433EF
	for <iommu@archiver.kernel.org>; Fri, 10 Dec 2021 01:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9254640ADD;
	Fri, 10 Dec 2021 01:56:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m3Fd1EqtBrG0; Fri, 10 Dec 2021 01:56:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1BA3240ADE;
	Fri, 10 Dec 2021 01:56:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBA2BC001E;
	Fri, 10 Dec 2021 01:56:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55351C0012
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 01:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39DA140AE7
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 01:56:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s_NNHsTfAIWG for <iommu@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 01:56:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4AB740AB1
 for <iommu@lists.linux-foundation.org>; Fri, 10 Dec 2021 01:56:02 +0000 (UTC)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J9DSf2zBkzZdSk;
 Fri, 10 Dec 2021 09:53:06 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 09:55:59 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 10 Dec
 2021 09:55:58 +0800
Subject: Re: [PATCH] iommu/iova: wait 'fq_timer' handler to finish before
 destroying 'fq'
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <1564219269-14346-1-git-send-email-wangxiongfeng2@huawei.com>
 <ef2c9b27-a644-928d-5bae-1ae4d2f2c099@arm.com>
 <ebfebc58-10b5-c12e-edbe-a22181721c2d@arm.com>
Message-ID: <c414965e-16cf-32a4-14c3-4f3793086695@huawei.com>
Date: Fri, 10 Dec 2021 09:55:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ebfebc58-10b5-c12e-edbe-a22181721c2d@arm.com>
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Cc: yaohongbo@huawei.com, huawei.libin@huawei.com
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
From: Xiongfeng Wang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2021/12/10 1:48, Robin Murphy wrote:
> On 2021-12-09 13:17, Robin Murphy wrote:
>> Sorry I missed this before...
>>
>> On 2019-07-27 10:21, Xiongfeng Wang wrote:
>>> Fix following crash that occurs when 'fq_flush_timeout()' access
>>> 'fq->lock' while 'iovad->fq' has been cleared. This happens when the
>>> 'fq_timer' handler is being executed and we call
>>> 'free_iova_flush_queue()'. When the timer handler is being executed,
>>> its pending state is cleared and it is detached. This patch use
>>> 'del_timer_sync()' to wait for the timer handler 'fq_flush_timeout()' to
>>> finish before destroying the flush queue.
>>
>> So if I understand correctly, you shut down the device - which naturally frees
>> some DMA mappings into the FQ - then hotplug it out, such that tearing down
>> its group and default domain can end up racing with the timeout firing on a
>> different CPU? It would help if the commit message actually explained that -
>> I've just reverse-engineered it from the given symptom - rather than focusing
>> on details that aren't really important. fq->lock is hardly significant, since
>> *any* access to the FQ while it's being destroyed is fundamentally unsound. I
>> also spent way too long trying to understand the significance of the full
>> stack trace below before realising that it is in fact just irrelevant -
>> there's only one way fq_flush_timeout() ever gets called, and it's the obvious
>> one.
>>
>> The fix itself seems reasonable - the kerneldoc for del_timer_sync() is
>> slightly scary, but since free_iova_flush_queue() doesn't touch any of the
>> locks and definitely shouldn't run in IRQ context I believe we're OK.

Our internal version has merged this modification for about two years and didn't
cause any problems. So I think we're OK.

>>
>> This will affect my IOVA refactoring series a little, so I'm happy to help
>> improve the writeup if you like - provided that my understanding is actually
>> correct - and include it in a v2 of that.
> 
> FWIW, this is what I came up with:
> 
> https://gitlab.arm.com/linux-arm/linux-rm/-/commit/ecea6835baca75b945bd8ecfaa636ff01dabcc1d
> 
> 
> Let me know what you think.

Thanks for the writeup. It is exactly the situation I came across.

Thanks,
Xiongfeng

> 
> Thanks,
> Robin.
> .
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
