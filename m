From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: Fixes for 4.9
Date: Thu, 3 Nov 2016 17:29:43 +0100
Message-ID: <20161103162943.GS3541@8bytes.org>
References: <20161028160148.GD1076@arm.com> <20161103153303.GA837@8bytes.org>
	<20161103160006.GS22791@arm.com> <20161103161407.GR3541@8bytes.org>
	<0dbf2665-4292-d49a-b9e7-688bcdf29c6e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0dbf2665-4292-d49a-b9e7-688bcdf29c6e-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 03, 2016 at 04:22:04PM +0000, Robin Murphy wrote:
> But bus_set_iommu() is already checking whether another SMMU (in this
> case) has probed, by virtue of bus->iommu_ops being non-NULL, and
> returning without doing anything if so. What's the value of adding a
> whole  bunch more code to effectively duplicate that in a less elegant
> manner?

No, bus_set_iommu() checks whether there is _any_ other IOMMU already
registered. This doesn't need to be an smmu. So I think the return value
of bus_set_iommu shouldn't be generally ignored.


	Joerg
