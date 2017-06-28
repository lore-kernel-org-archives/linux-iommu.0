From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2] iommu/amd: Fix interrupt remapping when disable
 guest_mode
Date: Wed, 28 Jun 2017 14:44:48 +0200
Message-ID: <20170628124447.GA28603@8bytes.org>
References: <1498469284-85652-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1498469284-85652-1-git-send-email-suravee.suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 26, 2017 at 04:28:04AM -0500, Suravee Suthikulpanit wrote:
> Pass-through devices to VM guest can get updated IRQ affinity
> information via irq_set_affinity() when not running in guest mode.
> Currently, AMD IOMMU driver in GA mode ignores the updated information
> if the pass-through device is setup to use vAPIC regardless of guest_mode.
> This could cause invalid interrupt remapping.
> 
> Also, the guest_mode bit should be set and cleared only when
> SVM updates posted-interrupt interrupt remapping information.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Joerg Roedel <jroedel@suse.de>

Nervermind, I added this fixes line and applied the patch:

	Fixes: d98de49a53e48 ('iommu/amd: Enable vAPIC interrupt remapping mode by default'
