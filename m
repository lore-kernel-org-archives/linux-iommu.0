Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1981AB538
	for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920958; cv=none; b=YDPbDMyKK5QzSJCTWsyus/Di5YlNAqWf4eyIb+ab4NK82TRw0m4rx1PEB9EbkJDC11Eg9rzdz+INCPq2o+48ZfSoS9+wRJ89h3rAKM95XeF/5KXcBIzWwWfMzlNndLZa4zIvAW/hRzbGI2Gv0TsHerVuAbtfGVOIwRc13c+2XIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920958; c=relaxed/simple;
	bh=XRS/dhY3lhsy5JlKSK/pDayLQmj12dslPK6ZKBfJS1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZVpXUCmtL4riR4NQjsV56X/DI+Fwi2WL4l6vvJcSUmngYfywVm1Cykt+vR4kWyD1UoYnv5FokOH3ilGLuIbSeFKbiOZ8hvsHWULaLYn7BA499QdRpVkkltZoAzL0vPw7asy4VmnVnkNY3ClSJA4DKC1cElOfHXpnk0bL1x9jqlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5tDW+WD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5tDW+WD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728920955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5oOyJqq8PPkDeXUCYaZe3E5gfpM/CyhtuyeM6PK2gI=;
	b=N5tDW+WDCP8DjFE6WHxOKo0cetLv4fHYgNFGI6SSxKDOPX0gNRgwyeX3nX+k6xLu7jWjtp
	1w3cCfuzGF+IrvVXe/oshY1AWN/JKpHngdrZiY1Gl3/uXVQLNygL0uCuo4d77M+zlWHwO1
	ra1phK+KVGNQZpHQwiInFKlzrcqCmx4=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-UkqnOoC8OvOxw6nZEmYdBQ-1; Mon, 14 Oct 2024 11:49:14 -0400
X-MC-Unique: UkqnOoC8OvOxw6nZEmYdBQ-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3b8a34c06so1920895ab.3
        for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 08:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920954; x=1729525754;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5oOyJqq8PPkDeXUCYaZe3E5gfpM/CyhtuyeM6PK2gI=;
        b=BwtA2BIS72mL5a8RJYI5FT+xq/aeaPsgcuTkSMx7z9bBPuD5GMBvi68BRDsJiDsldZ
         cFUsrkuM8yjkPCzbDCLOWRFhaf52XV/HTQQFA/Kww8l46GEBAE8o4qNCwVW19FadhX4u
         m0HJk2Nj5ttqgq/mI7paKNE01XKMfULAuF1bxGUj92FDyxm87ZTB+Qsr84SYjXkniFBV
         dcOhZCPg71LhSy2Vj7i62mY7edxLbXPHfnj27aCVvTZvHjaNsxd9PYDpUXaoF/tHrOIH
         ZOodmubjbiZlyLu90H8ILoyPyZELuM1B2AIo/O9hdxGeRAk6Z12dErsZ/D5A3uSYGZH+
         HvOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3bd8vuW3LKwAVhmBN+ZawCayp+UhC6R8olrIc5NNBGPaEkNfDgBf7GRdefLx9Gos92/G+5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyURWB970/AS7e9cpH2q0YeT1vBLlkV0wV5+L6ar2eWaGzx4Cv3
	qShGRUYNTbLI/lRlFpZ7W1ZQDiqX69Bjx23JeRI+2PaxRv50xwUL6rYE0IFp9v87+OW/upjIWc+
	HIphDDEdTBsi4KEaEnFyZ3VPGl+iJ5vL2Yj72T/IjiCDX5np9YKxH
X-Received: by 2002:a05:6602:1d42:b0:82c:f075:e033 with SMTP id ca18e2360f4ac-8379202d3bdmr268321439f.1.1728920953932;
        Mon, 14 Oct 2024 08:49:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUFkYkuWYHNF8mjIwi8TJAn4sHd44prmigXPuDnZRjvu50tB9Qo+nw7+fZFLhBf8JiFPBHQw==
X-Received: by 2002:a05:6602:1d42:b0:82c:f075:e033 with SMTP id ca18e2360f4ac-8379202d3bdmr268319939f.1.1728920953522;
        Mon, 14 Oct 2024 08:49:13 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbd2c7e34asm5505357173.84.2024.10.14.08.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:49:12 -0700 (PDT)
Date: Mon, 14 Oct 2024 09:49:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
 <chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: Re: [PATCH v3 3/4] vfio: Add
 VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
Message-ID: <20241014094911.46fba20e.alex.williamson@redhat.com>
In-Reply-To: <a435de20-2c25-46f5-a883-f10d425ef37e@intel.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
	<20240912131729.14951-4-yi.l.liu@intel.com>
	<BN9PR11MB5276D2D0EEAC2904EDB60B048C762@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20241001121126.GC1365916@nvidia.com>
	<a435de20-2c25-46f5-a883-f10d425ef37e@intel.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Oct 2024 21:49:05 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> On 2024/10/1 20:11, Jason Gunthorpe wrote:
> > On Mon, Sep 30, 2024 at 07:55:08AM +0000, Tian, Kevin wrote:
> >   
> >>> +struct vfio_device_pasid_attach_iommufd_pt {
> >>> +	__u32	argsz;
> >>> +	__u32	flags;
> >>> +	__u32	pasid;
> >>> +	__u32	pt_id;
> >>> +};
> >>> +
> >>> +#define VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT	_IO(VFIO_TYPE,
> >>> VFIO_BASE + 21)  
> >>
> >> Not sure whether this was discussed before. Does it make sense
> >> to reuse the existing VFIO_DEVICE_ATTACH_IOMMUFD_PT
> >> by introducing a new pasid field and a new flag bit?  
> > 
> > Maybe? I don't have a strong feeling either way.
> > 
> > There is somewhat less code if you reuse the ioctl at least  
> 
> I had a rough memory that I was suggested to add a separate ioctl for
> PASID. Let's see Alex's opinion.

I don't recall any previous arguments for separate ioctls, but it seems
to make a lot of sense to me to extend the existing ioctls with a flag
to indicate pasid cscope and id.  Thanks,

Alex

