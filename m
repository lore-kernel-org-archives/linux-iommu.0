From: "G. Richard Bellamy" <rbellamy-1/AleqyZJC8ybS5Ee8rs3A@public.gmane.org>
Subject: Re: AMD-Vi: Event logged [INVALID_DEVICE_REQUEST device=00:14.0
	address=0x000000fdf9103300 flags=0x0600]
Date: Sun, 11 Oct 2015 12:37:51 -0700
Message-ID: <CADw2B2OdtWxHSNpMP6SO3n_Zb16WgF9ZLEQhgHMbNtq5Nry4Mw@mail.gmail.com>
References: <CADw2B2Mzo2DbMMiyTVjBGVc4-f6Koa6sWQjoLmfX7NZ3B4+saA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5309122546003507817=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CADw2B2Mzo2DbMMiyTVjBGVc4-f6Koa6sWQjoLmfX7NZ3B4+saA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============5309122546003507817==
Content-Type: multipart/alternative; boundary=001a11c333f2329a250521d95982

--001a11c333f2329a250521d95982
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Does anyone have a suggestion on next steps, or should I await the next
kernel in hopes this regression is corrected?

I call it regression, as I found a patch-set from April of 2014[1] which
appears to correct this exact problem. I'm not sophisticated enough to know
how I would determine that one way or another, so I'm really just guessing
here.

[1] https://lkml.org/lkml/2014/4/22/562

On Sat, Oct 3, 2015 at 5:19 PM, G. Richard Bellamy <rbellamy-1/AleqyZJC8ybS5Ee8rs3A@public.gmane.org>
wrote:

> What happens: Kernel logs message to journal, kvm VMs no longer work. Ker=
nel messages spew at a rate of ~660/sec.
> What should happen: Kernel boots and kvm VMs start.
>
> Affected kernels: 4.2.1 & 4.2.1
>
> Unaffected kernel: 4.1.9
>
> ------------------------------------------------
> GRUB_CMDLINE_LINUX_DEFAULT=3D"quiet acpi_osi=3DLinux iommu=3Dpt iommu=3D1=
 transparent_hugepage=3Dnever"
> ------------------------------------------------
> I would attach my journal, except it is literally full of MB of lines jus=
t repeating what is in the summary:
>
> 2015-10-01 08:38:40
> root@eanna i ~ # journalctl --disk-usage
> Archived and active journals take up 3.9G on disk.
>
> ver_linux:
> ------------------------------------------------
> Linux eanna 4.2.1-1-ARCH #1 SMP PREEMPT Tue Sep 22 06:57:07 CEST 2015 x86=
_64 GNU/Linux
>
> Gnu C                  5.2.0
> Gnu make               4.1
> binutils               2.25.1
> util-linux             2.27
> mount                  debug
> module-init-tools      21
> e2fsprogs              1.42.12
> jfsutils               1.1.15
> reiserfsprogs          3.6.24
> xfsprogs               4.2.0
> pcmciautils            018
> PPP                    2.4.7
> Linux C Library        Dynamic linker (ldd)   2.22
> Linux C++ Library      6.0.21
> Net-tools              2.10-alpha
> Kbd                    2.0.3
> Sh-utils               8.24
> wireless-tools         30
> Modules Loaded         nls_utf8 udf crc_itu_t ses enclosure uas usb_stora=
ge vhost_net vhost macvtap macvlan xt_CHECKSUM iptable_mangle ipt_MASQUERAD=
E nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 n=
f_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp=
 tun bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables ipta=
ble_filter fuse arc4 sch_fq_codel rt2800usb rt2x00usb rt2800lib rt2x00lib m=
ac80211 fan thermal nfs fscache uvcvideo videobuf2_vmalloc snd_usb_audio vi=
deobuf2_memops videobuf2_core v4l2_common cfg80211 snd_usbmidi_lib videodev=
 input_leds led_class evdev joydev media crc_ccitt mousedev amdkfd mac_hid =
rfkill kvm_amd amd_iommu_v2 snd_hda_codec_hdmi kvm radeon crct10dif_pclmul =
crc32_pclmul snd_virtuoso snd_hda_intel ghash_clmulni_intel snd_oxygen_lib =
cp210x snd_mpu401_uart aesni_intel usbserial snd_hda_codec ttm snd_rawmidi =
aes_x86_64 lrw drm_kms_helper gf128mul snd_hda_core igb glue_helper ablk_he=
lper cryptd snd_hwdep snd_seq_device snd_pcm snd_timer drm amd64_edac_mod s=
nd ptp soundcore pps_core dca i2c_algo_bit edac_core serio_raw pcspkr psmou=
se k10temp edac_mce_amd sp5100_tco fam15h_power i2c_piix4 shpchp tpm_tis tp=
m button acpi_cpufreq processor nfsd auth_rpcgss oid_registry nfs_acl lockd=
 grace sunrpc ipmi_si ipmi_devintf ipmi_msghandler ip_tables x_tables btrfs=
 xor raid6_pq sr_mod cdrom hid_generic usbhid hid sd_mod atkbd libps2 crc32=
c_intel xhci_pci xhci_hcd ahci ohci_pci libahci ohci_hcd ehci_pci mpt2sas e=
hci_hcd raid_class libata scsi_transport_sas usbcore usb_common scsi_mod i8=
042 serio
>
>

--001a11c333f2329a250521d95982
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif">Does anyone have a suggestion on next steps, or should I await =
the next kernel in hopes this regression is corrected?</div><div class=3D"g=
mail_default" style=3D"font-family:verdana,sans-serif"><br></div><div class=
=3D"gmail_default" style=3D"font-family:verdana,sans-serif">I call it regre=
ssion, as I found a patch-set from April of 2014[1] which appears to correc=
t this exact problem. I&#39;m not sophisticated enough to know how I would =
determine that one way or another, so I&#39;m really just guessing here.</d=
iv><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif"><b=
r></div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-seri=
f">[1]=C2=A0<a href=3D"https://lkml.org/lkml/2014/4/22/562">https://lkml.or=
g/lkml/2014/4/22/562</a></div></div><div class=3D"gmail_extra"><br><div cla=
ss=3D"gmail_quote">On Sat, Oct 3, 2015 at 5:19 PM, G. Richard Bellamy <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:rbellamy-1/AleqyZJC8ybS5Ee8rs3A@public.gmane.org" target=3D"_blank=
">rbellamy-1/AleqyZJC8ybS5Ee8rs3A@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:ve=
rdana,sans-serif"><pre style=3D"font-size:medium;white-space:pre-wrap;width=
:50em;color:rgb(0,0,0)">What happens: Kernel logs message to journal, kvm V=
Ms no longer work. Kernel messages spew at a rate of ~660/sec.
What should happen: Kernel boots and kvm VMs start.<br></pre><pre style=3D"=
font-size:medium;white-space:pre-wrap;width:50em;color:rgb(0,0,0)">Affected=
 kernels: 4.2.1 &amp; 4.2.1</pre><pre style=3D"font-size:medium;white-space=
:pre-wrap;width:50em;color:rgb(0,0,0)">Unaffected kernel: 4.1.9</pre><pre s=
tyle=3D"font-size:medium;white-space:pre-wrap;width:50em;color:rgb(0,0,0)">=
------------------------------------------------
GRUB_CMDLINE_LINUX_DEFAULT=3D&quot;quiet acpi_osi=3DLinux iommu=3Dpt iommu=
=3D1 transparent_hugepage=3Dnever&quot;
------------------------------------------------
I would attach my journal, except it is literally full of MB of lines just =
repeating what is in the summary:

2015-10-01 08:38:40
root@eanna i ~ # journalctl --disk-usage
Archived and active journals take up 3.9G on disk.

ver_linux:
------------------------------------------------
Linux eanna 4.2.1-1-ARCH #1 SMP PREEMPT Tue Sep 22 06:57:07 CEST 2015 x86_6=
4 GNU/Linux
=20
Gnu C                  5.2.0
Gnu make               4.1
binutils               2.25.1
util-linux             2.27
mount                  debug
module-init-tools      21
e2fsprogs              1.42.12
jfsutils               1.1.15
reiserfsprogs          3.6.24
xfsprogs               4.2.0
pcmciautils            018
PPP                    2.4.7
Linux C Library        Dynamic linker (ldd)   2.22
Linux C++ Library      6.0.21
Net-tools              2.10-alpha
Kbd                    2.0.3
Sh-utils               8.24
wireless-tools         30
Modules Loaded         nls_utf8 udf crc_itu_t ses enclosure uas usb_storage=
 vhost_net vhost macvtap macvlan xt_CHECKSUM iptable_mangle ipt_MASQUERADE =
nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_=
defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp t=
un bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptabl=
e_filter fuse arc4 sch_fq_codel rt2800usb rt2x00usb rt2800lib rt2x00lib mac=
80211 fan thermal nfs fscache uvcvideo videobuf2_vmalloc snd_usb_audio vide=
obuf2_memops videobuf2_core v4l2_common cfg80211 snd_usbmidi_lib videodev i=
nput_leds led_class evdev joydev media crc_ccitt mousedev amdkfd mac_hid rf=
kill kvm_amd amd_iommu_v2 snd_hda_codec_hdmi kvm radeon crct10dif_pclmul cr=
c32_pclmul snd_virtuoso snd_hda_intel ghash_clmulni_intel snd_oxygen_lib cp=
210x snd_mpu401_uart aesni_intel usbserial snd_hda_codec ttm snd_rawmidi ae=
s_x86_64 lrw drm_kms_helper gf128mul snd_hda_core igb glue_helper ablk_help=
er cryptd snd_hwdep snd_seq_device snd_pcm snd_timer drm amd64_edac_mod snd=
 ptp soundcore pps_core dca i2c_algo_bit edac_core serio_raw pcspkr psmouse=
 k10temp edac_mce_amd sp5100_tco fam15h_power i2c_piix4 shpchp tpm_tis tpm =
button acpi_cpufreq processor nfsd auth_rpcgss oid_registry nfs_acl lockd g=
race sunrpc ipmi_si ipmi_devintf ipmi_msghandler ip_tables x_tables btrfs x=
or raid6_pq sr_mod cdrom hid_generic usbhid hid sd_mod atkbd libps2 crc32c_=
intel xhci_pci xhci_hcd ahci ohci_pci libahci ohci_hcd ehci_pci mpt2sas ehc=
i_hcd raid_class libata scsi_transport_sas usbcore usb_common scsi_mod i804=
2 serio</pre></div></div>
</blockquote></div><br></div>

--001a11c333f2329a250521d95982--

--===============5309122546003507817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5309122546003507817==--
