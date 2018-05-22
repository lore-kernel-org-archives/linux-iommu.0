From: plexo rama <plexorama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: kernel BUG at drivers/iommu/intel-iommu.c:732! , kernel 4.14.39
Date: Tue, 22 May 2018 13:30:20 +0200
Message-ID: <CAONWS2ynv6oEnFRLmCCvLLC=XBk9qtFkugkRw6GDvBpfgbMbPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4055794623847748818=="
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============4055794623847748818==
Content-Type: multipart/alternative; boundary="0000000000005a436c056cc9be44"

--0000000000005a436c056cc9be44
Content-Type: text/plain; charset="UTF-8"

Hi all,


I receive the following kernel dump when trying to load QLogic qede in-tree
driver for a dual-port

*QLogic* Corp. FastLinQ QL41000 Series 10/25/40/50GbE Controller (rev 02).
One of the ports (45:00.0) is bound to the vfio-pci driver for
pci-passthrough to a KVM/QEMU guest. Id like to use the PF of the second
port on the host. I've unbound the pci device (45:00.1) from vfio-pci, but when
I modprobe qede, I receive this:




[1290644.615499] QLogic FastLinQ 4xxxx Core Module qed 8.10.11.21

[1290644.619128] qede_init: QLogic FastLinQ 4xxxx Ethernet Driver qede
8.10.10.21

[1290644.619347] qede 0000:45:00.1: enabling device (0400 -> 0402)

[1290644.632341] ------------[ cut here ]------------

[1290644.632344] kernel BUG at drivers/iommu/intel-iommu.c:732!

[1290644.632352] invalid opcode: 0000 [#1] SMP PTI

[1290644.632353] Modules linked in: qede(+) qed nbd vfio_pci
vfio_iommu_type1 vfio vhost_net vhost tap tcp_lp fuse dummy vfio_virqfd
ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat tun
bridge stp llc ebtable_filter ebtables team_mode_loadbalance
x86_pkg_temp_thermal coretemp kvm_intel cdc_ether kvm ioatdma irqbypass
usbnet dca shpchp hed nfsd efivarfs xfs libcrc32c team i40e ipmi_si
ipmi_devintf ipmi_msghandler [last unloaded: qed]

[1290644.632387] CPU: 24 PID: 106151 Comm: kworker/24:2 Not tainted 4.14.39
#1

[1290644.632389] Hardware name: Lenovo ThinkSystem SR850
-[7X19CTO1WW]-/-[7X19CTO1WW]-, BIOS -[TEE120N-1.20]- 10/16/2017

[1290644.632397] Workqueue: events work_for_cpu_fn

[1290644.632399] task: ffff8aec3a830180 task.stack: ffff9bc39a284000

[1290644.632409] RIP: 0010:domain_get_iommu+0x45/0x60

[1290644.632410] RSP: 0018:ffff9bc39a287b28 EFLAGS: 00010202

[1290644.632412] RAX: 0000000000000000 RBX: ffff8bacb72770a0 RCX:
0000000000000000

[1290644.632413] RDX: 0000000000000000 RSI: 000000b2e0d70000 RDI:
ffff8b4c9ff02140

[1290644.632414] RBP: 0000000000000000 R08: ffffffffffffffff R09:
ffff8ae0e0d70000

[1290644.632415] R10: 0000000000000004 R11: ffff8aee3ffded00 R12:
000000b2e0d70000

[1290644.632416] R13: ffff8b4c9ff02140 R14: ffffffffffffffff R15:
0000000000010000

[1290644.632417] FS:  0000000000000000(0000) GS:ffff8aecbf200000(0000)
knlGS:0000000000000000

[1290644.632418] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

[1290644.632420] CR2: 00007f3ecd5f6000 CR3: 0000000254c0a002 CR4:
00000000007626e0

[1290644.632420] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000

[1290644.632421] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400

[1290644.632422] PKRU: 55555554

[1290644.632423] Call Trace:

[1290644.632427]  __intel_map_single+0x5c/0x170

[1290644.632430]  intel_alloc_coherent+0xa8/0x120

[1290644.632446]  qed_ilt_blk_alloc+0xea/0x1f0 [qed]

[1290644.632455]  ? __kmalloc+0xe5/0x1e0

[1290644.632459]  qed_cxt_tables_alloc+0xb6/0x560 [qed]

[1290644.632465]  qed_resc_alloc+0x235/0x510 [qed]

[1290644.632472]  qed_slowpath_start+0x14b/0x6e0 [qed]

[1290644.632481]  __qede_probe.isra.31+0xe3/0x600 [qede]

[1290644.632487]  ? update_curr+0xac/0x140

[1290644.632491]  local_pci_probe+0x19/0x50

[1290644.632494]  work_for_cpu_fn+0xb/0x20

[1290644.632497]  process_one_work+0x133/0x340

[1290644.632499]  worker_thread+0x1ac/0x3b0

[1290644.632502]  kthread+0xf7/0x130

[1290644.632505]  ? process_one_work+0x340/0x340

[1290644.632506]  ? __kthread_parkme+0x60/0x60

[1290644.632516]  ret_from_fork+0x1f/0x30

[1290644.632518] Code: 48 83 c7 08 31 c0 eb 0b 48 83 c7 04 8b 4f fc 85 c9
75 1a 83 c0 01 39 d0 75 ee 31 c0 c3 31 d2 48 8b 05 08 a0 3e 01 48 8b 04 10
c3 <0f> 0b 85 c0 78 e9 48 98 48 8d 14 c5 00 00 00 00 eb e2 66 0f 1f

[1290644.632541] RIP: domain_get_iommu+0x45/0x60 RSP: ffff9bc39a287b28

[1290644.632544] ---[ end trace 80f7ccb19898ef42 ]---




What am I doing wrong? How can I make use of the second port on my host?


I'd really appreciate any help or suggestions how to make this work.


Thanks!

- Plexo

--0000000000005a436c056cc9be44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">




<span></span>





<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">Hi all,</span=
></p><p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><br></p><p =
class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo">I receive the follo=
wing kernel dump when trying to load QLogic qede in-tree driver for a dual-=
port=20




<span></span>





</p><p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=
=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures;color:rgb=
(195,55,32)"><b>QLogic</b></span><span class=3D"gmail-s2" style=3D"font-var=
iant-ligatures:no-common-ligatures"> Corp. FastLinQ QL41000 Series 10/25/40=
/50GbE Controller (rev 02). One of the ports (</span><span style=3D"font-va=
riant-ligatures:no-common-ligatures">45:00.0) is bound to the vfio-pci driv=
er for pci-passthrough to a KVM/QEMU guest. Id like to use the PF of the se=
cond port on the host. I&#39;ve unbound the pci device (<span style=3D"colo=
r:rgb(34,34,34);font-family:Menlo;font-size:14px;font-style:normal;font-var=
iant-ligatures:no-common-ligatures;font-variant-caps:normal;font-weight:400=
;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:none=
;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text=
-decoration-style:initial;text-decoration-color:initial;float:none;display:=
inline">45:00.1) from vfio-pci, but</span>=C2=A0when I modprobe qede, I rec=
eive this:=C2=A0 =C2=A0</span></p><p class=3D"gmail-p1" style=3D"margin:0px=
;font:14px Menlo"><span style=3D"font-variant-ligatures:no-common-ligatures=
">=C2=A0</span></p>


<p></p><p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span cla=
ss=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures"><br></=
span></p><p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span c=
lass=3D"gmail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[129=
0644.615499] QLogic FastLinQ 4xxxx Core Module qed 8.10.11.21</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6191=
28] qede_init: QLogic FastLinQ 4xxxx Ethernet Driver qede 8.10.10.21</span>=
</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6193=
47] qede 0000:45:00.1: enabling device (0400 -&gt; 0402)</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6323=
41] ------------[ cut here ]------------</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6323=
44] kernel BUG at drivers/iommu/intel-iommu.c:732!</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6323=
52] invalid opcode: 0000 [#1] SMP PTI</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6323=
53] Modules linked in: qede(+) qed nbd vfio_pci vfio_iommu_type1 vfio vhost=
_net vhost tap tcp_lp fuse dummy vfio_virqfd ipt_MASQUERADE nf_nat_masquera=
de_ipv4 iptable_nat nf_nat_ipv4 nf_nat tun bridge stp llc ebtable_filter eb=
tables team_mode_loadbalance x86_pkg_temp_thermal coretemp kvm_intel cdc_et=
her kvm ioatdma irqbypass usbnet dca shpchp hed nfsd efivarfs xfs libcrc32c=
 team i40e ipmi_si ipmi_devintf ipmi_msghandler [last unloaded: qed]</span>=
</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6323=
87] CPU: 24 PID: 106151 Comm: kworker/24:2 Not tainted 4.14.39 #1</span></p=
>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6323=
89] Hardware name: Lenovo ThinkSystem SR850 -[7X19CTO1WW]-/-[7X19CTO1WW]-, =
BIOS -[TEE120N-1.20]- 10/16/2017</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6323=
97] Workqueue: events work_for_cpu_fn</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6323=
99] task: ffff8aec3a830180 task.stack: ffff9bc39a284000</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
09] RIP: 0010:domain_get_iommu+0x45/0x60</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
10] RSP: 0018:ffff9bc39a287b28 EFLAGS: 00010202</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
12] RAX: 0000000000000000 RBX: ffff8bacb72770a0 RCX: 0000000000000000</span=
></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
13] RDX: 0000000000000000 RSI: 000000b2e0d70000 RDI: ffff8b4c9ff02140</span=
></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
14] RBP: 0000000000000000 R08: ffffffffffffffff R09: ffff8ae0e0d70000</span=
></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
15] R10: 0000000000000004 R11: ffff8aee3ffded00 R12: 000000b2e0d70000</span=
></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
16] R13: ffff8b4c9ff02140 R14: ffffffffffffffff R15: 0000000000010000</span=
></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
17] FS:<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>0000000000=
000000(0000) GS:ffff8aecbf200000(0000) knlGS:0000000000000000</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
18] CS:<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>0010 DS: 0=
000 ES: 0000 CR0: 0000000080050033</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
20] CR2: 00007f3ecd5f6000 CR3: 0000000254c0a002 CR4: 00000000007626e0</span=
></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
20] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000</span=
></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
21] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400</span=
></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
22] PKRU: 55555554</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
23] Call Trace:</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
27]<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>__intel_map_si=
ngle+0x5c/0x170</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
30]<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>intel_alloc_co=
herent+0xa8/0x120</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
46]<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>qed_ilt_blk_al=
loc+0xea/0x1f0 [qed]</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
55]<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>? __kmalloc+0x=
e5/0x1e0</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
59]<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>qed_cxt_tables=
_alloc+0xb6/0x560 [qed]</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
65]<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>qed_resc_alloc=
+0x235/0x510 [qed]</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
72]<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>qed_slowpath_s=
tart+0x14b/0x6e0 [qed]</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
81]<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>__qede_probe.i=
sra.31+0xe3/0x600 [qede]</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
87]<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>? update_curr+=
0xac/0x140</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
91]<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>local_pci_prob=
e+0x19/0x50</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
94]<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>work_for_cpu_f=
n+0xb/0x20</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
97]<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>process_one_wo=
rk+0x133/0x340</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6324=
99]<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>worker_thread+=
0x1ac/0x3b0</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6325=
02]<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>kthread+0xf7/0=
x130</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6325=
05]<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>? process_one_=
work+0x340/0x340</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6325=
06]<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>? __kthread_pa=
rkme+0x60/0x60</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6325=
16]<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>ret_from_fork+=
0x1f/0x30</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6325=
18] Code: 48 83 c7 08 31 c0 eb 0b 48 83 c7 04 8b 4f fc 85 c9 75 1a 83 c0 01=
 39 d0 75 ee 31 c0 c3 31 d2 48 8b 05 08 a0 3e 01 48 8b 04 10 c3 &lt;0f&gt; =
0b 85 c0 78 e9 48 98 48 8d 14 c5 00 00 00 00 eb e2 66 0f 1f<span class=3D"g=
mail-Apple-converted-space">=C2=A0</span></span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6325=
41] RIP: domain_get_iommu+0x45/0x60 RSP: ffff9bc39a287b28</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"g=
mail-s1" style=3D"font-variant-ligatures:no-common-ligatures">[1290644.6325=
44] ---[ end trace 80f7ccb19898ef42 ]---</span></p><p class=3D"gmail-p1" st=
yle=3D"margin:0px;font:14px Menlo"><span class=3D"gmail-s1" style=3D"font-v=
ariant-ligatures:no-common-ligatures"><br></span></p><p class=3D"gmail-p1" =
style=3D"margin:0px;font:14px Menlo"><span class=3D"gmail-s1" style=3D"font=
-variant-ligatures:no-common-ligatures"><br></span></p><p class=3D"gmail-p1=
" style=3D"margin:0px;font:14px Menlo"><span class=3D"gmail-s1" style=3D"fo=
nt-variant-ligatures:no-common-ligatures"><br></span></p><p class=3D"gmail-=
p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">What am I doing wrong? How can =
I make use of the second port on my host?=C2=A0</span></p><p class=3D"gmail=
-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"gmail-s1" style=3D=
"font-variant-ligatures:no-common-ligatures"><br></span></p><p class=3D"gma=
il-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"gmail-s1" style=
=3D"font-variant-ligatures:no-common-ligatures">I&#39;d really appreciate a=
ny help or suggestions how to make this work.</span></p><p class=3D"gmail-p=
1" style=3D"margin:0px;font:14px Menlo"><span class=3D"gmail-s1" style=3D"f=
ont-variant-ligatures:no-common-ligatures"><br></span></p><p class=3D"gmail=
-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"gmail-s1" style=3D=
"font-variant-ligatures:no-common-ligatures">Thanks!</span></p><p class=3D"=
gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"gmail-s1" sty=
le=3D"font-variant-ligatures:no-common-ligatures">- Plexo</span></p><p clas=
s=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"gmail-s1=
" style=3D"font-variant-ligatures:no-common-ligatures"><br></span></p><p cl=
ass=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><span class=3D"gmail-=
s1" style=3D"font-variant-ligatures:no-common-ligatures"><br></span></p><p =
class=3D"gmail-p1" style=3D"margin:0px;font:14px Menlo"><br></p><div><br></=
div></div>

--0000000000005a436c056cc9be44--

--===============4055794623847748818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4055794623847748818==--
