From: srikanth TS <srikantht.shivanand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Stream ID managment for VF
Date: Tue, 25 Feb 2014 19:49:12 +0900
Message-ID: <CAM0G4zuSuvhUk0cph4HNE8Ygddc4UYotH_nsCb7Buen1iM-hJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2879336349452961347=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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

--===============2879336349452961347==
Content-Type: multipart/alternative; boundary=001a11c2a20cb8b71004f338d654

--001a11c2a20cb8b71004f338d654
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
many VF are used and i feel its not good idea to keep whole list of
streamID [which is equal to max num vf] in DT. Again in this method we need
to generate the stream ID dynamically whenever VF is added in pci iov
driver side. And then pass that stream ID to SMMU.

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

--001a11c2a20cb8b71004f338d654
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Feb 25, 2014 2:28 AM, &quot;Will Deacon&quot; &lt;<a href=3D"mailto:will=
.deacon-5wv7dgnIgG8@public.gmane.org">will.deacon-5wv7dgnIgG8@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, Feb 24, 2014 at 03:12:21PM +0000, srikanth TS wrote:<br>
&gt; &gt; Hi Will Deacon,<br>
&gt;<br>
&gt; Hello,<br>
&gt;<br>
&gt; &gt; Currently SMMU driver expecting all stream ID used by respective =
master<br>
&gt; &gt; should be defined in the DT.<br>
&gt; &gt;<br>
&gt; &gt; We want to know how to handle in the case of virtual functions dy=
namically<br>
&gt; &gt; created and destroyed.<br>
&gt; &gt;<br>
&gt; &gt; Is PCI driver responsible for creating stream ID respective BDand=
<br>
&gt; &gt; requesting SMMU to add to the mapping table[stream Id to context =
mapping<br>
&gt; &gt; table]?<br>
&gt; &gt;<br>
&gt; &gt; Or is there any right way of doing it?<br>
&gt;<br>
&gt; Correct, the driver currently doesn&#39;t support dynamic mappings (ma=
inly<br>
&gt; because I didn&#39;t want to try and invent something that I couldn&#3=
9;t test).<br>
&gt;<br>
&gt; There are a couple of ways to solve this:<br>
&gt;<br>
&gt; =A0 (1) Add a way for a PCI RC to dynamically allocate StreamIDs on an=
 SMMU<br>
&gt; =A0 =A0 =A0 within a fixed range. That would probably need some code i=
n the bus<br>
&gt; =A0 =A0 =A0 layer, so that a bus notifier can kick and call back to th=
e relevant<br>
&gt; =A0 =A0 =A0 SMMU.</p>
<p dir=3D"ltr">I think first way of solving seems to be better, because we =
don&#39;t know how many=A0VF are used and i feel its not good idea to keep =
whole list of streamID=A0[which is equal to max num vf] in DT. Again in thi=
s method we need to generate the stream ID=A0dynamically whenever VF is add=
ed in pci iov driver side. And then pass that stream ID to SMMU.</p>

<p dir=3D"ltr">Is it ok this way? =A0Or you prefer 2nd way which is simpler=
.<br>
&gt;<br>
&gt; =A0 (2) Describe the RID -&gt; SID mapping in the device-tree. We prob=
ably want<br>
&gt; =A0 =A0 =A0 to avoid an enormous table, so this would only work for si=
mple `SID =3D<br>
&gt; =A0 =A0 =A0 RID + offset&#39; or &#39;SID =3D RID &amp; mask&#39; case=
s.<br>
&gt;<br>
&gt; How do your IDs map to each other?<br>
&gt;<br>
&gt; Will</p>

--001a11c2a20cb8b71004f338d654--

--===============2879336349452961347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2879336349452961347==--
