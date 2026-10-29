Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793234014;
	b=ctMEZul0A3szZ+AASHCuRTe1KlKNLPorI4mo131P+u4wDgdr08MHGFzAjlrbNhkdhScc
	 0YSLMI/IDqq8QFsFp062t+D5G7vQMFmHt8EkNnQI85pHsu1UaGo6Pf+Fll12qvCpnoBXg
	 5+xfal4yEw7/Zk3psNi77uz69YrFACoR4TFEBLtDXeio9vdGqzq04MuxuZ19Xe7yGpU3D
	 D6G50h3xF+tkGDfm7ROCg4c8XhEXEZRgccvDJ+AviGDiG39G83dfvhaMNZdOtBe7p/ojQ
	 KmbtdP8ikdO+8MnfauWMaNUKApS3IbvmO3e+RZmtqbBRB8x4KaZrAIkmeI8LVTcv7Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793234014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=O9QpSR8lg+vF2or6LsznjkiIHbPGjItpop+9ep+sVOA=;
	b=MDoOdVS8/j0F1LhRffE6zyEZgnGIlKtJqrYV+Mc+3hhWpzkcBLqVNT2Rhrxnw90kTs1R
	 uUZQ9xJrCCr1udlmCTQzU9lVwM3Fc7rwXgQRRs9R3OASS7QR0kY7B+7o5ST/6vNERp3kT
	 XqvvMjXZVK2/1PXqu0y3HRdDoupRcsA+6M2fd2ye9VZrJPVTaJ5HCR7GYBUSDAFN/Csuu
	 y5DZWAJRQjFFgE2lF5PTjyvGGaSODwbxq8ERagZl6qmjNkU52ztj7nxDX69Akj2MA525W
	 QV3V4cmY29B7UTEKTpTlRBV/BcofcKT05gujtTcImQAbYodCh+G0srw8dh9tvlhvvUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=izUwLD4G;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D2D606A31A
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 00:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24D2D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=izUwLD4G
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so19225ad.1
        for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 17:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793234013; x=1793838813; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O9QpSR8lg+vF2or6LsznjkiIHbPGjItpop+9ep+sVOA=;
        b=izUwLD4GbB2OGIO/pFgjTjcdHxAJWYH3OOMQJdQu6PPaHjWYZ99r+k7LtF783A25BJ
         SBmb11vtVbt34sI/9BEzoPYHKxCtkz+TAE4PQP3bQgkQ/OBSsMYtd00mcSgnNX6QfiOU
         cfQmACHwH6DyWMZXWNes6u++XQo9r9uqfnnvP1E5MkGhk7Abbg8oSGPDGIBV5u2UWXc+
         4pyQJMeVs+UhTQXJEi0yIzbcAq/ur03yXSlwcOXtUCJUzNWmZPos3O1c8kNJzD1iQRHe
         7YRin5km+3IVtQ9C2055liaAV4BNw3MW4zXxDXrGOkKwjXkeg+E0qm93Vm5LNv3hLpBI
         0trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793234013; x=1793838813;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O9QpSR8lg+vF2or6LsznjkiIHbPGjItpop+9ep+sVOA=;
        b=fClCr0NlD/YaafWq5EqxalWrt3VUQMuBkobrGaz0Iv213OVQQW+2coVTVNBUrCZydz
         VhXR2OJsUxxycYgBN5dauj/gLwzLGINgS7qHArxbJw0PvKEAvjPqXYAkpWYcst41bI8a
         WRf15/x6o9aTFLKVC8fXDpPLY4c2YO4tXShg7ydqLo81wFzauhucY3EGnH+upUUgYp0v
         ds/crGZNeP1DWzRJ5r/C5TmSmy9VoOE3+9Qif32RY/b87ruUKBiQ27A0IYT0j34MhFHC
         80o0rXNUZMvXpwH5Xiq5KMZD/la/mLTa+i4hAeLwEojBgeEFI5/LEppe9XAiHd5J6Yoj
         XQAw==
X-Forwarded-Encrypted: i=1; AKwUvBxOoelHBXbAQkVfefheF47UQx1IfGH0mS2cDNuMEeMe0LnExYooT6i6uFc5TXio+UTsloyvIw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLtmc0a1+Wy6xh/IdFNp7BMU67M/YCHZLuLRWXvSwSmZru7JqRz
	FCNuC/XQohlxCXbZ8A3SlcB8ioUdOKmOwUxByOfRUcwl7EU7Q5OJVkPEyc9hZN4wIg==
X-Gm-Gg: AYBFou1tZVaoUPXEZKEi1P9DbLkczT08boUTbHN1M4DHnBYT9EBwed1NZaX6c/HwVAi
	2WSvcY5VgLl1u7cb44jHs1gvQ+Cefx5WosIYQVh0uTuUFIVlZXxnM70RPMVcm+TTdg/rDlcK13I
	wvLEf21uHOPxXjzLUtd3aqt8JUDpAaqWD9k+GIiGz1bs9+6il/6T54Du8gZB3K1+cBP4BkiHXk0
	2MFWT1WvI8NBnCvT7ol1VDk9aZr+6lP+wVhwDZBkYMqb6IN2cqsqiDd29rB8koCbtnd/8JndF6M
	EFRdfEx3RpG+Uexv7Q2bdhPOz8OjjDB657pMeTVDvyHk2LRgaA7lhAhxwycNtMVzKdE196ZFttJ
	wNOj/mu+gNIJ+DqtSsI1krQn1g0PX1LCVJqrhizyAoGj10ei1dCpRolqZoWkQimKtYFyBycweRB
	5Lc5Tav4JWGfvF9Vp/BP/fq4ingnPyYgg4VLJAAVMSGelQDZUkZqH51p3oFbbbRlla+F3rX4MSB
	WRng/SH1woGlXP+28QqpHgVrSC8gaS63qwUF9+hg5PwD9pO/E9VbIAafKLH0HA0wyTk6fO5JWjV
	WDNad6mpAu76VKEufSV3smYROzdOYd09fqpj5z5Ry+arqp8Tyxt/PfOrTiS4jTTUlB3ZCh/HOAp
	4Cc5vopRyTBGwp6eWTY4BCg==
X-Received: by 2002:a17:903:2301:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2eb1ec33fe0mr1312655ad.2.1793234012878;
        Wed, 28 Oct 2026 17:33:32 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5795d04asm2769044a91.2.2026.10.28.17.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:33:32 -0700 (PDT)
Date: Thu, 29 Oct 2026 00:33:28 +0000
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
Subject: Re: [PATCH v6 09/18] iommu/vt-d: Combine disable_dmar_iommu() and
 free_dmar_iommu()
Message-ID: <auKULvZVjkrAmzIB@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-10-skhawaja@google.com>
 <9e0c1aee-5a4c-4e93-ab26-f7e59b268f2d@linux.intel.com>
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
In-Reply-To: <9e0c1aee-5a4c-4e93-ab26-f7e59b268f2d@linux.intel.com>

On Wed, Oct 28, 2026 at 02:01:08PM +0800, Baolu Lu wrote:
>On 10/25/26 10:19, Samiullah Khawaja wrote:
>>Every caller of disable_dmar_iommu() immediately follows it with a call
>>to free_dmar_iommu(). Combine the two helpers into release_dmar_iommu()
>>and simplify the teardown and error paths in init_dmars(),
>>intel_iommu_add(), and dmar_iommu_hotplug().
>>
>>Also drop the early return when
>>WARN_ON(!ida_is_empty(&iommu->domain_ida)) triggers so translation is
>>still disabled before freeing the IOMMU resources.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c | 30 ++++++++++--------------------
>>  1 file changed, 10 insertions(+), 20 deletions(-)
>>

[snip]

>>@@ -2310,12 +2302,10 @@ int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
>>  	if (iommu == NULL)
>>  		return -EINVAL;
>>-	if (insert) {
>>+	if (insert)
>>  		ret = intel_iommu_add(dmaru);
>>-	} else {
>>-		disable_dmar_iommu(iommu);
>>-		free_dmar_iommu(iommu);
>>-	}
>>+	else
>>+		release_dmar_iommu(iommu);
>>  	return ret;
>>  }
>
>Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
Sami
