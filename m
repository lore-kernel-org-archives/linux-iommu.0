From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Mon, 18 Aug 2014 13:48:46 -0700
Message-ID: <53F266AE.40303@codeaurora.org>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>	<1407797150-515-2-git-send-email-ohaugan@codeaurora.org>	<871tsm5vcn.fsf@nvidia.com>	<CAF6AEGvZUanVtPxAt76+AAdOaNwyMJ3cmcJ1srsEYBeG7ELkBQ@mail.gmail.com>	<53EA472B.3020900@codeaurora.org>	<20140818140730.GC9809@8bytes.org>
	<CAF6AEGtGmAQjMc5W5a6x5QiyUc8v0XHcsNAFe65Znc=DDKPS+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAF6AEGtGmAQjMc5W5a6x5QiyUc8v0XHcsNAFe65Znc=DDKPS+w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 8/18/2014 11:32 AM, Rob Clark wrote:
> On Mon, Aug 18, 2014 at 10:07 AM, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
>> On Tue, Aug 12, 2014 at 09:56:11AM -0700, Olav Haugan wrote:
>>> On 8/12/2014 3:48 AM, Rob Clark wrote:
>>>> iirc, one plan for 'flags' was some sort of DONT_FLUSH_TLB flag for
>>>> drivers which wanted to map/unmap N buffers with a single flush at the
>>>> end.  There might have been some other usages envisioned.
>>>
>>> Yes, that was the original intent of the flags for now. I am sure we can
>>> find other uses for this in the future.
>>
>> Do you have anything else in mind already besides the DONT_FLUSH_TLB
>> flag?

No, I do not have other uses right now. But could imagine use cases like
"force <insert minimum mapping size here> mapping" flag etc.

>> How is the IOTLB supposed to be flushed when this flag is used?
>>
> 
> well, I was thinking one of two ways:
> 
> 1) add new flush() vfunc.. this, I think, would be most convenient for
> drivers using this feature
> 2) or driver simply doesn't set DONT_FLUSH_TLB flag on the last
> {map,unmap}..  that would be slightly more awkward to use, but would
> avoid adding a new vfunc
> 

I agree and would support adding a public flush() API. It is cleaner.
However, it does allow clients to chose which method to use. Either an
extra call to flush() or just do not pass DONT_FLUSH_TLB flag on the
last invocation of map/unmap.


Thanks,

Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
