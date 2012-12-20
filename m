From: Ying Chu <gm.ychu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH] Fix Intel IOMMU support for Marvell 88SE91xx SATA
	controllers.
Date: Thu, 20 Dec 2012 10:55:15 +0800
Message-ID: <CAJWeur8tK0TtnVdhb_6LJwo5hn33J_OFY-55__s_yhTjmR-uJw@mail.gmail.com>
References: <1354533387-4110-1-git-send-email-acooks@gmail.com>
	<1355914703-28576-1-git-send-email-acooks@gmail.com>
	<A1185FFE-6B90-4B44-BF8C-082E487AA73D@gmail.com>
	<CAJtEV7ZmgkJMhFL_2Qzt1YsKnZ40gNi0yHgixVW3yJEfi4QzfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0696657412153000707=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAJtEV7ZmgkJMhFL_2Qzt1YsKnZ40gNi0yHgixVW3yJEfi4QzfA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "xjtuychu-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org" <xjtuychu-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, "jpiszcz-BP4nVm5VUdNhbmWW9KSYcQ@public.gmane.org" <jpiszcz-BP4nVm5VUdNhbmWW9KSYcQ@public.gmane.org>, "open list:PCI SUBSYSTEM" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============0696657412153000707==
Content-Type: multipart/alternative; boundary=f46d040167814c483b04d13fdc30

--f46d040167814c483b04d13fdc30
Content-Type: text/plain; charset=ISO-8859-1

Ack.

2012/12/19 Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> On Wed, Dec 19, 2012 at 9:41 PM, Chu Ying <gm.ychu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On 2012-12-19, at 18:58, Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> >> This is my second attempt to make Marvell 88SE91xx SATA controllers
> work when IOMMU is enabled.[1][2]
> >> +static const struct pci_dev_dma_source_funcs {
> >> +    u16 vendor;
> >> +    u16 device;
> >> +    u8 func_map;    /* bit map. lsb is fn 0. */
> >> +} pci_dev_dma_source_funcs[] = {
> >> +     {0x1b4b, 0x9172, (1<<0)|(1<<1)},
> >> +     { 0 },
> >> +};
> >
> > Can you confirm function 0 should be marked? Per my PCIe trace, I found
> no function 0 involved in DMA access?
> >
>
> Yes. The attached patch disables function 0 for the 0x9172 device. The
> attached dmesg output shows the resulting change at time 1.920163 and
> fault at time 2.265757.
>

--f46d040167814c483b04d13fdc30
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ack.<br><br><div class=3D"gmail_quote">2012/12/19 Andrew Cooks <span dir=3D=
"ltr">&lt;<a href=3D"mailto:acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">acooks@gmai=
l.com</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">On Wed, Dec 19, 2012 at 9:41 PM, Chu Ying &lt;<a href=3D"=
mailto:gm.ychu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">gm.ychu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; On 2012-12-19, at 18:58, Andrew Cooks &lt;<a href=3D"mailto:acooks@gma=
il.com">acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; This is my second attempt to make Marvell 88SE91xx SATA controller=
s work when IOMMU is enabled.[1][2]<br>
</div><div class=3D"im">&gt;&gt; +static const struct pci_dev_dma_source_fu=
ncs {<br>
&gt;&gt; + =A0 =A0u16 vendor;<br>
&gt;&gt; + =A0 =A0u16 device;<br>
&gt;&gt; + =A0 =A0u8 func_map; =A0 =A0/* bit map. lsb is fn 0. */<br>
&gt;&gt; +} pci_dev_dma_source_funcs[] =3D {<br>
&gt;&gt; + =A0 =A0 {0x1b4b, 0x9172, (1&lt;&lt;0)|(1&lt;&lt;1)},<br>
&gt;&gt; + =A0 =A0 { 0 },<br>
&gt;&gt; +};<br>
&gt;<br>
&gt; Can you confirm function 0 should be marked? Per my PCIe trace, I foun=
d no function 0 involved in DMA access?<br>
&gt;<br>
<br>
</div>Yes. The attached patch disables function 0 for the 0x9172 device. Th=
e<br>
attached dmesg output shows the resulting change at time 1.920163 and<br>
fault at time 2.265757.<br>
</blockquote></div><br>

--f46d040167814c483b04d13fdc30--

--===============0696657412153000707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0696657412153000707==--
