From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] base: dma-mapping: Export commonly used symbols
Date: Thu, 6 Jul 2017 10:44:05 +0900
Message-ID: <CAAFQd5CkVYd6uyoFP_15N8ZaZp8jivJ-4S=CAvrTynRU2ShFYg@mail.gmail.com>
References: <20170705071215.17603-1-tfiga@chromium.org>
	<20170705071215.17603-2-tfiga@chromium.org>
	<20170705151728.GA2479@lst.de>
	<CAAFQd5DijKbNJ-8wHh=+2Z2y1nSF-LC8R+d+NktTRF4iQqPsrA@mail.gmail.com>
	<20170705172019.GB5246@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170705172019.GB5246-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Hans-Christian Noren Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 6, 2017 at 2:20 AM, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
> On Thu, Jul 06, 2017 at 12:22:35AM +0900, Tomasz Figa wrote:
>> Generally the user is a work in progress that should be posted in a
>> very near future. You can find a reference to our downstream tree at
>> chromium.org in the cover letter. Obviously I don't mind including
>> patches from this series in the driver series later and that's one of
>> the reasons for this series being RFC.
>
> Please post and explain them here.

That's the intention. I will talk with people to try to get it posted earlier.

You can also refer to the old series, which we are reworking to
address review comments:
https://www.mail-archive.com/linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg113505.html

The old code essentially reimplements all the DMA mapping operations
on its own, without using the generic helpers (and not even following
the API properly, see my review comments to the original patch 2 and
3), which IMHO is really ugly (but avoids exporting symbols of the
helpers, which I assumed to be a no-problem).

> In general I think moving dma
> ops and iommu implementations into modules is a bad idea

Could you elaborate on this? I'd be interested in seeing the reasoning
behind this.

> but I
> don't want to reject the idea before seeing the code.  Or maybe
> by looking at the user we can come up with an even better idea
> to solve the original issue you're trying to solve, so please also
> explain your rationale.

Basically we have an x86 platform with a camera subsystem that is a
PCI device, has its own MMU and needs cache maintenance. Moreover, the
V4L2 subsystem, which is the right place for camera drivers, heavily
relies on DMA mapping as a way to abstract memory allocation, mapping
and cache maintenance. So it feels natural to me to hide the hardware
details (additional cache maintenance, mapping into the built-in
IOMMU) in the DMA mapping ops for this camera subsystem and simply
make V4L2 just work without knowing those details.

Best regards,
Tomasz
