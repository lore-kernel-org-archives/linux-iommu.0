Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D278336B1D
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707482914; cv=none; b=mMKhKLkzLLZfmI/6U0CrvPoDQoRHJdiYp6DFkhMMZH+SWB8/N7hjg5mwdzII20IsBEyEqr40L2XQI26aQpZqDA7A3OE5WABFU4hbtR+4e0qtiBf7QIkjjY8uPscFC6dmsKjHtpOIuBsGOLRe9hif7MblWik64Px4VWBpSqExE4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707482914; c=relaxed/simple;
	bh=IM4q4X0gWydS60JSjkH5keOtJWJtq4G9Lb/U1VwXjTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tc351fQl3ugrHA/vSiVs8Aa08M5zHuTFUraZh+guSRsw05Z6naLXObtX2OZBF6mSjLS8sFjzxRsZyEoiz7jIOP/gzPSTpisdvkqvH+b8qGjTYWT/Ttf2eLaYJDkEUP4CKkaPGLYVDYAsPQfXdW5maAp27KEmyU1AIZmf6tLcxM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LdlnZS5+; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LdlnZS5+"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bba0ac2e88so1058798b6e.0
        for <iommu@lists.linux.dev>; Fri, 09 Feb 2024 04:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707482912; x=1708087712; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oWyRQWjZwGy5YBtNCBODdh66LwGl8ke0FcwUO1q6L1E=;
        b=LdlnZS5+NPv/mP7SW8g6g3a/cJTjULcdFEJKq12du4kXzs/YlAXHPnaedh/HSo9bKH
         yA0d+/NX4sntGx4pSaw7CkqsXVlyyURdeRFbHaghWy9LL3Z6Rr/QPEKiJNW43A0inMZi
         fSa9isrj+ibbddr4FpqsTVRTpaX2bLi/L8cqtxnPZp9ZiPHOCmloaPrF8NwOsPg3yIGE
         noUGJEeAb/wLYiVNB1iXo2lwZb0WLsdWisYiGWYBBeum4fzDM1Xui7vvM/WfPQlHM5Uj
         tMHYdU2be/NJNs9SAK2+0A+ZKAG8e9HmIW/NvZq6+/RQB8cbvbYcpK/8aLtM3DQkIhSJ
         HcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707482912; x=1708087712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWyRQWjZwGy5YBtNCBODdh66LwGl8ke0FcwUO1q6L1E=;
        b=H4qXR1tPJcLBDTgLDxUP5l3w07cqNKyjd24NusGw2BWX7iZlU1zPK+opcv25rXp/yO
         2xHFe4DlAa9s+4qahV301k2TcQ3pby2yZmHcShR36wX/IaDp9mO1NIsFCggEwceigobr
         ZFi0LsxgqJQxIvveCpFI6D+6ASNdBhVNLMg3he5JUg6/y8WYgLWuyZjvHNLNg8Psz1OB
         TBN4x18DvCuQvXmVUOhEm+C5e8mzUwTMeF1pXgC0RqPZXfqPADVoZ7iXK5lQ4z0cAHaY
         OdI/OqstC7M99VLAJYI40iPGNYeK4ifEixJiua5iP7ccyHWVb5C5hPRHqxANRUun7lhf
         hYAw==
X-Gm-Message-State: AOJu0YxkLTRbevze+awZiz/apuJu9SZx7tnCHkIFeO9ANdHNO2Lmvu2r
	mIJuiq1nd+aaGTKVJvU8AFeQ+bKK2hp1OJZ+yfUlErnAYh6aYl4I9unQ2SJ55Fc=
X-Google-Smtp-Source: AGHT+IHFPlR4wf7wjb3MRfreQQdqtvCuxiFKYBPPC7N+l8UE1yE7FNCdjopARBSlORizJZ/dGI5EsA==
X-Received: by 2002:a05:6808:3195:b0:3bf:dd9d:4d0b with SMTP id cd21-20020a056808319500b003bfdd9d4d0bmr355246oib.13.1707482911751;
        Fri, 09 Feb 2024 04:48:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPwYEyUGD5aRT/+w0MJnpXz3rN94HARHVlk6JNRzkywXVQSfZLnyU/tNbTEAaMu3uFRZYqYPUzQAR73/2ePL21LXFO7pg+BD3dqk9biXkOojEIrKijKC473yLZaKAhs+fSe5kYVud3vj9tB56m6xRoQCPvb+sWZYAIFGHA4HcIDZvRRdHt3cZ4P4jWu9Q7/HlKtpNcuULmsBXf3ua7KJpcGJfq1mqzdZH4w0JOpz/KYi6K8VPoNi2A0JaaQAD8C7vMwVP0sddq+yJRXIPfKlgztVEwePf2HGnh+fkArqZk/GNTpkNBXg+OLsqRN4T/woIaXN8ixU43ZHUatKaQBsZkYIsxKMCAmwiZahVEGNKitRU7+mflXn1+mpQ2AYAvfoEyrjLgoRiYc+60ft11Ir95y1Twdi4w
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id c1-20020a544e81000000b003bfbeb8035esm243981oiy.8.2024.02.09.04.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 04:48:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rYQIv-001zB2-Rs;
	Fri, 09 Feb 2024 08:48:29 -0400
Date: Fri, 9 Feb 2024 08:48:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
	kevin.tian@intel.com, alex.williamson@redhat.com, maz@kernel.org,
	oliver.upton@linux.dev, will@kernel.org, robin.murphy@arm.com,
	jonathan.cameron@huawei.com
Subject: Re: [RFC PATCH v2 0/7] iommu/arm-smmu-v3: Use pinned KVM VMID for
 stage 2
Message-ID: <20240209124829.GB31743@ziepe.ca>
References: <20240208151837.35068-1-shameerali.kolothum.thodi@huawei.com>
 <20240209115824.GA2922446@myrica>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209115824.GA2922446@myrica>

On Fri, Feb 09, 2024 at 11:58:24AM +0000, Jean-Philippe Brucker wrote:

> * Stage-1 TLB entries in the SMMU have a bit (ASET) saying "this entry
>   is private and does not participate in BTM", which we set for private
>   SMMU address spaces.
> 
>   Annoyingly, the stage-2 TLB entries do not have it. With BTM all VMIDs
>   are shared between CPU and SMMU.

Right, the spec justified this decision like this:

 Note: Arm expects that SMMU stage 2 address spaces are generally
 shared with their respective PE virtual machine stage 2
 configuration. If broadcast invalidation is required to be avoided
 for a particular SMMU stage 2 address space, Arm recommends that a
 hypervisor configures the STE with a VMID that is not allocated for
 virtual machine use on the PEs.

Which doesn't match how Linux works and I think after the recent KVM
PUCK call on this topic we can say it does not match how Linux will
work going into the future. Assuming the KVM S2 and IOMMU S2 are
shared is not true.

So unfortuntely this creates a waste as the BTM will generate
worthless invalidation workload on the related IOMMU S2. We cannot do
as the spec suggests to avoid broadcast invalidation here with a
unique VMID as that will break vSVA vBTM invalidation to the S1.

I do wonder how much of a performance negative this will create. At
least the S1 isn't flushed so perhaps the performace hit is
small.

Anyhow, I view it as a defect that the HW doesn't have a BTM ignore
bit at the S2 level so that we can use the same VMID to make vBTM work
but not participate in CPU originated invalidations for a non-shared
S2. A global bit to disable S2 BTM would have been fine for Linux.

>   - The old VFIO_TYPE1_NESTING_IOMMU lets userspace allocate a private
>     stage-2, and has only been used for testing as far as I know. I don't
>     think I ever found a program that used it in the wild, but haven't
>     checked recently.

There isn't, it is useless and cannot do anything. A patch has been
waiting to remove it for a while now, I've got it in my part 3 right
now.

>     It needs to be deprecated over a few releases (starting with a
>     warning maybe?),

No need, we just NOP'd it. It has no user visible side effect,
replacing the S2 with a S1 is fine.

>     and the replacement API shouldn't allow creating a
>     stage-2 without a KVM context.

See my remarks yesterday.

Jason
