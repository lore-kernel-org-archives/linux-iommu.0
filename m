Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FE4215041
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028643; cv=none; b=jul4rP54vGE6tVukt1Myo6TQ9ieJHMWjSkBgZpOMj1tBUSFY2DnjaFtJEdaxRh66t+7X40CPIZdNGIzlKOV3MGztcc1hVrpZU8t0aoDuBQKGLf109PH1YAtyxFU314wLNCY74qyHqCIDk+7PrSXlCVbJ1ttsatCUNQXS2JIMG7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028643; c=relaxed/simple;
	bh=SBKTKcxMsfQBXZnyIKo1h7mswmhDUyYtLdOc6AOWgX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdLJyIt/5AalUMqMcEnT2EuLrS1VBrzKOshBjTPBuxzTbwHUTfaecmq697iRKmP/Pmx2R6cDEicQ7vGCvIQVeuC9JNCAzwe3f2VV74slugXF20XHTgZjqRa4UjxuzJtGzRYxg1NmNO7bhv0YSE2okp1f0KTjM5nQu56FJ+qX8+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13E62106F;
	Mon,  3 Mar 2025 11:04:15 -0800 (PST)
Received: from e133081.arm.com (unknown [10.57.37.154])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A72623F5A1;
	Mon,  3 Mar 2025 11:03:55 -0800 (PST)
Date: Mon, 3 Mar 2025 19:03:42 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"maz@kernel.org" <maz@kernel.org>,
	"david@redhat.com" <david@redhat.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"mshavit@google.com" <mshavit@google.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"smostafa@google.com" <smostafa@google.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 4/4] iommu/arm: Add BBM Level 2 smmu feature
Message-ID: <20250303190330.GA426248@e133081.arm.com>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-6-miko.lenczewski@arm.com>
 <20250228193221.GM5011@ziepe.ca>
 <b23aa37f8e864dea82a6143bece912d6@huawei.com>
 <20250303103102.GC13345@e133081.arm.com>
 <20250303165255.GS5011@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303165255.GS5011@ziepe.ca>

On Mon, Mar 03, 2025 at 12:52:55PM -0400, Jason Gunthorpe wrote:
> On Mon, Mar 03, 2025 at 10:31:02AM +0000, Mikołaj Lenczewski wrote:
> 
> > > > On such a system it seems like your series would break previously
> > > > working SVA support because this patch will end up disabling it?
> > 
> > Perhaps my understanding is flawed here, but I was under the impression
> > that with SVA both the core and smmu MUST support BBML2 to use it safely
> > for core translations? 
> 
> Yes
> 
> But today's kernel does not use BBML2 in the CPU or the SMMU so it is
> compatible with everything.
> 
> So it is an upgrade issue, going from today's kernel without any BBML2
> support to tomorrow's kernel that does then you loose SVA on
> previously working HW.

I see what you mean.

If you have hardware that supports cpu BBML2 but doesn't support smmu
BBML2, either by virtue of having a pre-SMMUv3.2 smmu, or by only
implementing BBML1, the simplest option I see is then to disable BBML2
globally in the kernel. A bad klude, but would at least leave current
SVA working.

> > Hopefully, as you say, the MIDR list restricts the breakage to a limited
> > (ideally, zero-size) set of implementations which advertise BBML2
> > without conflict aborts, but which do not support BBML2 on the smmu.
> > 
> > However, if my understanding of the BBML2 feature and how it interacts
> > with SVA is flawed, this will obviously be something for me to fix.
> 
> Lets hope, I was not able to discover any NVIDIA platforms that have
> an issue with this series as is.
> 
> But every addition to the MIDR list will require some consideration :\

Yes, I agree. I believe that for larger cores, this is a guarantee that
implementors will be able to make when adding themselves to the list.
They know what smmu their core uses, and that tends to be
performance-focused (hence more likely to use an smmu that support
BBML2).

For smaller cores, i.e. mobile cores, this becomes a larger issue as you
may have a higher likelyhood of pairing such a core with an
older/insufficient smmu version. So, careful consideration is required.

> > On independently enabling BBML2 on the smmu but not the CPU, this should
> > be possible.
> 
> What about the reverse? Could we disable BBML2 on the CPU side on a
> per-mm basis? Ie when an old SMMU attaches with disable the
> incompatible feature? Not something for this series, but if we get
> into trouble down the road

I agree in principle with having, as you point out, some mechanism
to disable BBML2 when an smmu without BBML2 is used. However, I think
that the complexity of such a mechanism depends on how the BBML2 feature
is used by future patches.

For example, if we use BBML2 for kernel mappings, does that require us
to repaint all kernel mappings when disabling BBML2 on smmu attach? I
am not sure, but definitely something to be worked out.

-- 
Kind regards,
Mikołaj Lenczewski
