From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 4/3] iommu/io-pgtable: Rationalise quirk handling
Date: Fri, 12 Feb 2016 15:55:18 +0000
Message-ID: <20160212155517.GQ25087@arm.com>
References: <cover.1453723096.git.robin.murphy@arm.com>
	<ea1f3d3feec0dc9c18d43393678370b50b1275f5.1455206840.git.robin.murphy@arm.com>
	<20160212120857.GN25087@arm.com> <4282853.vdxKI5JT5z@avalon>
	<56BDF8D8.4010200@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56BDF8D8.4010200-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 12, 2016 at 03:23:04PM +0000, Robin Murphy wrote:
> On 12/02/16 12:32, Laurent Pinchart wrote:
> >On Friday 12 February 2016 12:08:58 Will Deacon wrote:
> >>On Thu, Feb 11, 2016 at 04:13:45PM +0000, Robin Murphy wrote:
> >>>@@ -173,10 +187,12 @@ static inline void io_pgtable_tlb_sync(struct
> >>>io_pgtable *iop)
> >>>   *
> >>>   * @alloc: Allocate a set of page tables described by cfg.
> >>>   * @free:  Free the page tables associated with iop.
> >>>+ * @supported_quirks: Bitmap of quirks supported by the format.
> >>>   */
> >>>  struct io_pgtable_init_fns {
> >>>  	struct io_pgtable *(*alloc)(struct io_pgtable_cfg *cfg, void
> >*cookie);
> >>>  	void (*free)(struct io_pgtable *iop);
> >>>+	unsigned int supported_quirks;
> >>>  };
> >>
> >>My only gripe here is that this is supposed to be a struct of function
> >>pointers... get_supported_quirks() ?
> >
> >Can't we instead say it's a struct of function pointers and static data ? :-)
> >A function to retrieve the supported quirks will just contribute to kernel
> >bloat without adding any extra benefit.
> 
> Bleh - personally I think it's marginally more obvious and readable to have
> the information looking like data, but I'd much sooner just have a
> hard-coded "if (cfq->quirks & ..." check in every format's alloc function
> than introduce a whole new callback. Does that sound like a reasonable
> compromise?

Yeah, do that. You never know, there could be quirks that are only supported
based on other things in the cfg, so it's more extensible that way too.

Will
