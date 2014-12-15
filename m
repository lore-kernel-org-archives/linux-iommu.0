From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/4] iommu: add ARM LPAE page table allocator
Date: Mon, 15 Dec 2014 16:43:59 +0000
Message-ID: <BN3PR0301MB12199C5CAD33E745CC7E51F4EA6F0@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
	<1417089078-22900-3-git-send-email-will.deacon@arm.com>
	<BN3PR0301MB12198CE5D736CDC6A221EDC2EA790@BN3PR0301MB1219.namprd03.prod.outlook.com>
	<20141205184802.GH1203@arm.com>
	<BN3PR0301MB1219D3161E4E9DB314FDD8FAEA6E0@BN3PR0301MB1219.namprd03.prod.outlook.com>
	<20141215133020.GJ20738@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141215133020.GJ20738-5wv7dgnIgG8@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org" <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



-----Original Message-----
From: Will Deacon [mailto:will.deacon-5wv7dgnIgG8@public.gmane.org] 
Sent: Monday, December 15, 2014 7:00 PM
To: Sethi Varun-B16395
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org; Robin Murphy; lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org; mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org; laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Subject: Re: [PATCH 2/4] iommu: add ARM LPAE page table allocator

On Sun, Dec 14, 2014 at 05:45:49PM +0000, Varun Sethi wrote:
> Please find my response inline. Search for "varun".

This is getting fiddly now that you've already replied once. Any chance you could sort your mail client out, please?


[[varun]]  Yes I need to do that, this is painful.

> > +       if (!data)
> > +               return NULL;
> > +
> > +       data->pages_per_pgd = 1;
> > +       data->pg_shift = __ffs(cfg->pgsize_bitmap);
> > +       data->bits_per_level = data->pg_shift - 
> > + ilog2(sizeof(arm_lpae_iopte));
> > +
> > +       va_bits = cfg->ias - data->pg_shift;
> > +       data->levels = DIV_ROUND_UP(va_bits, data->bits_per_level);
> >
> > [[varun]]  Not related to the patch, but this would be applicable to 
> > the CPU tables as well i.e, we can't support 48bit VA with 64 KB 
> > page tables, right? The AR64 memory maps shows possibility of using 
> > 6 bits for the first level page table.
> 
> Sure we can support 48-bit VAs with 64k pages. Why do you think we can't?
> 
> [varun]  My concern was with respect to the bits per level, which is 
> uneven for the 64 K page sizes. Just wondering how would things work 
> with 64K pages when we do a 3 level page lookup.

Well, it's uneven (9) for the 4k case too. Do you actually see an issue here?

48-bit VA with 64k pages gives us:

  va_bits = (48 - 16) = 32
  bits_per_level = (16 - 3) = 13
  levels = ceil(32/13) = 3

so the starting level is 1, which resolves 32-(13*2) = 6 bits.

Does that make sense?

[[varun]]Yes, but what I meant was, is that in case of 4K pages you have 9 bits per level, but for 64K pages you have 6 bits for the first  level and 13 each for second and third. So, bits per level would not work in case of 64 K pages?

Thanks,
Varun
