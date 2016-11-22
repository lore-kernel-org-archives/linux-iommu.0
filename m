From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: BUG at drivers/iommu/amd_iommu.c:1436!
Date: Tue, 22 Nov 2016 09:45:22 +0100
Message-ID: <20161122084522.GF2078@8bytes.org>
References: <838275de-6cac-93d8-ca04-54b06a24b3d4@compro.net>
	<20161117214141.GC2078@8bytes.org>
	<f4ababc2-64bf-fd0e-1d18-cb5963d23eb1@compro.net>
	<20161117220045.GD2078@8bytes.org>
	<b8260bfd-55c9-c029-1af1-e1ccc719dd3a@compro.net>
	<20161121153250.GE2078@8bytes.org>
	<4f6afa52-9634-79f4-01af-1ae047aa83f7@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4f6afa52-9634-79f4-01af-1ae047aa83f7-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 21, 2016 at 04:47:59PM -0500, Mark Hounschell wrote:
> OK, I did get this message before the reported BUG message.
> 
> gpiohsd gpiohsd: DMA-API: device driver tries to free DMA memory it has not allocated [device address=0xffffffffffee8000] [size=8192 bytes]
> 
> But I've verified that the dma_addr_t that I get for the alloc, and
> also use for the free is 0x00000000ffee8000 in this case? Is device
> "address=0xffffffffffee8000" in that message a bug in the message or
> do we have a sign extended address problem? It seems strange to me,
> I've never seen a dma_addr_t given, when using the iommu, that
> high. In the past I've seen them as usually 0x00xxxxxx?
> 
> I have also verified that simply changing from
> pci_alloc/free_consistent to the newer DMA API fixes my issue and I
> get no such messages.

Yes, this looks like a sign-extension bug somewhere. But its not in the
amd-iommu driver, because dma-debug also sees it. And from what I can
tell the dma-api interface seems to be fine. It consistently uses
dma_addr_t to pass these values around.

Where can I find the source of the failing code? I need exactly the code
version that triggers the problem.



	Joerg
