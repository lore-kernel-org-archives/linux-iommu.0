From: He Zhe <zhe.he-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH v2] kernel/dma: Fix panic caused by passing swiotlb to
	command line
Date: Fri, 11 Jan 2019 09:46:12 +0800
Message-ID: <1cef7480-0838-c044-9bca-9b7adacb0f17@windriver.com>
References: <1543832571-121638-1-git-send-email-zhe.he@windriver.com>
	<b35907a9-4d30-493b-3839-731b10d71c63@windriver.com>
	<20190107090702.GA14033@lst.de>
	<CAPbh3rupHC_G0=5dBhhpoXvXO_=i-Y6p=9WdRtn9W19jRpVVcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAPbh3rupHC_G0=5dBhhpoXvXO_=i-Y6p=9WdRtn9W19jRpVVcg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: konrad-Gq0aWv8utHQdnm+yROfE0A@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 1/11/19 1:27 AM, Konrad Rzeszutek Wilk wrote:
> Let's skip it. There was another patch that would allocate a default 4MB size if it there was an misue of swiotlb parameters.

But this patch mainly fixes a crash. Could you please point me to the patch you mentioned?

Thanks,
Zhe

>
>
>
> On Mon, Jan 7, 2019, 4:07 AM Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org <mailto:hch-jcswGhMUV9g@public.gmane.org> wrote:
>
>     On Mon, Jan 07, 2019 at 04:46:51PM +0800, He Zhe wrote:
>     > Kindly ping.
>
>     Konrad, I'll pick this up through the DMA mapping tree unless you
>     protest in the next few days.
>
