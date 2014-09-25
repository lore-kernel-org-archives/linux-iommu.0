From: Rob Roschewsk <gerard-1/SUfjJPYocsP9Te1NuDSQC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Fix broken device issue when using iommu=pt
Date: Thu, 25 Sep 2014 13:56:11 +0000
Message-ID: <CAE1O4xrQYpc4o6MbN8b7kkgwTbjj+Pszu5WUwM_vErUfyQYfNw@mail.gmail.com>
References: <1597491265.153338.1411595791727.JavaMail.open-xchange@oxuslxltgw04.lxa.perfora.net>
	<54237F92.1090601@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4962241312835473399=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54237F92.1090601-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============4962241312835473399==
Content-Type: multipart/alternative; boundary=001a11c1df2cc65aff0503e42977

--001a11c1df2cc65aff0503e42977
Content-Type: text/plain; charset=UTF-8

OK ... at first glance the system seems to be operating "normally" except
for the errors every 4 seconds ... that is it's attached to and using the
iscsi target ...

Is this a problem in iommu OR the emulex driver??

On Thu, Sep 25, 2014 at 2:36 AM, Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:

> On 2014/9/25 5:56, Rob Roschewsk wrote:
> > Hello All .... wonder if there has been any movement on this issue ....
> I'm having a similar issue
> >
> > I'm running an HP dl380 gen 8 with an Emulex OneConnect 10Gb iSCSI
> (14e4:164c) (rev 11)
> > also known as " Hewlett-Packard Company NC373i Integrated Multifunction
> Gigabit Server Adapter"
> >
> > 03:00.2 Mass storage controller: Emulex Corporation OneConnect 10Gb
> iSCSI Initiator (be3) (rev 01)
> >
> > 03:00.3 Mass storage controller: Emulex Corporation OneConnect 10Gb
> iSCSI Initiator (be3) (rev 01)
> >
> > Seems as soon as the iscsi target is contacted the following messages
> appear in the log every few seconds ....
> >
>
> It seems to a different problem, in my issue, the DMA fault messages
> contained a non-exist PCI ID in system.
> But in this issue, 03:00.2 is in system, the fault addr is ffffc000, I
> guess it's DMA virtual address allocated
> by vt-d driver. And it seems to 03:00.2 has no write access authority.
>
> > Sep 24 15:25:30  kernel: [ 78.682675] dmar: DRHD: handling fault status
> reg 2
> > Sep 24 15:25:30  kernel: [ 78.699797] dmar: DMAR:[DMA Write] Request
> device [03:00.2] fault addr ffffc000
> > Sep 24 15:25:30  kernel: [ 78.699797] DMAR:[fault reason 05] PTE Write
> access is not set
> > Sep 24 15:25:30  kernel: [ 78.934546] dmar: DRHD: handling fault status
> reg 102
> > Sep 24 15:25:30  kernel: [ 78.934549] dmar: DMAR:[DMA Write] Request
> device [03:00.2] fault addr ffffc000
> > Sep 24 15:25:30  kernel: [ 78.934549] DMAR:[fault reason 05] PTE Write
> access is not set
> > Sep 24 15:25:30  kernel: [ 78.935359] dmar: DRHD: handling fault status
> reg 202
> >
> > If I pull intel_iommu=on out of the kernel command line the problem goes
> away.
> >
> > System is running Ubuntu 14.04.1 LTS
> >
> > 3.13.0-32-generic #57-Ubuntu SMP Tue Jul 15 03:51:08 UTC 2014 x86_64
> x86_64 x86_64 GNU/Linux
> >
> > Looking for help .... I'm not sure where I should be looking next .....
> I need SR-IOV for other adapters in the box.
> >
> > I have a system up that I can pull any data from that might be required.
> >
> > Thanks,
> >
> > --> Rob
> >
> >
> >
> >
> >
> > _______________________________________________
> > iommu mailing list
> > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >
>
>
> --
> Thanks!
> Yijing
>
>

--001a11c1df2cc65aff0503e42977
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">OK ... at first glance the system seems to be operating &q=
uot;normally&quot; except for the errors every 4 seconds ... that is it&#39=
;s attached to and using the iscsi target ...=C2=A0<div><br></div><div>Is t=
his a problem in iommu OR the emulex driver??=C2=A0</div></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Sep 25, 2014 at 2:3=
6 AM, Yijing Wang <span dir=3D"ltr">&lt;<a href=3D"mailto:wangyijing@huawei=
.com" target=3D"_blank">wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">On 2014/9/25 5:56, Rob Roschewsk wrote:<br>
&gt; Hello All .... wonder if there has been any movement on this issue ...=
. I&#39;m having a similar issue<br>
&gt;<br>
&gt; I&#39;m running an HP dl380 gen 8 with an Emulex OneConnect 10Gb iSCSI=
 (14e4:164c) (rev 11)<br>
&gt; also known as &quot; Hewlett-Packard Company NC373i Integrated Multifu=
nction Gigabit Server Adapter&quot;<br>
&gt;<br>
&gt; 03:00.2 Mass storage controller: Emulex Corporation OneConnect 10Gb iS=
CSI Initiator (be3) (rev 01)<br>
&gt;<br>
&gt; 03:00.3 Mass storage controller: Emulex Corporation OneConnect 10Gb iS=
CSI Initiator (be3) (rev 01)<br>
&gt;<br>
&gt; Seems as soon as the iscsi target is contacted the following messages =
appear in the log every few seconds ....<br>
&gt;<br>
<br>
It seems to a different problem, in my issue, the DMA fault messages contai=
ned a non-exist PCI ID in system.<br>
But in this issue, 03:00.2 is in system, the fault addr is ffffc000, I gues=
s it&#39;s DMA virtual address allocated<br>
by vt-d driver. And it seems to 03:00.2 has no write access authority.<br>
<br>
&gt; Sep 24 15:25:30=C2=A0 kernel: [ 78.682675] dmar: DRHD: handling fault =
status reg 2<br>
&gt; Sep 24 15:25:30=C2=A0 kernel: [ 78.699797] dmar: DMAR:[DMA Write] Requ=
est device [03:00.2] fault addr ffffc000<br>
&gt; Sep 24 15:25:30=C2=A0 kernel: [ 78.699797] DMAR:[fault reason 05] PTE =
Write access is not set<br>
&gt; Sep 24 15:25:30=C2=A0 kernel: [ 78.934546] dmar: DRHD: handling fault =
status reg 102<br>
&gt; Sep 24 15:25:30=C2=A0 kernel: [ 78.934549] dmar: DMAR:[DMA Write] Requ=
est device [03:00.2] fault addr ffffc000<br>
&gt; Sep 24 15:25:30=C2=A0 kernel: [ 78.934549] DMAR:[fault reason 05] PTE =
Write access is not set<br>
&gt; Sep 24 15:25:30=C2=A0 kernel: [ 78.935359] dmar: DRHD: handling fault =
status reg 202<br>
&gt;<br>
&gt; If I pull intel_iommu=3Don out of the kernel command line the problem =
goes away.<br>
&gt;<br>
&gt; System is running Ubuntu 14.04.1 LTS<br>
&gt;<br>
&gt; 3.13.0-32-generic #57-Ubuntu SMP Tue Jul 15 03:51:08 UTC 2014 x86_64 x=
86_64 x86_64 GNU/Linux<br>
&gt;<br>
&gt; Looking for help .... I&#39;m not sure where I should be looking next =
..... I need SR-IOV for other adapters in the box.<br>
&gt;<br>
&gt; I have a system up that I can pull any data from that might be require=
d.<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; --&gt; Rob<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; iommu mailing list<br>
&gt; <a href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org=
foundation.org</a><br>
&gt; <a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/iommu" t=
arget=3D"_blank">https://lists.linuxfoundation.org/mailman/listinfo/iommu</=
a><br>
&gt;<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Thanks!<br>
Yijing<br>
<br>
</font></span></blockquote></div><br></div>

--001a11c1df2cc65aff0503e42977--

--===============4962241312835473399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4962241312835473399==--
