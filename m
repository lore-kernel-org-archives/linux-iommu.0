From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v6 2/8] dma-mapping: replace set_arch_dma_coherent_ops
	with arch_setup_dma_ops
Date: Tue, 02 Dec 2014 10:16:12 +0100
Message-ID: <18789666.A0Z8YWCnk0@wuerfel>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<1417453034-21379-3-git-send-email-will.deacon@arm.com>
	<CAL_JsqLtN3euwXHM4BzYxkXsgE=Dmn05aXzL+kr_8x23voneZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAL_JsqLtN3euwXHM4BzYxkXsgE=Dmn05aXzL+kr_8x23voneZA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Monday 01 December 2014 16:58:09 Rob Herring wrote:
> > @@ -178,28 +180,21 @@ static void of_dma_configure(struct device *dev)
> >         if (!dev->dma_mask)
> >                 dev->dma_mask = &dev->coherent_dma_mask;
> >
> > -       /*
> > -        * if dma-coherent property exist, call arch hook to setup
> > -        * dma coherent operations.
> > -        */
> > -       if (of_dma_is_coherent(dev->of_node)) {
> > -               set_arch_dma_coherent_ops(dev);
> > -               dev_dbg(dev, "device is dma coherent\n");
> > -       }
> > -
> > -       /*
> > -        * if dma-ranges property doesn't exist - just return else
> > -        * setup the dma offset
> > -        */
> >         ret = of_dma_get_range(dev->of_node, &dma_addr, &paddr, &size);
> >         if (ret < 0) {
> > -               dev_dbg(dev, "no dma range information to setup\n");
> > -               return;
> > +               dma_addr = offset = 0;
> > +               size = dev->coherent_dma_mask;
> 
> It looks like size is not used.

Catalin has proposed a patch for handling the size right, but it's
still under discussion.

	Arnd
