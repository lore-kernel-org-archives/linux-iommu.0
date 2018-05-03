From: Nadav Amit <nadav.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC/RFT] Add noats flag to boot parameters
Date: Thu, 3 May 2018 15:15:20 -0700
Message-ID: <56E6D90C-A85F-42F7-94C5-EF21DA6C656B@gmail.com>
References: <1525025808-2365-1-git-send-email-gilkup@cs.technion.ac.il>
	<20180503133459.waawna3ebtu3udn6@8bytes.org>
	<359d736a-a7ac-f0e4-f4db-dc7bb506481c@codeaurora.org>
	<20180503135920.o2rdh3exai7qmkvu@8bytes.org>
	<5cf699f1-90c1-5ad8-07fe-a65042395d05@codeaurora.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5cf699f1-90c1-5ad8-07fe-a65042395d05-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Gil Kupfer <gilkup-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:

> +Bjorn,
> 
> On 5/3/2018 9:59 AM, Joerg Roedel wrote:
>> On Thu, May 03, 2018 at 09:46:34AM -0400, Sinan Kaya wrote:
>>> I also like the idea in general.
>>> Minor nit..
>>> 
>>> Shouldn't this be an iommu parameter rather than a PCI kernel command line parameter?
>>> We now have an iommu.passthrough argument that prevents page translation.
>>> 
>>> Doesn't this fit into the same category especially when it is the IOMMU drivers that
>>> call ATS functions for enablement not the PCI drivers.
>> 
>> ATS is a bit of a grey area between PCI and IOMMU, but since ATS is
>> PCI-specific and the code to enable/disable it is in PCI as well, I
>> think the parameter makes sense for PCI too.
> 
> OK. Bjorn was interested in having a command line driven feature enables in driver/pci
> directory with bitmasks for each optional PCI spec capability rather than noXYZ feature.
> 
> This would allow us to troubleshoot code breakage as well as the platform bring up to
> turn off all optional features.
> 
> Sounds like this would be a good match for that work.

I think that since this feature (ATS) has security implications, it should
be controllable through the kernel boot parameters. Otherwise, it can be
potentially too late to turn it off.

Regards,
Nadav
