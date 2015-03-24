From: "Wu, Feng" <feng.wu@intel.com>
Subject: RE: [v4 2/8] iommu, x86: Define new irte structure for VT-d
 Posted-Interrupts
Date: Tue, 24 Mar 2015 02:32:01 +0000
Message-ID: <E959C4978C3B6342920538CF579893F00245824F@SHSMSX104.ccr.corp.intel.com>
References: <1422864424-19411-1-git-send-email-feng.wu@intel.com>
 <1422864424-19411-3-git-send-email-feng.wu@intel.com>
 <20150323115754.GN4441@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150323115754.GN4441@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wu, Feng" <feng.wu@intel.com>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Monday, March 23, 2015 7:58 PM
> To: Wu, Feng
> Cc: dwmw2@infradead.org; jiang.liu@linux.intel.com;
> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> Subject: Re: [v4 2/8] iommu, x86: Define new irte structure for VT-d
> Posted-Interrupts
> 
> Hi Feng,
> 
> On Mon, Feb 02, 2015 at 04:06:58PM +0800, Feng Wu wrote:
> > Add a new irte_pi structure for VT-d Posted-Interrupts.
> >
> > Signed-off-by: Feng Wu <feng.wu@intel.com>
> > Reviewed-by: Jiang Liu <jiang.liu@linux.intel.com>
> > Acked-by: David Woodhouse <David.Woodhouse@intel.com>
> > ---
> >  include/linux/dmar.h |   32 ++++++++++++++++++++++++++++++++
> >  1 files changed, 32 insertions(+), 0 deletions(-)
> >
> > diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> > index 8473756..c7f9cda 100644
> > --- a/include/linux/dmar.h
> > +++ b/include/linux/dmar.h
> > @@ -212,6 +212,38 @@ struct irte {
> >  	};
> >  };
> >
> > +struct irte_pi {
> 
> I think it is better to put this as a union into struct irte. It saves
> memory and unnecessary casting in later patches.

Thanks for the comments!

Do you mean doing it like the following?

struct irte {
        union {
                struct {
                        __u64   present         : 1,
                                fpd             : 1,
                                dst_mode        : 1,
                                redir_hint      : 1,
                                trigger_mode    : 1,
                                dlvry_mode      : 3,
                                avail           : 4,
                                __reserved_1    : 4,
                                vector          : 8,
                                __reserved_2    : 8,
                                dest_id         : 32;
                };
                struct {
                        __u64   present         : 1,
                                fpd             : 1,
                                __reserved_1    : 6,
                                avail           : 4,
                                __reserved_2    : 2,
                                urg             : 1,
                                pst             : 1,
                                vector          : 8,
                                __reserved_3    : 14,
                                pda_l           : 26;
                };
                __u64 low;
        };

        union {
                struct {
                        __u64   sid             : 16,
                                sq              : 2,
                                svt             : 2,
                                __reserved_3    : 44;
                };
                struct {
                        __u64   sid             : 16,
                                sq              : 2,
                                svt             : 2,
                                __reserved_4    : 12,
                                pda_h           : 32;
                };
                __u64 high;
        };
};

In fact, I also intended to make these two defines as one, however, this code will get build
error ("duplicated member") with new version of GCC, such as, gcc 4.9.1. I cannot find a
good way to handle this gracefully, since I don't want to impact the existing usage of this
structure . Do you have any ideas about this? Thanks a lot!

Thanks,
Feng

> 
> 
> 	Joerg
