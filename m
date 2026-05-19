Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0FD3E314D
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224638; cv=none; b=Gg/igTfSE3BDDKUFMph2KTcjTXB+f2KJKhQrA4bxNdaUcOpS5REKpk0fBsfH2evPYp/I/dqaZ3dkD/F/rXJqVjqTWIHV4ao2wvPvzjFglP82ixLUiplos1NAmTZn9GDzecDZobvYwUREBiKRtu+tkmRuam7lLB392VbcB3uTV4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224638; c=relaxed/simple;
	bh=7lskqn26rq6tTNwK1bV4v0JSuUkq9H1pEJwY2Ub670s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzgpbLAImMXFQRpdGZjSD6CbUXTj2KW2KvbH6QoS54ngCdjgvWNn4FMmg/yaUmCLh3M0JMnEA0ymctIL3nv1FA0rKj6IWScQUYgE2s1+BTlgvalFud/Z0Qv8E6MD+VMC9daIU7szqMWNtpmemTnH77WGBpF+XQvTTb29EsTT+8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gX3o2Jag; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gX3o2Jag"
Received: from localhost (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9623420B7167;
	Tue, 19 May 2026 14:03:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9623420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779224624;
	bh=oWgyrpRAn58pjiIs+zN/w5MJ680FMEvCTgi9+J1g8zs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gX3o2JagM9yOXq+8mrjI11q2R99Kgah25cfcdFDTX+Qa2MaXAWlC6fSc34VAQQQZ5
	 6BbN8GBHW1xGbD1/tgkUyhdEoeVKZGUrCH1tCd0O1E76f4rUul/w9KPUUO2zmOdrUC
	 7NT2Qp3LbvWZW4wWJgAoAxB+2f4zZ9Lv/KhVBZA4=
Date: Tue, 19 May 2026 14:03:48 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>
Cc: Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 skhawaja@google.com, pasha.tatashin@soleen.com, Will Deacon
 <will@kernel.org>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 0/9] iommufd: Enable noiommu mode for cdev
Message-ID: <20260519140348.00003c87@linux.microsoft.com>
In-Reply-To: <20260519180156.GI3602937@nvidia.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
	<20260519180156.GI3602937@nvidia.com>
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

Hi Jason,

On Tue, 19 May 2026 15:01:56 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, May 11, 2026 at 11:41:05AM -0700, Jacob Pan wrote:
> > VFIO's unsafe_noiommu_mode has long provided a way for userspace
> > drivers to operate on platforms lacking a hardware IOMMU. Today,
> > IOMMUFD also supports No-IOMMU mode for group-based devices under
> > vfio_compat mode. However, IOMMUFD's native character device (cdev)
> > does not yet support No-IOMMU mode, which is the purpose of this
> > patch.  
> 
> I would like to try to take this for this cycle, how are we doing for
> a v6?
I will send out v6 with Baolu's feedback in a couple of days.

> Alex, did you have any remarks?
> 
> Thanks,
> Jason

