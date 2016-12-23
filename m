From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: possible dmar_init_reserved_ranges() error
Date: Thu, 22 Dec 2016 18:48:01 -0600
Message-ID: <20161223004801.GA1096@bhelgaas-glaptop.roam.corp.google.com>
References: <20161219212044.GA21774@bhelgaas-glaptop.roam.corp.google.com>
	<20161222162713.GF17255@8bytes.org>
	<20161222202803.GA16855@bhelgaas-glaptop.roam.corp.google.com>
	<20161222233238.GA20861@otc-nc-03>
	<20161222234508.GA20924@otc-nc-03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161222234508.GA20924@otc-nc-03>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rwright-ZPxbGqLxI0U@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Ashok,

On Thu, Dec 22, 2016 at 03:45:08PM -0800, Raj, Ashok wrote:
> Hi Bjorn
> 
> None in the platform group say they know about this. So i'm fairly sure
> we don't do that on Intel hardware (x86). 

I'm pretty sure there was once an x86 prototype for which PCI bus
addresses were not identical to CPU physical addresses, but I have no
idea whether it shipped that way.

Even if such a system never shipped, the x86 arch code supports _TRA,
and there's no reason to make the unnecessary assumption in this code
that _TRA is always zero.

If we didn't want to use pcibios_resource_to_bus() here for some
reason, we should at least add a comment about why we think it's OK to
use a CPU physical address as an IOVA.

Bjorn
