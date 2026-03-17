Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F556221FB1
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 01:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773709601; cv=none; b=rdcDl5PhE1ES782gXqYIBw8YCIRfb0V5pSgZlU1yim+Jhup1F8Md8D0uZfxupM8UkLVulr2if+Qs2u71tZ7442jHUhT6LfyGazcjNGKQkE5YFEuCYubKvc6U9POmSDmIz2oJV61Pt4IKZcsXa5iVURBuhwVP/Jxnge63oZGKhDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773709601; c=relaxed/simple;
	bh=q2Hzxwc5lB6wUMulp9dp5c3gNXXM3DNB28y8fCE9vpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkGtlOCfBKWP3FzZXh5RB5NZgX+R2ZY1cQwTuEQvcx46dcyfYkFl66UdxG1obSapJN2nuq1XgNwjIVEB0hWb2NsLdvo3yjx9Hqsh5XKyP3HYKeD6CWztOl3M5c2Z3TFqJqWZ0Z5GoR/Fbs707ShxgzxorfaHEaiyrtuOY5dQsk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VNKU0CG8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VNKU0CG8"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aeab6ff148so24705ad.1
        for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 18:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773709600; x=1774314400; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oGZgtOm1Cce1gJW6SeSO5QkxuAynrOG8SKM5SJxHzmE=;
        b=VNKU0CG8fwegX3PhsSnvit1fxiSs+Np3jIlG2kO14BU+YAhdygTsZ+kX+YHGRA+9oQ
         yKqjFrn+klb46xBlbJBxu+m0iQxmR7+og8aef9vG/Moz/cmO0eP8h/SAGTmjIlyQoGoh
         pwWe5KOKR47X2+qYGJU546oZE0uuZhpSYpepPx61pADKDWUWI5euVUtrdoCxmiLgWQX7
         zkhUPR4w02Mb8kRMQjcBMbtQ1Fy20fPJ3O1Xai6vivHV7k0y8rBLIG/Y4Oy6TmzCR9Mo
         WE/u/5nxq7UNHf1G1XBpEz1g4tXeuZgOZ1bDNU+qptxYZGBpIX9GrHQoX1zPzIDFy9qy
         KHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773709600; x=1774314400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGZgtOm1Cce1gJW6SeSO5QkxuAynrOG8SKM5SJxHzmE=;
        b=Ur6SCqtXI4HiUdsUCb8B4QKmQ4NTshyk9O/J1NfyNurVlXOZRnbWmOvnnYJtJO5i3u
         T8L2YX/b2vHrOXAhEuifXM6JsHCRVv3OBzGtvqekuzsIiWCRr3xrfZi0h7qr9wYY0SNF
         8w2WCY1qv8DjrryoNAoF/VdVICzRc8PeTfEVSOWeiAiyyZzyy1cCMhaGayIWhw/dKDo2
         YTdenCm6co9+xyEL6/VhhwnNMBmsibl8Zj8UzVqNh3W2fHDzeIvB3matFsJ0HtcdtTKX
         FDw8Pd3WFhMsS5Fqv8WtlfdADYxhEc/OmYWEsgWuOh5+tVH5uMmyw+F/qF985hUGd373
         eqQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVf8h0S2JTLfQ9bEiAJUwk9UjaKUfsnk2e5kJUXKkcfwGZ3ovxccJvKzBm/fE/JHbbPCDdzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+rMsiF4ryqcQB1ZzdrGPdvItSAGOTJDZYjK5Nraxrom0OFl5k
	swiCzSX2iybaHPVqvJnFsdWkGY1vFkCmQJbQOIwdyVGnQSL9EraNia40JeXhVA747A==
X-Gm-Gg: ATEYQzymbNWeh7BFXA0yOuTX/gkc+virchcR2ljkTbr+UUc0WAr57to/drG3aOciEl6
	eIP3dopkUP0IW8GTVtLUTuWKloTNpsbTR8W8MFNLlhnUSWlqw3+sTfc3eJP/J9xaiO1ptfCvV3g
	VvgC0/RQI85HpOKp/WSOrXjLvmiUalbJ0brb7qCm6Oi4XppgK07LVVx/6+SqyPuMmJcOhW1gimm
	dlEvfWCdT3swtaxKDpqsimJ2FttLrmRTH+Q8xSO2xnFTDmrFm+WyiDmnlELHGaUQNYNByAk7omn
	FnKmh5K5wiY2JUuZO7w29fzJlRvcMuZDs8fHpwK/z1ByE5S9DrH9MCIP2Awao5eRA/uG5lHGUL8
	LfgZdiEN5KxHq+eMzoJ7d0hxpZxZCLWbJHjfsH4LWeLVJ0DxJTFC1DE7SyA8v3tdwGjhXL2N3jJ
	i6ujEwYDyHWNY5zVn2PyXiLnBh3X6Nz7UOyl4j5sXTBZIuqu8IRZor1y1dGZanyA==
X-Received: by 2002:a17:902:d2ce:b0:2ad:6f9b:7817 with SMTP id d9443c01a7336-2b06404f4d7mr1768365ad.22.1773709599273;
        Mon, 16 Mar 2026 18:06:39 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb6336bsm11427073a12.21.2026.03.16.18.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 18:06:38 -0700 (PDT)
Date: Tue, 17 Mar 2026 01:06:34 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 01/14] iommu: Implement IOMMU LU FLB callbacks
Message-ID: <abidn8EGmi88wpCr@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-2-skhawaja@google.com>
 <20260316165018.GA1768676.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260316165018.GA1768676.vipinsh@google.com>

On Mon, Mar 16, 2026 at 03:54:50PM -0700, Vipin Sharma wrote:
>On Tue, Feb 03, 2026 at 10:09:35PM +0000, Samiullah Khawaja wrote:
>> +config IOMMU_LIVEUPDATE
>> +	bool "IOMMU live update state preservation support"
>> +	depends on LIVEUPDATE && IOMMUFD
>> +	help
>> +	  Enable support for preserving IOMMU state across a kexec live update.
>> +
>> +	  This allows devices managed by iommufd to maintain their DMA mappings
>> +	  during kexec base kernel update.
>> +
>> +	  If unsure, say N.
>> +
>
>Do we need a separate config? Can't we just use CONFIG_LIVEUPDATE?

We have a separate CONFIG here so that the phase 1/2 split for iommu
preservation doesn't break the vfio preservation. See following
discussion in the RFCv2:

https://lore.kernel.org/all/aYEpHBYxlQxhXrwl@google.com/
>
>>  menuconfig IOMMU_SUPPORT
>>  	bool "IOMMU Hardware Support"
>>  	depends on MMU
>> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>> index 0275821f4ef9..b3715c5a6b97 100644
>> --- a/drivers/iommu/Makefile
>> +++ b/drivers/iommu/Makefile
>> @@ -15,6 +15,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>>  obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
>>  obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST) += io-pgtable-arm-selftests.o
>>  obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
>> +obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
>
>It seems like there is a sorted order for CONFIG_IOMMU_* in the
>Makefile, lets keep it same if possible.

Will fix in the next revision.
>
>> +static void iommu_liveupdate_free_objs(u64 next, bool incoming)
>> +{
>> +	struct iommu_objs_ser *objs;
>> +
>> +	while (next) {
>> +		objs = __va(next);
>
>There is also call to phys_to_virt() in other functions in this patch.
>Should we use the same here to be consistent?

Agreed. I will fix this.
>
>> +		next = objs->next_objs;
>> +
>> +		if (!incoming)
>> +			kho_unpreserve_free(objs);
>> +		else
>> +			folio_put(virt_to_folio(objs));
>> +	}
>> +}
>
>Instead of passing boolean, and calling with different arguments, I
>think it will be simpler to just have two functions
>
>- iommu_liveupdate_unpreserve()
>- iommu_liveupdate_folio_put()

This is a helper function to free the serialized state without
duplicating multiple checks for various type of state (iommu,
iommu_domain and devices).

Do you think maybe I should add these two functions and make it call the
helper?
>
>> +
>> +static void iommu_liveupdate_flb_free(struct iommu_lu_flb_obj *obj)
>> +{
>> +	if (obj->iommu_domains)
>> +		iommu_liveupdate_free_objs(obj->ser->iommu_domains_phys, false);
>> +
>> +	if (obj->devices)
>> +		iommu_liveupdate_free_objs(obj->ser->devices_phys, false);
>> +
>> +	if (obj->iommus)
>> +		iommu_liveupdate_free_objs(obj->ser->iommus_phys, false);
>> +
>> +	kho_unpreserve_free(obj->ser);
>> +	kfree(obj);
>> +}
>> +
>> +static int iommu_liveupdate_flb_preserve(struct liveupdate_flb_op_args *argp)
>> +{
>> +	struct iommu_lu_flb_obj *obj;
>> +	struct iommu_lu_flb_ser *ser;
>> +	void *mem;
>> +
>> +	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
>> +	if (!obj)
>> +		return -ENOMEM;
>> +
>> +	mutex_init(&obj->lock);
>> +	mem = kho_alloc_preserve(sizeof(*ser));
>> +	if (IS_ERR(mem))
>> +		goto err_free;
>> +
>> +	ser = mem;
>> +	obj->ser = ser;
>> +
>> +	mem = kho_alloc_preserve(PAGE_SIZE);
>> +	if (IS_ERR(mem))
>> +		goto err_free;
>> +
>> +	obj->iommu_domains = mem;
>> +	ser->iommu_domains_phys = virt_to_phys(obj->iommu_domains);
>> +
>> +	mem = kho_alloc_preserve(PAGE_SIZE);
>> +	if (IS_ERR(mem))
>> +		goto err_free;
>> +
>> +	obj->devices = mem;
>> +	ser->devices_phys = virt_to_phys(obj->devices);
>> +
>> +	mem = kho_alloc_preserve(PAGE_SIZE);
>> +	if (IS_ERR(mem))
>> +		goto err_free;
>> +
>> +	obj->iommus = mem;
>> +	ser->iommus_phys = virt_to_phys(obj->iommus);
>> +
>> +	argp->obj = obj;
>> +	argp->data = virt_to_phys(ser);
>> +	return 0;
>> +
>> +err_free:
>> +	iommu_liveupdate_flb_free(obj);
>
>Generally, I have seen in the function goto will call corresponding
>error tags, and free corresponding allocations and all the one which
>happend before. It is easier to read code that way. I know you are
>combining the free call from iommu_liveupdate_flb_unpreserve() also.
>IMHO, code readability will be better this way.

I had that originally when I was writing this function, but it gets
really cluttered :(. Instead it is more clean without code duplication
using this one cleanup function here to free the state on error and also
when doing unpreserve. Please consider this a "destroy" function of obj
and it can be called from 2 places,

- Error during allocation of internal state.
- During unpreserve.
>
>> +	return PTR_ERR(mem);
>> +}
>> +
>> +static void iommu_liveupdate_flb_unpreserve(struct liveupdate_flb_op_args *argp)
>> +{
>> +	iommu_liveupdate_flb_free(argp->obj);
>> +}
>> +
>> +static void iommu_liveupdate_flb_finish(struct liveupdate_flb_op_args *argp)
>> +{
>> +	struct iommu_lu_flb_obj *obj = argp->obj;
>> +
>> +	if (obj->iommu_domains)
>> +		iommu_liveupdate_free_objs(obj->ser->iommu_domains_phys, true);
>
>Can there be the case where obj->iommu_domains is NULL but
>obj->ser->iommu_domains_phys is not? If that is not possible, I will
>just simplify the patch and unconditionally call
>iommu_liveupdate_free_objs()?

Are you suggesting that on flb_finish() the obj->iommu_domains should be
non-NULL as flb_retrieve() succeeded? If yes, then that is correct. I
will update this to call the free_objs() without checking
obj->iommu_domains. I will do same for other types.
>
>> +
>> +static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
>> +{
>> +	struct iommu_lu_flb_obj *obj;
>> +	struct iommu_lu_flb_ser *ser;
>> +
>> +	obj = kzalloc(sizeof(*obj), GFP_ATOMIC);
>> +	if (!obj)
>> +		return -ENOMEM;
>
>Is kzalloc() failure here recoverable whereas iommu_liveupdate_restore_objs()
>below is not? If it is not recoverable should there be a BUG_ON here?

Interesting... This should be recoverable as there is no corruption or
bad state. LUO will propagate this to caller and it should be handle
properly. I will make sure that this is handled in init.
>
>> +
>> +	mutex_init(&obj->lock);
>> +	BUG_ON(!kho_restore_folio(argp->data));
>> +	ser = phys_to_virt(argp->data);
>> +	obj->ser = ser;
>> +
>> +	iommu_liveupdate_restore_objs(ser->iommu_domains_phys);
>> +	obj->iommu_domains = phys_to_virt(ser->iommu_domains_phys);
>
>Can iommu_liveupdate_restore_obj() just return virtual address and we
>can simplify code to:
>
>	obj->iommu_domains = iommu_liveupdate_restore_objs(ser->iommu_domains_phys);

Yes that is a good idea. I will change this.
>
>> +
>> +	iommu_liveupdate_restore_objs(ser->devices_phys);
>> +	obj->devices = phys_to_virt(ser->devices_phys);
>> +
>> +	iommu_liveupdate_restore_objs(ser->iommus_phys);
>> +	obj->iommus = phys_to_virt(ser->iommus_phys);
>> +
>> +	argp->obj = obj;
>> +
>> +	return 0;
>> +}
>> +
>> diff --git a/include/linux/iommu-lu.h b/include/linux/iommu-lu.h
>
>I will recommend to use full name and not short "lu". iommu-liveupdate.h
>seems more readable and not too long.

Agreed. I will change this.
>
>> +#define MAX_IOMMU_SERS ((PAGE_SIZE - sizeof(struct iommus_ser)) / sizeof(struct iommu_ser))
>> +#define MAX_IOMMU_DOMAIN_SERS \
>> +		((PAGE_SIZE - sizeof(struct iommu_domains_ser)) / sizeof(struct iommu_domain_ser))
>> +#define MAX_DEVICE_SERS ((PAGE_SIZE - sizeof(struct devices_ser)) / sizeof(struct device_ser))
>
>This is per page limit, not whole serialization limit. May be we can
>name something like:
>
>- MAX_IOMMU_SERS_PER_PAGE, or
>- MAX_IOMMU_SERS_PAGE_CAPACITY

Agreed.
>
>> +
>> +struct iommu_lu_flb_obj {
>> +	struct mutex lock;
>> +	struct iommu_lu_flb_ser *ser;
>> +
>> +	struct iommu_domains_ser *iommu_domains;
>> +	struct iommus_ser *iommus;
>> +	struct devices_ser *devices;
>> +} __packed;
>> +
>
>I think naming scheme used here is little hard to absorb when we have so
>many individual structs in this header file. Specifically, struct names like:
>
>- iommu_domains_ser vs iommu_domain_ser
>- iommus_ser vs iommu_ser
>- devices_ser vs device_ser
>- iommu_objs_ser vs iommu_obj_ser
>
>First three are showing container and its elements relation, however,
>last one doesn't have that relation but naming is same there.
>
>I will recommend to change the naming scheme of containers to something like:
>
>	struct iommu_domain_ser_[hdr|header|table|arr] {};
>	struct iommu_ser_hdr {}
>	struct device_ser_hdr {}
>
>Individual element of container can be same.
>
>For objs, something like:
>	iommu_objs_ser -> iommu_hdr_meta
>
>

Agreed. The singular vs plural for object vs aggregate is tricky. I will
rework these names. I am thinking something like following based on the
feedback on this patch,

struct iommu_ser_hdr; <= object hdr.
struct iommu_ser_arr_hdr <= array of objects hdr.
struct iommu_domain_ser <= contains a preserved domain.
struct iommu_domain_ser_arr <= array of domains.

Thanks,
Sami
