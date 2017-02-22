From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v1 1/6] iommu/dmar: Fix crash on boot when DMAR is disabled
Date: Wed, 22 Feb 2017 12:26:17 +0100
Message-ID: <20170222112617.GD4154@suse.de>
References: <20170215144226.34519-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170215144226.34519-1-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Andy,

On Wed, Feb 15, 2017 at 04:42:21PM +0200, Andy Shevchenko wrote:
> By default CONFIG_INTEL_IOMMU_DEFAULT_ON is not set and thus
> dmar_disabled variable is set.
> 
> Intel IOMMU driver based on above doesn't set intel_iommu_enabled
> variable.
> 
> The commit b0119e870837 ("iommu: Introduce new 'struct iommu_device'")
> mistakenly assumes it never happens and tries to unregister not ever
> registered resources, which crashes the kernel at boot time:
> 
> 	BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> 	IP: iommu_device_unregister+0x31/0x60
> 
> Make unregister procedure conditional in free_iommu().
> 
> Fixes: b0119e870837 ("iommu: Introduce new 'struct iommu_device'")
> Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Thanks for the patch, I applied it and will send it upstream asap.



	Joerg
