From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 1/8] iommu: provide early initialisation hook for IOMMU
	drivers
Date: Fri, 5 Dec 2014 13:06:52 +0000
Message-ID: <CACxGe6vppOQj-hJnqEEtLwDuSr4bzcbTgEFj8=x4ULu=yxswpg@mail.gmail.com>
References: <CAL_JsqKHvh9KSTYrrs1Pts5Kg=8dA1V6NiW57_2vdDH173qQGg@mail.gmail.com>
	<CACxGe6vyMkyE9ZRj_FQzi19ESEo7OV_RQoVV65xBYpdQV8cRGQ@mail.gmail.com>
	<2579924.PPXuLn3o19@wuerfel> <54805312.6000402@arm.com>
	<CACxGe6uR5J4Cjdh_xYhBPoQRgeYwHPv5=AnuRmQKSD3yZrMK9Q@mail.gmail.com>
	<54806504.20507@arm.com> <20141204144925.GB31464@ulmo.nvidia.com>
	<54809D09.2050406@arm.com>
	<CACxGe6tpFHdP1-5NWiNVAqzXx-diN1xfRbu0AQDyVJ6AU_4RXg@mail.gmail.com>
	<5480B924.2010205@arm.com> <20141205121037.GI1630@arm.com>
	<5481A688.4030606@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5481A688.4030606-5wv7dgnIgG8@public.gmane.org>
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
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Dec 5, 2014 at 12:35 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> Hi Will,
>
> On 05/12/14 12:10, Will Deacon wrote:
> [...]
>>>>
>>>> Do you expect drivers to modify that *priv pointer after the ops
>>>> structure is registered? I'd be very surprised if that was the use
>>>> case. It's fine for the driver to register a non-const version, but
>>>> once it is registered, the infrastructure can treat it as const from
>>>> then on.
>>>
>>>
>>> Possibly not - certainly my current port of the ARM SMMU which makes use
>>> of *priv is only ever reading it - although we did also wave around
>>> reasons for mutable ops like dynamically changing the pgsize_bitmap and
>>> possibly even swizzling individual ops for runtime reconfiguration. On
>>> consideration though, I'd agree that things like that are mad enough to
>>> stay well within individual drivers if they did ever happen, and
>>> certainly shouldn't apply to this bit of the infrastructure at any rate.
>>
>>
>> I certainly need to update the pgsize_bitmap at runtime because I don't
>> know the supported page sizes until I've both (a) probed the hardware
>> and (b) allocated page tables for a domain. We've already discussed
>> moving the pgsize_bitmap out of the ops, but moving it somewhere where
>> it remains const doesn't really help.
>
>
> We can safely cast the call to get_ops in the SMMU driver though, since
> we'll know that we put a mutable per-instance ops in there in the first
> place. At least that way drivers that aren't taking advantage and just pass
> their static const ops around shouldn't provoke warnings. I deliberately
> didn't touch anything beyond get_ops as that would be too disruptive.
>
>> Can I just take the patch that Grant acked, in the interest of getting
>> something merged? As you say, there's plenty of planned changes in this
>> area anyway. I plan to send Olof a pull request this afternoon.
>
>
> Grant, Thierry? Personally I'm not fussed either way - the sooner something
> goes in, the sooner I can carry on working at replacing it :D

I've already acked it. Why are we still talking about it?  :-D

g.
