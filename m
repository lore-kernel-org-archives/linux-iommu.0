From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/4] VMD fixups
Date: Wed, 30 Aug 2017 14:23:42 -0500
Message-ID: <20170830192342.GV8154@bhelgaas-glaptop.roam.corp.google.com>
References: <20170817181014.1257-1-jonathan.derrick@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170817181014.1257-1-jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jon Derrick <jonathan.derrick-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keith Busch <keith.busch-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Fugate <david.fugate-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Scott Bauer <scott.bauer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

[+cc Joerg]

On Thu, Aug 17, 2017 at 12:10:10PM -0600, Jon Derrick wrote:
> Mostly just cleanup in this revision, eg, trying to limit scope of vmd code to
> x86
> 
> Previous:
> https://patchwork.kernel.org/patch/9886095/
> https://patchwork.kernel.org/patch/9886097/
> https://patchwork.kernel.org/patch/9886101/
> 
> 
> Jon Derrick (4):
>   MAINTAINERS: Add Jonathan Derrick as VMD maintainer
>   pci/x86: Move VMD quirks to x86 fixups
>   x86/PCI: Use is_vmd rather than relying on the domain number
>   iommu: Prevent VMD child devices from being remapping targets
> 
>  MAINTAINERS                 |  1 +
>  arch/x86/pci/fixup.c        | 18 ++++++++++++++++++
>  drivers/iommu/intel-iommu.c |  5 +++++
>  drivers/pci/quirks.c        | 17 -----------------
>  4 files changed, 24 insertions(+), 17 deletions(-)

I haven't heard anything from IOMMU folks, so I applied these to
pci/host-vmd for v4.14.  Let me know if there's any objection.
