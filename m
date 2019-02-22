From: Jis Ben via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Handle hotplug devices' default identity
	mapping setting
Date: Fri, 22 Feb 2019 10:07:28 -0800
Message-ID: <CADChb=nuCeki5fA0S23P4+BB43r4USoLcsPqzEzGuZrFDuvNEg@mail.gmail.com>
References: <21c17b44-af9b-2f18-f109-ba4bb0635e61@linux.intel.com>
	<20190222082829.75567-1-xmdong@google.com>
Reply-To: Jis Ben <jisben-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1230519437413149753=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190222082829.75567-1-xmdong-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: James Dong <xmdong-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============1230519437413149753==
Content-Type: multipart/alternative; boundary="00000000000070cd7f05827f770c"

--00000000000070cd7f05827f770c
Content-Type: text/plain; charset="UTF-8"

An NVMe device configured in static identity mapping should also cause
this error when removed and rescanned. Essentially, a device that does
a DMA when its driver inits, or one that you can force a DMA from.



On Fri, Feb 22, 2019 at 12:28 AM James Dong <xmdong-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:

> Baolu:
>
> The reproduction depends on devices. HW passthrough PCIe devices with
> default
> identity map could have the issue. Make sure that messages like following
> came
> out in dmesg and their mapping does not change after booting:
>   [   10.167809] DMAR: Hardware identity mapping for device 0000:30:00.0
>   [   10.167823] DMAR: Hardware identity mapping for device 0000:30:00.1
>
> Devices which make following true could also be used for the experiment:
>   > static int iommu_should_identity_map(struct device *dev, int startup)
>   > {
>   >             if ((iommu_identity_mapping & IDENTMAP_AZALIA) &&
> IS_AZALIA(pdev))
>   >                     return 1;
>   >             if ((iommu_identity_mapping & IDENTMAP_GFX) &&
> IS_GFX_DEVICE(pdev))
>   >                     return 1;
>
> Once they are up, remove them first by following command:
>   echo 1 > /sys/bus/pci/devices/0000\:03\:00.1/remove
>
> Then trigger the hotplug device rescanning:
>   echo 1 > /sys/bus/pci/rescan
>
> To provide an example of specific devices on the market, I need to try out.
> Or, if it is fine with you, forcing a PCIe NIC card to be default hardware
> passthrough by changing the intel-iommu.c is another easy way to reproduce
> this issue.
>
> Best Regards,
> James
>

--00000000000070cd7f05827f770c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">An NVMe device configured in static identity mapping shoul=
d also cause<div>this error when removed and rescanned. Essentially, a devi=
ce that does</div><div>a DMA when its driver inits, or one that you can for=
ce a DMA from.</div><div><br></div><div><br></div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 22, 2019 at 1=
2:28 AM James Dong &lt;<a href=3D"mailto:xmdong-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org">xmdong@google.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Baolu:<br>
<br>
The reproduction depends on devices. HW passthrough PCIe devices with defau=
lt<br>
identity map could have the issue. Make sure that messages like following c=
ame<br>
out in dmesg and their mapping does not change after booting:<br>
=C2=A0 [=C2=A0 =C2=A010.167809] DMAR: Hardware identity mapping for device =
0000:30:00.0<br>
=C2=A0 [=C2=A0 =C2=A010.167823] DMAR: Hardware identity mapping for device =
0000:30:00.1<br>
<br>
Devices which make following true could also be used for the experiment:<br=
>
=C2=A0 &gt; static int iommu_should_identity_map(struct device *dev, int st=
artup)<br>
=C2=A0 &gt; {<br>
=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((iommu_ident=
ity_mapping &amp; IDENTMAP_AZALIA) &amp;&amp; IS_AZALIA(pdev))<br>
=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return 1;<br>
=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((iommu_ident=
ity_mapping &amp; IDENTMAP_GFX) &amp;&amp; IS_GFX_DEVICE(pdev))<br>
=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return 1;<br>
<br>
Once they are up, remove them first by following command:<br>
=C2=A0 echo 1 &gt; /sys/bus/pci/devices/0000\:03\:00.1/remove<br>
<br>
Then trigger the hotplug device rescanning:<br>
=C2=A0 echo 1 &gt; /sys/bus/pci/rescan<br>
<br>
To provide an example of specific devices on the market, I need to try out.=
<br>
Or, if it is fine with you, forcing a PCIe NIC card to be default hardware<=
br>
passthrough by changing the intel-iommu.c is another easy way to reproduce<=
br>
this issue.<br>
<br>
Best Regards,<br>
James<br>
</blockquote></div>

--00000000000070cd7f05827f770c--

--===============1230519437413149753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1230519437413149753==--
