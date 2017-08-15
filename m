From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH v5 0/5] vfio-pci: Add support for mmapping MSI-X table
Date: Tue, 15 Aug 2017 10:37:17 -0600
Message-ID: <20170815103717.3b64e10c@w520.home>
References: <20170807072548.3023-1-aik@ozlabs.ru>
	<8f5f7b82-3c10-7f39-b587-db4c4424f04c@ozlabs.ru>
	<ca2a4550-fb26-28db-0eea-a5940dfa612f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <ca2a4550-fb26-28db-0eea-a5940dfa612f-5wv7dgnIgG8@public.gmane.org>
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
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Kyle Mahlkuch <Kyle.Mahlkuch-qyM6JfAXOaQ@public.gmane.org>, Vlad Tsyrklevich <vlad-NIZqynvkaCU43zv7NVfAiQ@public.gmane.org>, kvm-ppc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Yongji Xie <elohimes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mauricio Faria de Oliveira <mauricfo-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 14 Aug 2017 14:12:33 +0100
Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:

> On 14/08/17 10:45, Alexey Kardashevskiy wrote:
> > Folks,
> > 
> > Is there anything to change besides those compiler errors and David's
> > comment in 5/5? Or the while patchset is too bad? Thanks.  
> 
> While I now understand it's not the low-level thing I first thought it
> was, so my reasoning has changed, personally I don't like this approach
> any more than the previous one - it still smells of abusing external
> APIs to pass information from one part of VFIO to another (and it has
> the same conceptual problem of attributing something to interrupt
> sources that is actually a property of the interrupt target).
> 
> Taking a step back, though, why does vfio-pci perform this check in the
> first place? If a malicious guest already has control of a device, any
> kind of interrupt spoofing it could do by fiddling with the MSI-X
> message address/data it could simply do with a DMA write anyway, so the
> security argument doesn't stand up in general (sure, not all PCIe
> devices may be capable of arbitrary DMA, but that seems like more of a
> tenuous security-by-obscurity angle to me). Besides, with Type1 IOMMU
> the fact that we've let a device be assigned at all means that this is
> already a non-issue (because either the hardware provides isolation or
> the user has explicitly accepted the consequences of an unsafe
> configuration) - from patch #4 that's apparently the same for SPAPR TCE,
> in which case it seems this flag doesn't even need to be propagated and
> could simply be assumed always.
> 
> On the other hand, if the check is not so much to mitigate malicious
> guests attacking the system as to prevent dumb guests breaking
> themselves (e.g. if some or all of the MSI-X capability is actually
> emulated), then allowing things to sometimes go wrong on the grounds of
> an irrelevant hardware feature doesn't seem correct :/

While the theoretical security provided by preventing direct access to
the MSI-X vector table may be mostly a matter of obfuscation, in
practice, I think it changes the problem of creating arbitrary DMA
writes from a generic, trivial, PCI spec based exercise to a more device
specific challenge.  I do however have evidence that there are
consumers of the vfio API who would have attempted to program device
interrupts by directly manipulating the vector table had they not been
prevented from doing so and contacting me to learn about the SET_IRQ
ioctl.  Therefore I think the behavior also contributes to making the
overall API more difficult to use incorrectly.

Of course I don't think either of those are worth imposing a
performance penalty where we don't otherwise need one.  However, if we
look at a VM scenario where the guest is following the PCI standard for
programming MSI-X interrupts (ie. not POWER), we need some mechanism to
intercept those MMIO writes to the vector table and configure the host
interrupt domain of the device rather than allowing the guest direct
access.  This is simply part of virtualizing the device to the guest.
So even if the kernel allows mmap'ing the vector table, the hypervisor
needs to trap it, so the mmap isn't required or used anyway.  It's only
when you define a non-PCI standard for your guest to program
interrupts, as POWER has done, and can therefore trust that the
hypervisor does not need to trap on the vector table that having that
mmap'able vector table becomes fully useful.  AIUI, ARM supports 64k
pages too... does ARM have any strategy that would actually make it
possible to make use of an mmap covering the vector table?  Thanks,

Alex
