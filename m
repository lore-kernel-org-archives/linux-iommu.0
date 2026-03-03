Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC763B4E83
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563885; cv=none; b=JaFIfO7FZoTnCik3yWqUisQYGlVSPjkxundZmlFjtENjsgomFcDEXzPHzmc8qoqWBtaGhfpJuVmkb4ndwuiMppS+uP9kqbIUingw1cb89D2mg0B59+pLwoJ3P94wzAW5s9Qq520JzHncxKCjoq7P4Y1i1J6nELiZ9Tz/Ov2FR8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563885; c=relaxed/simple;
	bh=saFrkHD9A0jl8FG23ePEQhYjIEsy4y0Or5I6Qiz+iBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cn88RVfowps5qVzqx8PdAS+Mm9UjB5KkeOnPhTX1QMmttwq5agJGAJ2+8jW6kX0Gm/l8EWo6/Q8uEYLX1gHvxaNBQNwrweReuMt/0/Z/AZeyaZIaSpPb/4n8telW2MSzV5Q/SKL8Be5QMu4atgAX4UISEz82klybE997ivjtpv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kZniKnAh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZniKnAh"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae49120e97so92855ad.0
        for <iommu@lists.linux.dev>; Tue, 03 Mar 2026 10:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772563881; x=1773168681; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HlPLV02PSXP+edDlOLBCujALxcDghVDbBowN1loqhmY=;
        b=kZniKnAhdHBLvxMGFWdAyidoMzQ2gMCDV+toK9ie30QazW9vDD0Yk7t94YrZYOMVtU
         5qdYNu6RyTEEiIXMaFLFlE1RZ/Yc1jwZkv7scnh4bwqOQQUFGFjdi5UB7KHpFtbi40kv
         jYosIovZ+lthCSiHtf9Im8ACzsKExaEkB1diYgkytTFcfQCF+MyAgEbM/oVxzjqQq5Gq
         3k05JB06Vy8AKkfR8jWCuJQYxWKZo8hCbdVpnnP5CAGRUOw9GRauP81Chs+Z1jtLaY6X
         KpQe6cQmq82/Azu0ob+1Ys5boMrut+V/aJdKt+6CphXB2w7SFhGMdMYIxwJuzhgXxROi
         VCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772563881; x=1773168681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlPLV02PSXP+edDlOLBCujALxcDghVDbBowN1loqhmY=;
        b=rBcNvPYj05aPNJW78qBFPTPCYnyfZHpYHfSpKdWQry1BAK/FIfjUeSw9wny5Kwqs6e
         BNtm8cRtWuocvDDmZrkbwzZUzI06z4i7siz3+MWUvYwhhG49mHwWrsdrcmRVdROekjoq
         rhCg1uQrvpFtfh7bNyxX+uP1TcaocS8rpELQ/hkKH9v8UmbhDeV3w/eeSEBvCWrqyAa3
         PW91ieA+NpZA5DCLrcrYj7fPzNhz9cThAMHW5oWvGBcjEx0RGo68MH0TqT+4IHhK8u4Z
         /30H1yvQheQFh9UiZAkqcWawP6gr4tF9iXfiGnQdoKJ3RSb00AUdiHbpRZV9MBInSG0e
         E7Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXnlxJQSp4Sj4X+/jvnGwpVLGHzOe5L6Pf6xatpaloVZnUvSn/pe5pXXwsFnnc6blPkUFAaog==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzt6t76QkPtICp+g6qvwIRpIrjel/l3PoDcDhrMO8/7MP2Q+Tdr
	SsktnSHnfygD6rQuPayNr7UmBRN1YR7BKKCfZZf2gU+fVNQtVDTq4rgyBFynrYkgzg==
X-Gm-Gg: ATEYQzy4UbtBw11IhA4kX3e/7R9t19eJ3NnSdh+sPtCriHFd9u+l7ZEeB1b0bhyypvD
	N+F4n3G/MhOrd8KMjm5T/eptMNj9ZgNg6inlU9koeTwVA24gR9LckPHk37U4sBpIm5n7BsWRGj0
	xi6DEAi+8k2VvQb+o0PCzGLufeI2VkzOySHsL3dW43IYZ82mAMGWKe+hUdCeUyx4Fx5Y9OhIhlF
	O3OtnIQ/4QZsxExpta9TrHPPvA9r4fA84hCCffUdn5B3fw/aF5URsa2JQrfAHl9scpwp7LZKjmU
	a9+4gJRfoLCm99w4Gx86xXw09Dwd0/NqmzRsSjHDbs6rydgy5+jqo34rNAkEvuvKdNGa6gcxV4+
	pkkgQceWZIzZkKWXYBuWzHS9fDEuBKQ7B44wFLZganeCI7oIedRULgXDzUQvt83efxAyleUy2Z3
	OC6KRwaZLQfKXzk+3Z68lzZRFTKUbQBlb4QRrJqs6TWSOWcNYWXTPcTz59qjs8RA==
X-Received: by 2002:a17:903:fae:b0:2a0:867c:60e2 with SMTP id d9443c01a7336-2ae3b5554c6mr7299895ad.19.1772563880765;
        Tue, 03 Mar 2026 10:51:20 -0800 (PST)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5db596sm183363085ad.35.2026.03.03.10.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:51:20 -0800 (PST)
Date: Tue, 3 Mar 2026 18:51:16 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH 11/14] iommufd-lu: Persist iommu hardware pagetables for
 live update
Message-ID: <n56v7llotm7jlkev4rsrm6l36vpzyufrx273ay5455hfauttzn@kn3oydrbhill>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-12-skhawaja@google.com>
 <srgagoecgejftgvvqstjiwazi6blsljqyae3v5dlyj7nlv5lii@rjigll2eosuj>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <srgagoecgejftgvvqstjiwazi6blsljqyae3v5dlyj7nlv5lii@rjigll2eosuj>

On Tue, Mar 03, 2026 at 05:56:15AM +0000, Ankit Soni wrote:
>Hi,
>
>On Tue, Feb 03, 2026 at 10:09:45PM +0000, Samiullah Khawaja wrote:
>> From: YiFei Zhu <zhuyifei@google.com>
>>
>> The caller is expected to mark each HWPT to be preserved with an ioctl
>> call, with a token that will be used in restore. At preserve time, each
>> HWPT's domain is then called with iommu_domain_preserve to preserve the
>> iommu domain.
>>
>> The HWPTs containing dma mappings backed by unpreserved memory should
>> not be preserved. During preservation check if the mappings contained in
>> the HWPT being preserved are only file based and all the files are
>> preserved.
>>
>> The memfd file preservation check is not enough when preserving iommufd.
>> The memfd might have shrunk between the mapping and memfd preservation.
>> This means that if it shrunk some pages that are right now pinned due to
>> iommu mappings are not preserved with the memfd. Only allow iommufd
>> preservation when all the iopt_pages are file backed and the memory file
>> was seal sealed during mapping. This guarantees that all the pages that
>> were backing memfd when it was mapped are preserved.
>>
>> Once HWPT is preserved the iopt associated with the HWPT is made
>> immutable. Since the map and unmap ioctls operates directly on iopt,
>> which contains an array of domains, while each hwpt contains only one
>> domain. The logic then becomes that mapping and unmapping is prohibited
>> if any of the domains in an iopt belongs to a preserved hwpt. However,
>> tracing to the hwpt through the domain is a lot more tedious than
>> tracing through the ioas, so if an hwpt is preserved, hwpt->ioas->iopt
>> is made immutable.
>>
>> When undoing this (making the iopts mutable again), there's never
>> a need to make some iopts mutable and some kept immutable, since
>> the undo only happen on unpreserve and error path of preserve.
>> Simply iterate all the ioas and clear the immutability flag on all
>> their iopts.
>>
>> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/iommufd/io_pagetable.c    |  17 ++
>>  drivers/iommu/iommufd/io_pagetable.h    |   1 +
>>  drivers/iommu/iommufd/iommufd_private.h |  25 ++
>>  drivers/iommu/iommufd/liveupdate.c      | 300 ++++++++++++++++++++++++
>>  drivers/iommu/iommufd/main.c            |  14 +-
>>  drivers/iommu/iommufd/pages.c           |   8 +
>>  include/linux/kho/abi/iommufd.h         |  39 +++
>>  7 files changed, 403 insertions(+), 1 deletion(-)
>>  create mode 100644 include/linux/kho/abi/iommufd.h
>>
>> +
>> +static int iommufd_save_hwpts(struct iommufd_ctx *ictx,
>> +			      struct iommufd_lu *iommufd_lu,
>> +			      struct liveupdate_session *session)
>> +{
>> +	struct iommufd_hwpt_paging *hwpt, **hwpts = NULL;
>> +	struct iommu_domain_ser *domain_ser;
>> +	struct iommufd_hwpt_lu *hwpt_lu;
>> +	struct iommufd_object *obj;
>> +	unsigned int nr_hwpts = 0;
>> +	unsigned long index;
>> +	unsigned int i;
>> +	int rc = 0;
>> +
>> +	if (iommufd_lu) {
>> +		hwpts = kcalloc(iommufd_lu->nr_hwpts, sizeof(*hwpts),
>> +				GFP_KERNEL);
>> +		if (!hwpts)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	xa_lock(&ictx->objects);
>> +	xa_for_each(&ictx->objects, index, obj) {
>> +		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
>> +			continue;
>> +
>> +		hwpt = container_of(obj, struct iommufd_hwpt_paging, common.obj);
>> +		if (!hwpt->lu_preserve)
>> +			continue;
>> +
>> +		if (hwpt->ioas) {
>> +			/*
>> +			 * Obtain exclusive access to the IOAS and IOPT while we
>> +			 * set immutability
>> +			 */
>> +			mutex_lock(&hwpt->ioas->mutex);
>> +			down_write(&hwpt->ioas->iopt.domains_rwsem);
>> +			down_write(&hwpt->ioas->iopt.iova_rwsem);
>
>Taking mutex/rwsem under spin-lock is not a good idea.

Agreed. I will move this out by taking a reference on the object and
then setting it separately without xa_lock.
>
>> +
>> +			hwpt->ioas->iopt.lu_map_immutable = true;
>> +
>> +			up_write(&hwpt->ioas->iopt.iova_rwsem);
>> +			up_write(&hwpt->ioas->iopt.domains_rwsem);
>> +			mutex_unlock(&hwpt->ioas->mutex);
>> +		}
>> +
>> +		if (!hwpt->common.domain) {
>> +			rc = -EINVAL;
>> +			xa_unlock(&ictx->objects);
>> +			goto out;
>> +		}
>> +
>> +		if (!iommufd_lu) {
>> +			rc = check_iopt_pages_preserved(session, hwpt);
>> +			if (rc) {
>> +				xa_unlock(&ictx->objects);
>> +				goto out;
>> +			}
>> +		} else if (iommufd_lu) {
>
>Redundant else_if().

Will remove
>
>-Ankit
>
>> +			hwpts[nr_hwpts] = hwpt;
>> +			hwpt_lu = &iommufd_lu->hwpts[nr_hwpts];
>> +
>> +			hwpt_lu->token = hwpt->lu_token;
>> +			hwpt_lu->reclaimed = false;
>> +		}
>> +
>> +		nr_hwpts++;
>> +	}
>> +	xa_unlock(&ictx->objects);
>> +

Thanks for looking into this.

Sami
