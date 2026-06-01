Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF42F306746
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 05:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780290056; cv=none; b=mpXZ+dsk/GtBMd5hxAAWfvDqxwc8y1cJ1tg9clZtmY91/uJSjkipXaDZjtE7jgdN1Z/GeuLG6vB2Txwl7IEoHklqCCsM5CRt7ugPOPByg3vtNGSOZiiJ8cinG934QlbIl7bQo4Ra8uNWsMpYs3tqqQez0H52uNWuxO6egyCvtII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780290056; c=relaxed/simple;
	bh=sKx7C7z4gHYVIiPdQZdhzaKPMuYZxxtiqHWOqYRVgtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SU3GxK39o/Bl7+uz6M5J+Z4k5CyvPB23iPagUIOCXm4wHRIK1Q3efCree4UryegOx/3ImJfbVTiyctjyYQWBpHRJt1xEQkxEL4+qXteqx15kwxC0or1hzxwPVvvxKMYC4UB5Qwc8oY0bzZ4k0hCWE/uwDr2vBQvJaGIEzRHmrH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jK8M9tTS; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jK8M9tTS"
Date: Mon, 1 Jun 2026 13:00:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780290042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e129xfl2uwbBORZTKnJ3i22zjcF3b+7zkkUcuJrSRlM=;
	b=jK8M9tTSYsgWEa+miw8zUAseNoC+gbcuCv9nUMAsDdJneXEMD6zUH9KN3eu6lVTxSHEXW2
	hSHndFlGvSyxQ7zV+0TKSQTKSS3hHU6muR0MeW7qGoat01tQoLxr28BDKQvwXidIPuZNdp
	eGw38CLTieSZYcpODkiAlFiju9A6r0w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Baoquan He <baoquan.he@linux.dev>
To: Mike Rapoport <rppt@kernel.org>
Cc: Will Deacon <will@kernel.org>, Wandun Chen <chenwandun1@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	iommu@lists.linux.dev, zhaomeijing@lixiang.com,
	catalin.marinas@arm.com, chenhuacai@kernel.org, kernel@xen0n.name,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, robh@kernel.org, saravanak@kernel.org,
	akpm@linux-foundation.org, bhe@redhat.com,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, m.szyprowski@samsung.com,
	robin.murphy@arm.com, quic_obabatun@quicinc.com
Subject: Re: [PATCH v3 09/11] arm64: kdump: exclude non-dumpable reserved
 memory regions from vmcore
Message-ID: <ah0R8pEIyuk4N2Is@MiWiFi-R3L-srv>
References: <20260527032917.3385849-1-chenwandun1@gmail.com>
 <20260527032917.3385849-10-chenwandun1@gmail.com>
 <ahmr-UjoApj2j5JS@willie-the-truck>
 <ahsPcv8G1BR9rLah@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahsPcv8G1BR9rLah@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 05/30/26 at 07:25pm, Mike Rapoport wrote:
> On Fri, May 29, 2026 at 04:08:41PM +0100, Will Deacon wrote:
> > On Wed, May 27, 2026 at 11:29:15AM +0800, Wandun Chen wrote:
...snip...
> There are patches that move common code to kernel/crash_core.c:
> 
> https://lore.kernel.org/all/20260525084932.934910-1-ruanjinjie@huawei.com
>  
> Review from arch maintainers would be helpful there ;-)

Before, Andrew would put patch candidates into his mm tree and trigger
testing. If any adjustment, he would take them off. Can we do the
similar thing for kexec/kdump patches, unless the patches are objected
explicitly?

Thanks
Baoquan
