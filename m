From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Wed, 20 Aug 2014 09:02:50 -0400
Message-ID: <20140820130250.GA3120@laptop.dumpdata.com>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
	<2348740.xICP2AxYHy@avalon> <53F39A18.70409@codeaurora.org>
	<2767102.8U6hAaZh2n@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2767102.8U6hAaZh2n@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 19, 2014 at 10:52:46PM +0200, Laurent Pinchart wrote:
> On Tuesday 19 August 2014 11:40:24 Olav Haugan wrote:
> > On 8/19/2014 9:11 AM, Laurent Pinchart wrote:
> > > On Tuesday 19 August 2014 13:59:54 Joerg Roedel wrote:
> > >> On Mon, Aug 18, 2014 at 03:47:56PM -0700, Olav Haugan wrote:
> > >>> If the alignment is not correct then iommu_map() will return error. Not
> > >>> sure what other option we have here (and why make it different behavior
> > >>> than iommu_map which just return error when it is not aligned properly).
> > >>> I don't think we want to force any kind of alignment automatically. I
> > >>> would rather have the API tell me I am doing something wrong than having
> > >>> the function aligning the values and possibly undermap or overmap.
> > >> 
> > >> But sg->offset is an offset into the page (at least it is used that way
> > >> in the DMA-API and since you do 'page_len = s->offset + s->length' you
> > >> use it the same way).
> > >> So when you pass iova + offset the result will no longer be
> > >> page-aligned. You should force sg->offset == 0 and sg->length to be
> > >> page-aligned instead. This makes more sense because the IOMMU-API works
> > >> on (io)-page granularity and not on arbitrary phys-addr ranges like the
> > >> DMA-API.
> > >> 
> > >>> Yes, I am aware of that. However, several people prefer this than
> > >>> passing in scatterlist. It is not very convenient to pass a scatterlist
> > >>> in some use cases. Someone mentioned a use case where they would have to
> > >>> create a dummy sg list and populate it with the iova just to do an
> > >>> unmap. I believe we would have to do this also. There is no use for
> > >>> sglist when unmapping. However, would like to keep separate API from
> > >>> iommu_unmap() to keep the API function names symmetric
> > >>> (map_sg/unmap_sg).
> > >> 
> > >> Keeping it symetric is not more complicated, the caller just needs to
> > >> keep the sg-list used for mapping around. I prefer the unmap_sg call to
> > >> work in sg-lists too.
> > > 
> > > Do we have a use case where the unmap_sg() implementation would be
> > > different than a plain iommu_unmap() call ? If not I'd rather remove
> > > unmap_sg() completely.
> > > 
> > >>> I thought that was why we added the default fallback and set all the
> > >>> drivers to point to these fallback functions. Several people wanted this
> > >>> so that we don't have to have NULL-check in these functions (and have
> > >>> the functions be simple inline functions).
> > >> 
> > >> Okay, since you add these call-backs to all drivers I think I can live
> > >> with not doing a pointer check here.
> > > 
> > > I suggested doing a
> > > 
> > > if (ops is not NULL)
> > > 
> > > 	return ops();
> > > 
> > > else
> > > 
> > > 	return default_ops();
> > > 
> > > to avoid modifying all drivers. I'm not sure why that wasn't received with
> > > much enthusiasm.
> > 
> > Both Thierry R. and Konrad W. argued for modifying the drivers instead
> > so I implemented what the majority wanted. :-)
> 
> I'm not blaming you :-) I was just wondering what their rationale was.


a). To be inline with the usage of this API.

    For this particular case the other functions (but maybe I missed some)
    follow the idea that they implement the ops->func for every operation
    and they don't have an fallback.

b)  Follow what x86 maintainers prefer (based on other API calls,
    such as x86_init or any other platform overrides).

c). When there are new IOMMUs it has to take in-to account all of the
    function ops. If they fail to implement all of them the kernel
    crashes instead of working (but maybe working incorrectly).

d). Lastly, we also want the bloat of kernel. If the compiler decides
    to roll in the fallback implementation for 'iommu_map_sg' in - it will
    needlessly expand the kernel wherever we use 'iommu_map_sg' call with
    a fallback implementation (which might not be called 99% of time).

    Having the little inline static just do 'func_ops->func' will
    stop the compiler from optimizing too much and convert this just
    to a simple function.
