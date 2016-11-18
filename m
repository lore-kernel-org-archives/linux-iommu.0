From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v8 12/16] drivers: iommu: arm-smmu: split probe functions
 into DT/generic portions
Date: Fri, 18 Nov 2016 16:00:06 +0000
Message-ID: <20161118160006.GW13470@arm.com>
References: <20161116152936.22955-1-lorenzo.pieralisi@arm.com>
 <20161116152936.22955-13-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161116152936.22955-13-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: iommu@lists.linux-foundation.org, Hanjun Guo <hanjun.guo@linaro.org>, Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>, Eric Auger <eric.auger@redhat.com>, Sinan Kaya <okaya@codeaurora.org>, Nate Watterson <nwatters@codeaurora.org>, Prem Mallappa <prem.mallappa@broadcom.com>, Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 16, 2016 at 03:29:32PM +0000, Lorenzo Pieralisi wrote:
> Current ARM SMMU probe functions intermingle HW and DT probing
> in the initialization functions to detect and programme the ARM SMMU
> driver features. In order to allow probing the ARM SMMU with other
> firmwares than DT, this patch splits the ARM SMMU init functions into
> DT and HW specific portions so that other FW interfaces (ie ACPI) can
> reuse the HW probing functions and skip the DT portion accordingly.
> 
> This patch implements no functional change, only code reshuffling.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 62 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 37 insertions(+), 25 deletions(-)

Reviewed-by: Will Deacon <will.deacon@arm.com>

Although I'd also like Robin to have a look at this.

Will
