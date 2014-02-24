From: srikanth TS <srikantht.shivanand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: (unknown)
Date: Tue, 25 Feb 2014 00:12:21 +0900
Message-ID: <CAM0G4zvu1BHcOrSgBuobvb-+fVsNWXjXdzZdV51T70B9_ZC4XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8024141206004734371=="
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sungjinn.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ts.srikanth-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============8024141206004734371==
Content-Type: multipart/alternative; boundary=089e0160c660f3ba8b04f32865b7

--089e0160c660f3ba8b04f32865b7
Content-Type: text/plain; charset=ISO-8859-1

Hi Will Deacon,



Currently SMMU driver expecting all stream ID used by respective master
should be defined in the DT.

We want to know how to handle in the case of virtual functions dynamically
created and destroyed.

Is PCI driver responsible for creating stream ID respective BDand
requesting SMMU to add to the mapping table[stream Id to context mapping
table]?

Or is there any right way of doing it?



WBRs,

Srikanth.

--089e0160c660f3ba8b04f32865b7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"margin:0cm 0cm 0pt;font-family:&#39;Courier Ne=
w&#39;;font-size:10pt"><span style=3D"font-size:10pt">Hi Will Deacon,</span=
><br></p><p style=3D"margin:0cm 0cm 0pt;font-family:&#39;Courier New&#39;;f=
ont-size:10pt">
<span lang=3D"EN-US"><u></u>=A0<u></u></span></p><p style=3D"margin:0cm 0cm=
 0pt;font-family:&#39;Courier New&#39;;font-size:10pt"><span lang=3D"EN-US"=
>Currently SMMU driver expecting all stream ID used by respective master sh=
ould be defined in the DT.<u></u><u></u></span></p>
<p style=3D"margin:0cm 0cm 0pt;font-family:&#39;Courier New&#39;;font-size:=
10pt"><span lang=3D"EN-US">We want to know how to handle in the case of vir=
tual functions dynamically created and destroyed.<u></u><u></u></span></p><=
p style=3D"margin:0cm 0cm 0pt;font-family:&#39;Courier New&#39;;font-size:1=
0pt">
<span lang=3D"EN-US">Is PCI driver responsible for creating stream ID respe=
ctive BDand requesting SMMU to add to the mapping table[stream Id to contex=
t mapping table]?<u></u><u></u></span></p><p style=3D"margin:0cm 0cm 0pt;fo=
nt-family:&#39;Courier New&#39;;font-size:10pt">
<span lang=3D"EN-US">Or is there any right way of doing it?<u></u><u></u></=
span></p><p style=3D"margin:0cm 0cm 0pt;font-family:&#39;Courier New&#39;;f=
ont-size:10pt"><span lang=3D"EN-US"><u></u>=A0<u></u></span></p><p style=3D=
"margin:0cm 0cm 0pt;font-family:&#39;Courier New&#39;;font-size:10pt">
<span lang=3D"EN-US">WBRs,<u></u><u></u></span></p><p style=3D"margin:0cm 0=
cm 0pt;font-family:&#39;Courier New&#39;;font-size:10pt"><span lang=3D"EN-U=
S">Srikanth.</span></p></div>

--089e0160c660f3ba8b04f32865b7--

--===============8024141206004734371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8024141206004734371==--
