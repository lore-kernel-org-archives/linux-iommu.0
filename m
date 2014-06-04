From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/4] dma-mapping: Add devm_ interface for
	dma_map_single()
Date: Wed, 4 Jun 2014 23:25:25 +0200
Message-ID: <20140604212525.GE23880@8bytes.org>
References: <1401606077-1739-1-git-send-email-eli.billauer@gmail.com>
	<1401606077-1739-2-git-send-email-eli.billauer@gmail.com>
	<538E3D04.9060808@samsung.com> <20140603233907.GB23880@8bytes.org>
	<20140604140408.GC5004@htj.dyndns.org>
	<20140604141211.GC23880@8bytes.org>
	<20140604141416.GD5004@htj.dyndns.org> <538F3548.4050101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <538F3548.4050101-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, discuss-Wa75r+71Mmgdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Wed, Jun 04, 2014 at 06:03:36PM +0300, Eli Billauer wrote:
> I believe that I need a managed dma_map_single() my own driver,
> which doesn't fall in the case of a single use: The driver allocates
> its buffers with __get_free_pages() (or the to-be managed version of
> it). Then it cuts the allocated memory into smaller buffers (in some
> cases, and with certain alignment rules), and  then calls
> dma_map_single() to do the DMA mapping for each. The buffers are
> held along the driver's lifetime, with DMA sync API juggling control
> back and forth to the hardware. Note that the DMA is noncoherent.

What you are trying to do should work with dma_alloc_noncoherent(). The
API allows partial syncs on this memory, so you should be fine.

The problem with a devm variant of dma_map_* is that it is too easy to
misuse or to use it wrong so that a driver could eat up all available
DMA handles on some platforms.


	Joerg
