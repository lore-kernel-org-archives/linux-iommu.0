From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 3/6] iommu: add ARM short descriptor page table
	allocator.
Date: Fri, 31 Jul 2015 15:55:37 +0800
Message-ID: <1438329337.25925.147.camel@mhfsdcap03>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
	<1437037475-9065-4-git-send-email-yong.wu@mediatek.com>
	<20150721171101.GN31095@arm.com> <1437715466.23932.68.camel@mhfsdcap03>
	<20150724165325.GC21177@arm.com> <1437970868.25925.20.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4906416033384081261=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1437970868.25925.20.camel@mhfsdcap03>
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
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, th.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org" <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, "frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Daniel
List-Id: iommu@lists.linux-foundation.org

--===============4906416033384081261==
Content-Type: multipart/alternative; boundary="=-qDWx1sQZzXXbQxdAjX8h"

--=-qDWx1sQZzXXbQxdAjX8h
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2015-07-27 at 12:21 +0800, Yong Wu wrote:

> On Fri, 2015-07-24 at 17:53 +0100, Will Deacon wrote:
> > On Fri, Jul 24, 2015 at 06:24:26AM +0100, Yong Wu wrote:
> > > On Tue, 2015-07-21 at 18:11 +0100, Will Deacon wrote:
> > > > On Thu, Jul 16, 2015 at 10:04:32AM +0100, Yong Wu wrote:
> > > > > +/* level 2 pagetable */
> > > > > +#define ARM_SHORT_PTE_TYPE_LARGE               BIT(0)
> > > > > +#define ARM_SHORT_PTE_SMALL_XN                 BIT(0)
> > > > > +#define ARM_SHORT_PTE_TYPE_SMALL               BIT(1)
> > > > > +#define ARM_SHORT_PTE_B                                BIT(2)
> > > > > +#define ARM_SHORT_PTE_C                                BIT(3)
> > > > > +#define ARM_SHORT_PTE_SMALL_TEX0               BIT(6)
> > > > > +#define ARM_SHORT_PTE_IMPLE                    BIT(9)
> > > >
> > > > This is AP[2] for small pages.
> > > 
> > > Sorry, In our pagetable bit9 in PGD and PTE is PA[32] that is for  the
> > > dram size over 4G. I didn't care it is different in PTE of the standard
> > > spec.
> > > And I don't use the AP[2] currently, so I only delete this line in next
> > > time.
> > 
> > Is this related to the "special bit". What would be good is a comment
> > next to the #define for the quirk describing *exactly* that differs in
> > your implementation. Without that, it's very difficult to know what is
> > intentional and what is actually broken.
> 
> I will add the comment alongside the #define.
> 
> > 
> > > > > +static arm_short_iopte
> > > > > +__arm_short_pte_prot(struct arm_short_io_pgtable *data, int prot, bool large)
> > > > > +{
> > > > > +       arm_short_iopte pteprot;
> > > > > +
> > > > > +       pteprot = ARM_SHORT_PTE_S | ARM_SHORT_PTE_nG;
> > > > > +       pteprot |= large ? ARM_SHORT_PTE_TYPE_LARGE :
> > > > > +                               ARM_SHORT_PTE_TYPE_SMALL;
> > > > > +       if (prot & IOMMU_CACHE)
> > > > > +               pteprot |=  ARM_SHORT_PTE_B | ARM_SHORT_PTE_C;
> > > > > +       if (prot & IOMMU_WRITE)
> > > > > +               pteprot |= large ? ARM_SHORT_PTE_LARGE_TEX0 :
> > > > > +                               ARM_SHORT_PTE_SMALL_TEX0;
> > > >
> > > > This doesn't make any sense. TEX[2:0] is all about memory attributes, not
> > > > permissions, so you're making the mapping write-back, write-allocate but
> > > > that's not what the IOMMU_* values are about.
> > > 
> > >      I will delete it.
> > 
> > Well, can you not control mapping permissions with the AP bits? The idea
> > of the IOMMU flags are:
> > 
> >   IOMMU_CACHE : Install a normal, cacheable mapping (you've got this right)
> >   IOMMU_READ : Allow read access for the device
> >   IOMMU_WRITE : Allow write access for the device
> >   IOMMU_NOEXEC : Disallow execute access for the device
> > 
> > so the caller to iommu_map passes in a bitmap of these, which you need to
> > encode in the page-table entry.
> 
> From the spec, AP[2] differentiate the read/write and readonly.
> How about this?: 
> //===============
>   #define ARM_SHORT_PGD_FULL_ACCESS  (3 << 10) 
>   #define ARM_SHORT_PGD_RDONLY       BIT(15)
> 
>   pgdprot |= ARM_SHORT_PGD_FULL_ACCESS;/* or other names? */
>   if(!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
>      pgdprot |= ARM_SHORT_PGD_RDONLY;
> //===============
> pte is the same. 
> 
> Sorry, Our HW don't meet the standard spec fully. it don't implement the
> AP bits.



Hi Will, 
    About the AP bits, I may have to add a new quirk for it...

  Current I add AP in pte like this:
 #define ARM_SHORT_PTE_RD_WR        (3 << 4) 
 #define ARM_SHORT_PTE_RDONLY       BIT(9)

 pteprot |=  ARM_SHORT_PTE_RD_WR;

 If(!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))

      pteprot |= ARM_SHORT_PTE_RDONLY;

The problem is that the BIT(9) in the level1 and level2 pagetable of our
HW has been used for PA[32] that is for the dram size over 4G.

so I had to add a quirk to disable bit9 while RDONLY case.
(If BIT9 isn't disabled, the HW treat it as the PA[32] case then it will
translation fault..)

like: IO_PGTABLE_QUIRK_SHORT_MTK ?


> > 
> > Will
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



--=-qDWx1sQZzXXbQxdAjX8h
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/4.2.2">
</HEAD>
<BODY>
On Mon, 2015-07-27 at 12:21 +0800, Yong Wu wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
On Fri, 2015-07-24 at 17:53 +0100, Will Deacon wrote:
&gt; On Fri, Jul 24, 2015 at 06:24:26AM +0100, Yong Wu wrote:
&gt; &gt; On Tue, 2015-07-21 at 18:11 +0100, Will Deacon wrote:
&gt; &gt; &gt; On Thu, Jul 16, 2015 at 10:04:32AM +0100, Yong Wu wrote:
&gt; &gt; &gt; &gt; +/* level 2 pagetable */
&gt; &gt; &gt; &gt; +#define ARM_SHORT_PTE_TYPE_LARGE               BIT(0)
&gt; &gt; &gt; &gt; +#define ARM_SHORT_PTE_SMALL_XN                 BIT(0)
&gt; &gt; &gt; &gt; +#define ARM_SHORT_PTE_TYPE_SMALL               BIT(1)
&gt; &gt; &gt; &gt; +#define ARM_SHORT_PTE_B                                BIT(2)
&gt; &gt; &gt; &gt; +#define ARM_SHORT_PTE_C                                BIT(3)
&gt; &gt; &gt; &gt; +#define ARM_SHORT_PTE_SMALL_TEX0               BIT(6)
&gt; &gt; &gt; &gt; +#define ARM_SHORT_PTE_IMPLE                    BIT(9)
&gt; &gt; &gt;
&gt; &gt; &gt; This is AP[2] for small pages.
&gt; &gt; 
&gt; &gt; Sorry, In our pagetable bit9 in PGD and PTE is PA[32] that is for  the
&gt; &gt; dram size over 4G. I didn't care it is different in PTE of the standard
&gt; &gt; spec.
&gt; &gt; And I don't use the AP[2] currently, so I only delete this line in next
&gt; &gt; time.
&gt; 
&gt; Is this related to the &quot;special bit&quot;. What would be good is a comment
&gt; next to the #define for the quirk describing *exactly* that differs in
&gt; your implementation. Without that, it's very difficult to know what is
&gt; intentional and what is actually broken.

I will add the comment alongside the #define.

&gt; 
&gt; &gt; &gt; &gt; +static arm_short_iopte
&gt; &gt; &gt; &gt; +__arm_short_pte_prot(struct arm_short_io_pgtable *data, int prot, bool large)
&gt; &gt; &gt; &gt; +{
&gt; &gt; &gt; &gt; +       arm_short_iopte pteprot;
&gt; &gt; &gt; &gt; +
&gt; &gt; &gt; &gt; +       pteprot = ARM_SHORT_PTE_S | ARM_SHORT_PTE_nG;
&gt; &gt; &gt; &gt; +       pteprot |= large ? ARM_SHORT_PTE_TYPE_LARGE :
&gt; &gt; &gt; &gt; +                               ARM_SHORT_PTE_TYPE_SMALL;
&gt; &gt; &gt; &gt; +       if (prot &amp; IOMMU_CACHE)
&gt; &gt; &gt; &gt; +               pteprot |=  ARM_SHORT_PTE_B | ARM_SHORT_PTE_C;
&gt; &gt; &gt; &gt; +       if (prot &amp; IOMMU_WRITE)
&gt; &gt; &gt; &gt; +               pteprot |= large ? ARM_SHORT_PTE_LARGE_TEX0 :
&gt; &gt; &gt; &gt; +                               ARM_SHORT_PTE_SMALL_TEX0;
&gt; &gt; &gt;
&gt; &gt; &gt; This doesn't make any sense. TEX[2:0] is all about memory attributes, not
&gt; &gt; &gt; permissions, so you're making the mapping write-back, write-allocate but
&gt; &gt; &gt; that's not what the IOMMU_* values are about.
&gt; &gt; 
&gt; &gt;      I will delete it.
&gt; 
&gt; Well, can you not control mapping permissions with the AP bits? The idea
&gt; of the IOMMU flags are:
&gt; 
&gt;   IOMMU_CACHE : Install a normal, cacheable mapping (you've got this right)
&gt;   IOMMU_READ : Allow read access for the device
&gt;   IOMMU_WRITE : Allow write access for the device
&gt;   IOMMU_NOEXEC : Disallow execute access for the device
&gt; 
&gt; so the caller to iommu_map passes in a bitmap of these, which you need to
&gt; encode in the page-table entry.

>From the spec, AP[2] differentiate the read/write and readonly.
How about this?: 
//===============
  #define ARM_SHORT_PGD_FULL_ACCESS  (3 &lt;&lt; 10) 
  #define ARM_SHORT_PGD_RDONLY       BIT(15)

  pgdprot |= ARM_SHORT_PGD_FULL_ACCESS;/* or other names? */
  if(!(prot &amp; IOMMU_WRITE) &amp;&amp; (prot &amp; IOMMU_READ))
     pgdprot |= ARM_SHORT_PGD_RDONLY;
//===============
pte is the same. 

Sorry, Our HW don't meet the standard spec fully. it don't implement the
AP bits.
</PRE>
</BLOCKQUOTE>
<PRE>

</PRE>
Hi Will, <BR>
&nbsp;&nbsp;&nbsp; About the AP bits, I may have to add a new quirk for it...<BR>
<BR>
&nbsp; Current I add AP in pte like this:<BR>
 #define ARM_SHORT_PTE_RD_WR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (3 &lt;&lt; 4) <BR>
 #define ARM_SHORT_PTE_RDONLY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BIT(9)<BR>
<BR>
 pteprot |=&nbsp; ARM_SHORT_PTE_RD_WR;
<PRE>
 If(!(prot &amp; IOMMU_WRITE) &amp;&amp; (prot &amp; IOMMU_READ))
</PRE>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pteprot |= ARM_SHORT_PTE_RDONLY;<BR>
<BR>
The problem is that the BIT(9) in the level1 and level2 pagetable of our HW has been used for PA[32] that is for the dram size over 4G.<BR>
<BR>
so I had to add a quirk to disable bit9 while RDONLY case.<BR>
(If BIT9 isn't disabled, the HW treat it as the PA[32] case then it will translation fault..)<BR>
<BR>
like: IO_PGTABLE_QUIRK_SHORT_MTK ?<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
&gt; 
&gt; Will
_______________________________________________
Linux-mediatek mailing list
<A HREF="mailto:Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org">Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org</A>
<A HREF="http://lists.infradead.org/mailman/listinfo/linux-mediatek">http://lists.infradead.org/mailman/listinfo/linux-mediatek</A>
</PRE>
</BLOCKQUOTE>
<BR>
</BODY>
</HTML>

--=-qDWx1sQZzXXbQxdAjX8h--

--===============4906416033384081261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4906416033384081261==--
