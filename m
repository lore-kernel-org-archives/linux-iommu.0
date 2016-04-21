From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 0/5] Introduce per-domain page sizes
Date: Thu, 21 Apr 2016 17:38:27 +0100
Message-ID: <20160421163826.GM929@arm.com>
References: <cover.1460048991.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1460048991.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 07, 2016 at 06:42:03PM +0100, Robin Murphy wrote:
> Hi all,

Hi Robin,

> Since this area seems to be in vogue at the moment, here's what I was
> working on when the related patches[1][2] popped up, which happens to
> be more or less the intersection of both. As I recycled some of Will's
> old series as a starting point, I've retained the cleanup patches from
> that with their original acks - hope that's OK.
> 
> Fortunately, this already looks rather like parts of Joerg's plan[3],
> so I hope it's a suitable first step. Below is a quick hacked-up example
> of the kind of caller-controlled special use-case alluded to, using the
> SMMU/HDLCD combo on Juno - for a 'real' implementation of this we'd want
> the group-based domain allocation call so the driver could throw the
> device at that and get its own non-default DMA ops domain to play with.

I like this series a lot and it moves us a significant step closer to
being able to request specific IOMMU geometry at domain initialisation
time. For the series:

Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

Will
