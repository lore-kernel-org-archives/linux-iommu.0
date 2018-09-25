From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Fix race handling in
	split_blk_unmap()
Date: Tue, 25 Sep 2018 15:03:25 +0200
Message-ID: <20180925130325.7w6hfqarnms2iozi@8bytes.org>
References: <f6700817286f60597f2a93835bf658f3ef3585ef.1535026499.git.robin.murphy@arm.com>
	<20180925090138.h6tqvrvxy43ycp6g@8bytes.org>
	<e86cd69f-4355-5078-890a-338756e325ba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e86cd69f-4355-5078-890a-338756e325ba-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Tue, Sep 25, 2018 at 11:48:17AM +0100, Robin Murphy wrote:
> Will has the cleaned-up version in his tree along with a couple of other
> SMMU fixes, which I assume he's planning to send you a pull for (he's off at
> yet another conference just now so I can't confirm offline).

Okay, less work for me, fine.

> We were planning for the non-strict stuff to come in as SMMU updates
> on top of that (p.s. please shout if you have any objections on that
> series so I can get on them ASAP!)

No objections, I have suggested this change for quite some time now.
Cool to see you implmented it :) I also looked at the patches and they
look good to me.


Regards,

	Joerg
