Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB3046F4AD
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790372658; cv=none; b=NBx+3/0WaOZ7cT4ZirGp1psj5trdyQbzT3o1oC2JmxAt+fwzsor2fOMZuU2VhmTtiWTKJOIFMUDF4wW67K9UsbgnFkxT6ZOPyKH9weTvSiV2gtSTg176Lfe9z9O7GUFo5UHMfQ/WYvib52cfCnpLEue6HWb9NWrOzYkQK9mFXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790372658; c=relaxed/simple;
	bh=6U09m8Yxp85jBdyqUnyYZKTjlYcFpD66EbaC4eXzO9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTPZoZWXrLdw6JwP4WZIdUhxbVsjcy1vJ2OOeqQ8wOEnmzBghq+7w1HiEUvCQwHIKigW1D895F+2k/jg9cPDkT/Uvbtn7PFPFX44DIrgpKgGKOub0kvXiHvCZx/V/QzERl4RWOeQIB6tIyGpWqRuK/l1l4slSLozaH+Nt/a3eIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zm3yXQEm; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zm3yXQEm"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0abca97c0so775713a91.1
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 14:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790372656; x=1790977456; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IIMvCRPk4oQabUuNoTzd+hbJerQBs659OSj7AsZRTXU=;
        b=Zm3yXQEm+bZ13ZnfDZ9Uy3tlpBaiYY5Lzb0W6prJF2lVXrUmNc7wnJRYwpgZC+yy0C
         ZZuBBs5KCOEFX3/KE903sT5X1lAp73wSfqZejs9khDL9lEkYggvQpcjaBbKwxWbmwsbd
         q+S14YS7JmIuMsUhh4mLrwSVzfRhbeWO4XyPeIVyC5PlHTes3cHdCQ8rKYtUxjdhbUkV
         QhRnSuikfnfsrBgZO/hfR6Exd8yzns5LKe9bKYvZ4tdCeTN7myAjQbvOpPxXtgqJlbPD
         8AxUTL2WT8dwVt9SpdWQBiuF5eXm0ORLQtdEX58+kt02IHkmNSU/2qibXDILom7dEsqq
         A1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790372656; x=1790977456;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IIMvCRPk4oQabUuNoTzd+hbJerQBs659OSj7AsZRTXU=;
        b=DoVOQadYATVeuHmOL66+3DDPilv0X2citKThK0nmRvolazt7m8NOZENnIut2i9VToW
         HK/tP7B3mEN36LYMvYkpEV6nlZF2VHgsk6Jc3BXTKJeDrDhhlFiwIKnpPNWObf0QQf1E
         qLjgqqI1ZPFUDP1qE2MmtYYmj1bwUvlbwL0lf1gbsFs0a0VNn9qwsy3EQcg9ij4sCs+3
         Ajb1X3ZKUgpvFkwsgE5ul/85AZGovhd5ZmIktZ+yawLALf7YXWdO15Psge8FomSEdgrF
         GKQT1hOoObGuGaPzB4OhkZM7LdhHuT5+jU8XdcHfK+BwvEuKRGrXsvjgM3s8i8Sz+c4D
         7aSQ==
X-Forwarded-Encrypted: i=1; AKwUvByPPr5Xr1goQPJ6PmMQsGkDlN/UwbLIQTu0xOPECC8kvP+UtZv3aotbYS9LgSW5ucWM2DrmHg==@lists.linux.dev
X-Gm-Message-State: AFuF++kA4ofm/CM48nPJt66z5JnYqiF6+3ulSRbzBwO5QarHWpEBucqM
	wk777SnXvNNF3g9PF9YyRm053+IRWjpUtZ3lIROyqM4cOfc9ZXoRdJblMp3PO9Iqbw==
X-Gm-Gg: AYBFou3j7pZ3Gzau1gygi4M1Jp7sz4LW2iDCD3m4UZ2bH8KGCaFy8YEvtmlmEJ6vOWC
	7St+A7RTxX+3ooHPBf1Dn/kdt5B3lCATmro+MFhaTrhYGqum38/JLUD0GI40SivoerF0XjoNj1+
	O/z4iWiBbib4TuvZjH3Ka6TQsRoaJVTal4D/a8RQx8Joc8mo93gN4EFuMjtTi3v3i/bQFgD+YIT
	9IpjRKds3pvIGR64aW+SvkvOfDfA0jRoAgWuwE8NVAWfCV6cIse1sTZG2VXdOcFBkTjbtnpnXVc
	XRUaCwNkFG0WAwO4FW6yMunA+KPIx7K2fSYEPrmZRLwzB5kENIy2v/fDxR+Bl5Qq+gHJfP2R5bi
	Xr2WR7Mj1WpgmNFwukPwmUtxKGl68q9jl4YHG28qb2qZjkG8oR1b3xZ6v+OrjW9ZqhaECPf481S
	ZpycKy7o0idiP11Jrjg5PE93L+H+nXa3SVNr89VzzohP07b4yo8C1Vs+YFlT1pLHw1Tim9Jvzet
	4F4xa/qzbbiDJEcytriyYi475TUdoCC8EZMpiY7
X-Received: by 2002:a17:903:184c:b0:2df:3b0c:a6a5 with SMTP id d9443c01a7336-2df7da5d1bemr63157015ad.9.1790372655435;
        Fri, 25 Sep 2026 14:44:15 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91476bb4sm16242765ad.83.2026.09.25.14.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:44:14 -0700 (PDT)
Date: Fri, 25 Sep 2026 21:44:05 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [RFC PATCH 0/3] iommu/arm-smmu-v3: Add support for hitless
 replace of CD entries
Message-ID: <arbrJYsILS1IPpCK@google.com>
References: <20260925011308.3381953-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925011308.3381953-1-skhawaja@google.com>

On 2026-09-25 01:13 AM, Samiullah Khawaja wrote:
> This patch series adds support for replacing IOMMU domains with S1 page
> tables hitlessly, that is without disrupting the ongoing DMAs. This is
> one of the dependencies of the Liveupdate IOMMU support for Arm SMMUv3.
> 
> S1 domains are programmed by CD entries in the CD table. During a new
> domain attach these are updated using arm_smmu_write_cd_entry(). Since
> ASID and TTB0 are in different 64-bit words, arm_smmu_write_cd_entry()
> considers it a non-hitless update and sets V=0. This means such an
> update is disruptive and would generate translation faults if there are
> ongoing DMAs.
> 
> Replace the CD entries by using an unused temporary ASID in the
> following sequence to allow hitless replacement of CD entry,
> 
> - Update the CD entry with temporary ASID.
> - Update the CD entry with the target TTB0.
> - Invalidate the temporary ASID.
> - Update the CD entry with target ASID.
> - Invalidate and release the temporary ASID.
> 
> The series adds a vfio selftest that triggers a continuous DMA and does
> the hwpt replace while the DMA is ongoing. Since domain replacement is a
> race with the translation requests, the test does it multiple times to
> capture the small window where IOMMU faults can occur.
> 
> Without this change we can observe the SMMU faults in the kernel logs
> and with it the SMMU faults do not occur.
> 
> This is only tested on qemu with the emulated SMMUv3 and an out of tree
> NVMe vfio selftest driver, not on real hardware. Following are not
> covered and can be done later,

Out of curiousity, does the in-tree VFIO selftests driver for IGB not
work for this testing scenario?
