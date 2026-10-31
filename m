Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793417985;
	b=0BVOyJnV2+IXAUEQAFdrWdune1HgitsJnXiQSERF1lq7cmaclW98A0MWK5SzHGX/RcZR
	 UzR8g/X6XHvz37g1X5v5RVloIIKt6dIfbmpvtbCvmYIwCqLhgBxMtIhkZHVXk/TeJr2gB
	 0kUgiLgXO152OQq2GznEx8t/6M9UpXsBcyjbwEYVU2tqQ/FMAMTc67aVgf/xjWrmLEMf1
	 WNTP0+8q1AFNa+52cUUnh9wSPdAM7zojuS596zgCS/zbXH+aXRNB17b34mQd7nsTEuJb3
	 t5cjixtKZUasf3jg72XtiOcvL4+CyKpNGkcylBWpP5o6Wc5GtWujV9FYW9TeZ6RVKsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793417985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=NXyWjDtz5Zwj67m+4i2xpy2FHpW9IbWNwHkPcCAx9Qo=;
	b=FyVswGNGIbA7f+gJG4ByB7UTFq25fFhaWuIiqrVF5LxHN7PLSPQeOoy4r3aaMphAOZUl
	 bumrFnqUYyhq649Eqe+S93qotYXRls1KuRtLb+QlknL2OhOd3JjLlo6mWdWZtxOXZwfuR
	 SqBgcBSNykjTmtr5VKz1armexpu6/eHVYjCf06HGffxx8kcCUn1Cz2Ileytj/GjXW2+EA
	 vWik4H/SKWjM1GGmu6ghWTZt00psWeFTuQaqykeBCzQsFGrrWi52h1BJiQgu4dZwRfs1+
	 +zkrf/O84ZDhwvdrflvBSjW1p4WH8OyqTVvUcljMRbEZ6/81xNeBokfZBDrh4aA/vow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cGpmHiTE;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C0E606A31A
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 03:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92C0E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cGpmHiTE
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9f6a16afcso18845ad.1
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 20:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793417984; x=1794022784; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NXyWjDtz5Zwj67m+4i2xpy2FHpW9IbWNwHkPcCAx9Qo=;
        b=cGpmHiTEVW80KXnEcH43jHUvCycKtW1cvJgxnLZTZE1eGhk6XznkZcfstHI69XKqfQ
         IDcqNZwbSBppiYbOU3QaJSTvJqtRmHUvdvOgomuupokbjFR2xPqJBzjK9drqLroMfDA2
         zUkLjEARRiQamGyat7mcpgEONwobmNeuYD2UKPqUNdMniXNnbfWCiOKa+DRmb6yEg6GH
         lPD8FFNpFOARTJza8S/krhuoxS/7aL/GqWk3f5gjHIAqmqOjfXwFQEExmsrvG1TZHv4C
         ODs7yPAW4Zw2xTFzZjHD+epEcODqFFhO0y28vjGK7x2B4oM0+4DOoFC74p4iOpUOib1B
         MiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793417984; x=1794022784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NXyWjDtz5Zwj67m+4i2xpy2FHpW9IbWNwHkPcCAx9Qo=;
        b=Vo2f4A4gW3Yhm+VI/AjaUwjBovbnYb7z75W6xINorkDahYdfFQmr2exreXo3/N36IJ
         RN4MU1aCheqy1BRG1Y7eUBt0NV3lvDoVZC2Kff0KtmLO1ymwfxM6zqKbfbDu7H/AvJLj
         Nfwhoj3VBIUr/noGTqRkQmRLlP6Y93rh33omi6blj1m5uHY6rtqRS74+e64x7+o1KCK8
         f6ovZoVMnzHcvYScfZf+WMeF0gyH7FQtxzu9rlcuiiU3WfO8wEm6l1Yus1L//L/qSp1+
         e9umxZMCantl/qIZ2Tv56HKmyBCS0gCmT4XbMALKbamBkmvYjazyNyBjDk+TwwuRb0vz
         3p+w==
X-Forwarded-Encrypted: i=1; AKwUvBw4KxhBjJ3kuSe/BVgLAHnjndlt57zsCxlFbWRKDpAuRHbOLLHzSNGa826ZBhENobuaMsk8KA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIKr+MWdGTBHTUrqXim3K4eyF+LF/bmms7/iPn8Ds36k7h6Xgim
	IsPR/laDAQjJtN0ovkvSYxxPn+bQTpuux3dcAO1o8o2cRAljI56z/HsLgzbqJ9XaCg==
X-Gm-Gg: AYBFou0nyYknz05FBJDRTP7I0OkqLZRPbls1/XsCrkllCDLRisaJ9SOTpNKp2OP/wuy
	1fSIqJDR/vGwgbJUUEbP3gptdu5Qn2Xf8FuMRByNWsum1HKKYCov0yndlEvXdusraLfFCh9GccW
	lk+tbZGqCH2ekaPTjXKI2T69pykB6nyw//xhgs99LkOG2LLHNs8QV4nwxOwn3mOLzKD0M7xWODS
	EaS6S62yJnlyb5o2O3/FRoz1QrhA/Vv4kjp93sGF/plPhaFaLqiJjon7rqnbMkgXDt+AUkXOoZo
	URjliRiI+RGrlHjbU3zvxB1u5OISnSwoNZWQcMkqhVkLf01NxblMY4I08jj3qy4+Fe17IyCQ/1d
	PphkWmJPt+2Z7TiuNLRr9/BSCqjPbWalkntFYN0iElXPlsMqZ4p9zLOtapfpxoFbKuDuDYmtAeB
	hDl/GtdqTIeZeO9G2iS3Kh3GnVSrdDjtd1P+SWHIn1ICR5Jlqd3K3aU+1ss12111QFw8h5/6EH1
	PuXuzN6TZdeUaQMRVOX3CW4vjxfG2I0QDv84GFdp4ju4uH2LiulsxjQU9/i17PozjBzzRCANHfw
	VmXDlWJxMDXaLQBe3ozzkwaO7+NMrikmTQWtVFessmId7Xxpxg3Z/9eK8c3+hY0gJ407GFhVo0k
	VJuq/gMcFa1NyO1cSo4Vgf7I=
X-Received: by 2002:a17:903:3904:b0:2e2:d665:6ad8 with SMTP id d9443c01a7336-2eb1b81b9e8mr15045105ad.4.1793417983213;
        Fri, 30 Oct 2026 20:39:43 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9583c1sm11236719a91.10.2026.10.30.20.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 20:39:41 -0700 (PDT)
Date: Sat, 31 Oct 2026 03:39:36 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 05/18] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <auVfqaDhk25JUkYd@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-6-skhawaja@google.com>
 <df75f891-05a0-4d47-8705-d6a00c81ff97@linux.intel.com>
 <auTzN4NWuKsBvIZU@google.com>
 <51b23019-8ac2-4f6b-9be7-29f3635b472e@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51b23019-8ac2-4f6b-9be7-29f3635b472e@linux.intel.com>

On Sat, Oct 31, 2026 at 11:04:22AM +0800, Baolu Lu wrote:
>On 10/31/2026 9:45 AM, Samiullah Khawaja wrote:
>>>>+
>>>> #if IS_ENABLED(CONFIG_IOMMUFD_TEST)
>>>> void iommu_device_unregister_bus(struct iommu_device *iommu,
>>>>                  const struct bus_type *bus,
>>>>@@ -626,8 +668,8 @@ DEFINE_MUTEX(iommu_probe_device_lock);
>>>> static int __iommu_probe_device(struct device *dev, struct 
>>>>list_head *group_list)
>>>> {
>>>>+    struct group_device *gdev, *gdev2;
>>>>     struct iommu_group *group;
>>>>-    struct group_device *gdev;
>>>>     int ret;
>>>>     /*
>>>>@@ -661,6 +703,13 @@ static int __iommu_probe_device(struct 
>>>>device *dev, struct list_head *group_list
>>>>         goto err_put_group;
>>>>     }
>>>>+    for_each_group_device(group, gdev2) {
>>>>+        if (dev_iommu_has_preserved_state(gdev2->dev)) {
>>>>+            ret = -EBUSY;
>>>>+            goto err_free_gdev;
>>>>+        }
>>>>+    }
>>>>+
>>>>     /*
>>>>      * The gdev must be in the list before calling
>>>>      * iommu_setup_default_domain()
>>>>@@ -697,6 +746,7 @@ static int __iommu_probe_device(struct 
>>>>device *dev, struct list_head *group_list
>>>> err_remove_gdev:
>>>>     list_del(&gdev->list);
>>>>+err_free_gdev:
>>>>     __iommu_group_free_device(group, gdev);
>>>> err_put_group:
>>>>     iommu_deinit_device(dev);
>>>>@@ -3543,6 +3593,26 @@ bool iommu_group_dma_owner_claimed(struct 
>>>>iommu_group *group)
>>>> }
>>>> EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>>>>+/**
>>>>+ * iommu_group_is_singleton() - Query if group contains exactly 
>>>>one device
>>>>+ * @group: The group.
>>>>+ *
>>>>+ * Return: true if group contains exactly 1 device, false otherwise.
>>>>+ */
>>>
>>>We discussed this interface before, and the consensus was that such an
>>>interface is not feasible, because the membership of an iommu_group is
>>>not fixed, given the hot-plug support of buses like PCI.
>>>
>>>I am fine with the usage model of ensuring the iommu group of a
>>>preserved device to be a singleton, but I don't think we even need such
>>>a kAPI. It should be handled case by case.
>>
>>The iommu_group membership can change, this is why we check it in two
>>places, both under group->mutex:
>>
>>- During preservation we check that the group is a singleton, and check
>>   again after setting device_ser.
>>- During probe we refuse to add a device to a group that has a preserved
>>   device.
>>
>>So if a device is added to the group while we are preserving, either the
>>probe fails because the group already has a preserved device, or the
>>preservation fails because the group is no longer a singleton. Could you
>>please elaborate what you mean by handling it case by case?
>
>I am fine with the singleton-group checking logic you described above,
>but I don't think we need a helper like iommu_group_is_singleton(). It
>drops group->mutex before returning, so its result may already be stale
>when the caller uses it. That makes it easy to misuse in the future.
>
>I'd prefer to open-code the check where group->mutex is already held, as
>iommu_attach_device() does today:

struct iommu_group is private to drivers/iommu/iommu.c, and
iommu_preserve_device() is in liveupdate.c, so open coding it there is
tricky.

You are correct that it drops the lock before returning. That is why I
recheck the singleton state after setting device_ser, which handles the
race.

I was thinking of adding something like iommu_group_lock() and
iommu_group_unlock() for this, but the number of devices check also
needs struct iommu_group definition.

To avoid misuse, I can add a comment on iommu_group_is_singleton() that
the result may be stale and the caller must recheck. What do you think?

Thanks,
Sami
