From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/3 v14] iommu/fsl: Add additional iommu attributes
 required by the PAMU driver.
Date: Tue, 23 Apr 2013 15:38:38 +0200
Message-ID: <20130423133837.GG17148@8bytes.org>
References: <1366691726-9023-1-git-send-email-Varun.Sethi@freescale.com>
 <1366691726-9023-2-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1366691726-9023-2-git-send-email-Varun.Sethi@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Varun Sethi <Varun.Sethi@freescale.com>
Cc: iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, galak@kernel.crashing.org, benh@kernel.crashing.org, stuart.yoder@freescale.com, scottwood@freescale.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 23, 2013 at 10:05:25AM +0530, Varun Sethi wrote:
> Added the following domain attributes for the FSL PAMU driver:
> 1. Added new iommu stash attribute, which allows setting of the
>    LIODN specific stash id parameter through IOMMU API.
> 2. Added an attribute for enabling/disabling DMA to a particular
>    memory window.
> 3. Added domain attribute to check for PAMUV1 specific constraints.
> 
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> v14 changes:
> - Add FSL prefix to PAMU attributes.
> v13 changes:
> - created a new file include/linux/fsl_pamu_stash.h for stash
> attributes.
> v12 changes:
> - Moved PAMU specifc stash ids and structures to PAMU header file.
> - no change in v11.
> - no change in v10.
>  include/linux/fsl_pamu_stash.h |   39 +++++++++++++++++++++++++++++++++++++++

Isn't asm/ for your architecture a better place for that header?


	Joerg
