Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B440523D8
	for <iommu@lists.linux.dev>; Fri, 25 Nov 2022 08:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669365789;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sRZVtfy7jHF/otBGu/mU+bfgNu+7SQC3SDiG+Mz/0SA=;
	b=eEA5QJNZJr/dvEzyfcSNpokME9276WOadtwi/2zDkyHDDUnrBoSTq3UfIbeNqImzOfyxx7
	Jp04Ft1UanbnUuPp+lN38OL4s0FxCoHZscf2SD+ZEFm4QsLxXl+vf0vD0E+R+K+IiAA3I3
	ZYrc1P7OY1U5eJEXTX5lGdZP9CY9fq8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-278-YsuZH-2tPUe3Vy3DQG7BLg-1; Fri, 25 Nov 2022 03:43:08 -0500
X-MC-Unique: YsuZH-2tPUe3Vy3DQG7BLg-1
Received: by mail-wm1-f70.google.com with SMTP id m34-20020a05600c3b2200b003cf549cb32bso3888340wms.1
        for <iommu@lists.linux.dev>; Fri, 25 Nov 2022 00:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRZVtfy7jHF/otBGu/mU+bfgNu+7SQC3SDiG+Mz/0SA=;
        b=NbXR4BAmkrv+JxqvPrBa2Jw7xVpzRr/dVAMckJdBdqE/gIVUM4f37C8EulTStmueRI
         uZ9PkKN0e2JlATAKKnKfJ2uxreo5+n4nMAUOvxKE+1HtSG9NOr5A1jX12Cn7Qx6K3UrT
         J/vaAmm0BAghQIFRI9Qe8CsPT2hSnwrabi3t7UB1F11bYf8Z28Y99UHIYZ3WuXMssfDy
         U2O1aLtoTKJOT8Oi26d6fdKb3oolYcA9Jno4pwyK9YtC2/aGxlAS8v8mariocgSCaV2D
         D5FPPQPCjzDCGpD3QJjMgm2D/XTOZabxUX1bw7d532N+1IMJtkRago329kbiE6yH1VPj
         3leg==
X-Gm-Message-State: ANoB5pmYW0XnHzokgm/sHiWNeWzf1OCPc40mW6DPjmozETl9RPe/8V6n
	SdjfUgTFzh1BukQ2OEa0XbYTP+gDOqgjicPzglh2jmV+tkfkXlQt5raC4SvrHmyq7ePUNsfgvwQ
	O+SNXgq6m09MVBMw=
X-Received: by 2002:adf:e412:0:b0:242:2cd:259 with SMTP id g18-20020adfe412000000b0024202cd0259mr2490710wrm.718.1669365787188;
        Fri, 25 Nov 2022 00:43:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7NpneEPbu/BenchhBdj5/LhryjdAFoI4Kz3tEVBfEXrlPcu+cT/QmX7tIEwuOh5Vr44rV30Q==
X-Received: by 2002:adf:e412:0:b0:242:2cd:259 with SMTP id g18-20020adfe412000000b0024202cd0259mr2490662wrm.718.1669365786878;
        Fri, 25 Nov 2022 00:43:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id bt7-20020a056000080700b00236705daefesm3295974wrb.39.2022.11.25.00.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 00:43:05 -0800 (PST)
Message-ID: <85ac616c-ef5e-eab6-4b0b-06c946a324ff@redhat.com>
Date: Fri, 25 Nov 2022 09:43:02 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v5 06/19] iommufd: File descriptor, context, kconfig and
 makefiles
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
 Anthony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Cornelia Huck
 <cohuck@redhat.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eric Farman <farman@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>, Joao Martins
 <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
 Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
References: <6-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <0c6ba292-4e65-9a9f-b498-2409482a06b8@redhat.com>
 <Y3fppPM9mCm6xIz6@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Y3fppPM9mCm6xIz6@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

On 11/18/22 21:23, Jason Gunthorpe wrote:
> On Fri, Nov 18, 2022 at 05:27:35PM +0100, Eric Auger wrote:
>>> +config IOMMUFD
>>> +	tristate "IOMMU Userspace API"
>>> +	select INTERVAL_TREE
>>> +	select INTERVAL_TREE_SPAN_ITER
>>> +	select IOMMU_API
>>> +	default n
>>> +	help
>>> +	  Provides /dev/iommu the user API to control the IOMMU subsystem as
>>> +	  it relates to managing IO page tables that point at user space memory.
>> nit: missing ',' after /dev/iommu or Provides /dev/iommu user API
> Done
>
>>> +/**
>>> + * iommufd_ref_to_users() - Switch from destroy_rwsem to users refcount
>>> + *        protection
>>> + * @obj - Object to release
>>> + *
>>> + * Objects have two refcount protections (destroy_rwsem and the refcount_t
>>> + * users). Holding either of these will prevent the object from being destroyed.
>>> + *
>>> + * Depending on the use case, one protection or the other is appropriate.  In
>>> + * most cases references are being protected by the destroy_rwsem. This allows
>>> + * orderly destruction of the object because iommufd_object_destroy_user() will
>>> + * wait for it to become unlocked. However, as a rwsem, it cannot be held across
>>> + * a system call return. So cases that have longer term needs must switch
>>> + * to the weaker users refcount_t.
>>> + *
>>> + * With users protection iommufd_object_destroy_user() will return -EBUSY to
>> iommufd_object_destroy_user() returns false and iommufd_destroy
>>  retruns -EBUSY.
> ""
>  * With users protection iommufd_object_destroy_user() will return false,
>  * refusing to destroy the object, causing -EBUSY to userspace.
>  */
> ""
>
>>> + * userspace and refuse to destroy the object.
>>> + */
>>> +static inline void iommufd_ref_to_users(struct iommufd_object *obj)
>>> +{
>>> +	up_read(&obj->destroy_rwsem);
>>> +	/* iommufd_lock_obj() obtains users as well */
>> Do you have a way to check that put() is done in accordance, ie. we are
>> not going to try up_read() the rwsem if this latter is not used anymore?
> If put becomes unbalanced then fd closure will WARN_ON
>
> If someone misuses the rwsem (eg double up_reading it) then lockdep
> will fire

OK
>
>>> +static int iommufd_fops_release(struct inode *inode, struct file *filp)
>>> +{
>>> +	struct iommufd_ctx *ictx = filp->private_data;
>>> +	struct iommufd_object *obj;
>>> +
>>> +	/* Destroy the graph from depth first */
>> I would suggest: destroy the leaf objects first thanks to the
>> hierarchical user ref counting? or something alike
> "depth first" is a technical term when working with graphs..
OK. I ignored that.
>
> How about replacing both comments with this:
>
> 	/*
> 	 * The objects in the xarray form a graph of "users" counts, and we have
> 	 * to destroy them in a depth first manner. Leaf objects will reduce the
> 	 * users count of interior objects when they are destroyed.
> 	 *
> 	 * Repeatedly destroying all the "1 users" leaf objects will progress
> 	 * until the entire list is destroyed. If this can't progress then there
> 	 * is some bug related to object refcounting.
> 	 */
Yes that looks much clearer to me. Thanks!
>
>>> +	while (!xa_empty(&ictx->objects)) {
>>> +		unsigned int destroyed = 0;
>>> +		unsigned long index;
>>> +
>>> +		xa_for_each(&ictx->objects, index, obj) {
>>> +			/*
>>> +			 * Since we are in release elevated users must come from
>>> +			 * other objects holding the users. We will eventually
>> the sentense sounds a bit cryptic to me.
>>> +			 * destroy the object that holds this one and the next
>>> +			 * pass will progress it.
>>> +			 */
>>> +			if (!refcount_dec_if_one(&obj->users))
>>> +				continue;
>>> +			destroyed++;
>>> +			xa_erase(&ictx->objects, index);
>>> +			iommufd_object_ops[obj->type].destroy(obj);
>>> +			kfree(obj);
>> Use iommufd_object_abort_and_destroy(obj) instead of the above 3 lines?
> Ah, they are not quite the same things, the order is different and
> abort has a protective assertion that the xa_array hasn't been messed
> with. It would be messy to merge them
>
> It is also very similar to iommufd_object_destroy_user() except we
> shortcut some unncessary locking.
OK
>>> +/**
>>> + * DOC: General ioctl format
>>> + *
>>> + * The ioctl interface follows a general format to allow for extensibility. Each
>>> + * ioctl is passed in a structure pointer as the argument providing the size of
>>> + * the structure in the first u32. The kernel checks that any structure space
>>> + * beyond what it understands is 0. This allows userspace to use the backward
>>> + * compatible portion while consistently using the newer, larger, structures.
>>> + *
>>> + * ioctls use a standard meaning for common errnos:
>>> + *
>>> + *  - ENOTTY: The IOCTL number itself is not supported at all
>>> + *  - E2BIG: The IOCTL number is supported, but the provided structure has
>>> + *    non-zero in a part the kernel does not understand.
>>> + *  - EOPNOTSUPP: The IOCTL number is supported, and the structure is
>>> + *    understood, however a known field has a value the kernel does not
>>> + *    understand or support.
>>> + *  - EINVAL: Everything about the IOCTL was understood, but a field is not
>>> + *    correct.
>>> + *  - ENOENT: An ID or IOVA provided does not exist.
>>> + *  - ENOMEM: Out of memory.
>>> + *  - EOVERFLOW: Mathematics oveflowed.
>> overflowed
> Done
>
> Thanks,
> Jason
>
Thanks

Eric

