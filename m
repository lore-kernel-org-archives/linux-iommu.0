From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Convert to IOMMU API TLB sync
Date: Wed, 27 Sep 2017 13:34:30 +0100
Message-ID: <1d55901b-e1a6-c3d5-b039-4c63b724c468@arm.com>
References: <a472d061559a6afcc4631e881e9420944471f461.1505747866.git.robin.murphy@arm.com>
	<20170922154322.GA27080@arm.com> <20170927122726.GM8398@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170927122726.GM8398-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 27/09/17 13:27, Joerg Roedel wrote:
> Hi Will, Robin,
> 
> On Fri, Sep 22, 2017 at 04:43:22PM +0100, Will Deacon wrote:
>> Joerg, do you reckon it's worth merging this as-is, or should we also
>> hook up add_flush before implementing this?
> 
> The patches implement .iotlb_sync() so that it is okay to not have a
> .iotlb_range_add() call-back for now. But the patches lack a
> .flush_iotlb_range() call-back, which is strictly necessary for
> correctness because it is defined to be synchronous and doesn't require
> a sync-call afterwards.

Good point - even with the flush still implicit in the unmap, an
iommu_unmap_fast()/iommu_flush_iotlb_all() sequence would indeed be
missing a sync at the end. I'll fix that up and post a new version shortly.

Thanks,
Robin.
