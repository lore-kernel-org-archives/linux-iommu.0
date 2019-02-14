From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: ARM64 boot failure on espressobin with 5.0.0-rc6
	(1f947a7a011fcceb14cb912f5481a53b18f1879a)
Date: Thu, 14 Feb 2019 17:58:42 +0000
Message-ID: <fd389e6a-b10c-77fb-ac79-b15ffd805a7d@arm.com>
References: <bd202e22-c23e-ddf1-ef33-e60896465a5a@bell.net>
	<6d11c3cf-ce21-f1d6-df6f-8678f4159e3c@arm.com>
	<20190214173642.GA2704@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190214173642.GA2704-jcswGhMUV9g@public.gmane.org>
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
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, John David Anglin <dave.anglin-CzeTG9NwML0@public.gmane.org>
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 14/02/2019 17:36, Christoph Hellwig wrote:
> On Thu, Feb 14, 2019 at 05:27:41PM +0000, Robin Murphy wrote:
>> Oh wow, that driver has possibly the most inventive way of passing a NULL
>> device to the DMA API that I've ever seen, and on arm64 it will certainly
>> have been failing since 4.2, but of course there's also no error checking
>> for anyone to notice...
> 
> I did take a brief look and didn't see how we got the NULL device
> pointer, so it is well hidden for sure.
> 
>> This crash will be a fallout from 356da6d0cd (plus the subsequent fix in
>> 9ab91e7c5c51) that's otherwise missed Christoph's big cleanup. Obviously
>> the right thing to do is for someone to try to figure out the steaming pile
>> of mess in that driver, but if necessary I think the quick fix below should
>> probably suffice to mitigate the change in the short term.
> 
> The fix looks ok.  And for 5.2 I plan to explicitly reject all uses of
> NULL device arguments in the DMA API.  I've sent patches out for all
> the obviously problemetic drivers, and most of them got accepted by the
> maintainers for the 5.1 merge window.
> 
> It seems like the mv_xor code is mostly unmaintained as far as I can
> tell unfortunately.

Hmm, having felt brave enough to take a closer look, it might actually 
be as simple as this - Dave, are you able to give the diff below a spin?

Robin.

----->8-----
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 7f595355fb79..fe4a7c71fede 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1059,6 +1059,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
  		mv_chan->op_in_desc = XOR_MODE_IN_DESC;

  	dma_dev = &mv_chan->dmadev;
+	dma_dev->dev = &pdev->dev;
  	mv_chan->xordev = xordev;

  	/*
@@ -1091,7 +1092,6 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
  	dma_dev->device_free_chan_resources = mv_xor_free_chan_resources;
  	dma_dev->device_tx_status = mv_xor_status;
  	dma_dev->device_issue_pending = mv_xor_issue_pending;
-	dma_dev->dev = &pdev->dev;

  	/* set prep routines based on capability */
  	if (dma_has_cap(DMA_INTERRUPT, dma_dev->cap_mask))
