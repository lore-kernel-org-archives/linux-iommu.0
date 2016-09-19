From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 00/22] Generic DT bindings for PCI IOMMUs and ARM SMMU
Date: Mon, 19 Sep 2016 13:41:47 +0100
Message-ID: <99ee0946-c7ff-e6e4-08c1-ff686ea1a8a5@arm.com>
References: <cover.1473695704.git.robin.murphy@arm.com>
	<11ebd81e-2ea5-5ff3-35b3-be95f03e05bd@redhat.com>
	<d03ea5e7-59f1-8b49-4ba2-d05fc2030ebc@arm.com>
	<04a0a682-4fdc-8d62-57cd-efdf730582c6@redhat.com>
	<c2645c5e-edd3-2b31-4311-0ca621a915e2@arm.com>
	<4d87d5f2-0350-b5f8-ffc3-4e9377cf1f87@redhat.com>
	<fc4ce398-4eeb-f2ca-b964-e9f466be79c4@arm.com>
	<1838c65d-5944-8946-781c-b420bea1acab@redhat.com>
	<f16db032-1905-9804-0607-fe007af72b0e@arm.com>
	<48f3bc10-3966-7d50-d070-7ec7f0946c92@redhat.com>
	<20160919122435.GD9005@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160919122435.GD9005-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 19/09/16 13:24, Will Deacon wrote:
> On Mon, Sep 19, 2016 at 02:13:45PM +0200, Auger Eric wrote:
>> On 16/09/2016 18:18, Robin Murphy wrote:
>>> What I probably will do, though, since we have the functionality in
>>> place for the sake of the old binding, and I think there are other folks
>>> who want PCI iommu-map support but would prefer not to bother with DMA
>>> ops on the host, is add a command-line option to disable DMA domains
>>> even for the generic bindings.
>>
>> Yes this would be a good thing I think. This series has an important
>> impact on platforms which do not have smmu v3, where contexts are scarce
>> HW resources.
> 
> Rather than disabling DMA domains entirely, we could specify a number
> of contexts to reserve for other use (e.g. VFIO). It's a pity that these
> options are global for the system, as opposed to per SMMU instance,
> but I can't see a good way around that.

The problem with that approach is that due to bus traversal order you'd
typically end up with the even-more-limited number of non-reserved
contexts getting consumed by bridges that are unlikely to ever actually
use their DMA ops, so you end up barely any better off than just not
doing DMA ops at all, which we already have the code for.

And yeah, if you had, say, "arm-smmu.reserved_s2_contexts=4", for the
benefit of your PCI SMMU, what do the SMMUs in front of your other
platform devices with only 2 contexts (and which only want DMA ops) do?

Robin.

> 
> Will
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
