From: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [Linaro-mm-sig] DMA mapping API(IOMMU) for ARM64?
Date: Wed, 5 Feb 2014 21:40:39 +0530
Message-ID: <CAD15agYTz79MxLfuG7KM4JvGyw74FjCtP-5u1ca1KcS0NMuXEQ@mail.gmail.com>
References: <20130618.053955.305832937374936961.hdoyu@nvidia.com>
	<20130618101914.GB3539@mudshark.cambridge.arm.com>
	<5159282.rrJMaZuYMv@wuerfel>
	<20130618.140137.1551430695673122122.hdoyu@nvidia.com>
	<20130618125054.GL9930@arm.com> <51C0DA4F.1010405@redhat.com>
	<20130619111137.GJ9261@MacBook-Pro.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0824720632019528824=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130619111137.GJ9261-jF64zX8BO082Zs7wWoiTUGZHpeb/A1Y/@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============0824720632019528824==
Content-Type: multipart/alternative; boundary=089e01633aa8746aba04f1aaffea

--089e01633aa8746aba04f1aaffea
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

Frankly speaking, I didn't follow up this discussion until this point where
I wanted to know whether we have iommu ops support in dma-mapping API for
64BIT ARM Arch.
If anyone can please provide some more info as what is the current status
on this and is it completely supported now ?



Thanks
Ritesh





On Wed, Jun 19, 2013 at 4:41 PM, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>wrote:

> On Tue, Jun 18, 2013 at 11:08:15PM +0100, Don Dutile wrote:
> > On 06/18/2013 08:50 AM, Catalin Marinas wrote:
> > > On Tue, Jun 18, 2013 at 12:01:37PM +0100, Hiroshi Doyu wrote:
> > >> Arnd Bergmann<arnd-r2nGTMty4D4@public.gmane.org>  wrote @ Tue, 18 Jun 2013 12:32:44
> +0200:
> > >>> On Tuesday 18 June 2013 11:19:14 Will Deacon wrote:
> > >>>> I've spoken briefly with Catalin about this and it seems like there
> might be
> > >>>> *some* scope for sharing common dma-mapping code between
> architectures.
> > >>>> There doesn't really need to be any architecture-specific details in
> > >>>> allocating iova space and the interface to the iommu drivers is
> > >>>> well-defined. The arch-specific stuff is bogged down in the
> non-coherent
> > >>>> buffer management, but that doesn't necessarily equate to lots of
> code.
> > >>>>
> > >>>> So, the best bet would be to figure out how to split up what we
> have under
> > >>>> arch/arm/ so that it can be re-used by arm64 and potentially other
> > >>>> architectures (powerpc has some simple stuff for coherent mappings
> and some
> > >>>> less-simple stuff for non-coherent buffers).
> > >>>
> > >>> I'm sure that other architectures are interested in sharing the code.
> > >>> Best move it into the global mm/ directory, at least the version for
> > >>> coherent mappings.
> > >>
> > >> I'm guessing that this kind of unification usually takes some time
> > >> since we need to factor out the common code from the different
> > >> ${ARCH}/mm/dma-mapping.c. Also some of ${ARCH} has IOMMU support in
> > >> it. So if we want to develop our 64-bit ARM with working DMA mapping
> > >> API during this transition, the step to take would be:
> > >>
> > >> 1, Copy arch/arm/mm/dma-mapping.c
> arch/arm64/mm/dma-mapping.c(+swiotlb)
> > >> 2, Adapt arch/arm64/mm/dma-mapping.c(+swiotlb) to 64bit compatible.
> > >> 3, Factor out the common code from them into mm/dma-mapping.c
> > >
> > > Or add the relevant code to something like lib/iommu-helper.c, convert
> > > arm64 to use that and we can work on converting arm and other
> > > architectures afterwards.
> > >
> > why not in current drivers/iommu directory ?
>
> That's not really specific to the iommu driver implementation, they have
> a clearly defined interface. For similarity with swiotlb and given that
> we already have iommu-helper.c, lib/ looks best to me. Anyway, let's
> first see how the code looks like, it can be moved later.
>
> --
> Catalin
>
> _______________________________________________
> Linaro-mm-sig mailing list
> Linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
> http://lists.linaro.org/mailman/listinfo/linaro-mm-sig
>

--089e01633aa8746aba04f1aaffea
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi All, <br><br></div>Frankly speaking, I didn&#=
39;t follow up this discussion until this point where I wanted to know whet=
her we have iommu ops support in dma-mapping API for 64BIT ARM Arch. <br></=
div>
<div>If anyone can please provide some more info as what is the current sta=
tus on this and is it completely supported now ? <br><br><br><br></div><div=
>Thanks <br>Ritesh <br><br></div><div><br></div><br></div><div class=3D"gma=
il_extra">
<br><br><div class=3D"gmail_quote">On Wed, Jun 19, 2013 at 4:41 PM, Catalin=
 Marinas <span dir=3D"ltr">&lt;<a href=3D"mailto:catalin.marinas-5wv7dgnIgG8@public.gmane.org" t=
arget=3D"_blank">catalin.marinas-5wv7dgnIgG8@public.gmane.org</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On Tue, Jun 18, 2013 at 11:08:15PM =
+0100, Don Dutile wrote:<br>
&gt; On 06/18/2013 08:50 AM, Catalin Marinas wrote:<br>
&gt; &gt; On Tue, Jun 18, 2013 at 12:01:37PM +0100, Hiroshi Doyu wrote:<br>
&gt; &gt;&gt; Arnd Bergmann&lt;<a href=3D"mailto:arnd-r2nGTMty4D4@public.gmane.org">arnd@arndb.=
de</a>&gt; =A0wrote @ Tue, 18 Jun 2013 12:32:44 +0200:<br>
&gt; &gt;&gt;&gt; On Tuesday 18 June 2013 11:19:14 Will Deacon wrote:<br>
&gt; &gt;&gt;&gt;&gt; I&#39;ve spoken briefly with Catalin about this and i=
t seems like there might be<br>
&gt; &gt;&gt;&gt;&gt; *some* scope for sharing common dma-mapping code betw=
een architectures.<br>
&gt; &gt;&gt;&gt;&gt; There doesn&#39;t really need to be any architecture-=
specific details in<br>
&gt; &gt;&gt;&gt;&gt; allocating iova space and the interface to the iommu =
drivers is<br>
&gt; &gt;&gt;&gt;&gt; well-defined. The arch-specific stuff is bogged down =
in the non-coherent<br>
&gt; &gt;&gt;&gt;&gt; buffer management, but that doesn&#39;t necessarily e=
quate to lots of code.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; So, the best bet would be to figure out how to split =
up what we have under<br>
&gt; &gt;&gt;&gt;&gt; arch/arm/ so that it can be re-used by arm64 and pote=
ntially other<br>
&gt; &gt;&gt;&gt;&gt; architectures (powerpc has some simple stuff for cohe=
rent mappings and some<br>
&gt; &gt;&gt;&gt;&gt; less-simple stuff for non-coherent buffers).<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; I&#39;m sure that other architectures are interested in s=
haring the code.<br>
&gt; &gt;&gt;&gt; Best move it into the global mm/ directory, at least the =
version for<br>
&gt; &gt;&gt;&gt; coherent mappings.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I&#39;m guessing that this kind of unification usually takes =
some time<br>
&gt; &gt;&gt; since we need to factor out the common code from the differen=
t<br>
&gt; &gt;&gt; ${ARCH}/mm/dma-mapping.c. Also some of ${ARCH} has IOMMU supp=
ort in<br>
&gt; &gt;&gt; it. So if we want to develop our 64-bit ARM with working DMA =
mapping<br>
&gt; &gt;&gt; API during this transition, the step to take would be:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; 1, Copy arch/arm/mm/dma-mapping.c arch/arm64/mm/dma-mapping.c=
(+swiotlb)<br>
&gt; &gt;&gt; 2, Adapt arch/arm64/mm/dma-mapping.c(+swiotlb) to 64bit compa=
tible.<br>
&gt; &gt;&gt; 3, Factor out the common code from them into mm/dma-mapping.c=
<br>
&gt; &gt;<br>
&gt; &gt; Or add the relevant code to something like lib/iommu-helper.c, co=
nvert<br>
&gt; &gt; arm64 to use that and we can work on converting arm and other<br>
&gt; &gt; architectures afterwards.<br>
&gt; &gt;<br>
&gt; why not in current drivers/iommu directory ?<br>
<br>
</div></div>That&#39;s not really specific to the iommu driver implementati=
on, they have<br>
a clearly defined interface. For similarity with swiotlb and given that<br>
we already have iommu-helper.c, lib/ looks best to me. Anyway, let&#39;s<br=
>
first see how the code looks like, it can be moved later.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Catalin<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
_______________________________________________<br>
Linaro-mm-sig mailing list<br>
<a href=3D"mailto:Linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org">Linaro-mm-sig-cunTk1MwBs/tYdAWNwuQyg@public.gmane.org=
o.org</a><br>
<a href=3D"http://lists.linaro.org/mailman/listinfo/linaro-mm-sig" target=
=3D"_blank">http://lists.linaro.org/mailman/listinfo/linaro-mm-sig</a><br>
</div></div></blockquote></div><br></div>

--089e01633aa8746aba04f1aaffea--

--===============0824720632019528824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0824720632019528824==--
