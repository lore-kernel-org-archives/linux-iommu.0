Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95907C433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 11:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2FA7D4056C;
	Thu,  9 Dec 2021 11:56:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9bgKss-PyHvt; Thu,  9 Dec 2021 11:56:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 284AD4017E;
	Thu,  9 Dec 2021 11:56:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B835C001E;
	Thu,  9 Dec 2021 11:56:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 394F5C0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 11:56:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2015C41BE3
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 11:56:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aMVFO5XqHTgn for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 11:56:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2E7941BDF
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 11:56:44 +0000 (UTC)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J8stn46jbz91WH;
 Thu,  9 Dec 2021 19:56:01 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 19:56:41 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 9 Dec
 2021 19:56:40 +0800
Subject: Re: [PATCH] iommu/iova: wait 'fq_timer' handler to finish before
 destroying 'fq'
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
 <linux-kernel@vger.kernel.org>
References: <1564219269-14346-1-git-send-email-wangxiongfeng2@huawei.com>
Message-ID: <fc15a310-14b0-507d-8e4a-f8d4f9e8e573@huawei.com>
Date: Thu, 9 Dec 2021 19:56:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1564219269-14346-1-git-send-email-wangxiongfeng2@huawei.com>
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Hi Joerg,

Sorry to ping you. It's just that the isssue same still exists in the mainline.
Do you have any suggestion about this patch.

Thanks,
Xiongfeng.

On 2019/7/27 17:21, Xiongfeng Wang wrote:
> Fix following crash that occurs when 'fq_flush_timeout()' access
> 'fq->lock' while 'iovad->fq' has been cleared. This happens when the
> 'fq_timer' handler is being executed and we call
> 'free_iova_flush_queue()'. When the timer handler is being executed,
> its pending state is cleared and it is detached. This patch use
> 'del_timer_sync()' to wait for the timer handler 'fq_flush_timeout()' to
> finish before destroying the flush queue.
> 
> [ 9052.361840] Unable to handle kernel paging request at virtual address 0000a02fd6c66008
> [ 9052.361843] Mem abort info:
> [ 9052.361845]   ESR = 0x96000004
> [ 9052.361847]   Exception class = DABT (current EL), IL = 32 bits
> [ 9052.361849]   SET = 0, FnV = 0
> [ 9052.361850]   EA = 0, S1PTW = 0
> [ 9052.361852] Data abort info:
> [ 9052.361853]   ISV = 0, ISS = 0x00000004
> [ 9052.361855]   CM = 0, WnR = 0
> [ 9052.361860] user pgtable: 4k pages, 48-bit VAs, pgdp = 000000009b665b91
> [ 9052.361863] [0000a02fd6c66008] pgd=0000000000000000
> [ 9052.361870] Internal error: Oops: 96000004 [#1] SMP
> [ 9052.361873] Process rmmod (pid: 51122, stack limit = 0x000000003f5524f7)
> [ 9052.361881] CPU: 69 PID: 51122 Comm: rmmod Kdump: loaded Tainted: G           OE     4.19.36-vhulk1906.3.0.h356.eulerosv2r8.aarch64 #1
> [ 9052.361882] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 0.81 07/10/2019
> [ 9052.361885] pstate: 80400089 (Nzcv daIf +PAN -UAO)
> [ 9052.361902] pc : fq_flush_timeout+0x9c/0x110
> [ 9052.361904] lr :           (null)
> [ 9052.361906] sp : ffff00000965bd80
> [ 9052.361907] x29: ffff00000965bd80 x28: 0000000000000202
> [ 9052.361912] x27: 0000000000000000 x26: 0000000000000053
> [ 9052.361915] x25: ffffa026ed805008 x24: ffff000009119810
> [ 9052.361919] x23: ffff00000911b938 x22: ffff00000911bc04
> [ 9052.361922] x21: ffffa026ed804f28 x20: 0000a02fd6c66008
> [ 9052.361926] x19: 0000a02fd6c64000 x18: ffff000009117000
> [ 9052.361929] x17: 0000000000000008 x16: 0000000000000000
> [ 9052.361933] x15: ffff000009119708 x14: 0000000000000115
> [ 9052.361936] x13: ffff0000092f09d7 x12: 0000000000000000
> [ 9052.361940] x11: 0000000000000001 x10: ffff00000965be98
> [ 9052.361943] x9 : 0000000000000000 x8 : 0000000000000007
> [ 9052.361947] x7 : 0000000000000010 x6 : 000000d658b784ef
> [ 9052.361950] x5 : 00ffffffffffffff x4 : 00000000ffffffff
> [ 9052.361954] x3 : 0000000000000013 x2 : 0000000000000001
> [ 9052.361957] x1 : 0000000000000000 x0 : 0000a02fd6c66008
> [ 9052.361961] Call trace:
> [ 9052.361967]  fq_flush_timeout+0x9c/0x110
> [ 9052.361976]  call_timer_fn+0x34/0x178
> [ 9052.361980]  expire_timers+0xec/0x158
> [ 9052.361983]  run_timer_softirq+0xc0/0x1f8
> [ 9052.361987]  __do_softirq+0x120/0x324
> [ 9052.361995]  irq_exit+0x11c/0x140
> [ 9052.362003]  __handle_domain_irq+0x6c/0xc0
> [ 9052.362005]  gic_handle_irq+0x6c/0x150
> [ 9052.362008]  el1_irq+0xb8/0x140
> [ 9052.362010]  vprintk_emit+0x2b4/0x320
> [ 9052.362013]  vprintk_default+0x54/0x90
> [ 9052.362016]  vprintk_func+0xa0/0x150
> [ 9052.362019]  printk+0x74/0x94
> [ 9052.362034]  nvme_get_smart+0x200/0x220 [nvme]
> [ 9052.362041]  nvme_remove+0x38/0x250 [nvme]
> [ 9052.362051]  pci_device_remove+0x48/0xd8
> [ 9052.362065]  device_release_driver_internal+0x1b4/0x250
> [ 9052.362068]  driver_detach+0x64/0xe8
> [ 9052.362072]  bus_remove_driver+0x64/0x118
> [ 9052.362074]  driver_unregister+0x34/0x60
> [ 9052.362077]  pci_unregister_driver+0x24/0xd8
> [ 9052.362083]  nvme_exit+0x24/0x1754 [nvme]
> [ 9052.362094]  __arm64_sys_delete_module+0x19c/0x2a0
> [ 9052.362102]  el0_svc_common+0x78/0x130
> [ 9052.362106]  el0_svc_handler+0x38/0x78
> [ 9052.362108]  el0_svc+0x8/0xc
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/iommu/iova.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 3e1a8a6..90e8035 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -64,8 +64,7 @@ static void free_iova_flush_queue(struct iova_domain *iovad)
>  	if (!has_iova_flush_queue(iovad))
>  		return;
>  
> -	if (timer_pending(&iovad->fq_timer))
> -		del_timer(&iovad->fq_timer);
> +	del_timer_sync(&iovad->fq_timer);
>  
>  	fq_destroy_all_entries(iovad);
>  
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
