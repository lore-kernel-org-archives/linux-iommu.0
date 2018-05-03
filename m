From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: amd: hide unused iommu_table_lock
Date: Thu, 3 May 2018 14:48:33 +0200
Message-ID: <20180503124832.f4klueztrtc664st@8bytes.org>
References: <20180404105713.633983-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180404105713.633983-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Baoquan He <bhe@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 04, 2018 at 12:56:59PM +0200, Arnd Bergmann wrote:
> The newly introduced lock is only used when CONFIG_IRQ_REMAP is enabled:
> 
> drivers/iommu/amd_iommu.c:86:24: error: 'iommu_table_lock' defined but not used [-Werror=unused-variable]
>  static DEFINE_SPINLOCK(iommu_table_lock);
> 
> This moves the definition next to the user, within the #ifdef protected
> section of the file.
> 
> Fixes: ea6166f4b83e ("iommu/amd: Split irq_lookup_table out of the amd_iommu_devtable_lock")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iommu/amd_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
