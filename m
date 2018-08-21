From: Eric Pilmore <epilmore-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>
Subject: Re: IOAT DMA w/IOMMU
Date: Tue, 21 Aug 2018 16:28:41 -0700
Message-ID: <CAOQPn8uyozbmEV0Ww3LW4XDcaY1ZwV0yazsPxPQC0AfLNUhKYw@mail.gmail.com>
References: <CAOQPn8soxubJxb=vp7kz+AM6LbPH5y+_Nx0Vzv7rjV_nMMqEmA@mail.gmail.com>
	<20180809184331.GB113140@bhelgaas-glaptop.roam.corp.google.com>
	<CAOQPn8uPYKai49WYPqZp2wNd5of=0hUvPOHEtqP56RZu-hcjuw@mail.gmail.com>
	<b54899a8-a144-e8e0-9880-1800c4657b95@deltatee.com>
	<CAOQPn8tSNN+3igN-kMcQH46w_a9p6T+S7=c8CLREMLxr1kaTXQ@mail.gmail.com>
	<7068db44-af31-4462-f966-2dd2340ba0f0@deltatee.com>
	<695826a6-e10c-5a30-a51f-7cc61ba6e640@gigaio.com>
	<0d3f48c3-8c4f-4dfb-e883-23c168f12b9b@deltatee.com>
	<14db6acb-da4f-9604-7359-1671210fcb8b@gigaio.com>
	<ad2cd3f2-eb41-d4c2-7614-379c2e458352@deltatee.com>
	<CAOQPn8uuTEcmdQdZB9-A7FT+YWtxSuruGFwmwCPApffTJNs9Vg@mail.gmail.com>
	<41419ada-7f16-0028-1e43-3b4a6c6960b6@deltatee.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6086180644685798090=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <41419ada-7f16-0028-1e43-3b4a6c6960b6-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Kit Chow <kchow-Op3I1peydIbQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============6086180644685798090==
Content-Type: multipart/alternative; boundary="000000000000f27b200573fa6205"

--000000000000f27b200573fa6205
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 21, 2018 at 4:20 PM, Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>
wrote:

>
>
> On 21/08/18 05:18 PM, Eric Pilmore wrote:
> > We have been running locally with Kit's change for dma_map_resource and
> its
> > incorporation in ntb_async_tx_submit for the destination address and
> > it runs fine
> > under "load" (iperf) on a Xeon (Xeon(R) CPU E5-2680 v4 @ 2.40GHz) based
> system,
> > regardless of whether the DMA engine being used is IOAT or a PLX
> > device sitting in
> > the PCIe tree. However, when we go back to a i7 (i7-7700K CPU @ 4.20GHz)
> based
> > system it seems to run into issues, specifically when put under a
> > load. In this case,
> > just having a load using a single ping command with an interval=0, i.e.
> no delay
> > between ping packets, after a few thousand packets the system just
> hangs. No
> > panic or watchdogs.  Note that in this scenario I can only use a PLX DMA
> engine.
>
> This is just my best guess: but it sounds to me like a bug in the PLX
> DMA driver or hardware.
>
>
The PLX DMA driver?  But the PLX driver isn't really even involved in the
mapping
stage.  Are you thinking maybe the stage at which the DMA descriptor is
freed and
the PLX DMA driver does a dma_descriptor_unmap?

Again, PLX did not exhibit any issues on the Xeon system.

Eric

--000000000000f27b200573fa6205
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Aug 21, 2018 at 4:20 PM, Logan Gunthorpe <span dir=3D"ltr">&lt;=
<a href=3D"mailto:logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org" target=3D"_blank">logang-OTvnGxWRz7jQFizaE/u3fw@public.gmane.org=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">=
<br>
<br>
On 21/08/18 05:18 PM, Eric Pilmore wrote:<br>
&gt; We have been running locally with Kit&#39;s change for dma_map_resourc=
e and its<br>
&gt; incorporation in ntb_async_tx_submit for the destination address and<b=
r>
&gt; it runs fine<br>
&gt; under &quot;load&quot; (iperf) on a Xeon (Xeon(R) CPU E5-2680 v4 @ 2.4=
0GHz) based system,<br>
&gt; regardless of whether the DMA engine being used is IOAT or a PLX<br>
&gt; device sitting in<br>
&gt; the PCIe tree. However, when we go back to a i7 (i7-7700K CPU @ 4.20GH=
z) based<br>
&gt; system it seems to run into issues, specifically when put under a<br>
&gt; load. In this case,<br>
&gt; just having a load using a single ping command with an interval=3D0, i=
.e. no delay<br>
&gt; between ping packets, after a few thousand packets the system just han=
gs. No<br>
&gt; panic or watchdogs.=C2=A0 Note that in this scenario I can only use a =
PLX DMA engine.<br>
<br>
</span>This is just my best guess: but it sounds to me like a bug in the PL=
X<br>
DMA driver or hardware.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquo=
te><div><br></div><div>The PLX DMA driver?=C2=A0 But the PLX driver isn&#39=
;t really even involved in the mapping<br></div><div>stage.=C2=A0 Are you t=
hinking maybe the stage at which the DMA descriptor is freed and</div><div>=
the PLX DMA driver does a dma_descriptor_unmap?</div><div><br></div><div>Ag=
ain, PLX did not exhibit any issues on the Xeon system.</div><div><br></div=
><div>Eric</div><div><br></div></div><br>
</div></div>

--000000000000f27b200573fa6205--

--===============6086180644685798090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6086180644685798090==--
