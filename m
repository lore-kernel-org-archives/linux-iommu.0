From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/msm: Claim bus ops on probe
Date: Wed, 17 Jan 2018 15:27:20 +0100
Message-ID: <20180117142720.GT28161@8bytes.org>
References: <f1a506337bf602c54f4d6d417c14ca556a5f3674.1515436860.git.robin.murphy@arm.com>
	<20180117133331.vidtyduiu7zr3fwc@8bytes.org>
	<bc83496f-f0c0-6fe7-acd4-b96526a81dc3@arm.com>
	<20180117135356.GQ28161@8bytes.org>
	<fc884e48-bf80-23a7-8275-209950e0ef34@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <fc884e48-bf80-23a7-8275-209950e0ef34-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 17, 2018 at 02:05:21PM +0000, Robin Murphy wrote:
> The IOMMU_OF_DECLARE() in ipmmu-vmsa.c added in 4.15 is missed by the
> prototype change in (4.14-based) v1 2/2 - by applying v2 2/3 on top of the
> two v1 patches you will end up with an extra NULL argument there which will
> then fail to compile. v2 3/3 supersedes v1 2/2 by removing that one as well.
> This is entirely my fault for hacking out some quick patches on top of
> unrelated development work instead of creating a fresh branch...

Okay, I see. So I removed the two patches from arm/msm and the one patch
from arm/renesas and applied all 3 patches from v2 to the core branch
instead.

Thanks,

	Joerg
