Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667B5354AC7;
	Thu,  5 Mar 2026 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753178; cv=none; b=jB+PCB4YQw4WX80sys7G/jc24YZNyRrbZFlWlXESF1sFdPDOUma4rl2QUJwGmozr3GIiYzGCMeV1BRO3alChgawPI9AXgrGOPseR8fXQMzVGvPuigVSVJVzhbFu8uQdwmyuPFchtIATQLCkmyl0zfKML1HAFDTsirV3R9OsNAck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753178; c=relaxed/simple;
	bh=EiJJXyryo+HKuVx66S49BeciXHgI7om9dfPV1VsHETE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFpqV4TWKK4nvTbfFerjyutrHCm0k+9lGC5MWFmpm7w1HL2l7dpHKFTPS6EBRpH/q6jlPu9QqQcfULWXyWhS68Ti3Wv+xVMpfxCauj90hYucIjSpndmMOLhGn6Y4ArmQOjf3FFSnw8QBm2+A8Yq4ke54mhYmBdMRNZNOeMDbDXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rea9cN1H; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rea9cN1H"
Received: from localhost (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 79E6F20B6F02;
	Thu,  5 Mar 2026 15:26:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79E6F20B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772753175;
	bh=QDKfwN/5O+T5oubvSWKw3kAtVIG3s2Nyz61U0vnOzD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rea9cN1HUPKVP2hX6TJsgD2Ud5CdDwdS2GWWk9OkUCstLzRLyrJQLGqfNGJy+Fvez
	 Q8AWO7fgBh+U0Hh1oo9Df2a7aqAkBOiaPMRtNpcejPvPwlBIK3sd0KEay3Pgx1x/39
	 FSnhPE9x0+8zcYCrcIQMPC8ToYg9PQ3+s/irrm88=
Date: Thu, 5 Mar 2026 15:26:14 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, David Matlack
 <dmatlack@google.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, oe-kbuild-all@lists.linux.dev,
 skhawaja@google.com, pasha.tatashin@soleen.com, Jean Philippe-Brucker
 <jean-philippe@linaro.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 08/11] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <20260305152614.00001a0f@linux.microsoft.com>
In-Reply-To: <20260228003540.GN5933@nvidia.com>
References: <20260227175247.26103-9-jacob.pan@linux.microsoft.com>
	<202602280855.WxyIHCy5-lkp@intel.com>
	<20260228003540.GN5933@nvidia.com>
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

On Fri, 27 Feb 2026 20:35:40 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Sat, Feb 28, 2026 at 08:18:41AM +0800, kernel test robot wrote:
> > Kconfig warnings: (for reference only)
> >    WARNING: unmet direct dependencies detected for IOMMU_PT_AMDV1
> >    Depends on [n]: GENERIC_PT [=y] && IOMMU_PT [=y] &&
> > !GENERIC_ATOMIC64 [=y] Selected by [y]:
> >    - VFIO_NOIOMMU [=y] && VFIO [=y] && VFIO_GROUP [=y]  
> 
> Some kconfig stuff is missing, the iommufd IOMMU would only work with
> GENERIC_ATOMIC64
I don't quite understand this dependency on GENERIC_ATOMIC64, or you
mean the opposite? since we currently have:
config IOMMU_PT_AMDV1
	tristate "IOMMU page table for 64-bit AMD IOMMU v1"
	depends on !GENERIC_ATOMIC64 # for cmpxchg64

And I already have noiommu depends on AMDV1 for mock page tables.

Anyway, this particular build issue can be fixed by adding
IOMMU_SUPPORT. i.e.

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index 1f3fd7140604..78feca3d0c8b 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -65,6 +65,7 @@ config VFIO_NOIOMMU
        select GENERIC_PT
        select IOMMU_PT
        select IOMMU_PT_AMDV1
+       depends on IOMMU_SUPPORT
        help


