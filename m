From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 06/07] iommu/ipmmu-vmsa: ARM and ARM64 archdata access
Date: Thu, 9 Mar 2017 11:40:24 +0000
Message-ID: <60a12f1e-968d-be3c-babb-5fcf4e18f232@arm.com>
References: <148885660307.28553.995847796823338863.sendpatchset@little-apple>
	<148885666392.28553.6653211200015255398.sendpatchset@little-apple>
	<d7db1ada-863a-ab92-7936-47d0306eaa8f@arm.com>
	<CANqRtoSE3nE5d9tGWwbowDkFAbXSQRBzjtBoACmR0BwQB5SK-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CANqRtoSE3nE5d9tGWwbowDkFAbXSQRBzjtBoACmR0BwQB5SK-Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 09/03/17 03:44, Magnus Damm wrote:
> Hi Robin,
> 
> On Wed, Mar 8, 2017 at 9:48 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>> On 07/03/17 03:17, Magnus Damm wrote:
>>> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
>>>
>>> Not all architectures have an iommu member in their archdata, so
>>> use #ifdefs support build with COMPILE_TEST on any architecture.
>>
>> I have a feeling I might be repeating myself, but ipmmu_vmsa_archdata
>> looks to be trivially convertible to iommu_fwspec, which I strongly
>> encourage, not least because it would obviate bodges like this.
> 
> Yeah, I think it should be possible to use iommu_fwspec for this
> purpose. The question is when to do it. =)

I'd actually be inclined to do it *before* any other major changes, as
it would be pretty minimal given the current structure of the driver.
But then I'm free to wilfully ignore the burden of maintaining patch
stacks between both mainline and older trees ;)

> I actually looked into it recently, but then realised that for this to
> work then due to code sharing I need to make use of iommu_fwspec on
> both 32-bit and 64-bit ARM. So it requires rework of the existing
> IPMMU for 32-bit ARM (including hairy legacy CONFIG_IOMMU_DMA=n code).
> I was actually thinking of doing some rework of 32-bit ARM IPMMU code
> anyway (I suspect iommu_device_* conversion caused breakage) and it
> probably has to happen on top of current -next. I would also like to
> start reducing burden of forward porting all these patches, and
> stirring up the ground does not really help much there...

Note that iommu_fwspec can be used pretty much orthogonally to any of
the core DMA ops support, so it shouldn't be as invasive as you might
think. See 84672f192671 ("iommu/mediatek: Convert M4Uv1 to
iommu_fwspec") as an example of an archdata-to-fwspec conversion of a
driver which only supports 32-bit ARM, and notably borrows its master
handling directly from the the IPMMU driver.

Robin.

> 
> Cheers,
> 
> / magnus
> 
