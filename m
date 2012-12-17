From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH/WIP/RFC 02/14] shmobile-iommu: Move IPMMU driver to
	drivers/iommu
Date: Mon, 17 Dec 2012 09:45:03 +0100
Message-ID: <1626129.3KmpqDAOtk@avalon>
References: <1350290093-998-1-git-send-email-hdk@igel.co.jp>
	<1355678760-27357-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<50CE8D24.3010604@igel.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <50CE8D24.3010604-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Damian Hobson-Garcia <dhobsong-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>
Cc: Katsuya MATSUBARA <matsu-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Hideki EIRAKU <hdk-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Damian,

(CC'ing iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org)

On Monday 17 December 2012 12:10:28 Damian Hobson-Garcia wrote:
> On 2012/12/17 2:25, Laurent Pinchart wrote:
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> > ---
> > 
> >  arch/arm/mach-shmobile/Kconfig                     |    6 ------
> >  arch/arm/mach-shmobile/Makefile                    |    3 ---
> >  drivers/iommu/Kconfig                              |    6 ++++++
> >  drivers/iommu/Makefile                             |    1 +
> >  .../ipmmu.c => drivers/iommu/shmobile-ipmmu.c      |    0
> >  5 files changed, 7 insertions(+), 9 deletions(-)
> >  rename arch/arm/mach-shmobile/ipmmu.c => drivers/iommu/shmobile-ipmmu.c
> >  (100%)
>
> I agree that arch/arm is not a good place, but I'm not completely sure that
> ipmmu.c belongs in drivers/iommu.  The reason is because of the PMB
> functionality provided by the IPMMU.  The PMB provides a fixed address
> remapping capability that is completely unrelated to the IOMMU
> functionality.  Since this remapping is done by writing the IPMMU registers
> directly, instead of via a page table it doesn't really fit in well with the
> IOMMU API (it also supports things like tiled/linear address translation,
> which require some other method to set up).  Since the PMB and the IOMMU
> functions of the IPPMU share the same register address space, we would like
> to have one driver to handle the register accesses of both of these
> functions.  That driver is ipmmu.c.  So if ipmmu.c is in drivers/iommu, the
> entire IOMMU subsystem must be enabled in order to use the PMB
> functionality. So maybe it might be better to treat the IPMMU like a
> multifuction device, with a core driver (ipmmu.c) in one location and the
> function implementations in their own respective directories. Does
> drivers/mfd sound like a good place for it?

I've thought about this as well. The IPMMU indeed provides two different 
functions, so drivers/mfd/ could be a candidate. This being said, both the 
IOMMU function and the PMB function are related to virtual memory space 
management, so they're not totally unrelated. I agree that the PMB function 
isn't really an IOMMU in the sense that it will likely not be exposed through 
the existing IOMMU API.

However, drivers/iommu/ seems to me like a more natural place to store the 
IPMMU driver compared to drivers/mfd/. Enabling IOMMU support 
(CONFIG_IOMMU_SUPPORT) doesn't mean the IOMMU core (CONFIG_IOMMU_API) will be 
compiled in. There would thus be no extra code compiled in if the IOMMU 
function of the IPMMU is disabled.

-- 
Regards,

Laurent Pinchart
