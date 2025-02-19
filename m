Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337D21DE4D2
	for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 10:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739961298; cv=none; b=mTfPaUAmxus+X+LmjVhdcQoNJlGCcYCzR8nt1PuMS0QtXsd8uoWyhB00ZoUrvINUEKdHDzMmrns/HJB1kItEtJFIgVy1awT8pFdv0ZNKfI3ZMNTKuQQAaq3fA0s4tDe/AbaDWrPhcHlMHlvVH6BppWXHdvyIX0wVJoZ/rYnoduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739961298; c=relaxed/simple;
	bh=b7MSguhkEYIFV9r/YVvQjRqC1zbG88lRpiyyvxT4IwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqYUE6dmkdILIO8FL3VA9Ch3diMZhI6246QfMGCYtAUkxKw1JCuNL+abJ+11apv1ZKvP7BR+fHHapqJ5Hm4OtkZ8oy5JHRXxsdSHfBVQC7WwdE1WvZmt+pqWS3QCGE6qbkUsZiF8mqfbRhyhzW6iLVDTDo5dKGncfcjahGtoEag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g0mM46w4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g0mM46w4"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4396a4d5e3bso49219005e9.3
        for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 02:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739961293; x=1740566093; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iddD4f+K68MybEewTke97XkRD+irdrfZMT0WwBhvQBA=;
        b=g0mM46w4qxD1m3gl7w+ua41Efmi2uXXkpUts38/ZNP8GFFkQCip5qCin38Mu45IH8y
         +GnecEYD22naeG2FY6DcSXxILhJodqq6TAdZpEqUTnYFI0ON3ikTdWwX7f/6Erg3YH4U
         bE8d2Qis5tNABM/YaTqrgh/6+5IbCK6svy4ZJ5wPeVPg+ErPdE47z/BHAKHdoLBiNHW8
         0icVpZ+T3frWC7mq+ljXGaWUGT6pMAQoR7cKMF8Ik5hlFNmdfU47GLNyO0BPhzS7mtPk
         oaUlHhWziireoQrZIFjkJ/UF0KPWbd2zZrirxw5VQO5HDRhmQUOg9U2nmdVJx1t3QuAG
         +RDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739961293; x=1740566093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iddD4f+K68MybEewTke97XkRD+irdrfZMT0WwBhvQBA=;
        b=KrQUbSpY4dY/t1SlQS7T8OCAxbnDOsZ1tzARL5iDdS60PKMo3N4Hj9pHgjoBekY/l9
         IrQf9/oMZSArAEvXsR1uwwHp4QaI2DNB2FppMIE8yjrPGtd452hB0A091wrNggnxphqa
         LaAtAosO2PuGzFpOYQ9wqXAB+GGwNTU9Ql4eWT9yluJ1ZwdPtitkNADXzsp+TJLP3S4N
         RRRl2/KNAsP/N9SEdcp/Kg1SAp/IfGs8JyH/tsMDrXOAGCGAcOj0pHelVdKe1jHTbyRa
         juHakryl5ToPf9lE8CGWEO+gGjxNL3/4YEkGpOoqX3EmDrc0O9Z35f4tlMHtHqa6x1Vn
         tKFw==
X-Forwarded-Encrypted: i=1; AJvYcCW23N0leTdaLlF8H5yfdNLFnPonQpGncsCsTLXi23NxNUUL8NFTvvq2EzHbYdWbVJYm0a6jNA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDo1WgWbgP6+1QDGqR+10zk9ICWHAyAyNQz30g5MmVWiZkMjNA
	HTdQ5c7rJveSnGCx0OC0niC3nPxPOAWRfnjVhr2wmRv1iJflTj4Ny7yVNQ8zuKw=
X-Gm-Gg: ASbGnctErwM5bKcGpibhxKT+hRGYc7lnu/B70kmG8Cw+y2r2Vo8JOCxznh9oH0mu+HM
	+JWf2C/j2JSESmUNEiug3m78KP7IedBINvko4ktatcf8PBxnUOU+9vI2uS9xcpXpDM7RK2sSAku
	dFCvGz5z562ygdGfcEBDQTf333BElGz6oSAQAMzJNbEqV3KtI741/zlxquJHBZTwSLZDJDXQtb9
	H97OvcdedhE+4D86VlZLXgpSvcE3k79X0ogrt/4kqYkNHIVQvwt+SqiI86vp0EnAAO3q8EZvIh1
	2zs1LyQzfvlt/w==
X-Google-Smtp-Source: AGHT+IGdvjDwC1Yg0UDGPC2/1cHd3XcCUaxjKylFQQPONcj1mC0xAaoqTWK5SwfaEl1+gWgif5i+lQ==
X-Received: by 2002:a05:600c:3b09:b0:439:9225:2f76 with SMTP id 5b1f17b1804b1-43999da7d97mr29641305e9.18.1739961293450;
        Wed, 19 Feb 2025 02:34:53 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f208sm207312815e9.6.2025.02.19.02.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:34:53 -0800 (PST)
Date: Wed, 19 Feb 2025 10:35:18 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: jacob.pan@linux.microsoft.com,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	"zhangyu1@microsoft.com" <zhangyu1@microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	Eric Auger <eric.auger@redhat.com>, patches@lists.linux.dev
Subject: Re: [PATCH 3/5] iommu/virtio: Move to domain_alloc_paging()
Message-ID: <20250219103518.GA513544@myrica>
References: <0-v1-91eed9c8014a+53a37-iommu_virtio_domains_jgg@nvidia.com>
 <3-v1-91eed9c8014a+53a37-iommu_virtio_domains_jgg@nvidia.com>
 <20250212112235.714b0a14@DESKTOP-0403QTC.>
 <20250212233053.GV3754072@nvidia.com>
 <67ad876d.170a0220.3c21dc.85ceSMTPIN_ADDED_BROKEN@mx.google.com>
 <20250213094601.GA243081@myrica>
 <5irmuy6xwrjsrdjy7tmfzlnotxqdoqagjdsdtqjrrit673zaka@r43nyvc5gcyf>
 <20250213180919.GC243081@myrica>
 <cu7lznx5bxnqoavt3ri4dtzwt7lu3loitn7a344rbnmahpnc6h@2e2dknchxjmd>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cu7lznx5bxnqoavt3ri4dtzwt7lu3loitn7a344rbnmahpnc6h@2e2dknchxjmd>

On Wed, Feb 19, 2025 at 05:39:19PM +0800, Yu Zhang wrote:
> On Thu, Feb 13, 2025 at 06:09:19PM +0000, Jean-Philippe Brucker wrote:
> > On Fri, Feb 14, 2025 at 01:03:43AM +0800, Yu Zhang wrote:
> > > On Thu, Feb 13, 2025 at 09:46:01AM +0000, Jean-Philippe Brucker wrote:
> > > > Hi Jacob,
> > > > 
> > > > On Wed, Feb 12, 2025 at 09:47:23PM -0800, Jacob Pan wrote:
> > > > > Our code and backend support are still in the early stages, that is why
> > > > > I am attempting to convert virtio-iommu driver to iommu_pt. Not sure if
> > > > > anyone has done the QEMU part to support VIRTIO_IOMMU_F_ATTACH_TABLE?
> > > > > @Jean @Eric Do you know?
> > > > 
> > > > As far as I know Tina worked on this most recently:
> > > > https://github.com/TinaZhangZW/qemu/commits/virtio-iommu/vt-d-pgtable/
> > > > https://lore.kernel.org/all/20231106071226.9656-1-tina.zhang@intel.com/
> > > 
> > > Thanks a lot for this information, Jean.
> > > IIUC, these patches were trying to add VT-d IO page table support in
> > > virtio-iommu, but it is not based on Jason's generic PT [1]. Just wondering,
> > > does anyone have plan to do the incorporation? 
> > 
> > I'm not aware of anyone working on this at the moment. Something you will
> > need for a portable pviommu is a library that manages PASID tables rather
> > than page tables [1], because the Arm SMMUv3 arch only support assigning
> > PASID tables to the guest. Alternatively you could implement opaque PASID
> > table allocation via host calls, letting the guest allocate GPA space and
> > the host manage the PASID table, but that idea didn't seem very popular at
> > the time.
> 
> Thank you, Jean. Just had a study of the spec. For ARM SMMUv3, letting
> the guest manage the PASID table, and then assigning it directly to the
> backend in ATTACH_TABLE request looks quite resonable. But for VT-d,
> my understanding is the PASID table shall be managed by host. By "that
> idea didn't seem very popular", do you mean that people also want the 
> ATTCH_TABLE request for VT-d also assign the PASID table(an virtual one
> managed by the guest). If yes, why? 

No, the proposal for managing the PASID table in the host was done before
the VT-d architecture added Scalable mode, so at the time they also had to
assign whole PASID tables to the guest and weren't keen on managing it in
the host. I believe in revision 3 (2018) the architecture added support
for Scalable mode and the ability to manage PASID tables in the host.

Nowadays it wouldn't make sense for a pvIOMMU to manage the VT-d PASID
tables in the guest, because as I understand it there is no demand for
supporting the legacy mode address translation of VT-d.

Thanks,
Jean
