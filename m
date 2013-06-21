From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 0/3] How to pass IOMMU map attr via DMA API?
Date: Fri, 21 Jun 2013 18:03:44 +0200
Message-ID: <20130621160344.GM11309@8bytes.org>
References: <1371707384-30037-1-git-send-email-hdoyu@nvidia.com>
	<51C3FE27.5070702@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51C3FE27.5070702-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jun 21, 2013 at 09:17:59AM +0200, Marek Szyprowski wrote:
> Using DMA attributes for this seems to be a bad idea. The dma direction
> parameter is much more appropriate. Will Deacon recently posted a patch
> which does it right, see:
> 
> https://git.linaro.org/gitweb?p=people/mszyprowski/linux-dma-mapping.git;a=commit;h=8fc3749bd31d139db58f874e093255fe62505968

Agreed, that is one usecase the dma-direction parameter was made for. In
particular:

	DMA_FROM_DEVICE		-> Write only mapping
	DMA_TO_DEVICE 		-> Read only mapping
	DMA_BIDIRECTIONAL	-> Read/Write mapping

So no need to use the dma attributes for that.


	Joerg
