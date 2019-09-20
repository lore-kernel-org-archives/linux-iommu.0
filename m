Return-Path: <SRS0=xPYy=XP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=BODY_QUOTE_MALF_MSGID,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93F8C3A5A2
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 16:36:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0A120640
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 16:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CauVxj6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0A120640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 810E9D85;
	Fri, 20 Sep 2019 16:36:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 213C4ACC
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 16:36:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
	[209.85.208.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BD1278C9
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 16:36:01 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id h33so7030174edh.12
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=7hzm3K7b35rEliLwtwWMBUwsKHdn+N/LZtz2QhNViq0=;
	b=CauVxj6MR1/RdV5hq7nYFTEiAQ38w+HRge127iXApIBR59r3qh4l0aPcKXW0Sbx/5A
	RTg+s1ZfTru6nN27dI2fp0QIy1jAxhK/pl9MW19Gaug4CV+G1dKXBsgMiTLIA2UVybqO
	UAmb13NlHSnT6mnFVOyne6rvTAbrt7Ej9OoVJFCBomxNr65ASSxT8YU4OTkLkMeT4JCj
	+bJsQXHFF0pcImSMExHzjCEk3x1AHLLm2nsUrmzbOQCK69plnVx/IYiZRHQPC+WVubqz
	Aegc9x+DYxt3BFMK0FyToqmU77UgRPf0rQW8PJc0lYgYLh/2uCixziS2U870hMWTxDnf
	gr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=7hzm3K7b35rEliLwtwWMBUwsKHdn+N/LZtz2QhNViq0=;
	b=C+8zyt6ujs1G3bHBWjURexLBk8RCKVDDdewm+M92oBRIAF5Vv8BWftrdvdC5+aZsGD
	wsBaQ80PXgYaz8wRXuO9Ifn9JHRy+E/5DB/oOMBI51aA/nL9K/hF/Y39mrqzJkGZSUql
	tjSB2y0KJH3qx9c6MBPX1tT+6CDXwPFQjEfNof8UjF6XZCkAh5qX4HMtV92bLAAakEkl
	ewJ7d8VfR0kmkGLfI4YMhxkgzW2p8E+6CsY6Z5wOp+BvaAP3oYS/s8zQr+MFaeiY2qUc
	BxY1mYUDBrcFAs/Bj780/eve/ieCUdQ2o4SfVv+KHXaaHwJs7qKby164YhQB6lTO8wPj
	07jw==
X-Gm-Message-State: APjAAAXvqrTp/jlZ4IneRAKzDzj/BkzrT53LFvG4y2Ne8PBxG1bq7NBg
	wgZhXyofz3Lz4L024ldTB70eYw==
X-Google-Smtp-Source: APXvYqzlxtJkxMrObFiFEfMvTttDlFX1Lhn2rxHuQzhFG8RUkiyWTAgaUrjIEHSvAzKzYqD39ju+AQ==
X-Received: by 2002:a50:ee92:: with SMTP id f18mr22835043edr.253.1568997360481;
	Fri, 20 Sep 2019 09:36:00 -0700 (PDT)
Received: from lophozonia ([85.195.192.192])
	by smtp.gmail.com with ESMTPSA id y22sm277918eje.42.2019.09.20.09.35.59
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 20 Sep 2019 09:35:59 -0700 (PDT)
Date: Fri, 20 Sep 2019 18:35:58 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 3/4] iommu/ioasid: Add custom allocators
Message-ID: <20190920163558.GC1533866@lophozonia>
References: <1568849194-47874-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1568849194-47874-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1568849194-47874-4-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed, Sep 18, 2019 at 04:26:33PM -0700, Jacob Pan wrote:
> +/*
> + * struct ioasid_allocator_data - Internal data structure to hold information
> + * about an allocator. There are two types of allocators:
> + *
> + * - Default allocator always has its own XArray to track the IOASIDs allocated.
> + * - Custom allocators may share allocation helpers with different private data.
> + *   Custom allocators share the same helper functions also share the same
> + *   XArray.

"that share the same helper"

> + * Rules:
> + * 1. Default allocator is always available, not dynamically registered. This is
> + *    to prevent race conditions with early boot code that want to register
> + *    custom allocators or allocate IOASIDs.
> + * 2. Custom allocators take precedence over the default allocator.
> + * 3. When all custom allocators sharing the same helper functions are
> + *    unregistered (e.g. due to hotplug), all outstanding IOASIDs must be
> + *    freed.
> + * 4. When switching between custom allocators sharing the same helper
> + *    functions, outstanding IOASIDs are preserved.
> + * 5. When switching between custom allocator and default allocator, all IOASIDs
> + *    must be freed to ensure unadulterated space for the new allocator.
> + *
> + * @ops:	allocator helper functions and its data
> + * @list:	registered custom allocators
> + * @slist:	allocators share the same ops but different data
> + * @flags:	attributes of the allocator
> + * @xa		xarray holds the IOASID space
> + * @users	number of allocators sharing the same ops and XArray
> + */
> +struct ioasid_allocator_data {
> +	struct ioasid_allocator_ops *ops;
> +	struct list_head list;
> +	struct list_head slist;
> +#define IOASID_ALLOCATOR_CUSTOM BIT(0) /* Needs framework to track results */
> +	unsigned long flags;
> +	struct xarray xa;
> +	refcount_t users;
> +};
> +
> +static DEFINE_SPINLOCK(ioasid_allocator_lock);

Thanks for making this a spinlock! I hit that sleep-in-atomic problem
while updating iommu-sva to the new MMU notifier API, which doesn't
allow sleeping in the free() callback.

I don't like having to use GFP_ATOMIC everywhere as a result, but can't
see a better way. Maybe we can improve that later.

[...]
> +/**
> + * ioasid_unregister_allocator - Remove a custom IOASID allocator ops
> + * @ops: the custom allocator to be removed
> + *
> + * Remove an allocator from the list, activate the next allocator in
> + * the order it was registered. Or revert to default allocator if all
> + * custom allocators are unregistered without outstanding IOASIDs.
> + */
> +void ioasid_unregister_allocator(struct ioasid_allocator_ops *ops)
> +{
> +	struct ioasid_allocator_data *pallocator;
> +	struct ioasid_allocator_ops *sops;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	if (list_empty(&allocators_list)) {
> +		pr_warn("No custom IOASID allocators active!\n");
> +		goto exit_unlock;
> +	}
> +
> +	list_for_each_entry(pallocator, &allocators_list, list) {
> +		if (!use_same_ops(pallocator->ops, ops))
> +			continue;
> +
> +		if (refcount_read(&pallocator->users) == 1) {
> +			/* No shared helper functions */
> +			list_del(&pallocator->list);
> +			/*
> +			 * All IOASIDs should have been freed before
> +			 * the last allocator that shares the same ops
> +			 * is unregistered.
> +			 */
> +			WARN_ON(!xa_empty(&pallocator->xa));

The function doc seems to say that we revert to the default allocator
only if there wasn't any outstanding IOASID, which isn't what this does.
To follow the doc, we'd need to return here instead of continuing. The
best solution would be to return with an error, but since we don't
propagate errors I think leaking stuff is preferable to leaving the
allocator registered, since the caller might free the ops when this
function return. So I would keep the code like that but change the
function's comment. What do you think is best?

> +			kfree(pallocator);
> +			if (list_empty(&allocators_list)) {
> +				pr_info("No custom IOASID allocators, switch to default.\n");
> +				active_allocator = &default_allocator;

I'm concerned about the active_allocator variable, because ioasid_find()
accesses it without holding ioasid_allocator_lock. It is holding the RCU
read lock, so I think we need to free pallocator after a RCU grace
period (using kfree_rcu)? I think we also need to update
active_allocator with rcu_assign_pointer() and dereference it with
rcu_dereference()

> +			} else if (pallocator == active_allocator) {
> +				active_allocator = list_first_entry(&allocators_list, struct ioasid_allocator_data, list);
> +				pr_info("IOASID allocator changed");
> +			}
> +			break;
> +		}
> +		/*
> +		 * Find the matching shared ops to delete,
> +		 * but keep outstanding IOASIDs
> +		 */
> +		list_for_each_entry(sops, &pallocator->slist, list) {
> +			if (sops == ops) {
> +				list_del(&ops->list);
> +				if (refcount_dec_and_test(&pallocator->users))
> +					pr_err("no shared ops\n");

That's not possible, right, since dec_and_test only returns true if
pallocator->users was 1, which we already checked against? I find
pallocator->users a bit redundant since you can use list_is_empty() or
list_is_singular() on pallocator->slist

[...]
>  ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>  		      void *private)
>  {
> -	ioasid_t id;
>  	struct ioasid_data *data;
> +	void *adata;
> +	ioasid_t id;
>  
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
> @@ -76,14 +324,34 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>  	data->set = set;
>  	data->private = private;
>  
> -	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max), GFP_KERNEL)) {
> -		pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
> +	/*
> +	 * Custom allocator needs allocator data to perform platform specific
> +	 * operations.
> +	 */
> +	spin_lock(&ioasid_allocator_lock);
> +	adata = active_allocator->flags & IOASID_ALLOCATOR_CUSTOM ? active_allocator->ops->pdata : data;
> +	id = active_allocator->ops->alloc(min, max, adata);
> +	if (id == INVALID_IOASID) {
> +		pr_err("Failed ASID allocation %lu\n", active_allocator->flags);
>  		goto exit_free;
>  	}
> +
> +	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
> +		/* Custom allocator needs framework to store and track allocation results */
> +		min = max = id;
> +
> +		if (xa_alloc(&active_allocator->xa, &id, data, XA_LIMIT(min, max), GFP_KERNEL)) {

Or just XA_LIMIT(id, id), and merge the two ifs?

You do need GFP_ATOMIC here.

> +			pr_err("Failed to alloc ioasid from %d to %d\n", min, max);

Maybe just "Failed to alloc ioasid %d\n" then

> +			active_allocator->ops->free(id, NULL);

Why doesn't this call need to pass active_allocator->ops->pdata like the
one in ioasid_free()?

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
