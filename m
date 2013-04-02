From: Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] Quirk for buggy dma source tags with Intel IOMMU.
Date: Tue, 2 Apr 2013 22:50:34 +0800
Message-ID: <CAJtEV7aDaMkBmLevccGoRvm1YPEQPAwN1ZZnKHNN_FO2ex8F-Q@mail.gmail.com>
References: <1362710133-25168-1-git-send-email-acooks@gmail.com>
	<515A8A95.1080806@erley.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2727166353664841947=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <515A8A95.1080806-Jx9fsTfDDR3YtjvyW6yDsg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Pat Erley <pat-lkml-Jx9fsTfDDR3YtjvyW6yDsg@public.gmane.org>
Cc: open-PxS6QbICe4xqbv67lBd7PQ@public.gmane.org, "list-PxS6QbICe4xqbv67lBd7PQ@public.gmane.org:PCI SUBSYSTEM" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU,
	(VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Justin Piszcz <jpiszcz-BP4nVm5VUdNhbmWW9KSYcQ@public.gmane.org>, Gaudenz Steinlin <gaudenz-Pp/UeI/YXckUgOneFgkt3A@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "David Woodhouse (supporter:INTEL IOMMU (VT-d))" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============2727166353664841947==
Content-Type: multipart/alternative; boundary=14dae94edc771e914f04d961dc8c

--14dae94edc771e914f04d961dc8c
Content-Type: text/plain; charset=ISO-8859-1

On 2 Apr 2013 15:37, "Pat Erley" <pat-lkml-Jx9fsTfDDR3YtjvyW6yDsg@public.gmane.org> wrote:
>
> On 03/07/2013 09:35 PM, Andrew Cooks wrote:
>>
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>>
>> +/* Table of multiple (ghost) source functions. This is similar to the
>> + * translated sources above, but with the following differences:
>> + * 1. the device may use multiple functions as DMA sources,
>> + * 2. these functions cannot be assumed to be actual devices, they're
simply
>> + * incorrect DMA tags.
>> + * 3. the specific ghost function for a request can not always be
predicted.
>> + * For example, the actual device could be xx:yy.1 and it could use
>> + * both 0 and 1 for different requests, with no obvious way to tell when
>> + * DMA will be tagged as comming from xx.yy.0 and and when it will be
tagged
>> + * as comming from xx.yy.1.
>> + * The bitmap contains all of the functions used in DMA tags, including
the
>> + * actual device.
>> + * See  https://bugzilla.redhat.com/show_bug.cgi?id=757166,
>> + * https://bugzilla.kernel.org/show_bug.cgi?id=42679
>> + * https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1089768
>> + */
>> +static const struct pci_dev_dma_multi_func_sources {
>> +       u16 vendor;
>> +       u16 device;
>> +       u8 func_map;    /* bit map. lsb is fn 0. */
>> +} pci_dev_dma_multi_func_sources[] = {
>> +       { PCI_VENDOR_ID_MARVELL_2, 0x9123, (1<<0)|(1<<1)},
>> +       { PCI_VENDOR_ID_MARVELL_2, 0x9125, (1<<0)|(1<<1)},
>> +       { PCI_VENDOR_ID_MARVELL_2, 0x9128, (1<<0)|(1<<1)},
>> +       { PCI_VENDOR_ID_MARVELL_2, 0x9130, (1<<0)|(1<<1)},
>> +       { PCI_VENDOR_ID_MARVELL_2, 0x9143, (1<<0)|(1<<1)},
>> +       { PCI_VENDOR_ID_MARVELL_2, 0x9172, (1<<0)|(1<<1)},
>> +       { 0 }
>> +};
>
>
> Adding another buggy device.  I have a Ricoh multifunction device:
>
> 17:00.0 SD Host controller: Ricoh Co Ltd MMC/SD Host Controller (rev 01)
> 17:00.3 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 PCIe IEEE 1394
>         Controller (rev 01)
>
> 17:00.0 0805: 1180:e822 (rev 01)
> 17:00.3 0c00: 1180:e832 (rev 01)
>

The Ricoh device issue has been known for some time and a quirk has been
available since commit 12ea6cad1c7d046 in June 2012.  It's slightly
different than the problem this patch tries to work around [1].

> that adding entries for also fixed booting.  I don't have any SD cards or
firewire devices handy to test that they work, but the system now boots,
which was not the case without your patch and IOMMU/DMAR enabled.

That is really strange. Could you tell us what kernel version you tested
and provide dmesg output?


>  Here's a previous patch used for similar hardware that may also be fixed
by this:
>
>
http://lists.fedoraproject.org/pipermail/scm-commits/2010-October/510785.html
>
> and another thread/bug report this may solve:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=605888

I believe this is referenced in drivers/pci/quirks.c for versions newer
than 3.5.


> Feel free to include me in any future iterations of this patch you'd like
tested.
>
> Tested-By: Pat Erley <pat-lkml-Jx9fsTfDDR3YtjvyW6yDsg@public.gmane.org>
>

Thanks for testing!

[1] In the Ricoh case, multiple functions are used for real devices and the
bug is that these devices all use function 0 during DMA. In this particular
case, I'd expect the FireWire device 17:00.3 to issue DMA from the SD Host
Controller address 17:00.0. The quirk is not too much of a terrible hack -
it's a fairly simple translation.

In the Marvell case, the real device uses DMA source tags that don't
actually belong to any visible devices. The quirk to make this work is more
invasive, not nearly as elegant and has not attracted much enthusiasm from
subsystem maintainers, though I'm still hopeful that a quirk will be merged
in some form or another.

--

a.

--14dae94edc771e914f04d961dc8c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p dir=3D"ltr">On 2 Apr 2013 15:37, &quot;Pat Erley&quot; =
&lt;<a href=3D"mailto:pat-lkml-Jx9fsTfDDR3YtjvyW6yDsg@public.gmane.org" target=3D"_blank">pat-lkml@erley.=
org</a>&gt; wrote:<br>
&gt;<br>
&gt; On 03/07/2013 09:35 PM, Andrew Cooks wrote:<br>
&gt;&gt;<br>
&gt;&gt; --- a/drivers/pci/quirks.c<br>
&gt;&gt; +++ b/drivers/pci/quirks.c<br>
&gt;&gt;<br>
&gt;&gt; +/* Table of multiple (ghost) source functions. This is similar to=
 the<br>
&gt;&gt; + * translated sources above, but with the following differences:<=
br>
&gt;&gt; + * 1. the device may use multiple functions as DMA sources,<br>
&gt;&gt; + * 2. these functions cannot be assumed to be actual devices, the=
y&#39;re simply<br>
&gt;&gt; + * incorrect DMA tags.<br>
&gt;&gt; + * 3. the specific ghost function for a request can not always be=
 predicted.<br>
&gt;&gt; + * For example, the actual device could be xx:yy.1 and it could u=
se<br>
&gt;&gt; + * both 0 and 1 for different requests, with no obvious way to te=
ll when<br>
&gt;&gt; + * DMA will be tagged as comming from xx.yy.0 and and when it wil=
l be tagged<br>
&gt;&gt; + * as comming from xx.yy.1.<br>
&gt;&gt; + * The bitmap contains all of the functions used in DMA tags, inc=
luding the<br>
&gt;&gt; + * actual device.<br>
&gt;&gt; + * See =A0<a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=
=3D757166" target=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi?id=3D=
757166</a>,<br>
&gt;&gt; + * <a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D42679=
" target=3D"_blank">https://bugzilla.kernel.org/show_bug.cgi?id=3D42679</a>=
<br>
&gt;&gt; + * <a href=3D"https://bugs.launchpad.net/ubuntu/+source/linux/+bu=
g/1089768" target=3D"_blank">https://bugs.launchpad.net/ubuntu/+source/linu=
x/+bug/1089768</a><br>
&gt;&gt; + */<br>
&gt;&gt; +static const struct pci_dev_dma_multi_func_sources {<br>
&gt;&gt; + =A0 =A0 =A0 u16 vendor;<br>
&gt;&gt; + =A0 =A0 =A0 u16 device;<br>
&gt;&gt; + =A0 =A0 =A0 u8 func_map; =A0 =A0/* bit map. lsb is fn 0. */<br>
&gt;&gt; +} pci_dev_dma_multi_func_sources[] =3D {<br>
&gt;&gt; + =A0 =A0 =A0 { PCI_VENDOR_ID_MARVELL_2, 0x9123, (1&lt;&lt;0)|(1&l=
t;&lt;1)},<br>
&gt;&gt; + =A0 =A0 =A0 { PCI_VENDOR_ID_MARVELL_2, 0x9125, (1&lt;&lt;0)|(1&l=
t;&lt;1)},<br>
&gt;&gt; + =A0 =A0 =A0 { PCI_VENDOR_ID_MARVELL_2, 0x9128, (1&lt;&lt;0)|(1&l=
t;&lt;1)},<br>
&gt;&gt; + =A0 =A0 =A0 { PCI_VENDOR_ID_MARVELL_2, 0x9130, (1&lt;&lt;0)|(1&l=
t;&lt;1)},<br>
&gt;&gt; + =A0 =A0 =A0 { PCI_VENDOR_ID_MARVELL_2, 0x9143, (1&lt;&lt;0)|(1&l=
t;&lt;1)},<br>
&gt;&gt; + =A0 =A0 =A0 { PCI_VENDOR_ID_MARVELL_2, 0x9172, (1&lt;&lt;0)|(1&l=
t;&lt;1)},<br>
&gt;&gt; + =A0 =A0 =A0 { 0 }<br>
&gt;&gt; +};<br>
&gt;<br>
&gt;<br>
&gt; Adding another buggy device. =A0I have a Ricoh multifunction device:<b=
r>
&gt;<br>
&gt; 17:00.0 SD Host controller: Ricoh Co Ltd MMC/SD Host Controller (rev 0=
1)<br>
&gt; 17:00.3 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 PCIe IEEE 1394<br>
&gt; =A0 =A0 =A0 =A0 Controller (rev 01)<br>
&gt;<br>
&gt; 17:00.0 0805: 1180:e822 (rev 01)<br>
&gt; 17:00.3 0c00: 1180:e832 (rev 01)<br>
&gt;</p><p style>The Ricoh device issue has been known for some time and a =
quirk has been available since commit=A012ea6cad1c7d046 in June 2012. =A0It=
&#39;s slightly different than the problem this patch tries to work around =
[1].=A0</p>
<p style>&gt; that adding entries for also fixed booting. =A0I don&#39;t ha=
ve any SD cards or firewire devices handy to test that they work, but the s=
ystem now boots, which was not the case without your patch and IOMMU/DMAR e=
nabled.<br>
</p><p style>That is really strange. Could you tell us what kernel version =
you tested and provide dmesg output?</p><p dir=3D"ltr"><br></p><p dir=3D"lt=
r">&gt; =A0Here&#39;s a previous patch used for similar hardware that may a=
lso be fixed by this:<br>


&gt;<br>
&gt; <a href=3D"http://lists.fedoraproject.org/pipermail/scm-commits/2010-O=
ctober/510785.html" target=3D"_blank">http://lists.fedoraproject.org/piperm=
ail/scm-commits/2010-October/510785.html</a><br>
&gt;<br>
&gt; and another thread/bug report this may solve:<br>
&gt;<br>
&gt; <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D605888" targe=
t=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi?id=3D605888</a></p><p=
 dir=3D"ltr">I believe this is referenced in drivers/pci/quirks.c for versi=
ons newer than 3.5.</p>
<p dir=3D"ltr"><br>
&gt; Feel free to include me in any future iterations of this patch you&#39=
;d like tested.<br>
&gt;<br>
&gt; Tested-By: Pat Erley &lt;<a href=3D"mailto:pat-lkml-Jx9fsTfDDR3YtjvyW6yDsg@public.gmane.org" target=
=3D"_blank">pat-lkml-Jx9fsTfDDR3YtjvyW6yDsg@public.gmane.org</a>&gt;<br>
&gt;<br>
</p><p style>Thanks for testing!</p><p style>[1] In the Ricoh case, multipl=
e functions are used for real devices and the bug is that these devices all=
 use function 0 during DMA. In this particular case, I&#39;d expect the Fir=
eWire device 17:00.3 to issue DMA from the SD Host Controller address 17:00=
.0. The quirk is not too much of a terrible hack - it&#39;s a fairly simple=
 translation.<br>
</p><p>In the Marvell case, the real device uses DMA source tags that don&#=
39;t actually belong to any visible devices. The quirk to make this work is=
 more invasive, not nearly as elegant and has not attracted much enthusiasm=
 from subsystem maintainers, though I&#39;m still hopeful that a quirk will=
 be merged in some form or another.</p>
<p>--<br></p><p style>a.</p>
</div>

--14dae94edc771e914f04d961dc8c--

--===============2727166353664841947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2727166353664841947==--
