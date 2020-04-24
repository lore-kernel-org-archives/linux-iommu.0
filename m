Return-Path: <SRS0=k0pT=6I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5057CC54FD0
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 12:01:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116DD20736
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 12:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uGde7jYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116DD20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CBACB24C2A;
	Fri, 24 Apr 2020 12:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0QQsh1n8zzbs; Fri, 24 Apr 2020 12:01:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0EF30236B5;
	Fri, 24 Apr 2020 12:01:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00C37C089E;
	Fri, 24 Apr 2020 12:01:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08C07C0175
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 12:01:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EA821887AA
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 12:01:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YoyxBqchL6on for <iommu@lists.linux-foundation.org>;
 Fri, 24 Apr 2020 12:01:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 93A59887B5
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 12:01:10 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id k13so10466318wrw.7
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 05:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EQzCDDHNTuJWaLCmaTnBy3CgPo4x1idXZil7GTt5qSE=;
 b=uGde7jYq1DsgcMXXKAm2O4Qp0PmwiV99Os87c8n/7gvCzHvRsmsdEBvM+Z5Go+DlHe
 EzuoQac45cniYi9gWx9K5lRiq66DZapWQEgVWlUa/lbrD5ZW/BcPrpfuxzyJ3QWuEEir
 WGV3N1ZspikHqyPaCsHmNMXfXrkl7g66h+7trZuNisz+VEyMBLmfn+V3NKkmg0Lt8N21
 UoSWpVI9JeGb0OfuNBXsjRyOaSNGGDREyC0EYfALLQ5msydmKsiHDkr6GInp6qiJz4Oo
 w/aW/wiMnq1DI6IG9hdc5LhfBRrTjfiptiMrKgDk56SYBUXDZUZtX25MXqdom8izJk5O
 4vXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EQzCDDHNTuJWaLCmaTnBy3CgPo4x1idXZil7GTt5qSE=;
 b=OnaKKpkwNJ4kMTZJ8AZFfqEg9qbe84/VHO/u8LOwluF+UnZe5su8N5m2lBlHVBPiW5
 hhV5WZ3CpFqruu68LoiiDTPvVzXAcVW/2EJcgxK4No3gsqPKFQPFNHlQqfEl89duaLgV
 bc4r+CTnyLc1bmw3/AjcfQJRfTdi8cjAKpwN+OG8Zik5tYSM7a0cB9SvOb1xGAdClRE5
 qmLxCfTpzk4PUXe6faLQTCrbSlO0oifyuplo8okjhmvSUxbZljzGpDH6sB3dG2OULan8
 6Pa1lIu8H1slBAggwrpYimag51SKobKGFcfWOoZlh5ixMCajrch+KVuGAzy/JktHm5WQ
 /MCg==
X-Gm-Message-State: AGi0PuYjWod1uvou93hQepM3tKbd4TQ7eiDw9v6pH6qtSud7Uz7KxYBy
 Aztcrhfy5k1zyTwox3tMd0VfZuR78IZpl1Mqafs=
X-Google-Smtp-Source: APiQypID0lTZ2HNuPFyP9zNU7e3zhDgGSpjT2iNk3VfalxgjsfOTbP57EezkpI7O8jv7Mjxj3I4Wc2NdFs2qDGJj7oI=
X-Received: by 2002:adf:ab1b:: with SMTP id q27mr11489816wrc.220.1587729668720; 
 Fri, 24 Apr 2020 05:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAEbUFv6SHY8z2kuNFwZ4khFwgqLZjxi4-KfDv5kVANeROMU_Vw@mail.gmail.com>
 <CAEbUFv5AybVFe8Wg6ZKLaiUoUj25G_oRk+Xi_HVSvb6pTsgYzQ@mail.gmail.com>
 <CAEbUFv7YZCh5V5btB4npBLg_FcZqB01LOp_QQKM7qURmucPAqQ@mail.gmail.com>
 <562c9033-05b2-2a15-5294-f68e40c02e92@arm.com>
In-Reply-To: <562c9033-05b2-2a15-5294-f68e40c02e92@arm.com>
From: Bin <anole1949@gmail.com>
Date: Fri, 24 Apr 2020 20:00:57 +0800
Message-ID: <CAEbUFv5_bG7-rNFZ0R8f0ndgbc84aM_jyV8pi8wusy6qs9=hVA@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1201098509244631259=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============1201098509244631259==
Content-Type: multipart/alternative; boundary="000000000000e74e4705a4081ebf"

--000000000000e74e4705a4081ebf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Well, that's the problem! I'm assuming the iommu kernel module is leaking
memory. But I don't know why and how.

Do you have any idea about it? Or any further information is needed?

Robin Murphy <robin.murphy@arm.com> =E4=BA=8E 2020=E5=B9=B44=E6=9C=8824=E6=
=97=A5=E5=91=A8=E4=BA=94 19:20=E5=86=99=E9=81=93=EF=BC=9A

> On 2020-04-24 1:40 am, Bin wrote:
> > Hello? anyone there?
> >
> > Bin <anole1949@gmail.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8823=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:14=E5=86=99=E9=81=93=EF=BC=9A
> >
> >> Forget to mention, I've already disabled the slab merge, so this is wh=
at
> >> it is.
> >>
> >> Bin <anole1949@gmail.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8823=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:11=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >>> Hey, guys:
> >>>
> >>> I'm running a batch of CoreOS boxes, the lsb_release is:
> >>>
> >>> ```
> >>> # cat /etc/lsb-release
> >>> DISTRIB_ID=3D"Container Linux by CoreOS"
> >>> DISTRIB_RELEASE=3D2303.3.0
> >>> DISTRIB_CODENAME=3D"Rhyolite"
> >>> DISTRIB_DESCRIPTION=3D"Container Linux by CoreOS 2303.3.0 (Rhyolite)"
> >>> ```
> >>>
> >>> ```
> >>> # uname -a
> >>> Linux cloud-worker-25 4.19.86-coreos #1 SMP Mon Dec 2 20:13:38 -00 20=
19
> >>> x86_64 Intel(R) Xeon(R) CPU E5-2640 v2 @ 2.00GHz GenuineIntel GNU/Lin=
ux
> >>> ```
> >>> Recently, I found my vms constently being killed due to OOM, and afte=
r
> >>> digging into the problem, I finally realized that the kernel is leaki=
ng
> >>> memory.
> >>>
> >>> Here's my slabinfo:
> >>>
> >>>   Active / Total Objects (% used)    : 83818306 / 84191607 (99.6%)
> >>>   Active / Total Slabs (% used)      : 1336293 / 1336293 (100.0%)
> >>>   Active / Total Caches (% used)     : 152 / 217 (70.0%)
> >>>   Active / Total Size (% used)       : 5828768.08K / 5996848.72K
> (97.2%)
> >>>   Minimum / Average / Maximum Object : 0.01K / 0.07K / 23.25K
> >>>
> >>>    OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> >>>
> >>> 80253888 80253888 100%    0.06K 1253967       64   5015868K iommu_iov=
a
>
> Do you really have a peak demand of ~80 million simultaneous DMA
> buffers, or is some driver leaking DMA mappings?
>
> Robin.
>
> >>> 489472 489123  99%    0.03K   3824      128     15296K kmalloc-32
> >>>
> >>> 297444 271112  91%    0.19K   7082       42     56656K dentry
> >>>
> >>> 254400 252784  99%    0.06K   3975       64     15900K anon_vma_chain
> >>>
> >>> 222528  39255  17%    0.50K   6954       32    111264K kmalloc-512
> >>>
> >>> 202482 201814  99%    0.19K   4821       42     38568K vm_area_struct
> >>>
> >>> 200192 200192 100%    0.01K    391      512      1564K kmalloc-8
> >>>
> >>> 170528 169359  99%    0.25K   5329       32     42632K filp
> >>>
> >>> 158144 153508  97%    0.06K   2471       64      9884K kmalloc-64
> >>>
> >>> 149914 149365  99%    0.09K   3259       46     13036K anon_vma
> >>>
> >>> 146640 143123  97%    0.10K   3760       39     15040K buffer_head
> >>>
> >>> 130368  32791  25%    0.09K   3104       42     12416K kmalloc-96
> >>>
> >>> 129752 129752 100%    0.07K   2317       56      9268K Acpi-Operand
> >>>
> >>> 105468 105106  99%    0.04K   1034      102      4136K
> >>> selinux_inode_security
> >>>   73080  73080 100%    0.13K   2436       30      9744K
> kernfs_node_cache
> >>>
> >>>   72360  70261  97%    0.59K   1340       54     42880K inode_cache
> >>>
> >>>   71040  71040 100%    0.12K   2220       32      8880K eventpoll_epi
> >>>
> >>>   68096  59262  87%    0.02K    266      256      1064K kmalloc-16
> >>>
> >>>   53652  53652 100%    0.04K    526      102      2104K pde_opener
> >>>
> >>>   50496  31654  62%    2.00K   3156       16    100992K kmalloc-2048
> >>>
> >>>   46242  46242 100%    0.19K   1101       42      8808K cred_jar
> >>>
> >>>   44496  43013  96%    0.66K    927       48     29664K
> proc_inode_cache
> >>>
> >>>   44352  44352 100%    0.06K    693       64      2772K task_delay_in=
fo
> >>>
> >>>   43516  43471  99%    0.69K    946       46     30272K
> sock_inode_cache
> >>>
> >>>   37856  27626  72%    1.00K   1183       32     37856K kmalloc-1024
> >>>
> >>>   36736  36736 100%    0.07K    656       56      2624K eventpoll_pwq
> >>>
> >>>   34076  31282  91%    0.57K   1217       28     19472K radix_tree_no=
de
> >>>
> >>>   33660  30528  90%    1.05K   1122       30     35904K
> ext4_inode_cache
> >>>
> >>>   32760  30959  94%    0.19K    780       42      6240K kmalloc-192
> >>>
> >>>   32028  32028 100%    0.04K    314      102      1256K
> ext4_extent_status
> >>>
> >>>   30048  30048 100%    0.25K    939       32      7512K
> skbuff_head_cache
> >>>
> >>>   28736  28736 100%    0.06K    449       64      1796K fs_cache
> >>>
> >>>   24702  24702 100%    0.69K    537       46     17184K files_cache
> >>>
> >>>   23808  23808 100%    0.66K    496       48     15872K ovl_inode
> >>>
> >>>   23104  22945  99%    0.12K    722       32      2888K kmalloc-128
> >>>
> >>>   22724  21307  93%    0.69K    494       46     15808K
> shmem_inode_cache
> >>>
> >>>   21472  21472 100%    0.12K    671       32      2684K seq_file
> >>>
> >>>   19904  19904 100%    1.00K    622       32     19904K UNIX
> >>>
> >>>   17340  17340 100%    1.06K    578       30     18496K mm_struct
> >>>
> >>>   15980  15980 100%    0.02K     94      170       376K avtab_node
> >>>
> >>>   14070  14070 100%    1.06K    469       30     15008K signal_cache
> >>>
> >>>   13248  13248 100%    0.12K    414       32      1656K pid
> >>>
> >>>   12128  11777  97%    0.25K    379       32      3032K kmalloc-256
> >>>
> >>>   11008  11008 100%    0.02K     43      256       172K
> >>> selinux_file_security
> >>>   10812  10812 100%    0.04K    106      102       424K Acpi-Namespac=
e
> >>>
> >>> These information shows that the 'iommu_iova' is the top memory
> consumer.
> >>> In order to optimize the network performence of Openstack virtual
> machines,
> >>> I enabled the vt-d feature in bios and sriov feature of Intel 82599 1=
0G
> >>> NIC. I'm assuming this is the root cause of this issue.
> >>>
> >>> Is there anything I can do to fix it?
> >>>
> >>
> >
> >
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >
>

--000000000000e74e4705a4081ebf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Well, that&#39;s the problem! I&#39;m assuming the i=
ommu kernel module is leaking memory. But I don&#39;t know why and how.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Do you have any idea about =
it? Or any further information is needed?</div><div dir=3D"auto"><br><div c=
lass=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr">Rob=
in Murphy &lt;<a href=3D"mailto:robin.murphy@arm.com">robin.murphy@arm.com<=
/a>&gt; =E4=BA=8E 2020=E5=B9=B44=E6=9C=8824=E6=97=A5=E5=91=A8=E4=BA=94 19:2=
0=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 202=
0-04-24 1:40 am, Bin wrote:<br>
&gt; Hello? anyone there?<br>
&gt; <br>
&gt; Bin &lt;<a href=3D"mailto:anole1949@gmail.com" target=3D"_blank" rel=
=3D"noreferrer">anole1949@gmail.com</a>&gt; =E4=BA=8E2020=E5=B9=B44=E6=9C=
=8823=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:14=E5=86=99=E9=81=93=
=EF=BC=9A<br>
&gt; <br>
&gt;&gt; Forget to mention, I&#39;ve already disabled the slab merge, so th=
is is what<br>
&gt;&gt; it is.<br>
&gt;&gt;<br>
&gt;&gt; Bin &lt;<a href=3D"mailto:anole1949@gmail.com" target=3D"_blank" r=
el=3D"noreferrer">anole1949@gmail.com</a>&gt; =E4=BA=8E2020=E5=B9=B44=E6=9C=
=8823=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:11=E5=86=99=E9=81=93=
=EF=BC=9A<br>
&gt;&gt;<br>
&gt;&gt;&gt; Hey, guys:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I&#39;m running a batch of CoreOS boxes, the lsb_release is:<b=
r>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; ```<br>
&gt;&gt;&gt; # cat /etc/lsb-release<br>
&gt;&gt;&gt; DISTRIB_ID=3D&quot;Container Linux by CoreOS&quot;<br>
&gt;&gt;&gt; DISTRIB_RELEASE=3D2303.3.0<br>
&gt;&gt;&gt; DISTRIB_CODENAME=3D&quot;Rhyolite&quot;<br>
&gt;&gt;&gt; DISTRIB_DESCRIPTION=3D&quot;Container Linux by CoreOS 2303.3.0=
 (Rhyolite)&quot;<br>
&gt;&gt;&gt; ```<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; ```<br>
&gt;&gt;&gt; # uname -a<br>
&gt;&gt;&gt; Linux cloud-worker-25 4.19.86-coreos #1 SMP Mon Dec 2 20:13:38=
 -00 2019<br>
&gt;&gt;&gt; x86_64 Intel(R) Xeon(R) CPU E5-2640 v2 @ 2.00GHz GenuineIntel =
GNU/Linux<br>
&gt;&gt;&gt; ```<br>
&gt;&gt;&gt; Recently, I found my vms constently being killed due to OOM, a=
nd after<br>
&gt;&gt;&gt; digging into the problem, I finally realized that the kernel i=
s leaking<br>
&gt;&gt;&gt; memory.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Here&#39;s my slabinfo:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0Active / Total Objects (% used)=C2=A0 =C2=A0 : 838=
18306 / 84191607 (99.6%)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0Active / Total Slabs (% used)=C2=A0 =C2=A0 =C2=A0 =
: 1336293 / 1336293 (100.0%)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0Active / Total Caches (% used)=C2=A0 =C2=A0 =C2=A0=
: 152 / 217 (70.0%)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0Active / Total Size (% used)=C2=A0 =C2=A0 =C2=A0 =
=C2=A0: 5828768.08K / 5996848.72K (97.2%)<br>
&gt;&gt;&gt;=C2=A0 =C2=A0Minimum / Average / Maximum Object : 0.01K / 0.07K=
 / 23.25K<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 OBJS ACTIVE=C2=A0 USE OBJ SIZE=C2=A0 SLABS OBJ/SL=
AB CACHE SIZE NAME<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 80253888 80253888 100%=C2=A0 =C2=A0 0.06K 1253967=C2=A0 =C2=A0=
 =C2=A0 =C2=A064=C2=A0 =C2=A05015868K iommu_iova<br>
<br>
Do you really have a peak demand of ~80 million simultaneous DMA <br>
buffers, or is some driver leaking DMA mappings?<br>
<br>
Robin.<br>
<br>
&gt;&gt;&gt; 489472 489123=C2=A0 99%=C2=A0 =C2=A0 0.03K=C2=A0 =C2=A03824=C2=
=A0 =C2=A0 =C2=A0 128=C2=A0 =C2=A0 =C2=A015296K kmalloc-32<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 297444 271112=C2=A0 91%=C2=A0 =C2=A0 0.19K=C2=A0 =C2=A07082=C2=
=A0 =C2=A0 =C2=A0 =C2=A042=C2=A0 =C2=A0 =C2=A056656K dentry<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 254400 252784=C2=A0 99%=C2=A0 =C2=A0 0.06K=C2=A0 =C2=A03975=C2=
=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0 =C2=A0 =C2=A015900K anon_vma_chain<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 222528=C2=A0 39255=C2=A0 17%=C2=A0 =C2=A0 0.50K=C2=A0 =C2=A069=
54=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 111264K kmalloc-512<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 202482 201814=C2=A0 99%=C2=A0 =C2=A0 0.19K=C2=A0 =C2=A04821=C2=
=A0 =C2=A0 =C2=A0 =C2=A042=C2=A0 =C2=A0 =C2=A038568K vm_area_struct<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 200192 200192 100%=C2=A0 =C2=A0 0.01K=C2=A0 =C2=A0 391=C2=A0 =
=C2=A0 =C2=A0 512=C2=A0 =C2=A0 =C2=A0 1564K kmalloc-8<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 170528 169359=C2=A0 99%=C2=A0 =C2=A0 0.25K=C2=A0 =C2=A05329=C2=
=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A042632K filp<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 158144 153508=C2=A0 97%=C2=A0 =C2=A0 0.06K=C2=A0 =C2=A02471=C2=
=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0 =C2=A0 =C2=A0 9884K kmalloc-64<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 149914 149365=C2=A0 99%=C2=A0 =C2=A0 0.09K=C2=A0 =C2=A03259=C2=
=A0 =C2=A0 =C2=A0 =C2=A046=C2=A0 =C2=A0 =C2=A013036K anon_vma<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 146640 143123=C2=A0 97%=C2=A0 =C2=A0 0.10K=C2=A0 =C2=A03760=C2=
=A0 =C2=A0 =C2=A0 =C2=A039=C2=A0 =C2=A0 =C2=A015040K buffer_head<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 130368=C2=A0 32791=C2=A0 25%=C2=A0 =C2=A0 0.09K=C2=A0 =C2=A031=
04=C2=A0 =C2=A0 =C2=A0 =C2=A042=C2=A0 =C2=A0 =C2=A012416K kmalloc-96<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 129752 129752 100%=C2=A0 =C2=A0 0.07K=C2=A0 =C2=A02317=C2=A0 =
=C2=A0 =C2=A0 =C2=A056=C2=A0 =C2=A0 =C2=A0 9268K Acpi-Operand<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 105468 105106=C2=A0 99%=C2=A0 =C2=A0 0.04K=C2=A0 =C2=A01034=C2=
=A0 =C2=A0 =C2=A0 102=C2=A0 =C2=A0 =C2=A0 4136K<br>
&gt;&gt;&gt; selinux_inode_security<br>
&gt;&gt;&gt;=C2=A0 =C2=A073080=C2=A0 73080 100%=C2=A0 =C2=A0 0.13K=C2=A0 =
=C2=A02436=C2=A0 =C2=A0 =C2=A0 =C2=A030=C2=A0 =C2=A0 =C2=A0 9744K kernfs_no=
de_cache<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A072360=C2=A0 70261=C2=A0 97%=C2=A0 =C2=A0 0.59K=C2=
=A0 =C2=A01340=C2=A0 =C2=A0 =C2=A0 =C2=A054=C2=A0 =C2=A0 =C2=A042880K inode=
_cache<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A071040=C2=A0 71040 100%=C2=A0 =C2=A0 0.12K=C2=A0 =
=C2=A02220=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A0 8880K eventpoll=
_epi<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A068096=C2=A0 59262=C2=A0 87%=C2=A0 =C2=A0 0.02K=C2=
=A0 =C2=A0 266=C2=A0 =C2=A0 =C2=A0 256=C2=A0 =C2=A0 =C2=A0 1064K kmalloc-16=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A053652=C2=A0 53652 100%=C2=A0 =C2=A0 0.04K=C2=A0 =
=C2=A0 526=C2=A0 =C2=A0 =C2=A0 102=C2=A0 =C2=A0 =C2=A0 2104K pde_opener<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A050496=C2=A0 31654=C2=A0 62%=C2=A0 =C2=A0 2.00K=C2=
=A0 =C2=A03156=C2=A0 =C2=A0 =C2=A0 =C2=A016=C2=A0 =C2=A0 100992K kmalloc-20=
48<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A046242=C2=A0 46242 100%=C2=A0 =C2=A0 0.19K=C2=A0 =
=C2=A01101=C2=A0 =C2=A0 =C2=A0 =C2=A042=C2=A0 =C2=A0 =C2=A0 8808K cred_jar<=
br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A044496=C2=A0 43013=C2=A0 96%=C2=A0 =C2=A0 0.66K=C2=
=A0 =C2=A0 927=C2=A0 =C2=A0 =C2=A0 =C2=A048=C2=A0 =C2=A0 =C2=A029664K proc_=
inode_cache<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A044352=C2=A0 44352 100%=C2=A0 =C2=A0 0.06K=C2=A0 =
=C2=A0 693=C2=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0 =C2=A0 =C2=A0 2772K task_dela=
y_info<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A043516=C2=A0 43471=C2=A0 99%=C2=A0 =C2=A0 0.69K=C2=
=A0 =C2=A0 946=C2=A0 =C2=A0 =C2=A0 =C2=A046=C2=A0 =C2=A0 =C2=A030272K sock_=
inode_cache<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A037856=C2=A0 27626=C2=A0 72%=C2=A0 =C2=A0 1.00K=C2=
=A0 =C2=A01183=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A037856K kmall=
oc-1024<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A036736=C2=A0 36736 100%=C2=A0 =C2=A0 0.07K=C2=A0 =
=C2=A0 656=C2=A0 =C2=A0 =C2=A0 =C2=A056=C2=A0 =C2=A0 =C2=A0 2624K eventpoll=
_pwq<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A034076=C2=A0 31282=C2=A0 91%=C2=A0 =C2=A0 0.57K=C2=
=A0 =C2=A01217=C2=A0 =C2=A0 =C2=A0 =C2=A028=C2=A0 =C2=A0 =C2=A019472K radix=
_tree_node<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A033660=C2=A0 30528=C2=A0 90%=C2=A0 =C2=A0 1.05K=C2=
=A0 =C2=A01122=C2=A0 =C2=A0 =C2=A0 =C2=A030=C2=A0 =C2=A0 =C2=A035904K ext4_=
inode_cache<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A032760=C2=A0 30959=C2=A0 94%=C2=A0 =C2=A0 0.19K=C2=
=A0 =C2=A0 780=C2=A0 =C2=A0 =C2=A0 =C2=A042=C2=A0 =C2=A0 =C2=A0 6240K kmall=
oc-192<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A032028=C2=A0 32028 100%=C2=A0 =C2=A0 0.04K=C2=A0 =
=C2=A0 314=C2=A0 =C2=A0 =C2=A0 102=C2=A0 =C2=A0 =C2=A0 1256K ext4_extent_st=
atus<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A030048=C2=A0 30048 100%=C2=A0 =C2=A0 0.25K=C2=A0 =
=C2=A0 939=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A0 7512K skbuff_he=
ad_cache<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A028736=C2=A0 28736 100%=C2=A0 =C2=A0 0.06K=C2=A0 =
=C2=A0 449=C2=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0 =C2=A0 =C2=A0 1796K fs_cache<=
br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A024702=C2=A0 24702 100%=C2=A0 =C2=A0 0.69K=C2=A0 =
=C2=A0 537=C2=A0 =C2=A0 =C2=A0 =C2=A046=C2=A0 =C2=A0 =C2=A017184K files_cac=
he<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A023808=C2=A0 23808 100%=C2=A0 =C2=A0 0.66K=C2=A0 =
=C2=A0 496=C2=A0 =C2=A0 =C2=A0 =C2=A048=C2=A0 =C2=A0 =C2=A015872K ovl_inode=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A023104=C2=A0 22945=C2=A0 99%=C2=A0 =C2=A0 0.12K=C2=
=A0 =C2=A0 722=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A0 2888K kmall=
oc-128<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A022724=C2=A0 21307=C2=A0 93%=C2=A0 =C2=A0 0.69K=C2=
=A0 =C2=A0 494=C2=A0 =C2=A0 =C2=A0 =C2=A046=C2=A0 =C2=A0 =C2=A015808K shmem=
_inode_cache<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A021472=C2=A0 21472 100%=C2=A0 =C2=A0 0.12K=C2=A0 =
=C2=A0 671=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A0 2684K seq_file<=
br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A019904=C2=A0 19904 100%=C2=A0 =C2=A0 1.00K=C2=A0 =
=C2=A0 622=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A019904K UNIX<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A017340=C2=A0 17340 100%=C2=A0 =C2=A0 1.06K=C2=A0 =
=C2=A0 578=C2=A0 =C2=A0 =C2=A0 =C2=A030=C2=A0 =C2=A0 =C2=A018496K mm_struct=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A015980=C2=A0 15980 100%=C2=A0 =C2=A0 0.02K=C2=A0 =
=C2=A0 =C2=A094=C2=A0 =C2=A0 =C2=A0 170=C2=A0 =C2=A0 =C2=A0 =C2=A0376K avta=
b_node<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A014070=C2=A0 14070 100%=C2=A0 =C2=A0 1.06K=C2=A0 =
=C2=A0 469=C2=A0 =C2=A0 =C2=A0 =C2=A030=C2=A0 =C2=A0 =C2=A015008K signal_ca=
che<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A013248=C2=A0 13248 100%=C2=A0 =C2=A0 0.12K=C2=A0 =
=C2=A0 414=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A0 1656K pid<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A012128=C2=A0 11777=C2=A0 97%=C2=A0 =C2=A0 0.25K=C2=
=A0 =C2=A0 379=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A0 3032K kmall=
oc-256<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A011008=C2=A0 11008 100%=C2=A0 =C2=A0 0.02K=C2=A0 =
=C2=A0 =C2=A043=C2=A0 =C2=A0 =C2=A0 256=C2=A0 =C2=A0 =C2=A0 =C2=A0172K<br>
&gt;&gt;&gt; selinux_file_security<br>
&gt;&gt;&gt;=C2=A0 =C2=A010812=C2=A0 10812 100%=C2=A0 =C2=A0 0.04K=C2=A0 =
=C2=A0 106=C2=A0 =C2=A0 =C2=A0 102=C2=A0 =C2=A0 =C2=A0 =C2=A0424K Acpi-Name=
space<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; These information shows that the &#39;iommu_iova&#39; is the t=
op memory consumer.<br>
&gt;&gt;&gt; In order to optimize the network performence of Openstack virt=
ual machines,<br>
&gt;&gt;&gt; I enabled the vt-d feature in bios and sriov feature of Intel =
82599 10G<br>
&gt;&gt;&gt; NIC. I&#39;m assuming this is the root cause of this issue.<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Is there anything I can do to fix it?<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt; <br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; iommu mailing list<br>
&gt; <a href=3D"mailto:iommu@lists.linux-foundation.org" target=3D"_blank" =
rel=3D"noreferrer">iommu@lists.linux-foundation.org</a><br>
&gt; <a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/iommu" r=
el=3D"noreferrer noreferrer" target=3D"_blank">https://lists.linuxfoundatio=
n.org/mailman/listinfo/iommu</a><br>
&gt; <br>
</blockquote></div></div></div>

--000000000000e74e4705a4081ebf--

--===============1201098509244631259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1201098509244631259==--
