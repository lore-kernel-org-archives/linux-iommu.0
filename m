From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [RFC 1/5] driver core: amba: add device binding path
	'driver_override'
Date: Tue, 26 Aug 2014 09:43:32 +0200
Message-ID: <CAG8rG2yU8vc5dfja8SvVQqnUTrjyXwCjVYF9rjT1_9XuHTzBjQ@mail.gmail.com>
References: <1408698088-5349-1-git-send-email-a.motakis@virtualopensystems.com>
	<1408698088-5349-2-git-send-email-a.motakis@virtualopensystems.com>
	<20140825152909.43a6a02d972823056108dd95@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140825152909.43a6a02d972823056108dd95-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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
Cc: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, KVM devel mailing list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, alvise rigo <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 25, 2014 at 10:29 PM, Kim Phillips
<kim.phillips-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> On Fri, 22 Aug 2014 11:01:24 +0200
> Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org> wrote:
>
>> As already demonstrated with PCI [1] and the platform bus [2], a
>> driver_override property in sysfs can be used to bypass the id matching
>> of a device to a AMBA driver. This can be used by VFIO to bind to any AMBA
>> device requested by the user.
>>
>> [1] http://lists-archives.com/linux-kernel/28030441-pci-introduce-new-device-binding-path-using-pci_dev-driver_override.html
>> [2] https://www.redhat.com/archives/libvir-list/2014-April/msg00382.html
>>
>> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
>> ---
>>  drivers/amba/bus.c       | 43 +++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/amba/bus.h |  1 +
>
> missing Documentation/ABI/testing/sysfs-bus-amba entry?
>
> otherwise looks ok.

Yep, it will be included when integrated with the VFIO PLATFORM series.

>
> Thanks,
>
> Kim



-- 
Antonios Motakis
Virtual Open Systems
