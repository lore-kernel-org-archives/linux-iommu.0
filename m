From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu: call detach also for default_domain before
	attaching to new one
Date: Thu, 25 Feb 2016 15:01:10 +0100
Message-ID: <20160225140110.GB16675@8bytes.org>
References: <1455633632-16873-1-git-send-email-m.szyprowski@samsung.com>
	<1455633632-16873-2-git-send-email-m.szyprowski@samsung.com>
	<20160216155922.GV18805@8bytes.org> <56C422AE.9000108@samsung.com>
	<20160217111450.GA18805@8bytes.org> <56C486EE.5020504@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56C486EE.5020504-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

On Wed, Feb 17, 2016 at 03:42:54PM +0100, Marek Szyprowski wrote:
> From driver perspective the default_domains don't really differ from the
> 'other' domains. They are just allocated from the IOMMU core and used by
> the IOMMU/DMA-mapping glue code. That's what I got from reading the code.
> 
> There should be also a way to detach the driver even from the default domain
> to implement the arch_tear_down_dma_ops function.

The attaching/detaching in the iommu-core only manages software state.
The iommu-driver can power-down the iommu device when the default-domain
is attached and it does not expect any map/unmap calls.

All it has to make sure is that it wakes up the iommu device again when
or before these calls are made again.


	Joerg
