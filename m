From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC] iommu: arm-smmu: stall support
Date: Mon, 18 Sep 2017 18:33:32 +0100
Message-ID: <20170918173331.GH11343@arm.com>
References: <20170914194444.32551-1-robdclark@gmail.com>
	<9c2c136a-8c0f-6196-a135-0135b41c9b6e@arm.com>
	<CAF6AEGv0WZe-bYXUVYt4WxMX3RFnZxr5038pDg3VOiP8Edx+4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAF6AEGv0WZe-bYXUVYt4WxMX3RFnZxr5038pDg3VOiP8Edx+4Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, james.morse-5wv7dgnIgG8@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 18, 2017 at 08:11:47AM -0400, Rob Clark wrote:
> IIRC Will or Robin mentioned wanting a token in earlier stall
> discussion.. although not being familiar with v3 I wasn't quite sure
> what the use was.
> 
> At any rate, adding a token to fault handler callback and
> iommu_domain_resume() seems like something that could be added later,
> when it is needed.
> 
> Anyways, I am interested to see what your proposal is.. although tend
> to be a bit sceptical about trying to abstract too much.  (And if
> there should be something more abstract, maybe it should be at the
> dma-mapping layer instead?)

Whilst I'm also often sceptical about premature abstraction (which is why
I previously suggested just plugging into iommu_set_fault_handler and
managing any work queues yourself), in this case Jean-Philippe actually
has SVM up and running with multiple hardware platforms using stalls, so
I'm confident that if we have something that works for both of you, then
it's worth abstracting at this stage.

When we last had this discussion, you were the only person writing code
for this, but I think that things have moved on since then.

> I don't suppose you or someone working on this from ARM side will be
> at linaro connect in a couple weeks?  Jordan and myself will be there,
> and it could be a good time to chat about this, and also per-process
> pagetables and gpu switching switching pagetables directly on v2 hw.

James Morse (CC'd) will be there from our group. He's not looked at this
at all, but it might be worth speaking to him anyway as this is often
better done face-to-face than over email.

Will
