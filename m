From: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 0/9] Support using MSI interrupts in ntb_transport
Date: Thu, 31 Jan 2019 15:39:51 -0700
Message-ID: <29f7e3fe-5354-6156-1243-7248ffb2249f@deltatee.com>
References: <20190131185656.17972-1-logang@deltatee.com>
	<345197a6-89e6-c0de-5f7b-a646b5f396c9@intel.com>
	<bafe9db4-6d5b-0453-d7e7-e49e9293dd01@deltatee.com>
	<ea7b7c3c-8ed5-51ec-022a-7d28a5afce82@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <ea7b7c3c-8ed5-51ec-022a-7d28a5afce82-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-CA
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ntb-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kselftest-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Mason <jdmason-zqedIHPRSYI@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Allen Hubbe <allenbh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Serge Semin <fancer.lancer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Pilmore <epilmore-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 2019-01-31 1:58 p.m., Dave Jiang wrote:
> 
> On 1/31/2019 1:48 PM, Logan Gunthorpe wrote:
>>
>> On 2019-01-31 1:20 p.m., Dave Jiang wrote:
>>> Does this work when the system moves the MSI vector either via software
>>> (irqbalance) or BIOS APIC programming (some modes cause round robin
>>> behavior)?
>>
>> I don't know how irqbalance works, and I'm not sure what you are
>> referring to by BIOS APIC programming, however I would expect these
>> things would not be a problem.
>>
>> The MSI code I'm presenting here doesn't do anything crazy with the
>> interrupts, it allocates and uses them just as any PCI driver would. The
>> only real difference here is that instead of a piece of hardware sending
>> the IRQ TLP, it will be sent through the memory window (which, from the
>> OS's perspective, is just coming from an NTB hardware proxy alias).
>>
>> Logan
> Right. I did that as a hack a while back for some silicon errata 
> workaround. When the vector moves, the address for the LAPIC changes. So 
> unless it gets updated, you end up writing to the old location and lose 
> all the new interrupts. irqbalance is a user daemon that rotates the 
> system interrupts around to ensure that not all interrupts are pinned on 
> a single core. 

Yes, that would be a problem if something changes the MSI vectors out
from under us. Seems like that would be a bit difficult to do even with
regular hardware. So far I haven't seen anything that would do that. If
you know of where in the kernel this happens I'd be interested in
getting a pointer to the flow in the code. If that is the case this MSI
stuff will need to get much more complicated...

> I think it's enabled by default on several distros. 

> Although MSIX has nothing to do with the IOAPIC, the mode that the APIC 
> is programmed can have an influence on how the interrupts are delivered. 
> There are certain Intel platforms (I don't know if AMD does anything 
> like that) puts the IOAPIC in a certain configuration that causes the 
> interrupts to be moved in a round robin fashion. I think it's physical 
> flat mode? I don't quite recall. Normally on the low end Xeons. It's 
> probably worth doing a test run with the irqbalance daemon running and 
> make sure you traffic stream doesn't all of sudden stop.

I've tested with irqbalance running and haven't found any noticeable
difference.

Logan
