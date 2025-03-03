Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C43623F383
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997933; cv=none; b=mRslhluF18N7rF6Iqkj9PywEIz/f3Rw5mw7GgYV0WpMrWo0i8gcS2SqHtLdqR2VWWuGGhcrr0KVrtPvjtWZcX5BLhbPfW5fxcLgrWFX11rlu7T+m2rEaH0+at3ZgltO12k/k6avcdO+ftUBIJoaSoW2YVMH/KR6KdGh+e3jvtTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997933; c=relaxed/simple;
	bh=cfjZTAA3wFI4kmuYmgNO61aNSEGKpej4JaJFeqP9wPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXr1lvISF0TyFeYDeX6gdcefVab/U3WS0qaO+ST5+MwSKfPuZWJlbLO9CL3S6LyTt1J/1aqPUNVQ94eka8MRGSdPyBs54KyfFk4N0TdjmQ0DU6zO9BkFvq18Q66Xe/dVHN6P+pIvQshkTIwBjNujYpfHCs6sBaxMXcJWD61twhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 092C1113E;
	Mon,  3 Mar 2025 02:32:25 -0800 (PST)
Received: from e133081.arm.com (unknown [10.57.37.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AC8F3F66E;
	Mon,  3 Mar 2025 02:32:03 -0800 (PST)
Date: Mon, 3 Mar 2025 10:32:01 +0000
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, suzuki.poulose@arm.com,
	catalin.marinas@arm.com, will@kernel.org, joro@8bytes.org,
	jean-philippe@linaro.org, mark.rutland@arm.com, joey.gouly@arm.com,
	oliver.upton@linux.dev, james.morse@arm.com, broonie@kernel.org,
	maz@kernel.org, david@redhat.com, akpm@linux-foundation.org,
	jgg@ziepe.ca, nicolinc@nvidia.com, mshavit@google.com,
	jsnitsel@redhat.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2 4/4] iommu/arm: Add BBM Level 2 smmu feature
Message-ID: <20250303103201.GD13345@e133081.arm.com>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-6-miko.lenczewski@arm.com>
 <b46dc626-edc9-4d20-99d2-6cd08a01346c@os.amperecomputing.com>
 <43732270-8fd0-4a18-abec-096e383a6a4d@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43732270-8fd0-4a18-abec-096e383a6a4d@arm.com>

On Mon, Mar 03, 2025 at 10:17:28AM +0000, Ryan Roberts wrote:
> On 01/03/2025 01:32, Yang Shi wrote:
> > 
> > 
> > 
> > On 2/28/25 10:24 AM, Mikołaj Lenczewski wrote:
> >> For supporting BBM Level 2 for userspace mappings, we want to ensure
> >> that the smmu also supports its own version of BBM Level 2. Luckily, the
> >> smmu spec (IHI 0070G 3.21.1.3) is stricter than the aarch64 spec (DDI
> >> 0487K.a D8.16.2), so already guarantees that no aborts are raised when
> >> BBM level 2 is claimed.
> >>
> >> Add the feature and testing for it under arm_smmu_sva_supported().
> >>
> >> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> >> ---
> >>   arch/arm64/kernel/cpufeature.c                  | 7 +++----
> >>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 +++
> >>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
> >>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 4 ++++
> >>   4 files changed, 13 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> >> index 63f6d356dc77..1022c63f81b2 100644
> >> --- a/arch/arm64/kernel/cpufeature.c
> >> +++ b/arch/arm64/kernel/cpufeature.c
> >> @@ -2223,8 +2223,6 @@ static bool has_bbml2_noabort(const struct
> >> arm64_cpu_capabilities *caps, int sco
> >>               if (!cpu_has_bbml2_noabort(__cpu_read_midr(cpu)))
> >>                   return false;
> >>           }
> >> -
> >> -        return true;
> >>       } else if (scope & SCOPE_LOCAL_CPU) {
> >>           /* We are a hot-plugged CPU, so only need to check our MIDR.
> >>            * If we have the correct MIDR, but the kernel booted on an
> >> @@ -2232,10 +2230,11 @@ static bool has_bbml2_noabort(const struct
> >> arm64_cpu_capabilities *caps, int sco
> >>            * we have an incorrect MIDR, but the kernel booted on a
> >>            * sufficient CPU, we will not bring up this CPU.
> >>            */
> >> -        return cpu_has_bbml2_noabort(read_cpuid_id());
> >> +        if (!cpu_has_bbml2_noabort(read_cpuid_id()))
> >> +            return false;
> >>       }
> >>   -    return false;
> >> +    return has_cpuid_feature(caps, scope);
> > 
> > Do we really need this? IIRC, it means the MIDR has to be in the allow list
> > *AND* MMFR2 register has to be set too. AmpereOne doesn't have MMFR2 register set.
> 
> Miko, I think this should have been squashed into patch #1? It doesn't belong in
> this patch.

Yes, 100%. Missed this, will put into patch #1.
