From: Jon Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] iommu: prevent VMD child devices from being remapping
	targets
Date: Wed, 9 Aug 2017 11:13:30 -0600
Message-ID: <e1ead7c8-0891-f1b2-e5b0-d601d1af80e0@intel.com>
References: <20170807195713.10963-1-jonathan.derrick@intel.com>
	<20170807195713.10963-3-jonathan.derrick@intel.com>
	<fda8e2c5-11da-7189-794c-59a68273e4d8@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <fda8e2c5-11da-7189-794c-59a68273e4d8-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Fugate <david.fugate-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Scott Bauer <scott.bauer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin, thanks for the reply.

On 08/11/2017 12:25 PM, Robin Murphy wrote:
> On 07/08/17 20:57, Jon Derrick wrote:
>> VMD child devices must use the VMD endpoint's ID as the DMA source.
>> Because of this, there needs to be a way to link the parent VMD
>> endpoint's DMAR domain to the VMD child devices' DMAR domain such that
>> attaching and detaching child devices modify the endpoint's DMAR mapping
>> and prevents early detaching.
> > That sounds like either pci_device_group() needs modifying, or perhaps
> that intel-iommu needs its own extended iommu_ops::device_group
> implementation, to ensure that VMD child devices get put in the same
> group as their parent - if they share requester IDs they can't feasibly
> be attached to different domains anyway.
> 
> Robin.
Yes it seems like that to me too. I have a high-level understanding of
the changes required but not too much in the nitty-gritty details. It's
a bit more complicated anyways because VMD emerges a set of root ports,
and AFAICT, PCI ACS end at the root ports and iommu groups rely on ACS
to group devices. Either way it's not within the scope of VMD.
