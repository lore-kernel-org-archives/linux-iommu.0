From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 2/3] arm64: Add IOMMU dma_ops
Date: Wed, 14 Oct 2015 14:35:38 +0100
Message-ID: <20151014133538.GG4239@e104818-lin.cambridge.arm.com>
References: <cover.1443718557.git.robin.murphy@arm.com>
	<80cb035144a2648a5d94eb1fec3336f17ad249f1.1443718557.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <80cb035144a2648a5d94eb1fec3336f17ad249f1.1443718557.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 01, 2015 at 08:13:59PM +0100, Robin Murphy wrote:
> Taking some inspiration from the arch/arm code, implement the
> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
> 
> Since there is still work to do elsewhere to make DMA configuration happen
> in a more appropriate order and properly support platform devices in the
> IOMMU core, the device setup code unfortunately starts out carrying some
> workarounds to ensure it works correctly in the current state of things.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Sorry, I reviewed this patch before but forgot to ack it, so here it is:

Acked-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>

(and I'm fined for the arm64 patches here to go in via the iommu tree)

I assume part of this patch will disappear at some point when the device
probing order is sorted.

-- 
Catalin
