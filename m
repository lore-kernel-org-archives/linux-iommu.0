Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186613C3BED
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 18:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773427801; cv=none; b=NMsnrzQgiel8lQd3pBlawWNkvD964bSmU6KTxS1k46qInCRjh7K8Sn6wN7d6SJ0TkC3BQXop1pQ+/7Cb484MVcFvbTUnCh5mV6xmZqG7tG3nzW0O3zsbuiQY1r95z/3b34lnCU7uWUCxHvpKBlXZOJoQdeeBK2RGXRwz7dUtd3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773427801; c=relaxed/simple;
	bh=Cgw7rgg052jBwsBm6FVNyDCSrT6homGIa8xXe2Nl/LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWgK43LatbHYD1aVKP59w3ZqkcxX9gcyQ7om8J7Xix6DqZf78U0mlnoTARuUu8Sg6GeV4RRyoIz8JZLKpeDvjyIQb1GnPiDaDhINxHcH5uue6y50HRGxbLe90PFS0oYKKk9012uh40E/oO3bgJuhh4y9qyl2LkOVPwT0EUtXh4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dTE6kyi9; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dTE6kyi9"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89a14be4733so30770366d6.2
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773427799; x=1774032599; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OmAqHdmpJRsgkjLn2CzcNC2LkQHnurZaGunyWBb1R7Y=;
        b=dTE6kyi9i6DHvy5cRvHsjWFkOxVcCLxu9heQRv6hkqGi7K+wMX4eBBRZigM60+BywL
         asTkAKhSDoUnTLNGBM9O/97/6izNOt86HMiqfUtCzXEwL/TSpSSutyIoQgnJP/vEpP01
         CVWJSZRJ86/CugSapSStO6g+4rWphFZWqO4uL8a/jqD+gFDO7kMbCisDlmd1ZoeNOsbm
         12zKEQNdbTTRgETAwF585/PkjyMxc0+1O9QQrDJvYIFKBtbCLXLVkSKuLUByOBcJvO15
         lh072RjD70iPDsgQyzVlJPLspLIeVI78+yrFGbn96CO1ni43W6E6y3+OfckK07HcrdY8
         sNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773427799; x=1774032599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmAqHdmpJRsgkjLn2CzcNC2LkQHnurZaGunyWBb1R7Y=;
        b=MXqXvuCsdv+QQkHOWT6VH0+vVCSYRpf40w4amvEY4aiuZ2CY3x2YCdK4NsB4fkLAPq
         Bq8tsknF9NO/rNO9Z8hlxQdEfrGOCWoYwH97cPJ95EF71pcDCZKe8t6aEQRMgOD2WNO4
         44amMEBrSFSf/T6pEpcsNMeHJB6N7Kkyu8YNmTjH72dYJUYv6aavw5aAh8ZgxwcTZogY
         dGXZTvPxAYXDjk3jf1v3BOj5GP1QUoUsM2kePhsQrw2A4ySXvPQ2DDC8eelv5skPuD1Q
         bE8arHfPhnSJYeflZQvKoX0MAX3aJdDjNwvEqk+VehU69YARNyrhJ0aHkiPcdFJY5zNj
         fJKw==
X-Gm-Message-State: AOJu0YwgiPVUoJ0c9gfriW5Xs7uYSMwnRpx+aIedqPHo2wGER7fvRlww
	Gn4KBEB28HEi0jnYfud7dHTC4wGQQqOpaWZMqoSxS9c1AMtvS1pEX8geoHdvdc6FdoM=
X-Gm-Gg: ATEYQzzCV5RjvMo9uCcFYEhqFuZfE0RTkkYJvjQ+agBU4XsrUqnrOqA7tog1kaXcd2P
	TOPNwRz6Uao7kyyBCQJ3DDsy4WKFn7VVyzt/ODEgfh6vIZv3b9+BocPKFFCfmPy/se/GMln9kju
	0xkdyrZmCPrYZ8et/G66svqq3J6qs8b5pYaIqHxhmWzktXuFIE3DRicnIdWFbAu1Ar2IR8QaVCo
	19qrD020Ht/okqEsIYW+pV4z0fmQPerhxoX0B2z72/d3tBigERWUTGXTEeyJJJzmpYvm0Qt3YZg
	X8/kFM+kOqL7NVRnldAfAjRVjZhoYsaRilc8PGoQFRr4JVHBcpiHN8hso42kx3+lxYB9vmYiuUn
	CtChgq0r+aqiP2NBmfdKBU0c7fgCdZRsSIwvc+fkBgt+2sn4IZOFL3XgrUT9kpwKR14xW4S1bly
	GaSxSiVXm79ZIpQRDfAZByuxSj3WmUPkou3yseCtAW/p6E0UEu3fatUhe5cLPVfqSKT4D84lKJ8
	EiR2Ivd
X-Received: by 2002:a05:6214:1c0b:b0:89a:ff2:b8d4 with SMTP id 6a1803df08f44-89a81ef3356mr69685496d6.36.1773427799050;
        Fri, 13 Mar 2026 11:49:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65bd318fsm60836326d6.8.2026.03.13.11.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 11:49:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w17a9-00000007M5A-3jdN;
	Fri, 13 Mar 2026 15:49:57 -0300
Date: Fri, 13 Mar 2026 15:49:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 3/3] iommufd/vdevice: add TSM guest request ioctl
Message-ID: <20260313184957.GP1704121@ziepe.ca>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-4-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309111704.2330479-4-aneesh.kumar@kernel.org>

On Mon, Mar 09, 2026 at 04:47:04PM +0530, Aneesh Kumar K.V (Arm) wrote:
> +/**
> + * struct iommu_vdevice_tsm_guest_request - ioctl(IOMMU_VDEVICE_TSM_GUEST_REQUEST)
> + * @size: sizeof(struct iommu_vdevice_tsm_guest_request)
> + * @vdevice_id: vDevice ID the guest request is for
> + * @scope: scope of tsm guest request
> + * @req_len: the blob size for @req_uptr, filled by guest
> + * @resp_len: the blob size for @resp_uptr, filled by guest
> + * @req_uptr: request data buffer filled by guest
> + * @resp_uptr: response data buffer
> + */

This needs a much better kdoc.

Refer to specs that define this.

Explain WTF scope is

> +struct iommu_vdevice_tsm_guest_request {
> +	__u32 size;
> +	__u32 vdevice_id;
> +	__u32 scope;
> +	__u32 req_len;
> +	__u32 resp_len;

do not leave implicit padding, add a reserved, and check it is 0

Jason
