From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v1] iommu/io-pgtable-arm-v7s: Check for leaf entry
	right after finding it
Date: Fri, 24 Feb 2017 15:18:23 +0000
Message-ID: <20170224151823.GH20130@arm.com>
References: <1487253137-13792-1-git-send-email-olekstysh@gmail.com>
	<bc24299c-748a-4b86-fead-a9ed6b5e5b9f@arm.com>
	<CAPD2p-nPoiSanU4jYvnaYtAbbERE8c=4mLjTC3NX2bGYkZM5UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPD2p-nPoiSanU4jYvnaYtAbbERE8c=4mLjTC3NX2bGYkZM5UA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Oleksandr Tyshchenko <olekstysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>, Volodymyr Babchuk <vlad.babchuk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andrii Anisov <andrii.anisov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oleksandr Andrushchenko <andr2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, al1img <al1img-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Artem Mygaiev <joculator-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 21, 2017 at 03:31:26PM +0200, Oleksandr Tyshchenko wrote:
> On Tue, Feb 21, 2017 at 2:00 PM, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> > Would it not be more logical (and simpler) to just check that the thing
> > we dereference is valid to dereference when we dereference it? i.e.:
> >
> > -----8<-----
> > diff --git a/drivers/iommu/io-pgtable-arm-v7s.c
> > b/drivers/iommu/io-pgtable-arm-v7s.c
> > index 0769276c0537..f3112f9ff494 100644
> > --- a/drivers/iommu/io-pgtable-arm-v7s.c
> > +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> > @@ -418,8 +418,10 @@ static int __arm_v7s_map(struct arm_v7s_io_pgtable
> > *data, unsigned long iova,
> >                         pte |= ARM_V7S_ATTR_NS_TABLE;
> >
> >                 __arm_v7s_set_pte(ptep, pte, 1, cfg);
> > -       } else {
> > +       } else if (ARM_V7S_PTE_IS_TABLE(pte, lvl)) {
> >                 cptep = iopte_deref(pte, lvl);
> > +       } else {
> > +               return -EEXIST;
> >         }
> >
> >         /* Rinse, repeat */
> > ----->8-----
> 
> Agree. Sounds reasonable.
> 
> >
> > I think the equivalent could be done in LPAE as well.
> 
> OK.
> 
> I will resend both modified patches without RFC prefix, right?

Sounds good to me.

Will
