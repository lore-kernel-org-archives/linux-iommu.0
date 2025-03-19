Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64A3222575
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742427590; cv=none; b=PNPuqKWhZM11Tj60iqxC0GbRHZxnP2h7p0bTTWBUTmylkrA3pKnN6nuZ4RTfJXo+WeO1cEMcVNuM2mXujfOrtPyb5yDi6XyIPNodxrzJb1HHfDaLT135DlYoiCWTjbGhWLx9OetE5nwexm2zwJhtjrB0ws0uOmVKpXcuy/Sbq4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742427590; c=relaxed/simple;
	bh=Qp0wIcZ6apEfZg4GuuBubt8w+xLe+et7yRvcV9+Fct0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqT0SiK0pTSDKwx1DBQP5cyUf0qvpa+LmHGDIJqOG6cR2gKdUPml1MtLmRj2rmjyC7qYCj7xrbn5d9gcl97MqykMSwZ26HnV5+CD+5JqK3H56fxBs5I+fqim8+9HoGgJh7QCWkVoM/muQhb8JQvOucwb86dozmDYpeoN1FQUG5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dc5H01xS; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dc5H01xS"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47663aeff1bso2531611cf.0
        for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 16:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742427587; x=1743032387; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RzAx7zrshxa9otOXRhlSkfMjSVGU/IxrZ5CXiIP9CSA=;
        b=dc5H01xS/lns0iuSYKN9zVtG1p9zITrovNuxdav5lPM865X0hQ/0gHplF7sdw38DEc
         N1fFJYxaKxHwGS9F//A6dsTaOEdfUw39vAPiAQqHsZZGhv+YXbGKbcZ3ll844nHcUCur
         FaA7Wk+5cDJvY/qHFuj6K8z5kdNeX9VY9ptS8QLqZwATbuLtJ3ZjLUR53JW6vkkjOgiO
         xvEQabhSsD61Nys171qhMjQaS+alaO9eUYXmjymGapi8eN+eptzAef0gzy+NRzMmZ5v/
         35jQNRXDMlrwZSvX2Wtfy5I/brjxE/l3aqt9uGEQOnNkfeidq2eOsClsuKAZAEmICfrL
         capQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742427587; x=1743032387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzAx7zrshxa9otOXRhlSkfMjSVGU/IxrZ5CXiIP9CSA=;
        b=fLCdtKrN+Bpl4UBB8yLCPYLAD3ymoM861uwBH2kUUTov/6bOs2kpTBNW+k95HlGSbc
         lVM3s3JijLgdQsjGqDiaT6DD4HwYOHJ3oksV3/0bKzpuJ1f7AdW/wWiNwlmF4N5Kw8LG
         zHo/lehfmTEoZr5vM6xHUvyHaGgpzHNIwI38fVTRvk+BiW4kLe70HxbcZYn62kyHBv9H
         CFyXkuvvyiSR37L8fJ9LvLoZN/xt//u5qWsHLqtIvDa7JAnUFVHwdU6/ZVME4TMm0Quo
         ycHG1dD7B8/eapuLA/wSOY3sm0vJhCQuavvOE8u1v7WrMqWLujF/Hbb8XbKMcM/0o+U+
         5arg==
X-Forwarded-Encrypted: i=1; AJvYcCW2R4Bp9T/fNnqQZdxJ96RdZKmf/XCOduPC0PxEDHWM7hz5maEcUHwzEfm+x4XSGjJaLhUlVw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4n/KXp8o7EnJ6FM3LpGVjqbXgVyAq61QokDNb0kx5vBh0ckQQ
	zSQTi/zr/aArnZJEsIif9GxTtqG8BdZBb8irEpaOgXM9KgjLq27jgVTuzkPffJM=
X-Gm-Gg: ASbGncuobh1VhuUjpfUFHKdyjotLGle0+vi/q0v4Mg8rXUEb4zILdR3t2nArnT2EZox
	0XNeDPFTYS2eTrLbaJEetX6um+TIdxHhWL+UCZ+nn+7KLO4QNDXWk3KBQQHjbR/6KgGche3GWhc
	hG7DoFmDkRnrC48mnXBCgoq8KjUN64FixxospM1W0JWtkJPgY65qmx/9OeP86LlPMBYBqUzIET7
	dDXoyJ49pwIoUdmVsWICusoiwIRM+Ay2Fdb1MV3t+n/M1/31lTx1288RBE6OR4EPrHjHA4Hdrur
	S+4AKu7UCtdY0NCs6u0d4dlpuC8bRciUalkOtCvmYTQlh23v4YhTSiNiYxnODe5AHg02Z6GJVo1
	+1LiXcJC8lTfsbufjBw==
X-Google-Smtp-Source: AGHT+IF9kl9P6XYnhoEMvEZ3lKapz4eUtSUPO4gWdTGr+ps6RPA96Wz7D0zijkf/bw2551v0mV3avg==
X-Received: by 2002:a05:622a:418f:b0:476:7b0b:3110 with SMTP id d75a77b69052e-4770831f8f5mr94450601cf.20.1742427587653;
        Wed, 19 Mar 2025 16:39:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb82bf6bsm85415621cf.78.2025.03.19.16.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 16:39:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tv30k-00000000clb-27LO;
	Wed, 19 Mar 2025 20:39:46 -0300
Date: Wed, 19 Mar 2025 20:39:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
	kevin.tian@intel.com, alex.williamson@redhat.com, maz@kernel.org,
	oliver.upton@linux.dev, will@kernel.org, robin.murphy@arm.com,
	nicolinc@nvidia.com, jean-philippe@linaro.org,
	jonathan.cameron@huawei.com
Subject: Re: [RFC PATCH v3 4/5] iommu/arm-smmu-v3-iommufd: Use KVM VMID for
 s2 stage
Message-ID: <20250319233946.GF126678@ziepe.ca>
References: <20250319173202.78988-1-shameerali.kolothum.thodi@huawei.com>
 <20250319173202.78988-5-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319173202.78988-5-shameerali.kolothum.thodi@huawei.com>

On Wed, Mar 19, 2025 at 05:32:01PM +0000, Shameer Kolothum wrote:
> +static int arm_vsmmu_alloc_vmid(struct arm_smmu_device *smmu, struct kvm *kvm,
> +				bool *kvm_used)
> +{
> +#ifdef CONFIG_KVM
> +	/*
> +	 * There can only be one allocator for VMIDs active at once. If BTM is
> +	 * turned on then KVM's allocator always supplies the VMID, and the
> +	 * VMID is matched by CPU invalidation of the KVM S2. Right now there
> +	 * is no API to get an unused VMID from KVM so this also means BTM systems
> +	 * cannot support S2 without an associated KVM.
> +	 */
> +	if ((smmu->features & ARM_SMMU_FEAT_BTM)) {
> +		int vmid;
> +
> +		if (!kvm || !kvm_get_kvm_safe(kvm))
> +			return -EOPNOTSUPP;

Isn't kvm_get_kvm_safe() in modular KVM code most of the time? You can't
call it like this right?

Per my prior comments, I'm a little nervous to make drivers keep track
of this refcount instead of the core code but this does seem like it
could work..

I also think you should block using the S2 without a viommu & KVM in
BTM mode.. Maybe like this:

@@ -2938,8 +2938,16 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
                cdptr = arm_smmu_alloc_cd_ptr(master, IOMMU_NO_PASID);
                if (!cdptr)
                        return -ENOMEM;
-       } else if (arm_smmu_ssids_in_use(&master->cd_table))
-               return -EBUSY;
+       } else {
+               if (arm_smmu_ssids_in_use(&master->cd_table))
+                       return -EBUSY;
+               /*
+                * S2 cannot be used when BTM is turned on without a VIOMMU and
+                * VMID shared with KVM
+                */
+               if (smmu->features & ARM_SMMU_FEAT_BTM)
+                       return -EOPNOTSUPP;
+       }

That more closely matches how this will eventually work when the VMID
allocation is properly made to be local to the viommu.

Jason
