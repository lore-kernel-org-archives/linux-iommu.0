From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v2 1/4] dma-mapping: Add devm_ interface for
	dma_map_single()
Date: Fri, 6 Jun 2014 09:01:03 -0700
Message-ID: <20140606160103.GG15110@kroah.com>
References: <1401606077-1739-1-git-send-email-eli.billauer@gmail.com>
	<1401606077-1739-2-git-send-email-eli.billauer@gmail.com>
	<538E3D04.9060808@samsung.com> <20140603233907.GB23880@8bytes.org>
	<20140604140408.GC5004@htj.dyndns.org>
	<20140604141211.GC23880@8bytes.org>
	<20140604141416.GD5004@htj.dyndns.org> <538F3548.4050101@gmail.com>
	<20140604212525.GE23880@8bytes.org> <5391A9C2.3040602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5391A9C2.3040602-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eli Billauer <eli.billauer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, discuss-Wa75r+71Mmgdnm+yROfE0A@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 06, 2014 at 02:45:06PM +0300, Eli Billauer wrote:
> Hello Joerg.
> 
> 
> On 05/06/14 00:25, Joerg Roedel wrote:
> >
> >What you are trying to do should work with dma_alloc_noncoherent(). The
> >API allows partial syncs on this memory, so you should be fine.
> Please try to put yourself in my position: I have a driver that I care
> about, which works fine for a few years. It's based upon dma_map_single(),
> which seems to be the common way to get non-coherent memory, even for the
> driver's entire lifespan. I realize that dma_alloc_* was the intended way to
> do it, but fact is that dma_map_* has become the common choice.

Is your driver in the kernel tree?  If not, you really are on your own :(

greg k-h
