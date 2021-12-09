Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938CDC433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 17:48:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A96C6F295;
	Thu,  9 Dec 2021 17:48:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zUtDhXczNEIQ; Thu,  9 Dec 2021 17:48:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0429C6EFB5;
	Thu,  9 Dec 2021 17:48:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7595C001E;
	Thu,  9 Dec 2021 17:48:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92C64C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 17:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7AA1C41F33
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 17:48:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QsQmv2FtPNo5 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 17:48:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 59C9141E16
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 17:48:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89A86ED1;
 Thu,  9 Dec 2021 09:48:10 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DA873F73B;
 Thu,  9 Dec 2021 09:48:09 -0800 (PST)
Message-ID: <ebfebc58-10b5-c12e-edbe-a22181721c2d@arm.com>
Date: Thu, 9 Dec 2021 17:48:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] iommu/iova: wait 'fq_timer' handler to finish before
 destroying 'fq'
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>, joro@8bytes.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1564219269-14346-1-git-send-email-wangxiongfeng2@huawei.com>
 <ef2c9b27-a644-928d-5bae-1ae4d2f2c099@arm.com>
In-Reply-To: <ef2c9b27-a644-928d-5bae-1ae4d2f2c099@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-12-09 13:17, Robin Murphy wrote:
> Sorry I missed this before...
> 
> On 2019-07-27 10:21, Xiongfeng Wang wrote:
>> Fix following crash that occurs when 'fq_flush_timeout()' access
>> 'fq->lock' while 'iovad->fq' has been cleared. This happens when the
>> 'fq_timer' handler is being executed and we call
>> 'free_iova_flush_queue()'. When the timer handler is being executed,
>> its pending state is cleared and it is detached. This patch use
>> 'del_timer_sync()' to wait for the timer handler 'fq_flush_timeout()' to
>> finish before destroying the flush queue.
> 
> So if I understand correctly, you shut down the device - which naturally 
> frees some DMA mappings into the FQ - then hotplug it out, such that 
> tearing down its group and default domain can end up racing with the 
> timeout firing on a different CPU? It would help if the commit message 
> actually explained that - I've just reverse-engineered it from the given 
> symptom - rather than focusing on details that aren't really important. 
> fq->lock is hardly significant, since *any* access to the FQ while it's 
> being destroyed is fundamentally unsound. I also spent way too long 
> trying to understand the significance of the full stack trace below 
> before realising that it is in fact just irrelevant - there's only one 
> way fq_flush_timeout() ever gets called, and it's the obvious one.
> 
> The fix itself seems reasonable - the kerneldoc for del_timer_sync() is 
> slightly scary, but since free_iova_flush_queue() doesn't touch any of 
> the locks and definitely shouldn't run in IRQ context I believe we're OK.
> 
> This will affect my IOVA refactoring series a little, so I'm happy to 
> help improve the writeup if you like - provided that my understanding is 
> actually correct - and include it in a v2 of that.

FWIW, this is what I came up with:

https://gitlab.arm.com/linux-arm/linux-rm/-/commit/ecea6835baca75b945bd8ecfaa636ff01dabcc1d

Let me know what you think.

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
