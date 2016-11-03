From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: Fixes for 4.9
Date: Thu, 3 Nov 2016 16:22:04 +0000
Message-ID: <0dbf2665-4292-d49a-b9e7-688bcdf29c6e@arm.com>
References: <20161028160148.GD1076@arm.com> <20161103153303.GA837@8bytes.org>
	<20161103160006.GS22791@arm.com> <20161103161407.GR3541@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161103161407.GR3541-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 03/11/16 16:14, Joerg Roedel wrote:
> On Thu, Nov 03, 2016 at 04:00:06PM +0000, Will Deacon wrote:
>> We're basically doing that already, since the bus_set_iommu call happens in
>> the probe routine, which won't run unless an SMMUv3 has been found in the
>> DT. The issue we're trying to avoid is failing the probe of a second SMMUv3
>> in the system, because the bus will already have the iommu ops set by the
>> first SMMUv3 that probed.
>>
>> I suppose we could go and compare bus->iommu_ops with &arm_smmu_ops, but
>> given that we can't support different IOMMU types on a single bus, I don't
>> think we gain anything from that.
> 
> Can you instead check whether there is already another smmu probed and
> skip the bus_set_iommu call then?

But bus_set_iommu() is already checking whether another SMMU (in this
case) has probed, by virtue of bus->iommu_ops being non-NULL, and
returning without doing anything if so. What's the value of adding a
whole  bunch more code to effectively duplicate that in a less elegant
manner?

Robin.

> 
> 
> 	Joerg
> 
