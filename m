Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CD12D028A
	for <iommu@lists.linux.dev>; Sun, 11 Jan 2026 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768169684; cv=none; b=nq0BSUG5RhxPYCMOeEKq29TyAmEH7blCdQixH1g5X9dBD9RPmDKVvJ1tPND2Ioa5jpWyugG+hrjXT8N1A5Ahq3/CuffCe6mxEeVxfwP+s/Q9qZJs0ryVMfDdbtxgCQCjTcaSPOxgr1SfBNEYrsue/T6Pc+wMCqgMckhfs8XxONU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768169684; c=relaxed/simple;
	bh=rHiryJM7d29n7Ir5Iumqlnov61xpCgGo0ADph/D20A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0mdCrK7s82MkMwldfdkKznYXUCKww/bRWpCn8Etuic/D0ZqXD9BFlE+wbARl8qtCBl4eI6bZeRXSKHgy1DRCTjprjZO38zdoy1cXmLcitIokWyJBOLLejl7CHaNbZqYSPNTqiwehH3rtAruGcfDL+aqzf4c1o3+N+LDQttPLrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UnQM4t/4; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UnQM4t/4"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c0d16bb24dso553019885a.0
        for <iommu@lists.linux.dev>; Sun, 11 Jan 2026 14:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768169681; x=1768774481; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rHiryJM7d29n7Ir5Iumqlnov61xpCgGo0ADph/D20A8=;
        b=UnQM4t/4TXMiwllVklsb3E+sdK/aJPzkK+RzyKfDOyT6f8HdvmCTFSajQEWQkFotDw
         NazNiTA5+w9ZghLi2g9cgKWPY/w/6uuO8uzw072FOCP47vSA238jcH9obSTkF3NOsOXY
         RXyaexfO/1bVZKxhMwySYd+cjShBQsXflbYhxAG+p3tEuvMm4heAI+9w8ucWd+xcy3S3
         7wlyjLFgrWUWidihVVQTVtVMrGZDIh5J3DxycmXifnxG/kX2X0piR9w3yVKfBHmlWuBu
         A8zmSISaw/JG3nH9f+oetIXtKPSB7LknOiSBCd3oqWqN+mBLhaiIuy7UOAP6FORJ6BXP
         fIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768169681; x=1768774481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHiryJM7d29n7Ir5Iumqlnov61xpCgGo0ADph/D20A8=;
        b=s49hgxlmoLxqe8cA2n5M3LLm01ax5Z9GNnAZ4Owr8gvacQNE/dGOzY/38/0q47YGKH
         5v7M1cbGhcE5ePrceMILci9NZZoObfVr/B3FYpr2kYa/02CfqP90PD6KiUCuFgYQhiOi
         YeVfvL21otHJk/KzO2HFIFizVOwJzvKAetDTYvChIfCEWfuvCKhjQ+YAnSnrlRagnNzc
         mPMy8OsLnpwYRAkZBQHvktzldGGWswF+dXDEWY6rj6NoAKbBwP4GxfcvaCVk4fRqoQUb
         +Ugq8FdNEcKwKFIuU4FFJt50BnLiCXPb4jhM965enPyEcUpfQRhms5RN6SveSgG5EMNL
         tycQ==
X-Forwarded-Encrypted: i=1; AJvYcCV09Wtyocrb04rMwqChjZkCuySDc3I5UjbSsQQu4GW1PX5tRAk9AYqn6F/eiiAajfcgK3jy6w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4fAvti37/CAFgR2v2yMmvXM8xdc5nh5oK6UM3Ac0jKdrDsMKR
	gQguBQHsnoDejhg58FO+iaJGl9gKWMY66hfKRvCa+rFFKfTRVtY/KTFo1MouxrKKeKM=
X-Gm-Gg: AY/fxX7i4r+jKRXTuZcq4LCiDQABNXT1oOGRGXpAZRhZo6YrFRKxW345/rW2slre0Zs
	YoKqYhp/QnMmwPJbF2ObX20GD0W+VJJDo9E6POIwDR9yVV3Sk44JQftd9dHtJWwZL3S8/ZrTvyC
	wfnG1vlAXqqx2xqOgrMda9sIWQBSnU8oz20hHVs6KylbOUJmIE9H8C53wPWzDCtaonlW4vqAm/l
	DhxCHCybjt+EQOWLB4hGCz4zzqUE3t+80QxqFOE2fFSYMCJNQ4b8ePGKK77xWNgEVsGcVwbCO6O
	2IoGT4HAFeCJABlz36I2KvGqTJdcH8hh/6JK4QloGTD/pgYoRfpNi0z5Aq1EO6mMZYChOHJu0EK
	d+gjVVDV8J/fHyuViJctzoN6nAQK/QCMeXZHVfT499JeZKqyMZ+VCH/bYABKDwSAPRhQKC7pvMK
	s+hXSY09PNWE4Wf2wmsUS5fc90nc8T0T+sssuM2k1oDpT1Rf9N9W/oI4s9yeFzJUvO1IvzMDL2f
	GgfOCm81NUpX2Uv
X-Google-Smtp-Source: AGHT+IHNj93eZH1ynTU8daiu8l11Esrxq9PJGGVD0zEpnE5HUdS0s6ZkqCQ6JfdxMxeReo3KOm+E4w==
X-Received: by 2002:a05:620a:1710:b0:8a0:fb41:7f3c with SMTP id af79cd13be357-8c389383f76mr2218905785a.27.1768169681510;
        Sun, 11 Jan 2026 14:14:41 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c38a9244bdsm1117335285a.3.2026.01.11.14.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 14:14:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vf3ho-00000003Kpj-0I67;
	Sun, 11 Jan 2026 18:14:40 -0400
Date: Sun, 11 Jan 2026 18:14:40 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>
Subject: Re: [PATCH 0/3] iommu/vt-d: Add support to hitless replace IOMMU
 domain
Message-ID: <20260111221440.GA745888@ziepe.ca>
References: <20260107201800.2486137-1-skhawaja@google.com>
 <20260107202812.GD340082@ziepe.ca>
 <20260107204607.GE340082@ziepe.ca>
 <CAAywjhTEyOUmxWeCX6GwCBSnMf-p18Ksu2TUYeQ57K8H4RW-9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAywjhTEyOUmxWeCX6GwCBSnMf-p18Ksu2TUYeQ57K8H4RW-9w@mail.gmail.com>

> Thank you for the feedback. I will prepare a v2 series addressing these points.

I think there are so many problems here you should talk to Kevin and
Baolu to come up with some plan. A single series is not going to be
able to do all of this.

Jason
