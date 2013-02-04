From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/5] iommu: Add domain window handling functions
Date: Mon, 4 Feb 2013 19:56:50 +0100
Message-ID: <20130204185650.GP25591@8bytes.org>
References: <1359983924-28952-1-git-send-email-joro@8bytes.org>
	<1359983924-28952-5-git-send-email-joro@8bytes.org>
	<CALRxmdCiSZgoqd8tp90kPCdA=s7SWZCTwKsFnWu7S5=U7+eRLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CALRxmdCiSZgoqd8tp90kPCdA=s7SWZCTwKsFnWu7S5=U7+eRLQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stuart Yoder <b08248-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 04, 2013 at 12:10:51PM -0600, Stuart Yoder wrote:
> On Mon, Feb 4, 2013 at 7:18 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> > +static inline int iommu_domain_window_enable(struct iommu_domain *domain,
> > +                                            u32 wnd_nr, phys_addr_t paddr,
> > +                                            size_t size)
> > +{
> > +       return -ENODEV;
> > +}
> > +
> > +static inline void iommu_domain_window_disable(struct iommu_domain *domain,
> > +                                              u32 wnd_nr)
> > +{
> > +}
> > +
> >  static inline phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain,
> >                                              unsigned long iova)
> >  {
> 
> This API looks workable.   The one change we need is that the size argument in
> the enable API needs to be 64 bits.   Our window sizes can exceed 4GB.

Okay. So if your architecture supports sizes over 2^32 then size_t
probably is already 64bits, right?


	Joerg
