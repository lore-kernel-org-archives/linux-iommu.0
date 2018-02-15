From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 02/37] iommu/sva: Bind process address spaces to devices
Date: Thu, 15 Feb 2018 12:46:36 +0000
Message-ID: <9d440890-cb57-c890-334d-c40a6c68566e@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
	<20180212183352.22730-3-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D191002897@SHSMSX101.ccr.corp.intel.com>
	<b9eacb30-817f-9027-bc0a-1f01cf9f13f9@arm.com>
	<20180215102113.c7t7rrnyzgazmdli@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180215102113.c7t7rrnyzgazmdli-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "mykyta.iziumtsev-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <mykyta.iziumtsev-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Raj,
	Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, dwmw
List-Id: iommu@lists.linux-foundation.org

On 15/02/18 10:21, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org wrote:
> On Tue, Feb 13, 2018 at 12:57:23PM +0000, Jean-Philippe Brucker wrote:
>> * bind_device() fails if the device's group has more than one device,
>> otherwise calls __bind_device(). This prevents device drivers that are
>> oblivious to IOMMU groups from opening a backdoor.
>>
>> * bind_group() calls __bind_device() for all devices in group. This way
>> users that are aware of IOMMU groups can still use them safely. Note that
>> at the moment bind_group() fails as soon as it finds a device that doesn't
>> support SVA. Having all devices support SVA in a given group is
>> unrealistic and this behavior ought to be improved.
> 
> Yeah, so the problem on PCI is that all functions of a multi-function
> device are put into one group. For AMD-GPUs this means that the GPU
> (SVA-capable) will end up in the same group as the on-GPU sound
> device (not SVA-capable).

As I understood it ACS also isolate functions within a device, for example
the two PFs of my ixgbe card are in different groups. Strangely all VFs go
in the same group, I haven't investigated why yet.

> Before this causes us big headaches I suggest to only provide the
> bind_device() function.

Ok. I added bind_group() to make it easier for VFIO - so if one bind()
fails in the group, iommu.c can rollback and remove the bonds already
created. If we mandate a single device in the group for SVA, then VFIO can
use iommu_group_for_each_dev() and ensure that the callback was only
called once.

> This should be fine because for SVA we don't
> need all types of isolation that iommu_groups provide.
> 
> IOMMU-groups provide two types of isolation:
> 
> 	1) They group devices together which the IOMMU can't distinguish
> 	   from each other, like PCI devices behind a PCIe bridge.
> 
> 	2) Devices that can't be isolated from each other are also put
> 	   into the same group. This is the case for multi-function PCIe
> 	   devices as well as all PCIe devices behind a non-ACS bridge.
> 	   But all these devices cann still be distinguished by the
> 	   IOMMU.

But transactions don't necessarily reach the IOMMU if devices are not
isolated by ACS. So even if you disable all translation in the IOMMU for
one device in the group, it may still have a view of address spaces shared
with another device in that group.

> These two types of protection are needed to safely assign devices to
> guests, but for bare-metal SVA all we need is type 1) isolation, and
> not even that if we can assume that all SVA-capable devices have an
> exclusive device-id (or stream-id).

I'm not as optimistic that we won't need IOMMU groups with SVA devices for
2) (hardware bugs, integration issues, etc). I'd be more comfortable if we
added a sanity-check as suggested by Kevin, to ensure that SVA is
disallowed if multiple devices are in the group.

Thanks,
Jean
