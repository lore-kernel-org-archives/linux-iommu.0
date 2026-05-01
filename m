Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93F526C39E
	for <iommu@lists.linux.dev>; Fri,  1 May 2026 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777675384; cv=none; b=SGMUE0DfyHjjtceDdEGC70yeheJX9HIU+Ar0B95Kc4eCEyxY9fOl4HU9Mrvo9PdFwDB/8FNS2rlKS6dkHt6AJYBlBYEraWZsxaj7XrqllCNJKL+BV9CzbAowqRbgpnzBlqnwW74k1OjBbA+D7jgwhqXft7I1hq3PodsoUv6NxR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777675384; c=relaxed/simple;
	bh=zxY+FJ/D1qGJPLj7LmqjRlqbTv0Us5t8F//4LBJztq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0oWRYXpywzusvo8yOCsF76yA457IJ+OVzGWxLM5SYP9QMDLUPF5lqgCbmdg3PQ/tDZ3sIeQWr0p+5StkYZIMCHmdmAEmz1gzkYxQ7JMRuq2sFMYIigyu/vHZSR6FBps5bCmft9a70ZEY2Yj/cpAs4fpzn6x0hweKMbr9QOoKmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K1l9GWgP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1l9GWgP"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so2656191a91.0
        for <iommu@lists.linux.dev>; Fri, 01 May 2026 15:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777675382; x=1778280182; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zA7ZB+9cdr8jZzJkhetR/xMmU5JX5i8WCgvlAknX308=;
        b=K1l9GWgPkiphIIZKpELC4roOb172HdwiVH8ZLBGRKyg0+axHVPryY6vqN4rdn5nc3X
         sxTeox8EpEpE3Mn0tgYZ2MNOG2CW2u2mykazzSKz0Gb7RhDfT2x7UIWWv4Wf8f5W47mo
         thksOmfaobZrgrWfuWZpH3O99K3UCo7QYt+qrrzpKJ3Igo2aa7fe9nWCJoVBlfImJOIi
         ERMmbxOzSFr8EOh6nOx4RhVe8yzmz49TocQw/IMT/2kov12Yvau9IzQSRKdlJZWrc//Z
         flrhdp/aHU1mWMg/Ew4KvCemJ0qEQWGrD5tx7QCnLXq3jmviOkC5u3RivHfgM4eaBJ59
         Vlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777675382; x=1778280182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zA7ZB+9cdr8jZzJkhetR/xMmU5JX5i8WCgvlAknX308=;
        b=Z+7PpPvvqiWruJE/5f4WMP96kM5dZB50wvaD4qbYRFCeMumd4bqMUY5ijLjYqAPyRK
         cc70xvuAgt7+ltZQuC/b45XcGv12ouEikTCPz4+AOhLhJGsCoGEoFCtTqcE1t9HTXbLC
         l4W0id7TshjFjY6lE26sy8FKDeeEkvPVzRgPKJqJGbmAwLVJl5WHTJ7yl/EeyGAwTuWs
         5olAlduP6+NjLwLLb0PJ7WNd3OyWdDyAt60VGgBl+eefqn4Mig1E+LWVxTmfqfiG9cNy
         PVjAsCn1gT5pw8p/tY14nJdASR94dZcBNmoVB4CeaZXlAUXDaEzNBI7ZKbs1VBfQBVYE
         fOWg==
X-Forwarded-Encrypted: i=1; AFNElJ9FMpZvWEoaYfBOIPK5d8RV+iLBbQP4kHS+VOpyJBhHF+h62MueXqqjCtsSO1mwu6mGmfKlnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yya8ENtdrOsYaHVPeYxWONwFYOE1EbS6muVBulU1zZpBwW3lc/Q
	cQXfHDEUIr7OZXM30lNCh6jm1gEPIUTVl32McBssSyNW/BI7oW85GIT/g8smbB2zqg==
X-Gm-Gg: AeBDietW0iar4CW+cyHnYlPGUSnl/JdgjLjNIsbChk4T5fWTI8ZLJYBNtcfzpPCI4wN
	XvP2GTu5trcS4gYUi4fSqzxx+sPNr/OcSb7MDRukYgqa++I58GS2XXkrJtbXCD5AR/Hi1Ms2MGb
	RDptodERQCm2Qsqmc4JqPzE5k08WmN3FFee1/d89jtCJlYbfW1aWRAXp5jf5J0oly5MNnsyGaxr
	A7H2e6VZzkNqW59ZwQQkMkTNLp+7RJhfy0XVHIH/1m487HRoePcczl5i2dbA9ukzbZgF3kB+gFo
	LcG2EB07Vp6iBI47ZKn3gO86tGi3X2o95IaAlAyyuVUmOzuZxf04SUq8ZUHP1PPji3YD5d59Z0W
	1kK7BzlkmfyLeHVF/ZjL1f9aSijohArk8s1TM6JRoaRG/uv94fHq6F+fIdlDHUZAEnEa0ghSGY6
	WOKblpIh9A9Z7ksDPiuniW2BfeazxoHshO+9NCEJGwIVNQa07tDW5+Euj/k6ZFPQov+zXN543ml
	QR3bg==
X-Received: by 2002:a17:90b:3852:b0:35e:30bc:96e2 with SMTP id 98e67ed59e1d1-3650cdd40cfmr981966a91.10.1777675381854;
        Fri, 01 May 2026 15:43:01 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364f3fc1714sm1322177a91.2.2026.05.01.15.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 15:43:01 -0700 (PDT)
Date: Fri, 1 May 2026 22:42:57 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 04/16] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <afUscSeXKnNAJ0ZF@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-5-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-5-skhawaja@google.com>

On 2026-04-27 05:56 PM, Samiullah Khawaja wrote:
> Add IOMMU ops to preserve/unpreserve a device. These can be implemented

Can you make this comment more specific about what is being preserved?
Saying it preserves a device is vague and maybe even misleading. It's
more about  about preserving a device's attachment to a specific domain
correct?

> by the IOMMU drivers that support preservation of devices that have
> their IOMMU domains preserved. During device preservation the state of
> the associated IOMMU is also preserved as dependency.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index f71f14518248..765d042e22e3 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c

> +static struct iommu_device_ser *alloc_iommu_device_ser(struct iommu_flb_obj *flb)

It is unforunate that struct iommu_device_ser has nothing to do with
struct iommu_device. The former represents an a PCI device, while the
latter represents an IOMMU.

> diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
> index 6019cfc27428..279c7ab04f09 100644
> --- a/include/linux/iommu-liveupdate.h
> +++ b/include/linux/iommu-liveupdate.h

>  int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser);
>  void iommu_domain_unpreserve(struct iommu_domain *domain);
> +int iommu_preserve_device(struct iommu_domain *domain,
> +			  struct device *dev, u64 *preserved_state);
> +void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev);

The naming scheme is inconsistent... Maybe it can be:

  iommu_preserve_domain()
  iommu_unpreserve_domain()
  iommu_preserve_device() or iommu_preserve_device_attachment()
  iommu_unpreserve_device() or iommu_unpreserve_device_attachment()

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 3853a3946733..1c424b32c5fc 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h

> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	int (*preserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
> +	void (*unpreserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
> +	int (*preserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
> +	void (*unpreserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
> +#endif

Maybe we can make these names a little more specific:

  preserve_device_attachment()
  unpreserve_device_attachment()
  preserve_iommu()
  unpreserve_iommu()

?
