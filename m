From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/3] iommu: Expose IOMMU information in sysfs
Date: Fri, 4 Jul 2014 12:37:57 +0200
Message-ID: <20140704103757.GB13434@8bytes.org>
References: <20140612215954.2754.30263.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140612215954.2754.30263.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 12, 2014 at 04:12:18PM -0600, Alex Williamson wrote:
> Alex Williamson (3):
>       iommu: Add sysfs support for IOMMUs
>       iommu/intel: Make use of IOMMU sysfs support
>       iommu/amd: Add sysfs support
> 
> 
>  Documentation/ABI/testing/sysfs-class-iommu        |   17 +++
>  .../ABI/testing/sysfs-class-iommu-amd-iommu        |   14 ++
>  .../ABI/testing/sysfs-class-iommu-intel-iommu      |   32 +++++
>  drivers/iommu/Makefile                             |    1 
>  drivers/iommu/amd_iommu.c                          |    6 +
>  drivers/iommu/amd_iommu_init.c                     |   38 ++++++
>  drivers/iommu/amd_iommu_types.h                    |    3 
>  drivers/iommu/dmar.c                               |    9 +
>  drivers/iommu/intel-iommu.c                        |   77 +++++++++++-
>  drivers/iommu/iommu-sysfs.c                        |  133 ++++++++++++++++++++
>  include/linux/intel-iommu.h                        |    3 
>  include/linux/iommu.h                              |   26 ++++
>  12 files changed, 358 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-iommu
>  create mode 100644 Documentation/ABI/testing/sysfs-class-iommu-amd-iommu
>  create mode 100644 Documentation/ABI/testing/sysfs-class-iommu-intel-iommu
>  create mode 100644 drivers/iommu/iommu-sysfs.c

Also applied to the core branch, thanks Alex.
