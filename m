Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A6A24DFF3
	for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949587; cv=none; b=EM38XGe343E3NSPNsMoh7Ch9smrNaP6OU2scgPO0NOd2QlVeUYo46qX9MpXmHaJjdOF3BnsZYU65XKUzOu7jf6Xypv4yYbThs7K8RCxQEtJR+k38VJbNM/eNLbo6GLm/4tV2nmAq5iZRRvc2njNwKwZJgNY4KPN1e5ICkzGw7TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949587; c=relaxed/simple;
	bh=d16RAGrhUAPMnh/Fm7KTz/flsdV6DTvv/njmBuuJRZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxZT08xsaXnzTkiC+za7US2cGBOhSA/KefyM5mNmV2le21oiN50lRJB58nuGld3OEtCmhmb44ibsnhgA78hmzFFEGmvdcQShdt9k5rqNpFOefBNlWRAQd4qWQpSugCX2ZOBj8wQVUxCziT7V/UtIYru69tbyRSc/j2OcF0xfNiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g2y4ho54; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g2y4ho54"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2264c9d0295so198415ad.0
        for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 10:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745949583; x=1746554383; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZWx5YzsE6VtBscW7jSSrryOsxFdJT63HSkZNADS7Hs=;
        b=g2y4ho54hoaxBj8xsvS/5unzx1G58LIapGu1rpet1Mhq/JE41Ajhb9H4Jt8kCA0t6g
         qFBXcP5LdgaQDGFB+lNRXQfdbAyTF/fWQn4UuHq1xNNC0w58tmZVMPZvlYXEKzrcxHxQ
         lg7rCtbR4XY5l0cn1/P3DcO+YWN1PSs37FFqAAxpinAhEwq3j5+sSL7lDXPVLPXhzYSA
         z7FUxDVyO9HUMUJS6TpXAB7StC2oGL9IFOUBoTOQ3YaG+w+PtE7Qnu9mho7/NtoRM4F5
         CIurcAZwURlXZdpd61ivua7NmcBmQYMJeAhUM6xfxUryCVev05NnTlmgrXxKQFgHABVy
         iloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745949583; x=1746554383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZWx5YzsE6VtBscW7jSSrryOsxFdJT63HSkZNADS7Hs=;
        b=OuDbPpZcDJ8MYNvXH2sEGNyL+v8D42x3bkaQE9V73udnS1Pud0B8twl8GOMuzX7Yd0
         c/pFDbXxzGzXRq0fBxJMlWU4H1IITQzgtcMli8fnYuj0ZnJtT0Mey6JBNsUfK+1OV5md
         iZ9PXXiU9aEcOwAul75aN3rpDM/Trp1fai/8tZT/irJFDXT1SuTLy46VRG+s9zJm/+dz
         xHWJTFO27AxxphQccehPJ+P7G3qRut8xtvyvZwvsZzBaKVqmqKIrzkUcjcAy61SIfYz9
         ibMI0yFLwZn9UiqTwHXI4VcxMifBKJ+Qlib5yRm9vMcapaFTWcTR2D02cggvmjawELqO
         1T6g==
X-Forwarded-Encrypted: i=1; AJvYcCVc+4QG9woc7dP307pyrJbPN3NuTyqEGVaam8nxvTTIE7SACLHvV48WgPZvgqQvRoqrwYpAew==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0oSd9xvSwL4wZGiYECv4QOx9ExIgecbxD8uGq0XQQUmHEY8Bw
	p55qMLgsxPUCZeo01gDn0s7tTG6YKykJN1jarOxpUbCBumskqv8RPSZfTiPDWw==
X-Gm-Gg: ASbGncu9XZ25w+Hr1TaoWkaaYZfrcDVUCsiIE+X1mSB+jfS1IreYz4zC6sEAn5nwbja
	FgYEedaI2F+5/zVFvDTHf138myKSfTmJ7T1oJktpRxLd+gLHPlMJcR+EY+C3diN+5pzQkU8NrLs
	0T2d4KY0L1csn7vPSjYiKIFqzvK3i8ZgyL0y8HSkmFWB7eUkIpxD76sMGYn2Q5peco60peQ2PWU
	N6uC9mGQFYUswVOS/0XcRMOXq2PKENMDX2vhlkaxuZ9EpsUT1rLPuGT3W46bHF6W8xIKbcPlOdN
	ndYvxKkF8rPmH4oyNvWxJ5S5uH69yb+oHzhmyOfRwp598xDSd+/N6AAqBKwVULB5rN90Pe8r
X-Google-Smtp-Source: AGHT+IFpQWcmyzP1N/TbZRNb1gatjkwbbsmgC09afTOnO3GyWImnhX2qlaIfI4JGDZZ0CTRg72ZS0g==
X-Received: by 2002:a17:903:2303:b0:215:f0c6:4dbf with SMTP id d9443c01a7336-22df3fe491emr117295ad.14.1745949583190;
        Tue, 29 Apr 2025 10:59:43 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db510272csm105625315ad.177.2025.04.29.10.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 10:59:42 -0700 (PDT)
Date: Tue, 29 Apr 2025 17:59:32 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 11/22] iommufd: Add for-driver helpers
 iommufd_vcmdq_depend/undepend()
Message-ID: <aBEThP2Bn0YDgXfu@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <a25c9454c17663f9e79b37bc2908bf3a99856be6.1745646960.git.nicolinc@nvidia.com>
 <aBDIpz7w8wxIn_AF@google.com>
 <aBEIBKdjuecVHgpU@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBEIBKdjuecVHgpU@Asurada-Nvidia>

On Tue, Apr 29, 2025 at 10:10:28AM -0700, Nicolin Chen wrote:
> On Tue, Apr 29, 2025 at 12:40:07PM +0000, Pranjal Shrivastava wrote:
> > On Fri, Apr 25, 2025 at 10:58:06PM -0700, Nicolin Chen wrote:
> > >  /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
> > >  struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
> > >  				       unsigned long vdev_id)
> > 
> > If I'm getting this right, I think we are setting up dependencies like:
> > vcmdq[2] -> vcmdq[1] -> vcmdq[0] based on refcounts of each object,
> > which ensures that the unmaps happen in descending order..
> 
> Yes.
> 
> > If that's right, Is it fair to have iommufd_vcmdq_depend/undepend in the
> > core code itself? Since it's a driver-level limitation, I think we
> > should just have iommufd_object_depend/undepend in the core code and the
> > iommufd_vcmdq_depend/undepend can move into the CMDQV driver?
> 
> The moment we added iommufd_object_depend/undepend, we already had
> a blur boundary here since we had no choice to handle in the driver
> but to ask core for help.
> 
> The iommufd_vcmdq_depend/undepend is just a pair of macros to help
> validating the structure inputs that are core defined. It is quite
> fair to put next to the raw functions. I also had the notes on top
> of the raw functions suggesting callers to use the macros instead.
> 

Well, yes.. in that case let's call the macros something else? The
current names suggest that the macros only setup dependencies for vcmdq
and not any "two sibling structures created by one of the allocators
above" as mentioned by the note. Maybe we could rename the macro to
something like: `iommufd_container_obj_depend`?

With this nit,
Reviewed-by: Pranjal Shrivastava <praan@google.com>

> Thanks
> Nicolin

Thanks,
Praan
