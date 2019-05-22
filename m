Return-Path: <SRS0=VKv6=TW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8ECC282DC
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 12:20:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CD7217F9
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 12:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CD7217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E8DF5D39;
	Wed, 22 May 2019 12:20:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4869DD2E
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 12:20:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 27418102
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 12:20:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A234780D;
	Wed, 22 May 2019 05:20:04 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 247863F575;
	Wed, 22 May 2019 05:20:03 -0700 (PDT)
Subject: Re: [PATCH v3 03/16] iommu: Add I/O ASID allocator
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Auger Eric <eric.auger@redhat.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556922737-76313-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<bb31fbcb-2708-93e6-f11e-3018556fbc21@redhat.com>
	<20190521100300.4f224e68@jacob-builder>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <836caf0d-699e-33ba-5303-b1c9c949c9ca@arm.com>
Date: Wed, 22 May 2019 13:19:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521100300.4f224e68@jacob-builder>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
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

On 21/05/2019 18:03, Jacob Pan wrote:
> On Tue, 21 May 2019 10:21:55 +0200
> Auger Eric <eric.auger@redhat.com> wrote:
>>> +config IOASID
>>> +	bool  
>> don't we want a tristate here too?
>>
>> Also refering to the past discussions we could add "# The IOASID
>> library may also be used by non-IOMMU_API users"
> I agree. For device driver modules to use ioasid w/o iommu, this does
> not have to be built-in.
> Jean, would you agree?

Yes we can make it tristate. There is a couple of things missing to
build it as a module:
* Add MODULE_LICENSE("GPL") to ioasid.c
* Use #if IS_ENABLED(CONFIG_IOASID) in ioasid.h rather than #ifdef
CONFIG_IOASID

>>> +	help
>>> +	  Enable the I/O Address Space ID allocator. A single ID
>>> space shared
>>> +	  between different users.
>>> +
>>>  # IOMMU_API always gets selected by whoever wants it.
>>>  config IOMMU_API
>>>  	bool
>>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>>> index 8c71a15..0efac6f 100644
>>> --- a/drivers/iommu/Makefile
>>> +++ b/drivers/iommu/Makefile
>>> @@ -7,6 +7,7 @@ obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
>>>  obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>>>  obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>>>  obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
>>> +obj-$(CONFIG_IOASID) += ioasid.o
>>>  obj-$(CONFIG_IOMMU_IOVA) += iova.o
>>>  obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>>>  obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
>>> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
>>> new file mode 100644
>>> index 0000000..99f5e0a
>>> --- /dev/null
>>> +++ b/drivers/iommu/ioasid.c
>>> @@ -0,0 +1,140 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * I/O Address Space ID allocator. There is one global IOASID
>>> space, split into
>>> + * subsets. Users create a subset with DECLARE_IOASID_SET, then
>>> allocate and
>>> + * free IOASIDs with ioasid_alloc and ioasid_free.
>>> + */
>>> +#include <linux/xarray.h>
>>> +#include <linux/ioasid.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/spinlock.h>

nit: sort alphabetically

>>> +
>>> +struct ioasid_data {
>>> +	ioasid_t id;
>>> +	struct ioasid_set *set;
>>> +	void *private;
>>> +	struct rcu_head rcu;
>>> +};
>>> +
>>> +static DEFINE_XARRAY_ALLOC(ioasid_xa);
>>> +
>>> +/**
>>> + * ioasid_set_data - Set private data for an allocated ioasid
>>> + * @ioasid: the ID to set data
>>> + * @data:   the private data
>>> + *
>>> + * For IOASID that is already allocated, private data can be set
>>> + * via this API. Future lookup can be done via ioasid_find.
>>> + */
>>> +int ioasid_set_data(ioasid_t ioasid, void *data)
>>> +{
>>> +	struct ioasid_data *ioasid_data;
>>> +	int ret = 0;
>>> +
>>> +	ioasid_data = xa_load(&ioasid_xa, ioasid);
>>> +	if (ioasid_data)
>>> +		ioasid_data->private = data;

I think we might be in trouble if this function runs concurrently with
ioasid_free(). ioasid_data may be freed between xa_load() and this
assignment. It's probably not a valid use at the moment but we might as
well make this code robust (or describe the constraints of
ioasid_set_data() in the comment).

I'm still uneasy about this, but I think we need the following sequence:

	xa_lock();
	ioasid_data = xa_load()
	if (ioasid_data)
		rcu_assign_pointer(ioasid_data->private, data);
	else
		ret = -ENOENT;
	xa_unlock();

>>> +	else
>>> +		ret = -ENOENT;
>>> +
>>> +	/* getter may use the private data */
>>> +	synchronize_rcu();

If I understand correctly, this allows our caller to safely free the old
data, if any? Is there any other reason to have a synchronize_rcu()?
Otherwise the comment could be more precise:

/* Wait for readers to stop accessing the old private data so the caller
can free it. */

>>> +
>>> +	return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(ioasid_set_data);
[...]
>>> +void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>>> +		  bool (*getter)(void *))
>>> +{
>>> +	void *priv = NULL;
>>> +	struct ioasid_data *ioasid_data;
>>> +
>>> +	rcu_read_lock();
>>> +	ioasid_data = xa_load(&ioasid_xa, ioasid);
>>> +	if (!ioasid_data) {
>>> +		priv = ERR_PTR(-ENOENT);
>>> +		goto unlock;
>>> +	}
>>> +	if (set && ioasid_data->set != set) {
>>> +		/* data found but does not belong to the set */
>>> +		priv = ERR_PTR(-EACCES);
>>> +		goto unlock;
>>> +	}
>>> +	/* Now IOASID and its set is verified, we can return the
>>> private data */
>>> +	priv = ioasid_data->private;

And here, I suppose we need:

	priv = rcu_dereference(ioasid_data->private);

Thanks,
Jean

>>> +	if (getter && !getter(priv))
>>> +		priv = NULL;
>>> +unlock:
>>> +	rcu_read_unlock();
>>> +
>>> +	return priv;
>>> +}
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
