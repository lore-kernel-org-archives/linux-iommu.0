Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0D10E8
	for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 05:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D285C433C9;
	Fri, 21 Jul 2023 05:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689917252;
	bh=1afuGQPjD3KQx3/4ehbMFfIxt3CD7zfKs3ykg3JJelE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lECO1F7bktgAsOfWmqS2j/yGnDirF99NzuIcsBZJOMFEISz0FNvFWz+j88jdaqk4o
	 YgegmaKK9BCb0lgGHbKo7IB4GRDw2v5rhYVTwn31Cr9ruXOoPA1wmBA3psI0nXislB
	 /f7OVGBoznS8wQy2v2jJlOlXV+58hBvjHRYViUuc=
Date: Fri, 21 Jul 2023 07:27:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: stable@vger.kernel.org, easwar.hariharan@microsoft.com,
	catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
	robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 5.15 2/4] arm64: errata: Add workaround for TSB flush
 failures
Message-ID: <2023072131-supremacy-modify-f9ff@gregkh>
References: <1689895414-17425-1-git-send-email-eahariha@linux.microsoft.com>
 <1689895414-17425-3-git-send-email-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689895414-17425-3-git-send-email-eahariha@linux.microsoft.com>

On Thu, Jul 20, 2023 at 04:23:32PM -0700, Easwar Hariharan wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> commit fa82d0b4b833790ac4572377fb777dcea24a9d69 upstream
> 
> Arm Neoverse-N2 (#2067961) and Cortex-A710 (#2054223) suffers
> from errata, where a TSB (trace synchronization barrier)
> fails to flush the trace data completely, when executed from
> a trace prohibited region. In Linux we always execute it
> after we have moved the PE to trace prohibited region. So,
> we can apply the workaround every time a TSB is executed.
> 
> The work around is to issue two TSB consecutively.
> 
> NOTE: This errata is defined as LOCAL_CPU_ERRATUM, implying
> that a late CPU could be blocked from booting if it is the
> first CPU that requires the workaround. This is because we
> do not allow setting a cpu_hwcaps after the SMP boot. The
> other alternative is to use "this_cpu_has_cap()" instead
> of the faster system wide check, which may be a bit of an
> overhead, given we may have to do this in nvhe KVM host
> before a guest entry.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Link: https://lore.kernel.org/r/20211019163153.3692640-4-suzuki.poulose@arm.com
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  Documentation/arm64/silicon-errata.rst |  4 ++++
>  arch/arm64/Kconfig                     | 33 ++++++++++++++++++++++++++
>  arch/arm64/include/asm/barrier.h       | 16 ++++++++++++-
>  arch/arm64/kernel/cpu_errata.c         | 19 +++++++++++++++
>  arch/arm64/tools/cpucaps               |  1 +
>  5 files changed, 72 insertions(+), 1 deletion(-)

As you forwarded this patch on to me, you forgot to sign-off on it :(

I've taken patch 1/4 of this series, but not the rest.  Please redo
them, and send the needed backports for 6.1.y and 6.4.y as a separate
series (obviously I can't apply patches in a series to trees that
already have them.)

thanks,

greg k-h
