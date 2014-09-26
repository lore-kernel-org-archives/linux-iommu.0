From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [PATCHv7 13/26] vfio: amba: add the VFIO for AMBA devices module
	to Kconfig
Date: Fri, 26 Sep 2014 17:06:52 +0200
Message-ID: <CAG8rG2xgXZsNMC-UrnjTmxAisO1gmboZXHMq1bi5Fm+VpZH-Ag@mail.gmail.com>
References: <1411483586-29304-1-git-send-email-a.motakis@virtualopensystems.com>
	<1411483586-29304-14-git-send-email-a.motakis@virtualopensystems.com>
	<1411513877.24563.62.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1411513877.24563.62.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
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
Cc: KVM devel mailing list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 24, 2014 at 1:11 AM, Alex Williamson
<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Tue, 2014-09-23 at 16:46 +0200, Antonios Motakis wrote:
>> Enable building the VFIO AMBA driver. VFIO_AMBA depends on VFIO_PLATFORM,
>> since it is sharing a portion of the code, and it is essentially implemented
>> as a platform device whose resources are discovered via AMBA specific APIs
>> in the kernel.
>>
>> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
>> ---
>>  drivers/vfio/platform/Kconfig  | 10 ++++++++++
>>  drivers/vfio/platform/Makefile |  4 ++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/vfio/platform/Kconfig b/drivers/vfio/platform/Kconfig
>> index c51af17..8b97786 100644
>> --- a/drivers/vfio/platform/Kconfig
>> +++ b/drivers/vfio/platform/Kconfig
>> @@ -7,3 +7,13 @@ config VFIO_PLATFORM
>>         framework.
>>
>>         If you don't know what to do here, say N.
>> +
>> +config VFIO_AMBA
>> +     tristate "VFIO support for AMBA devices"
>> +     depends on VFIO && VFIO_PLATFORM && EVENTFD && ARM_AMBA
>
> nit, VFIO_PLATFORM already depends on VFIO && EVENTFD

Ack

>
>> +     help
>> +       Support for ARM AMBA devices with VFIO. This is required to make
>> +       use of ARM AMBA devices present on the system using the VFIO
>> +       framework.
>> +
>> +       If you don't know what to do here, say N.
>> diff --git a/drivers/vfio/platform/Makefile b/drivers/vfio/platform/Makefile
>> index 279862b..1957170 100644
>> --- a/drivers/vfio/platform/Makefile
>> +++ b/drivers/vfio/platform/Makefile
>> @@ -2,3 +2,7 @@
>>  vfio-platform-y := vfio_platform.o vfio_platform_common.o
>>
>>  obj-$(CONFIG_VFIO_PLATFORM) += vfio-platform.o
>> +
>> +vfio-amba-y := vfio_amba.o
>> +
>> +obj-$(CONFIG_VFIO_AMBA) += vfio-amba.o
>
>
>



-- 
Antonios Motakis
Virtual Open Systems
