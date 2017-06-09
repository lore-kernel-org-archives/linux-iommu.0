From: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 0/8] io-pgtable lock removal
Date: Fri, 9 Jun 2017 15:28:46 -0400
Message-ID: <458ad41d-6679-eeca-3c0f-13ccb6c933b6@codeaurora.org>
References: <cover.1496921366.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1496921366.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: sunil.goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 6/8/2017 7:51 AM, Robin Murphy wrote:
> Hi all,
> 
> Here's the cleaned up nominally-final version of the patches everybody's
> keen to see. #1 is just a non-critical thing-I-spotted-in-passing fix,
> #2-#4 do some preparatory work (and bid farewell to everyone's least
> favourite bit of code, hooray!), and #5-#8 do the dirty deed itself.
> 
> The branch I've previously shared has been updated too:
> 
>    git://linux-arm.org/linux-rm  iommu/pgtable
> 
> All feedback welcome, as I'd really like to land this for 4.13.
>

I tested the series on a QDF2400 development platform and see notable
performance improvements particularly in workloads that make concurrent
accesses to a single iommu_domain.

> Robin.
> 
> 
> Robin Murphy (8):
>    iommu/io-pgtable-arm-v7s: Check table PTEs more precisely
>    iommu/io-pgtable-arm: Improve split_blk_unmap
>    iommu/io-pgtable-arm-v7s: Refactor split_blk_unmap
>    iommu/io-pgtable: Introduce explicit coherency
>    iommu/io-pgtable-arm: Support lockless operation
>    iommu/io-pgtable-arm-v7s: Support lockless operation
>    iommu/arm-smmu: Remove io-pgtable spinlock
>    iommu/arm-smmu-v3: Remove io-pgtable spinlock
> 
>   drivers/iommu/arm-smmu-v3.c        |  36 ++-----
>   drivers/iommu/arm-smmu.c           |  48 ++++------
>   drivers/iommu/io-pgtable-arm-v7s.c | 173 +++++++++++++++++++++------------
>   drivers/iommu/io-pgtable-arm.c     | 190 ++++++++++++++++++++++++-------------
>   drivers/iommu/io-pgtable.h         |   6 ++
>   5 files changed, 268 insertions(+), 185 deletions(-)
> 

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
