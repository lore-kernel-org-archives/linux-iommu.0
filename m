Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792765752;
	b=tag7UO/g/pzfyvWxo0UXEPAKD/cnTHMDAqXkZlHRBFsldiTiBP8v0yv03161wgfGIWxT
	 3v/Hm7UEF7c2izz2fBDEswbn66hAo063vToyxMDceMZTFhktHZT+qFn7cZHr0G9fe+Jwx
	 01p4MSedS7m/YKnegD0r0tR1gkQ0Zoip9ETsewa/SVbd3DCw7M6TZaFQbDUDhvTQMqdcl
	 yzUfbm1pBHJEwSnJq1yccwEPxZHSTjVu/dmP1dxqjFQfP3ZL8W0FxD/OQ7loa7W01cJg5
	 yXtmv0nbXc0UV0Zmq+yrMuHpxIYNZFggfFvGOttN1DiZYg66FKms0rbAtk1oyxGHvxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=MtqXElKTNCKa651mdJkZvNuV+haZHv7iacPGuZotGd8=;
	b=ER1xB6Drbh7q2MzcVGVab+D1iCVl1OyRIL3bRvx5kIH6/Gzn9a7uosDKj4gap2VHWxQk
	 wDriCBKKGCHijyPDqjeHjDeM4y3AsevcM3yeSL68yb7u2vwpsrKEuQ2sEZ5537hEHGUBr
	 vlfGK8/2YPipD7jlKhw7w80RqQXJ0X+xERjog1WM/WMX9lxmw+YnL9VY0Ni+TrRqqiySj
	 pjbDsNdLcrpbhJmzY4O8aBQNpDWxxsPZbv4zHt1gKJXOex0VfKbvenNmnWMzBdw+kZN5Y
	 M7ZbDL0+FJfZTbXqEimaNgKbEsoJUc9duG+k/W3n2XGOBC6GWGoXKItcn5BQQ/vnlhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=afq1ppiQ;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE22606A31B
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 14:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AE22606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=afq1ppiQ
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f20c3aaa5so78481885a.2
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792765751; x=1793370551; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MtqXElKTNCKa651mdJkZvNuV+haZHv7iacPGuZotGd8=;
        b=afq1ppiQW2W6+xevs5LG9wVkfWcWITrtMtXu52Ofp6MwNYNpVmNaXK9J6tv8WiWr4y
         Pg+EsDzK+kZks+BHJTJNuaHByL1tBNCjJOhhV2Q6iAA5CY/3B+v8cMtt0zSGkR3cVAbf
         ZsMEKAx38P3CEud8l75TzipFikNbNozNQh7L9pJYOd3/QBkPpuDU6H6I47hyzmkJeVsf
         nhXL6VlF1FQlbUlgZ0alHIz+2cC9/JcktXcvhynuy2N/pamVjlwaI1nq6luJNJc+Bnjz
         gaqXiBxpuzysxyDkkADkQutlJ8ZK0Zgy0CLt/3Hzv89oBlziqbDDERAmyI222Akt3Hwr
         lFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792765751; x=1793370551;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MtqXElKTNCKa651mdJkZvNuV+haZHv7iacPGuZotGd8=;
        b=yxo4oHeqapKHDPOiajITqSpDgjXYJGC6aRMQwvgv5E0MppZgOntYIS5rq8uUqXt1nR
         eL86CsTmtYA/THnjo+4Sji5ufkVIbdilJQByk0dsExFnMOc34GtyOnoJSBDklfawRUom
         aNUZB5R6kyC3RSt+Q9zLzemFzePz5Tpy49svuWHodFpPvz0yKFN2SvV741jAHcK/Fmtr
         HsRJnDdxwTyCIHDRlkXfVnhCpxFDWcwZwx7AtBsy8lff90syBeyZtefFy8lRRKcp8ON+
         tb1m8ZIL9g3B22lIP6kojWQ9Y4ZgrA3YNyIWa13H2pa2cWQNUTpYmMKtvoGVbS2DwxEQ
         tAHg==
X-Forwarded-Encrypted: i=1; AKwUvByDQv50tOY8WLlbCpmU7IEjYId9I9m3VrMa2+Ev3Y/uGMFVRVc9BDM6WLywazXcKdPNw3HAVQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJJf3S27nWROEda/QjYgdUl7wCJFcV9n+xJnrGSGB4r0AenXsNA
	zOKPDkMqn2KpTNCTD8fy1BSaKPou7MnJGJTZW3L/oHwNKJ6VxuUUXPgXfnxA2CwBIoY=
X-Gm-Gg: AYBFou0L2laO6+KrkyOOKFIu8bo9DDkEluNH1pVYD7LbRx+O88zOawn7wLTBzcQMmZs
	jnXQKsbr+hLSmi14W8uusn55zCVs7ON95oLtPgrZbw5g9oarrfRJ+obRJXvQ1NzW3X2xw34n4lW
	jakCJR49WLOmnHgfG2Y2I1qEseTlR7q8+Upr4f9XqcF+qe3goaMgi0Egwz/CBxM8GTXohpQKmim
	ZBEWbKx8HuHxc+dCy+X9tqHtjNTT8jCvwMpMTlLreoXuw8DxtkZdwDdDfTbtv3XNi05RrHNq1VM
	QTgQs+QcLG3tut7kxz8Zuzm8vY+Tw6EfzaaaFFLWOsQ9sjwzK5o6cMdvyzBS/xHmcWO473o9EIg
	/Qog1EsA0zJZjbx9FWuOe4r3o52tPgaT6BmfVbpXKqGOgRR38ssS4LPqXh8SnvaK3XHsAZO/Phj
	+n5L+x6sII7Qed4CC/erUQfuvwz8qenAl192d8KTBB4Z8uZcsHh9qOQXMP7DNZHM/AZ1espcLst
	vmT9iMvRVEw43cMe4q7riF8l0at96ADBLiwJh7s5/oOqv3krkfIMzAw3yIjwoCSKXoyF8vJE9ir
	fWrg3VfggH8Y1Gjkkaze8vV3vFSuTuGzOvOZnw==
X-Received: by 2002:a05:620a:7001:b0:939:b057:daf2 with SMTP id af79cd13be357-93f6f7fef1amr427452285a.45.1792765750875;
        Fri, 23 Oct 2026 07:29:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9404722bccbsm30639685a.8.2026.10.23.07.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:29:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKGGb-0000000GjTu-3HLf;
	Fri, 23 Oct 2026 11:29:09 -0300
Date: Fri, 23 Oct 2026 11:29:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [RFC PATCH 3/3] iommu/arm-smmu-v3: Add support for hitless
 replace of S1 domains
Message-ID: <20261023142909.GG3977851@ziepe.ca>
References: <20260925011308.3381953-1-skhawaja@google.com>
 <20260925011308.3381953-4-skhawaja@google.com>
 <3d1eb92f-3447-49f0-a210-fd4fa015304b@arm.com>
 <20261023134900.GB3977851@ziepe.ca>
 <d4570e2d-5b92-4f05-a8b3-34d5d5b299bd@arm.com>
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
In-Reply-To: <d4570e2d-5b92-4f05-a8b3-34d5d5b299bd@arm.com>

On Fri, Oct 23, 2026 at 03:04:23PM +0100, Robin Murphy wrote:
> On 23/10/2026 2:49 pm, Jason Gunthorpe wrote:
> > On Fri, Oct 23, 2026 at 02:43:28PM +0100, Robin Murphy wrote:
> > > > @@ -3664,8 +3726,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
> > > >    		struct arm_smmu_cd target_cd;
> > > >    		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
> > > > -		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
> > > > -					&target_cd);
> > > > +		arm_smmu_replace_cd_entry(master, IOMMU_NO_PASID, cdptr,
> > > > +					  &target_cd);
> > > 
> > > No, we cannot blindly do this for arbitrary ->attach_dev calls - the
> > > majority of S1->S1 transitions are going to be moving back and forth between
> > > the default domain and user domains, where there is zero expectation, let
> > > alone guarantee, that the translations would be equivalent and thus not
> > > liable to lead to TLB conflict aborts or amalgamation hell.
> > 
> > Heh, yeah this probably only works properly with BBML2 or something so
> > the temporary ASID doesn't explode.
> 
> This is fundamental VMSA behaviour - see R_FVQCK in the Arm ARM. BBML only
> applies to the one specific case of identical VA->PA translations with
> identical attributes _only_ differing in the leaf level at which they are
> described.

Sigh, I thought ARM got past that 'tlb conflicts catch fire'.

So, yeah we need a flag that says "I pinky swear these are identical
translations". And it has to be a kernel only flag since we can't let
userspace trigger this.

Jason
