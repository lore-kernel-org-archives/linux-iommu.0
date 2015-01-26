From: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] iommu/ipmmu-vmsa: Use the ARM LPAE page table allocator
Date: Mon, 26 Jan 2015 13:46:03 +0100
Message-ID: <20150126124603.GE4653@8bytes.org>
References: <20150119140106.GM6343@8bytes.org> <3530276.KVdcG9umfv@avalon>
	<20150121152724.GB30345@8bytes.org> <2654819.qtgnKgjAAR@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2654819.qtgnKgjAAR@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 21, 2015 at 05:31:05PM +0200, Laurent Pinchart wrote:
> On Wednesday 21 January 2015 16:27:24 joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org wrote:
> > On Wed, Jan 21, 2015 at 05:07:03PM +0200, Laurent Pinchart wrote:
> > > As you wish. I just thought you would prefer merging the series with at
> > > least one user.
> > 
> > Yes, and with your patch there would be two users: ARM-SMMU and the VMSA
> > IPMMU. So ideally I would apply/pull Will's patches on v3.19-rc5 with
> > your patch on-top (and no other patches as dependency).
> 
> But that would conflict with the IPMMU patches that you have already queued 
> for v3.20.

Okay, I merged the arm/smmu branch into arm/renesas and applied your
patch on-top.
