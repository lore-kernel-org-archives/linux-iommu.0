From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 0/7] Cavium CN99xx SMMUv3 Errata workarounds
Date: Tue, 11 Apr 2017 17:30:04 +0100
Message-ID: <20170411163004.GH17109@arm.com>
References: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1491921765-29475-1-git-send-email-linucherian@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linucherian@gmail.com
Cc: catalin.marinas@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robert.moore@intel.com, lv.zheng@intel.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, devel@acpica.org, Sunil.Goutham@cavium.com, Geethasowjanya.Akula@cavium.com, robert.richter@cavium.com, linu.cherian@cavium.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 11, 2017 at 08:12:38PM +0530, linucherian@gmail.com wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
> 
> Cavium CN99xx SMMUv3 implementation has two Silicon Erratas.
> 1. Errata ID #74
>    SMMU register alias Page 1 is not implemented
> 2. Errata ID #126
>    SMMU doesnt support unique IRQ lines for gerror, eventq and cmdq-sync

Is this device in production, or just part of a test chip?

Will
