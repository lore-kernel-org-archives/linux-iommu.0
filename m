Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05985C35679
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 07:17:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D1EA20714
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 07:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1EA20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 370D486252;
	Mon, 24 Feb 2020 07:17:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vxWvVkxLPw2w; Mon, 24 Feb 2020 07:17:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 02BA986117;
	Mon, 24 Feb 2020 07:17:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCD8EC07FF;
	Mon, 24 Feb 2020 07:17:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E853C0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 07:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 07C7B85A6E
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 07:17:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5VCgoTlf8-aQ for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 07:17:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2FC37859E3
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 07:17:45 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 8238FEBECE607EF86A2F;
 Mon, 24 Feb 2020 15:17:36 +0800 (CST)
Received: from [127.0.0.1] (10.67.101.242) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Feb 2020
 15:17:28 +0800
Subject: Re: [PATCH] uacce: unmap remaining mmapping from user space
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Herbert Xu
 <herbert@gondor.apana.org.au>, <jonathan.cameron@huawei.com>,
 <dave.jiang@intel.com>, <grant.likely@arm.com>, jean-philippe
 <jean-philippe@linaro.org>, Jerome Glisse <jglisse@redhat.com>,
 <ilias.apalodimas@linaro.org>, <francois.ozog@linaro.org>,
 <kenneth-lee-2012@foxmail.com>, Wangzhou <wangzhou1@hisilicon.com>, "haojian
 . zhuang" <haojian.zhuang@linaro.org>, <guodong.xu@linaro.org>
References: <1582528016-2873-1-git-send-email-zhangfei.gao@linaro.org>
From: Xu Zaibo <xuzaibo@huawei.com>
Message-ID: <a4716453-0607-d613-e632-173d1ebc424e@huawei.com>
Date: Mon, 24 Feb 2020 15:17:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <1582528016-2873-1-git-send-email-zhangfei.gao@linaro.org>
X-Originating-IP: [10.67.101.242]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-accelerators@lists.ozlabs.org, linux-crypto@vger.kernel.org
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

Hi Zhangfei,


On 2020/2/24 15:06, Zhangfei Gao wrote:
> When uacce parent device module is removed, user app may
> still keep the mmaped area, which can be accessed unsafely.
> When rmmod, Parent device drvier will call uacce_remove,
> which unmap all remaining mapping from user space for safety.
> VM_FAULT_SIGBUS is also reported to user space accordingly.
>
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>   drivers/misc/uacce/uacce.c | 17 +++++++++++++++++
>   include/linux/uacce.h      |  2 ++
>   2 files changed, 19 insertions(+)
>
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index ffced4d..1bcc5e6 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -224,6 +224,7 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
>   
>   	init_waitqueue_head(&q->wait);
>   	filep->private_data = q;
> +	uacce->inode = inode;
>   	q->state = UACCE_Q_INIT;
>   
>   	return 0;
> @@ -253,6 +254,14 @@ static int uacce_fops_release(struct inode *inode, struct file *filep)
>   	return 0;
>   }
>   
> +static vm_fault_t uacce_vma_fault(struct vm_fault *vmf)
> +{
> +	if (vmf->flags & (FAULT_FLAG_MKWRITE | FAULT_FLAG_WRITE))
> +		return VM_FAULT_SIGBUS;
> +
> +	return 0;
> +}
> +
>   static void uacce_vma_close(struct vm_area_struct *vma)
>   {
>   	struct uacce_queue *q = vma->vm_private_data;
> @@ -265,6 +274,7 @@ static void uacce_vma_close(struct vm_area_struct *vma)
>   }
>   
>   static const struct vm_operations_struct uacce_vm_ops = {
> +	.fault = uacce_vma_fault,
>   	.close = uacce_vma_close,
>   };
>   
> @@ -585,6 +595,13 @@ void uacce_remove(struct uacce_device *uacce)
>   		cdev_device_del(uacce->cdev, &uacce->dev);
>   	xa_erase(&uacce_xa, uacce->dev_id);
>   	put_device(&uacce->dev);
> +
> +	/*
> +	 * unmap remainning mapping from user space, preventing user still
> +	 * access the mmaped area while parent device is already removed
> +	 */
> +	if (uacce->inode)
> +		unmap_mapping_range(uacce->inode->i_mapping, 0, 0, 1);
Should we unmap them at the first of 'uacce_remove',  and before 
'uacce_put_queue'?

Thanks,
Zaibo

.
>   }
>   EXPORT_SYMBOL_GPL(uacce_remove);
>   
> diff --git a/include/linux/uacce.h b/include/linux/uacce.h
> index 904a461..0e215e6 100644
> --- a/include/linux/uacce.h
> +++ b/include/linux/uacce.h
> @@ -98,6 +98,7 @@ struct uacce_queue {
>    * @priv: private pointer of the uacce
>    * @mm_list: list head of uacce_mm->list
>    * @mm_lock: lock for mm_list
> + * @inode: core vfs
>    */
>   struct uacce_device {
>   	const char *algs;
> @@ -113,6 +114,7 @@ struct uacce_device {
>   	void *priv;
>   	struct list_head mm_list;
>   	struct mutex mm_lock;
> +	struct inode *inode;
>   };
>   
>   /**


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
