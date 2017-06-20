From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v8 1/3] ACPI/IORT: Fixup SMMUv3 resource size for Cavium
 ThunderX2 SMMUv3 model
Date: Tue, 20 Jun 2017 19:01:02 +0100
Message-ID: <20170620180101.GD28035@arm.com>
References: <1497968259-16390-1-git-send-email-gakula@caviumnetworks.com>
 <1497968259-16390-2-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497968259-16390-2-git-send-email-gakula@caviumnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Geetha sowjanya <gakula@caviumnetworks.com>
Cc: robin.murphy@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org, robert.moore@intel.com, lv.zheng@intel.com, rjw@rjwysocki.net, jcm@redhat.com, linux-kernel@vger.kernel.org, robert.richter@cavium.com, catalin.marinas@arm.com, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, geethasowjanya.akula@gmail.com, devel@acpica.org, linu.cherian@cavium.com, Charles.Garcia-Tobin@arm.com, robh@kernel.org, Geetha Sowjanya <geethasowjanya.akula@cavium.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 20, 2017 at 07:47:37PM +0530, Geetha sowjanya wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
> 
> Cavium ThunderX2 implementation doesn't support second page in SMMU
> register space. Hence, resource size is set as 64k for this model.
> 
> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> ---
>  drivers/acpi/arm64/iort.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)

Looks fine to me, but I need Lorenzo's ack on this.

Will
