Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E0C36AF5
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964400; cv=none; b=r3uT3HMEa1x9udtEgziabJ2cS2lJHGrGpYjMOOP8RSK2INRsUGWtQ8izBQ+dXSoF67n9/wgDKjVJyMRY94K3jLdzYX7mYd8/5Pi/oXOfIF2Mvr+vC/MTu4/KZrG3i33CVU827cycng9lwmGKEWkr+2Mr7O4lY+2BlWCa3uMuX7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964400; c=relaxed/simple;
	bh=YN6vMSV5mJVWgg/to8AJg4nV9KUUtYkIyeYo3vJiXEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgEOztOJmkaZmRECwDm1F+CNAP9zrC8hpiTqo3msAAeSVstpTHplCO3OIMSJ3sGX2tjZU1yLbjD7IKaDZwU/P51tj6F7aXTMK6HzwIMMs0PRQbZ39KOpAR5TILZt6Afc6iNMi+MpIuN9afzhe9Xhyq4roBGHmwN6DEQNsMjiLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hUEdp8gK; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hUEdp8gK"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44ff398cefcso5502861cf.0
        for <iommu@lists.linux.dev>; Tue, 06 Aug 2024 10:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1722964398; x=1723569198; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSznEVEIYw46wyW3XMMsma0WGZhVspw+jN+9r2mgLEc=;
        b=hUEdp8gKQR1QB86WN02IPCimfhvOkt8H2yUQBRxZC1ttW8u4oTdQd1h2cuwy6bVuUL
         04D0fml7Yj7lXKkqiGNxinAE7H2KHwxLBudXN0oZCMLFtMzcFYityjQb47gt9me/zqKJ
         zYBrqVtMq+4VjByHxuVArQ9B1RN9SR0yXHGx1svCg1l4F1uNoM9zUNCySaxbPxJYQu4T
         P38qY0gZSXlHtGRw4We6bFXJOyxOD3ncyiuWwS3/rzblsWCGqX2R7Cb89vpih+KBG2PD
         HF+zFl1J2n9xa54OonJzPdEwKCkC3h7Xz9DcmB1iFKd/cq5o6FnD1h66h+8V6hUnrSmZ
         oc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964398; x=1723569198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSznEVEIYw46wyW3XMMsma0WGZhVspw+jN+9r2mgLEc=;
        b=TNJ7JEE4GofYvRbGIsr3eLiGWl2E32CkOVWUl+b52uFPLtFDa5g0W1tB0vWJsqrJUe
         qr56vr5Ha00KdLGiKv0tiEaWigUMqRA6ifdoOTpq6umBLJjP3bbWO5V9p8QojVD/NlEa
         mPKODIBhZAUeC3Ihi42NIdk/9J9yQvYjWA4dXU45o8R1xvrs6typopw4scCdvNVna0Dp
         xuYKgWIqFxCPwbuwHoiP+fREO+3XvMTYPpRiQXuPCPKAVaOgN79kXo41IZpth1EtlL6L
         eFvQZLbrrB+adPezFkp17slW+e8YA3OBaV1pLBvAibP/e3hjVHwYkH7MoE/+nrd9RuSv
         A1aA==
X-Forwarded-Encrypted: i=1; AJvYcCVkDsIm1uI1bOFs4LfOy8MM/KQH+bYPSSae/F5Fgn0GBvQE1TWWkC3HCwzz+UFZlB6jqjz5o23u0KBK1z/gU8ujda/WCpI=
X-Gm-Message-State: AOJu0Yz+d63AQ3fnh8BqNBUirjn/Ov3y1ThaATuFzJXPCGSXMDcT8+NI
	zhWYPL2d3koWvTS4h37N5cUUOXbNy0lhfwo6mOSOIxPORJlEH8qkdG4cajm1p4A=
X-Google-Smtp-Source: AGHT+IFVCBe2Zb/J2ADzsYBFArjOGEaznrjwg9WBDhd5sbiJxGOBrhqlded9CgkJnij9iXaZQUtVHA==
X-Received: by 2002:ac8:5e09:0:b0:446:47e9:6591 with SMTP id d75a77b69052e-45189204457mr182702781cf.2.1722964398063;
        Tue, 06 Aug 2024 10:13:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a7714fdsm39532601cf.86.2024.08.06.10.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:13:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sbNkL-00FVat-3x;
	Tue, 06 Aug 2024 14:13:17 -0300
Date: Tue, 6 Aug 2024 14:13:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] iommu/vt-d: Factor out helpers from
 domain_context_mapping_one()
Message-ID: <20240806171317.GN676757@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806023941.93454-6-baolu.lu@linux.intel.com>

On Tue, Aug 06, 2024 at 10:39:39AM +0800, Lu Baolu wrote:
> Extract common code from domain_context_mapping_one() into new helpers,
> making it reusable by other functions such as the upcoming identity domain
> implementation. No intentional functional changes.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 99 ++++++++++++++++++++++---------------
>  1 file changed, 58 insertions(+), 41 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
