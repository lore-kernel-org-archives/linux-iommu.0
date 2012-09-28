From: "Roedel, Joerg" <Joerg.Roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: 3.6-rc7 boot crash + bisection
Date: Fri, 28 Sep 2012 15:58:24 +0200
Message-ID: <20120928135824.GB4009@amd.com>
References: <20120924210348.5f50677b@brain.lan>
	<1348597970.28860.114.camel@bling.home>
	<20120925205420.0a07dea2@brain.lan>
	<1348602226.28860.132.camel@bling.home>
	<20120926132050.GB10549@amd.com>
	<1348670159.28860.183.camel@bling.home>
	<20120926151044.GE10549@amd.com>
	<1348676470.28860.197.camel@bling.home>
	<1348689013.28860.220.camel@bling.home>
	<1348697043.28860.235.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1348697043.28860.235.camel-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Florian Dazinger <florian-Q0TRQrZM+Zzk1uMJSBkQmQ@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 26, 2012 at 04:04:03PM -0600, Alex Williamson wrote:

> Here's a lockdep clean version of it:
> 
> amd_iommu: Handle aliases not backed by devices
> 
> Aliases sometimes don't have a struct pci_dev backing them.  This breaks
> our attempt to figure out the topology and device quirks that may effect
> IOMMU grouping.  When this happens, allocate an IOMMU group on the
> dev_data for the alias and make use of it for all devices referencing
> this alias.

Yes, this is the real fix. But it is too big for v3.6 at this time, so
I'll would take this for 3.7 and use my small fix for 3.6.

> Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index b64502d..4eacb17 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -71,6 +71,7 @@ static DEFINE_SPINLOCK(iommu_pd_list_lock);
>  /* List of all available dev_data structures */
>  static LIST_HEAD(dev_data_list);
>  static DEFINE_SPINLOCK(dev_data_list_lock);
> +static DEFINE_MUTEX(dev_data_iommu_group_lock);

I think this lock is not necessary. The iommu_init_device routine does
not run multiple times in parallel for the same device. So we should be
safe on that side.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
