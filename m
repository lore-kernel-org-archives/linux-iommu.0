From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 0/7] Introduce automatic DMA configuration for IOMMU
	masters
Date: Tue, 02 Sep 2014 14:24:18 +0200
Message-ID: <5405B6F2.1060105@samsung.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<20140902083138.GA25379@arm.com> <54058442.2070204@samsung.com>
	<33373396.gPTVFGBBxa@wuerfel> <54059F05.2090901@samsung.com>
	<20140902105730.GH25379@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20140902105730.GH25379-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On 2014-09-02 12:57, Will Deacon wrote:
> On Tue, Sep 02, 2014 at 11:42:13AM +0100, Marek Szyprowski wrote:
>> On 2014-09-02 10:56, Arnd Bergmann wrote:
>>> On Tuesday 02 September 2014 10:48:02 Marek Szyprowski wrote:
>>>>>     -- I have concerns that allocating one domain per master might be
>>>>> too much, but it's hard to tell without an IOMMU driver ported over.
>>>> One domain per master is IMHO a sane default configuration. The only default
>>>> alternative I see is to have only one domain (related with dma-mapping
>>>> subsystem) and bind all devices to it. However I really don't see any
>>>> disadvantage of having separate domain per each master and such
>>>> configuration
>>>> gives devices better separation.
>>> I was expecting that the dma-mapping implementation would by default use
>>> one domain for all devices, since that is what the simpler IOMMUs without
>>> domain support have to do anyway.
>>>
>>> For isolation purposes, it can only help to have more domains, but
>>> I would guess that there is some space overhead in maintaining lots
>>> of page tables.
>> I'm okay with both approaches (separate domain for each device vs. single
>> common domain for all devices). Maybe this can be some kind of Kconfig
>> option added to DMA debugging? Separation might be really helpful when
>> debugging strange device behavior.
> One potential problem with a single domain is when you have multiple
> instances of a given IOMMU, each with different hardware restrictions.
> Then you can end up with multiple sets of page tables for the domain
> which, although not impossible to work with, is a bit of a mess.

Maybe the default dma-mapping domain should be one per a given IOMMU 
instance?
This will simplify a lot of things in such case.

> I think having one domain per IOMMU instance would make the most sense,
> but then you have to teach more of the stack about the IOMMU topology. I
> think we'll get there in the end, but that's a little way off right now.

Right, those seems to be a details.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
