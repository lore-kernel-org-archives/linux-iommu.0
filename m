From: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH 5/9] iommu: ipmmu-vmsa: make it explicitly non-modular
Date: Wed, 28 Nov 2018 10:32:05 -0500
Message-ID: <20181128153204.GI14659@windriver.com>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
	<1543271498-28966-6-git-send-email-paul.gortmaker@windriver.com>
	<cdded4c3-4bc5-39b3-ebc9-64fa145c9242@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cdded4c3-4bc5-39b3-ebc9-64fa145c9242-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

[Re: [PATCH 5/9] iommu: ipmmu-vmsa: make it explicitly non-modular] On 28/11/2018 (Wed 12:50) Robin Murphy wrote:

> On 26/11/2018 22:31, Paul Gortmaker wrote:

[...]

> >diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> >index 9e2655f1c1bf..de39ef992d8a 100644
> >--- a/drivers/iommu/ipmmu-vmsa.c
> >+++ b/drivers/iommu/ipmmu-vmsa.c
> >@@ -1,6 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * IPMMU VMSA
> 
> Nit: this line doesn't convey any information that the module description
> below doesn't also say far more clearly, so you may as well just replace it
> entirely.

No problem. Will do in v2.

P.
--

> 
> Robin.
> 
> >+ * IOMMU API for Renesas VMSA-compatible IPMMU
> >+ * Author: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

[...]
