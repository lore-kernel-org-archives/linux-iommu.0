Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D1241667
	for <iommu@lists.linux.dev>; Fri, 13 Jun 2025 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749843813; cv=none; b=pqpXya/Y8F7IriTIMFgEoFWwNH4gAl1TE7jLonSTtUVM2xIoy/atxnI4BgBFnxEh3ic2cMB1yGkYZAXZCvcW/DBDcywHO2gspsdB+HnewFToFfdboJJfOetyA6LF6nGxyiPskCbU4C3IThe1uGdc/KmSVFtpNVdbiuwjOCv9ahk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749843813; c=relaxed/simple;
	bh=hC4V+1Dt27/Fv+cHSYNpPlN1jU584vWBlk4E/iSJqNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNHUcpYgSXRu4yD+AJFdRcOIvon5D8nvgSXtsh3PiMmaRQbfGp/rbDKo+5h6A+FD7n6RPZdo8kBVODP2woyUJeXUp5Kyo2vYZY8+gv27S9fRk3/ilTm4g4Mo9F9YF/CWkzqGDULoFI8NBcOSsv49OPLIpPrPD9kT6D9pkFcyPvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vd7PKd8w; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vd7PKd8w"
Date: Fri, 13 Jun 2025 12:43:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749843807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RiYXVgcIqh/RTLmK+Rx+QzUVOjDT9BY8SQ3RWUnrRPA=;
	b=Vd7PKd8wGfZvL5kqVq+Dca3A5hDB3H0EKNSbHMcN6e7P8ORHUnyy6UkFj4MyqfKzaiKyyy
	cluvv8f1WJyFdH2b+/DBV0z7DYn18aGgYZ50ltz3iGZ+XYjl8KLTJ8+lmr7urH53OmMXpz
	IzAMWm6MMTUuosIcgGHMBqXqO+4KxIA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Sairaj Kodilkar <sarunkod@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Francesco Lavra <francescolavra.fl@gmail.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 01/62] KVM: arm64: Explicitly treat routing entry type
 changes as changes
Message-ID: <aEx_VlekBuL0ds5v@linux.dev>
References: <20250611224604.313496-2-seanjc@google.com>
 <20250611224604.313496-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611224604.313496-3-seanjc@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 11, 2025 at 03:45:04PM -0700, Sean Christopherson wrote:
> Explicitly treat type differences as GSI routing changes, as comparing MSI
> data between two entries could get a false negative, e.g. if userspace
> changed the type but left the type-specific data as-
> 
> Note, the same bug was fixed in x86 by commit bcda70c56f3e ("KVM: x86:
> Explicitly treat routing entry type changes as changes").

Yeah, I'll let you guess where I got the idea from...

> Fixes: 4bf3693d36af ("KVM: arm64: Unmap vLPIs affected by changes to GSI routing information")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

Thanks,
Oliver
