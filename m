Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BADC3D5643
	for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786736769; cv=none; b=fKb97ABSeTjH/DZsAXQYbsyyhi4uz6/VKv/QVK3y8Wf+honsir9MqKGTl4pfLXmQ1D2Qv0+jw5iCFhdhb/+LJmvj+4gok4pMxIo18AtaAl/m1cGt3GkmpnonpbMnrqMnDI6ckYlXunxKyCtoMdqBHMfhwePNdf1nwv5vbKHk5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786736769; c=relaxed/simple;
	bh=baOJZPd7nJlBagSvu4EY/e0qB3OgSpSkb6F80UmuE5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oByBFLLoOjG9JVc8I2uN/9vcCXNvGWi+PKTC23UtfXGx1F3PVcElOwSY+8PM/huafcohtN7DGIHE/in6xMX+TeZU5giWFow9i1VzJxfV8cSKbqJjgKZaRWZAZXRBMp/SJ12MGc9xT82ykUy9aluwR0wZPRQeoT1S/YRYHCSqyjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xtv9bLiK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xtv9bLiK"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d3b445a84fso126925ad.1
        for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 12:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786736765; x=1787341565; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S64AgIWO7QxYO2SGcf+4LpPDoMjsF/PwjvLqa2d2Geo=;
        b=Xtv9bLiK5bhdzbZvwUqvVpULhwzcxFEG0W6SxM5/sn64LtaI0IBhlyr1B0nioxCgkw
         p2QOElNQfu4vww9pC2UolrxCjOsc6DUMLnu4rWyml5CxuYTHmmduB9GxTviXEyWg2PlJ
         c5hir2NOdxmobacgcqNh20gSPzii7UtVrwP5/PViTfv8VQj8vJbzZv7WHVhwVqmVkAuj
         SL9SLYyLPiDFcxMRESukxCBi/4YhqG+UUEzGn436Ft30F7IxZVrirtKCS9slwLQBZcGI
         YMmMylmGxbHQFlTZOud/EO1WR8fV8GgnAHegC22St7PuCkplYVVvsBzXm/rkJTE5wUDB
         nvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786736765; x=1787341565;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S64AgIWO7QxYO2SGcf+4LpPDoMjsF/PwjvLqa2d2Geo=;
        b=Pp7ZKb0JiUgJamrLsYbUKx2Kp2dMnqEW+OLQ7KaDzxkIMcPUlDecxFOUI897Bjy9j5
         WQwIWnZmmf1A9cykjkaVzHQ5qUSUUEdYuTJSZTs8ZI3XgtD+aMqw3iurBCGns9qsRlOP
         H50uqnZ6OqrS4ucD9BhVZolXEApOsSLUJr2nbwu3ppLzzjMlgtNsB3oGlaPnwKIUZMOX
         BCtISXM1VR71jA2ITBLGKpMyFdAQt/2k45+DhnawOjcXiwuV7640K63dthPy3M7AXlB/
         +YOGRwWC7LcB3XgCIrYUcokbamRGDl0FBxrsLGCKLPMD7eSFV4u+4NdpiIMmcs1GGKnV
         yaVw==
X-Forwarded-Encrypted: i=1; AHgh+RpKq/uORaddP28f5W+m/4hC+v147LWRtpPvr6BuV7K3uYg70ff6550UXMipW7ffkvMOcqrP1w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy28wrIbExrxhmHBtJ9YWQomMndT5dI07EBA7honlVyMI/NKCXO
	/WVle1ELxRzEhhLf+mn5iDYRH1yvdvar3GKC6t6mTy4nUNqqH6sxkVed0eE1gqnwiQ==
X-Gm-Gg: AR+sD1234aEAiTqKUL51ci2Yp3wTqsfIaIKJmtXfzIgFh3cGSV71ejaBfaWq70irq0a
	gFUVHg9RMIumhvUZSxHLOhyjcvG3eLhnASlagUtsj6Eqw/lp6jeXq/lCPZQVfrZr5gyj4jAihvW
	aOdSb8XxRVWl3ycFQq4BNAo0lQmNMLnyoR4mRDJrpRfmepwLvjTQGYDf6uANRn9KpH4TNoukZRS
	dR6kBWzZy35tpFRTKe0O4Rlol2TgwzYaFiHJpiV//ZrYdywkeGqrqwgLYP8x1d5Td/mZ+qJmuVy
	KEXvKQAkR7vIQvimmMKlO0RPCWbmPJfmAusQ1B4KY3533qhNFZi4DSfI68DkdoZeNEzEMMkB8YV
	FbrSVNrcOOFxVErl1P+HFH3hSUboncP5JLA2Fo1wb5wfRuf9yiAdqY9RlMQnAh/g+MF6/i8s4P/
	xRbdOmHHa3O8zCzbzL7KXJuVXHs2euVzlm11YBUQ2PypmeuN+t/jYQ4Msqonj4aK7eLfGDS//x8
	h/tZixsQ4cdVlnIwEdGC/J+KZf0j4NZ3V0A/8f9Ofmj0A9EeFWIj7M10mMqU989
X-Received: by 2002:a17:903:1b0f:b0:2cf:41ba:96b8 with SMTP id d9443c01a7336-2d3af229eb1mr12458355ad.6.1786736764793;
        Fri, 14 Aug 2026 12:46:04 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea99ab1dsm3742041a91.7.2026.08.14.12.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:46:04 -0700 (PDT)
Date: Fri, 14 Aug 2026 19:46:01 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 11/18] iommu: Restore and reattach preserved domains
 to devices
Message-ID: <an9mwcflLcLtwDrn@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-12-skhawaja@google.com>
 <xssagtjtc27kxprwyz7exeiotigcr3ksnvr53ap56ialuqlfe4@xql3pr5va6m5>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xssagtjtc27kxprwyz7exeiotigcr3ksnvr53ap56ialuqlfe4@xql3pr5va6m5>

On Fri, Aug 14, 2026 at 04:59:50PM +0000, Ankit Soni wrote:
>On Sat, Aug 08, 2026 at 02:27:16AM +0000, Samiullah Khawaja wrote:
>> During default domain setup, restore the preserved domains by restoring
>> the page tables using restore() iommupt op. Associated the restored
>> domain with the iommu group of the preserved device, and reattach the
>> domain to the device.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/iommu.c            |  76 ++++++++++++++++++
>>  drivers/iommu/liveupdate.c       | 130 +++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h |  69 ++++++++++++++++
>>  3 files changed, 275 insertions(+)
>>
>
>../..
>
>> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>> index 20acf123b47a..04c0212cd81b 100644
>> --- a/drivers/iommu/liveupdate.c
>> +++ b/drivers/iommu/liveupdate.c
>> @@ -708,3 +708,133 @@ void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
>>  	liveupdate_flb_put_outgoing(&iommu_flb);
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_unpreserve_device);
>> +
>> +static inline bool match_device_ser(struct iommu_device_ser *match,
>> +				    struct pci_dev *pdev)
>> +{
>> +	return match->devid == pci_dev_id(pdev) && match->pci_domain_nr == pci_domain_nr(pdev->bus);
>> +}
>> +
>> +/**
>> + * iommu_init_device_preserved_data() - Initialize preserved state for device
>> + * @dev: Target device
>> + *
>> + * Looks up incoming Live Update state for @dev and attaches it to the device if
>> + * found.
>> + */
>> +void iommu_init_device_preserved_data(struct device *dev)
>> +{
>> +	struct iommu_device_ser *device_ser = NULL;
>> +	struct iommu_device_array_ser *array;
>> +	struct iommu_flb_obj *flb_obj;
>> +	int ret, idx;
>> +
>> +	if (!dev_is_pci(dev))
>> +		return;
>> +
>> +	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
>> +	if (ret)
>> +		return;
>> +
>> +	mutex_lock(&flb_obj->lock);
>> +	array = phys_to_virt(flb_obj->ser->device_array_phys);
>> +	iommu_liveupdate_for_each_arr(array) {
>> +		iommu_liveupdate_for_each_obj(array, device_ser, idx) {
>> +			if (match_device_ser(device_ser, to_pci_dev(dev))) {
>> +				device_ser->hdr.flags |= IOMMU_SER_FLAG_INCOMING;
>> +				goto out;
>> +			}
>> +		}
>> +	}
>> +
>> +	device_ser = NULL;
>> +out:
>> +	WRITE_ONCE(dev->iommu->device_ser, device_ser);
>> +	mutex_unlock(&flb_obj->lock);
>> +	liveupdate_flb_put_incoming(&iommu_flb);
>> +}
>> +EXPORT_SYMBOL(iommu_init_device_preserved_data);
>> +
>> +/**
>> + * iommu_release_restored_device() - Release a restored device
>> + * @dev: Target device
>> + */
>> +void iommu_release_restored_device(struct device *dev)
>> +{
>> +	/*
>> +	 * We do not support releasing the restored devices that are not
>> +	 * reclaimed by the device drivers as they can fallback to the default
>> +	 * domain.
>> +	 */
>> +	BUG_ON(dev_iommu_restored_state(dev));
>
>Hi,

Hi,

Thanks for looking at this.

>After a successful live update this is one sysfs write away, and nothing in
>the series disarms it.
>
>At PCI probe, iommu_init_device_preserved_data() matches the incoming FLB on
>devid + pci_domain_nr and sets IOMMU_SER_FLAG_INCOMING.
>Nothing clears the flag or device_ser afterwards. The group is meanwhile owned
>on behalf of iommufd (iommu.c:3229-3231, "will be reclaimed later by the
>entity (iommufd) that preserved them"), and iommufd_liveupdate_retrieve() is
>-EOPNOTSUPP, so the reclaim that would end the restored state cannot happen
>yet. The device is left with the state permanently set.

Yes, these points are valid and this is intentional. The IOMMU
persistence support is split into two phases as mentioned in the cover
letter. The reclaim logic in iommufd will come later as a phase 2. The
preserved devices go to normal state when these are reclaimed through
iommufd.

https://lore.kernel.org/all/20260128195943.GY1641016@ziepe.ca/

Regarding the handling of sysfs, my concern is about it coming back and
going to default domain as mentioned in the comment. But I will evaluate
if we can allow device tear down here and reattach it to the preserved
domain.

Also please see the patchset breakdown here:
https://docs.google.com/document/d/1enDn-uPE9U77U-xHEnzn6HHGKiePSAtMIP8EDU3NO0M

Btw since this phase 1 is relatively stable and I don't expect many
changes in it. I have started reviving the Phase 2 patches and will be
sending them out as RFC soon if you want to experiment with it.

Sami

