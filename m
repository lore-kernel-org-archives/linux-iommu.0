Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793234053;
	b=sIMrf3AXHl9sJsilnP62q5v6lSDNo7Dhl9XW2GAbI7zBXP/BsaABlUp+/v58sso+Gi62
	 X1Wo6hY4IxrYVQqoDsP4S95IUGD8wiAhTxcghmRdCUC8frZ3zijbVtKJKkAfYAAlzkwoh
	 5kmQxe0p6PkHMWAnhWfThfLr6xfN463P54LZO5IhTco7ARL9jLTB4o6HiZpe2jJNrWkXg
	 42aycUpz9q4W7HDWTaQiGY2KeFlI++S7qx64LgsFOnS6o/70bBC8C6pMvo8SIWZUoYg4b
	 EMgqinxpl2/wYBIoXhUe++yc0oQu/zdiXdkdojCkwqay3UwBnkdnt10sZzG8nD0K8kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793234053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=tsBZ2JOSM+81yacIx7jogYyTLK+vUeLgZ6wv+MV+Ed0=;
	b=4j1BAysSVPcsB9/U2YFlpGn8qQjseOlanyo7iiONIlSk6hiDiqt5zI7T3z0LGz46/ALB
	 YnP57IWV1/qHL8f4TgqTWsbnde13h4/Q/6sfPECZAB54Ih8qJ+KDv5Pg6DWeh3tczQmDJ
	 ZeH7XVFAdVACRaFMloOdktERiStRdgy1y1oMQKMz7LDwZpProDF0VLI8MZVuODeHAzTOx
	 wnu19WphKtw6XhQBxl/PSov3XPAe0E3P2464z6oHwvBIRtWnVGvliv4mdFhRbZwosw0Jk
	 MkNrvFkzoJI9rjR5r00a21tBiHtShfUykbEbNC3GYEAbiMlr9cczlW/tbwPF2fA+yYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X3uNnArm;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50E606A31D
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 00:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A50E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X3uNnArm
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so19405ad.1
        for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 17:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793234052; x=1793838852; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tsBZ2JOSM+81yacIx7jogYyTLK+vUeLgZ6wv+MV+Ed0=;
        b=X3uNnArmi/FUQFLHN+z0s6Gj5PbxBbrOfcxbuUJVP/4I31aQjN39Uw9OsEhtzrUYPw
         7jd6cjSPxb1LOF/CzFu7SwXasHeSmpHZaYZI7FT43UI4hyyH8wSxqQ6dasbNdkG8yGTb
         xCUv1jI2Kg/vJZqNb4PGJmrEsw5IVvICEAE0SbWlRkYRsNlgBkEAVi924e9zY/QgDvL/
         qNUjde5YmKilXzMqfM2aLFQCDGwfv8qVWoUOZkejTCVHypZXylohamWGbEqC1H+tQDpa
         2iMVrFg0cRg4gZNMCw3GdFRA+9oKfewTR5lNzcU/uphOPwS9p9GAQ8khpYCwQ0DeSmst
         Q23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793234052; x=1793838852;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tsBZ2JOSM+81yacIx7jogYyTLK+vUeLgZ6wv+MV+Ed0=;
        b=fdeEH1AAukAlNkvlsieMYCs7//0M0mCPq/uMzIWbZMb9I6m+a0zfe3NP7ziDZWbH35
         z8XGnJI/j2py90yYBn4Hbjx+qgQvGUWnTRTOEZHClJnm/uWye+g2KumiqftI2nYO+KWE
         +p85VMeWKKuRLNxWGyuBQg42kEU2VVfB4A1kbl6RH5IneCKBrVeWC69brsaoOB0F9Ed/
         93NI9nvKThNR9jFqLo456oINslRT8tadw6PxX3dQGr/Mkxj17B9Fk1yFgHw8apK2jM2X
         IEKWnqTEmy8q9VJ4E96xj4t6ekYExUZ4ZhcHtlvTwjezuSPjkTg4wXsH1bxdcMFay8hd
         xv1Q==
X-Forwarded-Encrypted: i=1; AKwUvByMWaOVSPma4XDKpXsFqQUMXRv9KLJgdr72e928duAY+XztJqcqgfP6Q/i6jC/+8o17Ve9lkw==@lists.linux.dev
X-Gm-Message-State: AFq9FYK3QYeh1ItiKSjm0lR9nd2pu6mNxD0QJ38ebZT0Qh7lCsHERKYY
	VTPwDFGh6lCgjlkIUYWSiICpqwic6vaBLg2fPN0ge/Dz8VcgBN4izcsW5RdOgOXYOA==
X-Gm-Gg: AYBFou3OJAd+Pzc70bVLtBQUFbABx9ItuvaDyLzX4J6zQhrGawB4bej2CRfKLp+J5ca
	eHH/Vtg8sjxtw8HPjemfcDt3TlDYZbkClnc4a+m8w9I9Dmzu/TB0zps9snw+78olQ9NtxnvmW1O
	fhaw4X4+iv9W1yeCTLzVk5Zgq+YalX5T+IoHMuKJK3u3eiQ9EzTXZHfXTWKzw0sa50oVAnK8HrX
	Brr/p6zWX0BOM6Fx/P56yUtl1EiK9u5u85D2SU2Qgzl8LD82fXFuLBXXC45CagnuRjYdWf0n6nQ
	ComgKRNjbW9J5pZgRAyFDqX8PLR/5RDtQA+jdZDpOYxSJRG3UWnhuEQnLhAf2qIaBYHSaXfkCmF
	CGK3kf3QtqE+BcKWXaIFHHhWnQvcbYnnBrxWLabBwDr3pcHLjiBgrkOrZ63zgP5s+DSyUKLn5Fe
	fiHtYDsIKY7dWGOCxRzpIqrVGqwFE4uOlAoc/4DyDyFD1M85pvsoMi1mHQu/dj5xQDr4NP+UGr5
	sBWcuCDRz74i7/V3RY7S6DtUIIhcMDJxD3pjYiWzvIAAU2w9xPo7qMd5VZ6BIzs3OWFznCqfKOc
	k6L+jC8ysyOTaJHNSUuWLR6zfqAOos4g+OPY8tnFicfMygmHZ5sUYjuLE2UrUMOdLBE15wSvBEq
	8z/zSMgayzjG4ZAp2dg2qDVzbmeAh+JKl4LgcM+Bj2Bg=
X-Received: by 2002:a17:903:388f:b0:2c6:99be:9dd with SMTP id d9443c01a7336-2eb1b86ba8amr2826165ad.12.1793234052002;
        Wed, 28 Oct 2026 17:34:12 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdad8f2c611sm2396233a12.10.2026.10.28.17.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:34:09 -0700 (PDT)
Date: Thu, 29 Oct 2026 00:34:05 +0000
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
Subject: Re: [PATCH v6 07/18] iommu/vt-d: Clear unpreserved context entries
 during shutdown
Message-ID: <auKUZTjuwFZc_oPp@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-8-skhawaja@google.com>
 <3a31d343-68e2-4329-bd72-76a80b4edf81@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3a31d343-68e2-4329-bd72-76a80b4edf81@linux.intel.com>

On Wed, Oct 28, 2026 at 11:18:40AM +0800, Baolu Lu wrote:
>On 10/25/26 10:19, Samiullah Khawaja wrote:
>>During normal shutdown the iommu translation is disabled. Since the root
>>table is preserved during live update, it needs to be cleaned up and the
>>context entries of the unpreserved devices and root entries for the
>>unpreserved context tables need to be cleared.
>>
>>This is required because during kexec reboot and shutdown the devices do
>>not go through the release flow, so there might be stale entries in the
>>root table and context tables. Also note that new unpreserved context
>>tables for unpreserved devices might have been added after preservation,
>>so the root table entries for unpreserved context tables also need to
>>removed.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |  15 +++-
>>  drivers/iommu/intel/iommu.h      |   5 ++
>>  drivers/iommu/intel/liveupdate.c | 134 +++++++++++++++++++++++++++++++
>>  3 files changed, 152 insertions(+), 2 deletions(-)
>>

[snip]

>>+
>>  static void unpreserve_iommu_context_tables(struct intel_iommu *iommu,
>>  					    struct iommu_hw_ser *ser)
>>  {
>
>This patch looks good to me,
>
>Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks for the review,
Sami
