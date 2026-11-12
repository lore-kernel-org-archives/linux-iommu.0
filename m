Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505212;
	b=BOqnsZ5j0LnooorEmqHazHEeoyAw/xqEWWkOv+LdlYygY8mLs81iN/uB1Jn7CAYdYD8O
	 AEJZS+xiNPUALrIWelx1KRaU07YiBURtPKMSb/oJLfy1uTyl2bEveY7GCRr6M+JzM2yPR
	 FgmXHjZJYyQihZY6GYZ4yeKi/lXgIPo5MB9T3vVoIt2FEtnVCIgob0vPDm3pkogcCJViS
	 yXFToAK6TeUik3EfXUQnvr5Xsmjo+qMJXXcm2qbx0KgzwgP3ASBB32ujrpgdP96ssJS3j
	 UVHqgwiM9pb7eItIAz0ORxyYXbN738DrYunl5FdMxigucToPSyk3Hv7X7YVgHkv7RVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=GMK7MSqRNNJITd9VKn9EN01v+V/w/ND04vZqm17dQrA=;
	b=JQbVn+jZ+RTjVW2ZwqQROTLhooNNj1bmkx5/F71rWNCy/EYBG618NqYDK78duL7UGjNc
	 m0Z15ySeXaqJd+aW+m/j9xbYkjDgIAWc6AqmRd5HKV0SCciPK8IHlDyl7h2o7PiNfW2jo
	 lgXHV5ywoqGbwvd0Pfko9B08kFiz92gOYQ49+d5R5B4/MubLcO+7EF+VvK5BjJPsrKPLe
	 H4sHEeo/95VdLnK8EO+F9Ee8/sgaOeJBIt/K0mT7wMi3nJs/lr7m8bScC9h/4oZZWFG9o
	 iPK74A7JgBrYOzipy0W5VZwSIJTAyDi/swjnGw9IKxQZt+OtVkzB8LsGuG/5V5jyyCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=CqV1uTWZ;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF49606C346
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 17:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBF49606C346
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=CqV1uTWZ
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53664b4860bso44162741cf.1
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 09:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794505211; x=1795110011; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GMK7MSqRNNJITd9VKn9EN01v+V/w/ND04vZqm17dQrA=;
        b=CqV1uTWZLD1L9NUEhI2miAOIlg2p8ADhRgdBZNi/jB7KVrktxCFGZpG8aV3NgcbXFZ
         OWgv+DZIi38KQK1QkKH/EPpymiyHVP6eSTndDzO0mDx9EIhPcaU0t2FcGvuWY14Mc7UL
         +iu0irxg40LxiWHzftdkFD4EdL7cciS3GNDvQZSBOoArB6mvY+xc4KCU7W4ARensaN3k
         o9BP3qpEgCfhrdYyRG154oTynuTKUvJTnpTfsZYLRRwgsvMJAB9avNyfMHd25Hp+C3tx
         uE6U+CLgzKTkdnjvko4rr/YkqM4vS7ZgUrm/w0Z4EUbzumidhgmrpKIdLrsMB043Ubc9
         EXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794505211; x=1795110011;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GMK7MSqRNNJITd9VKn9EN01v+V/w/ND04vZqm17dQrA=;
        b=bW4/7mJMsW8A0QOmwFuvgpJtJOq1S/73KyRnW4HRgx+zRslnI92YNBxOQRg8CqDB3I
         QO8/16LWIQrb2QS+Hsy8/Bt5aQ+nkESa8xg0Xg7g4ZGCHQec3A0g8coT+t5yaB0cKWdO
         WBeU1YI85AUHmGU1Re3hfTJZRZ5WIjjR6G1sVz3KP3Au2BwPFr0kQydIcmk8XtuCWOfa
         IRT6OIgHwn9NRQ9JiaL/B0vACGBeUJF4aZESlS52v4h7GnfixYP3aA6M5ZUhgxVs2qor
         S+0puyegStnEmSkube8VKuifcXc1YNAF1fz9aFFQRiuPDkL1MJDZxxn5pSa/KB5Pa2O+
         m3mg==
X-Forwarded-Encrypted: i=1; AL+hErFm/9DtA+6ugYePLYsUQ/G7kM3ML5cph8Y3SZWKpWB98VIZh5rfdJtoBqSGtqDF/51zHT3p+g==@lists.linux.dev
X-Gm-Message-State: APuU4Z/pyJOaW0JfV2f21Lwp5o6PKmHcZBTbgWIjyeaKXKRwzLROgf8H
	vSY0emRLx85wszFpTPTDO1N5loUrsvu2ujqe/BwARjLpTPE5b6hjUFfQ5FTxiyiT9jo=
X-Gm-Gg: AYBFou2UGZyuM/7jIjgsFzwY9AiIvLVxogxmAAi9ACoxLQo9HeRC9wCBu3IHJ90kRIC
	E4D5HIb5SOBkYtJ1suGFagFj4rPs7hdrk+cCFhjj9ly9U9c40sS7zHkaWBrPrI8xJQA1l739WiX
	7JIoEmVqVwe2OobLGOvaZ6WC7P1DjLE732ixxBhd0ai3hxUks32wpuOi9u/ZOsdnog67Vzw8biI
	kxQ59OYSJV7Btxqiu5GXLZ1mEPyXYmj/ymcN1LAZeYjiSbDk4NlGamyyn7nZSzQoDxb+7peq4I+
	sLC5g5kMHLc41y5ubol1MDdsAuMt6gLLB4MZKllf5MNcjWYcNKAdOEg+PK55ifRpYMBKp5Kp6cQ
	a5UiFcLHxU0loa7pr7RQjoLsD3UJ0MvvOR2UCUujxMa/jH0002EnBe1VRMR/GcaWUd+r544ZW+Z
	yFW4L/DjO/i3S41hXp3LafkRir9j8rkjfUEPkAVZ5stzGvzHWumLaaMg1Sl5/7d8KJTWrQ2egMo
	8vS0mCjFPru60A8MziMSnFzsX69Tdql86q9MGRqQpXL83ciG13Jp0gYtPrn13GIfB0w+Otka664
	kNZ0Iw==
X-Received: by 2002:ac8:5fcb:0:b0:533:8e6b:260e with SMTP id d75a77b69052e-55ac78597d2mr1668441cf.31.1794505210728;
        Thu, 12 Nov 2026 09:40:10 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d70489sm890336d6.21.2026.11.12.09.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:40:10 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xRYmP-0000000FjX1-1XQV;
	Thu, 12 Nov 2026 13:40:09 -0400
Date: Thu, 12 Nov 2026 13:40:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v8 06/15] iommufd/device: Hold a KVM file reference for
 the device lifetime
Message-ID: <20261112174009.GB2532299@ziepe.ca>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-7-aneesh.kumar@kernel.org>
 <CO1PR11MB4835982DE81AFE060EEE01B88C762@CO1PR11MB4835.namprd11.prod.outlook.com>
 <97053bb6-c221-4ae0-972c-603b194ec25a@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97053bb6-c221-4ae0-972c-603b194ec25a@amd.com>

On Thu, Nov 12, 2026 at 11:25:46PM +1100, Alexey Kardashevskiy wrote:
> > > Once the remaining KVM file references are released, a later ioctl on
> > > the still-open iommufd can access the stale pointer:
> > > 
> > >    iommufd_fops_ioctl()
> > >      iommufd_viommu_alloc_ioctl()
> > >        iommufd_get_device()         /* finds the surviving device ID */
> > >        get_file(idev->kvm_file)     /* accesses the freed KVM file */
> > > 
> > > Take a KVM file reference when binding the device and release it when
> > > the iommufd_device is actually destroyed. Release it before the igroup
> > > check in the destructor so that bind failure cleanup is covered too.
> > > Document the ownership in the bind API and device structure.
> > 
> > I don't think this needs to be fixed. There is already a WARN_ON()
> > in iommufd_object_destroy_user() and many bad things could
> > happen afterwards...

Yeah, it shouldn't be fixed like this.

Either we need to rethink that warn_on path for some way to actually
wait forever or we leave it.

AFAIK nothing here is going to make that warn on trigger.

> > If we really think an ioctl could take more than 60s in sane scenarios,
> 
> It is quite possible when some TSM operation involves (in)validation
> of hundreds GBs of MMIO.

That won't be under these locks though.

Jason
