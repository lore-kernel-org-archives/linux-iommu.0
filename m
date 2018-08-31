From: Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>
Subject: Re: your mail
Date: Fri, 31 Aug 2018 13:23:49 -0700
Message-ID: <20180831202349.xcz45jjcy7xvx3yk@pburton-laptop>
References: <20180827145032.9522-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180827145032.9522-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On Mon, Aug 27, 2018 at 04:50:27PM +0200, Christoph Hellwig wrote:
> Subject: [RFC] merge dma_direct_ops and dma_noncoherent_ops
> 
> While most architectures are either always or never dma coherent for a
> given build, the arm, arm64, mips and soon arc architectures can have
> different dma coherent settings on a per-device basis.  Additionally
> some mips builds can decide at boot time if dma is coherent or not.
> 
> I've started to look into handling noncoherent dma in swiotlb, and
> moving the dma-iommu ops into common code [1], and for that we need a
> generic way to check if a given device is coherent or not.  Moving
> this flag into struct device also simplifies the conditionally coherent
> architecture implementations.
> 
> These patches are also available in a git tree given that they have
> a few previous posted dependencies:
> 
>     git://git.infradead.org/users/hch/misc.git dma-direct-noncoherent-merge
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-direct-noncoherent-merge

Apart from the nits in patch 2, these look sane to me from a MIPS
perspective, so for patches 1-4:

    Acked-by: Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org> # MIPS parts

Thanks,
    Paul
