Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D227A907
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 01:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792114445; cv=none; b=P0+3FUwmDXVFL2TkE/N9tZwiOnn29S61c+LvJBeDdENPrC2JVA+Qh820uFMDcjer9N0DOQTmldgpkGO9zetBv6sFyuN9wnW8cZKxVaVnf19BbtpU1hL4l11yWn4QFlUACd7nan1XgHPMoevwr5j7Jv0W5EjClO6z61W1Y22ZycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792114445; c=relaxed/simple;
	bh=nLgPiYbSq45fhcCwaebsJ2SjYmzyaWlhxU4COKBBfmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyC4xzRvD1gxVzjv3Dx+n+FepMBLyPjRjiGE/3P3bODvnAd37M07TBVjN3Zrxex0dmp+v0703Fn9rz3Qc0vcb0FlPqQuzD6ZFGJkW7Z4p6Ocdt1454oYF+TNLOgj6DjeTPH/WcO2eMeT8iqfNYyloG/b+v9pTEgfYgBToVJ1mao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ksLJOq/a; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ksLJOq/a"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8623790f8so27935ad.0
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 18:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792114443; x=1792719243; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sdPpN9Xqdtkh9zsXDM/jJFMTNd+EOKXTasm7UxE7C4k=;
        b=ksLJOq/a85igf03T3u9oirfpcqwqtDaTenXkqSFC+LSSpmyLanRmV5+6npCFZMJett
         jlKDB50bk9NzMDJeyDVMpnB9S1einyCUuX2jQ/JTwH9oC0CYN2X6kPmRB7DvItTw9rbu
         A1rePEksFIz5UWHXvE/1/mQrwIVynkL3M8vZfFZKXulYutodtOCCmATxdUBhtoA6HN5a
         vk6mKWlwr4aXjzF1itrPl9b15CT1k0TCBdqVq4fHdzoatVRBL5GRPJFK2ipLmHN9UlrM
         JYyo1lcpD3T031p2clCp7QNKIJxpH++2RtB+aObt5e7z2kg3QLZhL+ITXrk6ioe8tQWh
         iVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792114443; x=1792719243;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sdPpN9Xqdtkh9zsXDM/jJFMTNd+EOKXTasm7UxE7C4k=;
        b=T/XSZtf0cZDqvUoznIhRgBzWPE1aSRjarD11OLn26IwPew9jEldsRv53SnefgGBnvq
         Qr9GKIkC+gn0pZ1BUJ0mD92Aj87BB+e6zujaaeP12nkjNqW02bJ/NlXRE9Q/sd4K93gW
         paLYdgLpDAY/QraPTwN95JOI3gNzvQvv11sggn/g8IjBhXlmU2zpQcBIJgOsmT4UFN3a
         FtZ/U9TBsHTSewx7DXiQ6IhlpGeckZ6qrkBAPV+ZI9FG9pMP4hcFk5pymaVEdNfrCJaE
         mOSG3gRYOwKe4DgPvUXeaD7k7APHf+ltjYePGrUZa3Yv7526aJtYKuR0JlGQgBS6B4ub
         auHg==
X-Gm-Message-State: AFq9FYKKBX4OIqWJ6ULeaOzv5DUCDh5JqI9Q/nmOAbvvw6t2joQlZxCc
	wVGz0pysb7DLExXZYwIFY50s1zN5RYRftRmXz/wWXmzJU1vx9as/JMQ4K6qLC04DA6rnKboNAv5
	565raPw==
X-Gm-Gg: AYBFou3qjBCC/cC1usbHUA89XWWoBB352Y0dETC1pnGNz3x2oDNe1+73g+15JhPwLlS
	V5SCGLf35Ow51SMIaAfJo7gQ10nkrIli/9WyDZVdcIqHQ7W8pBAIj5iNH8mKRXTZ1Esw9QFyrAH
	M5BYOMr35/tP9V63egTUCj/EillKv/hXrjMQ+6yl3x96J1ARV77dJ0iqKtp3APivSVxY6wGPmMf
	z66WQroymgtKPTY5zaZM1IbQ2muee5rIt74s5VR0QpOSXl5sMIl75xPnSzDP1vdXobtwYKb69c/
	COYH657wgHdF0KMXRw3PQP3Hy5iC85TCpa7QbtJY55i1Q7AH+T9qJuYkwrMlD0oh6D2pvyfGYzH
	kBpRdKsZRfCNOp1OrPS+etsx6nnG1ytlQOxrZLzd0jU35JO9OfAsrxFvSqg7dAm5+64yE8XKRiW
	AmhJDDrg6VBLdoPgFWZsN/WIg80cvp4Q7zDvAnGMu1VMZmVrtbiJVp4n/TH4MsMDUygc8rQ0kaF
	eLCxcFc1ouiT+A7KoDa41JroK50RDrUu9iWQqFN3lNSdID2xYN2RSbtSd6kyHJ4Evg=
X-Received: by 2002:a17:902:ecc3:b0:2e6:1013:ad57 with SMTP id d9443c01a7336-2e9821d5bafmr1820355ad.12.1792114442559;
        Thu, 15 Oct 2026 18:34:02 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd05c9255sm407564a91.2.2026.10.15.18.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 18:34:01 -0700 (PDT)
Date: Fri, 16 Oct 2026 01:33:55 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	linux-kselftest@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Joerg Roedel <joerg.roedel@amd.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	patches@lists.linux.dev, Samarth Narang <samarth.colleges@gmail.com>
Subject: Re: [PATCH] iommupt: Do not allow PTEs to be split when dirty logging
Message-ID: <atF8QSyk2TK7wlvH@google.com>
References: <0-v1-5bb926ff73ec+576-iommufd_dirty_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0-v1-5bb926ff73ec+576-iommufd_dirty_jgg@nvidia.com>

On Thu, Oct 15, 2026 at 02:20:10PM -0300, Jason Gunthorpe wrote:
>If a single PTE cannot be stored in the current bitmap that should be a
>failure and reported back to userspace. Allowing a PTE to be split creates
>a possibility that dirty memory will be reported as clean.
>
>The gather must also cover the entire PTE that is being cleaned, not just
>the part that fits within the bitmap.
>
>Fix both issues by computing the full IOVA range of every PTE and using
>that to update the bitmap and the gather. The bitmap code now rejects
>ranges that don't fit in it, and the gather always combined ranges.
>
>The selftest quietly relied on a bug where the CONT was split, that is why
>the half page size for the mock domain saw alternating dirties. Increase
>the dirty test page size to PAGE_SIZE so it still works as intended.
>
>Cc: stable@vger.kernel.org
>Fixes: 4a00f9434891 ("iommupt: Add read_and_clear_dirty op")
>Reported-by: Samarth Narang <samarth.colleges@gmail.com>
>Closes: https://lore.kernel.org/all/20261013165814.309255
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>---
> drivers/iommu/generic_pt/iommu_pt.h     | 30 +++++++------------------
> tools/testing/selftests/iommu/iommufd.c | 10 ++++-----
> 2 files changed, 13 insertions(+), 27 deletions(-)
>
>This relies on other changes in the iommufd tree so I will take it
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
