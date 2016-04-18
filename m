From: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFT v2] iommu/amd: use subsys_initcall() on amdv2 iommu
Date: Sun, 17 Apr 2016 23:55:45 -0700
Message-ID: <CAB=NE6WL7j_azrFxQUG3bybXtu67ew51CyzYvkBct6tCdARKDg@mail.gmail.com>
References: <20160316171719.GE2195@8bytes.org>
	<1459273313-5139-1-git-send-email-mcgrof@kernel.org>
	<CAB=NE6XCmMk4sraQo34XQJfjWu_yRc1rar_eQRSET8Q7VR9EOw@mail.gmail.com>
	<570BA694.8040900@amd.com>
	<CAFCwf10oD9c3MOW3+J8A5MVjVkX0nNRGCEE2pWcQxOy7mjUsBw@mail.gmail.com>
	<570BAC2B.4090508@amd.com> <20160412220715.GL1990@wotan.suse.de>
	<CAFCwf12SJ-dTv6PC0_KfHbtC9951xb_4v8wu5uSjXO-V3TgdkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1907045455101721765=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAFCwf12SJ-dTv6PC0_KfHbtC9951xb_4v8wu5uSjXO-V3TgdkA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============1907045455101721765==
Content-Type: multipart/alternative; boundary=001a1149039093a1670530bcd9dc

--001a1149039093a1670530bcd9dc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Apr 18, 2016 7:48 AM, "Oded Gabbay" <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> On Wed, Apr 13, 2016 at 1:07 AM, Luis R. Rodriguez <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
wrote:
> > On Mon, Apr 11, 2016 at 03:52:43PM +0200, Christian K=C3=B6nig wrote:
> >> Am 11.04.2016 um 15:39 schrieb Oded Gabbay:
> >> >On Mon, Apr 11, 2016 at 4:28 PM, Christian K=C3=B6nig
> >> ><christian.koenig-5C7GfCeVMHo@public.gmane.org> wrote:
> >> >>Am 09.04.2016 um 02:25 schrieb Luis R. Rodriguez:
> >> >>>On Tue, Mar 29, 2016 at 10:41 AM, Luis R. Rodriguez <
mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> >> >>>>We need to ensure amd iommu v2 initializes before
> >> >>>>driver uses such as drivers/gpu/drm/amd/amdkfd/kfd_module.c,
> >> >>>>to do this make its init routine a subsys_initcall() which
> >> >>>>ensures its load init is called first than modules when
> >> >>>>built-in.
> >> >>>>
> >> >>>>This reverts the old work around implemented through commit
> >> >>>>1bacc894c227fad8a7 ("drivers: Move iommu/ before gpu/ in
Makefile"),
> >> >>>>instead of making the dependency implicit by linker order this
> >> >>>>makes the ordering requirement explicit through proper kernel
> >> >>>>APIs.
> >> >>>>
> >> >>>>Cc: Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
> >> >>>>Cc: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >> >>>>Signed-off-by: Luis R. Rodriguez <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >> >>
> >> >>Sorry for not responding earlier. Just coming back to all the stuff
on my TODO list.
> >> >>
> >> >>Patch is Acked-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >> >
> >> >Christian,
> >> >Just wanted to be sure if you tested this patch-set or not.
> >>
> >> I did NOT tested it. If AMD IOMMU requires something which will now
> >> initialize after the IOMMU module we will obviously run into trouble
> >> again.
> >>
> >> I assumed that the creator of the patch did some testing.
> >
> > Nope, hence [RTF] Request For Testing.
> >
> >> >I don't think it should be merged without testing. If you already
> >> >tested it than fine. If not, I think I can do it in the next week or
> >> >so (just came back from PTO).
> >>
> >> Yeah, agree totally.
> >
> > Agreed, please let me know if someone is able to test and confirm
> > this works. It should work.
> >
> >   Luis
>
> Hi,
> So I finally got to test this patch and it's not working.
> The reason is that AMD IOMMUv2 gets initialized *before* AMD IOMMUv1
driver !

Thanks can you try using late_initcall() instead then?

  Luis

--001a1149039093a1670530bcd9dc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Apr 18, 2016 7:48 AM, &quot;Oded Gabbay&quot; &lt;<a href=3D"mailto:oded=
.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On Wed, Apr 13, 2016 at 1:07 AM, Luis R. Rodriguez &lt;<a href=3D"mail=
to:mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org">mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt; On Mon, Apr 11, 2016 at 03:52:43PM +0200, Christian K=C3=B6nig wr=
ote:<br>
&gt; &gt;&gt; Am 11.04.2016 um 15:39 schrieb Oded Gabbay:<br>
&gt; &gt;&gt; &gt;On Mon, Apr 11, 2016 at 4:28 PM, Christian K=C3=B6nig<br>
&gt; &gt;&gt; &gt;&lt;<a href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">christian=
.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
&gt; &gt;&gt; &gt;&gt;Am 09.04.2016 um 02:25 schrieb Luis R. Rodriguez:<br>
&gt; &gt;&gt; &gt;&gt;&gt;On Tue, Mar 29, 2016 at 10:41 AM, Luis R. Rodrigu=
ez &lt;<a href=3D"mailto:mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org">mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org</a>&gt; wrote=
:<br>
&gt; &gt;&gt; &gt;&gt;&gt;&gt;We need to ensure amd iommu v2 initializes be=
fore<br>
&gt; &gt;&gt; &gt;&gt;&gt;&gt;driver uses such as drivers/gpu/drm/amd/amdkf=
d/kfd_module.c,<br>
&gt; &gt;&gt; &gt;&gt;&gt;&gt;to do this make its init routine a subsys_ini=
tcall() which<br>
&gt; &gt;&gt; &gt;&gt;&gt;&gt;ensures its load init is called first than mo=
dules when<br>
&gt; &gt;&gt; &gt;&gt;&gt;&gt;built-in.<br>
&gt; &gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt;&gt;&gt;This reverts the old work around implemented =
through commit<br>
&gt; &gt;&gt; &gt;&gt;&gt;&gt;1bacc894c227fad8a7 (&quot;drivers: Move iommu=
/ before gpu/ in Makefile&quot;),<br>
&gt; &gt;&gt; &gt;&gt;&gt;&gt;instead of making the dependency implicit by =
linker order this<br>
&gt; &gt;&gt; &gt;&gt;&gt;&gt;makes the ordering requirement explicit throu=
gh proper kernel<br>
&gt; &gt;&gt; &gt;&gt;&gt;&gt;APIs.<br>
&gt; &gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt;&gt;&gt;Cc: Oded Gabbay &lt;<a href=3D"mailto:oded.ga=
bbay-5C7GfCeVMHo@public.gmane.org">oded.gabbay-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; &gt;&gt; &gt;&gt;&gt;&gt;Cc: Christian K=C3=B6nig &lt;<a href=3D"mailt=
o:christian.koenig-5C7GfCeVMHo@public.gmane.org">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; &gt;&gt; &gt;&gt;&gt;&gt;Signed-off-by: Luis R. Rodriguez &lt;<a href=
=3D"mailto:mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org">mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org</a>&gt;<br>
&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt;Sorry for not responding earlier. Just coming back to=
 all the stuff on my TODO list.<br>
&gt; &gt;&gt; &gt;&gt;<br>
&gt; &gt;&gt; &gt;&gt;Patch is Acked-by: Christian K=C3=B6nig &lt;<a href=
=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt;Christian,<br>
&gt; &gt;&gt; &gt;Just wanted to be sure if you tested this patch-set or no=
t.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I did NOT tested it. If AMD IOMMU requires something which wi=
ll now<br>
&gt; &gt;&gt; initialize after the IOMMU module we will obviously run into =
trouble<br>
&gt; &gt;&gt; again.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I assumed that the creator of the patch did some testing.<br>
&gt; &gt;<br>
&gt; &gt; Nope, hence [RTF] Request For Testing.<br>
&gt; &gt;<br>
&gt; &gt;&gt; &gt;I don&#39;t think it should be merged without testing. If=
 you already<br>
&gt; &gt;&gt; &gt;tested it than fine. If not, I think I can do it in the n=
ext week or<br>
&gt; &gt;&gt; &gt;so (just came back from PTO).<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Yeah, agree totally.<br>
&gt; &gt;<br>
&gt; &gt; Agreed, please let me know if someone is able to test and confirm=
<br>
&gt; &gt; this works. It should work.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0Luis<br>
&gt;<br>
&gt; Hi,<br>
&gt; So I finally got to test this patch and it&#39;s not working.<br>
&gt; The reason is that AMD IOMMUv2 gets initialized *before* AMD IOMMUv1 d=
river !</p>
<p dir=3D"ltr">Thanks can you try using late_initcall() instead then?</p>
<p dir=3D"ltr">=C2=A0 Luis</p>

--001a1149039093a1670530bcd9dc--

--===============1907045455101721765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1907045455101721765==--
