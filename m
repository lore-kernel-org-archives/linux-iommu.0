Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44C0242935
	for <iommu@lists.linux.dev>; Sun, 30 Nov 2025 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764543166; cv=none; b=NktLwMVlCNFzM75WSjpm2YW8VjnamqZkKSRDg6h280Z7P2nQRxhf6RGu53VGMgArSgSbM/tQcT2/7zs5zh0joLyWwtkt4fhVNaiqYJNpK6NEf+NFbB9qW26x3nJzMukXvdBebBUdyPqt5EnIIAoERhLbuSudCXbm9eReUq9rVlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764543166; c=relaxed/simple;
	bh=SOPNcceROgpE+NOElZey38Ee4jplu6+nurjD9UwV744=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3mGpkpqmgcO1adI5Nc/aYmSiAtCdSqBd2pTX8vpmIPqxXZJ5SisP8HZQqW6Gn3JUcqPjxBSdLnF4u+1JrYAJup08zcJcUWFKOK5UD6UYa9OrB2fA5P+FLevHOLbFIsOjxDNDGQZOpv5IzXKGUkuePuvCM+l48EocOs4ne6Jf+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XB7U3xtD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XB7U3xtD"
Received: from localhost (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id EEBCC200DFDB;
	Sun, 30 Nov 2025 14:52:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EEBCC200DFDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764543158;
	bh=gCfSE1SpLmMXqUf2ooGYc7zAwj8Zix/sXTyz5dV9dPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XB7U3xtDB2SBNBhuvthy0YOrJTAYhD44hlTUvhP4nivL2jYcdI0aE5+qs3oCWmtkL
	 tsKZvNoLp+9N/6QgBvMHslSThESYbRNzhkZT8LgKJzTwflSxc4/KRsFxhlenT1lUl7
	 5yt4BviUW1b7Ksl3I7CWw5iMRrH8OUKqxqKm8sBc=
Date: Sun, 30 Nov 2025 14:52:36 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, Zhang Yu
 <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v4 2/2] iommu/arm-smmu-v3: Improve CMDQ lock fairness
 and efficiency
Message-ID: <20251130145236.0000009d@linux.microsoft.com>
In-Reply-To: <aSXlAT00HVCGBaNY@willie-the-truck>
References: <20251114171718.42215-1-jacob.pan@linux.microsoft.com>
	<20251114171718.42215-3-jacob.pan@linux.microsoft.com>
	<aSXlAT00HVCGBaNY@willie-the-truck>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Will,

On Tue, 25 Nov 2025 17:18:57 +0000
Will Deacon <will@kernel.org> wrote:

> On Fri, Nov 14, 2025 at 09:17:18AM -0800, Jacob Pan wrote:
> > @@ -521,9 +527,14 @@ static bool
> > arm_smmu_cmdq_shared_tryunlock(struct arm_smmu_cmdq *cmdq)
> > __ret;
> > 	\ }) 
> > +/*
> > + * Only clear the sign bit when releasing the exclusive lock this
> > will
> > + * allow any shared_lock() waiters to proceed without the
> > possibility
> > + * of entering the exclusive lock in a tight loop.
> > + */
> >  #define arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq,
> > flags)		\ ({
> > 				\
> > -	atomic_set_release(&cmdq->lock, 0);
> > 	\
> > +	atomic_fetch_and_release(~INT_MIN, &cmdq->lock);
> > 	\  
> 
> nit: you can use atomic_fetch_andnot_release(INT_MIN)
> 
Good point, will do.

> That aside, doesn't this introduce a new fairness issue in that a
> steady stream of shared lockers will starve somebody trying to take
> the lock in exclusive state?
> 
I don't think this change will starve exclusive lockers in the
current code flow since new shared locker must acquire exclusive locker
first while polling for available queue spaces.

