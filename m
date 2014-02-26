From: srikanth TS <srikantht.shivanand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: RE: your mail
Date: Wed, 26 Feb 2014 17:23:19 +0900
Message-ID: <CAM0G4zv7nBLRdiXcFjiarXAhsbA+5MkdWHPysjpn=ydky72Piw@mail.gmail.com>
References: <CAM0G4zvu1BHcOrSgBuobvb-+fVsNWXjXdzZdV51T70B9_ZC4XQ@mail.gmail.com>
	<20140224172850.GG2553@mudshark.cambridge.arm.com>
	<42a1041ac2df4a73a94dc4516969e35d@BL2PR03MB468.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3118327616030262043=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <42a1041ac2df4a73a94dc4516969e35d-AZ66ij2kwaacCcN9WK45f+O6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sungjinn.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ts.srikanth-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============3118327616030262043==
Content-Type: multipart/alternative; boundary=089e015365e6d77ed704f34aea17

--089e015365e6d77ed704f34aea17
Content-Type: text/plain; charset=ISO-8859-1

On Feb 25, 2014 8:28 PM, "Varun Sethi" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
>
>
>
> > -----Original Message-----
> > From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> > bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Will Deacon
> > Sent: Monday, February 24, 2014 10:59 PM
> > To: srikanth TS
> > Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; sungjinn.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; linux-
> > kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ts.srikanth-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
> > Subject: Re: your mail
> >
> > On Mon, Feb 24, 2014 at 03:12:21PM +0000, srikanth TS wrote:
> > > Hi Will Deacon,
> >
> > Hello,
> >
> > > Currently SMMU driver expecting all stream ID used by respective
> > > master should be defined in the DT.
> > >
> > > We want to know how to handle in the case of virtual functions
> > > dynamically created and destroyed.
> > >
> > > Is PCI driver responsible for creating stream ID respective BDand
> > > requesting SMMU to add to the mapping table[stream Id to context
> > > mapping table]?
> > >
> > > Or is there any right way of doing it?
> >
> > Correct, the driver currently doesn't support dynamic mappings (mainly
> > because I didn't want to try and invent something that I couldn't test).
> >
> > There are a couple of ways to solve this:
> >
> >   (1) Add a way for a PCI RC to dynamically allocate StreamIDs on an
SMMU
> >       within a fixed range. That would probably need some code in the
bus
> >       layer, so that a bus notifier can kick and call back to the
> > relevant
> >       SMMU.
> This could be done in add device notifier. I am working on similar(not
PCI) hot plug device infrastructure for arm smmu driver. I will post an RFC
patch by next week.
Can you please explain with little more detail. We just want to make sure
your idea fits in for pci iov also.

-Srikanth ts
>
> -Varun
>

--089e015365e6d77ed704f34aea17
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Feb 25, 2014 8:28 PM, &quot;Varun Sethi&quot; &lt;<a href=3D"mailto:Varu=
n.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org">Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; &gt; -----Original Message-----<br>
&gt; &gt; From: <a href=3D"mailto:iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org"=
>iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org</a> [mailto:<a href=3D"mailto:iom=
mu-">iommu-</a><br>
&gt; &gt; <a href=3D"mailto:bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">bounces@lis=
ts.linux-foundation.org</a>] On Behalf Of Will Deacon<br>
&gt; &gt; Sent: Monday, February 24, 2014 10:59 PM<br>
&gt; &gt; To: srikanth TS<br>
&gt; &gt; Cc: <a href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">iommu@lis=
ts.linux-foundation.org</a>; <a href=3D"mailto:sungjinn.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org">=
sungjinn.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>; linux-<br>
&gt; &gt; <a href=3D"mailto:kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<=
/a>; <a href=3D"mailto:ts.srikanth-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org">ts.srikanth-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>=
<br>
&gt; &gt; Subject: Re: your mail<br>
&gt; &gt;<br>
&gt; &gt; On Mon, Feb 24, 2014 at 03:12:21PM +0000, srikanth TS wrote:<br>
&gt; &gt; &gt; Hi Will Deacon,<br>
&gt; &gt;<br>
&gt; &gt; Hello,<br>
&gt; &gt;<br>
&gt; &gt; &gt; Currently SMMU driver expecting all stream ID used by respec=
tive<br>
&gt; &gt; &gt; master should be defined in the DT.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; We want to know how to handle in the case of virtual functio=
ns<br>
&gt; &gt; &gt; dynamically created and destroyed.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Is PCI driver responsible for creating stream ID respective =
BDand<br>
&gt; &gt; &gt; requesting SMMU to add to the mapping table[stream Id to con=
text<br>
&gt; &gt; &gt; mapping table]?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Or is there any right way of doing it?<br>
&gt; &gt;<br>
&gt; &gt; Correct, the driver currently doesn&#39;t support dynamic mapping=
s (mainly<br>
&gt; &gt; because I didn&#39;t want to try and invent something that I coul=
dn&#39;t test).<br>
&gt; &gt;<br>
&gt; &gt; There are a couple of ways to solve this:<br>
&gt; &gt;<br>
&gt; &gt; =A0 (1) Add a way for a PCI RC to dynamically allocate StreamIDs =
on an SMMU<br>
&gt; &gt; =A0 =A0 =A0 within a fixed range. That would probably need some c=
ode in the bus<br>
&gt; &gt; =A0 =A0 =A0 layer, so that a bus notifier can kick and call back =
to the<br>
&gt; &gt; relevant<br>
&gt; &gt; =A0 =A0 =A0 SMMU.<br>
&gt; This could be done in add device notifier. I am working on similar(not=
 PCI) hot plug device infrastructure for arm smmu driver. I will post an RF=
C patch by next week.<br>
Can you please explain with little more detail. We just want to make sure y=
our idea fits in for pci iov also.</p>
<p dir=3D"ltr">-Srikanth ts<br>
&gt;<br>
&gt; -Varun<br>
&gt;<br>
</p>

--089e015365e6d77ed704f34aea17--

--===============3118327616030262043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3118327616030262043==--
