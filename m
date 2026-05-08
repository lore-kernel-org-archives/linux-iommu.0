Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE053E7164
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778272007; cv=none; b=NiD3Zd5l7reKCyzQ9ZPxEXtbnZdseBPd80FwdPc1SxV4C6RPnOmo24PVhHsaSQzjvom9pZurWw312sAu5sgQDdgnslF1pFjOH5BqaBK34nqRcij0jrGK9ewDet6LKaaxCOuLw7bLCcpUjBkZM3EHqEsOoVyI/GggmU+2zYSmTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778272007; c=relaxed/simple;
	bh=WlJSKH8GnQbAQDyv/X9rW3tuvBYlQ+Zvl/Deb3LwMjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzZwNaCh3vB2+jU1aPtWv6BzY9NWFVN8rDqDIXj7kKGP4zSHfWWIBJWAvGudJyxoiuIxITwEB09hZ6NwN/GvXTDLiEvTW8qBAq4Odwvwo9LcT8xTh2Ri3IUASseiJ+L+1K9SMw+ZA04Zm5mZgQcPQ8ntm4xfawbWa1gcp5oDcTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nReuIh4a; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nReuIh4a"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso1325ad.0
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 13:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778272006; x=1778876806; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ODbVXyQBYTWUs0NYAxrrYfv99hBNWpudjtexIbDyTrw=;
        b=nReuIh4afF6yAfrAI3NQd7TO5dpraTQAA5bDIqzjg1XCYzMGjV7yz2JycpPr0Hz8Gz
         Tigl2c5LbimsFvZ8ZOViKShd4haWrSoDdpDm2YXXPKV2NcQOxcLpYN5eNMgH7po+x8xr
         wWntbQ84ukc3N7+g29dV476JpcmwFznhod4Y6v49ADhh2lGojV4Uguazxgat8tWBGrUe
         PB39W3sP13Nm8Pz5O/G+4VU3MRxnzyd6KJD5SNjtvRD2PipT1ONC5fSAn23mguaIL9U7
         dDgEarmrDcCAqfNlr2NM0bpLpK60Adqq3a3LlcgeE5MXweW8J5wgUZOdO6VerKA6ZENB
         CGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778272006; x=1778876806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODbVXyQBYTWUs0NYAxrrYfv99hBNWpudjtexIbDyTrw=;
        b=GaZDvL63tf4cqQflZQm4vLCpCczCN3PcYlZQSUM9nJVXiitzNitNY3YQ90t7hMmNDk
         2D6VimaZGJn2CZF2ilpwMfZg8hlX6OG78vU7bOynwVDuSWB4gSCs7Oavd5nvBShH1gjb
         4v4d/YZnMWjsVc7dQx44Z1kIV2eNvklJu9PKuOV6fVGN0aaaZ4OFpEim2gL26SQ9j/Y1
         pgorOgsD0Ik66dkeA/K/9U+T+JV6fF2TxxGeCQo4GzGQCHgCb9UBBeaxn2T7rbWqvJFB
         jF6Y26NUis31NKkaeH04zg2Wl3hpORwHm6/MBLDYVSpYzwI2d6XIYJ43BI38v6EB2S7z
         So2A==
X-Forwarded-Encrypted: i=1; AFNElJ+L67xYydxSohDSiKbZhFkZXOK94tkLaHru7XQdcZ8QBZj8wHLmEEbx4utZyhMBYKOF4SxaqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaLtCOviT+bEGs6u8SbftS3+Z9YqngN7EvjqxDN8Xp0HRcAwAq
	pbkDYoe7k4gCIH6I1u4RzcdXJ2X0sBojv13SLyYOMY0+Wbh78KSty3zV8i/yEBS6jg==
X-Gm-Gg: Acq92OGb6EOPKBEcsHL3tV46wxyVxu9JbmiOTfVKGkfaTCfdiL5LlAZuoOawzvxxbwD
	XeGCZweoLQYbehm6CGQoG+kp8YLLz4iPjSklR9AgaismCWh7VPTIMnCq5ccHPTZr0zTnf/viAGq
	R/K0oqORvzt59MLDOYrs2ojoNZ9SNZh/1CWXE6Dk1HfxBpWykhiHTtzaT6cbC2hnjOpAqdwuyzL
	vFwzJhy/uLDL4KeVNtrwZZOo1E0mVoKN1vsN4zbjtH96Bn+l//90PpNaxxK9RATvyP7vrFRqDlc
	bWeEa/h24QqVTHNl01L59Xf7vmzn78jNsaBY/8pN8VjI0WH7aOSXQysAkYnqlt3QR+GVyvV1RER
	KNAFV+e/4Ia0oAElltiOUZ1243AFK8y2gMd0JntzwRty+kCpS2NzYh+RDBBOpzSq7dVglm3sIW3
	sEkGCBwtdLjH0oASRDLJ6OjQGPY5DHR2OyOdY8EBgfvgSDQbs1viU3rcpwL/JMkccj+gfl
X-Received: by 2002:a17:903:46c5:b0:2ba:4749:c9a2 with SMTP id d9443c01a7336-2bc746fc446mr864515ad.2.1778272005075;
        Fri, 08 May 2026 13:26:45 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367c23464ebsm680997a91.13.2026.05.08.13.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 13:26:44 -0700 (PDT)
Date: Fri, 8 May 2026 20:26:38 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Will Deacon <will@kernel.org>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 2/8] iommupt: Add struct iommupt_pending_gather
Message-ID: <af5G_j_Y4dUUc6aZ@google.com>
References: <0-v2-b5156f657dc1+25f-iommu_riscv_inv_jgg@nvidia.com>
 <2-v2-b5156f657dc1+25f-iommu_riscv_inv_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v2-b5156f657dc1+25f-iommu_riscv_inv_jgg@nvidia.com>

On Fri, May 08, 2026 at 11:53:01AM -0300, Jason Gunthorpe wrote:
> Add a struct to keep track of all the things that are pending to be
> merged into the gather. The way gather merging works, the pending
> range is checked against the current gather, and the current gather
> can be flushed before the pending things are added.
> 
> Thus, if new things have to be recorded in the gather they need to be
> kept in the pending struct until after the gather is optionally
> flushed.
> 
> The next patch adds new items to the gather and the pending struct.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
