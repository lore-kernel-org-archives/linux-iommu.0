From: Baptiste Reynal <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: SMMU 2-stage support
Date: Fri, 3 Apr 2015 11:55:02 +0200
Message-ID: <CAN9JPjFvg=e948ZLLtrUTnvDp8UWHCX2NGB4iUEES733T9YytQ@mail.gmail.com>
References: <CAN9JPjFf1Lb+L8sWq0SWt8f6P6DX2i308OeF+TdnFdstRoU3hA@mail.gmail.com>
	<20150218185600.GN22017@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3502497535196315292=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150218185600.GN22017-5wv7dgnIgG8@public.gmane.org>
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
Cc: Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============3502497535196315292==
Content-Type: multipart/alternative; boundary=001a11c0792c34a3be0512cef1d0

--001a11c0792c34a3be0512cef1d0
Content-Type: text/plain; charset=UTF-8

Hello,

We are eventually working on the vSMMU implementation. Relying on the talk
Will Deacon gave at the Linux Plumbers IOMMU Microconference on October
2014 (http://linuxplumbersconf.org/2014/ocw/proposals/2019), I tried the
vSMMU initialization.

I have a question about the KVM_DEV_ARM_SMMU_V2_CFG_INIT call. What is
exactly expected as parameters ?
My guess is, as it is the base address of the vSMMU, it should be the
address expected to be the "physical address" of the vSMMU on the guest
side. Am I right ?

Thanks,
Baptiste

On Wed, Feb 18, 2015 at 7:56 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:

> On Wed, Feb 18, 2015 at 05:04:21PM +0000, Baptiste Reynal wrote:
> > We are currently working on the ARM SMMU 2-stage support in order to
> > expose SMMU capabilities to a guest OS.
> > By doing some research, we noticed some work has already be done by Will
> > Deacon on exposing virtual IOMMU interface to KVM guest. After going
> > through slides and code (on
> > git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git<
> http://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git>,
> > branch: iommu/vsmmu), we have some questions :
> >
> > - What is the status of this work ? Is Alex still working on it ?
>
> I got a reasonable way through implementing something, but ran into a
> wall for a few reasons:
>
>   (1) I don't have anything where I can test this (yet)
>
>   (2) Nobody's actually asking for it...
>
> > - Are there any test case about the current vsmmu implementation ?
>
> No.
>
> > - What is exposed to the guest in the current implementation ?
>
> An emulation of a stage-1 only SMMU.
>
> > - How do the guest program the stage-1 translation ?
>
> Just like it would for a physical SMMU.
> It's probably easiest if you look at the (incomplete, WIP) code:
>
>
> https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/commit/?h=iommu/vsmmu&id=539dbcb964e5c730791a6a31a4f58ceff4b945c2
>
> Anyway, until somebody actually wants this feature I've put it on ice as
> it adds a whole bunch of complication to the ARM SMMU driver, as well as
> new user ABI extensions that I don't really want to maintain for fun.
>
> The only murmurs I've heard about IOMMU usage from a guest relate to a
> paravirtualised interface, which abstracts the details of the host IOMMU
> altogether and allows the translation to be collapsed (which can be
> better for TLB utilisation).
>
> Will
>

--001a11c0792c34a3be0512cef1d0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Hello,<br><br></div>We are eventu=
ally working on the vSMMU implementation. Relying on the talk Will Deacon g=
ave at the Linux Plumbers IOMMU Microconference on October 2014 (<a href=3D=
"http://linuxplumbersconf.org/2014/ocw/proposals/2019">http://linuxplumbers=
conf.org/2014/ocw/proposals/2019</a>), I tried the vSMMU initialization.<br=
><br></div>I have a question about the KVM_DEV_ARM_SMMU_V2_CFG_INIT call. W=
hat is exactly expected as parameters ?<br></div>My guess is, as it is the =
base address of the vSMMU, it should be the address expected to be the &quo=
t;physical address&quot; of the vSMMU on the guest side. Am I right ?<br><b=
r></div>Thanks,<br></div>Baptiste<br></div><div class=3D"gmail_extra"><br><=
div class=3D"gmail_quote">On Wed, Feb 18, 2015 at 7:56 PM, Will Deacon <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:will.deacon-5wv7dgnIgG8@public.gmane.org" target=3D"_blank">=
will.deacon-5wv7dgnIgG8@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
><span class=3D"">On Wed, Feb 18, 2015 at 05:04:21PM +0000, Baptiste Reynal=
 wrote:<br>
&gt; We are currently working on the ARM SMMU 2-stage support in order to<b=
r>
&gt; expose SMMU capabilities to a guest OS.<br>
&gt; By doing some research, we noticed some work has already be done by Wi=
ll<br>
&gt; Deacon on exposing virtual IOMMU interface to KVM guest. After going<b=
r>
&gt; through slides and code (on<br>
</span>&gt; git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/git=
/will/linux.git" target=3D"_blank">git.kernel.org/pub/scm/linux/kernel/git/=
will/linux.git</a>&lt;<a href=3D"http://git.kernel.org/pub/scm/linux/kernel=
/git/will/linux.git" target=3D"_blank">http://git.kernel.org/pub/scm/linux/=
kernel/git/will/linux.git</a>&gt;,<br>
<span class=3D"">&gt; branch: iommu/vsmmu), we have some questions :<br>
&gt;<br>
&gt; - What is the status of this work ? Is Alex still working on it ?<br>
<br>
</span>I got a reasonable way through implementing something, but ran into =
a<br>
wall for a few reasons:<br>
<br>
=C2=A0 (1) I don&#39;t have anything where I can test this (yet)<br>
<br>
=C2=A0 (2) Nobody&#39;s actually asking for it...<br>
<span class=3D""><br>
&gt; - Are there any test case about the current vsmmu implementation ?<br>
<br>
</span>No.<br>
<span class=3D""><br>
&gt; - What is exposed to the guest in the current implementation ?<br>
<br>
</span>An emulation of a stage-1 only SMMU.<br>
<span class=3D""><br>
&gt; - How do the guest program the stage-1 translation ?<br>
<br>
</span>Just like it would for a physical SMMU.<br>
It&#39;s probably easiest if you look at the (incomplete, WIP) code:<br>
<br>
=C2=A0 <a href=3D"https://git.kernel.org/cgit/linux/kernel/git/will/linux.g=
it/commit/?h=3Diommu/vsmmu&amp;id=3D539dbcb964e5c730791a6a31a4f58ceff4b945c=
2" target=3D"_blank">https://git.kernel.org/cgit/linux/kernel/git/will/linu=
x.git/commit/?h=3Diommu/vsmmu&amp;id=3D539dbcb964e5c730791a6a31a4f58ceff4b9=
45c2</a><br>
<br>
Anyway, until somebody actually wants this feature I&#39;ve put it on ice a=
s<br>
it adds a whole bunch of complication to the ARM SMMU driver, as well as<br=
>
new user ABI extensions that I don&#39;t really want to maintain for fun.<b=
r>
<br>
The only murmurs I&#39;ve heard about IOMMU usage from a guest relate to a<=
br>
paravirtualised interface, which abstracts the details of the host IOMMU<br=
>
altogether and allows the translation to be collapsed (which can be<br>
better for TLB utilisation).<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Will<br>
</font></span></blockquote></div><br></div>

--001a11c0792c34a3be0512cef1d0--

--===============3502497535196315292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3502497535196315292==--
