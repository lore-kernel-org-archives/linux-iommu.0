From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 4/7] io-64-nonatomic: Add relaxed accessor variants
Date: Mon, 25 Apr 2016 17:11:01 +0100
Message-ID: <20160425161101.GC2122@arm.com>
References: <cover.1460391217.git.robin.murphy@arm.com>
	<5485134.l18Z1dlVmn@wuerfel> <571E3781.3070609@arm.com>
	<4658440.AyDy7GFvoa@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4658440.AyDy7GFvoa@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Hitoshi Mitake <mitake.hitoshi-Zyj7fXuS5i5L9jVzuh4AOg@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 25, 2016 at 05:41:21PM +0200, Arnd Bergmann wrote:
> On Monday 25 April 2016 16:28:01 Robin Murphy wrote:
> > >>>
> > >>> We _could_ - indeed I started doing that, but then decided that the
> > >>> obfuscation of horrible macro-templated functions wasn't worth saving a
> > >>> couple of hundred bytes in some code that isn't exactly difficult to
> > >>> maintain and has needed touching once in 4 years.
> > >>>
> > >>> If you did want to go down the macro route, I may as well also generate both
> > >>> lo-hi and hi-lo headers all from a single template, it'd be really clever...
> > >>> <alarm bells>
> > >>
> > >> I certainly wasn't suggesting any more than the obvious macroisation,
> > >> but I'll leave it up to Arnd, as I think this falls on his lap.
> > >
> > > I'd prefer the open-coded variant as well.
> > 
> > By that, do you mean sticking with the smmu_writeq() implementation in 
> > the driver and dropping this patch, or merging this patch as-is without 
> > further macro-magic?
> > 
> 
> Sorry, that was really ambiguous on my end. I meant leaving patch 4/7
> as it is in the version you posted.

I'm happy with that. Could I have your ack, so that I can queue it with
the related SMMU patches, please?

Will
