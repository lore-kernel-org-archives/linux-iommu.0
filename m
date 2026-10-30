Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793392589;
	b=xVWgDfgX+Q+gtUBY4Ev3HWzCGtEtRmpMV38cQAoFVFCnBTbMwsdw9Pr9sU3zr0jVYu8T
	 ChtHGvVxyQESG2mDO5ILZ1jxgT1ihOzMM2PBfc7B5f+W7x1gMx6yBKzuAFRX6qgcjD+W7
	 nMgDf7NDQUscBjB8b7Udyq3PkSdXuVrUdo1uxEqg6o8s/0FXBndkmn9l6D/qMv9y8WByi
	 Y/C0FklsSs9d7cnuj/l+ve590GGV+srr8/J/J96lgUpxtPZKTj8Tc5B9D7tHPOkcRncy9
	 4+xeE7WlIwSk5HY7K+lALpwiBfo6p9N0qrTnNAG1rKCqk0uzQvWbHxxUk21hZwBjlbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793392589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=mfTTVpEW/ASHSaJiK1tCpdlPNObyw7zCk6yXHFi2rhs=;
	b=PIBSvwjx1QdY+YvCvHjkqgpBniVaiTyIweKpEuQAMoeVtXq9qZyXkrjwoaz5fFqfYLcC
	 G8KfOok9W3/5k+R9/W/M89VqH3pB/Ks1dHjQJVaSSZO/Dob+bAqh/4UhZlRZIf8LZ4wcV
	 MqPMM9weLUvRZ0iTtLkiWITfAZYMO3Ru+DL54fAEWX8h5G8aAdz1lY7TKhPPDtzE/lHzC
	 mvRaCiMF/F/0MDaWwzR7dNpBIKVeclAgXIKYKuqnLkM0yb4Y0GbRJA4Ds1qe2qwi019/b
	 0Glm0YP0otF8NDxpt+A2qkh83rOmxPGooM67nBWy6xj9ze4ArFGXt1GlRGQwiOc4l7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WrM3qAIY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5F6606A31F
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 20:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E5F6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WrM3qAIY
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-537548b811aso8886741cf.3
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 13:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793392588; cv=none;
        d=google.com; s=arc-20260327;
        b=P1VHtp7zSYV+9SBCt+SkHmH5Ai+hhnpBesnJ4xU5oolUg95Ucws9sDUjVBporV5bz2
         Eu2WUMB065kNPj1936dpLruyjU/VmB8POStinjHZ2ZA/dMDq2fl7/phRC1dXO4oY1P/+
         OZReo1Kc0fjuE8xDDqRk1b5dobe4QP4WZPZeZVecOr8gkkuhIOS916tJzlktQaNbaBrG
         qrIO4cSF0hfrSM3L0psfzcGjHN1mb1jlGFxpS3VDkuq4xEG+0GACDU1unojEWlA76VHZ
         wPCv6lFvOquOPVvUF6MxbMKzGX003xx48BjDMInip7k+Ra548QzbOzyy0oCJSAhaJGvx
         6sRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=mfTTVpEW/ASHSaJiK1tCpdlPNObyw7zCk6yXHFi2rhs=;
        fh=GGqFQryYu+czal9zRto+i6KRVKGbCPocCqJESsY1AO0=;
        b=WaS0dq2KRsywPknn8GlbupHQWTxyKIyQ5pylEhMhIZzs637ngmJRhxSG1QzkAoOsTm
         GQ6T8UewbIQST57EwKCNHfXQ0EydlRG1j+LcQ3E6+gQIqAFvj/1ME6+nNkxT30KIVSv0
         wfGO0FJU3deBIELIm2hI9SZ3lZ5a2pnXfWSUlmsLfNzQqIRplWJv97UNo1pQ7lNpFcg0
         5fQQFGi11hQGmCtNzlgnf3R43kJogxPAEX8S+J14mul0baDAgDQbFdlKiQpqt+rVmfi+
         mV+/9FniMIIshL+azwlyWjNRMeZTqDNI5miVcWRu/OcBaJjnJDuX34bJLry7PmXTS7vF
         2YsA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793392588; x=1793997388; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mfTTVpEW/ASHSaJiK1tCpdlPNObyw7zCk6yXHFi2rhs=;
        b=WrM3qAIYKEK00WP/+lqIwQz3CQQOj0Lp1bLj1blKx8HSACOYdwkJu3mh/ul/bE8YBH
         mQ/71ftJaB702Fw7fZx/bXPqTGAKzutVi71mwwKqduVqUCDZ7bpRwnYrf80G/kZoSo9+
         l2QTCl956UTOxBwQun31xKRPOMo2iBGroxZ2ZKHHtvYJ0KvrPXWkjhTxcALnr8RYdDw9
         HteVSS4rTNUtDMiXsIU52GUOG6FUmnRi1+vEsDwoizmvqgf0WQolX6wdZIadnTgMp3vt
         C/ZnykfOgqbdg2bjpJSZvloBT/FRET25GuFtfqxkvMAOM0yTyPYvk/5wzHmDj7EICDVQ
         KSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793392588; x=1793997388;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mfTTVpEW/ASHSaJiK1tCpdlPNObyw7zCk6yXHFi2rhs=;
        b=CEgA7Mda7+rh5sHtvhWPFRsRJ7U7huvAmmoYobkTh/PrgRdrUmvoMhuwo1TXUa1AFf
         iU/AuZVjgOy0Q5GHltKSlExLadKi8W6cT8e525jcm5feWxAv6qBX/iYz0f/F1M2GkO0q
         YiXAfc3YyIMjMeJ5JdvKix1k7lQD9yLrvx47JQTw6ptzuao/B/2NtGUcFD/nSaP6A9Zi
         Lt/sO5naPvgTQmI0ZJNvwNWM4ay5b8V9vWin5VFn1w2GKiJz+6GCvdHGpLDtqygEjdIW
         EGwIi46t8nQqjFbuyV53pjg9/TZbN9BiiS3SVMUA+jQ2kIYTCuuaLNXI0OHkjHigJFdZ
         b4ng==
X-Forwarded-Encrypted: i=1; AKwUvBw4U9A9FKbqK9RQnMppjzp87lPMPtXAiCo/fu8Cdy9OnQF2NUQE/ntNtWbFztky8tW6y9ajow==@lists.linux.dev
X-Gm-Message-State: AFq9FYLYMj922klfbzoT2w+o1FrpKkFsrsGve7yM/qsqkZ46UqlGgQnA
	OGqZDG3qrzZiOHr4C++p5DG2sAen9ECMe21FOl1baLQmVGk/mk8fRTsQnn0zRzs8TTVttpdw1Ut
	BNio4J8Ujs8cBbZ88lctw9lwdcd7oFS5pkNXvhE6P
X-Gm-Gg: AYBFou2yp4n7lY/5EB9m0zpuQN6YuayEoTIaX9B2BbL1IIqkNhAjAGloDsKFrzQSW2i
	42l91CR3tMtUC2cjqOj10JWY87Sb33QbVaB1Lk+0HZOPH0+78giFCOYF/lXHBLDAt6IOxhz0l78
	t+jFTvOBH4CxCfmr9EiiznSFRkbjzH3OiA2iJ+yTQhNEldFPmuqZg5UH8VQTfCt+fP90zSGhifZ
	r8IqCMkv8/IMSauXQWY6JoerbZI4UsimXdJVXnchER5IiUg+9e7xz1shMrhbdo8vmguldiFvGB5
	Y0KKh+DRVnZzS8q6N0qlKLRD1yV95y/zHUnxRgxs4/xs57uG2aOb2lTH2rgoFoT0IFsp+s88ZtO
	m6BOGk0uKrm/WFVt7ZcgHaL6y93Pyvs604qiOqmFpPdaARsT0ZGuWEqofx13/x3Tb2rgwIlqC68
	bc8JrrU86GKbYiES+/EPhqvA==
X-Received: by 2002:ac8:5c94:0:b0:532:af50:8d7d with SMTP id
 d75a77b69052e-542b6a6d6b2mr54363611cf.33.1793392587437; Fri, 30 Oct 2026
 13:36:27 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 13:36:26 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261017073149.1303738-3-aneesh.kumar@kernel.org>
References: <20261017073149.1303738-1-aneesh.kumar@kernel.org> <20261017073149.1303738-3-aneesh.kumar@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 13:36:26 -0700
X-Gm-Features: AclHuK8zIRE7fPt_40jzHY6DMSgwjgRywbF83YSieVT16EbHUHdKI8X5dSRrGPc
Message-ID: <CAEvNRgEh3E7NBc5_3Wq66Fss-mAYT6+4FWP5+=Co6+OVfVnQQQ@mail.gmail.com>
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

"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:

>
> [...snip...]
>
> +static int kvm_gmem_device_convert(struct inode *inode, pgoff_t start,
> +		pgoff_t nr_pages, const struct guest_memfd_device_request *req,
> +		const struct kvm_memory_slot *slot)
> +{
> +	struct gmem_inode *gi = GMEM_I(inode);
> +	u64 attrs = req ? KVM_MEMORY_ATTRIBUTE_PRIVATE : 0;
> +	bool prepared = false;
> +	int ret;
> +
> +	MA_STATE(mas, &gi->attributes, start, start + nr_pages - 1);
> +
> +	filemap_invalidate_lock(inode->i_mapping);
> +	if (__kvm_gmem_range_has_attributes(inode, start, nr_pages, attrs)) {
> +		ret = 0;
> +		goto out;
> +	}
> +
> +	if (req && !__kvm_gmem_range_has_attributes(inode, start, nr_pages, 0)) {
> +		ret = -EEXIST;
> +		goto out;
> +	}
> +
> +	ret = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
> +	if (ret)
> +		goto out;
> +
> +	kvm_gmem_invalidate_start(inode, start, start + nr_pages, KVM_FILTER_SHARED);
> +	if (req && READ_ONCE(gi->device.kvm->vm_dead))
> +		ret = -EIO;
> +	else
> +		ret = gi->provider_ops->prepare_conversion(gi->provider, req);
> +	if (!ret) {
> +		prepared = true;
> +		if (req)
> +			ret = kvm_gmem_device_make_private(inode, slot, req, nr_pages);

Is there a way to avoid making private from within the conversion flow?

kvm_gmem_device_map() below already does it as part of vcpu_run.

If we do the above, we'd be aligned with regular conversions, where
to-shared conversions eagerly update arch state (make_shared) but
to-private notifications to the firmware are done lazily.

> +		else
> +			ret = kvm_gmem_device_make_shared(inode, start, start + nr_pages);
> +	}
> +	if (!ret) {
> +		mas_store_prealloc(&mas, xa_mk_value(attrs));
> +		kvm_gmem_device_update_private(gi);
> +	} else {
> +		mas_destroy(&mas);
> +	}
> +
> +	kvm_gmem_invalidate_end(inode, start, start + nr_pages);
> +	if (prepared)
> +		gi->provider_ops->finish_conversion(gi->provider, req);
> +out:
> +	filemap_invalidate_unlock(inode->i_mapping);
> +	return ret;
> +}
> +
> +int kvm_gmem_device_map(struct kvm *kvm, u64 gpa, u64 size, u64 pa, u64 vdev_id)
> +{
> +	struct guest_memfd_device_request req = { gpa, pa, vdev_id };
> +	struct kvm_memory_slot *slot;
> +	gfn_t gfn = gpa >> PAGE_SHIFT;
> +	struct file *file;
> +	int ret;
> +
> +	if (!size)
> +		return -EINVAL;
> +
> +	if (!PAGE_ALIGNED(gpa | size | pa))
> +		return -EINVAL;
> +
> +	/* Caller holds SRCU across the pending architecture request. */
> +	slot = gfn_to_memslot(kvm, gfn);
> +	if (!slot || (slot->flags & KVM_MEMSLOT_INVALID))
> +		return -EINVAL;
> +
> +	if (!(slot->flags & KVM_MEMSLOT_GMEM_DEVICE))
> +		return -EINVAL;
> +
> +	if ((size >> PAGE_SHIFT) > slot->npages - (gfn - slot->base_gfn))
> +		return -EINVAL;
> +
> +	file = kvm_gmem_get_file(slot);
> +	if (!file)
> +		return -ENOENT;
> +	ret = kvm_gmem_device_convert(file_inode(file),
> +				      kvm_gmem_get_index(slot, gfn),
> +				      size >> PAGE_SHIFT, &req, slot);
> +	fput(file);
> +	return ret;
> +}
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_device_map);
> +
>
> [...snip...]
>
