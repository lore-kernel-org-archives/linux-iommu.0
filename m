From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH, for-4.19] dma-mapping: add the missing
	ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration
Date: Tue, 25 Sep 2018 22:05:43 +0200
Message-ID: <20180925200542.GA8200@lst.de>
References: <20180911090049.10747-1-hch@lst.de> <20180921061052.GA13705@lst.de>
	<20180921194218.at7ejkmmiucmawzo@pburton-laptop>
	<62B54A6B-6E10-4A40-8E61-C1D23A853816@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <62B54A6B-6E10-4A40-8E61-C1D23A853816-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Sep 22, 2018 at 12:24:33PM -0700, Florian Fainelli wrote:
> >My thought would be that it would be ideal to fix in 4.19 since that's
> >where the breakage is, but having said that I don't have much insight
> >into how bad the breakage is for the affected systems.
> 
> 
> AFAIR, DMA corruption is typically what you would observe, which could prove difficult if you are not exactly looking for it. In any case, I don't have a BMIPS system running 4.19 right now to exercise this on, but this looks correct:

Well, I originally intended it for 4.19, but without reviews from
the affected maintainers I'd fell bad about it.  Now that we've got
agreement I'll queue it for 4.19.
