From: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 0/2][RFC] kernel/dma: Support platform-specific default CMA
	sizes
Date: Mon,  4 Mar 2019 12:52:53 +0100
Message-ID: <20190304115255.2088-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: ptesarik-AlSwsSmVLrQ@public.gmane.org, Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This is an RFC patch set that adds support for configuring a default CMA
size, depending on the platform.

At SUSE, our ARM installer image runs on a variety of platforms. One of 
these, the Raspberry Pi 3, requires CMA to be allocated on order to provide
graphics output. Currently this can be done with the kernel's cma command-
line parameter, or with a compile-time setting. The cma parameter requires
user intervention during boot. Using a compile-time constant affects all
platforms. So both options are undesireable.

This patch set adds a data structure and look-up code to select a default
CMA size, depending on the device's model name. The kernel's cma parameter
or a compile-time setting take precedence of the per-device default.

For the Raspberry Pi 3, the CMA allocator now reserves 64 MiB (out of 
1 GiB) by default. We found that this is enough memory to run a graphics
installer or a simple desktop environment under X11.

Thomas Zimmermann (2):
  kernel/dma: Support device-specific CMA defaults
  kernel/dma: Default to 64 MiB of contiguous memory on Raspberry Pi 3

 kernel/dma/contiguous.c | 62 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

-- 
2.20.1
