Return-Path: <SRS0=M/NG=6J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A987DC54FCB
	for <iommu@archiver.kernel.org>; Sat, 25 Apr 2020 13:38:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650DF20661
	for <iommu@archiver.kernel.org>; Sat, 25 Apr 2020 13:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALVs/rTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650DF20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 67C4C85C32;
	Sat, 25 Apr 2020 13:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WKC2TOCy5X40; Sat, 25 Apr 2020 13:38:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3D2BA85C11;
	Sat, 25 Apr 2020 13:38:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E9F3C1AE8;
	Sat, 25 Apr 2020 13:38:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2666BC0175
 for <iommu@lists.linux-foundation.org>; Sat, 25 Apr 2020 13:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 22C808559F
 for <iommu@lists.linux-foundation.org>; Sat, 25 Apr 2020 13:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U5PSCjgIJGYt for <iommu@lists.linux-foundation.org>;
 Sat, 25 Apr 2020 13:38:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 34C40815F4
 for <iommu@lists.linux-foundation.org>; Sat, 25 Apr 2020 13:38:33 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id k13so14869045wrw.7
 for <iommu@lists.linux-foundation.org>; Sat, 25 Apr 2020 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0kwJOaec1BIT8p6i/slFQClvfw2EP4TxOEFszMDwsZA=;
 b=ALVs/rTYVwYBgH6Q6O+kgDLsWktjGwUMagVJOy/HNOcHrFRwnjznllTQUqEWyNigal
 kRQyMq7EBGiXLM0AmJiWOygrWo8B5j7PdRl5mY27DFXX4YTrIMZO9Pdr+OgiGVz07LFn
 f42AsnFPsY8f7iY5WG8x6xEjH7mALHtGFFKJaxFvSpa1F5UnmigNlyAypttLHE9S45SQ
 8SVa+6Ld2Vqj373AmaTwFXpzCDIXOnw9w41HEd3mJbulfYmRPgvqIg83JscCPyCrCdd/
 QEbM1watK7llJ8FOi57LvwdAZGjXHVWlkTnEFxIxSMpqzZDAVsfQpek2OYMd1rCbRt54
 g2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0kwJOaec1BIT8p6i/slFQClvfw2EP4TxOEFszMDwsZA=;
 b=AwgFwiLHkBMlXGqnR/jzzQxkj/ecxK53ZKTFUGb6ZhdsKqcxGs5JFiGotG80pk/g7s
 ZF9lYLoa0Sr38GzIE/GnwIvnxVOrgEPD3jFQu3uP7p0soy2S00ZY6jO1pSUIpR9ReB5H
 9+u/DLiDbMR31siJ9PB547fKjPnKqQbbXEaR37kc28urtBG9LFUR+zuwTpiKYJrKkb3X
 EJ+5493A+P8UWv+KzsjnZJVnlZJ1JObAgiCuYvZW1RVtzlxxTbrA3HiD3a05xTlfZzBa
 ye28CvreJf9xL/hJW8NTF588ztQhZVia1x65EMbl7TvjdsByK+tuJTS3z9SF04qUcSsp
 pdJw==
X-Gm-Message-State: AGi0PuYExQmtwgerpgKZpkcNsO2Vh/hLQTZy62x4nujjRm+wTAffKqeH
 PSpcvOCcmq8KRMAoeS14HH8Xo7e15yKd7JF+sPc=
X-Google-Smtp-Source: APiQypJBk/G8zci5+7oKxnTvVjWr8DY6Qg/mdto7FBk01LBE3rQw4i0lxBoy/2LCa1uywmm979mqItjnSHD3Pov14Ig=
X-Received: by 2002:adf:ab1b:: with SMTP id q27mr18319937wrc.220.1587821911328; 
 Sat, 25 Apr 2020 06:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAEbUFv6SHY8z2kuNFwZ4khFwgqLZjxi4-KfDv5kVANeROMU_Vw@mail.gmail.com>
 <CAEbUFv5AybVFe8Wg6ZKLaiUoUj25G_oRk+Xi_HVSvb6pTsgYzQ@mail.gmail.com>
 <CAEbUFv7YZCh5V5btB4npBLg_FcZqB01LOp_QQKM7qURmucPAqQ@mail.gmail.com>
 <562c9033-05b2-2a15-5294-f68e40c02e92@arm.com>
 <CAEbUFv5_bG7-rNFZ0R8f0ndgbc84aM_jyV8pi8wusy6qs9=hVA@mail.gmail.com>
 <CAEbUFv5mxo1TnJ7KyjpcPaefP4=3rB=_vgu8O3EHKcQQiBXo-Q@mail.gmail.com>
 <9157a31a-e6b5-4317-e50c-c69e1af094c5@arm.com>
 <CAEbUFv6yexM3nrNWMDdDV1T9QYcg7CT4nVE=eQt4C7CVYjs+fA@mail.gmail.com>
 <e026d1e2-cf3a-a7c7-3a3d-76571e766813@arm.com>
 <70d663d7-a3c7-44f3-bea6-1c300566ec1f@huawei.com>
In-Reply-To: <70d663d7-a3c7-44f3-bea6-1c300566ec1f@huawei.com>
From: Bin <anole1949@gmail.com>
Date: Sat, 25 Apr 2020 21:38:18 +0800
Message-ID: <CAEbUFv7YXeK3hSd3G0EZtM=tmQoFZ0Thi0-7d++oSLbN-hAJjA@mail.gmail.com>
Subject: Re: iommu_iova slab eats too much memory
To: John Garry <john.garry@huawei.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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
Content-Type: multipart/mixed; boundary="===============2299515908338449236=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============2299515908338449236==
Content-Type: multipart/alternative; boundary="000000000000fdcb3005a41d98ab"

--000000000000fdcb3005a41d98ab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear John:
    Thank you for your reply. The case you mentioned is a typical
performance regression issue, there's no need for the kernel to oom kill
any random process even in the worst case. But in my observations, the
iommu_iova slab could consume up to 40G memory, and the kernel have to kill
my vm process to free memory (64G memory installed). So I don't think it's
relevent.


John Garry <john.garry@huawei.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8825=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=881:50=E5=86=99=E9=81=93=EF=BC=9A

> On 24/04/2020 17:30, Robin Murphy wrote:
> > On 2020-04-24 2:20 pm, Bin wrote:
> >> Dear Robin:
> >>       Thank you for your explanation. Now, I understand that this coul=
d
> be
> >> NIC driver's fault, but how could I confirm it? Do I have to debug the
> >> driver myself?
> >
> > I'd start with CONFIG_DMA_API_DEBUG - of course it will chew through
> > memory about an order of magnitude faster than the IOVAs alone, but it
> > should shed some light on whether DMA API usage looks suspicious, and
> > dumping the mappings should help track down the responsible driver(s).
> > Although the debugfs code doesn't show the stacktrace of where each
> > mapping was made, I guess it would be fairly simple to tweak that for a
> > quick way to narrow down where to start looking in an offending driver.
> >
> > Robin.
>
> Just mentioning this in case it's relevant - we found long term aging
> throughput test causes RB tree to grow very large (and would I assume
> eat lots of memory):
>
>
> https://lore.kernel.org/linux-iommu/20190815121104.29140-3-thunder.leizhe=
n@huawei.com/
>
> John
>
> >
> >> Robin Murphy <robin.murphy@arm.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8824=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:15=E5=86=99=E9=81=93=EF=BC=
=9A
> >>
> >>> On 2020-04-24 1:06 pm, Bin wrote:
> >>>> I'm not familiar with the mmu stuff, so what you mean by "some drive=
r
> >>>> leaking DMA mappings", is it possible that some other kernel module
> like
> >>>> KVM or NIC driver leads to the leaking problem instead of the iommu
> >>> module
> >>>> itself?
> >>>
> >>> Yes - I doubt that intel-iommu itself is failing to free IOVAs when i=
t
> >>> should, since I'd expect a lot of people to have noticed that. It's f=
ar
> >>> more likely that some driver is failing to call dma_unmap_* when it's
> >>> finished with a buffer - with the IOMMU disabled that would be a no-o=
p
> >>> on x86 with a modern 64-bit-capable device, so such a latent bug coul=
d
> >>> have been easily overlooked.
> >>>
> >>> Robin.
> >>>
> >>>> Bin <anole1949@gmail.com> =E4=BA=8E 2020=E5=B9=B44=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=BA=94 20:00=E5=86=99=E9=81=93=EF=BC=9A
> >>>>
> >>>>> Well, that's the problem! I'm assuming the iommu kernel module is
> >>> leaking
> >>>>> memory. But I don't know why and how.
> >>>>>
> >>>>> Do you have any idea about it? Or any further information is needed=
?
> >>>>>
> >>>>> Robin Murphy <robin.murphy@arm.com> =E4=BA=8E 2020=E5=B9=B44=E6=9C=
=8824=E6=97=A5=E5=91=A8=E4=BA=94 19:20=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>
> >>>>>> On 2020-04-24 1:40 am, Bin wrote:
> >>>>>>> Hello? anyone there?
> >>>>>>>
> >>>>>>> Bin <anole1949@gmail.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8823=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:14=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>>>
> >>>>>>>> Forget to mention, I've already disabled the slab merge, so this
> is
> >>>>>> what
> >>>>>>>> it is.
> >>>>>>>>
> >>>>>>>> Bin <anole1949@gmail.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8823=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:11=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>>>>
> >>>>>>>>> Hey, guys:
> >>>>>>>>>
> >>>>>>>>> I'm running a batch of CoreOS boxes, the lsb_release is:
> >>>>>>>>>
> >>>>>>>>> ```
> >>>>>>>>> # cat /etc/lsb-release
> >>>>>>>>> DISTRIB_ID=3D"Container Linux by CoreOS"
> >>>>>>>>> DISTRIB_RELEASE=3D2303.3.0
> >>>>>>>>> DISTRIB_CODENAME=3D"Rhyolite"
> >>>>>>>>> DISTRIB_DESCRIPTION=3D"Container Linux by CoreOS 2303.3.0
> (Rhyolite)"
> >>>>>>>>> ```
> >>>>>>>>>
> >>>>>>>>> ```
> >>>>>>>>> # uname -a
> >>>>>>>>> Linux cloud-worker-25 4.19.86-coreos #1 SMP Mon Dec 2 20:13:38
> -00
> >>>>>> 2019
> >>>>>>>>> x86_64 Intel(R) Xeon(R) CPU E5-2640 v2 @ 2.00GHz GenuineIntel
> >>>>>> GNU/Linux
> >>>>>>>>> ```
> >>>>>>>>> Recently, I found my vms constently being killed due to OOM, an=
d
> >>> after
> >>>>>>>>> digging into the problem, I finally realized that the kernel is
> >>>>>> leaking
> >>>>>>>>> memory.
> >>>>>>>>>
> >>>>>>>>> Here's my slabinfo:
> >>>>>>>>>
> >>>>>>>>>      Active / Total Objects (% used)    : 83818306 / 84191607
> (99.6%)
> >>>>>>>>>      Active / Total Slabs (% used)      : 1336293 / 1336293
> (100.0%)
> >>>>>>>>>      Active / Total Caches (% used)     : 152 / 217 (70.0%)
> >>>>>>>>>      Active / Total Size (% used)       : 5828768.08K /
> 5996848.72K
> >>>>>> (97.2%)
> >>>>>>>>>      Minimum / Average / Maximum Object : 0.01K / 0.07K / 23.25=
K
> >>>>>>>>>
> >>>>>>>>>       OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> >>>>>>>>>
> >>>>>>>>> 80253888 80253888 100%    0.06K 1253967       64   5015868K
> >>> iommu_iova
> >>>>>>
> >>>>>> Do you really have a peak demand of ~80 million simultaneous DMA
> >>>>>> buffers, or is some driver leaking DMA mappings?
> >>>>>>
> >>>>>> Robin.
> >>>>>>
> >>>>>>>>> 489472 489123  99%    0.03K   3824      128     15296K kmalloc-=
32
> >>>>>>>>>
> >>>>>>>>> 297444 271112  91%    0.19K   7082       42     56656K dentry
> >>>>>>>>>
> >>>>>>>>> 254400 252784  99%    0.06K   3975       64     15900K
> >>> anon_vma_chain
> >>>>>>>>>
> >>>>>>>>> 222528  39255  17%    0.50K   6954       32    111264K
> kmalloc-512
> >>>>>>>>>
> >>>>>>>>> 202482 201814  99%    0.19K   4821       42     38568K
> >>> vm_area_struct
> >>>>>>>>>
> >>>>>>>>> 200192 200192 100%    0.01K    391      512      1564K kmalloc-=
8
> >>>>>>>>>
> >>>>>>>>> 170528 169359  99%    0.25K   5329       32     42632K filp
> >>>>>>>>>
> >>>>>>>>> 158144 153508  97%    0.06K   2471       64      9884K kmalloc-=
64
> >>>>>>>>>
> >>>>>>>>> 149914 149365  99%    0.09K   3259       46     13036K anon_vma
> >>>>>>>>>
> >>>>>>>>> 146640 143123  97%    0.10K   3760       39     15040K
> buffer_head
> >>>>>>>>>
> >>>>>>>>> 130368  32791  25%    0.09K   3104       42     12416K kmalloc-=
96
> >>>>>>>>>
> >>>>>>>>> 129752 129752 100%    0.07K   2317       56      9268K
> Acpi-Operand
> >>>>>>>>>
> >>>>>>>>> 105468 105106  99%    0.04K   1034      102      4136K
> >>>>>>>>> selinux_inode_security
> >>>>>>>>>      73080  73080 100%    0.13K   2436       30      9744K
> >>>>>> kernfs_node_cache
> >>>>>>>>>
> >>>>>>>>>      72360  70261  97%    0.59K   1340       54     42880K
> inode_cache
> >>>>>>>>>
> >>>>>>>>>      71040  71040 100%    0.12K   2220       32      8880K
> >>> eventpoll_epi
> >>>>>>>>>
> >>>>>>>>>      68096  59262  87%    0.02K    266      256      1064K
> kmalloc-16
> >>>>>>>>>
> >>>>>>>>>      53652  53652 100%    0.04K    526      102      2104K
> pde_opener
> >>>>>>>>>
> >>>>>>>>>      50496  31654  62%    2.00K   3156       16    100992K
> >>> kmalloc-2048
> >>>>>>>>>
> >>>>>>>>>      46242  46242 100%    0.19K   1101       42      8808K
> cred_jar
> >>>>>>>>>
> >>>>>>>>>      44496  43013  96%    0.66K    927       48     29664K
> >>>>>> proc_inode_cache
> >>>>>>>>>
> >>>>>>>>>      44352  44352 100%    0.06K    693       64      2772K
> >>>>>> task_delay_info
> >>>>>>>>>
> >>>>>>>>>      43516  43471  99%    0.69K    946       46     30272K
> >>>>>> sock_inode_cache
> >>>>>>>>>
> >>>>>>>>>      37856  27626  72%    1.00K   1183       32     37856K
> >>> kmalloc-1024
> >>>>>>>>>
> >>>>>>>>>      36736  36736 100%    0.07K    656       56      2624K
> >>> eventpoll_pwq
> >>>>>>>>>
> >>>>>>>>>      34076  31282  91%    0.57K   1217       28     19472K
> >>>>>> radix_tree_node
> >>>>>>>>>
> >>>>>>>>>      33660  30528  90%    1.05K   1122       30     35904K
> >>>>>> ext4_inode_cache
> >>>>>>>>>
> >>>>>>>>>      32760  30959  94%    0.19K    780       42      6240K
> kmalloc-192
> >>>>>>>>>
> >>>>>>>>>      32028  32028 100%    0.04K    314      102      1256K
> >>>>>> ext4_extent_status
> >>>>>>>>>
> >>>>>>>>>      30048  30048 100%    0.25K    939       32      7512K
> >>>>>> skbuff_head_cache
> >>>>>>>>>
> >>>>>>>>>      28736  28736 100%    0.06K    449       64      1796K
> fs_cache
> >>>>>>>>>
> >>>>>>>>>      24702  24702 100%    0.69K    537       46     17184K
> files_cache
> >>>>>>>>>
> >>>>>>>>>      23808  23808 100%    0.66K    496       48     15872K
> ovl_inode
> >>>>>>>>>
> >>>>>>>>>      23104  22945  99%    0.12K    722       32      2888K
> kmalloc-128
> >>>>>>>>>
> >>>>>>>>>      22724  21307  93%    0.69K    494       46     15808K
> >>>>>> shmem_inode_cache
> >>>>>>>>>
> >>>>>>>>>      21472  21472 100%    0.12K    671       32      2684K
> seq_file
> >>>>>>>>>
> >>>>>>>>>      19904  19904 100%    1.00K    622       32     19904K UNIX
> >>>>>>>>>
> >>>>>>>>>      17340  17340 100%    1.06K    578       30     18496K
> mm_struct
> >>>>>>>>>
> >>>>>>>>>      15980  15980 100%    0.02K     94      170       376K
> avtab_node
> >>>>>>>>>
> >>>>>>>>>      14070  14070 100%    1.06K    469       30     15008K
> >>> signal_cache
> >>>>>>>>>
> >>>>>>>>>      13248  13248 100%    0.12K    414       32      1656K pid
> >>>>>>>>>
> >>>>>>>>>      12128  11777  97%    0.25K    379       32      3032K
> kmalloc-256
> >>>>>>>>>
> >>>>>>>>>      11008  11008 100%    0.02K     43      256       172K
> >>>>>>>>> selinux_file_security
> >>>>>>>>>      10812  10812 100%    0.04K    106      102       424K
> >>> Acpi-Namespace
> >>>>>>>>>
> >>>>>>>>> These information shows that the 'iommu_iova' is the top memory
> >>>>>> consumer.
> >>>>>>>>> In order to optimize the network performence of Openstack virtu=
al
> >>>>>> machines,
> >>>>>>>>> I enabled the vt-d feature in bios and sriov feature of Intel
> 82599
> >>>>>> 10G
> >>>>>>>>> NIC. I'm assuming this is the root cause of this issue.
> >>>>>>>>>
> >>>>>>>>> Is there anything I can do to fix it?
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> _______________________________________________
> >>>>>>> iommu mailing list
> >>>>>>> iommu@lists.linux-foundation.org
> >>>>>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>
> >>>
> >>
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >
>
>

--000000000000fdcb3005a41d98ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dear John:</div>=C2=A0 =C2=A0 Thank you for your repl=
y. The case you mentioned is a typical performance regression issue, there&=
#39;s no need for the kernel to oom kill any random process even in the wor=
st case. But in my observations, the iommu_iova slab could consume up to 40=
G memory, and the kernel have to kill my vm process to free memory (64G mem=
ory installed). So I don&#39;t think it&#39;s relevent.=C2=A0<div>=C2=A0 =
=C2=A0=C2=A0</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">John Garry &lt;<a href=3D"mailto:john.garry@huawei.com">j=
ohn.garry@huawei.com</a>&gt; =E4=BA=8E2020=E5=B9=B44=E6=9C=8825=E6=97=A5=E5=
=91=A8=E5=85=AD =E4=B8=8A=E5=8D=881:50=E5=86=99=E9=81=93=EF=BC=9A<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">On 24/04/2020 17:30, Robi=
n Murphy wrote:<br>
&gt; On 2020-04-24 2:20 pm, Bin wrote:<br>
&gt;&gt; Dear Robin:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Thank you for your explanation. Now, I u=
nderstand that this could be<br>
&gt;&gt; NIC driver&#39;s fault, but how could I confirm it? Do I have to d=
ebug the<br>
&gt;&gt; driver myself?<br>
&gt; <br>
&gt; I&#39;d start with CONFIG_DMA_API_DEBUG - of course it will chew throu=
gh<br>
&gt; memory about an order of magnitude faster than the IOVAs alone, but it=
<br>
&gt; should shed some light on whether DMA API usage looks suspicious, and<=
br>
&gt; dumping the mappings should help track down the responsible driver(s).=
<br>
&gt; Although the debugfs code doesn&#39;t show the stacktrace of where eac=
h<br>
&gt; mapping was made, I guess it would be fairly simple to tweak that for =
a<br>
&gt; quick way to narrow down where to start looking in an offending driver=
.<br>
&gt; <br>
&gt; Robin.<br>
<br>
Just mentioning this in case it&#39;s relevant - we found long term aging <=
br>
throughput test causes RB tree to grow very large (and would I assume <br>
eat lots of memory):<br>
<br>
<a href=3D"https://lore.kernel.org/linux-iommu/20190815121104.29140-3-thund=
er.leizhen@huawei.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.k=
ernel.org/linux-iommu/20190815121104.29140-3-thunder.leizhen@huawei.com/</a=
><br>
<br>
John<br>
<br>
&gt; <br>
&gt;&gt; Robin Murphy &lt;<a href=3D"mailto:robin.murphy@arm.com" target=3D=
"_blank">robin.murphy@arm.com</a>&gt; =E4=BA=8E2020=E5=B9=B44=E6=9C=8824=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:15=E5=86=99=E9=81=93=EF=BC=9A<=
br>
&gt;&gt;<br>
&gt;&gt;&gt; On 2020-04-24 1:06 pm, Bin wrote:<br>
&gt;&gt;&gt;&gt; I&#39;m not familiar with the mmu stuff, so what you mean =
by &quot;some driver<br>
&gt;&gt;&gt;&gt; leaking DMA mappings&quot;, is it possible that some other=
 kernel module like<br>
&gt;&gt;&gt;&gt; KVM or NIC driver leads to the leaking problem instead of =
the iommu<br>
&gt;&gt;&gt; module<br>
&gt;&gt;&gt;&gt; itself?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Yes - I doubt that intel-iommu itself is failing to free IOVAs=
 when it<br>
&gt;&gt;&gt; should, since I&#39;d expect a lot of people to have noticed t=
hat. It&#39;s far<br>
&gt;&gt;&gt; more likely that some driver is failing to call dma_unmap_* wh=
en it&#39;s<br>
&gt;&gt;&gt; finished with a buffer - with the IOMMU disabled that would be=
 a no-op<br>
&gt;&gt;&gt; on x86 with a modern 64-bit-capable device, so such a latent b=
ug could<br>
&gt;&gt;&gt; have been easily overlooked.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Robin.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Bin &lt;<a href=3D"mailto:anole1949@gmail.com" target=3D"_=
blank">anole1949@gmail.com</a>&gt; =E4=BA=8E 2020=E5=B9=B44=E6=9C=8824=E6=
=97=A5=E5=91=A8=E4=BA=94 20:00=E5=86=99=E9=81=93=EF=BC=9A<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Well, that&#39;s the problem! I&#39;m assuming the iom=
mu kernel module is<br>
&gt;&gt;&gt; leaking<br>
&gt;&gt;&gt;&gt;&gt; memory. But I don&#39;t know why and how.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Do you have any idea about it? Or any further informat=
ion is needed?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Robin Murphy &lt;<a href=3D"mailto:robin.murphy@arm.co=
m" target=3D"_blank">robin.murphy@arm.com</a>&gt; =E4=BA=8E 2020=E5=B9=B44=
=E6=9C=8824=E6=97=A5=E5=91=A8=E4=BA=94 19:20=E5=86=99=E9=81=93=EF=BC=9A<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; On 2020-04-24 1:40 am, Bin wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hello? anyone there?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Bin &lt;<a href=3D"mailto:anole1949@gmail.com"=
 target=3D"_blank">anole1949@gmail.com</a>&gt; =E4=BA=8E2020=E5=B9=B44=E6=
=9C=8823=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:14=E5=86=99=E9=81=
=93=EF=BC=9A<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Forget to mention, I&#39;ve already disabl=
ed the slab merge, so this is<br>
&gt;&gt;&gt;&gt;&gt;&gt; what<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; it is.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Bin &lt;<a href=3D"mailto:anole1949@gmail.=
com" target=3D"_blank">anole1949@gmail.com</a>&gt; =E4=BA=8E2020=E5=B9=B44=
=E6=9C=8823=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:11=E5=86=99=E9=
=81=93=EF=BC=9A<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hey, guys:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I&#39;m running a batch of CoreOS boxe=
s, the lsb_release is:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ```<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; # cat /etc/lsb-release<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; DISTRIB_ID=3D&quot;Container Linux by =
CoreOS&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; DISTRIB_RELEASE=3D2303.3.0<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; DISTRIB_CODENAME=3D&quot;Rhyolite&quot=
;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; DISTRIB_DESCRIPTION=3D&quot;Container =
Linux by CoreOS 2303.3.0 (Rhyolite)&quot;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ```<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ```<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; # uname -a<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Linux cloud-worker-25 4.19.86-coreos #=
1 SMP Mon Dec 2 20:13:38 -00<br>
&gt;&gt;&gt;&gt;&gt;&gt; 2019<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; x86_64 Intel(R) Xeon(R) CPU E5-2640 v2=
 @ 2.00GHz GenuineIntel<br>
&gt;&gt;&gt;&gt;&gt;&gt; GNU/Linux<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ```<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Recently, I found my vms constently be=
ing killed due to OOM, and<br>
&gt;&gt;&gt; after<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; digging into the problem, I finally re=
alized that the kernel is<br>
&gt;&gt;&gt;&gt;&gt;&gt; leaking<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; memory.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Here&#39;s my slabinfo:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 Active / Total Obj=
ects (% used)=C2=A0 =C2=A0 : 83818306 / 84191607 (99.6%)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 Active / Total Sla=
bs (% used)=C2=A0 =C2=A0 =C2=A0 : 1336293 / 1336293 (100.0%)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 Active / Total Cac=
hes (% used)=C2=A0 =C2=A0 =C2=A0: 152 / 217 (70.0%)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 Active / Total Siz=
e (% used)=C2=A0 =C2=A0 =C2=A0 =C2=A0: 5828768.08K / 5996848.72K<br>
&gt;&gt;&gt;&gt;&gt;&gt; (97.2%)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 Minimum / Average =
/ Maximum Object : 0.01K / 0.07K / 23.25K<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0OBJS ACTIVE=
=C2=A0 USE OBJ SIZE=C2=A0 SLABS OBJ/SLAB CACHE SIZE NAME<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 80253888 80253888 100%=C2=A0 =C2=A0 0.=
06K 1253967=C2=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0 =C2=A05015868K<br>
&gt;&gt;&gt; iommu_iova<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Do you really have a peak demand of ~80 million si=
multaneous DMA<br>
&gt;&gt;&gt;&gt;&gt;&gt; buffers, or is some driver leaking DMA mappings?<b=
r>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Robin.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 489472 489123=C2=A0 99%=C2=A0 =C2=A0 0=
.03K=C2=A0 =C2=A03824=C2=A0 =C2=A0 =C2=A0 128=C2=A0 =C2=A0 =C2=A015296K kma=
lloc-32<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 297444 271112=C2=A0 91%=C2=A0 =C2=A0 0=
.19K=C2=A0 =C2=A07082=C2=A0 =C2=A0 =C2=A0 =C2=A042=C2=A0 =C2=A0 =C2=A056656=
K dentry<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 254400 252784=C2=A0 99%=C2=A0 =C2=A0 0=
.06K=C2=A0 =C2=A03975=C2=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0 =C2=A0 =C2=A015900=
K<br>
&gt;&gt;&gt; anon_vma_chain<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 222528=C2=A0 39255=C2=A0 17%=C2=A0 =C2=
=A0 0.50K=C2=A0 =C2=A06954=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 111264=
K kmalloc-512<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 202482 201814=C2=A0 99%=C2=A0 =C2=A0 0=
.19K=C2=A0 =C2=A04821=C2=A0 =C2=A0 =C2=A0 =C2=A042=C2=A0 =C2=A0 =C2=A038568=
K<br>
&gt;&gt;&gt; vm_area_struct<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 200192 200192 100%=C2=A0 =C2=A0 0.01K=
=C2=A0 =C2=A0 391=C2=A0 =C2=A0 =C2=A0 512=C2=A0 =C2=A0 =C2=A0 1564K kmalloc=
-8<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 170528 169359=C2=A0 99%=C2=A0 =C2=A0 0=
.25K=C2=A0 =C2=A05329=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A042632=
K filp<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 158144 153508=C2=A0 97%=C2=A0 =C2=A0 0=
.06K=C2=A0 =C2=A02471=C2=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0 =C2=A0 =C2=A0 9884=
K kmalloc-64<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 149914 149365=C2=A0 99%=C2=A0 =C2=A0 0=
.09K=C2=A0 =C2=A03259=C2=A0 =C2=A0 =C2=A0 =C2=A046=C2=A0 =C2=A0 =C2=A013036=
K anon_vma<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 146640 143123=C2=A0 97%=C2=A0 =C2=A0 0=
.10K=C2=A0 =C2=A03760=C2=A0 =C2=A0 =C2=A0 =C2=A039=C2=A0 =C2=A0 =C2=A015040=
K buffer_head<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 130368=C2=A0 32791=C2=A0 25%=C2=A0 =C2=
=A0 0.09K=C2=A0 =C2=A03104=C2=A0 =C2=A0 =C2=A0 =C2=A042=C2=A0 =C2=A0 =C2=A0=
12416K kmalloc-96<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 129752 129752 100%=C2=A0 =C2=A0 0.07K=
=C2=A0 =C2=A02317=C2=A0 =C2=A0 =C2=A0 =C2=A056=C2=A0 =C2=A0 =C2=A0 9268K Ac=
pi-Operand<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 105468 105106=C2=A0 99%=C2=A0 =C2=A0 0=
.04K=C2=A0 =C2=A01034=C2=A0 =C2=A0 =C2=A0 102=C2=A0 =C2=A0 =C2=A0 4136K<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; selinux_inode_security<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 73080=C2=A0 73080 =
100%=C2=A0 =C2=A0 0.13K=C2=A0 =C2=A02436=C2=A0 =C2=A0 =C2=A0 =C2=A030=C2=A0=
 =C2=A0 =C2=A0 9744K<br>
&gt;&gt;&gt;&gt;&gt;&gt; kernfs_node_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 72360=C2=A0 70261=
=C2=A0 97%=C2=A0 =C2=A0 0.59K=C2=A0 =C2=A01340=C2=A0 =C2=A0 =C2=A0 =C2=A054=
=C2=A0 =C2=A0 =C2=A042880K inode_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 71040=C2=A0 71040 =
100%=C2=A0 =C2=A0 0.12K=C2=A0 =C2=A02220=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0=
 =C2=A0 =C2=A0 8880K<br>
&gt;&gt;&gt; eventpoll_epi<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 68096=C2=A0 59262=
=C2=A0 87%=C2=A0 =C2=A0 0.02K=C2=A0 =C2=A0 266=C2=A0 =C2=A0 =C2=A0 256=C2=
=A0 =C2=A0 =C2=A0 1064K kmalloc-16<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 53652=C2=A0 53652 =
100%=C2=A0 =C2=A0 0.04K=C2=A0 =C2=A0 526=C2=A0 =C2=A0 =C2=A0 102=C2=A0 =C2=
=A0 =C2=A0 2104K pde_opener<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 50496=C2=A0 31654=
=C2=A0 62%=C2=A0 =C2=A0 2.00K=C2=A0 =C2=A03156=C2=A0 =C2=A0 =C2=A0 =C2=A016=
=C2=A0 =C2=A0 100992K<br>
&gt;&gt;&gt; kmalloc-2048<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 46242=C2=A0 46242 =
100%=C2=A0 =C2=A0 0.19K=C2=A0 =C2=A01101=C2=A0 =C2=A0 =C2=A0 =C2=A042=C2=A0=
 =C2=A0 =C2=A0 8808K cred_jar<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 44496=C2=A0 43013=
=C2=A0 96%=C2=A0 =C2=A0 0.66K=C2=A0 =C2=A0 927=C2=A0 =C2=A0 =C2=A0 =C2=A048=
=C2=A0 =C2=A0 =C2=A029664K<br>
&gt;&gt;&gt;&gt;&gt;&gt; proc_inode_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 44352=C2=A0 44352 =
100%=C2=A0 =C2=A0 0.06K=C2=A0 =C2=A0 693=C2=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0=
 =C2=A0 =C2=A0 2772K<br>
&gt;&gt;&gt;&gt;&gt;&gt; task_delay_info<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 43516=C2=A0 43471=
=C2=A0 99%=C2=A0 =C2=A0 0.69K=C2=A0 =C2=A0 946=C2=A0 =C2=A0 =C2=A0 =C2=A046=
=C2=A0 =C2=A0 =C2=A030272K<br>
&gt;&gt;&gt;&gt;&gt;&gt; sock_inode_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 37856=C2=A0 27626=
=C2=A0 72%=C2=A0 =C2=A0 1.00K=C2=A0 =C2=A01183=C2=A0 =C2=A0 =C2=A0 =C2=A032=
=C2=A0 =C2=A0 =C2=A037856K<br>
&gt;&gt;&gt; kmalloc-1024<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 36736=C2=A0 36736 =
100%=C2=A0 =C2=A0 0.07K=C2=A0 =C2=A0 656=C2=A0 =C2=A0 =C2=A0 =C2=A056=C2=A0=
 =C2=A0 =C2=A0 2624K<br>
&gt;&gt;&gt; eventpoll_pwq<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 34076=C2=A0 31282=
=C2=A0 91%=C2=A0 =C2=A0 0.57K=C2=A0 =C2=A01217=C2=A0 =C2=A0 =C2=A0 =C2=A028=
=C2=A0 =C2=A0 =C2=A019472K<br>
&gt;&gt;&gt;&gt;&gt;&gt; radix_tree_node<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 33660=C2=A0 30528=
=C2=A0 90%=C2=A0 =C2=A0 1.05K=C2=A0 =C2=A01122=C2=A0 =C2=A0 =C2=A0 =C2=A030=
=C2=A0 =C2=A0 =C2=A035904K<br>
&gt;&gt;&gt;&gt;&gt;&gt; ext4_inode_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 32760=C2=A0 30959=
=C2=A0 94%=C2=A0 =C2=A0 0.19K=C2=A0 =C2=A0 780=C2=A0 =C2=A0 =C2=A0 =C2=A042=
=C2=A0 =C2=A0 =C2=A0 6240K kmalloc-192<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 32028=C2=A0 32028 =
100%=C2=A0 =C2=A0 0.04K=C2=A0 =C2=A0 314=C2=A0 =C2=A0 =C2=A0 102=C2=A0 =C2=
=A0 =C2=A0 1256K<br>
&gt;&gt;&gt;&gt;&gt;&gt; ext4_extent_status<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 30048=C2=A0 30048 =
100%=C2=A0 =C2=A0 0.25K=C2=A0 =C2=A0 939=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0=
 =C2=A0 =C2=A0 7512K<br>
&gt;&gt;&gt;&gt;&gt;&gt; skbuff_head_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 28736=C2=A0 28736 =
100%=C2=A0 =C2=A0 0.06K=C2=A0 =C2=A0 449=C2=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0=
 =C2=A0 =C2=A0 1796K fs_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 24702=C2=A0 24702 =
100%=C2=A0 =C2=A0 0.69K=C2=A0 =C2=A0 537=C2=A0 =C2=A0 =C2=A0 =C2=A046=C2=A0=
 =C2=A0 =C2=A017184K files_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 23808=C2=A0 23808 =
100%=C2=A0 =C2=A0 0.66K=C2=A0 =C2=A0 496=C2=A0 =C2=A0 =C2=A0 =C2=A048=C2=A0=
 =C2=A0 =C2=A015872K ovl_inode<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 23104=C2=A0 22945=
=C2=A0 99%=C2=A0 =C2=A0 0.12K=C2=A0 =C2=A0 722=C2=A0 =C2=A0 =C2=A0 =C2=A032=
=C2=A0 =C2=A0 =C2=A0 2888K kmalloc-128<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 22724=C2=A0 21307=
=C2=A0 93%=C2=A0 =C2=A0 0.69K=C2=A0 =C2=A0 494=C2=A0 =C2=A0 =C2=A0 =C2=A046=
=C2=A0 =C2=A0 =C2=A015808K<br>
&gt;&gt;&gt;&gt;&gt;&gt; shmem_inode_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 21472=C2=A0 21472 =
100%=C2=A0 =C2=A0 0.12K=C2=A0 =C2=A0 671=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0=
 =C2=A0 =C2=A0 2684K seq_file<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 19904=C2=A0 19904 =
100%=C2=A0 =C2=A0 1.00K=C2=A0 =C2=A0 622=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0=
 =C2=A0 =C2=A019904K UNIX<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 17340=C2=A0 17340 =
100%=C2=A0 =C2=A0 1.06K=C2=A0 =C2=A0 578=C2=A0 =C2=A0 =C2=A0 =C2=A030=C2=A0=
 =C2=A0 =C2=A018496K mm_struct<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 15980=C2=A0 15980 =
100%=C2=A0 =C2=A0 0.02K=C2=A0 =C2=A0 =C2=A094=C2=A0 =C2=A0 =C2=A0 170=C2=A0=
 =C2=A0 =C2=A0 =C2=A0376K avtab_node<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 14070=C2=A0 14070 =
100%=C2=A0 =C2=A0 1.06K=C2=A0 =C2=A0 469=C2=A0 =C2=A0 =C2=A0 =C2=A030=C2=A0=
 =C2=A0 =C2=A015008K<br>
&gt;&gt;&gt; signal_cache<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 13248=C2=A0 13248 =
100%=C2=A0 =C2=A0 0.12K=C2=A0 =C2=A0 414=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0=
 =C2=A0 =C2=A0 1656K pid<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 12128=C2=A0 11777=
=C2=A0 97%=C2=A0 =C2=A0 0.25K=C2=A0 =C2=A0 379=C2=A0 =C2=A0 =C2=A0 =C2=A032=
=C2=A0 =C2=A0 =C2=A0 3032K kmalloc-256<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 11008=C2=A0 11008 =
100%=C2=A0 =C2=A0 0.02K=C2=A0 =C2=A0 =C2=A043=C2=A0 =C2=A0 =C2=A0 256=C2=A0=
 =C2=A0 =C2=A0 =C2=A0172K<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; selinux_file_security<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 10812=C2=A0 10812 =
100%=C2=A0 =C2=A0 0.04K=C2=A0 =C2=A0 106=C2=A0 =C2=A0 =C2=A0 102=C2=A0 =C2=
=A0 =C2=A0 =C2=A0424K<br>
&gt;&gt;&gt; Acpi-Namespace<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; These information shows that the &#39;=
iommu_iova&#39; is the top memory<br>
&gt;&gt;&gt;&gt;&gt;&gt; consumer.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; In order to optimize the network perfo=
rmence of Openstack virtual<br>
&gt;&gt;&gt;&gt;&gt;&gt; machines,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I enabled the vt-d feature in bios and=
 sriov feature of Intel 82599<br>
&gt;&gt;&gt;&gt;&gt;&gt; 10G<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; NIC. I&#39;m assuming this is the root=
 cause of this issue.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Is there anything I can do to fix it?<=
br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; ______________________________________________=
_<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; iommu mailing list<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:iommu@lists.linux-foundation=
.org" target=3D"_blank">iommu@lists.linux-foundation.org</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://lists.linuxfoundation.org/m=
ailman/listinfo/iommu" rel=3D"noreferrer" target=3D"_blank">https://lists.l=
inuxfoundation.org/mailman/listinfo/iommu</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt; _______________________________________________<br>
&gt; iommu mailing list<br>
&gt; <a href=3D"mailto:iommu@lists.linux-foundation.org" target=3D"_blank">=
iommu@lists.linux-foundation.org</a><br>
&gt; <a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/iommu" r=
el=3D"noreferrer" target=3D"_blank">https://lists.linuxfoundation.org/mailm=
an/listinfo/iommu</a><br>
&gt; <br>
<br>
</blockquote></div>

--000000000000fdcb3005a41d98ab--

--===============2299515908338449236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2299515908338449236==--
