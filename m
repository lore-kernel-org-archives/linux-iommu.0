From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 1/2] vfio: Allow No-IOMMU mode without checking
 iommu_present()
Date: Thu, 20 Jul 2017 10:19:10 +0100
Message-ID: <20170720091909.GC17837@arm.com>
References: <1500525154-5200-1-git-send-email-anup.patel@broadcom.com>
 <1500525154-5200-2-git-send-email-anup.patel@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500525154-5200-2-git-send-email-anup.patel@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anup Patel <anup.patel@broadcom.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 20, 2017 at 10:02:33AM +0530, Anup Patel wrote:
> Not allowing No-IOMMU mode for devices already having
> iommu_ops on their bus is very conservative.
> 
> We now have IOMMU (such as ARM SMMU) which can bypass
> transcations when IOMMU is not configured for a given
> device. In addition, it is not necessary to have all
> devices on bus to be upstream to an IOMMU on that bus.

How does the SMMU know to bypass in these cases? As I explained before, the
driver-specific command line option is the wrong way to go about arranging
this.

Will
