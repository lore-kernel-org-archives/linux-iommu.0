From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [RFC PATCH v2 0/7] VFIO for device tree based platform devices
	(work in progress)
Date: Mon, 2 Dec 2013 17:30:11 +0100
Message-ID: <CAG8rG2zWfP+Ku5jD4DCCotpa=i6juiBTr99hsLJzJy2pqV-uZA@mail.gmail.com>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
	<20131201120954.1d6cec431a99a7ad5f34da18@linaro.org>
	<CAG8rG2zir5-hXaARvuDbZ=OnX2Zs7suy_DetxYHS++5VrHGZfA@mail.gmail.com>
	<20131202160832.8f5ee84355086cdb14d6a431@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131202160832.8f5ee84355086cdb14d6a431-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kim Phillips <kim.phillips-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, KVM devel mailing list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 2, 2013 at 5:08 PM, Kim Phillips <kim.phillips-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Mon, 2 Dec 2013 14:56:58 +0100
> Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org> wrote:
>
>> VFIO for platform is still under development, and cannot be used yet
>> to fully assign a device. However, looking at the example you ran, I
>> would not have expected it to fail so spectacularly, so this is
>> definitely something I will investigate for our next update to the
>
> it fails in executing this call in vfio-correctness-tests.c [1]:
>
> ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1_IOMMU);
>

Hm, I realize now that you where trying to bind the SMMU to the VFIO
driver. This is not the right way to use it, the SMMU device needs to
be bound by a valid SMMU driver. However, you need to bind the target
device to vfio-platform. To do that you need to edit the device tree,
as mentioned in the patch series description; this is because at the
time it was not possible to have a platform driver dynamically bind to
any device (this particular point will be fixed in future versions)

Also, you need to check from the device tree if the device is actually
linked with an SMMU. In my case I was testing using the MFC.

>> patch series. Thanks for pointing this out. I plan to release an
>> updated series with several improvements and fixes soon enough.
>
> may I ask how you test the patchseries currently?  If on arndale, any
> particular device?  Also, I'm assuming you're using a different
> userspace test than Alex Williamson's vfio-tests?
>

Since this is a work in progress, I initially used a custom test where
I directly put each IOCTL I was testing. Since devices on the Arndale
are not very well documented, today I am testing on the FastModels
SMMU model which includes a pl330 controller.

Keep in mind this version of the patchset is not supposed to fully let
you use a device with VFIO yet, just discover it and attempt some
basic mappings. In the meantime we have fixed several bugs when
actually trying to access memory regions, and added missing
functionality. Soon we will release a functional version along with
some easily reproducible tests.

Antonios

> Kim
>
> [1] git://github.com/awilliam/tests.git
