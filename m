From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: updates for 3.15
Date: Tue, 4 Mar 2014 14:58:29 +0100
Message-ID: <20140304135829.GA2799@8bytes.org>
References: <20140228110525.GA674@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140228110525.GA674-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
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

On Fri, Feb 28, 2014 at 11:05:25AM +0000, Will Deacon wrote:
> The following changes since commit cfbf8d4857c26a8a307fb7cd258074c9dcd8c691:
> 
>   Linux 3.14-rc4 (2014-02-23 17:40:03 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates
> 
> for you to fetch changes up to 34fb4b37b7b6da7dc34797d1abf234dd30b091d8:
> 
>   iommu/arm-smmu: fix incorrect comment regarding TLB invalidation (2014-02-27 19:08:43 +0000)
> 
> ----------------------------------------------------------------
> Andreas Herrmann (3):
>       iommu/arm-smmu: set MAX_MASTER_STREAMIDS to MAX_PHANDLE_ARGS
>       iommu/arm-smmu: support buggy implementations with secure cfg accesses
>       documentation/iommu: update description of ARM System MMU binding
> 
> Will Deacon (3):
>       iommu/arm-smmu: clean up use of `flags' in page table handling code
>       iommu/arm-smmu: provide option to dsb macro when publishing tables
>       iommu/arm-smmu: fix incorrect comment regarding TLB invalidation
> 
>  .../devicetree/bindings/iommu/arm,smmu.txt         |   6 ++
>  drivers/iommu/arm-smmu.c                           | 105 ++++++++++++++-------
>  2 files changed, 77 insertions(+), 34 deletions(-)

Pulled, thanks Will.
