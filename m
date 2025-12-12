Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB61D29617D
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765569936; cv=none; b=r0ExutSqP7CVL6UTaQwuawmC4vr+/EWQQim1vyQakBhEeDhYegPqILVY5q3p6PlfC2tHGs6YQmUYSCYSAzzgNuheHIk/e8xkUtMGWfCRzTbx/dqKR72GsPoomMckOaURxuJkF4/e6y5DuHtS4fMsNT+NZdbyOdbxBUeM/RlGS9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765569936; c=relaxed/simple;
	bh=LB9aINfzyzjgnK4VhS+BUCarj495V99Mjc4gaEZNN5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uB8HKA2bB7wW27AWYKbvUYeaC+RvSEw3ZkbzDwIyn4w5PBKCdgV4dcAnayYMGA8PszFXVLMy8+UTgaQ/do/U82xEafO8XqM+xwik+wmB7a7ebl5uPncbtaGhAkdRm17TMbl3eztCoc2CPKb0cxb/CMyQFaSd7amidC9bJw131Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V18SAsRH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V18SAsRH"
Received: from localhost (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 976D5201D7F9;
	Fri, 12 Dec 2025 12:05:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 976D5201D7F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765569934;
	bh=um/xkKc/u/1WbAFU1WWdXZDKKUEFP85My8/oR0OPf6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V18SAsRHS4m2tNhWZODqNsTfln2/+U4a7gbatiY0j64IUwplxI568aGjJBhaUFk2V
	 K76W2akWfVzOI8BEoGCeQ3xTXo1NNmZStJkGmoglo6omd6pFvBAAqnBDWnz8xGqyNq
	 ZjlafUO6X8yjxJRlayTS1o4BDdYPrKt2RamAnAX0=
Date: Fri, 12 Dec 2025 12:05:26 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, Zhang Yu
 <zhangyu1@linux.microsoft.com>, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Alexander Grest <Alexander.Grest@microsoft.com>
Subject: Re: [PATCH v5 2/3] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Message-ID: <20251212120526.00007807@linux.microsoft.com>
In-Reply-To: <aTjmA_juSss36e8v@google.com>
References: <20251208212857.13101-1-jacob.pan@linux.microsoft.com>
	<20251208212857.13101-3-jacob.pan@linux.microsoft.com>
	<aTjmA_juSss36e8v@google.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Wed, 10 Dec 2025 12:16:19 +0900
Will Deacon <will@kernel.org> wrote:

> On Mon, Dec 08, 2025 at 01:28:56PM -0800, Jacob Pan wrote:
> > @@ -781,12 +771,21 @@ static int arm_smmu_cmdq_issue_cmdlist(struct
> > arm_smmu_device *smmu, local_irq_save(flags);
> >  	llq.val =3D READ_ONCE(cmdq->q.llq.val);
> >  	do {
> > +		struct arm_smmu_queue_poll qp;
> >  		u64 old;
> > =20
> > +		/*
> > +		 * Poll without WFE because:
> > +		 * 1) Running out of space should be rare. Power
> > saving is not
> > +		 *    an issue.
> > +		 * 2) WFE depends on queue full break events,
> > which occur only
> > +		 *    when the queue is full, but here we=E2=80=99re
> > polling for
> > +		 *    sufficient space, not just queue full
> > condition.
> > +		 */ =20
>=20
> I don't think this is reasonable; we should be able to use wfe
> instead of polling on hardware that supports it and that is an
> important power-saving measure in mobile parts.
>=20
After an offline discussion, I now understand that WFE essentially
stops the CPU clock, making energy savings almost always beneficial.
This differs from certain C-state or idle-state transitions, where the
energy-saving break-even point depends on how long the CPU remains
idle. Previously, I assumed power savings were not guaranteed due to
the unpredictability of wake events (e.g., timing relative to scheduler
ticks or queue-full conditions).

So I agree we should leverage WFE as much as we could here.
=20
> If this is really an issue, we could take a spinlock around the
> command-queue allocation loop for hardware with small queue sizes
> relative to the number of CPUs, but it's not clear to me that we need
> to do anything at all. I'm happy with the locking change in patch 3.
>=20
> If we apply _only_ the locking change in the next patch, does that
> solve the reported problem for you?
Yes, please take #3. It should take care of the functional problem.

Thanks,

Jacob
