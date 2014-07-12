From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
Date: Sat, 12 Jul 2014 08:57:31 -0400
Message-ID: <CAF6AEGs7=3UByP2DLm-uwU03wr7M14x2t-0hLX-VPJ6_eZbU3g@mail.gmail.com>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
	<20140712093917.GD18601@arm.com>
	<CAF6AEGutHp+3f3iPA+jjaRkqq=5T_vytZ_ESoSqsQ4RHZ8F8yQ@mail.gmail.com>
	<201407121422.02078.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <201407121422.02078.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Jul 12, 2014 at 8:22 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Saturday 12 July 2014, Rob Clark wrote:
>> >> Was there actually a good reason for having the device link to the
>> >> iommu rather than the other way around?  How much would people hate it
>> >> if I just ignore the generic bindings and use something that works for
>> >> me instead.  I mean, it isn't exactly like there is going to be .dts
>> >> re-use across different SoC's..  and at least with current IOMMU API
>> >> some sort of of_get_named_iommu() API doesn't really make sense.
>> >
>> > The thing is, if you end up ignoring the generic binding then we have two
>> > IOMMUs using the same (ARM SMMU) binding and it begs the question as to
>> > which is the more generic! I know we're keen to get this merged, but merging
>> > something that people won't use and calling it generic doesn't seem ideal
>> > either. We do, however, desperately need a generic binding.
>>
>> yeah, ignoring the generic binding is not my first choice.  I'd rather
>> have something that works well for everyone.  But I wasn't really sure
>> if the current proposal was arbitrary, or if there are some
>> conflicting requirements between different platforms.
>
> The common case that needs to be simple is attaching one (master) device
> to an IOMMU using the shared global context for the purposes of implementing
> the dma-mapping API.

well, I don't disagree that IOMMU API has some problems.  It is too
tied to the bus type, which doesn't really seem to make sense for
platform devices.  (Unless we start having multiple platform busses?)

But at least given the current IOMMU API I'm not really sure how it
makes a difference which way the link goes.  But if there has already
been some discussion about how you want to handle the tie in with
dma-mapping, if you could point me at that then maybe your point will
make more sense to me.

> The way that Thierry's binding does that is the obvious solution to this,
> and it mirrors what we do in practically every other subsystem. I definitely
> want the SMMU to change before anybody starts using it in a real system,
> which we fortunately do not have yet.

hmm, well if some of the things I need for (like this or batching
mappings) are too weird and gpu specific, I'm willing to duplicate the
IOMMU driver in drm/msm.  It really isn't so much code, and that gives
me a lot more more flexibility to do crazy things... at some point I'm
probably going to want to do context switches by banging the IOMMU
registers directly from the gpu.

But given what Will said, I don't think what I need here is too far
out of line.  But if it is really a problem for dma-mapping, I suppose
we could have links in both directions?  However, I think the link
which contains the stream-id's really needs to be in the IOMMU, not
the device using the IOMMU.

BR,
-R
