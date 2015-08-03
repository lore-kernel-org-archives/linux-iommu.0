From: Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 0/1] iommu: Detach device from domain when removed
	from group
Date: Mon, 3 Aug 2015 19:04:20 +0200
Message-ID: <20150803190420.74396481@thinkpad>
References: <1438106156-51847-1-git-send-email-gerald.schaefer@de.ibm.com>
	<20150803154855.GI14980@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150803154855.GI14980-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 3 Aug 2015 17:48:55 +0200
Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> On Tue, Jul 28, 2015 at 07:55:55PM +0200, Gerald Schaefer wrote:
> > On s390, this eventually leads to a kernel panic when binding the device
> > again to its non-vfio PCI driver, because of the missing arch-specific
> > cleanup in detach_dev. On x86, the detach_dev callback will also not be
> > called directly, but there is a notifier that will catch
> > BUS_NOTIFY_REMOVED_DEVICE and eventually do the cleanup. Other
> > architectures w/o the notifier probably have at least some kind of memory
> > leak in this scenario, so a general fix would be nice.
> 
> This notifier is not arch-specific, but registered against the bus the
> iommu-ops are set for. Why does it not run on s390?

Adding the notifier would of course also work on s390 (and all other affected
architectures). However, it seems that the "missing detach_dev" issue in this
scenario is not fundamentally fixed by using this notifier, it just seems to
hide the symptom by chance.

Adding the otherwise unneeded notifier just to work around this issue somehow
doesn't seem right, also given that x86 is so far the only user of it. At
least I thought it would be cleaner to fix it in common code and for all
architectures. Not sure what's wrong with fixing the asymmetry as suggested
in my patch, but I guess there are good reasons for having this asymmetry.

For now, I'll just add the notifier to my s390 implementation and post it
soon.

> 
> 
> 	Joerg
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
