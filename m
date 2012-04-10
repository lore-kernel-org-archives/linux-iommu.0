From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] IOMMU groups
Date: Tue, 10 Apr 2012 15:03:21 -0600
Message-ID: <1334091801.3799.387.camel@bling.home>
References: <20120402203721.28977.95285.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120402203721.28977.95285.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


Ping.  Does this approach look like it could satisfy your desire for a
more integrated group layer?  I'd really like to move VFIO forward,
we've been stalled on this long enough.  David Woodhouse, I think this
provides the quirking you're looking for for device like the Ricoh, do
you have any other requirements for a group layer?  Thanks,

Alex

On Mon, 2012-04-02 at 15:14 -0600, Alex Williamson wrote:
> This series attempts to make IOMMU device grouping a slightly more
> integral part of the device model.  iommu_device_groups were originally
> introduced to support the VFIO user space driver interface which needs
> to understand the granularity of device isolation in order to ensure
> security of devices when assigned for user access.  This information
> was provided via a simple group identifier from the IOMMU driver allowing
> VFIO to walk devices and assemble groups itself.
> 
> The feedback received from this was that groups should be the effective
> unit of work for the IOMMU API.  The existing model of allowing domains
> to be created and individual devices attached ignores many of the
> restrictions of the IOMMU, whether by design, by topology or by defective
> devices.  Additionally we should be able to use the grouping information
> at the dma ops layer for managing domains and quirking devices.
> 
> This series is a sketch at implementing only those aspects and leaving
> everything else about the multifaceted hairball of Isolation groups for
> another API.  Please comment and let me know if this seems like the
> direction we should be headed.  Thanks,
> 
> Alex
> 
> 
> ---
> 
> Alex Williamson (3):
>       iommu: Create attach/detach group interface
>       iommu: Create basic group infrastructure and update AMD-Vi & Intel VT-d
>       iommu: Introduce iommu_group
> 
> 
>  drivers/iommu/amd_iommu.c   |   50 ++++++----
>  drivers/iommu/intel-iommu.c |   76 ++++++++--------
>  drivers/iommu/iommu.c       |  210 ++++++++++++++++++++++++++++++++++++++-----
>  include/linux/device.h      |    2 
>  include/linux/iommu.h       |   43 +++++++++
>  5 files changed, 301 insertions(+), 80 deletions(-)
