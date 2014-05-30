From: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [RFC PATCH v5_v2 01/11] driver core: platform: add device binding
	path 'driver_override'
Date: Fri, 30 May 2014 00:36:35 +0000
Message-ID: <9a17e6ce9d2e4da39ec4254ae8814d5e@BY2PR03MB348.namprd03.prod.outlook.com>
References: <1398700371-20096-1-git-send-email-a.motakis@virtualopensystems.com>
	<1398700371-20096-2-git-send-email-a.motakis@virtualopensystems.com>
	<20140520192537.bab9fa2088c1cd5da3f92639@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140520192537.bab9fa2088c1cd5da3f92639-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kim Phillips <kim.phillips-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Cc: Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>, Julien Grall <julien.grall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "clbchenlibo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <clbchenlibo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org" <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Stefano Stabellini <stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org>, kvmarm-FPEHb7Xf0XX1GAl8QSHYmA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


> -----Original Message-----
> From: Kim Phillips [mailto:kim.phillips-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org]
> Sent: Tuesday, May 20, 2014 7:26 PM
> To: a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org
> Cc: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org;
> a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org; rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org; Yoder Stuart-
> B08248; rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org; grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org;
> tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org; clbchenlibo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org;
> christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; Julien Grall; Ian
> Campbell; Stefano Stabellini; Alexander Graf
> Subject: [RFC PATCH v5_v2 01/11] driver core: platform: add device
> binding path 'driver_override'
> 
> From: Kim Phillips <kim.phillips-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> 
> Needed by platform device drivers, such as the vfio-platform driver
> later in series, in order to bypass the existing OF, ACPI, id_table and
> name string matches, and successfully be able to be bound to any
> device, like so:
> 
> echo vfio-platform >
> /sys/bus/platform/devices/fff51000.ethernet/driver_override
> echo fff51000.ethernet >
> /sys/bus/platform/devices/fff51000.ethernet/driver/unbind
> echo fff51000.ethernet > /sys/bus/platform/drivers_probe
> 
> This mimics "PCI: Introduce new device binding path using
> pci_dev.driver_override" [1], which is an interface enhancement
> for more deterministic PCI device binding, e.g., when in the
> presence of hotplug.
> 
> [1] https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009527.html
> 
> Suggested-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Kim Phillips <kim.phillips-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> changes in v2 patch of v5 of this patchseries:
> - rebased onto today's Linus' ToT
> - added kfree to match PCI counterpart fix, as Alex Williamson
>   just posted a v3 of the patch (thanks Christoffer for the
>   notification)
> - in the commit text, replaced vfio platform driver reference with
>   'later in series', and updated the PCI version mailing list reference
>   to the v3 version.

Reviewed-by: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Stuart
