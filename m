From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/3] iommu/arm-smmu-v3: Add workaround for Cavium
 ThunderX2 erratum #74
Date: Thu, 27 Apr 2017 17:42:37 +0100
Message-ID: <20170427164237.GA7114@leverpostej>
References: <1493293584-20287-1-git-send-email-gakula@caviumnetworks.com>
 <1493293584-20287-3-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493293584-20287-3-git-send-email-gakula@caviumnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Geetha sowjanya <gakula@caviumnetworks.com>
Cc: will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org, jcm@redhat.com, linu.cherian@cavium.com, linux-kernel@vger.kernel.org, geethasowjanya.akula@gmail.com, linux-acpi@vger.kernel.org, robert.richter@cavium.com, catalin.marinas@arm.com, Geetha <gakula@cavium.com>, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 27, 2017 at 05:16:23PM +0530, Geetha sowjanya wrote:
> +	/*
> +	 * Override the size, for Cavium CN99xx implementations
> +	 * which doesn't support the page 1 SMMU register space.
> +	 */
> +	cpu_model = read_cpuid_id() & MIDR_CPU_MODEL_MASK;
> +	if (cpu_model == MIDR_THUNDERX_99XX ||
> +	    cpu_model == MIDR_BRCM_VULCAN)
> +		size = SZ_64K;

If you're trying to identify an SMMU erratum, identify the SMMU, not the
CPU it happens to be paired with this time.

There are ID registers in the SMMU you can use to do so.

NAK to using the CPU ID here.

Mark.
