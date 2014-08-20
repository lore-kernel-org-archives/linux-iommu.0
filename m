From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Wed, 20 Aug 2014 16:15:15 +0200
Message-ID: <1689625.AvEiiWCphE@avalon>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
	<2767102.8U6hAaZh2n@avalon>
	<20140820130250.GA3120@laptop.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140820130250.GA3120-0iZWjJA6G8GSPmnEAIUT9EEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Konrad,

On Wednesday 20 August 2014 09:02:50 Konrad Rzeszutek Wilk wrote:
> On Tue, Aug 19, 2014 at 10:52:46PM +0200, Laurent Pinchart wrote:
> > On Tuesday 19 August 2014 11:40:24 Olav Haugan wrote:
> > > On 8/19/2014 9:11 AM, Laurent Pinchart wrote:
> > > > On Tuesday 19 August 2014 13:59:54 Joerg Roedel wrote:

[snip]

> > > >> Okay, since you add these call-backs to all drivers I think I can
> > > >> live with not doing a pointer check here.
> > > > 
> > > > I suggested doing a
> > > > 
> > > > if (ops is not NULL)
> > > > 	return ops();
> > > > else
> > > > 	return default_ops();
> > > > 
> > > > to avoid modifying all drivers. I'm not sure why that wasn't received
> > > > with much enthusiasm.
> > > 
> > > Both Thierry R. and Konrad W. argued for modifying the drivers instead
> > > so I implemented what the majority wanted. :-)
> > 
> > I'm not blaming you :-) I was just wondering what their rationale was.
> 
> a). To be inline with the usage of this API.
> 
>     For this particular case the other functions (but maybe I missed some)
>     follow the idea that they implement the ops->func for every operation
>     and they don't have an fallback.

That's because the other functions are mandatory, while this particular one is 
just an optimization and can be implemented generically.

> b)  Follow what x86 maintainers prefer (based on other API calls,
>     such as x86_init or any other platform overrides).
> 
> c). When there are new IOMMUs it has to take in-to account all of the
>     function ops. If they fail to implement all of them the kernel
>     crashes instead of working (but maybe working incorrectly).

I don't think that applies in this case, the generic implementation should 
work in all cases.

> d). Lastly, we also want the bloat of kernel. If the compiler decides
>     to roll in the fallback implementation for 'iommu_map_sg' in - it will
>     needlessly expand the kernel wherever we use 'iommu_map_sg' call with
>     a fallback implementation (which might not be called 99% of time).
> 
>     Having the little inline static just do 'func_ops->func' will
>     stop the compiler from optimizing too much and convert this just
>     to a simple function.

That's an argument I can buy.

-- 
Regards,

Laurent Pinchart
