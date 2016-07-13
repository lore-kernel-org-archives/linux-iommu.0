From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] iommu: simplify and fix ida handling
Date: Wed, 13 Jul 2016 12:29:28 +0200
Message-ID: <20160713102928.GE27306@suse.de>
References: <e6d78cf6-2af6-8638-6f08-70025b720265@gmail.com>
	<20160704114648.GE11467@suse.de>
	<7c77402b-cbcb-1ac0-d81a-0e7c92201ee8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7c77402b-cbcb-1ac0-d81a-0e7c92201ee8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 04, 2016 at 09:01:18PM +0200, Heiner Kallweit wrote:
> Am 04.07.2016 um 13:46 schrieb Joerg Roedel:
> > On Wed, Jun 29, 2016 at 09:13:59PM +0200, Heiner Kallweit wrote:
> >> Ida handling can be much simplified by using the ida_simple_.. functions.
> >>
> >> This change also fixes the bug that previously checking for errors
> >> returned by ida_get_new() was incomplete.
> >> ida_get_new() can return errors other than EAGAIN, e.g. ENOSPC.
> >> This case wasn't handled.
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> ---
> >>  drivers/iommu/iommu.c | 24 ++++++------------------
> >>  1 file changed, 6 insertions(+), 18 deletions(-)
> > 
> > The patch does not apply. Please rebase it against the latest upstream
> > kernel and resend.
> > 
> This patch applies on top of patch "[PATCH 1/3] iommu: simplify init function"
> I submitted on June 28th. Do you have an opinion on that patch?

Applied both, thanks.
