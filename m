From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: add_device vs attach_device
Date: Tue, 2 Oct 2018 14:45:02 +0100
Message-ID: <97e0d846-9134-9e88-5e0e-b3c517fae922@arm.com>
References: <CAFT6yXGcm1g0G_RAu1usA2mcQ3MSs30ZPZzmL1qNDbOS1cY5Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAFT6yXGcm1g0G_RAu1usA2mcQ3MSs30ZPZzmL1qNDbOS1cY5Zg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Yang Yang <yyang0729-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 02/10/18 04:48, Yang Yang wrote:
> Hi all,
> I have a very basic question, what's the difference betwee
> arm_smmu_attach_dev()
> and arm_smmu_add_device() in ARM SMMUv3 driver? When should I use which
> method?

Add/remove are the low-level interface that give the IOMMU driver a 
chance to do any internal housekeeping relevant to the existence of the 
given device (note that remove effectively only matters for hotpluggable 
devices). Unless you're actually writing an IOMMU driver, you probably 
don't need to care.

Attach/detach are the operations for managing which address space 
(domain) the device is currently associated with. If you want to make a 
driver or subsystem IOMMU-aware and explicitly control its devices' 
address mappings, then allocating your own domain, attaching to it, and 
using iommu_map/unmap() is the way to go. I'd recommend using 
iommu_group_get() and iommu_attach_group() in new code, since 
iommu_attach_device() is a bit of a legacy interface, and may not be 
valid for some system topologies.

Robin.
