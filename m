Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3D341D20C
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747451; cv=none; b=dV3mOwbk6gCw2MPeRW/9axjrRHjEvExrpcr2YLDpC3tRS0/Zz4FiK2djUeacAgrNZSOHHeTsO2QHaTxCWcRpA3V0QYzp8+zNzkmWJfT/KfFrn7zfSVqMV0KQjiJWTvpMIM0rTVjfiQwhb7DLkDzUnApol5Tj06pEm85wlkx9vE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747451; c=relaxed/simple;
	bh=8dVVSO4XdHCx4KOZSduD/f39KYIfwpqzYrSSt2RuZ4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=myTI17oBvh0fZxbxBnrb4aokF4nDV8NLkF1pv9oIZxVHVSnFHOETGUpP0akFizeLvZWD4JSZa5/CqnCeqa4lj4+jeQZu0GoRCJRmMFoEk0w7WwWzaqpuzwiJhITEjlo3dupNlMErwcm5qPLTGBZpPasoaQLMhdF5FDiFBkGVY4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ef4ocu7C; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ef4ocu7C"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d3b445a84fso88535ad.1
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 05:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787747449; x=1788352249; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OtDyfAId4c9pmXSo6AkYFWKqGY/dpqg4gomEyUaZ1rc=;
        b=Ef4ocu7CETSoJErdQQj0QzXx0Vz9vgQMwF0193Dmw9FhWrCD9DD/MLHSXjeqnXs58A
         d/V3/eCzVAjP+1sFpqJbYEl9hzVui2ES76htGVOMC6QQ6R9U3DR/koRt0CERh1hzOKV7
         bzKqNsn5JhorMH5eLYi5VM1YhWu6O8awX9C8+/uEcYnQK57Xk2nEu3/w7oGvqwmWZF2n
         ZR3+I8gBhH2HHNpC+MfAnYuf9AhH/kT4H9yYQHMb9sR7UMvv49Aghs0SzlG3NqxlQC5h
         VqpF7IK+EE81KkWQ27k+qvjy/SfARtPHy7GW2uo2Izeh5AVVvxy9KJWDSLhq+ui/iRCF
         U3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787747449; x=1788352249;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OtDyfAId4c9pmXSo6AkYFWKqGY/dpqg4gomEyUaZ1rc=;
        b=XK1m6R3J8MMMcOvce9AwGklM0JXZ8dlEiEMbI+fN40xniMh3UU0P5R7FLsTJvrYAJy
         LICgjLC1uoINSRKzuOn0RQQZNHe6HP/bxUETnzpeAV1v33U4lbghyFuD5scQXMAK7Bjb
         EGAR6Sv3CE8xjOVPqrIC6/92HUSmeLQhb1JdzcymdCTzxWK8m1vLbPQsbR1eUP5jgalZ
         zvZYauKXuZ4zvZhZwTMaGozCKfW78CudlJ2/JhLMM9tG5JnyhqdHTMihc8KUZlvfBd9E
         Enz0msdQcfsog8jpZj4vgE2zmLyv28bjK3R+S9tQng/EdTM/rtAixIthu86CzUhVTxXi
         5itg==
X-Forwarded-Encrypted: i=1; AHgh+RpnHi0sCP/Op40yNIo1Jz/xk57bgAyBAzg4Q3kIv4rejJyQplqK6lhU4ddSWcetGE+Ox4oSgA==@lists.linux.dev
X-Gm-Message-State: AFuF++kY1nth5Mv+W823VmxVrcYqgd8oLklkW8eK584/1ZCAdJR83aad
	459LUm2ASJZIYEO2fcatsegAbuUV5yE/0LEdZ7ags38NmxgiRc7oGw/4ceo28ptyaA==
X-Gm-Gg: AR+sD10DucUYw53Ahe83HEb9zMHXE7o0IQEdKut0Ykkw5CJqWzW6FvqYsausmFQMX5f
	LqQjrn/ZKPOP4KpEDD9eSACO/hUfTbQVm9Ouy/ZtjOdzV5DotRfsPX/ULvSoONaR9cyi00n1HWh
	bFYkEIih/Enk0KHTJK4avI1mc39vBzUd52RLdGC4tJvrB1s1eML0ZOxOJUQLetis9UTJQhNlruA
	7gJFb7fk5Aprdgr5DFNWQlfYEV3MpiiJvgA61dH6vSOcd1ebKaaBCbhVmB6abl2McodelOckvzD
	eo1QGCt4BHj39rya3Pe+7iM27kE7unJnxRaxM2klWMr+spA3h2frpVOIJEhRI1ujS9DqgrSLKf2
	v53ppZer/jJBIefbQjRVlCPI07ck7ZgooZex/o35ueJJPEF3Izuitmco3JtWAtIivglMsstQOld
	Ixb9VPsGMl4srpyZ2T40KLibnX1K94U0Quk7osSYBaRd+PNkh8UedUmp8r2UaPHmwvmVo5XkQlY
	alhVHQJd45nWRCO3iHItxJhOw==
X-Received: by 2002:a17:903:22cc:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2d70baa90a8mr5053075ad.2.1787747448020;
        Wed, 26 Aug 2026 05:30:48 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b07394sm7933816a91.4.2026.08.26.05.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 05:30:47 -0700 (PDT)
Date: Wed, 26 Aug 2026 12:30:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 08/18] iommu/vt-d: Clear unpreserved context entries
 during shutdown
Message-ID: <ao7ccBlV9_RXT6Fe@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-9-skhawaja@google.com>
 <446684d8-44d0-47c5-9301-172c55efd950@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446684d8-44d0-47c5-9301-172c55efd950@linux.intel.com>

On Wed, Aug 26, 2026 at 04:05:51PM +0800, Baolu Lu wrote:
> On 8/8/26 10:27, Samiullah Khawaja wrote:
> > During normal shutdown the iommu translation is disabled. Since the root
> > table is preserved during live update, it needs to be cleaned up and the
> > context entries of the unpreserved devices and root entries for the
> > unpreserved context tables need to be cleared.
> 
> The key assumption here seems to be that, during a live-update kexec,
> most devices do not go through the normal iommu release path. Otherwise,
> their context entries should already be torn down in the
> iommu_release_device path.
> 
> Could you please confirm this assumption and add some short note in the
> comments or commit message?
> 

Yes, that's correct

During the normal shutdown paths (i.e power-off, normal reboot, & kexec),
the kernel only calls device_shutdown(). This path bypasses driver 
unbinding, as a result, devres_release_all() and iommu_release_device()
are never called. Those devres teardown paths are only triggered when a
driver is explicitly unloaded / device is unplugged.

Since live-update piggybacks on the kexec/shutdown path the unpreserved
devices never have their context entries naturally torn down by the core
driver's devres model, necessitating this explicit cleanup.

I think we can add a line in the commit msg for this because comments
might create confusion if similar comments don't exist in other drivers
performing Live Update. What do you think, Sami?

Thanks,
Praan
