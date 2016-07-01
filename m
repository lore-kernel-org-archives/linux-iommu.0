From: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [RFC 1/2] iommu/dma: Restrict IOVAs to physical memory layout
Date: Fri, 1 Jul 2016 16:03:07 +0000
Message-ID: <HE1PR04MB1641583BE6AFF39AF1BFCEFB8D250@HE1PR04MB1641.eurprd04.prod.outlook.com>
References: <cover.1467123945.git.robin.murphy@arm.com>
	<ac9b11493dfa3500889268488adfa8d4d5c34962.1467129314.git.robin.murphy@arm.com>
	<CALRxmdCuxLPogPTwpn2-B=PU=Ry0eNtgs2z+iZBPYtDc3NX-hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CALRxmdCuxLPogPTwpn2-B=PU=Ry0eNtgs2z+iZBPYtDc3NX-hQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Date: Tue, Jun 28, 2016 at 11:18 AM
> Subject: [RFC 1/2] iommu/dma: Restrict IOVAs to physical memory layout
> To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> 
> 
> Certain peripherals may be bestowed with knowledge of the physical
> memory map of the system in which they live, and refuse to handle
> addresses that they do not think are memory, which causes issues when
> remapping to arbitrary IOVAs. Sidestep the issue by restricting IOVA
> domains to only allocate addresses within ranges which match the
> physical memory layout.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> Posting this as an RFC because it's something I've been having to use
> on Juno for all the PCI IOMMU development - it's pretty horrible, but I
> can't easily think of a nicer solution...

Maybe I'm not getting the implications of this looking at the patch 
in isolation, but how will this impact systems that have devices
limited to 32-bit addressing?

In our memory map we have physical memory regions at:
0x00_8000_0000
0x80_8000_0000

Will devices with a 32-bit DMA mask still get 32-bit IOVAs?

Thanks,
Stuart
