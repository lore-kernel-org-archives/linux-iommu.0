Return-Path: <SRS0=k0pT=6I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46B8C55194
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 13:20:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7DEC20776
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 13:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2OWzMx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DEC20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8C2D98824B;
	Fri, 24 Apr 2020 13:20:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iUOx7mPzNxC5; Fri, 24 Apr 2020 13:20:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2F729884F5;
	Fri, 24 Apr 2020 13:20:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19DB4C089E;
	Fri, 24 Apr 2020 13:20:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8E89C0175
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 13:20:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D35D9884F5
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 13:20:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k7oFl6Gswb4G for <iommu@lists.linux-foundation.org>;
 Fri, 24 Apr 2020 13:20:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 356A08824B
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 13:20:29 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id b11so10765501wrs.6
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fGV5Ef5uLpVHIOAuWmY+YuJz/Bn6KIoR+uW9D2dTe8A=;
 b=X2OWzMx6BQKTClLdhHqmK0qX2nXBnMoL3/AHhgU/Pda44EGwRs8dVuplaxRdPeIdw6
 8B7u06jg0WNt131Gmc1N60qLHHidpmYDzlThYo/ZRHfdGr3U9U08OQCVYZswy2Z2Z75T
 OFjGMW8NDUkXXA6/0J7+8fXq7OvBFPn9dXp7i2PuvFUbwqfHSx7uWU7hpE9Ws7LEKvTT
 rJJg+RVJd5ci458rTMx45VSXB/aHugrxJiVMcPIwEWSCt2ToOhaDepAXTWF3SR2T7GF0
 LZ8sc34pB8DRSnkPNOtrMm0LHAsZnFq1vO/KUooac2kG2RqtUXBPO5nFYAA2+0ze6GBT
 xjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fGV5Ef5uLpVHIOAuWmY+YuJz/Bn6KIoR+uW9D2dTe8A=;
 b=hApwd+j2JSGQBnaiJmTPNcO/Ibg0JsDkXj3QYfnOvR1OKLGR2t0lEoBjAFhHnUWFjI
 oLikBvUNF527hKZBzFDP3FP1hnMMLJtL5ZG9BvV8LX8kjVhoW9xkIjT98+rlcPqnOr3Q
 6AjFqsZPyvmmIVSp+yA0F3pFQfYbL+0023bgErfylJpARwPrYIxu0CKPTe7n2jLwWEVL
 JHcCG0lqsLldWeV6gWEitqmlKL9pIzGh7j0lW7X81DWBiqHBCODYI6RWkPPPZiE2mgjr
 bSoWQDC6r15soK+aq7FuZtGlIixUs1xHUTHXjolbcTEYSBOA7c8nAewvmLg97gpEuKnx
 DRCQ==
X-Gm-Message-State: AGi0PuaWllZi4a7NzIqvRGaOmy8jhICUvxWa1QihMCZC7YyBOvznen7y
 19aZmC+DhI6Qnbab0691Xf4TvaZ8O+8ii1UcWbzJZ1uN
X-Google-Smtp-Source: APiQypIdzVq+AVKV0oq3aGX5WC7GfBdgz8hjZ2k7WZUfMzqs578BXsu16sJ5g0sBWiJs3WNb9yPzTCidvHrgHe2GXFM=
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr4043570wro.361.1587734427522; 
 Fri, 24 Apr 2020 06:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAEbUFv6SHY8z2kuNFwZ4khFwgqLZjxi4-KfDv5kVANeROMU_Vw@mail.gmail.com>
 <CAEbUFv5AybVFe8Wg6ZKLaiUoUj25G_oRk+Xi_HVSvb6pTsgYzQ@mail.gmail.com>
 <CAEbUFv7YZCh5V5btB4npBLg_FcZqB01LOp_QQKM7qURmucPAqQ@mail.gmail.com>
 <562c9033-05b2-2a15-5294-f68e40c02e92@arm.com>
 <CAEbUFv5_bG7-rNFZ0R8f0ndgbc84aM_jyV8pi8wusy6qs9=hVA@mail.gmail.com>
 <CAEbUFv5mxo1TnJ7KyjpcPaefP4=3rB=_vgu8O3EHKcQQiBXo-Q@mail.gmail.com>
 <9157a31a-e6b5-4317-e50c-c69e1af094c5@arm.com>
In-Reply-To: <9157a31a-e6b5-4317-e50c-c69e1af094c5@arm.com>
From: Bin <anole1949@gmail.com>
Date: Fri, 24 Apr 2020 21:20:14 +0800
Message-ID: <CAEbUFv6yexM3nrNWMDdDV1T9QYcg7CT4nVE=eQt4C7CVYjs+fA@mail.gmail.com>
Subject: Re: iommu_iova slab eats too much memory
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8952554403295486874=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============8952554403295486874==
Content-Type: multipart/alternative; boundary="0000000000008cdb8c05a4093aa2"

--0000000000008cdb8c05a4093aa2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Robin:
    Thank you for your explanation. Now, I understand that this could be
NIC driver's fault, but how could I confirm it? Do I have to debug the
driver myself?

Robin Murphy <robin.murphy@arm.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8824=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:15=E5=86=99=E9=81=93=EF=BC=9A

> On 2020-04-24 1:06 pm, Bin wrote:
> > I'm not familiar with the mmu stuff, so what you mean by "some driver
> > leaking DMA mappings", is it possible that some other kernel module lik=
e
> > KVM or NIC driver leads to the leaking problem instead of the iommu
> module
> > itself?
>
> Yes - I doubt that intel-iommu itself is failing to free IOVAs when it
> should, since I'd expect a lot of people to have noticed that. It's far
> more likely that some driver is failing to call dma_unmap_* when it's
> finished with a buffer - with the IOMMU disabled that would be a no-op
> on x86 with a modern 64-bit-capable device, so such a latent bug could
> have been easily overlooked.
>
> Robin.
>
> > Bin <anole1949@gmail.com> =E4=BA=8E 2020=E5=B9=B44=E6=9C=8824=E6=97=A5=
=E5=91=A8=E4=BA=94 20:00=E5=86=99=E9=81=93=EF=BC=9A
> >
> >> Well, that's the problem! I'm assuming the iommu kernel module is
> leaking
> >> memory. But I don't know why and how.
> >>
> >> Do you have any idea about it? Or any further information is needed?
> >>
> >> Robin Murphy <robin.murphy@arm.com> =E4=BA=8E 2020=E5=B9=B44=E6=9C=882=
4=E6=97=A5=E5=91=A8=E4=BA=94 19:20=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >>> On 2020-04-24 1:40 am, Bin wrote:
> >>>> Hello? anyone there?
> >>>>
> >>>> Bin <anole1949@gmail.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8823=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:14=E5=86=99=E9=81=93=EF=BC=9A
> >>>>
> >>>>> Forget to mention, I've already disabled the slab merge, so this is
> >>> what
> >>>>> it is.
> >>>>>
> >>>>> Bin <anole1949@gmail.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8823=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:11=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>
> >>>>>> Hey, guys:
> >>>>>>
> >>>>>> I'm running a batch of CoreOS boxes, the lsb_release is:
> >>>>>>
> >>>>>> ```
> >>>>>> # cat /etc/lsb-release
> >>>>>> DISTRIB_ID=3D"Container Linux by CoreOS"
> >>>>>> DISTRIB_RELEASE=3D2303.3.0
> >>>>>> DISTRIB_CODENAME=3D"Rhyolite"
> >>>>>> DISTRIB_DESCRIPTION=3D"Container Linux by CoreOS 2303.3.0 (Rhyolit=
e)"
> >>>>>> ```
> >>>>>>
> >>>>>> ```
> >>>>>> # uname -a
> >>>>>> Linux cloud-worker-25 4.19.86-coreos #1 SMP Mon Dec 2 20:13:38 -00
> >>> 2019
> >>>>>> x86_64 Intel(R) Xeon(R) CPU E5-2640 v2 @ 2.00GHz GenuineIntel
> >>> GNU/Linux
> >>>>>> ```
> >>>>>> Recently, I found my vms constently being killed due to OOM, and
> after
> >>>>>> digging into the problem, I finally realized that the kernel is
> >>> leaking
> >>>>>> memory.
> >>>>>>
> >>>>>> Here's my slabinfo:
> >>>>>>
> >>>>>>    Active / Total Objects (% used)    : 83818306 / 84191607 (99.6%=
)
> >>>>>>    Active / Total Slabs (% used)      : 1336293 / 1336293 (100.0%)
> >>>>>>    Active / Total Caches (% used)     : 152 / 217 (70.0%)
> >>>>>>    Active / Total Size (% used)       : 5828768.08K / 5996848.72K
> >>> (97.2%)
> >>>>>>    Minimum / Average / Maximum Object : 0.01K / 0.07K / 23.25K
> >>>>>>
> >>>>>>     OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> >>>>>>
> >>>>>> 80253888 80253888 100%    0.06K 1253967       64   5015868K
> iommu_iova
> >>>
> >>> Do you really have a peak demand of ~80 million simultaneous DMA
> >>> buffers, or is some driver leaking DMA mappings?
> >>>
> >>> Robin.
> >>>
> >>>>>> 489472 489123  99%    0.03K   3824      128     15296K kmalloc-32
> >>>>>>
> >>>>>> 297444 271112  91%    0.19K   7082       42     56656K dentry
> >>>>>>
> >>>>>> 254400 252784  99%    0.06K   3975       64     15900K
> anon_vma_chain
> >>>>>>
> >>>>>> 222528  39255  17%    0.50K   6954       32    111264K kmalloc-512
> >>>>>>
> >>>>>> 202482 201814  99%    0.19K   4821       42     38568K
> vm_area_struct
> >>>>>>
> >>>>>> 200192 200192 100%    0.01K    391      512      1564K kmalloc-8
> >>>>>>
> >>>>>> 170528 169359  99%    0.25K   5329       32     42632K filp
> >>>>>>
> >>>>>> 158144 153508  97%    0.06K   2471       64      9884K kmalloc-64
> >>>>>>
> >>>>>> 149914 149365  99%    0.09K   3259       46     13036K anon_vma
> >>>>>>
> >>>>>> 146640 143123  97%    0.10K   3760       39     15040K buffer_head
> >>>>>>
> >>>>>> 130368  32791  25%    0.09K   3104       42     12416K kmalloc-96
> >>>>>>
> >>>>>> 129752 129752 100%    0.07K   2317       56      9268K Acpi-Operan=
d
> >>>>>>
> >>>>>> 105468 105106  99%    0.04K   1034      102      4136K
> >>>>>> selinux_inode_security
> >>>>>>    73080  73080 100%    0.13K   2436       30      9744K
> >>> kernfs_node_cache
> >>>>>>
> >>>>>>    72360  70261  97%    0.59K   1340       54     42880K inode_cac=
he
> >>>>>>
> >>>>>>    71040  71040 100%    0.12K   2220       32      8880K
> eventpoll_epi
> >>>>>>
> >>>>>>    68096  59262  87%    0.02K    266      256      1064K kmalloc-1=
6
> >>>>>>
> >>>>>>    53652  53652 100%    0.04K    526      102      2104K pde_opene=
r
> >>>>>>
> >>>>>>    50496  31654  62%    2.00K   3156       16    100992K
> kmalloc-2048
> >>>>>>
> >>>>>>    46242  46242 100%    0.19K   1101       42      8808K cred_jar
> >>>>>>
> >>>>>>    44496  43013  96%    0.66K    927       48     29664K
> >>> proc_inode_cache
> >>>>>>
> >>>>>>    44352  44352 100%    0.06K    693       64      2772K
> >>> task_delay_info
> >>>>>>
> >>>>>>    43516  43471  99%    0.69K    946       46     30272K
> >>> sock_inode_cache
> >>>>>>
> >>>>>>    37856  27626  72%    1.00K   1183       32     37856K
> kmalloc-1024
> >>>>>>
> >>>>>>    36736  36736 100%    0.07K    656       56      2624K
> eventpoll_pwq
> >>>>>>
> >>>>>>    34076  31282  91%    0.57K   1217       28     19472K
> >>> radix_tree_node
> >>>>>>
> >>>>>>    33660  30528  90%    1.05K   1122       30     35904K
> >>> ext4_inode_cache
> >>>>>>
> >>>>>>    32760  30959  94%    0.19K    780       42      6240K kmalloc-1=
92
> >>>>>>
> >>>>>>    32028  32028 100%    0.04K    314      102      1256K
> >>> ext4_extent_status
> >>>>>>
> >>>>>>    30048  30048 100%    0.25K    939       32      7512K
> >>> skbuff_head_cache
> >>>>>>
> >>>>>>    28736  28736 100%    0.06K    449       64      1796K fs_cache
> >>>>>>
> >>>>>>    24702  24702 100%    0.69K    537       46     17184K files_cac=
he
> >>>>>>
> >>>>>>    23808  23808 100%    0.66K    496       48     15872K ovl_inode
> >>>>>>
> >>>>>>    23104  22945  99%    0.12K    722       32      2888K kmalloc-1=
28
> >>>>>>
> >>>>>>    22724  21307  93%    0.69K    494       46     15808K
> >>> shmem_inode_cache
> >>>>>>
> >>>>>>    21472  21472 100%    0.12K    671       32      2684K seq_file
> >>>>>>
> >>>>>>    19904  19904 100%    1.00K    622       32     19904K UNIX
> >>>>>>
> >>>>>>    17340  17340 100%    1.06K    578       30     18496K mm_struct
> >>>>>>
> >>>>>>    15980  15980 100%    0.02K     94      170       376K avtab_nod=
e
> >>>>>>
> >>>>>>    14070  14070 100%    1.06K    469       30     15008K
> signal_cache
> >>>>>>
> >>>>>>    13248  13248 100%    0.12K    414       32      1656K pid
> >>>>>>
> >>>>>>    12128  11777  97%    0.25K    379       32      3032K kmalloc-2=
56
> >>>>>>
> >>>>>>    11008  11008 100%    0.02K     43      256       172K
> >>>>>> selinux_file_security
> >>>>>>    10812  10812 100%    0.04K    106      102       424K
> Acpi-Namespace
> >>>>>>
> >>>>>> These information shows that the 'iommu_iova' is the top memory
> >>> consumer.
> >>>>>> In order to optimize the network performence of Openstack virtual
> >>> machines,
> >>>>>> I enabled the vt-d feature in bios and sriov feature of Intel 8259=
9
> >>> 10G
> >>>>>> NIC. I'm assuming this is the root cause of this issue.
> >>>>>>
> >>>>>> Is there anything I can do to fix it?
> >>>>>>
> >>>>>
> >>>>
> >>>>
> >>>> _______________________________________________
> >>>> iommu mailing list
> >>>> iommu@lists.linux-foundation.org
> >>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >>>>
> >>>
> >>
> >
>

--0000000000008cdb8c05a4093aa2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dear Robin:</div>=C2=A0 =C2=A0 Thank you for your exp=
lanation. Now, I understand that this could be NIC driver&#39;s fault, but =
how could I confirm it? Do I have to debug the driver myself?</div><br><div=
 class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Robin Murphy &=
lt;<a href=3D"mailto:robin.murphy@arm.com">robin.murphy@arm.com</a>&gt; =E4=
=BA=8E2020=E5=B9=B44=E6=9C=8824=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=
=888:15=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 2020-04-24 1:06 pm, Bin wrote:<br>
&gt; I&#39;m not familiar with the mmu stuff, so what you mean by &quot;som=
e driver<br>
&gt; leaking DMA mappings&quot;, is it possible that some other kernel modu=
le like<br>
&gt; KVM or NIC driver leads to the leaking problem instead of the iommu mo=
dule<br>
&gt; itself?<br>
<br>
Yes - I doubt that intel-iommu itself is failing to free IOVAs when it <br>
should, since I&#39;d expect a lot of people to have noticed that. It&#39;s=
 far <br>
more likely that some driver is failing to call dma_unmap_* when it&#39;s <=
br>
finished with a buffer - with the IOMMU disabled that would be a no-op <br>
on x86 with a modern 64-bit-capable device, so such a latent bug could <br>
have been easily overlooked.<br>
<br>
Robin.<br>
<br>
&gt; Bin &lt;<a href=3D"mailto:anole1949@gmail.com" target=3D"_blank">anole=
1949@gmail.com</a>&gt; =E4=BA=8E 2020=E5=B9=B44=E6=9C=8824=E6=97=A5=E5=91=
=A8=E4=BA=94 20:00=E5=86=99=E9=81=93=EF=BC=9A<br>
&gt; <br>
&gt;&gt; Well, that&#39;s the problem! I&#39;m assuming the iommu kernel mo=
dule is leaking<br>
&gt;&gt; memory. But I don&#39;t know why and how.<br>
&gt;&gt;<br>
&gt;&gt; Do you have any idea about it? Or any further information is neede=
d?<br>
&gt;&gt;<br>
&gt;&gt; Robin Murphy &lt;<a href=3D"mailto:robin.murphy@arm.com" target=3D=
"_blank">robin.murphy@arm.com</a>&gt; =E4=BA=8E 2020=E5=B9=B44=E6=9C=8824=
=E6=97=A5=E5=91=A8=E4=BA=94 19:20=E5=86=99=E9=81=93=EF=BC=9A<br>
&gt;&gt;<br>
&gt;&gt;&gt; On 2020-04-24 1:40 am, Bin wrote:<br>
&gt;&gt;&gt;&gt; Hello? anyone there?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Bin &lt;<a href=3D"mailto:anole1949@gmail.com" target=3D"_=
blank">anole1949@gmail.com</a>&gt; =E4=BA=8E2020=E5=B9=B44=E6=9C=8823=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:14=E5=86=99=E9=81=93=EF=BC=9A<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Forget to mention, I&#39;ve already disabled the slab =
merge, so this is<br>
&gt;&gt;&gt; what<br>
&gt;&gt;&gt;&gt;&gt; it is.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Bin &lt;<a href=3D"mailto:anole1949@gmail.com" target=
=3D"_blank">anole1949@gmail.com</a>&gt; =E4=BA=8E2020=E5=B9=B44=E6=9C=8823=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:11=E5=86=99=E9=81=93=EF=BC=
=9A<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Hey, guys:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; I&#39;m running a batch of CoreOS boxes, the lsb_r=
elease is:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; ```<br>
&gt;&gt;&gt;&gt;&gt;&gt; # cat /etc/lsb-release<br>
&gt;&gt;&gt;&gt;&gt;&gt; DISTRIB_ID=3D&quot;Container Linux by CoreOS&quot;=
<br>
&gt;&gt;&gt;&gt;&gt;&gt; DISTRIB_RELEASE=3D2303.3.0<br>
&gt;&gt;&gt;&gt;&gt;&gt; DISTRIB_CODENAME=3D&quot;Rhyolite&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; DISTRIB_DESCRIPTION=3D&quot;Container Linux by Cor=
eOS 2303.3.0 (Rhyolite)&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt; ```<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; ```<br>
&gt;&gt;&gt;&gt;&gt;&gt; # uname -a<br>
&gt;&gt;&gt;&gt;&gt;&gt; Linux cloud-worker-25 4.19.86-coreos #1 SMP Mon De=
c 2 20:13:38 -00<br>
&gt;&gt;&gt; 2019<br>
&gt;&gt;&gt;&gt;&gt;&gt; x86_64 Intel(R) Xeon(R) CPU E5-2640 v2 @ 2.00GHz G=
enuineIntel<br>
&gt;&gt;&gt; GNU/Linux<br>
&gt;&gt;&gt;&gt;&gt;&gt; ```<br>
&gt;&gt;&gt;&gt;&gt;&gt; Recently, I found my vms constently being killed d=
ue to OOM, and after<br>
&gt;&gt;&gt;&gt;&gt;&gt; digging into the problem, I finally realized that =
the kernel is<br>
&gt;&gt;&gt; leaking<br>
&gt;&gt;&gt;&gt;&gt;&gt; memory.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Here&#39;s my slabinfo:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 Active / Total Objects (% used)=C2=A0=
 =C2=A0 : 83818306 / 84191607 (99.6%)<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 Active / Total Slabs (% used)=C2=A0 =
=C2=A0 =C2=A0 : 1336293 / 1336293 (100.0%)<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 Active / Total Caches (% used)=C2=A0 =
=C2=A0 =C2=A0: 152 / 217 (70.0%)<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 Active / Total Size (% used)=C2=A0 =
=C2=A0 =C2=A0 =C2=A0: 5828768.08K / 5996848.72K<br>
&gt;&gt;&gt; (97.2%)<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 Minimum / Average / Maximum Object : =
0.01K / 0.07K / 23.25K<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0OBJS ACTIVE=C2=A0 USE OBJ SIZE=
=C2=A0 SLABS OBJ/SLAB CACHE SIZE NAME<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; 80253888 80253888 100%=C2=A0 =C2=A0 0.06K 1253967=
=C2=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0 =C2=A05015868K iommu_iova<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Do you really have a peak demand of ~80 million simultaneous D=
MA<br>
&gt;&gt;&gt; buffers, or is some driver leaking DMA mappings?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Robin.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; 489472 489123=C2=A0 99%=C2=A0 =C2=A0 0.03K=C2=A0 =
=C2=A03824=C2=A0 =C2=A0 =C2=A0 128=C2=A0 =C2=A0 =C2=A015296K kmalloc-32<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; 297444 271112=C2=A0 91%=C2=A0 =C2=A0 0.19K=C2=A0 =
=C2=A07082=C2=A0 =C2=A0 =C2=A0 =C2=A042=C2=A0 =C2=A0 =C2=A056656K dentry<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; 254400 252784=C2=A0 99%=C2=A0 =C2=A0 0.06K=C2=A0 =
=C2=A03975=C2=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0 =C2=A0 =C2=A015900K anon_vma_=
chain<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; 222528=C2=A0 39255=C2=A0 17%=C2=A0 =C2=A0 0.50K=C2=
=A0 =C2=A06954=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 111264K kmalloc-51=
2<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; 202482 201814=C2=A0 99%=C2=A0 =C2=A0 0.19K=C2=A0 =
=C2=A04821=C2=A0 =C2=A0 =C2=A0 =C2=A042=C2=A0 =C2=A0 =C2=A038568K vm_area_s=
truct<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; 200192 200192 100%=C2=A0 =C2=A0 0.01K=C2=A0 =C2=A0=
 391=C2=A0 =C2=A0 =C2=A0 512=C2=A0 =C2=A0 =C2=A0 1564K kmalloc-8<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; 170528 169359=C2=A0 99%=C2=A0 =C2=A0 0.25K=C2=A0 =
=C2=A05329=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A042632K filp<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; 158144 153508=C2=A0 97%=C2=A0 =C2=A0 0.06K=C2=A0 =
=C2=A02471=C2=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0 =C2=A0 =C2=A0 9884K kmalloc-6=
4<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; 149914 149365=C2=A0 99%=C2=A0 =C2=A0 0.09K=C2=A0 =
=C2=A03259=C2=A0 =C2=A0 =C2=A0 =C2=A046=C2=A0 =C2=A0 =C2=A013036K anon_vma<=
br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; 146640 143123=C2=A0 97%=C2=A0 =C2=A0 0.10K=C2=A0 =
=C2=A03760=C2=A0 =C2=A0 =C2=A0 =C2=A039=C2=A0 =C2=A0 =C2=A015040K buffer_he=
ad<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; 130368=C2=A0 32791=C2=A0 25%=C2=A0 =C2=A0 0.09K=C2=
=A0 =C2=A03104=C2=A0 =C2=A0 =C2=A0 =C2=A042=C2=A0 =C2=A0 =C2=A012416K kmall=
oc-96<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; 129752 129752 100%=C2=A0 =C2=A0 0.07K=C2=A0 =C2=A0=
2317=C2=A0 =C2=A0 =C2=A0 =C2=A056=C2=A0 =C2=A0 =C2=A0 9268K Acpi-Operand<br=
>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; 105468 105106=C2=A0 99%=C2=A0 =C2=A0 0.04K=C2=A0 =
=C2=A01034=C2=A0 =C2=A0 =C2=A0 102=C2=A0 =C2=A0 =C2=A0 4136K<br>
&gt;&gt;&gt;&gt;&gt;&gt; selinux_inode_security<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 73080=C2=A0 73080 100%=C2=A0 =C2=A0 0=
.13K=C2=A0 =C2=A02436=C2=A0 =C2=A0 =C2=A0 =C2=A030=C2=A0 =C2=A0 =C2=A0 9744=
K<br>
&gt;&gt;&gt; kernfs_node_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 72360=C2=A0 70261=C2=A0 97%=C2=A0 =C2=
=A0 0.59K=C2=A0 =C2=A01340=C2=A0 =C2=A0 =C2=A0 =C2=A054=C2=A0 =C2=A0 =C2=A0=
42880K inode_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 71040=C2=A0 71040 100%=C2=A0 =C2=A0 0=
.12K=C2=A0 =C2=A02220=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A0 8880=
K eventpoll_epi<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 68096=C2=A0 59262=C2=A0 87%=C2=A0 =C2=
=A0 0.02K=C2=A0 =C2=A0 266=C2=A0 =C2=A0 =C2=A0 256=C2=A0 =C2=A0 =C2=A0 1064=
K kmalloc-16<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 53652=C2=A0 53652 100%=C2=A0 =C2=A0 0=
.04K=C2=A0 =C2=A0 526=C2=A0 =C2=A0 =C2=A0 102=C2=A0 =C2=A0 =C2=A0 2104K pde=
_opener<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 50496=C2=A0 31654=C2=A0 62%=C2=A0 =C2=
=A0 2.00K=C2=A0 =C2=A03156=C2=A0 =C2=A0 =C2=A0 =C2=A016=C2=A0 =C2=A0 100992=
K kmalloc-2048<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 46242=C2=A0 46242 100%=C2=A0 =C2=A0 0=
.19K=C2=A0 =C2=A01101=C2=A0 =C2=A0 =C2=A0 =C2=A042=C2=A0 =C2=A0 =C2=A0 8808=
K cred_jar<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 44496=C2=A0 43013=C2=A0 96%=C2=A0 =C2=
=A0 0.66K=C2=A0 =C2=A0 927=C2=A0 =C2=A0 =C2=A0 =C2=A048=C2=A0 =C2=A0 =C2=A0=
29664K<br>
&gt;&gt;&gt; proc_inode_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 44352=C2=A0 44352 100%=C2=A0 =C2=A0 0=
.06K=C2=A0 =C2=A0 693=C2=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0 =C2=A0 =C2=A0 2772=
K<br>
&gt;&gt;&gt; task_delay_info<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 43516=C2=A0 43471=C2=A0 99%=C2=A0 =C2=
=A0 0.69K=C2=A0 =C2=A0 946=C2=A0 =C2=A0 =C2=A0 =C2=A046=C2=A0 =C2=A0 =C2=A0=
30272K<br>
&gt;&gt;&gt; sock_inode_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 37856=C2=A0 27626=C2=A0 72%=C2=A0 =C2=
=A0 1.00K=C2=A0 =C2=A01183=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A0=
37856K kmalloc-1024<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 36736=C2=A0 36736 100%=C2=A0 =C2=A0 0=
.07K=C2=A0 =C2=A0 656=C2=A0 =C2=A0 =C2=A0 =C2=A056=C2=A0 =C2=A0 =C2=A0 2624=
K eventpoll_pwq<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 34076=C2=A0 31282=C2=A0 91%=C2=A0 =C2=
=A0 0.57K=C2=A0 =C2=A01217=C2=A0 =C2=A0 =C2=A0 =C2=A028=C2=A0 =C2=A0 =C2=A0=
19472K<br>
&gt;&gt;&gt; radix_tree_node<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 33660=C2=A0 30528=C2=A0 90%=C2=A0 =C2=
=A0 1.05K=C2=A0 =C2=A01122=C2=A0 =C2=A0 =C2=A0 =C2=A030=C2=A0 =C2=A0 =C2=A0=
35904K<br>
&gt;&gt;&gt; ext4_inode_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 32760=C2=A0 30959=C2=A0 94%=C2=A0 =C2=
=A0 0.19K=C2=A0 =C2=A0 780=C2=A0 =C2=A0 =C2=A0 =C2=A042=C2=A0 =C2=A0 =C2=A0=
 6240K kmalloc-192<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 32028=C2=A0 32028 100%=C2=A0 =C2=A0 0=
.04K=C2=A0 =C2=A0 314=C2=A0 =C2=A0 =C2=A0 102=C2=A0 =C2=A0 =C2=A0 1256K<br>
&gt;&gt;&gt; ext4_extent_status<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 30048=C2=A0 30048 100%=C2=A0 =C2=A0 0=
.25K=C2=A0 =C2=A0 939=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A0 7512=
K<br>
&gt;&gt;&gt; skbuff_head_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 28736=C2=A0 28736 100%=C2=A0 =C2=A0 0=
.06K=C2=A0 =C2=A0 449=C2=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0 =C2=A0 =C2=A0 1796=
K fs_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 24702=C2=A0 24702 100%=C2=A0 =C2=A0 0=
.69K=C2=A0 =C2=A0 537=C2=A0 =C2=A0 =C2=A0 =C2=A046=C2=A0 =C2=A0 =C2=A017184=
K files_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 23808=C2=A0 23808 100%=C2=A0 =C2=A0 0=
.66K=C2=A0 =C2=A0 496=C2=A0 =C2=A0 =C2=A0 =C2=A048=C2=A0 =C2=A0 =C2=A015872=
K ovl_inode<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 23104=C2=A0 22945=C2=A0 99%=C2=A0 =C2=
=A0 0.12K=C2=A0 =C2=A0 722=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A0=
 2888K kmalloc-128<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 22724=C2=A0 21307=C2=A0 93%=C2=A0 =C2=
=A0 0.69K=C2=A0 =C2=A0 494=C2=A0 =C2=A0 =C2=A0 =C2=A046=C2=A0 =C2=A0 =C2=A0=
15808K<br>
&gt;&gt;&gt; shmem_inode_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 21472=C2=A0 21472 100%=C2=A0 =C2=A0 0=
.12K=C2=A0 =C2=A0 671=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A0 2684=
K seq_file<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 19904=C2=A0 19904 100%=C2=A0 =C2=A0 1=
.00K=C2=A0 =C2=A0 622=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A019904=
K UNIX<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 17340=C2=A0 17340 100%=C2=A0 =C2=A0 1=
.06K=C2=A0 =C2=A0 578=C2=A0 =C2=A0 =C2=A0 =C2=A030=C2=A0 =C2=A0 =C2=A018496=
K mm_struct<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 15980=C2=A0 15980 100%=C2=A0 =C2=A0 0=
.02K=C2=A0 =C2=A0 =C2=A094=C2=A0 =C2=A0 =C2=A0 170=C2=A0 =C2=A0 =C2=A0 =C2=
=A0376K avtab_node<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 14070=C2=A0 14070 100%=C2=A0 =C2=A0 1=
.06K=C2=A0 =C2=A0 469=C2=A0 =C2=A0 =C2=A0 =C2=A030=C2=A0 =C2=A0 =C2=A015008=
K signal_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 13248=C2=A0 13248 100%=C2=A0 =C2=A0 0=
.12K=C2=A0 =C2=A0 414=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A0 1656=
K pid<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 12128=C2=A0 11777=C2=A0 97%=C2=A0 =C2=
=A0 0.25K=C2=A0 =C2=A0 379=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A0=
 3032K kmalloc-256<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 11008=C2=A0 11008 100%=C2=A0 =C2=A0 0=
.02K=C2=A0 =C2=A0 =C2=A043=C2=A0 =C2=A0 =C2=A0 256=C2=A0 =C2=A0 =C2=A0 =C2=
=A0172K<br>
&gt;&gt;&gt;&gt;&gt;&gt; selinux_file_security<br>
&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 10812=C2=A0 10812 100%=C2=A0 =C2=A0 0=
.04K=C2=A0 =C2=A0 106=C2=A0 =C2=A0 =C2=A0 102=C2=A0 =C2=A0 =C2=A0 =C2=A0424=
K Acpi-Namespace<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; These information shows that the &#39;iommu_iova&#=
39; is the top memory<br>
&gt;&gt;&gt; consumer.<br>
&gt;&gt;&gt;&gt;&gt;&gt; In order to optimize the network performence of Op=
enstack virtual<br>
&gt;&gt;&gt; machines,<br>
&gt;&gt;&gt;&gt;&gt;&gt; I enabled the vt-d feature in bios and sriov featu=
re of Intel 82599<br>
&gt;&gt;&gt; 10G<br>
&gt;&gt;&gt;&gt;&gt;&gt; NIC. I&#39;m assuming this is the root cause of th=
is issue.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Is there anything I can do to fix it?<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt;&gt; iommu mailing list<br>
&gt;&gt;&gt;&gt; <a href=3D"mailto:iommu@lists.linux-foundation.org" target=
=3D"_blank">iommu@lists.linux-foundation.org</a><br>
&gt;&gt;&gt;&gt; <a href=3D"https://lists.linuxfoundation.org/mailman/listi=
nfo/iommu" rel=3D"noreferrer" target=3D"_blank">https://lists.linuxfoundati=
on.org/mailman/listinfo/iommu</a><br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt; <br>
</blockquote></div>

--0000000000008cdb8c05a4093aa2--

--===============8952554403295486874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8952554403295486874==--
