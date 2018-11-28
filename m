From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 5/9] iommu: ipmmu-vmsa: make it explicitly non-modular
Date: Wed, 28 Nov 2018 19:22:37 +0200
Message-ID: <7671106.x9S16LaZuq@avalon>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com> <cdded4c3-4bc5-39b3-ebc9-64fa145c9242@arm.com> <20181128153204.GI14659@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128153204.GI14659@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Paul,

On Wednesday, 28 November 2018 17:32:05 EET Paul Gortmaker wrote:
> [Re: [PATCH 5/9] iommu: ipmmu-vmsa: make it explicitly non-modular] On 
28/11/2018 (Wed 12:50) Robin Murphy wrote:
> > On 26/11/2018 22:31, Paul Gortmaker wrote:
> [...]
> 
> >> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> >> index 9e2655f1c1bf..de39ef992d8a 100644
> >> --- a/drivers/iommu/ipmmu-vmsa.c
> >> +++ b/drivers/iommu/ipmmu-vmsa.c
> >> @@ -1,6 +1,8 @@
> >>
> >>  // SPDX-License-Identifier: GPL-2.0
> >>  /*
> >>   * IPMMU VMSA
> > 
> > Nit: this line doesn't convey any information that the module description
> > below doesn't also say far more clearly, so you may as well just replace
> > it entirely.
> 
> No problem. Will do in v2.

With that change, the blank line after MODULE_DEVICE_TABLE() removed, and 
<linux/init.h> moved to keep alphabetical order sorting of the includes, 
please add

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

to v2. Thank you for the patch.

> > >+ * IOMMU API for Renesas VMSA-compatible IPMMU
> > >+ * Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> [...]

-- 
Regards,

Laurent Pinchart
