From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
Date: Mon, 14 Jul 2014 06:13:03 -0400
Message-ID: <CAF6AEGspVSxdEj_3LNtMp752LF-RbfQ+Y4EdWoWfT9O8wMnh-g@mail.gmail.com>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
	<20140712093917.GD18601@arm.com>
	<CAF6AEGutHp+3f3iPA+jjaRkqq=5T_vytZ_ESoSqsQ4RHZ8F8yQ@mail.gmail.com>
	<201407121422.02078.arnd@arndb.de>
	<CAF6AEGs7=3UByP2DLm-uwU03wr7M14x2t-0hLX-VPJ6_eZbU3g@mail.gmail.com>
	<20140714062428.GC2081@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140714062428.GC2081@ulmo>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Varun Sethi <varun.sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, Dave P Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 14, 2014 at 2:24 AM, Thierry Reding
<thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Sat, Jul 12, 2014 at 08:57:31AM -0400, Rob Clark wrote:
>> On Sat, Jul 12, 2014 at 8:22 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> [...]
>> > The way that Thierry's binding does that is the obvious solution to this,
>> > and it mirrors what we do in practically every other subsystem. I definitely
>> > want the SMMU to change before anybody starts using it in a real system,
>> > which we fortunately do not have yet.
>>
>> hmm, well if some of the things I need for (like this or batching
>> mappings) are too weird and gpu specific, I'm willing to duplicate the
>> IOMMU driver in drm/msm.  It really isn't so much code, and that gives
>> me a lot more more flexibility to do crazy things... at some point I'm
>> probably going to want to do context switches by banging the IOMMU
>> registers directly from the gpu.
>
> If the IOMMU API doesn't provide for what you need, then perhaps it's
> time to enhance it? We do that all the time in other parts of the
> kernel, why should IOMMU be special?

sure.. and my comment was also about the map/unmap batching.

Bypassing IOMMU wouldn't be my first choice.  (Especially because I'd
then get to implement it twice.)  But if some of the things I need are
too specific to one driver (or worse, problematic for other IOMMU
use-cases which I don't know about), then it is an option I'd be
willing to consider.  If nothing else, it would get me out of
allocating sglists for every buffer..  I wonder how much memory
scatterlists take up for 500M of gfx buffers?

> It seems to me like context switching for per-process address space
> isolation is one of the important features of an IOMMU. If the current
> API doesn't let you do that then we should think of ways how it can be
> improved. And if it doesn't do it fast enough, then we should equally
> find ways to speed it up.
>
> This is part of why I think it would be good to have explicit objects
> associated with IOMMU contexts. That would give us a good place to add
> caching for this kind of situation. Currently we're required to handle
> most of this in drivers (map from struct device to context, ...).

well, it is at least awkward that the current api conflates attaching
device and attaching context.  I think we could get some use out of an
iommu_swap() API which conceptually acts as:

  iommu_swap(olddomain, newdomain, dev)
  {
     iommu_detach_device(olddomain, dev);
     iommu_attach_device(newdomain, dev);
  }

BR,
-R

> Thierry
