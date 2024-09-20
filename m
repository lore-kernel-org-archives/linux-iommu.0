Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59987166F00
	for <iommu@lists.linux.dev>; Fri, 20 Sep 2024 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836879; cv=none; b=s/gZaKg67E6FOJKRenHmQx/0K9VrLM47F/Dk+PAWwyAbmGoIBmm7rhpHFLy5JCJIdxsDuZNEZ3dERasvoJQpGa3il/hoIjhS39kVMtl79oNx2onV8bYbvo+ard086SPGX4NSB/Ronfw0ZgyzamGrBHtddTNiMyVpbEAvWSmCa9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836879; c=relaxed/simple;
	bh=92w6dv+VseI/pBpQZrtGVh/yup0MAZCj8HPO1uZ7qiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmEYqbnYtQ6Uymv9P5yXVtrUE9We/kmtsAm8jnaEsHodievy1bivt4ay4xvgVlVjFF1RUGH5+6qbirf0UfIzBscIxbNKZqvzXNBCe8ClndLJE70WnMezaSj0b/dfxrKy63tGiJBIqxl2L5R7JacJddu1ZVtduBzkCAhXOrygW8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ba25d8VN; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ba25d8VN"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-536748c7e9aso2701465e87.0
        for <iommu@lists.linux.dev>; Fri, 20 Sep 2024 05:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726836875; x=1727441675; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VxOJXXuTPtJD2C97fiCxabtfgKFUIiIOX78ur33VM08=;
        b=ba25d8VNBKk9n0uCLfXpiXxuEHJCMZJSK3kFrY5y7AvDp4JfKnBadZ/Av9wmF8YpQO
         HIUOaZDFK/VGXzaWIF4+REx+ixVea3xb1HP8TR+ioUZnCwt4lFLcG80C0RNwb/BuhppZ
         WRHH4lLMGxwOuCmUpFJkYIoJvlCcnNynwZuuMvUoGLs/3uHJZTk2eHx3nNVpZdwrA9FB
         H+4+/EYMAIfZQSaOdhCSuLUPKWI+cEx9icKAF+9fRpTfQkED0rM7u7smzboX6Ep5Q2EN
         GwgfpWF7qiCQ2dH/ASn+ZyPn6jBVcGTerRfrzFEP1pp4vnlEKgsVZy6h8M4kf0j23AfG
         zVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836875; x=1727441675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxOJXXuTPtJD2C97fiCxabtfgKFUIiIOX78ur33VM08=;
        b=WgIa5rqA4zbyevxr+tfd0rAk+bja4zWNtirU1JKUzq/z+7xu56oDH4X6yMRvuUokMa
         e7Sf+oIkC+EKxnRVb+Jc3OsKPPX/Nw4G4t04L+iDg8+fTne3uEif8Ujv9kWRJg+ng2r3
         HkULY3QoIY0AQ3uHufxiSzQDjoJJqX7ONjXGOvC2LsVyQyVNSv4SMMwuZHeaqF30TjQf
         zxc2hnsqIfjIRfy8m24qZ42oiZKbsjUcW75D2fUVKPgx32LRoeD5/xfoieY70IDPngjq
         MAoBH0NWSIG623/GllZc/dQSui8dT7C9Ky+J6DgrxKAPTTddFzjjLhCJRdp8Pyw8RP4+
         rWMA==
X-Forwarded-Encrypted: i=1; AJvYcCXLOW7OvUmiobQPZT9kLO1fGkGketh+AYyvn5enhMRfSUvvgrvbM8dacl30JRBOykwhkTH4kg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz38tS9LxiqTfLvFyrexpbUAOydmasLQYj7lqEgP9mrhsWyyngK
	OWXsYR1hPHckfgAJqFrGjqso5bw3od7bDb5GLCIxLchDRfKXV1khsuz4R3Fs3s0=
X-Google-Smtp-Source: AGHT+IHOG14KF21RzqtJPgrK582YmG8ObcTpDLjYz0OHoTRqntbt5Q6vcnyU0BwEDB79I9PC0gWfDg==
X-Received: by 2002:a05:6512:acd:b0:535:65ce:e901 with SMTP id 2adb3069b0e04-536ac2d6791mr1966041e87.4.1726836875496;
        Fri, 20 Sep 2024 05:54:35 -0700 (PDT)
Received: from ziepe.ca ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb497adsm7145406a12.14.2024.09.20.05.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:54:34 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1srd9e-0001AK-AT;
	Fri, 20 Sep 2024 09:54:34 -0300
Date: Fri, 20 Sep 2024 09:54:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"j.granados@samsung.com" <j.granados@samsung.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Klaus Jensen <its@irrelevant.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 1/5] iommu/vt-d: Separate page request queue from SVM
Message-ID: <Zu1wim6MZz3rkbWY@ziepe.ca>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
 <20240913-jag-iopfv8-v2-1-dea01c2343bc@samsung.com>
 <BL1PR11MB52713D3D5947C66AE463FA4B8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
 <e0a1347f-877e-445c-9158-7584ae200bff@linux.intel.com>
 <BN9PR11MB527611131A808B78C8E0E8388C662@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c8708b95-14b9-4545-84f7-6f45161456cc@linux.intel.com>
 <BN9PR11MB52769D1D1FEA9BAF0E6D19718C622@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c54a15d8-fe60-480c-9156-bd77114c196c@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c54a15d8-fe60-480c-9156-bd77114c196c@linux.intel.com>

On Wed, Sep 18, 2024 at 07:17:32PM +0800, Baolu Lu wrote:
> > more than that... for each IOMMU the current code allocates 16 pages
> > and 1 hwirq. Those are unnecessary burdens in majority deployments
> > which don't support/require I/O page faults.
> 
> Yeah! I only focused on the kernel binary size but ignored these system
> resources consumed by IOPF. Then, perhaps

If you care about runtime overhead it should be delt with by
dynamically allocating the memory and enabling it, not via kconfig

We can dynmaically add IRQS in some cases now for instance

Jason
