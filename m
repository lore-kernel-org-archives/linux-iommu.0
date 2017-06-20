From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/7] dt-bindings: PCI: Describe ATS property for root
	complex nodes
Date: Tue, 20 Jun 2017 12:38:26 +0100
Message-ID: <1754b317-767e-7afd-5608-6ef6ea80a162@arm.com>
References: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
	<20170524180143.19855-3-jean-philippe.brucker@arm.com>
	<20170531172320.3u6bdctv44aqighy@rob-hp-laptop>
	<cd63a2dc-8259-482d-19e9-9db60be866f7@arm.com>
	<20170605172025.qgnocl5ytexnklue@rob-hp-laptop>
	<65aea93f-d516-f045-f216-3f56e96bdeb6@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <65aea93f-d516-f045-f216-3f56e96bdeb6-5wv7dgnIgG8@public.gmane.org>
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
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, sunil.kovvuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/06/2017 12:11 PM, Jean-Philippe Brucker wrote:
> On 05/06/17 18:20, Rob Herring wrote:
>> pci-host-{e,}cam-generic is a special case. I'm okay with having a 
>> property for that I suppose. We should not require this property though 
>> and allow for it to be implied by the SoC specific compatible as well.
> 
> The property isn't useful for host-generic since a host like Qemu can
> easily disable ATS in the IOMMU. It would only be here for consistency.
> Changing IOMMU registers wouldn't be as simple for a firmware running on
> real hardware.

Sorry I was mistaken here. AMD Seattle hardware, for instance, implements
a pure host-ecam-generic. So it's not exclusively used by Qemu. A quick
search in the kernel also brings up alpine and thunder2. So I guess I'll
move ats-supported documentation to host-generic-pci.txt.

Thanks,
Jean
