From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: Fwd: SWIOTLB on 32-bit PAE.
Date: Sat, 3 Oct 2015 14:00:19 -0400
Message-ID: <20151003180007.GA4732@localhost.localdomain>
References: <560E9007.1000604@t2data.com> <560E92A0.9030707@t2data.com>
	<20151003143630.GB17684@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151003143630.GB17684@localhost>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian Melki <christian.melki-VBSoEI6PWPXQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sat, Oct 03, 2015 at 09:36:30AM -0500, Bjorn Helgaas wrote:
> [+cc Konrad, Joerg, iommu list]
> 
> On Fri, Oct 02, 2015 at 04:20:16PM +0200, Christian Melki wrote:
> > I discovered a strange error on my machine. 32-bit PAE 4.2.0 without
> > IOMMU code (yeah, I know).
> > When writing to an ext4 filesystem on a USB disk my kernel would hang
> > and not return control to userspace. It would spew kernel messages to
> > syslog as fast as it could without giving userspace any time, ie "hang"
> > as far as a user sees it. The device itself is ok and the filesystem is
> > clean.
> > I get messages like this, millions of them.
> > 
> > Oct  2 14:33:06 voodoochild kernel: [  223.287447] nommu_map_sg:
> > overflow 25dcac000+1024 of device mask ffffffff
> > Oct  2 14:33:06 voodoochild kernel: [  223.287448] nommu_map_sg:
> > overflow 25dcac000+1024 of device mask ffffffff
> > Oct  2 14:33:06 voodoochild kernel: [  223.287449] nommu_map_sg:
> > overflow 25dcac000+1024 of device mask ffffffff
> > 
> > I disovered that SWIOTLB was not on. It is only provided for 64-bit
> > machines where it is default. On 32-bit SWIOTLB seems disabled
> > unless you are running with some IOMMU/AGPGART code.
> > 
> > But what about 32-bit PAE? Would that not qualify for SWIOTLB without IOMMU?

It most certainly would!
> > 
> > I am a novice in this area. Maybe this is a Kconfig "bug" for us
> > that like to hang ourselves with CONFIG_* rope? :) I'd like to think
> > that SWIOTLB should be default for 32-bit PAE too?

Aye. I presume that you had done a small change already for this?
Would you be willing to post it on lkml and CC me ?

Thank you.
> > 
> > Best regards,
> > Christian
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
