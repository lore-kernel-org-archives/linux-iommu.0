From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: iommu/amd: Implement dm_region call-backs
Date: Thu, 11 Jun 2015 11:02:51 +0300
Message-ID: <20150611080251.GF11734@mwanda>
References: <20150610153920.GC10549@mwanda>
 <20150611074327.GD16345@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150611074327.GD16345-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 11, 2015 at 09:43:27AM +0200, Joerg Roedel wrote:
> On Wed, Jun 10, 2015 at 06:39:20PM +0300, Dan Carpenter wrote:
> > Hello Joerg Roedel,
> > 
> > The patch b61238c4a5e1: "iommu/amd: Implement dm_region call-backs"
> > from May 28, 2015, leads to the following static checker warning:
> > 
> > 	drivers/iommu/amd_iommu.c:3153 amd_iommu_get_dm_regions()
> > 	error: potential null dereference 'region'.  (kzalloc returns null)
> 
> Thanks for the report, I added a check for the return value and folded
> it back into the original patch.
> 
> What static checker do you use, btw?

I'm using Smatch.

The ERR_PTR stuff requires that you run

	smatch_scripts/build_kernel_data.sh

At the start and that takes a couple hours.

regards,
dan carpenter
