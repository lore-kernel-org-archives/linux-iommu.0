From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 05/16] iommu/amd: Split device table initialization into
	irq and dma part
Date: Fri, 28 Sep 2012 11:00:10 -0400
Message-ID: <20120928150009.GI7483@localhost.localdomain>
References: <1348835046-3262-1-git-send-email-joerg.roedel@amd.com>
	<1348835046-3262-6-git-send-email-joerg.roedel@amd.com>
	<20120928141752.GD7483@localhost.localdomain>
	<20120928142555.GC4009@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120928142555.GC4009-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 28, 2012 at 04:25:55PM +0200, Joerg Roedel wrote:
> On Fri, Sep 28, 2012 at 10:17:53AM -0400, Konrad Rzeszutek Wilk wrote:
> > On Fri, Sep 28, 2012 at 02:23:55PM +0200, Joerg Roedel wrote:
> > > When the IOMMU is enabled very early (as with irq-remapping)
> > > some devices are still in BIOS hand. When dma is blocked
> > > early this can cause lots of IO_PAGE_FAULTs. So delay the
> > > DMA initialization and do it right before the dma_ops are
> > > initialized.
> > > To be secure, block all interrupts by default when irq-remapping is
> > 
> > What are you trying to be secure against?
> 
> Against attacks of faked MSI msgs that could DoS the system. MSI
> messages are only specific DMA transactions in the end and a guest with
> a device assigned has control over its DMA engine and can thus send
> arbitrary interrupt requests to the host. There is a whole paper about
> such attacks. I can't find right now, but I send you  a link when I find
> it.

I think I know which one you are talking about - that is the Joanna's
Rutkowski/Rafal Wojtczuk paper. Could you include a bit about it
in the description or at least the title in the git commit pls?
