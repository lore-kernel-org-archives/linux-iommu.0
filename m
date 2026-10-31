Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793474630;
	b=SZ5hb7sjMAvESPMW0Zs7RvQwnWF968zWkBb/lb1xqDVn5TrD8CBMrz1xnmxi89fYw4Ii
	 IBJKyx66Y+jf+Hv3BwTW5wKkwEUTh+wQFBPGO834x6pTJRmYwC6EZvPELm5jnXJbvjWgm
	 43r33fQKpRLGLz/0Ld9qP2ztrdA6QBffl5ioJAyf3bKxa410AVri8T2+f0Xq6XZ5e4hPP
	 DHQv83VdXB9zJ5e7E3SssM5pF8XfzD8kICD+RKONJnw0AH4J/hoK4f/Y/EcEXs3MGRWbP
	 Ca9kl9n82m3vv5h8H3P5NqhJX9mbnLS2Q0E5K/MMD04o5SkBDV+zAOmLJUXRDWmJ21Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793474630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=qee3FwDn+lR4Rdz4X353Tv1A8/aooI3LNRhrS8wuqjk=;
	b=Snh/PEmJ+mcCvZ2Rb+9o2g3BhtZ1r+LAQgcNi0n7kPxZ2LMBQ1tvievXVP/1fSjLitGS
	 fLvLuRRIzph3y9h12xGha1FLm0th6lJJh6UrmgWNSeDKOX50tCkVECJIC2b4XFEBrfSQ0
	 jFmkM6az+x2pPKArHivqSEHibKT9g8LcMRzsjUG2UT+9WeEsf7z3PBnL0fHVAL6WJevDI
	 PePiAVA4soxwn8THiP6KAGsiTFFeFToJjR6gb034/g5K5eoc/oSqSrvY9664HS68rIfk5
	 TMbpMyqoum2YkiIUUaPFH6bFLFYPjlea2pcVSoth3vTutGyajBkf3+Mzqtix5Pqv3Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fQpnYLpB;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549E7606A31C
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 19:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 549E7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fQpnYLpB
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so27915ad.1
        for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 12:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793474629; x=1794079429; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qee3FwDn+lR4Rdz4X353Tv1A8/aooI3LNRhrS8wuqjk=;
        b=fQpnYLpBXvZBv/ZmB7ima3C8IupbjOdm7o6Y8Sp+O/snsATxxrGBzObUYW3ziky5yM
         j0dijDgWfYduTP2mLMQwm0L8Ylw1Cb10irtqvKDH6VWN1bpUqP6GFtGigSTolReFvYh5
         IyXl4dUevv8D2XT7CYnyIWcCVB7ad3JXzC6Sb7RwW/8MQJVyY2bXkOp0R7XhfZPS3P5+
         oKnlnphw07Kc28amuicc60MnPBLbMIuYJ2TcLCbuez1ryDaRfsfC/5gaNaj/c2/G7B26
         LF0Nx/q3iRQoEBYtSJEHUw0S4VW2SByN4C/e+qTQZUSo1RxYI4VTY3n2cH+1LuZT4bTD
         UkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793474629; x=1794079429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qee3FwDn+lR4Rdz4X353Tv1A8/aooI3LNRhrS8wuqjk=;
        b=JaFHGQFGYS8c6utkq3OGUixou43FlRtEJCk352F5r5ve3UZGw+WQPGcAlF5FgX6iPi
         stmCUVY0ZbATyLLTIEF+iZMAUbjKsbMYGL5zcwS6T2ybPHDYeX9rrE6sdGeuLp+udJPZ
         yF377iuvhYUwz7F4UG5+BwqU9fbehmdBFk7JIVWq5cJ+8JJSwFEzgFqGsDAkxc1POti+
         Pv33crzJAcnShnupxrI41lBrne1rw4ZNhpsb9T7qjRsnvhXPc+1Yvp43I8hJCFE6Ft8o
         HIQNSatwfv71yrlFF5lTG6VD03OP7IJTcpk8REksOw56z8g0NVPs6LByaefvFSroskb9
         yxPA==
X-Forwarded-Encrypted: i=1; AKwUvBxIIl9coZj/GtYnGklWCTp8v3eobw10zo/6YORR/d6tg6Rz7JMrLtprl7yAm8fd+azOipL84A==@lists.linux.dev
X-Gm-Message-State: AFq9FYLtRDjcJdftB1FMnolZquish/jaQfyCCKgg56lSdzgRxRrqYqDl
	bFrM7JNprNdZqgLSDJuYkmPhp/UTN4RRQxtF5kRbSgO/kZsGkSGn8RI8lxbYv4oPpw==
X-Gm-Gg: AYBFou042GOAOBuqIyIgIQ6gOT7edagqL9m173QZJJrkAIDcx7D1aQNRKENJjyGfx3w
	BCwn9BDAHsiLWA/lnRYW7o09kFveQFHbyOaqa01+oiwLUFCiPFx1Sh4Lrj0szBetjICObMKPoZP
	X1EpliDA+clEhl3sbTTDdiknUsxygc95qRWtJrTnK/8XqdJlgAQTavcuP1WZjMBjzsqd+nm2lq8
	uT6Q5RY8li4KlwnrcYYhsDfRAeshgKLarT9rXrd/EVv4GIYcXMXtrQI9Yhjj3i05g3LWcNrmNIo
	tMJspSSsr9KQdHhWFtEnrKcQdnGR9zJv7LP0hQy9D+LvDGygv6gBbK7leDztqgz0zsul01wf0yN
	xMLFhFYbNAuPLge3+6oRLr9wYpUrb4apWZ3CN6dJ38wSp0StJ6B+bXygyLjbN3QixFXKnKxYCJw
	86EW5POOj9fbJU/6YQdnJEXqoqRSQoOyisvGJ4Ah80V/3iCpZw3Fxzf3e3+cO8/LSQ1atxQhe1Z
	0mRSfbNqzjTjcr8fZJCrpCdKvK/MZwAmvfPMy3K7VPJAa2P1pCLiAfk7M0h+n/Yh/beg/1/7brN
	v4YypjeujWgC653EiJGGn8KaUdo2Vw4KQX7OMEMw9uzAEjZ0viunJI7rN54tZgculKWu5m1SfRw
	oP6froPJuWuTdh3fe7icnEQ==
X-Received: by 2002:a17:903:3c70:b0:2ea:4a1:e8a4 with SMTP id d9443c01a7336-2eb1b8c029emr17347455ad.13.1793474627935;
        Sat, 31 Oct 2026 12:23:47 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8fb1ddsm12878243a91.5.2026.10.31.12.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 12:23:47 -0700 (PDT)
Date: Sat, 31 Oct 2026 19:23:44 +0000
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
Message-ID: <auY_eWa6J567s1uU@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-6-skhawaja@google.com>
 <df75f891-05a0-4d47-8705-d6a00c81ff97@linux.intel.com>
 <auTzN4NWuKsBvIZU@google.com>
 <51b23019-8ac2-4f6b-9be7-29f3635b472e@linux.intel.com>
 <auVfqaDhk25JUkYd@google.com>
 <7b059c0e-3b60-4d8c-b7d2-7dcb89a51c6f@linux.intel.com>
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
In-Reply-To: <7b059c0e-3b60-4d8c-b7d2-7dcb89a51c6f@linux.intel.com>

On Sat, Oct 31, 2026 at 01:27:05PM +0800, Baolu Lu wrote:
>On 10/31/2026 11:39 AM, Samiullah Khawaja wrote:
>>On Sat, Oct 31, 2026 at 11:04:22AM +0800, Baolu Lu wrote:
>>>On 10/31/2026 9:45 AM, Samiullah Khawaja wrote:
>>>>>>+
>>>>>> #if IS_ENABLED(CONFIG_IOMMUFD_TEST)
>>>>>> void iommu_device_unregister_bus(struct iommu_device *iommu,
>>>>>>                  const struct bus_type *bus,
>>>>>>@@ -626,8 +668,8 @@ DEFINE_MUTEX(iommu_probe_device_lock);
>>>>>> static int __iommu_probe_device(struct device *dev, struct 
>>>>>>list_head *group_list)
>>>>>> {
>>>>>>+    struct group_device *gdev, *gdev2;
>>>>>>     struct iommu_group *group;
>>>>>>-    struct group_device *gdev;
>>>>>>     int ret;
>>>>>>     /*
>>>>>>@@ -661,6 +703,13 @@ static int __iommu_probe_device(struct 
>>>>>>device *dev, struct list_head *group_list
>>>>>>         goto err_put_group;
>>>>>>     }
>>>>>>+    for_each_group_device(group, gdev2) {
>>>>>>+        if (dev_iommu_has_preserved_state(gdev2->dev)) {
>>>>>>+            ret = -EBUSY;
>>>>>>+            goto err_free_gdev;
>>>>>>+        }
>>>>>>+    }
>>>>>>+
>>>>>>     /*
>>>>>>      * The gdev must be in the list before calling
>>>>>>      * iommu_setup_default_domain()
>>>>>>@@ -697,6 +746,7 @@ static int __iommu_probe_device(struct 
>>>>>>device *dev, struct list_head *group_list
>>>>>> err_remove_gdev:
>>>>>>     list_del(&gdev->list);
>>>>>>+err_free_gdev:
>>>>>>     __iommu_group_free_device(group, gdev);
>>>>>> err_put_group:
>>>>>>     iommu_deinit_device(dev);
>>>>>>@@ -3543,6 +3593,26 @@ bool 
>>>>>>iommu_group_dma_owner_claimed(struct iommu_group *group)
>>>>>> }
>>>>>> EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>>>>>>+/**
>>>>>>+ * iommu_group_is_singleton() - Query if group contains 
>>>>>>exactly one device
>>>>>>+ * @group: The group.
>>>>>>+ *
>>>>>>+ * Return: true if group contains exactly 1 device, false otherwise.
>>>>>>+ */
>>>>>
>>>>>We discussed this interface before, and the consensus was that such an
>>>>>interface is not feasible, because the membership of an iommu_group is
>>>>>not fixed, given the hot-plug support of buses like PCI.
>>>>>
>>>>>I am fine with the usage model of ensuring the iommu group of a
>>>>>preserved device to be a singleton, but I don't think we even need such
>>>>>a kAPI. It should be handled case by case.
>>>>
>>>>The iommu_group membership can change, this is why we check it in two
>>>>places, both under group->mutex:
>>>>
>>>>- During preservation we check that the group is a singleton, and check
>>>>  again after setting device_ser.
>>>>- During probe we refuse to add a device to a group that has a preserved
>>>>  device.
>>>>
>>>>So if a device is added to the group while we are preserving, either the
>>>>probe fails because the group already has a preserved device, or the
>>>>preservation fails because the group is no longer a singleton. Could you
>>>>please elaborate what you mean by handling it case by case?
>>>
>>>I am fine with the singleton-group checking logic you described above,
>>>but I don't think we need a helper like iommu_group_is_singleton(). It
>>>drops group->mutex before returning, so its result may already be stale
>>>when the caller uses it. That makes it easy to misuse in the future.
>>>
>>>I'd prefer to open-code the check where group->mutex is already held, as
>>>iommu_attach_device() does today:
>>
>>struct iommu_group is private to drivers/iommu/iommu.c, and
>>iommu_preserve_device() is in liveupdate.c, so open coding it there is
>>tricky.
>>
>>You are correct that it drops the lock before returning. That is why I
>>recheck the singleton state after setting device_ser, which handles the
>>race.
>>
>>I was thinking of adding something like iommu_group_lock() and
>>iommu_group_unlock() for this, but the number of devices check also
>>needs struct iommu_group definition.
>>
>>To avoid misuse, I can add a comment on iommu_group_is_singleton() that
>>the result may be stale and the caller must recheck. What do you think?
>
>I would suggest something like this:
>
>size_t iommu_group_device_count(struct iommu_group *group)
>{
>        size_t count;
>
>        mutex_lock(&group->mutex);
>        count = list_count_nodes(&group->devices);
>        mutex_unlock(&group->mutex);
>
>        return count;
>}
>
>and, add a comment stating that the device count may change after the
>function returns, so the caller must recheck it.

Sounds good. I will replace iommu_group_is_singleton() with
iommu_group_device_count() and add the comment.

>
>Thanks,
>baolu

Thanks,
Sami
