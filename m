Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88823976A7
	for <iommu@lists.linux.dev>; Sat, 23 May 2026 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779542516; cv=none; b=ZCI/OL+0+6FluVXO1BHpD187Oj32UWKAbVwVcEbQl5sxQ9dB9kKvcdM5KEIqd6D4ZKe0kTiD9gKb78RzHR9ZoivT6VysCaqGwqJ/i14fRamzO9XFiKHdcA0OW7xJx3tGKVQRkKvSLAMr1GHGu2AOPFMLHKW9G0ZGnRaf3+QMTdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779542516; c=relaxed/simple;
	bh=mVpavoyb7l6uQQyd2XffEa1v5GKCirvC2OQyuHu/WoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2QwCSaXyfDFo/6FeXSRA3Eyczl9cwtzPYxOUo4KOgchVizxOA0dBUEg3/cyoEX3gT0D2JaUST2ZZfyHdghoqpLJLUI1wGmagH39Pus3kdfrYSlfsQTMiEvqFbFeGUbGR74uR/GKYJsA9uTZ0npcYj6XjdMEEi2V56FCgNf9RV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gSlc9V6W; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gSlc9V6W"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e97863425so89076611cf.0
        for <iommu@lists.linux.dev>; Sat, 23 May 2026 06:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779542512; x=1780147312; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RRo5ik7HMyePlqAnBOmFqKyPpDT1cZy71Z1vsu5Dc6A=;
        b=gSlc9V6WSCj2j9/AkGWb6ZyxUktG970YbioLjY4EXXR20CIDVRc4lTsU9I/R3Sn3qQ
         aWcP2E6+D2bRrJJn1wPdO4vTK9aiWCNYZnnjIi7a0ADF7umt+30nq6jcJHDWtjY9qyQ6
         LrsU/S/rTCh+zfeiKYGw3jA1iDwILUE/FyXmDHj9TRp4hgHFobk6QusNSIf++XC1G8Vx
         6PnjM9JIjcL2P78eAvf0LTXl08LppfmWTf3tEOiktjgO7vQ7Yeol8UpO4OhjfEEfCzVq
         JCu3CzJgg+kJ5hFBTzOR1LSa3bmkmPh/dOEcKzgkvBHI0fP0jmOFaEF5vzx9h0eyM21h
         orKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779542512; x=1780147312;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRo5ik7HMyePlqAnBOmFqKyPpDT1cZy71Z1vsu5Dc6A=;
        b=QgIb3IAbw2c9tvpHEKEQF5CaIXgW2MXb6z2wGlPQSUgD0x+lP7EHiaxATsEOFtpdyO
         MnT3/o0NHnIzQkLv2LaEB7wCw0cRuP0XhHHj3/BasSUTbTAN6NYO4mPH7hkaKfRKJbrZ
         jXQ9tR25jGvCvW+hM7W7OPOqKTLUZl22k5mBxcoqXpm5CMtLXecF4R69R3JfAMrac83F
         o2ug48PXQh2qp7sRLuWWe53zNdrG1CoGTfnM0pLxX1iyy+egCuCgf0QJo+ASl3ySjLGi
         j+KVMog4bL5pZnD2G9I3d4D/G3JEfjRY61iRUOvi94zmrB5miTwzXsxYXV1ms/4Mf5aF
         g3kA==
X-Gm-Message-State: AOJu0YzMO/wXhVOEVUuF+I0APTlv+ql5ejeZE1Qh+2ZVLE8+UojMEGZo
	9kCbC0D08tEVYXrRm5/M7tnK3Z3ecaMZWaSsQNvYfL+nyrOnYrbDbN/zC1pFJAJEpa4=
X-Gm-Gg: Acq92OETBT9v2AszvrERFNm78esVO0BTxrlr1TxQkx49kBYqyoKLjTcsS1JgzSfIikQ
	5iDXuFsXrSgjTJDiLNucE36odgN4+iYt9mQEhPEXmSbkcWXDrOslZssf69LLm/DQpjFzaDpXOX1
	SNtDtgAxaCt6BXbBadQoB7UI6npc1GrrAXptp5PRmF49OznTP9Bt5T0qNsn6rckXRJ+SE/I/SnD
	hgIagS+A49qVfS6kEhjFIe21qDmeqMPjoC7f5ES3JNZVOgmqo0fXdlyBnYNW4SgPFjylfeLUssb
	X5QsJGChb2Kbr5ez/skEsGB+jf4Zbie20IY8DpgAKRWirJ226ai3mjSJEXUR8C7Tk6UTz3r+b/j
	+5muLFDNw8nWmlvYWMIpu5Q7tMExumcFeuH/azz5/S1XYUmAmGsz1DLLh8yjkyjkRVEInrqxMNG
	jgudqaxvOuOA3Q5DFYsiSIb4sYtJaHCQTF07KnSAA3/bSkPY/bX+X09mYxMD5/LN0RxyCPXeXhp
	CQZ/92DY8sL3TS1
X-Received: by 2002:a05:622a:4cca:b0:50b:29a6:8696 with SMTP id d75a77b69052e-516d429b5e5mr107369911cf.7.1779542512416;
        Sat, 23 May 2026 06:21:52 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8cb9650sm39132141cf.22.2026.05.23.06.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 06:21:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wQmIY-00000006Gp4-3JkH;
	Sat, 23 May 2026 10:21:50 -0300
Date: Sat, 23 May 2026 10:21:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v4 1/4] iommufd/device: Associate a kvm pointer to
 iommufd_device
Message-ID: <20260523132150.GF7702@ziepe.ca>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-2-aneesh.kumar@kernel.org>
 <20260427135906.GB740385@ziepe.ca>
 <yq5afr4f1egv.fsf@kernel.org>
 <20260428125015.GB849557@ziepe.ca>
 <yq5atsstzxe9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5atsstzxe9.fsf@kernel.org>

On Wed, Apr 29, 2026 at 07:22:46PM +0530, Aneesh Kumar K.V wrote:
> 
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Tue, Apr 28, 2026 at 05:31:04PM +0530, Aneesh Kumar K.V wrote:
> >> > I thought we were trying to get away from struct kvm?
> >> >
> >> > https://lore.kernel.org/all/adf29Rn7q9Db0hxc@google.com/
> >> >
> >> > Ie this should be a 'struct file *kvm_fd'
> >> >
> >> > ?
> >> >
> >> > Though I am wondering how practical it is to do this at this moment :\
> >> >
> >> 
> >> Should we also switch 
> >> 
> >> modified   drivers/vfio/vfio.h
> >> @@ -22,8 +22,8 @@ struct vfio_device_file {
> >>  
> >>  	u8 access_granted;
> >>  	u32 devid; /* only valid when iommufd is valid */
> >> -	spinlock_t kvm_ref_lock; /* protect kvm field */
> >> -	struct kvm *kvm;
> >> +	spinlock_t kvm_ref_lock; /* protect kvm_file */
> >> +	struct file *kvm_file;
> >>  	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
> >>  };
> >>  
> >> @@ -88,7 +88,7 @@ struct vfio_group {
> >>  #endif
> >>  	enum vfio_group_type		type;
> >>  	struct mutex			group_lock;
> >> -	struct kvm			*kvm;
> >> +	struct file			*kvm_file;
> >>  	struct file			*opened_file;
> >>  	struct blocking_notifier_head	notifier;
> >>  	struct iommufd_ctx		*iommufd;
> >
> > Ideally, yes everything outside kvm should just use the struct file
> > and there should be quite narrow places where you do some kvm
> > operation on it.
> >  
> >> ie,
> >> KVM_CREATE_DEVICE with KVM_DEV_TYPE_VFIO still use kvm->users_count,
> >> KVM_DEV_VFIO_FILE_ADD -> will switch to get_file(kvm->_file);
> >> and VFIO_DEVICE_BIND_IOMMUFD -> will switch to get_file(df->kvm_file)
> >> 
> >> > Maybe ask Paolo how his series is going?
> >
> > I thought the above is what Paolo's series was going after?
> >
> 
> Hi Paolo,
> 
> Could you please take a look at this? I’ve tried to document the
> reference count details and hope I’ve captured everything correctly, but
> I’d appreciate your review to make sure I haven’t missed anything.

Reminder?

Jason
