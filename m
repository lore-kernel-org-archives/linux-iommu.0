From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [RFC 0/5] vfio: AMBA devices support
Date: Tue, 26 Aug 2014 09:41:45 +0200
Message-ID: <CAG8rG2zDCfJjVBVZu2OCCNJrJ-qisaARtQU_kKjfTNNLdX66MQ@mail.gmail.com>
References: <1408698088-5349-1-git-send-email-a.motakis@virtualopensystems.com>
	<20140825185611.cc359282a66d6afe7a4a590e@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140825185611.cc359282a66d6afe7a4a590e-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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

On Tue, Aug 26, 2014 at 1:56 AM, Kim Phillips
<kim.phillips-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
>
> On Fri, 22 Aug 2014 11:01:23 +0200
> Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org> wrote:
>
> > This patch series depends on the VFIO for PLATFORM devices patch series,
> > and implements AMBA device support for VFIO.
>
> ...
>
> >  drivers/amba/bus.c                            |  43 +++
> >  drivers/vfio/platform/Kconfig                 |  10 +
> >  drivers/vfio/platform/Makefile                |   6 +-
> >  drivers/vfio/platform/vfio_amba.c             | 129 +++++++++
> >  drivers/vfio/platform/vfio_platform.c         | 355 +-----------------------
> >  drivers/vfio/platform/vfio_platform_common.c  | 380 ++++++++++++++++++++++++++
> >  drivers/vfio/platform/vfio_platform_irq.c     |   6 +-
> >  drivers/vfio/platform/vfio_platform_private.h |   9 +-
> >  include/linux/amba/bus.h                      |   1 +
> >  9 files changed, 591 insertions(+), 348 deletions(-)
> >  create mode 100644 drivers/vfio/platform/vfio_amba.c
> >  create mode 100644 drivers/vfio/platform/vfio_platform_common.c
>
> I think this patchseries should be merged with its dependent
> patchseries, in order to not have to review the common vfio_platform
> code twice.

Yeah, my intention is to squash them into one series for the next
version of VFIO PLATFORM, so we are in agreement here.

>
> just my 2c.
>
> Thanks,
>
> Kim




-- 
Antonios Motakis
Virtual Open Systems
