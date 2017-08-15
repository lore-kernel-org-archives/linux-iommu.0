From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [RFC PATCH v5 0/5] vfio-pci: Add support for mmapping MSI-X table
Date: Tue, 15 Aug 2017 15:38:00 +1000
Message-ID: <1502775480.4493.45.camel@kernel.crashing.org>
References: <20170807072548.3023-1-aik@ozlabs.ru>
	<8f5f7b82-3c10-7f39-b587-db4c4424f04c@ozlabs.ru>
	<ca2a4550-fb26-28db-0eea-a5940dfa612f@arm.com>
	<59924B85.5040405@intel.com>
	<1502760820.4493.40.camel@kernel.crashing.org>
	<599252B9.8030407@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <599252B9.8030407-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jike Song <jike.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Vlad Tsyrklevich <vlad-NIZqynvkaCU43zv7NVfAiQ@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, Kyle Mahlkuch <Kyle.Mahlkuch-qyM6JfAXOaQ@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, kvm-ppc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Yongji Xie <elohimes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauricio Faria de Oliveira <mauricfo-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2017-08-15 at 09:47 +0800, Jike Song wrote:
> On 08/15/2017 09:33 AM, Benjamin Herrenschmidt wrote:
> > On Tue, 2017-08-15 at 09:16 +0800, Jike Song wrote:
> > > > Taking a step back, though, why does vfio-pci perform this check in the
> > > > first place? If a malicious guest already has control of a device, any
> > > > kind of interrupt spoofing it could do by fiddling with the MSI-X
> > > > message address/data it could simply do with a DMA write anyway, so the
> > > > security argument doesn't stand up in general (sure, not all PCIe
> > > > devices may be capable of arbitrary DMA, but that seems like more of a
> > > > tenuous security-by-obscurity angle to me).
> > 
> > I tried to make that point for years, thanks for re-iterating it :-)
> > 
> > > Hi Robin,
> > > 
> > > DMA writes will be translated (thereby censored) by DMA Remapping hardware,
> > > while MSI/MSI-X will not. Is this different for non-x86?
> > 
> > There is no way your DMA remapping HW can differenciate. The only
> > difference between a DMA write and an MSI is ... the address. So if I
> > can make my device DMA to the MSI address range, I've defeated your
> > security.
> 
> I don't think with IRQ remapping enabled, you can make your device DMA to
> MSI address, without being treated as an IRQ and remapped. If so, the IRQ
> remapping hardware is simply broken :)

You are mixing things here.

Robin's point is that there is no security provided by the obfuscating
of the MSI-X table by qemu because whatever qemu does to "filter" the
MSI-X targer addresses can be worked around by making the device DMA
wherever you want.

None of what you say invalidates that basic fact.

Now, as far as your remapping HW goes, either it filters interrupts or
it doesn't. If it does then yes, it can't be spoofed, and thus you
don't need the filtering of the table in qemu.

If it doesn't, then the guest can spoof any interrupt using DMAs and
whatever qemu does to filter the table is not going to fix it.

Thus the point remains that the only value in qemu filtering the table
is to enable already insecure use cases to work, without actually
making them any more secure.

Ben.
