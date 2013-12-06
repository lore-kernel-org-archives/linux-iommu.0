From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [GIT PULL] iommu: arm/smmu: fixes for 3.13
Date: Fri, 06 Dec 2013 14:47:35 -0700
Message-ID: <1386366455.25738.511.camel@ul30vt.home>
References: <20131206175319.GD8853@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131206175319.GD8853-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 2013-12-06 at 17:53 +0000, Will Deacon wrote:
> Hi Alex (CC'ing Joerg),
> 
> Please can you pull the following fixes to the arm/smmu driver for 3.13?

Hi Will,

I'll use my vfio tree since it's already included in next.  I've pulled
to here:

git://github.com/awilliam/linux-vfio.git for-linus

Unless something explodes I'll forward it on next week.  Thanks,

Alex

> --->8
> 
> The following changes since commit dc1ccc48159d63eca5089e507c82c7d22ef60839:
> 
>   Linux 3.13-rc2 (2013-11-29 12:57:14 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/fixes
> 
> for you to fetch changes up to 89a23cde75a7f0b3d8b0c156964eca0c23d2f1eb:
> 
>   iommu/arm-smmu: fix error return code in arm_smmu_device_dt_probe() (2013-12-06 16:44:25 +0000)
> 
> ----------------------------------------------------------------
> Wei Yongjun (1):
>       iommu/arm-smmu: fix error return code in arm_smmu_device_dt_probe()
> 
> Will Deacon (2):
>       iommu/arm-smmu: use mutex instead of spinlock for locking page tables
>       iommu/arm-smmu: remove potential NULL dereference on mapping path
> 
>  drivers/iommu/arm-smmu.c | 66 ++++++++++++++++++++----------------------------
>  1 file changed, 28 insertions(+), 38 deletions(-)
