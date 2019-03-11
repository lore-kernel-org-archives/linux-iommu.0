From: Chris Chiu <chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Fix a null pointer dereference for ACPI devices
Date: Mon, 11 Mar 2019 10:31:44 +0800
Message-ID: <CAB4CAwdY2whQZ6fyBx2TQDYHqF+sYBjspcd+TOCherZ49Z=5HQ@mail.gmail.com>
References: <20190308041210.84518-1-chiu@endlessm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2195250498644546573=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190308041210.84518-1-chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============2195250498644546573==
Content-Type: multipart/alternative; boundary="00000000000051b0790583c860ac"

--00000000000051b0790583c860ac
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 8, 2019 at 12:12 PM Chris Chiu <chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org> wrote:

> On ASUS laptop X512DK with the realtek USB card reader, the NULL
> pointer dereference happens while bringing up the rtsx_usb driver.
>
> [    1.782281] BUG: unable to handle kernel NULL pointer dereference at
> 0000000000000090
> [    1.782283] PGD 0 P4D 0
> [    1.782285] Oops: 0000 [#1] SMP NOPTI
> [    1.782287] CPU: 6 PID: 290 Comm: systemd-udevd Not tainted
> 4.20.0-2-generic #3+dev91.add2285bem1
> [    1.782288] Hardware name: ASUSTeK COMPUTER INC. VivoBook_ASUSLaptop
> X512DK_X512DK/X512DK, BIOS X512DK.200 01/04/2019
> [    1.782292] RIP: 0010:acpi_device_hid+0x6/0x30
> [    1.782293] Code: ff ff 5b 31 c0 41 5c 5d c3 49 8b 84 24 20 02 00 00 48
> 85 c0 74 e4 48 8b 40 38 48 85 c0 75 d3 eb d9 90 90 90 0f 1f 44 00 00 55
> <48> 8b 97 90 00 00 00 48 8d 8f 90 00 00 00 48 c7 c0 f7 4a ba b9 48
> [    1.782294] RSP: 0018:ffffb1c40209f7a8 EFLAGS: 00010246
> [    1.782295] RAX: 0000000000000000 RBX: ffff9ed23446b200 RCX:
> 0000000000000000
> [    1.782296] RDX: ffff9ed22ab23010 RSI: 0000000000000001 RDI:
> 0000000000000000
> [    1.782297] RBP: ffffb1c40209f7e0 R08: 0000000000000000 R09:
> 0000000000000228
> [    1.782297] R10: 0000000000000000 R11: ffff9ed2288c5ed8 R12:
> fffffffffffffff0
> [    1.782298] R13: ffff9ed22ab23010 R14: 0000000000000000 R15:
> 0000000000000000
> [    1.782299] FS:  00007f9aa61988c0(0000) GS:ffff9ed234b80000(0000)
> knlGS:0000000000000000
> [    1.782300] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.782300] CR2: 0000000000000090 CR3: 00000002aaafc000 CR4:
> 00000000003406e0
> [    1.782301] Call Trace:
> [    1.782307]  ? check_device.part.19+0x5e/0x140
> [    1.782308]  amd_iommu_add_device+0x2d/0x4a0
> [    1.782310]  ? acpi_match_device+0x30/0x70
> [    1.782312]  iommu_bus_notifier+0xc5/0xe0
> [    1.782315]  notifier_call_chain+0x4c/0x70
> [    1.782316]  blocking_notifier_call_chain+0x43/0x60
> [    1.782319]  device_add+0x392/0x6a0
> [    1.782321]  platform_device_add+0x111/0x260
> [    1.782323]  mfd_add_device+0x445/0x570
> [    1.782326]  ? urb_destroy+0x1b/0x40
> [    1.782329]  ? _cond_resched+0x19/0x30
> [    1.782330]  mfd_add_devices+0xab/0x120
> [    1.782333]  rtsx_usb_probe+0x256/0x300 [rtsx_usb]
> [    1.782336]  usb_probe_interface+0xf1/0x300
> [    1.782338]  really_probe+0xfe/0x3b0
> [    1.782339]  driver_probe_device+0xba/0x100
> [    1.782341]  __driver_attach+0xe4/0x110
> [    1.782343]  ? driver_probe_device+0x100/0x100
> [    1.782345]  bus_for_each_dev+0x79/0xc0
> [    1.782347]  ? kmem_cache_alloc_trace+0x15e/0x1e0
> [    1.782348]  driver_attach+0x1e/0x20
> [    1.782350]  bus_add_driver+0x159/0x230
> [    1.782351]  driver_register+0x70/0xc0
> [    1.782353]  usb_register_driver+0x7f/0x140
> [    1.782356]  rtsx_usb_driver_init+0x23/0x1000 [rtsx_usb]
> [    1.782359]  do_one_initcall+0x4a/0x1c4
> [    1.782377] localhost kernel: RIP: 0033:0x7f9aa6806299
> [    1.782379] localhost kernel: Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00
> 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
> 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 6b 0c 00 f7 d8 64
> 89 01 48
> [    1.782379] localhost kernel: RSP: 002b:00007fff6471bd48 EFLAGS:
> 00000246 ORIG_RAX: 0000000000000139
> [    1.782380] localhost kernel: RAX: ffffffffffffffda RBX:
> 000056264b3ba4a0 RCX: 00007f9aa6806299
> [    1.782381] localhost kernel: RDX: 0000000000000000 RSI:
> 00007f9aa670acad RDI: 000000000000000e
> [    1.782381] localhost kernel: RBP: 00007f9aa670acad R08:
> 0000000000000000 R09: 000056264b3ba4a0
> [    1.782382] localhost kernel: R10: 000000000000000e R11:
> 0000000000000246 R12: 0000000000000000
> [    1.782383] localhost kernel: R13: 000056264b3acc10 R14:
> 0000000000020000 R15: 000056264b3ba4a0
> [    1.782384] localhost kernel: Modules linked in: rtsx_usb(+) uas
> usb_storage hid_multitouch hid_generic amdgpu(+) chash amd_iommu_v2
> gpu_sched i2c_algo_bit serio_raw drm_kms_helper syscopyarea ahci
> sysfillrect sysimgblt fb_sys_fops libahci ttm drm wmi video i2c_hid hid
> [    1.782391] localhost kernel: CR2: 0000000000000090
> [    1.782392] localhost kernel: ---[ end trace ba1c82e36e279e13 ]---
>
> The reason is the card reader attached to the USB and doesn't have
> corresponding ACPI device. So the ACPI_COMPANION(dev) passed to
> acpi_device_hid() is NULL which results in null derefernce at the
> consequent device->pnp.ids.
>
> Fix this by validating the ACPI companion of the device first.
>
> Signed-off-by: Chris Chiu <chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 1167ff0416cf..7737d184a185 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -168,6 +168,9 @@ static inline int get_acpihid_device_id(struct device
> *dev,
>  {
>         struct acpihid_map_entry *p;
>
> +       if (!has_acpi_companion(dev))
> +               return -ENODEV;
> +
>         list_for_each_entry(p, &acpihid_map, list) {
>                 if (!match_hid_uid(dev, p)) {
>                         if (entry)
> --
> 2.20.1
>
>
Gentle ping. Any comment or suggestions? Thanks.

--00000000000051b0790583c860ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 8, 2019 at 12:12 PM Chris=
 Chiu &lt;<a href=3D"mailto:chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org">chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On ASUS lap=
top X512DK with the realtek USB card reader, the NULL<br>pointer dereferenc=
e happens while bringing up the rtsx_usb driver.<br>
<br>[=C2=A0 =C2=A0 1.782281] BUG: unable to handle kernel NULL pointer dere=
ference at 0000000000000090<br>[=C2=A0 =C2=A0 1.782283] PGD 0 P4D 0<br>[=C2=
=A0 =C2=A0 1.782285] Oops: 0000 [#1] SMP NOPTI<br>[=C2=A0 =C2=A0 1.782287] =
CPU: 6 PID: 290 Comm: systemd-udevd Not tainted 4.20.0-2-generic #3+dev91.a=
dd2285bem1<br>[=C2=A0 =C2=A0 1.782288] Hardware name: ASUSTeK COMPUTER INC.=
 VivoBook_ASUSLaptop X512DK_X512DK/X512DK, BIOS X512DK.200 01/04/2019<br>[=
=C2=A0 =C2=A0 1.782292] RIP: 0010:acpi_device_hid+0x6/0x30<br>[=C2=A0 =C2=
=A0 1.782293] Code: ff ff 5b 31 c0 41 5c 5d c3 49 8b 84 24 20 02 00 00 48 8=
5 c0 74 e4 48 8b 40 38 48 85 c0 75 d3 eb d9 90 90 90 0f 1f 44 00 00 55 &lt;=
48&gt; 8b 97 90 00 00 00 48 8d 8f 90 00 00 00 48 c7 c0 f7 4a ba b9 48<br>[=
=C2=A0 =C2=A0 1.782294] RSP: 0018:ffffb1c40209f7a8 EFLAGS: 00010246<br>[=C2=
=A0 =C2=A0 1.782295] RAX: 0000000000000000 RBX: ffff9ed23446b200 RCX: 00000=
00000000000<br>[=C2=A0 =C2=A0 1.782296] RDX: ffff9ed22ab23010 RSI: 00000000=
00000001 RDI: 0000000000000000<br>[=C2=A0 =C2=A0 1.782297] RBP: ffffb1c4020=
9f7e0 R08: 0000000000000000 R09: 0000000000000228<br>[=C2=A0 =C2=A0 1.78229=
7] R10: 0000000000000000 R11: ffff9ed2288c5ed8 R12: fffffffffffffff0<br>[=
=C2=A0 =C2=A0 1.782298] R13: ffff9ed22ab23010 R14: 0000000000000000 R15: 00=
00000000000000<br>[=C2=A0 =C2=A0 1.782299] FS:=C2=A0 00007f9aa61988c0(0000)=
 GS:ffff9ed234b80000(0000) knlGS:0000000000000000<br>[=C2=A0 =C2=A0 1.78230=
0] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[=C2=A0 =C2=A0=
 1.782300] CR2: 0000000000000090 CR3: 00000002aaafc000 CR4: 00000000003406e=
0<br>[=C2=A0 =C2=A0 1.782301] Call Trace:<br>[=C2=A0 =C2=A0 1.782307]=C2=A0=
 ? check_device.part.19+0x5e/0x140<br>[=C2=A0 =C2=A0 1.782308]=C2=A0 amd_io=
mmu_add_device+0x2d/0x4a0<br>[=C2=A0 =C2=A0 1.782310]=C2=A0 ? acpi_match_de=
vice+0x30/0x70<br>[=C2=A0 =C2=A0 1.782312]=C2=A0 iommu_bus_notifier+0xc5/0x=
e0<br>[=C2=A0 =C2=A0 1.782315]=C2=A0 notifier_call_chain+0x4c/0x70<br>[=C2=
=A0 =C2=A0 1.782316]=C2=A0 blocking_notifier_call_chain+0x43/0x60<br>[=C2=
=A0 =C2=A0 1.782319]=C2=A0 device_add+0x392/0x6a0<br>[=C2=A0 =C2=A0 1.78232=
1]=C2=A0 platform_device_add+0x111/0x260<br>[=C2=A0 =C2=A0 1.782323]=C2=A0 =
mfd_add_device+0x445/0x570<br>[=C2=A0 =C2=A0 1.782326]=C2=A0 ? urb_destroy+=
0x1b/0x40<br>[=C2=A0 =C2=A0 1.782329]=C2=A0 ? _cond_resched+0x19/0x30<br>[=
=C2=A0 =C2=A0 1.782330]=C2=A0 mfd_add_devices+0xab/0x120<br>[=C2=A0 =C2=A0 =
1.782333]=C2=A0 rtsx_usb_probe+0x256/0x300 [rtsx_usb]<br>[=C2=A0 =C2=A0 1.7=
82336]=C2=A0 usb_probe_interface+0xf1/0x300<br>[=C2=A0 =C2=A0 1.782338]=C2=
=A0 really_probe+0xfe/0x3b0<br>[=C2=A0 =C2=A0 1.782339]=C2=A0 driver_probe_=
device+0xba/0x100<br>[=C2=A0 =C2=A0 1.782341]=C2=A0 __driver_attach+0xe4/0x=
110<br>[=C2=A0 =C2=A0 1.782343]=C2=A0 ? driver_probe_device+0x100/0x100<br>=
[=C2=A0 =C2=A0 1.782345]=C2=A0 bus_for_each_dev+0x79/0xc0<br>[=C2=A0 =C2=A0=
 1.782347]=C2=A0 ? kmem_cache_alloc_trace+0x15e/0x1e0<br>[=C2=A0 =C2=A0 1.7=
82348]=C2=A0 driver_attach+0x1e/0x20<br>[=C2=A0 =C2=A0 1.782350]=C2=A0 bus_=
add_driver+0x159/0x230<br>[=C2=A0 =C2=A0 1.782351]=C2=A0 driver_register+0x=
70/0xc0<br>[=C2=A0 =C2=A0 1.782353]=C2=A0 usb_register_driver+0x7f/0x140<br=
>[=C2=A0 =C2=A0 1.782356]=C2=A0 rtsx_usb_driver_init+0x23/0x1000 [rtsx_usb]=
<br>[=C2=A0 =C2=A0 1.782359]=C2=A0 do_one_initcall+0x4a/0x1c4<br>[=C2=A0 =
=C2=A0 1.782377] localhost kernel: RIP: 0033:0x7f9aa6806299<br>[=C2=A0 =C2=
=A0 1.782379] localhost kernel: Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0=
f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4=
c 24 08 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 6b 0c 00 f7 d8=
 64 89 01 48<br>[=C2=A0 =C2=A0 1.782379] localhost kernel: RSP: 002b:00007f=
ff6471bd48 EFLAGS: 00000246 ORIG_RAX: 0000000000000139<br>[=C2=A0 =C2=A0 1.=
782380] localhost kernel: RAX: ffffffffffffffda RBX: 000056264b3ba4a0 RCX: =
00007f9aa6806299<br>[=C2=A0 =C2=A0 1.782381] localhost kernel: RDX: 0000000=
000000000 RSI: 00007f9aa670acad RDI: 000000000000000e<br>[=C2=A0 =C2=A0 1.7=
82381] localhost kernel: RBP: 00007f9aa670acad R08: 0000000000000000 R09: 0=
00056264b3ba4a0<br>[=C2=A0 =C2=A0 1.782382] localhost kernel: R10: 00000000=
0000000e R11: 0000000000000246 R12: 0000000000000000<br>[=C2=A0 =C2=A0 1.78=
2383] localhost kernel: R13: 000056264b3acc10 R14: 0000000000020000 R15: 00=
0056264b3ba4a0<br>[=C2=A0 =C2=A0 1.782384] localhost kernel: Modules linked=
 in: rtsx_usb(+) uas usb_storage hid_multitouch hid_generic amdgpu(+) chash=
 amd_iommu_v2 gpu_sched i2c_algo_bit serio_raw drm_kms_helper syscopyarea a=
hci sysfillrect sysimgblt fb_sys_fops libahci ttm drm wmi video i2c_hid hid=
<br>[=C2=A0 =C2=A0 1.782391] localhost kernel: CR2: 0000000000000090<br>[=
=C2=A0 =C2=A0 1.782392] localhost kernel: ---[ end trace ba1c82e36e279e13 ]=
---<br>
<br>The reason is the card reader attached to the USB and doesn&#39;t have<=
br>corresponding ACPI device. So the ACPI_COMPANION(dev) passed to<br>acpi_=
device_hid() is NULL which results in null derefernce at the<br>consequent =
device-&gt;pnp.ids.<br>
<br>Fix this by validating the ACPI companion of the device first.<br>
<br>Signed-off-by: Chris Chiu &lt;<a href=3D"mailto:chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org" targ=
et=3D"_blank">chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org</a>&gt;<br>---<br>=C2=A0drivers/iommu/amd_i=
ommu.c | 3 +++<br>=C2=A01 file changed, 3 insertions(+)<br>
<br>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c<br>i=
ndex 1167ff0416cf..7737d184a185 100644<br>--- a/drivers/iommu/amd_iommu.c<b=
r>+++ b/drivers/iommu/amd_iommu.c<br>@@ -168,6 +168,9 @@ static inline int =
get_acpihid_device_id(struct device *dev,<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct acpihid_map_entry *p;<br>
<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!has_acpi_companion(dev))<br>+=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>+<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 list_for_each_entry(p, &amp;acpihid_map, list) {<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!match_hid_ui=
d(dev, p)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (entry)<br>-- <br>2.20.1<br>
<br></blockquote><div><br></div><div>Gentle ping. Any comment or suggestion=
s? Thanks.=C2=A0</div></div></div>

--00000000000051b0790583c860ac--

--===============2195250498644546573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2195250498644546573==--
