Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF932D780E
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493321; cv=none; b=rJ7Iq304rdO9tlMshXCbghocrqpaBb+uzU2z0ihYFXbyl+YzHXd+Yxz0BiXOl8NSEShkcWro22Wtd8KYoVXjJgoVxd4OrSsGqJ1O/kpbCJYJB9/3BFkP/5B+At3fZ44t+Zq7bLVsfgpawcglKvHQV9ektu9jr+dl/ATrsqMbqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493321; c=relaxed/simple;
	bh=9BWuaZqYbE2xZQJ56+qGW6ufhtqU4X4Evjgd7IH1HgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqHh6uiqwgOu9QvDQSvpLvKU3DSe0Lc5myUPCrPG6sNrKhKu7G0jTJAhU8k8xxM30ALcptlKQQ8dlkd9XH8e8Qq0n0j7BK93agw7Vb+OSbB0XRP8rxD0mhSi4r6zCItfSn1aNG44RZR6j3ZOt7wFuvhwFFfI7tlJE9wIaZ0Ht/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t4++YT3l; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t4++YT3l"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5175d339e8bso486441cf.0
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 06:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780493319; x=1781098119; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wV8eYWbv/I03NtOIpbrdNUBR1gCQqSNReaPud8ZUHs4=;
        b=t4++YT3l0FRwARmat7eLHAGnYsJfGHvsnzQt8zmQdck1p6dfJLp/S7uNRwvdEcCs1J
         aZj/k1lwP7PoeyRDklemm/gTB4iJs/h9y4a3Hy+i+GIDcz91PlXL4iEC8cIirANAWgjV
         U2YQQ6mu6Rzd+RNjPOzkc7G/eshH9Wqv0TfW7UP7AQHwbaYn3vjeuOzvO0IcxMTi7cOm
         djzmMmqZvCvrWa1ZCXPhUkabdq+gJ5Vu1XzWdnEFkXA2Z7QifJ6Ne73vMxLyq3z7zvle
         y7Ww38Q/VcBJ4KTIcg0McIQB5lyVlrjDlnnWGquxEt5hNULqDI7VrHDB+BYkYLrqpcPt
         t5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780493319; x=1781098119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wV8eYWbv/I03NtOIpbrdNUBR1gCQqSNReaPud8ZUHs4=;
        b=sezd7Lnj670g/pj1vM9eRu31g+SzbNw1ccGauY41NwNDEzlh85ytUTR8ZULSWbf7rz
         3xOKSEM2lwD7OFZD2ngt6OvZhKrAm3VlOjIxe7e5ZjEOCwGDDqBeOCVvW4TNY4cTyn9u
         E9IsDq9aaMm9ezsEZQrnsC4qHxanB8s23x5NHn45h5yrOPk3tnSwvcgQmWkNwFQvIwp+
         X2WdQRa/X5Z4gpF3/xiQYvR+W+aJ9x1NlDStX4QhlTHJv313O0P6zzoBerUJXF7lv7tA
         OggncnRGAktwlZJ5IaaReetyi+NXOSXGhTov8z9t6Yxs9ZFOfRCu0XzAtU1c5TKnKDxg
         7dPQ==
X-Gm-Message-State: AOJu0YxJX37K/wqMp0LwD8N/RAx4wk7hE9HVwowaf3uQLLgJtH4ynXbd
	Q/tLlMM7l4ul6na3XH1oKYztXHuqlK046U8CUB47jmn+ztvwCi+gVqq0jwd0yPkSqg==
X-Gm-Gg: Acq92OGuIr/7aThtWgq6YL/HuY4FDYm0uRCoXKcWWnxZV0/8RdLNWrqBIazIH/394nK
	ROdMt4g/jrbARPNPfHH8a47LupiOdJiyE+7lX5Y7vYT6FhkAKjORuw723eTlNbwoHHYClIv46fd
	MALr4hSAfIB7N3wnnyXuPNRoqB2y6FVTIr2DH3HS3LEydAAlhHX9nU1jkjbNQHLJRlg9VmkUmDL
	d+7eJ7g58jOC6RS1uJ687AAHNliL0bTWZUS1l6HoY4tEsLhSsBtApP704qfOUEtCnKCqLvPv72l
	HNlaa6/d0Vuo9tvwMH2bavob6RqfwZaNFW4YHV/twasbZUPelMivo3dGezHETi8ZAb5FvTjLXuU
	vhIG9q5Sz4FBNx/RLsZAu5USUgziI08ZJXI4sPRCu1Q8Z7NVXuh2Ka0e11Vu/5nuHTOvsa2jIyn
	/6ln7AismqQTJvoOGguTq6c6d9lDkHMIJs1yNQZjgcHi7lpRh+9Qz5Gm1kutfcIHfu2D4DwN0=
X-Received: by 2002:ac8:6897:0:b0:516:d25f:f038 with SMTP id d75a77b69052e-5177b9a4747mr6943111cf.10.1780493317250;
        Wed, 03 Jun 2026 06:28:37 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb915csm20063146d6.14.2026.06.03.06.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 06:28:36 -0700 (PDT)
Date: Wed, 3 Jun 2026 13:28:29 +0000
From: Pranjal Shrivastava <praan@google.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v7 3/5] iommu/arm-smmu-v3: Fix a UAF in the probe_device
 error path
Message-ID: <aiAr_YZqVwijXyQ5@google.com>
References: <20260601143644.2358771-1-praan@google.com>
 <20260601143644.2358771-4-praan@google.com>
 <DM6PR11MB369078B4E5BC3C6514A99AFE8C132@DM6PR11MB3690.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB369078B4E5BC3C6514A99AFE8C132@DM6PR11MB3690.namprd11.prod.outlook.com>

On Wed, Jun 03, 2026 at 07:31:38AM +0000, Tian, Kevin wrote:
> > From: Pranjal Shrivastava <praan@google.com>
> > Sent: Monday, June 1, 2026 10:37 PM
> > 
> > Clear the iommu->priv to NULL while returning an error from probe_device.
> > 
> > Fixes: a2be6218e649 ("iommu/arm-smmu-v3: Improve add_device() error
> > handling")
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> 
> probably add a note that UAF is theoretical at this point.
> 
> iommu_init_device() calls dev_iommu_free() right after @probe_device()
> fails...

Ack. This is just to prevent a UAF against future refactors. I saw the
intel & amd iommu drivers doing it and felt this is missing from smmuv3

> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thanks,
Praan
