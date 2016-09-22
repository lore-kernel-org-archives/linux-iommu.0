From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 4.9
Date: Thu, 22 Sep 2016 17:34:54 +0200
Message-ID: <20160922153454.GM3541@8bytes.org>
References: <20160920102534.GC17978@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160920102534.GC17978-5wv7dgnIgG8@public.gmane.org>
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

On Tue, Sep 20, 2016 at 11:25:34AM +0100, Will Deacon wrote:
> Hi Joerg,
> 
> Please pull these significant arm-smmu updates for 4.9. The vast majority
> of the code here is Robin's series to move the drivers over to the
> generic DT bindings, which finally hooks up the DMA API and MSI mapping
> for host machines. This has been stewing for a while and is now at the
> point where I feel it's much better in mainline than languishing outside.
> 
> A consequence of that is that there are some non-trivial changes outside
> of the drivers, but these are all acked by the relevant subsystem
> maintainers.
> 
> Other stuff here includes some non-critical fixes to the queue handling
> on SMMUv3 and a small devm cleanup that missed the boat last time around.
> 
> Cheers,
> 
> Will
> 
> --->8
> 
> The following changes since commit 3eab887a55424fc2c27553b7bfe32330df83f7b8:
> 
>   Linux 4.8-rc4 (2016-08-28 15:04:33 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

Pulled, thanks Will.
