From: "joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [PATCH] amd/iommu: Fix Guest Virtual APIC Log Tail Address
 Register
Date: Mon, 12 Nov 2018 15:08:33 +0100
Message-ID: <20181112140833.uctt6mfi6lxb37fn@8bytes.org>
References: <20181112122611.129219-1-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181112122611.129219-1-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Filippo Sironi <sironi@amazon.de>, Wei Wang <wawei@amazon.de>
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 12, 2018 at 12:26:30PM +0000, Suthikulpanit, Suravee wrote:
> From: Filippo Sironi <sironi@amazon.de>
> 
> This register should have been programmed with the physical address
> of the memory location containing the shadow tail pointer for
> the guest virtual APIC log instead of the base address.
> 
> Fixes: 8bda0cfbdc1a  ('iommu/amd: Detect and initialize guest vAPIC log')
> Signed-off-by: Filippo Sironi <sironi@amazon.de>
> Signed-off-by: Wei Wang <wawei@amazon.de>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd_iommu_init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to iommu/fixes, thanks.
