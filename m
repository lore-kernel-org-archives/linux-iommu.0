Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E3370838
	for <iommu@lists.linux.dev>; Tue,  3 Jun 2025 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748964322; cv=none; b=sSYxWp+p/4qFp/pQg10OypnBmC8bt9wJ64UZcZYqZB+gFhILS1zJzCj113UYhgadd1Xb1SCwFGFpZIOXYBajQ5EDGje+YbPmXwD2sp4Z9a/Qky0hsNgWysBcsChgPB6Zj/jsaopexTEvAtGiccVOeiIPCNM29JuDJAHToJmvCDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748964322; c=relaxed/simple;
	bh=6nMeOZRePXDVXDGcnFsQmTbfxsXNWxTL5IGoQ/WDvbs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIpPUhqpift1rwJ52A2Y9QteC9Ki+I/Ypo0Tc/D53T4y9PxYoDkzBRD/wyGnQ5+4lhDgyplPOU/B/DjOh98DyYC5LCWSFPHxeRlIEQ6S0xQGGZMm5IzJFzJllfXTRCtYMvq5tkI1Fgz1sk2GpeydWXmt8m17XHpCPd3E5r8TIlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ex9vtb72; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ex9vtb72"
Received: from DESKTOP-0403QTC. (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 580672113A78;
	Tue,  3 Jun 2025 08:25:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 580672113A78
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748964320;
	bh=cCFBN2LWKAne1DQ7nQtWUv+KKHq4WV3lvkNZXKSNhCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=Ex9vtb72rLSb+vGkzYKBiKxYQpZAsLEPW3TIHqCqSuRYi3RKAEddGKijibCFd6S0Z
	 na/ISsr8ljwhCG8KvhXtjYiRYl/0fPSDbI8c1/kvpPHsJnpMsrk/bwufoICVTA5z+9
	 9iyLVujl1Fp2Dspi0AxC/H+qNn4Z35jwpx9CFvbw=
Date: Tue, 3 Jun 2025 08:25:19 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Alex Williamson <alex.williamson@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, Zhang Yu <zhangyu1@microsoft.com>, Easwar
 Hariharan <eahariha@linux.microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH 1/2] vfio: Fix unbalanced vfio_df_close call in no-iommu
 mode
Message-ID: <20250603082519.7b5b063e@DESKTOP-0403QTC.>
In-Reply-To: <20250602234903.GB376789@nvidia.com>
References: <20250602234319.4404-1-jacob.pan@linux.microsoft.com>
	<20250602234903.GB376789@nvidia.com>
Reply-To: jacob.pan@linux.microsoft.com
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Mon, 2 Jun 2025 20:49:03 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Jun 02, 2025 at 04:43:18PM -0700, Jacob Pan wrote:
> > For no-iommu enabled devices working under IOMMUFD VFIO compat
> > mode, the group open path does not call vfio_df_open() and the
> > open_count is 0. So calling vfio_df_close() in the group close path
> > will trigger warning in vfio_assert_device_open(device);
> > 
> > E.g. The following warning can be seen by running VFIO test.
> > https://github.com/awilliam/tests/blob/master/vfio-noiommu-pci-device-open.c
> > CONFIG_VFIO_CONTAINER = n
> > [   29.094781] vfio-pci 0000:02:01.0: vfio-noiommu device opened by
> > user (vfio-noiommu-pc:164) Failed to get device info
> > [   29.096540] ------------[ cut here ]------------
> > [   29.096616] WARNING: CPU: 1 PID: 164 at
> > drivers/vfio/vfio_main.c:487 vfio_df_close+0xac/0xb4
> > 
> > This patch adds checks for no-iommu mode and open_count to skip
> > calling vfio_df_close.
> > 
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> >  drivers/vfio/group.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)  
> 
> Did you mean to resend the original version?
my mistake, just sent v2.

Thanks!

Jacob


