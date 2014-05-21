From: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] devicetree: Add generic IOMMU device tree bindings
Date: Wed, 21 May 2014 08:44:42 -0700
Message-ID: <CANEJEGvhEsC9wKqX_pYmOg7LwsQkoN9=jjXJuW0UeEa9XywSPw@mail.gmail.com>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
	<4506822.XX7GrvtHhk@wuerfel> <20140521090244.GB19268@ulmo>
	<11242680.PQytQQqlPJ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <11242680.PQytQQqlPJ@wuerfel>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, May 21, 2014 at 2:32 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Wednesday 21 May 2014 11:02:45 Thierry Reding wrote:
>> On Wed, May 21, 2014 at 10:54:42AM +0200, Arnd Bergmann wrote:
>>
>> > Right. As long as we always unmap the buffers from the IOMMU after they
>> > have stopped being in use, it's very unlikely that even a broken device
>> > driver causes a DMA into some bus address that happens to be mapped for
>> > another device.
>>
>> I think that if buffers remain mapped in the IOMMU when they have been
>> deallocated that should be considered a bug.

There is currently no general requirement to tear down mappings immediately.
An option to enforce immediate tear down might be useful since I agree
Virtual Guests sharing host memory through shared physical devices
will want that. ie there should be no opportunity for a shared device
to be able to access another guests memory through "stale" (but live)
DMA mappings. I don't think that's the case but I'd ask someone like
Alex Williamson for a more certain answer.

> You could see it as a performance optimization in some cases, e.g. when you
> cannot flush individual IOTLBs or doing so is expensive, and you just keep
> assigning new addresses until every one has been used, then you do a global
> IOTLB flush once.

This is in fact exactly what several IOMMUs do - including the Intel
IOMMU driver.

IIRC, the Intel IOMMU driver collects 256 or so  entries to flush and
then flushes them all at once and updates the metadata. I don't if it
does this for ranges assigned to different virtual guests though or
just within a given range.

> Obviously you have to maintain the IO page tables correctly.

To be clear, "Correctly" in this case just means until the IOTLB is
flushed, the given IOMMU Pdir entries are marked "in use" even though
the driver has handed "ownership" back to the IOMMU driver.

cheers,
grant
