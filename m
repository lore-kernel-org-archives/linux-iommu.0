From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] of/device: Really only set bus DMA mask when appropriate
Date: Wed, 7 Nov 2018 12:56:49 +0000
Message-ID: <22cbe798-612f-8c88-90e7-388202f603cf@arm.com>
References: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
	<20181107080335.GA24511@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181107080335.GA24511-jcswGhMUV9g@public.gmane.org>
Content-Language: en-GB
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
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2018-11-07 8:03 am, Christoph Hellwig wrote:
> On Tue, Nov 06, 2018 at 11:54:15AM +0000, Robin Murphy wrote:
>> of_dma_configure() was *supposed* to be following the same logic as
>> acpi_dma_configure() and only setting bus_dma_mask if some range was
>> specified by the firmware. However, it seems that subtlety got lost in
>> the process of fitting it into the differently-shaped control flow, and
>> as a result the force_dma==true case ends up always setting the bus mask
>> to the 32-bit default, which is not what anyone wants.
>>
>> Make sure we only touch it if the DT actually said so.
> 
> This looks good, but I think it could really use a comment as the use
> of ret all the way down the function isn't exactly obvious.

Fair point.

> Let me now if you want this picked up through the OF or DMA trees.

I don't mind either way; I figure I'll wait a bit longer to see if Rob 
has any preference, then resend with the comment and the tags picked up 
so it can hopefully make rc2.

Robin.
