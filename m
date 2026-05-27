Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC3E44CAEC
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901877; cv=none; b=eGCBauA2HPCSo72BgqHMt/18ZF3qAxVujS6QgqGdX81zgUBZYRcrtRQjDkKHwCQcZbbVnSQSI697sCu9MMPnQwUUnZ92lsO0ZabTxIz0qz2jDnoRgP7XfI1ddPnMe/WNiXSS55SJWI4CLATSMi+RMLXSVqdUxYqrfrBfG9I+fZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901877; c=relaxed/simple;
	bh=5dhYnTz29zgsmBRPPybd5CWIS+uX9bZsxkT+ovNyCbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQWfaHQUoFJewwq6JOzL3CLIOWCGUhDLg1QG4mESjj+wykgsDOC2tlEAyodj8zdjsmMa53ojqWDOm5q0xH89LniTi8FHi+EdL+uOekTca+FU72rLHb6dQ41odtxwX7e6UeDL8NjxNCa/XaPBJ3ioQ4k6+EFy8WtBddipX7/1Ew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C2rb0WuJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2rb0WuJ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba180a022dso415ad.1
        for <iommu@lists.linux.dev>; Wed, 27 May 2026 10:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779901876; x=1780506676; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvAhvfUYiK9fAI1qqXG1UgLn6BZJB8NhaqamtOZNNLY=;
        b=C2rb0WuJQacVSXvySl4YsXwqzCnWpClepYjdx8XkFfg5sa5ocpxjICd+VXl4t+mt1c
         5/9zYqxUxUiSNM8OJ2BdifeRIxr74XC4bZcNmoydpbORpMehT00cZNnRLFFX8ZSybASF
         5IZQrPDzL6lZz5xGaNeb1ecAaZLkzBJuLCIcXPEmeTPDgrVi9+ONDhpt8OaJ04gngbE7
         4PRd/hMc0P8SKub+yyYTaMzVKcbOoB9mSQhY+Xblyp1eJnTPKtOHZLVWDc2saD2aV0BF
         9JM9adnTyFTx3KapcZamTfL4R3Hstp6sohszqvtJKoDKRiEZZ8UmraeEMqEw5QdBFT+Y
         t7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901876; x=1780506676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvAhvfUYiK9fAI1qqXG1UgLn6BZJB8NhaqamtOZNNLY=;
        b=X5ixXPR2R0LbAcev0XKPr2C/zNdDXHlLyO/dPrHIFy1vR5kfyuoIABshj8syauIuuW
         qCJT3dfpKddJQUYfXHxlDXJ96Da6g9R+poZc6NazBsb00hPU8f7sharoZEU+OZ91+CeM
         I8b+F9AAVkvnGviXSirQm1ytFNtv797tbWG489FPv+1a0zJ362GEGBKC6RDcUxvbmpuF
         DbmVhi2SQCElq8+m0IBkkJT10vOA/kaArLMl775l4i1Q1RKc+lRmv43JXYpAHdXrG0Cw
         Hw4qWP+eSQlDLyaLLqrUgJmWvEEoxAmlHH6Ki+TLf5pLZQbc79E4FbXAi17uXK0P5Rs7
         pMNA==
X-Forwarded-Encrypted: i=1; AFNElJ/5PWZRCgVNvbSFpdN4JMHHImaYtJH7k0gMfTd34d3qiBQM0v2Nqi5ecJbKijuTfsS/tpcfJg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2opRNUc9KNbfF1eDGfC6hNHNpmlinjNTJod+Nu8sZXaGq2aoW
	Rc9i3YAF3DVazyCCQ0rMN2mRi9vFiWhSn2/ZfIYbX3MAaiMoTIy1cQ1G3BUsZxyhJg==
X-Gm-Gg: Acq92OH9vIiIzExVgPxHK+MWy85a5+Xz5NvbdV869wI78Qex2uqTjuW3g5yU5CU60Yj
	GPevcGo8xjdUh5LBXfzSOBo1BNeQni4FBYRm+2jM3Y6Kpj3K6HWJQNzZZ2VXjxorTIl2ZFARbII
	5u3sDpJEybQneIkps3qYltI5XH9GhNVvh5H7Gz+KVQUNL7UWDn58Q7rxj2Kbg+O98CFoyf7vlJK
	K2FICTZFOgAwZex0izoj1J4zdmfghHVZeEPaR1mSN8XFPu3Bb3E2oEvIj66uMi1ZJvNIzx24cT7
	Falfl+ldOI8pVPPd3ABFiizFSJdN/ZwoifMBOs6YQQFGqK31zSmdyql8Rh8YZcpgpLN2jTefVzk
	B9hUBiSpNWjIL7yUW/g3PMlokXYsupP5jgdVv9x34uuhCeNXASL9pQ3wXeRyCz0CN9JZryAovo4
	iS70QF2zhlw10pG30oEckEV1t+cvlKURGvKXbw9i6luytktB0r313nqvAcd4LLdTezDpU/3A==
X-Received: by 2002:a17:902:cf11:b0:2bd:7bec:f0e6 with SMTP id d9443c01a7336-2bec116b716mr9444575ad.1.1779901875118;
        Wed, 27 May 2026 10:11:15 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5900b8bsm155801785ad.76.2026.05.27.10.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:11:14 -0700 (PDT)
Date: Wed, 27 May 2026 17:11:10 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 06/16] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <ahclK4Pky0huLpoJ@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-7-skhawaja@google.com>
 <20260523133357.GH7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260523133357.GH7702@ziepe.ca>

On Sat, May 23, 2026 at 10:33:57AM -0300, Jason Gunthorpe wrote:
>On Mon, Apr 27, 2026 at 05:56:23PM +0000, Samiullah Khawaja wrote:
>> @@ -266,12 +273,22 @@ struct pt_iommu_cfg {
>>  	};                              \
>>  	IOMMU_PROTOTYPES(fmt)
>>
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +#define IOMMU_PT_LIVEUPDATE_OPS(fmt)			\
>> +	, .preserve = &pt_iommu_##fmt##_preserve,	\
>> +	.unpreserve = &pt_iommu_##fmt##_unpreserve,	\
>> +	.restore = &pt_iommu_##fmt##_restore
>> +#else
>> +#define IOMMU_PT_LIVEUPDATE_OPS(fmt)
>> +#endif
>
>Don't do it like this at all, new iommupt unique ops should be routed
>through struct pt_iommu_ops
>
>See how map_range/unmap_range now work

Ah yes. That also looks much cleaner. I will update this.
>
>Jason

Sami
