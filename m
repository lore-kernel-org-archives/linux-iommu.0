From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH V4 6/7] iommu/msm: Use writel_relaxed and add a barrier
Date: Wed, 18 May 2016 14:15:20 +0200
Message-ID: <2638968.1a16UdaY62@wuerfel>
References: <1463381341-30498-1-git-send-email-sricharan@codeaurora.org>
	<3070591.xyl7SB8DB7@wuerfel>
	<002c01d1b0fd$e4f3c350$aedb49f0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <002c01d1b0fd$e4f3c350$aedb49f0$@codeaurora.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wednesday 18 May 2016 17:37:40 Sricharan wrote:
> >
> >These comments are completely useless. What is the specific race
> >that you are protecting against, and why are the implicit barriers
> >not sufficient here? Please find a better way to document what
> >is going on.
> >
> 
> The reason for doing this was, when the tlb maintenance ops are called
> by  io-pgtable functions, it expects that the tlb_range ops is complete
> only after the tlb_sync callback is called. Previously we were using
> writel and the sync in that case was dummy. Also previously every register
> configuration write was done using writel,  which was an overkill. So now
> we do all the writes with writel_relaxed  and a barrier in the end. I will
> change the documentation for this.

If you need the barrier after the write, it probably was already faulty
before, because writel only implies a barrier before the store, not
after. Of course all the barriers likely made the whole process so
slow that you never hit that race in the end.

	Arnd
