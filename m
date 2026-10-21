Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580247;
	b=Of5T+N8y7VLj0eNCwfAhdFuE9OuTFHrlW8z00Kb5X2Qdz51SSiMUm0650oVyp2mc0ABM
	 cFDfNCztXtv5eNxQDfiKESX9o3pdNTIKSLk/SQnoHvvSHrjUyRRP3y3BjUXMQ1+3/i6fK
	 jBes4sdWRLfudpbb3sLKtTuoRUWFByjM9DQa3c4y6O2TuLwuQWJ2Hc5daGejo+RPUIvlH
	 pYnycnIPjfg0aNFJlpPhzLc3ATX75D2tWig5GLJN5GFiweqMXjaRlezyrLYgTWmJOsq3+
	 mnB/3zAUGfrtAjKOFEpSEgvoSaRqGVI5B/jL6PJfS5mxsZKVht75T2E/JRWe3SmLtqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=QrPap46ytWVKYSj0iI7Hoj6ISMs6lq3pSRcSmymoflg=;
	b=a9XZVTNqBXK/OxMbDUYHwpx2F7dt9NQJReyRwKS069uzpLxDGPYvLb0WwLkkr/ZyPLuw
	 IW18nfFs3N6Bf/Vyl1LeBoRb0CHg3ScA2ABGoALjWfX4Rrq3FTf9mLZdScsulUvaLY6DG
	 Zk1H2ib9eunIOKDn7gEnwXW68Swo2zcP3lbgCxwqR2Jw1+1kbqUf8UF0vf02chA0ZycgS
	 8ABcNXYCS7i18gah7BDVIr+IKLNW+qjn+6kfe3kPPhE4GqvHyc1ga2sLo+r57Bvr4vii/
	 W/+X5GKVfUpJC1MxJbdpyy97KKTz0vteQ/YkfPiYGun7X10IF5yPBwGf4CplGSQNAKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TZ3dngEq;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B577E606A31B
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 10:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B577E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TZ3dngEq
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1d2ec9aadso39185e9.1
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 03:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792580245; x=1793185045; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QrPap46ytWVKYSj0iI7Hoj6ISMs6lq3pSRcSmymoflg=;
        b=TZ3dngEqSRqtqyybjJV8ziaiOG5Z22rso1NwOXhNsDsoeFAcTfdRYXElB9PSlWWYmK
         Ca3YnU1lDk2DVt0g9+ITKcK5UXkG/Pgd5og8k9YUnMYRaR7hFKT1yGXG7l+CjkI0vrIy
         3kjrQFWQHHJ8erOb/Zi1EPLmirrnvj3JsWpuRYFzJWyDMKFOdo98kYYDytyElTojBho5
         ktkVJn5WnZpYEy0Yj6NIjMNW4mRbYeTUky8s4ieRNKXJFmDtJgUmVnqJ/Ivk6dcdyNe3
         ItE8dIVclO2RKB0gnrfbCb+j19mz5drpFW+uTpIUnfyXsvH3c3XyoWBpEnx3hLmKllQy
         6W+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580245; x=1793185045;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QrPap46ytWVKYSj0iI7Hoj6ISMs6lq3pSRcSmymoflg=;
        b=zZ4G+1Sc35RZnt6PP+ayWwfdKYuv9+TOgpMK5mFBVXlFlaBxG9+dVnyv2am29FeejN
         QN55AmpPL5FfpCHSr7T9UztaM3cP4N7WlvLxA8/qm32hrxxmSUAdGIi9UnC5pGzi6hfv
         dDiszobZ0W2IOGAftRI7X2PlkRHU941SbaIN/ClOX6o9Yd+cXmHPGnM2YMGQ+i97wRig
         9YwDwVhnCXDUPJQAf9tbn+j5vhvdeltSWfbBq+mEpfkd2XJOgzJ4R0I9CF+75dvwgZgG
         Pwsq0FZ+tgwKkXE5MUNlc9Vs8fQLt1EuNnk75W8FXSzT1wBOmR6Zt8oZwZdx57h06wKs
         4DAQ==
X-Gm-Message-State: AFq9FYJmCR0JpI6vK8fYmmNx03vnOAO36n+ePPmcxjw71CIe9rfurYp8
	pKOINLpeI8MLOnbkyx0aHJKLrnTmHC2clkeEbW27o5+uQ75omdzaxey28Fc0XE1I7Q==
X-Gm-Gg: AYBFou2/1T8LSiq96Nb/3UpZhGDhbA0xAQ/VUF0ckryzbCjGN7XKzGeWeg5ksHOqoy7
	34vwhPN4eaX6joa2ejysTDyy9p4oE1r9RBVW6UrXYiHelQAokt1YpAGVCFiXYhMhDyWBYpqoJIC
	nWbQYRue47HUw14ex5wsk1YKbP3jDhYFVhdD+8XSxUW8G4OwYMvBMcSgjCO1HooNMRZZmH7vq6C
	W4v5/cGxPmuxcCHceoOj7yzFGBqEvtuIjnK+I3Zo8Z4CItcTlNinxl0Creua+MfB5KD41OD20Jh
	FfqAtSXMaRGJQOY/Fx/bxRk85NUdUJBXtuG/jeR03vj1Hdyu7ILatOYwtZx1jkLtdCi9F1Fp8vn
	7yw0GWQpyQ0c1dHXhdlhTesJXWp9vnAFbxPIQmgEusO2KK3JXv5mLODpsTMXrl2xzwIuD6sZzJ1
	3frFL0F/4rhxO+dZbTJl4Irb9YlrgiDKMnB0cDvxRFoVASejZ/6XzZMWfQ8p7GX22kcy30Qa5ou
	52uuQJEc6jz2BT0CpwfQiUW0wXEIgjsS6AyqKiAAOmyZzq55g/LzmZGDPrvyPNLr5YzsfFbSu4C
	KKPt4nvGJMg99SlsI35D+o8MNGt0/KxRy9y2kUrbhvwt
X-Received: by 2002:a05:600c:a3a5:b0:4a1:a48c:17eb with SMTP id 5b1f17b1804b1-4a1f59a5836mr1496985e9.11.1792580244647;
        Wed, 21 Oct 2026 03:57:24 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f8016c93sm104658535e9.5.2026.10.21.03.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:57:23 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:57:20 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Wei Liu <wei.liu@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mukesh Rathor <mukeshrathor@microsoft.com>,
	John Starks <John.Starks@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH RFC 1/9] iommu: Introduce external attach domain type
Message-ID: <atiakDqtuED2cTM5@google.com>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>

On Fri, Sep 25, 2026 at 12:07:34PM -0700, Jacob Pan wrote:
> Add IOMMU_DOMAIN_EXTERNAL for externally managed domains that move or
> attach devices to another VM address space provisioned by an external
> owner, such as a type 1 hypervisor.
> 
> This is not a paging domain and is not sysfs-selectable as a default
> domain type. It requires external owner context, such as a vIOMMU.
> 

Can't we use a IOMMU_DOMAIN_BLOCKED domain for that, AFAIU, the host never
inserts any mapping?

Thanks,
Mostafa

> PV IOMMU drivers are expected to use it when moving a device to a guest
> VM with an already-created S2 IOPT.
> 
> Assisted-by: GPT-5.6 Sol
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/iommu/iommu.c | 2 ++
>  include/linux/iommu.h | 9 +++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cd1bca7ede9a..d0bd3ef00379 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -220,6 +220,8 @@ static const char *iommu_domain_type_str(unsigned int t)
>  		return "Translated";
>  	case IOMMU_DOMAIN_PLATFORM:
>  		return "Platform";
> +	case IOMMU_DOMAIN_EXTERNAL:
> +		return "External";
>  	default:
>  		return "Unknown";
>  	}
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ac43b8b93f14..ede77b90f0fd 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -188,6 +188,7 @@ enum iommu_domain_cookie_type {
>  
>  #define __IOMMU_DOMAIN_NESTED	(1U << 6)  /* User-managed address space nested
>  					      on a stage-2 translation        */
> +#define __IOMMU_DOMAIN_EXTERNAL	(1U << 7)  /* Externally managed translation */
>  
>  #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
>  /*
> @@ -207,6 +208,13 @@ enum iommu_domain_cookie_type {
>   *				  represented by mm_struct's.
>   *	IOMMU_DOMAIN_PLATFORM	- Legacy domain for drivers that do their own
>   *				  dma_api stuff. Do not use in new drivers.
> + *	IOMMU_DOMAIN_EXTERNAL	- Externally managed domain for moving/attaching
> + *				  devices to another VM address space
> + *				  provisioned by the external owner, such as
> + *				  a type 1 hypervisor. This is not a
> + *				  sysfs-selectable default domain type; it
> + *				  requires external owner context such as a
> + *				  vIOMMU.
>   */
>  #define IOMMU_DOMAIN_BLOCKED	(0U)
>  #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
> @@ -219,6 +227,7 @@ enum iommu_domain_cookie_type {
>  #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
>  #define IOMMU_DOMAIN_PLATFORM	(__IOMMU_DOMAIN_PLATFORM)
>  #define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
> +#define IOMMU_DOMAIN_EXTERNAL	(__IOMMU_DOMAIN_EXTERNAL)
>  
>  struct iommu_domain {
>  	unsigned type;
> -- 
> 2.43.0
> 
> 
