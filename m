Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72443CAE69
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773421105; cv=none; b=hmVqsbXajF/+sFtRzQpZ8RIFLVubr/b7HWKr4EeBOKusuSmLl0Jy1lHdL4YV7/8W9XZIeKYI9RlVGNio/3U2TFXo8qkuWY9smy6IQ3c7C6Tn7OmyqOV5xg0gq7sRAlEExPw06zv/rgP7ovu7cHnH/UVsfRzp+a/4ICAW66FR6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773421105; c=relaxed/simple;
	bh=JotDbto36hMeejAjHcf798lMGCVYXdIVc/vM24Y9foM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjLNBbgQ17e92XcD2V3k06vOOsm1nkH8l2Wc8iEHOoUcBpzYbXKwq0lDcZ+FMb1e9rc/l4HpCRepSSF9eR277H/2N7HE+eY5Zt1Z6QmYWJmz+FMawf68mFcDwLFXyQir7bVjT9D76UnuTuoKXhkHAM/HbXSDtZ8kxXTeYA/CBAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o6UkjZIv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6UkjZIv"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aea4ebb048so2375ad.1
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 09:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773421103; x=1774025903; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vAIKhwXtibYOylihf36AZt2CKCO3X/rqMIMWFfZghRs=;
        b=o6UkjZIvxsFfdnFS8KFYG3DXvBvzBE8PVp30gs7DXufl70aH9OAO9N6ex/rlQAl20c
         qXXAlSV6v+XsUpqEcIF2P8fBrxXkWhtJ5yOFzofm4G7PeAVzW0x725wkFATK2Z2JNL5l
         ZtzvCXiU13y/bsie/oniAFB0cl7MgxsJviyuBJ2FHv4GZV9YaYBfQ6Ik5l1FIt2h+PaH
         hb2HzQfZu+gSCKA3FYEwJq9/KG2tQgggA7SvnsvNzFGYEpHQyNifdugQsDLzoYwOZgRm
         oxx9DGCI1Jqkagx/Ic3vU4xDuIvwSzfonUL/QzupJJAV6OsEYQI9e28OiuQSe0E+ByzE
         Rskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773421103; x=1774025903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAIKhwXtibYOylihf36AZt2CKCO3X/rqMIMWFfZghRs=;
        b=ZJ3Ngi4D/hm3gHjvDPqTqUXQVO2gmlfONduD64uDQ86coOd45HXbDWr/kKGLWfXpKG
         Pc29bai/zsOvp4d8X+Wy3dOdN5RkIfd5Hto5+uSM8tLUWnX09yL8Zo+HbcPRlkk16g1Q
         uiciqSERFgovTq6njuTs1s/mSqqDugtYngYJeE64CUkE0OClhW7r3E10MNjgTTuK3n4t
         fe8I77FU2B176u5VZ/SgOSdJWuNQj630in+r1aTnFK096Ys5yXK7XV2G1TLoOmFSZwQn
         9Uh+CowUjsidjijqOEtBCK5ZmcIRcaYMt1ah000Zqrw2firIhJfrpnznKCNpZs1YxUQz
         XX4g==
X-Forwarded-Encrypted: i=1; AJvYcCVJF3Lp+MQ1Fw8tJhn1Es4JFGriL/fYARKnDQr3Ih0hMGEjamHm6YzvaVMUMQNeHQRZoJB5Tg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAknCrMbKiDRbT4Uu4Uij98ySIstuuoC3gEIKR4KvAfcz86sDC
	PERia4aXX2p36BZJoeWQdruQEsDnKauUe6HeUvoFzszmXAeB6a+NzmN7uqBVbBrz3g==
X-Gm-Gg: ATEYQzwzPjYDH8rcklzY2m/1UR3c24DfQnaSBNSQHPO3khmIC/dfxdIDLGQLHSsbD8/
	x9o1/jRfQ8t1ypx4Qj7KMPnFX7zGEzzRNm7eQHvRyuBQVfCxd4qnQLDITVVpUUoSnu8n2pm0VAf
	nEgbVt8kDYW5+WRM13xG7W3uOVidHVetoZw6NEmR43Sns9GvEG52JrkugKYhy06NZ6kAG3LR370
	ukw/Z8GF7jauVyYRLzVTslEhb6LID6WwMa2rBwvDcEK8gl3SztvUM3sLFCQN1+leXHmxNEOAkGf
	BMjxlMNwpO7UGBYLt7JaPNXSmQImfd/H718TldH/gFzKqVLSY/FT0RrnSbIMih8+Pi7Q4sPB6b5
	I3IO9kT5s0X8ObpP29v9jueZQ5Fg5LKa29vnxVfBu1z5XyI91o+MkI3ha0zWb1n8NHrFixEUErV
	3TammNtLqfikMoK8clnt1drHDHfFy/WvqTIHAP/25jU8EdMvpK2NqPsodsq7zDtA==
X-Received: by 2002:a17:902:d2d0:b0:2ad:ab68:f2c3 with SMTP id d9443c01a7336-2aecd606615mr2781505ad.13.1773421102229;
        Fri, 13 Mar 2026 09:58:22 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece8629bbsm26159985ad.88.2026.03.13.09.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 09:58:21 -0700 (PDT)
Date: Fri, 13 Mar 2026 16:58:17 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
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
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 01/14] iommu: Implement IOMMU LU FLB callbacks
Message-ID: <abRB8Vy39nWfgDFP@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-2-skhawaja@google.com>
 <abHZdOKyLmmmHADz@google.com>
 <abLi5giBpi05_CLn@google.com>
 <abQvAY8Ao4acgmk2@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <abQvAY8Ao4acgmk2@google.com>

On Fri, Mar 13, 2026 at 03:36:33PM +0000, Pranjal Shrivastava wrote:
>On Thu, Mar 12, 2026 at 04:43:00PM +0000, Samiullah Khawaja wrote:
>> On Wed, Mar 11, 2026 at 09:07:00PM +0000, Pranjal Shrivastava wrote:
>> > On Tue, Feb 03, 2026 at 10:09:35PM +0000, Samiullah Khawaja wrote:
>> > > Add liveupdate FLB for IOMMU state preservation. Use KHO preserve memory
>> > > alloc/free helper functions to allocate memory for the IOMMU LU FLB
>> > > object and the serialization structs for device, domain and iommu.
>> > >
>> > > During retrieve, walk through the preserved objs nodes and restore each
>> > > folio. Also recreate the FLB obj.
>> > >
>> > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> > > ---
>> > >  drivers/iommu/Kconfig         |  11 +++
>> > >  drivers/iommu/Makefile        |   1 +
>> > >  drivers/iommu/liveupdate.c    | 177 ++++++++++++++++++++++++++++++++++
>> > >  include/linux/iommu-lu.h      |  17 ++++
>> > >  include/linux/kho/abi/iommu.h | 119 +++++++++++++++++++++++
>> > >  5 files changed, 325 insertions(+)
>> > >  create mode 100644 drivers/iommu/liveupdate.c
>> > >  create mode 100644 include/linux/iommu-lu.h
>> > >  create mode 100644 include/linux/kho/abi/iommu.h
>> > >
>> > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> > > index f86262b11416..fdcfbedee5ed 100644
>> > > --- a/drivers/iommu/Kconfig
>> > > +++ b/drivers/iommu/Kconfig
>> > > @@ -11,6 +11,17 @@ config IOMMUFD_DRIVER
>> > >  	bool
>> > >  	default n
>> > >
>
>[ snip ---- >8 -----]
>
>> >
>> > > +enum iommu_lu_type {
>> > > +	IOMMU_INVALID,
>> > > +	IOMMU_INTEL,
>> > > +};
>> > > +
>> > > +struct iommu_obj_ser {
>> > > +	u32 idx;
>> > > +	u32 ref_count;
>> > > +	u32 deleted:1;
>> > > +	u32 incoming:1;
>> > > +} __packed;
>> > > +
>> > > +struct iommu_domain_ser {
>> > > +	struct iommu_obj_ser obj;
>> > > +	u64 top_table;
>> > > +	u64 top_level;
>> > > +	struct iommu_domain *restored_domain;
>> > > +} __packed;
>> > > +
>> > > +struct device_domain_iommu_ser {
>> > > +	u32 did;
>> > > +	u64 domain_phys;
>> > > +	u64 iommu_phys;
>> > > +} __packed;
>> > > +
>> > > +struct device_ser {
>> > > +	struct iommu_obj_ser obj;
>> > > +	u64 token;
>> > > +	u32 devid;
>> > > +	u32 pci_domain;
>> > > +	struct device_domain_iommu_ser domain_iommu_ser;
>> > > +	enum iommu_lu_type type;
>> > > +} __packed;
>> > > +
>> > > +struct iommu_intel_ser {
>> > > +	u64 phys_addr;
>> > > +	u64 root_table;
>> > > +} __packed;
>> > > +
>
>One more thing here, let's add the "intel" stuff with the intel patches

Agreed. Will move these to intel specific patches.
>
>Thanks,
>Praan
>
>> > > +struct iommu_ser {
>> > > +	struct iommu_obj_ser obj;
>> > > +	u64 token;
>> > > +	enum iommu_lu_type type;
>> > > +	union {
>> > > +		struct iommu_intel_ser intel;
>> > > +	};
>> > > +} __packed;
>> > > +
>> > > +struct iommu_objs_ser {
>> > > +	u64 next_objs;
>> > > +	u64 nr_objs;
>> > > +} __packed;
>> > > +
>> > > +struct iommus_ser {
>> > > +	struct iommu_objs_ser objs;
>> > > +	struct iommu_ser iommus[];
>> > > +} __packed;
>> > > +
>> > > +struct iommu_domains_ser {
>> > > +	struct iommu_objs_ser objs;
>> > > +	struct iommu_domain_ser iommu_domains[];
>> > > +} __packed;
>> > > +
>> > > +struct devices_ser {
>> > > +	struct iommu_objs_ser objs;
>> > > +	struct device_ser devices[];
>> > > +} __packed;
>> > > +
>
>Thanks,
>Praan

Thanks,
Sami
