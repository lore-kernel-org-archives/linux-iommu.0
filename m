Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F119B363097
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294253; cv=none; b=tNm7cbEFErM8A8w1PkdxAcK06+BJv0vV1kMo4lMXv0t9X/NxODh2qcUyiVaxTy7SyZM4bO6YSphHCVMpq/Ze0Jb54wFPxOoOGYdj5mF/MZuadqmYdXHJn2c3dqF1Pof8JCRjxCjqi4LC1n6ch7ii55f0ht+5h6+49IX7KzSeKvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294253; c=relaxed/simple;
	bh=yH95AfxzT/+D60H+ywAWLG6d24H32sb2arUyyKK1J+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWo3bgVCNhdGwwt13o/Ho8MIOfLKOR43ajN6i1O2OLCv7e480s9GB9Tq5jJZL9yIrDNYZ+tvBrdHbyZ8qK2sefBI2EITeodkid9v2l6ooZdxWxFSVzMRnKkklUzJNw1oEicacdbq677ZfSkyKLJ99dBoFK3UHz9JigehCstWBPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HJEj8bUQ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJEj8bUQ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b46da8c48eso95ad.1
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779294251; x=1779899051; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ju9p5eoCrFSkfcsgNxlnvpqY2cZIwhwQVw4yR1FEmcE=;
        b=HJEj8bUQDUvciFChz9vqUTpMO2eaocs5DKNHM+EAyKbbgI/GoZEC1Vfwt0nI0YR2MK
         1AsNs1kajdst3e7/Amb6vf5wWYNFspCkwyh1MERVzjIZPQKCuft0mKuLAO5A4Mt0aXaJ
         LxVfvlK+xyo6pIRCznYLOHmqP644UzSS/ZGCzmlza/SbcbQ6xSbEpl7HDVaQYvyU6xCO
         OE4KypNyZrkqsU0G8PWMaMATIMBzIzzxe9VWT8SsTAcE/zET3Af3U1ml/mobHAk7MWCF
         w9bPqe1t+7Wy12VWAnADXbK1TJra/7cIiY5AK+zdj7y/qMVZaRQXK00Tf+vgL9s9OGNe
         3xiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779294251; x=1779899051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ju9p5eoCrFSkfcsgNxlnvpqY2cZIwhwQVw4yR1FEmcE=;
        b=OJfuUzzlIsaLmUw0bns7xzQY78LAv1d75dN7B0SScfRvfKB/p7kDc2zEpP/xX8ZESx
         nae9Ozsb9tV1a2l16jsn4OS8TMfQEAkYm8DBA+hUvW82OFFpXhBsOtzufaXQSM+JXgYY
         39EYuHouG8V1DvpvvTrJMAQeF9zuVeDT0OCug3FNV/6f83X4lC6v54qGE9Wm226Jfxha
         +1QYUlbaFcZytfRPTnnKNHeT6K05+M0czpcfd8QvUcMNVCSJju+EWJ0Ouj8JpJ2tl8X6
         3ujF/kiPgEH1BLqVi37UUMvRQAWbmrpeWKgW8jFR5dEjzpJjSb7SwYmscuIy4f/8SpZL
         3kHQ==
X-Gm-Message-State: AOJu0YxwlIruRJJ1YWLY0xiqYJzPUDbuualyW9KG+Ht3oNPdcrsa7etW
	m2FjQg04bNJfMhJmjlhhArn8rYrEJM3vrXI7ZwF9hrifpleEC/90xKs9OMjTfyIEtg==
X-Gm-Gg: Acq92OFJRJZmnuB5obyDVaU0c5H/76FErgjmsG0qIKnro5W5H8qWRPLGfxduHr5SoVf
	gMX0WJDLiUYGtl9FXsjRJyfH3+Rab0lR84O8F7phzaVEiFhBq8nBwyyHn93iaxc5Qf8I+9S7jY3
	PTD1gntubB4aIZYt1nxOKVZHx6Vp2UyUHEFdcaWw2Y/0Ay5fP2hHTkFMKNDbJWFVR1DDSpE74cj
	THmk+0qiF8fIj0FP1yaG1WSs7iNQ1OnFDSlxDLLJXAFHmR6fIENpTbw5rfdNcNNTIZiyqOzijAa
	ElglOXNwzTx5x1mA/jUp/Cq9HznaHhdQFQsfUaFFqZxQnkG7b70lNqo3bxNqm01BcAWixwTPXjP
	iIYFizLau7BETloeQyaGOUZgxp5sbIwKa+trcYn6L/ffdBcg8fP5qGEuvh5jRYJA/jFHc3g7ZoP
	tAQSReNRCwIrIqfuKWL7by/JfZfS4GG922GbMb8DmUS389UeIHHf6K4BaHtRHN6r01YiVd
X-Received: by 2002:a17:903:3205:b0:2b0:5193:1212 with SMTP id d9443c01a7336-2bdb03a2d06mr8986155ad.4.1779294250730;
        Wed, 20 May 2026 09:24:10 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb114c08sm21188897a12.23.2026.05.20.09.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:24:10 -0700 (PDT)
Date: Wed, 20 May 2026 16:24:04 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Fix ATS state tracking via
 ats_prepared gate
Message-ID: <ag3gJLtY1jnT17Zv@google.com>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
 <20260519145947.GK7702@ziepe.ca>
 <ag3EL10WAIImL9XR@google.com>
 <20260520145142.GU7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520145142.GU7702@ziepe.ca>

On Wed, May 20, 2026 at 11:51:42AM -0300, Jason Gunthorpe wrote:
> On Wed, May 20, 2026 at 02:24:47PM +0000, Pranjal Shrivastava wrote:
> 
> > However, I'm thinking what's the right thing to do if pci_enable_ats() 
> > fails in attach_commit():
> > 
> > 1. Fail to attach but unmerging the invs_array entry is complicated.
> 
> Is it? We should be able to keep the the original invs and not free
> it, just put the pointer back?

Reverting the invs pointer itself is straightforward, but IIUC the 
current implementation of arm_smmu_install_new_domain_invs() is a
destructive update as it calls kfree_rcu() on the old list immediately
after the swap.

Although, I guess we could refactor the RCU lifecycle to defer the 
kfree_rcu until after pci_enable_ats() succeeds in the commit phase?

> 
> > 2. Move the pci_enable_ats() to attach_prepare()
> 
> IIRC ATS cannot be enabled until the invs are loaded with ATS
> invalidations, hence the issue.

Ahh, right.
> 
> So you'd put the new invs list, turn on ATS, if it fails restore the
> invs list back to what it was and RCU free the new one(s).

I guess we'll have to to do the following:

1. Defer kfree_rcu of the old invs until attach_commit succeeds.
2. Implement a roll-back (writing the old STE/CD back) on enable failiure

Thanks,
Praan
