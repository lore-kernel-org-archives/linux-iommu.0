From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/8] io-pgtable lock removal
Date: Wed, 21 Jun 2017 17:47:26 +0200
Message-ID: <20170621154726.GQ30388@8bytes.org>
References: <cover.1496921366.git.robin.murphy@arm.com>
	<458ad41d-6679-eeca-3c0f-13ccb6c933b6@codeaurora.org>
	<b7830be1-9a78-e29f-a29c-4798aaa28c0a@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b7830be1-9a78-e29f-a29c-4798aaa28c0a-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: sunil.goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 14, 2017 at 05:40:30PM -0700, Ray Jui wrote:
> With the NVMf target test with 4 SSDs, fio based test, random read, 4k,
> 8 jobs:
> 
> Without IOMMU:
> 
> IOPS = 1080K
> 
> With IOMMU, but without your latest patch:
> 
> IOPS = 520K
> 
> With IOMMU and your latest patch:
> 
> IOPS = 500K ~ 850K (a lot of variation observed during the same test run)

That variation might come from the RB-Tree used in the IOVA allocator.
For block-device workloads the allocation size of iova ranges might be
bigger than what is cached in the magazines, so that the fall-back to
the old (locked) allocator is used.


	Joerg
