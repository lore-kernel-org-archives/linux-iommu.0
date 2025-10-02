Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697FE311977
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759412477; cv=none; b=VJi+/MFecJ5jnsWDD47GYu22csPSd3BkoRxT0L3NuRUSyLGtBfsuh7AEIKijf9Z6U6sgqpaJbOMvdd9uvrOwBNJfW6KZ3GDRR551owNm75XLuL3/yA1/b1TdN1ZVTMwk8edgMvR7+NjLBCHeXymToI+Pzt8xt/kJavx30SQS3yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759412477; c=relaxed/simple;
	bh=VCUZW3Nvj0PlHse4ZIyPzDgY02LRnAE4zmy76PVnWfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qe5nb74lhIe3Ink57hhIC4i0+uHus13Un5acwrPsd74BZp7aX9xyt6uzAaB8rUFDWBiIrOEk4BiuiEyBPqDDNEmJZfkwBm/bNtUmHwKasdRCrepsUmjgz6nOHxdLyDdwRz1i0crPbHDf8erwUQD/mgfYAuNA9TkU1IVAaYJ42nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G/wM/DjT; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G/wM/DjT"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7bc626c5467so712891a34.2
        for <iommu@lists.linux.dev>; Thu, 02 Oct 2025 06:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759412474; x=1760017274; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PmaKBvWqIjSyu9OcOIOXhZlZKkkawFeVoff3riiQ5Jg=;
        b=G/wM/DjTpEsOx0pYlLYY9bCWNTPYwjmFDZ+uwPzkJ6HbmyAKIC5j9xOVp7eoJHLAKg
         +rMrZQaSBDNmVbCg5QoWDFDlBUZBrV0PAuGhTtRNjvAv/VK1KDsSYX2g0xHRm98zP1+M
         EtcA9K3eHMtUECt9wy/YD/7TXttn7S5j81tE4pOGj54ofqPdaCU5yTq1IXNC9lPsG4fp
         ch//9ITusawOhP7ZfvLbbDV1UbxlRV3DdDZsWDg6K8OUWiHvbftqyFnKBaV/IOYxjgZW
         fDboDoBz3sUPvyQR9LFoRLDUCPoBi8iQ2ABqTiDlF9YtzBSLqyzq77skkjM/LE0iWUDB
         oGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759412474; x=1760017274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmaKBvWqIjSyu9OcOIOXhZlZKkkawFeVoff3riiQ5Jg=;
        b=AskbbEvzrzCSnjz0BnIaAMiIs9aj1KIkIR8vVpEIqjh2cJrWSCD53Ep6DK+wZ4Q5AK
         Jg6p/hY+mLwx1V/kaTvBC+iSG0vVS+PFX6brLzgwh3BIknuhou7swCwGevV9ZDNj/sPX
         9t8FWmP1W2VTNHQHyWcmTkVzWB+cM21GaybVQnrQN+ip3NFZBIVMYmkoPDeuQyO966Fx
         zAaj3POkn4Yx9KwlqVus0t1VUYgyYHlH6ynXVLjTicji3PwxTVcp9P3q9NNW7zBlz/5F
         mf/iJkhOGQoctp36qpkR2t2H9hMpIdjXhy0732jVhvHwkiJC/ZDJ73hiR4dxCbYbSk0Q
         lBrg==
X-Forwarded-Encrypted: i=1; AJvYcCUL2JxQeFp+2eT1oDqY2CutNtEfQMCZ+WKijnitm8lFr/CfVrIQnx+BOn8B8c/XSmPUcA43pg==@lists.linux.dev
X-Gm-Message-State: AOJu0YytjCSqEYEk2fvGurs0R2g7HC20HafiDQbsiv7mht78IeMxS1UW
	irjlJtgwvOd+okcjZKV6lyHoskinRXV9JuEyYNR/iUpwgp35cOPln0LXQUc+pTPgqrE=
X-Gm-Gg: ASbGncve06S13/77QQoJBkvNd/py5+LkyB9phmHDjZi0G8VacYK/B2hkseinDB6kHgT
	NdCacr4mjfnCCXcK2L9/VoYMlJN9MP7HPlLiKGPmvpsBGxf1Xx7LOCnWMrduw5wLxt+lR+6PfD5
	JmSVZ+Ak6U6gSZB2J/mhyc6v0+Nwb8LkrPg6S2sI5hSYXPG7VWYHSq4ACtYKT5Wys3onwCemtlb
	WI0HIA1MFz2XymgSMnXIvvqYrnrEZ1GDbUUpNxbvkqrR/goSYvt4Zej1fAXPjapPOn41An41bSp
	637GdP125d6N7jmVkqqaZWtDXFAdWaKH3T+zYe7I6g1MGsNt1D0j4ADuL3uy7OFP7VQbs50Hr/d
	hxpbtTjZckFgi7dBGN2cl
X-Google-Smtp-Source: AGHT+IFxDIQM42E8wYDD/YlbjZwi8VbGSBiQY2HlW12G+z0jmgjkeEufW1JtpOZFmbmeO3fGFnaKgQ==
X-Received: by 2002:a05:6808:d54:b0:437:f573:b175 with SMTP id 5614622812f47-43fa41be418mr4594199b6e.31.1759412474306;
        Thu, 02 Oct 2025 06:41:14 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ab59bda0c5sm778082fac.0.2025.10.02.06.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 06:41:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4JYW-0000000DiFO-1CwW;
	Thu, 02 Oct 2025 10:41:12 -0300
Date: Thu, 2 Oct 2025 10:41:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20251002134112.GD3195829@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca>
 <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca>
 <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca>
 <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca>
 <CAAywjhRKvZBShj7KAXew2v_uGjn3HhvO=sFrZ=bVfMJ8ye-Vyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAywjhRKvZBShj7KAXew2v_uGjn3HhvO=sFrZ=bVfMJ8ye-Vyw@mail.gmail.com>

On Wed, Oct 01, 2025 at 06:00:58PM -0700, Samiullah Khawaja wrote:
> > No, finish should never do anything on the restore path, IMHO. User
> > should directly attach the newly created HWPT when it is ready.
> 
> Makes sense. But if the user never replaces the restored iommu_domain
> with a new HWPT, we will have to discard the old (restored) domain on
> finish since it doesn't have any associated HWPT. I see you already
> hinted at this below. This needs to be handled carefully considering
> the vfio cdev FD state also. Discussed further below.

I think the simplest thing is the domain exists forever until
userspace attaches an iommufd, takes ownership of it and frees it.
Nothing to do with finish.

While the domain is attached iommu_device_use_default_domain() will
fail.

> This is the part that I was concerned about since I was looking into
> the auto_domain. Users that attach to ioas directly and use
> auto_domain would not be able to restore the mappings before attaching
> to the device.

IMHO luo users need to be sophisticated enough to avoid auto_domain.

> That's a good point. But it might be tricky since the ownership of the
> device is with the vfio cdev FD. So if vfio cdev FD is never
> restored/reclaimed the device can be FLR'd. iommufd will follow along
> and discard the domain.

Honestly, I keep wanting things to be kept as simple as possible with
as few exception flows as necessary.

If we make it so that iommu_device_claim_dma_owner() is aware of luo
and the only way vfio can get ownership is if it is also restoring the
luo session then that sounds perfect.

Attaching a non-luo VFIO would be blocked by the kernel so we never
get these inconsistencies.

> The more interesting case might be where cdev is restored and bound to
> iommufd but the user never recreates and hotswaps a new HWPT. In this
> case we can discard the restored iommu_domain and replace it with the
> blocking domain as it should have been if the device was not
> preserved.

Maybe the HWPT has to be auto-created inside the iommufd as soon as it
is attached. The "restore" ioctl would just return back the ID of this
already created HWPT.

Again, this seems to avoid special cases as once we exit the special
luo mode of iommu_device_claim_dma_owner() iommufd is always
responsible for the iommu_domain.

Jason
