From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 1/5] base: dma-mapping: Export commonly used symbols
Date: Thu, 6 Jul 2017 00:22:35 +0900
Message-ID: <CAAFQd5DijKbNJ-8wHh=+2Z2y1nSF-LC8R+d+NktTRF4iQqPsrA@mail.gmail.com>
References: <20170705071215.17603-1-tfiga@chromium.org>
	<20170705071215.17603-2-tfiga@chromium.org>
	<20170705151728.GA2479@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170705151728.GA2479-jcswGhMUV9g@public.gmane.org>
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

Hi Christoph,

Thanks for comments!

On Thu, Jul 6, 2017 at 12:17 AM, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
> Please use EXPORT_SYMBOL_GPL for any of these exports, as they are
> internal linux implementration details by any definition of it.

Right. I typically lean towards EXPORT_SYMBOL_GPL(), but was misled by
existing EXPORT_SYMBOL()s in the file. Will fix.

>
> On Wed, Jul 05, 2017 at 04:12:11PM +0900, Tomasz Figa wrote:
>> There is nothing wrong in having a loadable module implementing DMA API,
>> for example to be used for sub-devices registered by the module.
>> However, most of the functions from dma-mapping do not have their
>> symbols exported, making it impossible to use them from loadable modules.
>
> I'd like to see the patches for this use case as well.  We don't
> generally export symbols without seeing the users.

Generally the user is a work in progress that should be posted in a
very near future. You can find a reference to our downstream tree at
chromium.org in the cover letter. Obviously I don't mind including
patches from this series in the driver series later and that's one of
the reasons for this series being RFC.

Best regards,
Tomasz
