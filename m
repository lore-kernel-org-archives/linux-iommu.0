Return-Path: <SRS0=VKv6=TW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE18C282DD
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 19:40:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8E420675
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 19:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8E420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C1256AF0;
	Wed, 22 May 2019 19:40:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 12826A59
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 19:40:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4C7D0102
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 19:39:59 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	22 May 2019 12:39:58 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 22 May 2019 12:39:58 -0700
Date: Wed, 22 May 2019 12:42:55 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 04/16] ioasid: Add custom IOASID allocator
Message-ID: <20190522124255.117de6f6@jacob-builder>
In-Reply-To: <c991ff0c-87bf-574a-bf31-9b37f0421385@redhat.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556922737-76313-5-git-send-email-jacob.jun.pan@linux.intel.com>
	<c991ff0c-87bf-574a-bf31-9b37f0421385@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
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

On Tue, 21 May 2019 11:55:55 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 5/4/19 12:32 AM, Jacob Pan wrote:
> > Sometimes, IOASID allocation must be handled by platform specific
> > code. The use cases are guest vIOMMU and pvIOMMU where IOASIDs need
> > to be allocated by the host via enlightened or paravirt interfaces.
> > 
> > This patch adds an extension to the IOASID allocator APIs such that
> > platform drivers can register a custom allocator, possibly at boot
> > time, to take over the allocation. Xarray is still used for tracking
> > and searching purposes internal to the IOASID code. Private data of
> > an IOASID can also be set after the allocation.
> > 
> > There can be multiple custom allocators registered but only one is
> > used at a time. In case of hot removal of devices that provides the
> > allocator, all IOASIDs must be freed prior to unregistering the
> > allocator. Default XArray based allocator cannot be mixed with
> > custom allocators, i.e. custom allocators will not be used if there
> > are outstanding IOASIDs allocated by the default XA allocator.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/ioasid.c | 125
> > +++++++++++++++++++++++++++++++++++++++++++++++++ 1 file changed,
> > 125 insertions(+)
> > 
> > diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> > index 99f5e0a..ed2915a 100644
> > --- a/drivers/iommu/ioasid.c
> > +++ b/drivers/iommu/ioasid.c
> > @@ -17,6 +17,100 @@ struct ioasid_data {
> >  };
> >  
> >  static DEFINE_XARRAY_ALLOC(ioasid_xa);
> > +static DEFINE_MUTEX(ioasid_allocator_lock);
> > +static struct ioasid_allocator *active_custom_allocator;
> > +
> > +static LIST_HEAD(custom_allocators);
> > +/*
> > + * A flag to track if ioasid default allocator is in use, this will
> > + * prevent custom allocator from being used. The reason is that
> > custom allocator
> > + * must have unadulterated space to track private data with
> > xarray, there cannot
> > + * be a mix been default and custom allocated IOASIDs.
> > + */
> > +static int default_allocator_active;
> > +
> > +/**
> > + * ioasid_register_allocator - register a custom allocator
> > + * @allocator: the custom allocator to be registered
> > + *
> > + * Custom allocators take precedence over the default xarray based
> > allocator.
> > + * Private data associated with the ASID are managed by ASID
> > common code
> > + * similar to data stored in xa.
> > + *
> > + * There can be multiple allocators registered but only one is
> > active. In case
> > + * of runtime removal of a custom allocator, the next one is
> > activated based
> > + * on the registration ordering.
> > + */
> > +int ioasid_register_allocator(struct ioasid_allocator *allocator)
> > +{
> > +	struct ioasid_allocator *pallocator;
> > +	int ret = 0;
> > +
> > +	if (!allocator)
> > +		return -EINVAL;  
> is it really necessary? Sin't it the caller responsibility?
makes sense. will remove this one and below.
> > +
> > +	mutex_lock(&ioasid_allocator_lock);
> > +	/*
> > +	 * No particular preference since all custom allocators
> > end up calling
> > +	 * the host to allocate IOASIDs. We activate the first one
> > and keep
> > +	 * the later registered allocators in a list in case the
> > first one gets
> > +	 * removed due to hotplug.
> > +	 */
> > +	if (list_empty(&custom_allocators))
> > +		active_custom_allocator = allocator;> +
> > else {
> > +		/* Check if the allocator is already registered */
> > +		list_for_each_entry(pallocator,
> > &custom_allocators, list) {
> > +			if (pallocator == allocator) {
> > +				pr_err("IOASID allocator already
> > registered\n");
> > +				ret = -EEXIST;
> > +				goto out_unlock;
> > +			}
> > +		}
> > +	}
> > +	list_add_tail(&allocator->list, &custom_allocators);
> > +
> > +out_unlock:
> > +	mutex_unlock(&ioasid_allocator_lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_register_allocator);
> > +
> > +/**
> > + * ioasid_unregister_allocator - Remove a custom IOASID allocator
> > + * @allocator: the custom allocator to be removed
> > + *
> > + * Remove an allocator from the list, activate the next allocator
> > in
> > + * the order it was registered.
> > + */
> > +void ioasid_unregister_allocator(struct ioasid_allocator
> > *allocator) +{
> > +	if (!allocator)
> > +		return;  
> is it really necessary?
> > +
> > +	if (list_empty(&custom_allocators)) {
> > +		pr_warn("No custom IOASID allocators active!\n");
> > +		return;
> > +	}
> > +
> > +	mutex_lock(&ioasid_allocator_lock);
> > +	list_del(&allocator->list);
> > +	if (list_empty(&custom_allocators)) {
> > +		pr_info("No custom IOASID allocators\n")>
> > +		/*
> > +		 * All IOASIDs should have been freed before the
> > last custom
> > +		 * allocator is unregistered. Unless default
> > allocator is in
> > +		 * use.
> > +		 */
> > +		BUG_ON(!xa_empty(&ioasid_xa)
> > && !default_allocator_active);
> > +		active_custom_allocator = NULL;
> > +	} else if (allocator == active_custom_allocator) {  
> In case you are removing the active custom allocator don't you also
> need to check that all ioasids were freed. Otherwise you are likely
> to switch to a different allocator whereas the asid space is
> partially populated.
The assumption is that all custom allocators on the same guest will end
up calling the same host allocator. Having multiple custom allocators in
the list is just a way to support multiple (p)vIOMMUs with hotplug.
Therefore, we cannot nor need to free all PASIDs when one custom
allocator goes away. This is a different situation then switching
between default allocator and custom allocator, where custom allocator
has to start with a clean space.

 
> > +		active_custom_allocator =
> > list_entry(&custom_allocators, struct ioasid_allocator, list);
> > +		pr_info("IOASID allocator changed");
> > +	}
> > +	mutex_unlock(&ioasid_allocator_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_unregister_allocator);
> >  
> >  /**
> >   * ioasid_set_data - Set private data for an allocated ioasid
> > @@ -68,6 +162,29 @@ ioasid_t ioasid_alloc(struct ioasid_set *set,
> > ioasid_t min, ioasid_t max, data->set = set;
> >  	data->private = private;
> >  
> > +	mutex_lock(&ioasid_allocator_lock);
> > +	/*
> > +	 * Use custom allocator if available, otherwise use
> > default.
> > +	 * However, if there are active IOASIDs already been
> > allocated by default
> > +	 * allocator, custom allocator cannot be used.
> > +	 */
> > +	if (!default_allocator_active && active_custom_allocator) {
> > +		id = active_custom_allocator->alloc(min, max,
> > active_custom_allocator->pdata);
> > +		if (id == INVALID_IOASID) {
> > +			pr_err("Failed ASID allocation by custom
> > allocator\n");
> > +			mutex_unlock(&ioasid_allocator_lock);
> > +			goto exit_free;
> > +		}
> > +		/*
> > +		 * Use XA to manage private data also sanitiy
> > check custom
> > +		 * allocator for duplicates.
> > +		 */
> > +		min = id;
> > +		max = id + 1;
> > +	} else
> > +		default_allocator_active = 1;  
> nit: true?
yes, i can turn default_allocator_active into a bool type.

> > +	mutex_unlock(&ioasid_allocator_lock);
> > +
> >  	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max),
> > GFP_KERNEL)) { pr_err("Failed to alloc ioasid from %d to %d\n",
> > min, max); goto exit_free;> @@ -91,9 +208,17 @@ void
> > ioasid_free(ioasid_t ioasid) {
> >  	struct ioasid_data *ioasid_data;
> >  
> > +	mutex_lock(&ioasid_allocator_lock);
> > +	if (active_custom_allocator)
> > +		active_custom_allocator->free(ioasid,
> > active_custom_allocator->pdata);
> > +	mutex_unlock(&ioasid_allocator_lock);
> > +
> >  	ioasid_data = xa_erase(&ioasid_xa, ioasid);
> >  
> >  	kfree_rcu(ioasid_data, rcu);
> > +
> > +	if (xa_empty(&ioasid_xa))
> > +		default_allocator_active = 0;  
> Isn't it racy? what if an xa_alloc occurs inbetween?
> 
> 
yes, i will move it under the mutex. Thanks.
> >  }
> >  EXPORT_SYMBOL_GPL(ioasid_free);
> >  
> >   
> 
> Thanks
> 
> Eric

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
