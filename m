From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [Patch Part2 V2 15/17] iommu/vt-d, PCI: update DRHD/RMRR/ATSR
	device scope caches when PCI hotplug happens
Date: Mon, 10 Mar 2014 16:46:32 +0800
Message-ID: <531D7BE8.7060103@linux.intel.com>
References: <1392790057-32434-1-git-send-email-jiang.liu@linux.intel.com>	
	<1392790057-32434-16-git-send-email-jiang.liu@linux.intel.com>
	<1394130319.9994.28.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1394130319.9994.28.camel-W2I5cNIroUsVm/YvaOjsyQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi David,
	Good suggestion! It should make hotplug logic simpler too.
Will try to work out some patches for it.
Thanks!
Gerry

On 2014/3/7 2:25, David Woodhouse wrote:
> On Wed, 2014-02-19 at 14:07 +0800, Jiang Liu wrote:
>> Current Intel DMAR/IOMMU driver assumes that all PCI devices
>> associated
>> with DMAR/RMRR/ATSR device scope arrays are created at boot time and
>> won't change at runtime, so it caches pointers of associated PCI
>> device
>> object. That assumption may be wrong now due to:
>> 1) introduction of PCI host bridge hotplug
>> 2) PCI device hotplug through sysfs interfaces.
> ...
>> This patch introduces a new mechanism to update the DRHD/RMRR/ATSR
>> device scope caches by hooking PCI bus notification.
> 
> Hm, this seems overly complex. Can't we just abandon the
> dmaru->devices[] array completely? In dmar_find_matched_drhd_unit()
> can't we just compare the path in the scope entries directly to the PCI
> device we are trying to find a DRHD for?
> 
> We then cache the result in dev->archdata.iommu for ever (well, until
> hot-unplug) anyway, so it shouldn't even be any less efficient to do it
> on demand, right?
> 
> That's true at least for dmar_find_matched_drhd_unit(). Perhaps we'd
> need to find a way to cache the result for
> dmar_find_matched_atsr_unit()?
> 
