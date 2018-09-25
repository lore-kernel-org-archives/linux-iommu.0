From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Fix race handling in
	split_blk_unmap()
Date: Tue, 25 Sep 2018 11:48:17 +0100
Message-ID: <e86cd69f-4355-5078-890a-338756e325ba@arm.com>
References: <f6700817286f60597f2a93835bf658f3ef3585ef.1535026499.git.robin.murphy@arm.com>
	<20180925090138.h6tqvrvxy43ycp6g@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180925090138.h6tqvrvxy43ycp6g-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 25/09/18 10:01, Joerg Roedel wrote:
> Hey Robin,
> 
> On Thu, Aug 23, 2018 at 01:14:59PM +0100, Robin Murphy wrote:
>> Fixes: 2c3d273eabe8 ("iommu/io-pgtable-arm: Support lockless operation")
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> 
> I can't find a newer version of this in my inbox, do you plan to send
> one or has it been addressed differently?

Will has the cleaned-up version in his tree along with a couple of other 
SMMU fixes, which I assume he's planning to send you a pull for (he's 
off at yet another conference just now so I can't confirm offline). We 
were planning for the non-strict stuff to come in as SMMU updates on top 
of that (p.s. please shout if you have any objections on that series so 
I can get on them ASAP!)

Thanks,
Robin.
