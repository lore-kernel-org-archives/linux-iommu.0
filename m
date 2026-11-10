Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271982;
	b=AOG56D2gRRv6N0+EsNi3322RuJoC8kSZeT0s6QfZocsUOsqYH01rziwlEARxv7BG8S44
	 jAKTdBj9FgzUaCvQSiTMIym9gJopR1xmmMQCwUQ2QP4zoFoU8TXFp5wqtHP+hgrcjxejf
	 ZMurpt9MNVGn5cSdyGj6gQDHPNRd9DoQ0XJfZcpv8or3M7ye/oQcOX54v/LCFO5tdwCwE
	 FxIr6cDTbyRe8P9o2V7pcd0NRZHeR6WP7U9lrnTWurr9KPGNf2+TuzGTCHxLWt4FfE+Qs
	 AMdvSOW88jAjZR1n2ywN+By68psKUwQLg6pxrBZYPOmHheyhdiVk9Jxl7gjjhh73NtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JyWOo/pOtk62GRS0TgSKLCUeZbYObiIcnLDqhYuX4P0=;
	b=esVESzAemPGuZJXy+5eHy8PSRyooAfDj1AsXwLweUmoSxoBXIyTr4yxJoNrDeXLnfeJS
	 IJ1iQeAO34JKq74idjuXNZHDRrUHg4wQDokxd7M33VailVKYRMRSUckfDyWDj7UbILK+w
	 1Pqf2RnhlIOJK+3BwRtt/y9VoiL49msrkaYD/JRmBEUwOPUDsp9vcfNMBeuscUrUJemx6
	 6wU4i3pi+kbNzNUp+0qY9hc8kgG/BDj0+8QJUP3/k84Jo6qgis9E67tDyAx3cI+ONrQuN
	 kR5CKLd4k08ypwOX6A1kZtx4q2DnIzv6XJojn4wTYJvrCfpWvxWpxbqRHojYFsvpiEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nzkuQVKN;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5646606A31C
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 00:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5646606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nzkuQVKN
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91ea2e29d90so15602076d6.1
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 16:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794271981; x=1794876781; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JyWOo/pOtk62GRS0TgSKLCUeZbYObiIcnLDqhYuX4P0=;
        b=nzkuQVKNL+DhJ0/AflveVHpR/Phws64raXyBammC92LKi43vsJ7FFdWDtxHow+26U/
         tp8nlHxBF/U0/Q/0VYZz8G5hKcS1xTBPqKVv+6VfnmnwzNVGUBB8/kieYMYWL4wnk9tO
         mUtBZbdJ8o1Kv9txKE4QipQ6Tskn3+dG+lDWEmrF/x9TZjoiHjHAyL2x23uS0Fdz38N8
         q+hDU0fYJ/mWxaaU1KJKZFg6ZimvHYSqcvtvglY3DPJdDgv/9vkmeozCLM0JLQEiSVbc
         g5nBa75hx3GpASU0OeUW0vWi4DhxLAL7vjJx2sD3io8Bo1JQv3YOAv/SsgNUllCwLJDR
         Hk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794271981; x=1794876781;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JyWOo/pOtk62GRS0TgSKLCUeZbYObiIcnLDqhYuX4P0=;
        b=TsNT7Q/I0TQFwWmgW0woLBp5BKMN785y0S9tbcRG/7+CqgcGjCtjCI3oLtEYmvnvWE
         fov4hOhX7fOGY57pImrAQ2e86DP65KGqer5CP8+E8asr4dfgfHHFUsqqmDXxexUqeYp7
         E1iEG9A6xm1kW9n6cRTTRySHZkoxBUWNV6AHHyxDjEYFgOw9tBmslQa+lYv9iMDEB38x
         thPaNT1H3qYbnjemGEAEo6Y9c8Q5N4jr5Fu4poUDRBXXDiUbJJ0no8JW8GtofcDIev3p
         P49q5bQGpXj1ml6QZrQ0fkjJB5nxFCDpxeT7FewWQO0gMV7q4fvgKFGvs/C7JmMOEHIL
         I1Zg==
X-Forwarded-Encrypted: i=1; AL+hErEYvztHsnz4LpJF5P514D+Gd3yt8q9nPMm6uUtND8QTY16KK1qK6iC03W7T09+vxeE8uQC8/g==@lists.linux.dev
X-Gm-Message-State: APuU4Z+R1Cc1zodrkqA/9g1jkZSSV53nTfDhwQRbRr7XsSq4xiPkEEra
	4wyH85BwpxFu6lMKoNY8dIK5stzWZhC0ElW+uMTVQr68NMrHR3vEWT2k4UWloW1Sxzc=
X-Gm-Gg: AYBFou0CskxlppNR2/wjMuyxAwUWvhOzDrYV7Q+8di+HTIU9IKv2NexQuEOiXdXpkKl
	lHYiB+RrVx7u0av9IQ7vPmetIWYY2VZhZcLPSTfSQJlvYZVniNH5ptf2rbdcFavoZp9A/o9iXUE
	v2JcSxCSwjSRF28snomhgbC+U+Dj5MscgxipwP4q/tPoxRXsJvWOUvWjqJBWBCcCEGJLnazJeiP
	SQwSduU+Iw1US0oTDB1aKcKHprsOP4RsLQETwlSKVKcr2T/hCSMhKTd+sMeGVZuLIXKXc65MpPp
	yAQwDxC4Wpr6qQ/uAr4zlcyiaiim2nX6IkwZmIgkA2WG1orjfn5JUPuFsY+ZOYTi+prdyNZlXQT
	iMwq0hHIbUiYpSXEMu02GOH+z+ORud3rVK6o7akgA25M6RrWl4tdAPN0BIAKmc1r8wqqNGUp5N2
	dHfaSwI0/2R38pYQ05xWdWyUkCsR1wDgSzKg+SBfRKb+gdfI+BB8eHeYhoYbBsSRT0s5IpV119m
	tkiKY7fT6t/mf27G8AeV5SFt5xDt6CTZGyUVbQKiNWTJLl9Q9L/oAOcv+76TsVB4oIY02MuQqWA
	NJddWsFZsQL139GvhI6JCd8VP8nFuaswIphd3mHUfWTVWeEA+EazBD9ICbkmH6YPygNewBWDfLr
	O7CL4IVdnuw==
X-Received: by 2002:a05:6214:411e:b0:91e:972b:ad99 with SMTP id 6a1803df08f44-91ef027a678mr17759746d6.25.1794271980522;
        Mon, 09 Nov 2026 16:53:00 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef0543c8esm8667106d6.40.2026.11.09.16.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:52:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQa6d-00000003NZr-1IKz;
	Mon, 09 Nov 2026 20:52:59 -0400
Date: Mon, 9 Nov 2026 20:52:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Wei Liu <wei.liu@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mukesh Rathor <mukeshrathor@microsoft.com>,
	John Starks <John.Starks@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH RFC 1/9] iommu: Introduce external attach domain type
Message-ID: <20261110005259.GU663069@ziepe.ca>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
 <atiakDqtuED2cTM5@google.com>
 <20261026161003.00003b71@linux.microsoft.com>
 <ausIn5Txiy1uRjkY@google.com>
 <20261104170816.GS3889730@ziepe.ca>
 <20261106130352.0000638d@linux.microsoft.com>
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
In-Reply-To: <20261106130352.0000638d@linux.microsoft.com>

On Fri, Nov 06, 2026 at 01:03:52PM -0800, Jacob Pan wrote:
> I am not stating that it will break UAPI because of blocking domain is
> used. What I am trying to say is that with the blocking domain ->
> external transition, we do not need a new UAPI for external attach for
> non-CC. It will just reuse the existing UAPI.
> VMM:
> 	do_ioctl(vfio_cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach,
> 			"VFIO_DEVICE_ATTACH_IOMMUFD_PT");
> hv-iommu-root: external_domain.attach_dev() will do the hypercall.

You've basically described a wonky NESTING domain.

I think you should just use nested domains for this. Even though there
is no S2 make it possible to create a nested domain through the
viommu..

If hyperv ever learns to support VIOMMU you will need this anyhow to
pass vSTE/vDTE/etc to hyperv.

For now the nesting domain creation can just accept an empty struct or
something which means identity?

Jason
