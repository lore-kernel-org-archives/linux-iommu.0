From: Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [RFC PATCH v5_v2 01/11] driver core: platform: add device binding
	path 'driver_override'
Date: Thu, 29 May 2014 23:24:11 +0200
Message-ID: <5387A57B.6050204@suse.de>
References: <1398700371-20096-1-git-send-email-a.motakis@virtualopensystems.com>	
	<1398700371-20096-2-git-send-email-a.motakis@virtualopensystems.com>	
	<20140520192537.bab9fa2088c1cd5da3f92639@linaro.org>
	<1401392619.2412.102.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1401392619.2412.102.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kim Phillips <kim.phillips-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Julien Grall <julien.grall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, clbchenlibo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, Stefano Stabellini <stefano.stabellini-mvvWK6WmYclDPfheJLI6IQ@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


On 29.05.14 21:43, Alex Williamson wrote:
> On Tue, 2014-05-20 at 19:25 -0500, Kim Phillips wrote:
>> From: Kim Phillips <kim.phillips-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>
>> Needed by platform device drivers, such as the vfio-platform driver
>> later in series, in order to bypass the existing OF, ACPI, id_table and
>> name string matches, and successfully be able to be bound to any
>> device, like so:
>>
>> echo vfio-platform > /sys/bus/platform/devices/fff51000.ethernet/driver_override
>> echo fff51000.ethernet > /sys/bus/platform/devices/fff51000.ethernet/driver/unbind
>> echo fff51000.ethernet > /sys/bus/platform/drivers_probe
>>
>> This mimics "PCI: Introduce new device binding path using
>> pci_dev.driver_override" [1], which is an interface enhancement
>> for more deterministic PCI device binding, e.g., when in the
>> presence of hotplug.
>>
>> [1] https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009527.html
>>
>> Suggested-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Kim Phillips <kim.phillips-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Looks largely identical to the PCI version of the same that has been
> accepted for v3.16 and ack'd by GregKH.
>
> Reviewed-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Yup, would be great to have feature parity for device binding on 
platform and PCI.

Reviewed-by: Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>


Alex
