From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [GIT PULL (PATCH 0/4)] VFIO driver for v3.6
Date: Tue, 31 Jul 2012 08:53:35 -0600
Message-ID: <1343746415.3368.5.camel@ul30vt>
References: <20120725142254.12800.61860.stgit@bling.home>
	<20120727053206.GC11870@drongo> <1343690279.8073.215.camel@ul30vt>
	<CA+55aFzTzO-jzHNYSW6Hb5_kmP6aYCWH_hbAauLUn9rf9iLg_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CA+55aFzTzO-jzHNYSW6Hb5_kmP6aYCWH_hbAauLUn9rf9iLg_w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, agraf-l3A5Bk7waGM@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2012-07-30 at 22:11 -0700, Linus Torvalds wrote:
> On Mon, Jul 30, 2012 at 4:17 PM, Alex Williamson
> <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >
> > I'm pretty anxious to find out as well.  Linus, ping, any thoughts on
> > including this in 3.6?  Thanks,
> 
> I just pulled it, but then I unpulled again when I realized it's not a
> signed tag and it's on github.
> 
> Please, people. Do tagged releases with proper signatures if you're
> not using kernel.org or other controlled servers. In fact, I prefer
> signed tags even if you *do* use kernel.org etc.

Sorry about that, Linus.  I think this is a properly signed tag, please
let me know if I'm still screwing up.  Thanks,

Alex

The following changes since commit 2e3ee613480563a6d5c01b57d342e65cc58c06df:

  Merge tag 'writeback-proportions' of git://git.kernel.org/pub/scm/linux/kernel/git/wfg/linux (2012-07-30 22:14:04 -0700)

are available in the git repository at:


  git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:awilliam/linux-vfio.git tags/vfio-for-v3.6

for you to fetch changes up to 89e1f7d4c66d85f42c3d52ea3866eb10cadf6153:

  vfio: Add PCI device driver (2012-07-31 08:16:24 -0600)

----------------------------------------------------------------
VFIO for v3.6

----------------------------------------------------------------
Alex Williamson (4):
      vfio: VFIO core
      vfio: Add documentation
      vfio: Type1 IOMMU implementation
      vfio: Add PCI device driver

 Documentation/ioctl/ioctl-number.txt |    1 +
 Documentation/vfio.txt               |  314 +++++++
 MAINTAINERS                          |    8 +
 drivers/Kconfig                      |    2 +
 drivers/Makefile                     |    1 +
 drivers/vfio/Kconfig                 |   16 +
 drivers/vfio/Makefile                |    3 +
 drivers/vfio/pci/Kconfig             |    8 +
 drivers/vfio/pci/Makefile            |    4 +
 drivers/vfio/pci/vfio_pci.c          |  579 +++++++++++++
 drivers/vfio/pci/vfio_pci_config.c   | 1540 ++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_intrs.c    |  740 ++++++++++++++++
 drivers/vfio/pci/vfio_pci_private.h  |   91 ++
 drivers/vfio/pci/vfio_pci_rdwr.c     |  269 ++++++
 drivers/vfio/vfio.c                  | 1420 +++++++++++++++++++++++++++++++
 drivers/vfio/vfio_iommu_type1.c      |  753 +++++++++++++++++
 include/linux/vfio.h                 |  445 ++++++++++
 17 files changed, 6194 insertions(+)
 create mode 100644 Documentation/vfio.txt
 create mode 100644 drivers/vfio/Kconfig
 create mode 100644 drivers/vfio/Makefile
 create mode 100644 drivers/vfio/pci/Kconfig
 create mode 100644 drivers/vfio/pci/Makefile
 create mode 100644 drivers/vfio/pci/vfio_pci.c
 create mode 100644 drivers/vfio/pci/vfio_pci_config.c
 create mode 100644 drivers/vfio/pci/vfio_pci_intrs.c
 create mode 100644 drivers/vfio/pci/vfio_pci_private.h
 create mode 100644 drivers/vfio/pci/vfio_pci_rdwr.c
 create mode 100644 drivers/vfio/vfio.c
 create mode 100644 drivers/vfio/vfio_iommu_type1.c
 create mode 100644 include/linux/vfio.h
