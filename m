From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 0/3] How to pass IOMMU map attr via DMA API?
Date: Mon, 24 Jun 2013 08:17:59 +0300
Message-ID: <20130624081759.76e66d42bbf7c2c54ed1975c@nvidia.com>
References: <1371707384-30037-1-git-send-email-hdoyu@nvidia.com>
	<51C3FE27.5070702@samsung.com>
	<20130621160344.GM11309@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130621160344.GM11309-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 21 Jun 2013 18:03:44 +0200
Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> On Fri, Jun 21, 2013 at 09:17:59AM +0200, Marek Szyprowski wrote:
> > Using DMA attributes for this seems to be a bad idea. The dma direction
> > parameter is much more appropriate. Will Deacon recently posted a patch
> > which does it right, see:
> > 
> > https://git.linaro.org/gitweb?p=people/mszyprowski/linux-dma-mapping.git;a=commit;h=8fc3749bd31d139db58f874e093255fe62505968
> 
> Agreed, that is one usecase the dma-direction parameter was made for. In
> particular:
> 
> 	DMA_FROM_DEVICE		-> Write only mapping
> 	DMA_TO_DEVICE 		-> Read only mapping
> 	DMA_BIDIRECTIONAL	-> Read/Write mapping
> 
> So no need to use the dma attributes for that.

Ok, thanks. One more question, IOMMU H/W sometimes supports more
platform specific attributes than READ/WRITE. For example, in OMAP,

  #define IOMMU_FLAG	(IOVMF_ENDIAN_LITTLE | IOVMF_ELSZ_8)

Is there any way to deal with those platform specific attrs from DMA
mapping API POV?
