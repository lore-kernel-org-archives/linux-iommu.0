Return-Path: <SRS0=aVDl=HK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4383BC433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 08:14:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE54964E83
	for <iommu@archiver.kernel.org>; Mon,  8 Feb 2021 08:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE54964E83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 99C3420133;
	Mon,  8 Feb 2021 08:14:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AK6+YlJne+Ta; Mon,  8 Feb 2021 08:14:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7BDA1203CA;
	Mon,  8 Feb 2021 08:14:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56292C0174;
	Mon,  8 Feb 2021 08:14:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1560BC013A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 08:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 106368674A
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 08:14:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a6314-TpI1+a for <iommu@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 08:14:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C45A9866AF
 for <iommu@lists.linux-foundation.org>; Mon,  8 Feb 2021 08:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612772081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QRxWJ7WNsR3Y9yvptpnpz6C31b3RRDtBV5Rnzs7rDTo=;
 b=S0dewj6BbiQ05bXb9AcJ8tHf1kAVAKhauyRb0LlEUQAqOx91JnYrk1jXs/BC6/OmP2le1g
 uhl+VnBRkvGp1Y4NBapVrmuTNFjUKS6/cL2HDuTvrHzh6o2acjI61+lh4PI7Y52yjzqAMn
 ffYiWWnZoY3C/dWYyMQBxGny6ddmIiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-55cpkyl3N_GRgxFi1ZUuqA-1; Mon, 08 Feb 2021 03:14:39 -0500
X-MC-Unique: 55cpkyl3N_GRgxFi1ZUuqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5299100CCE4;
 Mon,  8 Feb 2021 08:14:36 +0000 (UTC)
Received: from [10.36.113.240] (ovpn-113-240.ams2.redhat.com [10.36.113.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EF6F18EC5;
 Mon,  8 Feb 2021 08:14:29 +0000 (UTC)
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory pin
To: Zhou Wang <wangzhou1@hisilicon.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linux-api@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a587bd61-9194-4b46-c122-8b4da7b941a8@redhat.com>
Date: Mon, 8 Feb 2021 09:14:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Sihang Chen <chensihang1@hisilicon.com>, jgg@ziepe.ca,
 gregkh@linuxfoundation.org, zhangfei.gao@linaro.org, liguozhu@hisilicon.com
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

On 07.02.21 09:18, Zhou Wang wrote:
> SVA(share virtual address) offers a way for device to share process virtual
> address space safely, which makes more convenient for user space device
> driver coding. However, IO page faults may happen when doing DMA
> operations. As the latency of IO page fault is relatively big, DMA
> performance will be affected severely when there are IO page faults.
>  From a long term view, DMA performance will be not stable.
> 
> In high-performance I/O cases, accelerators might want to perform
> I/O on a memory without IO page faults which can result in dramatically
> increased latency. Current memory related APIs could not achieve this
> requirement, e.g. mlock can only avoid memory to swap to backup device,
> page migration can still trigger IO page fault.
> 
> Various drivers working under traditional non-SVA mode are using
> their own specific ioctl to do pin. Such ioctl can be seen in v4l2,
> gpu, infiniband, media, vfio, etc. Drivers are usually doing dma
> mapping while doing pin.
> 
> But, in SVA mode, pin could be a common need which isn't necessarily
> bound with any drivers, and neither is dma mapping needed by drivers
> since devices are using the virtual address of CPU. Thus, It is better
> to introduce a new common syscall for it.
> 
> This patch leverages the design of userfaultfd and adds mempinfd for pin
> to avoid messing up mm_struct. A fd will be got by mempinfd, then user
> space can do pin/unpin pages by ioctls of this fd, all pinned pages under
> one file will be unpinned in file release process. Like pin page cases in
> other places, can_do_mlock is used to check permission and input
> parameters.
> 
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> Signed-off-by: Sihang Chen <chensihang1@hisilicon.com>
> Suggested-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>   arch/arm64/include/asm/unistd.h   |   2 +-
>   arch/arm64/include/asm/unistd32.h |   2 +
>   fs/Makefile                       |   1 +
>   fs/mempinfd.c                     | 199 ++++++++++++++++++++++++++++++++++++++
>   include/linux/syscalls.h          |   1 +
>   include/uapi/asm-generic/unistd.h |   4 +-
>   include/uapi/linux/mempinfd.h     |  23 +++++
>   init/Kconfig                      |   6 ++
>   8 files changed, 236 insertions(+), 2 deletions(-)
>   create mode 100644 fs/mempinfd.c
>   create mode 100644 include/uapi/linux/mempinfd.h
> 
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index 86a9d7b3..949788f 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -38,7 +38,7 @@
>   #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
>   #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
>   
> -#define __NR_compat_syscalls		442
> +#define __NR_compat_syscalls		443
>   #endif
>   
>   #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index cccfbbe..3f49529 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -891,6 +891,8 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
>   __SYSCALL(__NR_process_madvise, sys_process_madvise)
>   #define __NR_epoll_pwait2 441
>   __SYSCALL(__NR_epoll_pwait2, compat_sys_epoll_pwait2)
> +#define __NR_mempinfd 442
> +__SYSCALL(__NR_mempinfd, sys_mempinfd)
>   
>   /*
>    * Please add new compat syscalls above this comment and update
> diff --git a/fs/Makefile b/fs/Makefile
> index 999d1a2..e1cbf12 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -54,6 +54,7 @@ obj-$(CONFIG_COREDUMP)		+= coredump.o
>   obj-$(CONFIG_SYSCTL)		+= drop_caches.o
>   
>   obj-$(CONFIG_FHANDLE)		+= fhandle.o
> +obj-$(CONFIG_MEMPINFD)		+= mempinfd.o
>   obj-y				+= iomap/
>   
>   obj-y				+= quota/
> diff --git a/fs/mempinfd.c b/fs/mempinfd.c
> new file mode 100644
> index 0000000..23d3911
> --- /dev/null
> +++ b/fs/mempinfd.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2021 HiSilicon Limited. */
> +#include <linux/anon_inodes.h>
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/mm_types.h>
> +#include <linux/slab.h>
> +#include <linux/syscalls.h>
> +#include <linux/uaccess.h>
> +#include <linux/vmalloc.h>
> +#include <linux/xarray.h>
> +#include <uapi/linux/mempinfd.h>
> +
> +struct mem_pin_container {
> +	struct xarray array;
> +	struct mutex lock;
> +};
> +
> +struct pin_pages {
> +	unsigned long first;
> +	unsigned long nr_pages;
> +	struct page **pages;
> +};
> +
> +static int mempinfd_release(struct inode *inode, struct file *file)
> +{
> +	struct mem_pin_container *priv = file->private_data;
> +	struct pin_pages *p;
> +	unsigned long idx;
> +
> +	xa_for_each(&priv->array, idx, p) {
> +		unpin_user_pages(p->pages, p->nr_pages);
> +		xa_erase(&priv->array, p->first);
> +		vfree(p->pages);
> +		kfree(p);
> +	}
> +
> +	mutex_destroy(&priv->lock);
> +	xa_destroy(&priv->array);
> +	kfree(priv);
> +
> +	return 0;
> +}
> +
> +static int mempinfd_input_check(u64 addr, u64 size)
> +{
> +	if (!size || addr + size < addr)
> +		return -EINVAL;
> +
> +	if (!can_do_mlock())
> +		return -EPERM;
> +
> +	return 0;
> +}
> +
> +static int mem_pin_page(struct mem_pin_container *priv,
> +			struct mem_pin_address *addr)
> +{
> +	unsigned int flags = FOLL_FORCE | FOLL_WRITE;
> +	unsigned long first, last, nr_pages;
> +	struct page **pages;
> +	struct pin_pages *p;
> +	int ret;
> +
> +	if (mempinfd_input_check(addr->addr, addr->size))
> +		return -EINVAL;
> +
> +	first = (addr->addr & PAGE_MASK) >> PAGE_SHIFT;
> +	last = ((addr->addr + addr->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
> +	nr_pages = last - first + 1;
> +
> +	pages = vmalloc(nr_pages * sizeof(struct page *));
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	if (!p) {
> +		ret = -ENOMEM;
> +		goto free;
> +	}
> +
> +	mutex_lock(&priv->lock);
> +
> +	ret = pin_user_pages_fast(addr->addr & PAGE_MASK, nr_pages,
> +				  flags | FOLL_LONGTERM, pages);
> +	if (ret != nr_pages) {
> +		pr_err("mempinfd: Failed to pin page\n");
> +		goto unlock;
> +	}

People are constantly struggling with the effects of long term pinnings 
under user space control, like we already have with vfio and RDMA.

And here we are, adding yet another, easier way to mess with core MM in 
the same way. This feels like a step backwards to me.

-- 
Thanks,

David / dhildenb

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
