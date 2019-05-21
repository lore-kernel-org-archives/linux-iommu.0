Return-Path: <SRS0=R8za=TV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B74EC04AAF
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 09:56:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A64C2173E
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 09:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A64C2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 354E5ACD;
	Tue, 21 May 2019 09:56:18 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C956DA95
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 09:56:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 222E6E3
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 09:56:16 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FF1CF74CE;
	Tue, 21 May 2019 09:56:07 +0000 (UTC)
Received: from [10.36.116.113] (ovpn-116-113.ams2.redhat.com [10.36.116.113])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ADE96085B;
	Tue, 21 May 2019 09:55:57 +0000 (UTC)
Subject: Re: [PATCH v3 04/16] ioasid: Add custom IOASID allocator
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556922737-76313-5-git-send-email-jacob.jun.pan@linux.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c991ff0c-87bf-574a-bf31-9b37f0421385@redhat.com>
Date: Tue, 21 May 2019 11:55:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1556922737-76313-5-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 21 May 2019 09:56:15 +0000 (UTC)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Hi Jacob,

On 5/4/19 12:32 AM, Jacob Pan wrote:
> Sometimes, IOASID allocation must be handled by platform specific
> code. The use cases are guest vIOMMU and pvIOMMU where IOASIDs need
> to be allocated by the host via enlightened or paravirt interfaces.
> 
> This patch adds an extension to the IOASID allocator APIs such that
> platform drivers can register a custom allocator, possibly at boot
> time, to take over the allocation. Xarray is still used for tracking
> and searching purposes internal to the IOASID code. Private data of
> an IOASID can also be set after the allocation.
> 
> There can be multiple custom allocators registered but only one is
> used at a time. In case of hot removal of devices that provides the
> allocator, all IOASIDs must be freed prior to unregistering the
> allocator. Default XArray based allocator cannot be mixed with
> custom allocators, i.e. custom allocators will not be used if there
> are outstanding IOASIDs allocated by the default XA allocator.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/ioasid.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 99f5e0a..ed2915a 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -17,6 +17,100 @@ struct ioasid_data {
>  };
>  
>  static DEFINE_XARRAY_ALLOC(ioasid_xa);
> +static DEFINE_MUTEX(ioasid_allocator_lock);
> +static struct ioasid_allocator *active_custom_allocator;
> +
> +static LIST_HEAD(custom_allocators);
> +/*
> + * A flag to track if ioasid default allocator is in use, this will
> + * prevent custom allocator from being used. The reason is that custom allocator
> + * must have unadulterated space to track private data with xarray, there cannot
> + * be a mix been default and custom allocated IOASIDs.
> + */
> +static int default_allocator_active;
> +
> +/**
> + * ioasid_register_allocator - register a custom allocator
> + * @allocator: the custom allocator to be registered
> + *
> + * Custom allocators take precedence over the default xarray based allocator.
> + * Private data associated with the ASID are managed by ASID common code
> + * similar to data stored in xa.
> + *
> + * There can be multiple allocators registered but only one is active. In case
> + * of runtime removal of a custom allocator, the next one is activated based
> + * on the registration ordering.
> + */
> +int ioasid_register_allocator(struct ioasid_allocator *allocator)
> +{
> +	struct ioasid_allocator *pallocator;
> +	int ret = 0;
> +
> +	if (!allocator)
> +		return -EINVAL;
is it really necessary? Sin't it the caller responsibility?
> +
> +	mutex_lock(&ioasid_allocator_lock);
> +	/*
> +	 * No particular preference since all custom allocators end up calling
> +	 * the host to allocate IOASIDs. We activate the first one and keep
> +	 * the later registered allocators in a list in case the first one gets
> +	 * removed due to hotplug.
> +	 */
> +	if (list_empty(&custom_allocators))
> +		active_custom_allocator = allocator;> +	else {
> +		/* Check if the allocator is already registered */
> +		list_for_each_entry(pallocator, &custom_allocators, list) {
> +			if (pallocator == allocator) {
> +				pr_err("IOASID allocator already registered\n");
> +				ret = -EEXIST;
> +				goto out_unlock;
> +			}
> +		}
> +	}
> +	list_add_tail(&allocator->list, &custom_allocators);
> +
> +out_unlock:
> +	mutex_unlock(&ioasid_allocator_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_register_allocator);
> +
> +/**
> + * ioasid_unregister_allocator - Remove a custom IOASID allocator
> + * @allocator: the custom allocator to be removed
> + *
> + * Remove an allocator from the list, activate the next allocator in
> + * the order it was registered.
> + */
> +void ioasid_unregister_allocator(struct ioasid_allocator *allocator)
> +{
> +	if (!allocator)
> +		return;
is it really necessary?
> +
> +	if (list_empty(&custom_allocators)) {
> +		pr_warn("No custom IOASID allocators active!\n");
> +		return;
> +	}
> +
> +	mutex_lock(&ioasid_allocator_lock);
> +	list_del(&allocator->list);
> +	if (list_empty(&custom_allocators)) {
> +		pr_info("No custom IOASID allocators\n")> +		/*
> +		 * All IOASIDs should have been freed before the last custom
> +		 * allocator is unregistered. Unless default allocator is in
> +		 * use.
> +		 */
> +		BUG_ON(!xa_empty(&ioasid_xa) && !default_allocator_active);
> +		active_custom_allocator = NULL;
> +	} else if (allocator == active_custom_allocator) {
In case you are removing the active custom allocator don't you also need
to check that all ioasids were freed. Otherwise you are likely to switch
to a different allocator whereas the asid space is partially populated.
> +		active_custom_allocator = list_entry(&custom_allocators, struct ioasid_allocator, list);
> +		pr_info("IOASID allocator changed");
> +	}
> +	mutex_unlock(&ioasid_allocator_lock);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_unregister_allocator);
>  
>  /**
>   * ioasid_set_data - Set private data for an allocated ioasid
> @@ -68,6 +162,29 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>  	data->set = set;
>  	data->private = private;
>  
> +	mutex_lock(&ioasid_allocator_lock);
> +	/*
> +	 * Use custom allocator if available, otherwise use default.
> +	 * However, if there are active IOASIDs already been allocated by default
> +	 * allocator, custom allocator cannot be used.
> +	 */
> +	if (!default_allocator_active && active_custom_allocator) {
> +		id = active_custom_allocator->alloc(min, max, active_custom_allocator->pdata);
> +		if (id == INVALID_IOASID) {
> +			pr_err("Failed ASID allocation by custom allocator\n");
> +			mutex_unlock(&ioasid_allocator_lock);
> +			goto exit_free;
> +		}
> +		/*
> +		 * Use XA to manage private data also sanitiy check custom
> +		 * allocator for duplicates.
> +		 */
> +		min = id;
> +		max = id + 1;
> +	} else
> +		default_allocator_active = 1;
nit: true?
> +	mutex_unlock(&ioasid_allocator_lock);
> +
>  	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max), GFP_KERNEL)) {
>  		pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
>  		goto exit_free;> @@ -91,9 +208,17 @@ void ioasid_free(ioasid_t ioasid)
>  {
>  	struct ioasid_data *ioasid_data;
>  
> +	mutex_lock(&ioasid_allocator_lock);
> +	if (active_custom_allocator)
> +		active_custom_allocator->free(ioasid, active_custom_allocator->pdata);
> +	mutex_unlock(&ioasid_allocator_lock);
> +
>  	ioasid_data = xa_erase(&ioasid_xa, ioasid);
>  
>  	kfree_rcu(ioasid_data, rcu);
> +
> +	if (xa_empty(&ioasid_xa))
> +		default_allocator_active = 0;
Isn't it racy? what if an xa_alloc occurs inbetween?


>  }
>  EXPORT_SYMBOL_GPL(ioasid_free);
>  
> 

Thanks

Eric
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
