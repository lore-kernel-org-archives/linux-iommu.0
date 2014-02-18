From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: fixes for 3.14
Date: Tue, 18 Feb 2014 12:27:46 +0100
Message-ID: <20140218112745.GA3228@8bytes.org>
References: <20140210183232.GH12826@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140210183232.GH12826-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 10, 2014 at 06:32:32PM +0000, Will Deacon wrote:
> The following changes since commit b28a960c42fcd9cfc987441fa6d1c1a471f0f9ed:
> 
>   Linux 3.14-rc2 (2014-02-09 18:15:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/fixes
> 
> for you to fetch changes up to d123cf82d339c5cc4ffe2a481e0caa23a501d4ac:
> 
>   iommu/arm-smmu: fix compilation issue when !CONFIG_ARM_AMBA (2014-02-10 17:02:27 +0000)
> 
> ----------------------------------------------------------------
> Will Deacon (4):
>       iommu/arm-smmu: really fix page table locking
>       iommu/arm-smmu: fix table flushing during initial allocations
>       iommu/arm-smmu: set CBARn.BPSHCFG to NSH for s1-s2-bypass contexts
>       iommu/arm-smmu: fix compilation issue when !CONFIG_ARM_AMBA
> 
> Yifan Zhang (1):
>       iommu/arm-smmu: fix pud/pmd entry fill sequence
> 
>  drivers/iommu/arm-smmu.c | 103 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 61 insertions(+), 42 deletions(-)

Pulled, thanks Will.
