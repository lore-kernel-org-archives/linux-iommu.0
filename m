From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [v9 0/9] Add VT-d Posted-Interrupts support - IOMMU part
Date: Fri, 5 Jun 2015 15:33:33 +0200
Message-ID: <20150605133333.GU20384@8bytes.org>
References: <1433482974-14614-1-git-send-email-feng.wu@intel.com>
	<alpine.DEB.2.11.1506051343510.7723@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1506051343510.7723@nanos>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 05, 2015 at 01:47:06PM +0200, Thomas Gleixner wrote:
> On Fri, 5 Jun 2015, Feng Wu wrote:
> > Divide the whole series which contain multiple components into three parts:
> > - Prerequisite changes to irq subsystem (already merged in tip tree x86/apic branch)
> > - IOMMU part (in this series)
> 
> Please add 
> 
> Reviewed-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> 
> Which tree should this go through? It depends on tip/x86/apic AFAICT,
> so we can take it through that, if Joerg provides his ACK.

Yeah, these changes depend on tip/x86/apic, so it doesn't make sense to
send them through the iommu tree. There will be some conflicts when
merging tip/x86/apic and the iommu tree together, though, mainly because
of the vt-d kdump fixing patches I have in my tree. The conflicts are
spread over 3 files, but not too serious and easy to resolve.

Anyway, you have my

Acked-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

for those.


	Joerg
