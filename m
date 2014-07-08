From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] driver core: platform: add device binding path
	'driver_override'
Date: Tue, 8 Jul 2014 15:37:14 -0700
Message-ID: <20140708223714.GA15197@kroah.com>
References: <1398700371-20096-1-git-send-email-a.motakis@virtualopensystems.com>
	<1398700371-20096-2-git-send-email-a.motakis@virtualopensystems.com>
	<20140602194258.5135925bf3c71b9c010fb409@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140602194258.5135925bf3c71b9c010fb409-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kim Phillips <kim.phillips-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, clbchenlibo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Stefano Stabellini <stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org>, Julien Grall <julien.grall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 02, 2014 at 07:42:58PM -0500, Kim Phillips wrote:
> Needed by platform device drivers, such as the upcoming
> vfio-platform driver, in order to bypass the existing OF, ACPI,
> id_table and name string matches, and successfully be able to be
> bound to any device, like so:
> 
> echo vfio-platform > /sys/bus/platform/devices/fff51000.ethernet/driver_override
> echo fff51000.ethernet > /sys/bus/platform/devices/fff51000.ethernet/driver/unbind
> echo fff51000.ethernet > /sys/bus/platform/drivers_probe
> 
> This mimics "PCI: Introduce new device binding path using
> pci_dev.driver_override", which is an interface enhancement
> for more deterministic PCI device binding, e.g., when in the
> presence of hotplug.
> 
> Reviewed-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Reviewed-by: Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>
> Reviewed-by: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Kim Phillips <kim.phillips-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> Greg,
> 
> This is largely identical to the PCI version of the same that has
> been accepted for v3.16 and ack'd by you:
> 
> https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009674.html
> 
> and applied to Bjorn Helgaas' PCI tree:
> 
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/virtualization&id=782a985d7af26db39e86070d28f987cad21313c0
> 
> You are the platform driver core maintainer: can you apply this to
> your driver-core tree now?

Sorry for the very long delay, it's now merged in my tree.

Thanks for being persistant.

greg k-h
