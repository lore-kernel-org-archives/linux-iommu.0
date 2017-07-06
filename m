From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] base: dma-mapping: Export commonly used symbols
Date: Thu, 6 Jul 2017 14:23:57 +0200
Message-ID: <CAK8P3a2JyQ-qLgh+ig4yWMJvB0AGjspMu8P8fNrPHgm3NMCGNw@mail.gmail.com>
References: <20170705071215.17603-1-tfiga@chromium.org>
	<20170705071215.17603-2-tfiga@chromium.org>
	<20170705151728.GA2479@lst.de>
	<CAAFQd5DijKbNJ-8wHh=+2Z2y1nSF-LC8R+d+NktTRF4iQqPsrA@mail.gmail.com>
	<20170705172019.GB5246@lst.de>
	<CAAFQd5CkVYd6uyoFP_15N8ZaZp8jivJ-4S=CAvrTynRU2ShFYg@mail.gmail.com>
	<CAK8P3a2htZ7q=npfwJVW7Lr90O78Ey+OR5e0ivaR7GwV4YBs=A@mail.gmail.com>
	<CAAFQd5BMorNa8CD+cEap2=boD2-=jr+DFF9cXTNXzSSfe7FnLg@mail.gmail.com>
	<CAAFQd5BFLvWS5n8owm053GNC5VniMq-8Gh0BHo43B-TYShpsnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5BFLvWS5n8owm053GNC5VniMq-8Gh0BHo43B-TYShpsnA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Linux Media Mailing List <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Hans-Christian Noren Egtvedt <egtvedt-BrfabpQBY5qlHtIdYg32fQ@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Pawel Osciak <posciak-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 6, 2017 at 10:36 AM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> On Thu, Jul 6, 2017 at 5:34 PM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>> On Thu, Jul 6, 2017 at 5:26 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
>>> On Thu, Jul 6, 2017 at 3:44 AM, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:

>>
>> I'd say that this is something that has been consistently tried to be
>> avoided by V4L2 and that's why it's so tightly integrated with DMA
>> mapping. IMHO re-implementing the code that's already there in
>> videobuf2 again in the driver, only because, for no good reason
>> mentioned as for now, having a loadable module providing DMA ops was
>> disliked.
>
> Sorry, I intended to mean:
>
> IMHO re-implementing the code that's already there in videobuf2 again
> in the driver, only because, for no good reason mentioned as for now,
> having a loadable module providing DMA ops was disliked, would make no
> sense.

Why would we need to duplicate that code? I would expect that the videobuf2
core can simply call the regular dma_mapping interfaces, and you handle the
IOPTE generation at the point when the buffer is handed off from the core
code to the device driver. Am I missing something?

       Arnd
