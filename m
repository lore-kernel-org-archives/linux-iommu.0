Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D05D22EE5
	for <iommu@lists.linux.dev>; Wed, 29 Jan 2025 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158657; cv=none; b=EFUg3STeMDzmjWgzUKmdm7ISjxrX5+PvR9o2rb5SrgarILkfREFEREbX2RgJAb037hL0OGz1LSgYD2IIU0k7diOglkPS3wsZyTxZoa+eOVPcPVqK6O2FJRtfCqzV0SwPagPkEPs43vrChj4dKG6ygfVLdpHaXQWdd/pZSdi5UPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158657; c=relaxed/simple;
	bh=vlPMfwZ+C0CQX8CZbIzbwgggxxliwvbZU+YOWu/UjqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di0+Y7agyXwzbC9U3+1YHZ7+gtvoypYGQ/UvFPLSyWzc31xNXrw/0arTdAKhOvWTFi9wKzJULzHrQzy7PbniZ2E1cP6rQHOuET2dI7fJTc8MKerCceZdSQS8WqQurKP8S9lr88QVNWQxyL9TtcR0M2rVG9lw/S1yDsW6zAmgX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BpjslgrV; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BpjslgrV"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d900c27af7so66950186d6.2
        for <iommu@lists.linux.dev>; Wed, 29 Jan 2025 05:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738158654; x=1738763454; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vlPMfwZ+C0CQX8CZbIzbwgggxxliwvbZU+YOWu/UjqQ=;
        b=BpjslgrVJV/3edWfY2/mviitMjIIcYulmEt48ij1P2//Ch8qmveHusEiVAqSpPqL+E
         YDuNodOb+GOJOaYduT/RbMqWEsPmM/CIVhU7PMlc0J/fVaOg2XT/1Np3YgY4yCY+bFVA
         NRsrBPhGdYHzMnom8xFgtYnXuQ5GLlfoViXppeptu9SHQCFh0zlfH3afVq00zthOWbaE
         JOBDjx/BxNvkHtKx9HknDy8GIAytLEFtY/vSh+i86qZGkXqBHgqB9g6zdQqlO1dLdhMc
         s2Jm3BuF/gKY5XsftCEmH5phTg9xizsH1+b5O7uYQzETE91yRErTlQqxzeYxjhoNWlAL
         d0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738158654; x=1738763454;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlPMfwZ+C0CQX8CZbIzbwgggxxliwvbZU+YOWu/UjqQ=;
        b=bE2aGbycZu7j1IVdYCODM+bru2jCsJSxWrIlm7l5Tf+sTpLT8wJ5lEU1ocgqlBuLR8
         9TiStwJHuRgK0Hs6fqZ82zuaQe7qt/E3tgtl6gI/fvqgAJVyS7C+eMLFTrtt+avp2SHG
         9oWbKkubGo0QzMTWMegNUYJDFjUwFFHZO4NulQO7cOK7eH2sYBFhrwW0tmbm0Y/ewyuS
         p7zqzMYSKTp5kAvTS4KSSLfk/2YRVeSKNusq2Vq4EwPm0Y+mIVU/C0hFuoWkdCq57fEj
         tsCPHAi2K28MKsWwZKobx4UKlTPxedLblGNyiWF8WLz4/ANVL8cp/Eys1FBGxADYE0Yz
         pB7g==
X-Forwarded-Encrypted: i=1; AJvYcCU+OTXGO4jbq8vBiyo+gJ0BX28JcP3knseYRHnW6AA8MrjMiGfBRWVak8Udxc3MrvUJcR+z6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyoh65XIzCBt5DMC3Gnsj5LaBq8Fm68Yifjo8nHrWa32xh+L8ae
	eboqwMehGVrzA3nfq73+XpEU2FhleV2+WHGczSLMDP4uzHuAE4orOqdTss0y8rs=
X-Gm-Gg: ASbGncvDgqn6aMLZhtaDKpTaPsFPMieNVQmzo4m76bHfhDGMuVdabQOI/14ihtfU9dh
	tjphzN5nwDNjzjHpNiEQtlEng0VolE+qWUz87JIHx7L4EGxkVJXR60AAi2Ejdi6Xst3jmoiVqdP
	WG9dr3u+CULA5J99uuMbKsf3PVXFJ+JwrIA3ygBc9bA3wkwGHMGdsIzhtWKDapfpmSdp5pxyp3I
	RaOFh60afIOwdD7ldpUPI6poQjC8yDiG6ADsH4Xutc5rJxvavTKBZ3yMjN+xcWu+z8nlLbfA/jW
	+sMqZL6F2WEIS0OYQt0+C9MnBRKvM2adysUF9zN4pQ32L+KmOFIgw1uivaUlgxs3
X-Google-Smtp-Source: AGHT+IHlGOABfGzgCS+9RYYlIPNHGozwdrTB/aVN3u/ZTODdcBYH+YEI+HYYcAFunhC+uzQZ0l632A==
X-Received: by 2002:a05:6214:252c:b0:6e0:86ab:4b46 with SMTP id 6a1803df08f44-6e243c63cb9mr63742866d6.31.1738158654377;
        Wed, 29 Jan 2025 05:50:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2058c236csm55482536d6.104.2025.01.29.05.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 05:50:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1td8Sz-00000009Bm2-1Dp2;
	Wed, 29 Jan 2025 09:50:53 -0400
Date: Wed, 29 Jan 2025 09:50:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"maz@kernel.org" <maz@kernel.org>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"robdclark@gmail.com" <robdclark@gmail.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"vdonnefort@google.com" <vdonnefort@google.com>,
	"qperret@google.com" <qperret@google.com>,
	"tabba@google.com" <tabba@google.com>,
	"danielmentz@google.com" <danielmentz@google.com>,
	"tzukui@google.com" <tzukui@google.com>
Subject: Re: [RFC PATCH v2 00/58] KVM: Arm SMMUv3 driver for pKVM
Message-ID: <20250129135053.GB2120662@ziepe.ca>
References: <20241212180423.1578358-1-smostafa@google.com>
 <20241212194119.GA4679@ziepe.ca>
 <Z1yNWI9lBNIZg6Le@google.com>
 <20250102201614.GA26854@ziepe.ca>
 <Z35rEeSVwfZVA9IF@google.com>
 <BN9PR11MB52760686ABB3145E44BAD95A8C1A2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z5DWag7ZKCPl1Eje@google.com>
 <BN9PR11MB5276B783D518DB354BF58A3C8CE02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Z5odLXPZPAwu4oqe@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5odLXPZPAwu4oqe@google.com>

On Wed, Jan 29, 2025 at 12:21:01PM +0000, Mostafa Saleh wrote:
> levels) and can’t be separated from the kernel as that defeats the
> point of KVM, that means that all hypercalls have to be stable ABI,
> same for the shared data, shared structs, types...

Sorry, just trying to understand this sentance, today pkvm has no
stable ABI right? That is the whole point of building it into the
kernel?

Things like the CC world are creating stable ABIs for their pkvm like
environments because they are not built into the kernel? And thus they
take the pain of that?

Jason
