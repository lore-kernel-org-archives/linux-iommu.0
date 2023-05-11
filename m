Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E3EC9
	for <iommu@lists.linux.dev>; Thu, 11 May 2023 04:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=es1hAOZEanSpUzrO4i+W99kSmiTSzzhtBMlo8JnwlYU=; b=XiM0jwFnKxFWGJpiCOPcZXBOTf
	7Lff2nNv1b4BAaAzu2+8+Z6IL8XztnltccQ/JJuih56T1wL6PGmnGsDk5E0M2IhLX/LK07JbuLSIZ
	7MeUi0RBKlVjXfF2dQ49aEOFQTTDRlx51zHwTVQTE5xRu4I0fDcigOhciITUn6bZwgzkWHvP5GDoh
	2fdZoKkTwbsFp75btQY8vp64HMyDOb8xRvh6sSFXwAn6is5GoyjejZl85uiLUVi+kd01BW70CUhr5
	tVCPkz/2NQ/hoG7jre3wotCKe/XGVrVJE/Z2HuYhiIxeH3PutobfBK7QQ7ocB4hd/asQ7TR+7XP1K
	n3LuDq7A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pwxYC-001apk-2B;
	Thu, 11 May 2023 04:05:08 +0000
Date: Thu, 11 May 2023 05:05:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	jean-philippe <jean-philippe@linaro.org>,
	Wangzhou <wangzhou1@hisilicon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	iommu@lists.linux.dev, acc@lists.linaro.org,
	Weili Qian <qianweili@huawei.com>
Subject: Re: [PATCH] uacce: use filep->f_mapping to replace inode->i_mapping
Message-ID: <20230511040508.GF3390869@ZenIV>
References: <20230511021553.44318-1-zhangfei.gao@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511021553.44318-1-zhangfei.gao@linaro.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 11, 2023 at 10:15:53AM +0800, Zhangfei Gao wrote:
> The inode can be different in a container, for example, a docker and host
> both open the same uacce parent device, which uses the same uacce struct
> but different inode, so uacce->inode is not enough.
> 
> What's worse, when docker stops, the inode will be destroyed as well,
> causing use-after-free in uacce_remove.
> 
> So use q->filep->f_mapping to replace uacce->inode->i_mapping.

> @@ -574,12 +574,6 @@ void uacce_remove(struct uacce_device *uacce)
>  
>  	if (!uacce)
>  		return;
> -	/*
> -	 * unmap remaining mapping from user space, preventing user still
> -	 * access the mmaped area while parent device is already removed
> -	 */
> -	if (uacce->inode)
> -		unmap_mapping_range(uacce->inode->i_mapping, 0, 0, 1);
>  
>  	/*
>  	 * uacce_fops_open() may be running concurrently, even after we remove
> @@ -589,6 +583,8 @@ void uacce_remove(struct uacce_device *uacce)
>  	mutex_lock(&uacce->mutex);
>  	/* ensure no open queue remains */
>  	list_for_each_entry_safe(q, next_q, &uacce->queues, list) {
> +		struct file *filep = q->private_data;
> +
>  		/*
>  		 * Taking q->mutex ensures that fops do not use the defunct
>  		 * uacce->ops after the queue is disabled.
> @@ -597,6 +593,12 @@ void uacce_remove(struct uacce_device *uacce)
>  		uacce_put_queue(q);
>  		mutex_unlock(&q->mutex);
>  		uacce_unbind_queue(q);
> +
> +		/*
> +		 * unmap remaining mapping from user space, preventing user still
> +		 * access the mmaped area while parent device is already removed
> +		 */
> +		unmap_mapping_range(filep->f_mapping, 0, 0, 1);

IDGI.  Going through uacce_queue instead of uacce_device is fine, but why
bother with file *or* inode?  Just store a reference to struct address_space in
your uacce_queue and be done with that...

Another problem in that driver is uacce_vma_close(); this
        if (vma->vm_pgoff < UACCE_MAX_REGION)
                qfr = q->qfrs[vma->vm_pgoff];

        kfree(qfr);
can't be right - you have q->qfrs left pointing to freed object.  If nothing
else, subsequent mmap() will fail with -EEXIST, won't it?
