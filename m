Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.219.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793395143;
	b=WylIykPiZkFBgh8+IjpvQU34IsttVecCugpqL6o3MF7Rrc+35deNA5HeZmYiAyVHW69b
	 EVJsfj7P28gCPGHBXlAfSCTQuqpKEFv95XH3RgJJ1ugnkWlsN0X1F3vV8lAlsCv32NG7H
	 xf2SQ9Wjeqt9PlUID8O/3aolWhlFbMCUotLiyElkTKbqBxaerN4gE9j0D3QMYslTP3h92
	 MLkt/Vnu7RnDcmjyVgoW+kq0PRemPdlsn023SS/1MQIe3hT+1xZKc/2lWLAlr3qP4hopO
	 sgIzWbft/0fvqTHLt41s3Eztx+bqNrzgurSXkaBDz2vpFnkfF3qEYZDgSrcW8l5cZRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=HU3pvitpwZLUJMJVILFp+Zu6v1bdImGs94yE/HOyndg=;
	b=oXKsb9g9rzNoPp0oJuJmSvPzuHIxEVOHPdiidXgzZFKrghLX1kVFVRScJ0rviJYQVP+0
	 8oT7qNdwRdgqQ+sE6eusjK+0YZekEw8lJ1iKyxaME/XFlROmso9HJ2aRyClBVkUVvew45
	 a8kZ+8xhYF5jFFFB16Ka3cIuXDnykhO6MapAtfXQckbDJUVOzVI8jepfamaj8WmjqQC+e
	 hu9U6MU6AsXWWM5jpIq4D3JYaoQR1jCfMKh9sYlp9fkTNzBLnSgHPnY2hd1ZPwfkSu3pg
	 RWveGRCOaKcNmbkiYdlysB/Pnuu1vhjIMafykwsI62THlGzP7EO1EPfqtE+a+aZpQ9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dIB2Yomh;
	arc=fail smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C29606A31F
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 21:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1C29606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dIB2Yomh
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91b52ba422cso15608186d6.2
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 14:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793395142; cv=none;
        d=google.com; s=arc-20260327;
        b=hDt9XQSLpRvQfFkuT28al5xBEbmvhnB/5d1zyXRvkD25Ky/VE6gB9/7RUEgDMcAHgx
         AAZah6vVPKyxgr8k3vc2vUkcdwzK1BIs7kB0CFHiWN0XbvS3zHixdwAxlshjfrRuJmWK
         iqvKKydTu3US4Yn2/Tao9XpHUjVmQXLFfll5sG0rfZcrjEuvXM1y+SMrAWzCJJ3+3Yme
         GbXO7jjTzCdTnKW6x86iZ4z0YokWH2twaKIuqnSVG6ij+ZoHixki002k3AVchcS0sj1z
         fqVcSU1zA7ptMwrrWNOVFvjEynqnIHLqgSYWu9ux+j4tFjSmWsYPoZ0u2yrBvredpmXt
         3KnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=HU3pvitpwZLUJMJVILFp+Zu6v1bdImGs94yE/HOyndg=;
        fh=+z9i7+hiHz35dnW5KeBryNpilYBkx/2KBB4AX9Jt5s4=;
        b=bY0UYLq3Utor/hptOVCW51odMISWwN7kJbY6qW03q4d/nznaxhstbSPgBVJL5VB6cg
         NWOY4cDmP2enDzc3Zwme+nYWbSLgCMm/VQNbm3S7gjLte155nT5dRhz5jE+eA7xYno5e
         PHYZg8YnshW7//dZAMrccQcOKYU/bJhlSkXwo2Sfg/Ovgg9B8mjR84X7g/4uLANUPsoy
         4s5jpIpKuheC3Wm5pRTv40KC08Z8CE3dPMtX/ipMjwcfLDK7n01RB9xI/yMLRlNBJC25
         W1GMbclSJqhy5feEDPGRULM9yIbX/eK/mQ6dRBy45kuOsPRLLFRuQvEkOQIE0j4iVdgv
         DhDg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395142; x=1793999942; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HU3pvitpwZLUJMJVILFp+Zu6v1bdImGs94yE/HOyndg=;
        b=dIB2YomhttqFpyro1ApK4LTiU968266c5ZO4LOm/iRURcPtEckqyO4+blAdV9acpMW
         JZ92DvWKbO1BNZjpTb4O3aNi2knj6vKNYHh2FJYP/mTtMWGZcp1G47efjR6iXjVMbUTn
         ZWbEC3uiljE7a6U0YFeBft610grI94+ZQSqV2KDy9zu7IaQXQVPhKIJDfJJjsqIOezLS
         1cnGlzxUqbQD4gO5rhKNFFCNdIYQSeAoFfDarxO+dJgWRYvKWE9Tmt1/tEmFFsNVl4Ss
         2Lj4ykNzZQeu+zb2liSdeMYs3juBlhn14Jx0pvPnGLQ38i4vX4Ulz7hrdFIUnHOVDe0w
         qP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395142; x=1793999942;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HU3pvitpwZLUJMJVILFp+Zu6v1bdImGs94yE/HOyndg=;
        b=HP5ewc86VOqYJb7CHm5oD8cUBKn8zCTdjYIJhRi+79MaPg+AKRblNh7rhWE4Vo7lI8
         pkdc0Zghr/u1LP2+0C594aFfQaGbU9Kc08E2nAI6HMj+q3JbpcMBM/yWbWihVrbcXte4
         SJQxNxQnl3ZsrYQrNFSoWpxa4kJMIgUQcUrIPlyDv1vIqcPjP8AdqQVKqJxtD3H1VBxS
         ggwjmfD2ladQgG6QJPXFZM7xfxcW/Y+TeOuPOpKX6lfaBzxuXMAeiacHAfWyFDIgU56P
         C+Ky5INduK0VScbsHRm5mEdpg24cTVS48xlwUKLt4KngNrnupUcdgtsTPKHFJTjIZ8hj
         U1sQ==
X-Forwarded-Encrypted: i=1; AKwUvBw53EXHHlkjyGaFh9C/9yLqCr6yVWyiyYVm6Rcd5YEKAw5kigzc3DouurAa+CZfdXj0BKXXeQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIOiQLNQdquIzlCAJkCWSy2KNTVYewlY2MvuHk6r90bv15UT+Am
	maiQjL525y4OFrr96wTmiIFtoHs/aCNJS1Vs595KneQv3xMRQJh6nlldHN6c9h2z3+g3lYpbz0y
	gVVRJtFpAYcqW5T/HNg2/jIUoqcK/Id/6qxx1eZNv
X-Gm-Gg: AYBFou0A6sP7/H+wvC2uNrB2MKkD5Nr6oasG5JfVorBLQ5EuC6rXU0GrGtB/LFqbo8R
	LFdUbelGsNRXLN2QxPP7P28dlD+aF44eJVLZTBZFpC1p/GQZG43D1hwBnIW4TlN2mum7a/CBLNI
	Vc9uQy9FlQ3oczN6KXKSXtOEavJa1jS212TiyEnvjdv8cuC6YW+w5h4t9pF/lMjQBj4OFGxRU9m
	SEgeBMHMNmeaNVDZ1aYfQ0jqYVHBM5zSxaQ52OMF2iZSFMTxSIu6vKfQ+ukHgl2CxHeFqQLZhcZ
	zeqnKJ46jNXaKme4QEbe3rl+gkWh1djlbbTQPmOKoLitUU396xB19zrZoJwkRdkRN6zcKf1ys3W
	tKbOfC62qI0Rgke8ofleSev5KCQ0PAJjC05I3csF0Qo/kFml681bx4EppJ8TEVdgdbRlgMoPOQr
	C6vBHQMMFOT+wPS99A2ExSgQ==
X-Received: by 2002:a05:6214:240a:b0:91c:450d:8f34 with SMTP id
 6a1803df08f44-91ca4bce34emr58846786d6.46.1793395141110; Fri, 30 Oct 2026
 14:19:01 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 14:19:00 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CAEvNRgEh3E7NBc5_3Wq66Fss-mAYT6+4FWP5+=Co6+OVfVnQQQ@mail.gmail.com>
References: <20261017073149.1303738-1-aneesh.kumar@kernel.org>
 <20261017073149.1303738-3-aneesh.kumar@kernel.org> <CAEvNRgEh3E7NBc5_3Wq66Fss-mAYT6+4FWP5+=Co6+OVfVnQQQ@mail.gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 14:19:00 -0700
X-Gm-Features: AclHuK8aNtmB7JK_qHjJeH9V34MC2DCp5vnYn4fAUI82UUtxS3pHz4MfNJXrVPA
Message-ID: <CAEvNRgFEKqVZcNYCL0LpB6BTyBFe+ot1x1nFfEqOrSTsu134PQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/13] KVM: guest_memfd: Support private/shared
 conversion of device memory
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, linux-coco@lists.linux.dev
Cc: Alex Williamson <alex@shazbot.org>, David Woodhouse <dwmw2@infradead.org>, 
	David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Kevin Tian <kevin.tian@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Steven Price <steven.price@arm.com>, Fred Griffoul <griffoul@gmail.com>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
>
>>
>> [...snip...]
>>
>> +static int kvm_gmem_device_convert(struct inode *inode, pgoff_t start,
>> +		pgoff_t nr_pages, const struct guest_memfd_device_request *req,
>> +		const struct kvm_memory_slot *slot)
>> +{
>> +	struct gmem_inode *gi = GMEM_I(inode);
>> +	u64 attrs = req ? KVM_MEMORY_ATTRIBUTE_PRIVATE : 0;
>> +	bool prepared = false;
>> +	int ret;
>> +
>> +	MA_STATE(mas, &gi->attributes, start, start + nr_pages - 1);
>> +
>> +	filemap_invalidate_lock(inode->i_mapping);
>> +	if (__kvm_gmem_range_has_attributes(inode, start, nr_pages, attrs)) {
>> +		ret = 0;
>> +		goto out;
>> +	}
>> +
>> +	if (req && !__kvm_gmem_range_has_attributes(inode, start, nr_pages, 0)) {
>> +		ret = -EEXIST;
>> +		goto out;
>> +	}
>> +
>> +	ret = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
>> +	if (ret)
>> +		goto out;
>> +
>> +	kvm_gmem_invalidate_start(inode, start, start + nr_pages, KVM_FILTER_SHARED);
>> +	if (req && READ_ONCE(gi->device.kvm->vm_dead))
>> +		ret = -EIO;
>> +	else
>> +		ret = gi->provider_ops->prepare_conversion(gi->provider, req);
>> +	if (!ret) {
>> +		prepared = true;
>> +		if (req)
>> +			ret = kvm_gmem_device_make_private(inode, slot, req, nr_pages);
>
> Is there a way to avoid making private from within the conversion flow?
>
> kvm_gmem_device_map() below already does it as part of vcpu_run.
>
> If we do the above, we'd be aligned with regular conversions, where
> to-shared conversions eagerly update arch state (make_shared) but
> to-private notifications to the firmware are done lazily.
>

I was a bit confused above. IIUC to handle
RMI_EXIT_VDEV_VALIDATE_MAPPING, the conversion is not done from outside
the kernel, instead it is done in the vcpu_run completion hook.

Can we make the flow that userspace is required to do the conversion
request from userspace after an exit due to
RMI_EXIT_VDEV_VALIDATE_MAPPING, and then just do the delegate + map +
validate in the vcpu_run completion hook?


The rest are a little outside the guest_memfd field, but I'll make the
suggestion anyway.

It looks like delegate and map don't need the vcpu context, only
validate does, so validate has to be done in the vcpu_run completion
hook.

Delegate needs the host physical addresses, so we'd need to translate
the IPAs to PAs, could that be a VM ioctl? It could look up the memslots
and translate IPA to PA?

RMI_RTT_DEV_MAP also doesn't need the vcpu context, IIUC it does need
the VM context so it could be a VM ioctl too? If it looks up the
memslot, it'll also find the guest_memfd, where it can find the device
information.

I'm just thinking that the vcpu_run completion context is doing too
much, and there are so many possible errors that could be better
communicated to userspace if they're separate ioctls.

Or perhaps at least delegate + map could be one required ioctl call by
userspace before doing vcpu_run to continue after a
RMI_EXIT_VDEV_VALIDATE_MAPPING exit.

>> +		else
>> +			ret = kvm_gmem_device_make_shared(inode, start, start + nr_pages);
>> +	}
>> +	if (!ret) {
>> +		mas_store_prealloc(&mas, xa_mk_value(attrs));
>> +		kvm_gmem_device_update_private(gi);
>> +	} else {
>> +		mas_destroy(&mas);
>> +	}
>> +
>> +	kvm_gmem_invalidate_end(inode, start, start + nr_pages);
>> +	if (prepared)
>> +		gi->provider_ops->finish_conversion(gi->provider, req);
>> +out:
>> +	filemap_invalidate_unlock(inode->i_mapping);
>> +	return ret;
>> +}
>> +
>> +int kvm_gmem_device_map(struct kvm *kvm, u64 gpa, u64 size, u64 pa, u64 vdev_id)
>> +{
>> +	struct guest_memfd_device_request req = { gpa, pa, vdev_id };
>> +	struct kvm_memory_slot *slot;
>> +	gfn_t gfn = gpa >> PAGE_SHIFT;
>> +	struct file *file;
>> +	int ret;
>> +
>> +	if (!size)
>> +		return -EINVAL;
>> +
>> +	if (!PAGE_ALIGNED(gpa | size | pa))
>> +		return -EINVAL;
>> +
>> +	/* Caller holds SRCU across the pending architecture request. */
>> +	slot = gfn_to_memslot(kvm, gfn);
>> +	if (!slot || (slot->flags & KVM_MEMSLOT_INVALID))
>> +		return -EINVAL;
>> +
>> +	if (!(slot->flags & KVM_MEMSLOT_GMEM_DEVICE))
>> +		return -EINVAL;
>> +
>> +	if ((size >> PAGE_SHIFT) > slot->npages - (gfn - slot->base_gfn))
>> +		return -EINVAL;
>> +
>> +	file = kvm_gmem_get_file(slot);
>> +	if (!file)
>> +		return -ENOENT;
>> +	ret = kvm_gmem_device_convert(file_inode(file),
>> +				      kvm_gmem_get_index(slot, gfn),
>> +				      size >> PAGE_SHIFT, &req, slot);
>> +	fput(file);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_device_map);
>> +
>>
>> [...snip...]
>>
