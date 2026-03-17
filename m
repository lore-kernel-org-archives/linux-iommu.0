Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74338946B
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773779627; cv=none; b=Vdc8pwnA+qSNBfd/u1UDmAvbsG5SUBoUv20a7bFdpwP1D91bT315Yu45iqRQA2yfFF+w1zbcQY+rg4dNMBqzNXPJBZH4fAoOQ8phLYM9+t6xo1ThTTuuMoPwyYdx/o0Nb2VQBmLnvyyFDtP0XUGgaqjSEsLJBLlj78Znaye5eSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773779627; c=relaxed/simple;
	bh=cr4yzAJsARkLeImvnfyc3Q3IOB7M5gnE+dn1jy/zn6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9nxPcC2HAuKfA/ZsqbN656KA7U9TAUwSvPMTXJIa6kI9mocwXNmyXNnemTf47sGSo62Q2HmtARSG5GqXeTAFisRWtulWxGjL8hrKICD/JNWnEhUkllJR8h1v1KUc71DamLgZhnutGm8vvkZnRR9XzApldl9cgRCPNt+RMTTGWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g0ydvags; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g0ydvags"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b052562254so28865ad.0
        for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 13:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773779625; x=1774384425; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b87t95PtnrWHMeticjx588uzi6UDZqsEP1PMzieU4Pc=;
        b=g0ydvagsxIApvDAt3YHtkQnMs/6bPnKjFFj40IKtOni5+jAnj3Ptz9Q6AZC7shdmhC
         ortB4u3hftBgxZ38qFmswoyKLWjGK+Pf94e0o98Yu6iReeLFHis5eq5VppeC3VV/OVsh
         NBXY8Fd8ADuzyahA4JGuHFzr6CdBACILwNgEkxqzXFx12b2cC9lgJgKvq2FKBH9lSs1x
         V0Pjtiq89NaW86PCqumxFFA83MH4oQ+WBawRBMbH9BqJ7J38+zsnbIVca2ORiGZXjShz
         /XtM08r9cBneiteJii6DZrS01rE4AgU0YY1dp+ea4yX3ZH/VjUgT5tgJ4TwRkPhpER9n
         5UcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773779625; x=1774384425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b87t95PtnrWHMeticjx588uzi6UDZqsEP1PMzieU4Pc=;
        b=QQGLpCgVqxwVqoicVx9HHpG2b1w0U8bTBTFJJ/KovcTX3raLrSSEIi/+RwPzVJqhrc
         Mxc3ATtIbVaNYks0s2a0y+oBeZU9teOfmKci1vPD+GmmHZPiYy6/uRSylsddn6itT7UV
         XZZPkDaRoqAWUsgbAZt/9DJh77919yWJO3BLYWHTpMzii94ifc/88HN3DQ9mFK4d5XF4
         ldSPn58BE75F0/Sq7ZzJ9qvZdf3MnwK4vJ8tH02VdXGDxJG6AHtUCXIlNKsIk9OgISsc
         z5nTI/s4D0BmRbcSBCYGjfInfnMKRcczklaLnf9EohBWkPBWOyNLBFmC4LkLhtFRPUoX
         1Lmw==
X-Forwarded-Encrypted: i=1; AJvYcCVs6Fp9h1VzbRg5rDgC/WNSB6/ScIxAhuPv0IVAWRZTrbRtZvusIiuUkgOj9EI0fyeWuf0gcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywn64PGXgGIPYmwukd8QC135MOYlEr6O/pUsyXFapAYdpIj1Sue
	/+KS4UOOnb0kWVZKQoW1EIO31/yfGlWZqzgrMxiRFf/k/z09GN30MPS3jNnqee3BEg==
X-Gm-Gg: ATEYQzxLQdxD0uQmZFlWtKwB2paOIblVuIVkEmE5A3nHjfIWsf/GR2l5N92DtUTvsMd
	VbeM4luzokDgcu8UHVB8iA/JUNhRBU08ddwzsqd6swimo/Ia28qWJXPZkX0QM9URPYSnbViIuWQ
	+j1F+C3sNw07DHgo0kpdK60JcM18S9Kmj6jpxeKqmtc5ez+pvfngmybalCd2K1KnrG6EuCed+Wl
	f7lyabxWAxzqOmqKuIt4Sa1z7l6HvgxrxSUF9ZEBFA478uv29kRuoGNHhy/iohcTKaOn1h/xoi1
	b08S16mSDxh+My3iNx3rklGOC0qBh6AMM2Zrw8aKzoj4T1QjzxHrEoaQmK/ZKI3q1X00fKRvE4V
	s9szZSbUZqxuuPT5aoTCwBKYh6oDjV2PG9a1DG5QOtp6az4SCcb2170uXFhmbsbrMEYhtRHh8td
	87qsK5nET4enY+AXi2rc/MaoqhPlp8oHDi45F3yyDyqzLIEd7+baLBorBnUvqZ8Q==
X-Received: by 2002:a17:902:f54d:b0:2b0:5b4c:a439 with SMTP id d9443c01a7336-2b06e7d8216mr967155ad.2.1773779624373;
        Tue, 17 Mar 2026 13:33:44 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e629da3sm3734835ad.76.2026.03.17.13.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 13:33:43 -0700 (PDT)
Date: Tue, 17 Mar 2026 20:33:39 +0000
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
Subject: Re: [PATCH 02/14] iommu: Implement IOMMU core liveupdate skeleton
Message-ID: <abm2C-8xRstbuzIe@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-3-skhawaja@google.com>
 <20260316221854.GC1768676.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260316221854.GC1768676.vipinsh@google.com>

On Tue, Mar 17, 2026 at 12:58:27PM -0700, Vipin Sharma wrote:
>On Tue, Feb 03, 2026 at 10:09:36PM +0000, Samiullah Khawaja wrote:
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 4926a43118e6..c0632cb5b570 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -389,6 +389,9 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
>>
>>  	mutex_init(&param->lock);
>>  	dev->iommu = param;
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	dev->iommu->device_ser = NULL;
>> +#endif
>
>This should already be NULL due to kzalloc() above.

Will remove.
>
>>  	return param;
>>  }
>>
>> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>> index 6189ba32ff2c..83eb609b3fd7 100644
>> --- a/drivers/iommu/liveupdate.c
>> +++ b/drivers/iommu/liveupdate.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/liveupdate.h>
>>  #include <linux/iommu-lu.h>
>>  #include <linux/iommu.h>
>> +#include <linux/pci.h>
>>  #include <linux/errno.h>
>>
>>  static void iommu_liveupdate_restore_objs(u64 next)
>> @@ -175,3 +176,328 @@ int iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
>>  	return liveupdate_unregister_flb(handler, &iommu_flb);
>>  }
>>  EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
>> +
>> +int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
>> +				    void *arg)
>> +{
>> +	struct iommu_lu_flb_obj *obj;
>> +	struct devices_ser *devices;
>> +	int ret, i, idx;
>> +
>> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&obj);
>> +	if (ret)
>> +		return -ENOENT;
>> +
>> +	devices = __va(obj->ser->devices_phys);
>> +	for (i = 0, idx = 0; i < obj->ser->nr_devices; ++i, ++idx) {
>> +		if (idx >= MAX_DEVICE_SERS) {
>> +			devices = __va(devices->objs.next_objs);
>> +			idx = 0;
>> +		}
>> +
>> +		if (devices->devices[idx].obj.deleted)
>> +			continue;
>> +
>> +		ret = fn(&devices->devices[idx], arg);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(iommu_for_each_preserved_device);
>
>IMHO, with all the obj, ser, devices->devices[..], it is little harder
>to follow the code. I will recommend to reconsider naming.

Agreed. I will update this based on the feedback on the previous patch.
>
>Also, should this function be introduced in the patch where it is
>getting used? Other changes in this patch are already big and complex.
>Same for iommu_get_device_preserved_data() and
>iommu_get_preserved_data().

These are used by the drivers, but part of core. So need to be in
this patch :(.

Note that this patch is adding core skeleton only, focusing on helpers
for the serialized state. This patch is not preserving any real state of
iommu, domain or devices. For example, the domains are saved through
generic page table in a separate patch, and the drivers preserve the
state of devices and associated iommu in separate patches.

I will add this text in the commit message to clarify the purpose of
this patch.
>
>I think this patch can be split in three.
>Patch 1: Preserve iommu_domain
>Patch 2: Preserve pci device and iommu device
>Patch 3: The helper functions I mentioned above.
>
>
>> +
>> +static inline bool device_ser_match(struct device_ser *match,
>> +				    struct pci_dev *pdev)
>> +{
>> +	return match->devid == pci_dev_id(pdev) && match->pci_domain == pci_domain_nr(pdev->bus);
>
>Nit: s/match/device_ser for readability or something similar.

Agreed. Will do.
>
>> +}
>> +
>> +struct device_ser *iommu_get_device_preserved_data(struct device *dev)
>> +{
>> +	struct iommu_lu_flb_obj *obj;
>> +	struct devices_ser *devices;
>> +	int ret, i, idx;
>> +
>> +	if (!dev_is_pci(dev))
>> +		return NULL;
>> +
>> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&obj);
>> +	if (ret)
>> +		return NULL;
>> +
>> +	devices = __va(obj->ser->devices_phys);
>> +	for (i = 0, idx = 0; i < obj->ser->nr_devices; ++i, ++idx) {
>> +		if (idx >= MAX_DEVICE_SERS) {
>> +			devices = __va(devices->objs.next_objs);
>> +			idx = 0;
>> +		}
>> +
>> +		if (devices->devices[idx].obj.deleted)
>> +			continue;
>> +
>> +		if (device_ser_match(&devices->devices[idx], to_pci_dev(dev))) {
>> +			devices->devices[idx].obj.incoming = true;
>> +			return &devices->devices[idx];
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL(iommu_get_device_preserved_data);
>> +
>> +struct iommu_ser *iommu_get_preserved_data(u64 token, enum iommu_lu_type type)
>> +{
>> +	struct iommu_lu_flb_obj *obj;
>> +	struct iommus_ser *iommus;
>> +	int ret, i, idx;
>> +
>> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&obj);
>> +	if (ret)
>> +		return NULL;
>> +
>> +	iommus = __va(obj->ser->iommus_phys);
>> +	for (i = 0, idx = 0; i < obj->ser->nr_iommus; ++i, ++idx) {
>> +		if (idx >= MAX_IOMMU_SERS) {
>> +			iommus = __va(iommus->objs.next_objs);
>> +			idx = 0;
>> +		}
>> +
>> +		if (iommus->iommus[idx].obj.deleted)
>> +			continue;
>> +
>> +		if (iommus->iommus[idx].token == token &&
>> +		    iommus->iommus[idx].type == type)
>> +			return &iommus->iommus[idx];
>> +	}
>> +
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL(iommu_get_preserved_data);
>> +
>> +static int reserve_obj_ser(struct iommu_objs_ser **objs_ptr, u64 max_objs)
>> +{
>> +	struct iommu_objs_ser *next_objs, *objs = *objs_ptr;
>> +	int idx;
>> +
>> +	if (objs->nr_objs == max_objs) {
>> +		next_objs = kho_alloc_preserve(PAGE_SIZE);
>> +		if (IS_ERR(next_objs))
>> +			return PTR_ERR(next_objs);
>> +
>> +		objs->next_objs = virt_to_phys(next_objs);
>> +		objs = next_objs;
>> +		*objs_ptr = objs;
>> +		objs->nr_objs = 0;
>> +		objs->next_objs = 0;
>> +	}
>> +
>> +	idx = objs->nr_objs++;
>> +	return idx;
>
>I think we should rename these variables, it is difficult to comprehend
>the code.

Will do.
>
>> +}
>> +
>> +int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser)
>> +{
>> +	struct iommu_domain_ser *domain_ser;
>> +	struct iommu_lu_flb_obj *flb_obj;
>> +	int idx, ret;
>> +
>> +	if (!domain->ops->preserve)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
>> +	if (ret)
>> +		return ret;
>> +
>> +	guard(mutex)(&flb_obj->lock);
>> +	idx = reserve_obj_ser((struct iommu_objs_ser **)&flb_obj->iommu_domains,
>> +			      MAX_IOMMU_DOMAIN_SERS);
>> +	if (idx < 0)
>> +		return idx;
>> +
>> +	domain_ser = &flb_obj->iommu_domains->iommu_domains[idx];
>> +	idx = flb_obj->ser->nr_domains++;
>
>In for loops above, nr_domains are compared with 'i', and idx is for
>index inside a page. Lets not reuse idx here for nr_domains, keep it
>consistent for easier understanding. May be use something more
>descriptive than 'i' like global_idx and local_idx?

Agreed. Will change it.
>
>> +	domain_ser->obj.idx = idx;
>> +	domain_ser->obj.ref_count = 1;
>> +
>> +	ret = domain->ops->preserve(domain, domain_ser);
>> +	if (ret) {
>> +		domain_ser->obj.deleted = true;
>> +		return ret;
>> +	}
>> +
>> +	domain->preserved_state = domain_ser;
>> +	*ser = domain_ser;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_domain_preserve);
>> +
>> +static int iommu_preserve_locked(struct iommu_device *iommu)
>> +{
>> +	struct iommu_lu_flb_obj *flb_obj;
>> +	struct iommu_ser *iommu_ser;
>> +	int idx, ret;
>
>Should there be lockdep asserts in these locked version APIs?

Will add it here.
>
>> +
>> +}
>> +
>> +static void iommu_unpreserve_locked(struct iommu_device *iommu)
>> +{
>> +	struct iommu_ser *iommu_ser = iommu->outgoing_preserved_state;
>> +
>> +	iommu_ser->obj.ref_count--;
>
>Should there be a null check?

Hmm.. There is a dependency of unpreservation of iommus with devices, so
this should never be NULL unless used independently.

But I think I will add it here to protect against that.
>
>> +	if (iommu_ser->obj.ref_count)
>> +		return;
>> +
>> +	iommu->outgoing_preserved_state = NULL;
>> +	iommu->ops->unpreserve(iommu, iommu_ser);
>> +	iommu_ser->obj.deleted = true;
>> +}
>> +
>> +int iommu_preserve_device(struct iommu_domain *domain,
>> +			  struct device *dev, u64 token)
>> +{
>> +	struct iommu_lu_flb_obj *flb_obj;
>> +	struct device_ser *device_ser;
>> +	struct dev_iommu *iommu;
>> +	struct pci_dev *pdev;
>> +	int ret, idx;
>> +
>> +	if (!dev_is_pci(dev))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (!domain->preserved_state)
>> +		return -EINVAL;
>> +
>> +	pdev = to_pci_dev(dev);
>> +	iommu = dev->iommu;
>> +	if (!iommu->iommu_dev->ops->preserve_device ||
>> +	    !iommu->iommu_dev->ops->preserve)
>
>iommu_preserve_locked() is already checking for preserve(), we can just
>check preserve_device here.

iommu_preserve_locked() is called after reserving the serialization
state in FLB and taking the FLB lock, so this is an early check that
returns early.
>
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
>> +	if (ret)
>> +		return ret;
>> +
>> +	guard(mutex)(&flb_obj->lock);
>> +	idx = reserve_obj_ser((struct iommu_objs_ser **)&flb_obj->devices,
>> +			      MAX_DEVICE_SERS);
>> +	if (idx < 0)
>> +		return idx;
>> +
>> +	device_ser = &flb_obj->devices->devices[idx];
>> +	idx = flb_obj->ser->nr_devices++;
>> +	device_ser->obj.idx = idx;
>> +	device_ser->obj.ref_count = 1;
>> +
>> +	ret = iommu_preserve_locked(iommu->iommu_dev);
>> +	if (ret) {
>> +		device_ser->obj.deleted = true;
>> +		return ret;
>> +	}
>> +
>> +	device_ser->domain_iommu_ser.domain_phys = __pa(domain->preserved_state);
>> +	device_ser->domain_iommu_ser.iommu_phys = __pa(iommu->iommu_dev->outgoing_preserved_state);
>> +	device_ser->devid = pci_dev_id(pdev);
>> +	device_ser->pci_domain = pci_domain_nr(pdev->bus);
>> +	device_ser->token = token;
>> +
>> +	ret = iommu->iommu_dev->ops->preserve_device(dev, device_ser);
>> +	if (ret) {
>> +		device_ser->obj.deleted = true;
>> +		iommu_unpreserve_locked(iommu->iommu_dev);
>> +		return ret;
>> +	}
>> +
>> +	dev->iommu->device_ser = device_ser;
>> +	return 0;
>> +}
>> +
>> +void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
>> +{
>> +	struct iommu_lu_flb_obj *flb_obj;
>> +	struct device_ser *device_ser;
>> +	struct dev_iommu *iommu;
>> +	struct pci_dev *pdev;
>> +	int ret;
>> +
>> +	if (!dev_is_pci(dev))
>> +		return;
>> +
>> +	pdev = to_pci_dev(dev);
>> +	iommu = dev->iommu;
>> +	if (!iommu->iommu_dev->ops->unpreserve_device ||
>> +	    !iommu->iommu_dev->ops->unpreserve)
>> +		return;
>> +
>> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
>> +	if (WARN_ON(ret))
>
>Why WARN_ON here and not other places? Do we need it?

Basically this means that the upper layer (iommufd/vfio) is asking to
unpreserve a device, but there is no FLB found. This should not happen
and should generate a warning.
>
>> +		return;
>> +
>> +	guard(mutex)(&flb_obj->lock);
>> +	device_ser = dev_iommu_preserved_state(dev);
>> +	if (WARN_ON(!device_ser))
>
>Can't we just silently ignore this?

See answer above for the previous WARN. Same applies here.
>
>> +		return;
>> +
>> +	iommu->iommu_dev->ops->unpreserve_device(dev, device_ser);
>> +	dev->iommu->device_ser = NULL;
>> +
>> +	iommu_unpreserve_locked(iommu->iommu_dev);
>> +}
