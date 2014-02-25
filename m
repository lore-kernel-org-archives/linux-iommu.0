From: srikanth TS <srikantht.shivanand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: (unknown)
Date: Tue, 25 Feb 2014 20:20:11 +0900
Message-ID: <CAM0G4ztXWM5kw6dV4WRrTVJBMmeJDXuRnbeRBE603hM+7c=PCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1273758895620802496=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: 
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sungjinn.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ts.srikanth-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============1273758895620802496==
Content-Type: multipart/alternative; boundary=089e0111bbd67c2e5b04f339457a

--089e0111bbd67c2e5b04f339457a
Content-Type: text/plain; charset=ISO-8859-1

On Feb 25, 2014 2:28 AM, "Will Deacon" <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>
> On Mon, Feb 24, 2014 at 03:12:21PM +0000, srikanth TS wrote:
> > Hi Will Deacon,
>
> Hello,
>
> > Currently SMMU driver expecting all stream ID used by respective master
> > should be defined in the DT.
> >
> > We want to know how to handle in the case of virtual functions
dynamically
> > created and destroyed.
> >
> > Is PCI driver responsible for creating stream ID respective BDand
> > requesting SMMU to add to the mapping table[stream Id to context mapping
> > table]?
> >
> > Or is there any right way of doing it?
>
> Correct, the driver currently doesn't support dynamic mappings (mainly
> because I didn't want to try and invent something that I couldn't test).
>
> There are a couple of ways to solve this:
>
>   (1) Add a way for a PCI RC to dynamically allocate StreamIDs on an SMMU
>       within a fixed range. That would probably need some code in the bus
>       layer, so that a bus notifier can kick and call back to the relevant
>       SMMU.

I think first way of solving seems to be better, because we don't know how
many

VF are used and i feel its not good idea to keep whole list of
streamID [which is

equal to max num vf] in DT. Again in this method we need to generate the
stream ID

dynamically whenever VF is added in pci iov driver side. And then pass that

stream ID to SMMU.

Is it ok this way?  Or you prefer 2nd way which is simpler.
>
>   (2) Describe the RID -> SID mapping in the device-tree. We probably want
>       to avoid an enormous table, so this would only work for simple `SID
=
>       RID + offset' or 'SID = RID & mask' cases.
>
> How do your IDs map to each other?
>
> Will

-srikanth ts

--089e0111bbd67c2e5b04f339457a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p dir=3D"ltr" style=3D"font-family:arial,sans-serif;font-=
size:13px"><br>On Feb 25, 2014 2:28 AM, &quot;Will Deacon&quot; &lt;<a href=
=3D"mailto:will.deacon-5wv7dgnIgG8@public.gmane.org" target=3D"_blank">will.deacon-5wv7dgnIgG8@public.gmane.org</a>&g=
t; wrote:<br>
&gt;<br>&gt; On Mon, Feb 24, 2014 at 03:12:21PM +0000, srikanth TS wrote:<b=
r>&gt; &gt; Hi Will Deacon,<br>&gt;<br>&gt; Hello,<br>&gt;<br>&gt; &gt; Cur=
rently SMMU driver expecting all stream ID used by respective master<br>
&gt; &gt; should be defined in the DT.<br>&gt; &gt;<br>&gt; &gt; We want to=
 know how to handle in the case of virtual functions dynamically<br>&gt; &g=
t; created and destroyed.<br>&gt; &gt;<br>&gt; &gt; Is PCI driver responsib=
le for creating stream ID respective BDand<br>
&gt; &gt; requesting SMMU to add to the mapping table[stream Id to context =
mapping<br>&gt; &gt; table]?<br>&gt; &gt;<br>&gt; &gt; Or is there any righ=
t way of doing it?<br>&gt;<br>&gt; Correct, the driver currently doesn&#39;=
t support dynamic mappings (mainly<br>
&gt; because I didn&#39;t want to try and invent something that I couldn&#3=
9;t test).<br>&gt;<br>&gt; There are a couple of ways to solve this:<br>&gt=
;<br>&gt; =A0 (1) Add a way for a PCI RC to dynamically allocate StreamIDs =
on an SMMU<br>
&gt; =A0 =A0 =A0 within a fixed range. That would probably need some code i=
n the bus<br>&gt; =A0 =A0 =A0 layer, so that a bus notifier can kick and ca=
ll back to the relevant<br>&gt; =A0 =A0 =A0 SMMU.</p><p dir=3D"ltr" style=
=3D"font-family:arial,sans-serif;font-size:13px">
I think first way of solving seems to be better, because we don&#39;t know =
how many</p><p dir=3D"ltr" style=3D"font-family:arial,sans-serif;font-size:=
13px">VF are used and i feel its not good idea to keep whole list of stream=
ID=A0[which is=A0</p>
<p dir=3D"ltr" style=3D"font-family:arial,sans-serif;font-size:13px">equal =
to max num vf] in DT. Again in this method we need to generate the stream I=
D</p><p dir=3D"ltr" style=3D"font-family:arial,sans-serif;font-size:13px">d=
ynamically whenever VF is added in pci iov driver side. And then pass that=
=A0</p>
<p dir=3D"ltr" style=3D"font-family:arial,sans-serif;font-size:13px">stream=
 ID to SMMU.</p><p dir=3D"ltr" style=3D"font-family:arial,sans-serif;font-s=
ize:13px">Is it ok this way? =A0Or you prefer 2nd way which is simpler.<br>=
&gt;<br>
&gt; =A0 (2) Describe the RID -&gt; SID mapping in the device-tree. We prob=
ably want<br>&gt; =A0 =A0 =A0 to avoid an enormous table, so this would onl=
y work for simple `SID =3D<br>&gt; =A0 =A0 =A0 RID + offset&#39; or &#39;SI=
D =3D RID &amp; mask&#39; cases.<br>
&gt;<br>&gt; How do your IDs map to each other?<br>&gt;<br>&gt; Will</p><p =
style=3D"font-family:arial,sans-serif;font-size:13px">-srikanth ts</p></div=
>

--089e0111bbd67c2e5b04f339457a--

--===============1273758895620802496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1273758895620802496==--
