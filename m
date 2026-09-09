Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF563CAE8D;
	Wed,  9 Sep 2026 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945661; cv=none; b=LE4cHEEfP44cYBQQz3EQDCnfKBbjr9EaXpsYhwu08/EGz7CUv+tpkVB1apcLFxZDOyeFU5KJ3RzmM6X0CCztqsn33jFWMBojenvXj3usVswF6VrK2dz7xVIhFwsUtQwlNtnik3TuvIHMlmOJ492dPQ7540s3s4m/sU2lR50U2wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945661; c=relaxed/simple;
	bh=TRlZJ/e7t1LUzcpnKgnLA8txYNc6ZEo6qz3W7v1hVC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ebHM7PVDFFMG4XJU9RbFJx0OBtwKXWzrccn0j70GLmfJwiQpWzg/2q4SB5X54ZiKpKdF2wYwjBXMIxhDkL5Fo598/Ds8bIMo36vwsdvnwkNhsH/oJnD+3hbj9WOMDvxFXCPrtIZFLm1/vUOpDYMyiyXtbspNcNlXT/vN9FY4jbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbZbV8qx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbZbV8qx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A221F00A3D;
	Wed,  9 Sep 2026 09:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945655;
	bh=qpvEwZQZxhTh2+qj5/551diFHgIHsY+uTFIFCnSzP9U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZbZbV8qxzD5Lru67QXlKy5R7bfi5m/YE53ES93yAAK93zSesNfvdndAA2+zWe59rq
	 FgMJFB1XlNMASSyV+yad89jsRvb5gW/fUTilSAwbSHwMgraNaLSfb0I9+C6kIlxjXU
	 Yh5BYW+CbLWXit5j/pwmMiJf8096X+ImS8sQk/OVmuPRMDJ+j6dCzOpJ+aB2PxxvY0
	 +r6m9KjaAhmcxVhzniI/hGGAAOET/9zHyZDjRknZKRvlb8+knmu87v3bsLT//j1VJN
	 bADEfJQtZLnRweow1MY36LJt2CAZoelZFdGdIUufsFkot7P3/7oLRuDvGdgUJX+44W
	 igmDAtMKphXFQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, Ashish
 Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, Danilo
 Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, Jason Gunthorpe
 <jgg@nvidia.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v10 07/15] platform-msi: Introduce
 platform_device_msi_rewrite()
In-Reply-To: <aqBs1Rzz_i1N7756@google.com>
References: <20260908171712.356645-1-praan@google.com>
 <20260908171712.356645-8-praan@google.com> <87se3j1qgu.ffs@fw13>
 <aqBs1Rzz_i1N7756@google.com>
Date: Wed, 09 Sep 2026 11:20:52 +0200
Message-ID: <87bja6232j.ffs@fw13>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 08 2026 at 20:15, Pranjal Shrivastava wrote:
> On Tue, Sep 08, 2026 at 09:40:49PM +0200, Thomas Gleixner wrote:
>> So this all can be solved at the device domain level without sprinkling
>> per interrupt invocations including conditionals all over the place.
>> 
> Ack. I was wondering if the irq core should also cache the message for
> platform MSIs like it's done for PCI ? Would that be a bad idea? Or is
> it this way by design? (I'm having to cache the msg in the iommu driver
> atm).

Sure. This can be done in irq_chip_write_msi_msg() before invoking the
chip callback. That makes the PCI caching redundant, but it can't be
removed because of other historical layering violations in that
context. So adding it to the core requires to add a comment why this has
to stay in the PCI write function.

