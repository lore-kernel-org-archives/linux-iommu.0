Return-Path: <SRS0=AFVC=6N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47519C83003
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 04:14:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0488E20731
	for <iommu@archiver.kernel.org>; Wed, 29 Apr 2020 04:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVTFvtDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0488E20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BA09122BCC;
	Wed, 29 Apr 2020 04:13:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ye7GjkarHdR1; Wed, 29 Apr 2020 04:13:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A0C1522B7A;
	Wed, 29 Apr 2020 04:13:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AECCC0864;
	Wed, 29 Apr 2020 04:13:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA9BFC0172
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 04:13:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BC272882EC
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 04:13:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ok8mVZfP4mkW for <iommu@lists.linux-foundation.org>;
 Wed, 29 Apr 2020 04:13:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 67A75882EB
 for <iommu@lists.linux-foundation.org>; Wed, 29 Apr 2020 04:13:53 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id v8so3879802wma.0
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 21:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8NkAqPFWx3iWq50L/xVyjo7ChIGiFobHs9RmC7hTus4=;
 b=XVTFvtDIlkWXh54OHbhLYtuIbqdvrlRRDJI8L/A/AsRPRgpZntiBK0zw5/TvwuiMXm
 7UT5VLFvpKlq4/7Rr+5ak1JkDPRqg/3x9Mafq0ZU+hLUsK4AggYm+oVjNVPja/5BHEqK
 4lzJzSzm99rOK0cuqtyQMadZk5ZpVJaWpMH6O6Le6UPM4YXBNFgmjvEf7vxi0kEukWJl
 HSPBuZcrEq0vWXpjNgxOVXARO0ejwaDNb6QViHxsREzq9ichdFhYT3gHhtx3vqax388+
 s3/bT5PtV0HB+Vnv8MYY7H7aNvUqseN2at03cwdM1pQ2yI1Hg8+1E5PbHhB6waCaeRKz
 l4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8NkAqPFWx3iWq50L/xVyjo7ChIGiFobHs9RmC7hTus4=;
 b=IW2KIogpjGqSlMldTbeKa3F+mScauOlupOGEQZlQFToR85uhkynHo9HCkiwQbsMfW5
 N0+3nUg3WWvTJdzv/fhl1WyY1EjSL4Rq4VTNgXdVNewfK0eN5L8Rbuy2F9OtfSJf4Gmv
 uBC35DXEkcTAV57QDqtyFBp7ngdYOk4+aB926miS6nHPCLkyNJWYR89ZR/bZTmF5KPdb
 o1nFwLt80mJb3S4oSY+VQfMuvE+bL1bGvUKJwAVGn6wjuaqsyvPVkGgeFWtXmxDEdvt/
 6zqlhWcjNiJe8YSFXymmr/eQqd44HoEr9DWh939VHT81r9MpbqvuMvCwbKAZeqKyvXhq
 Od5g==
X-Gm-Message-State: AGi0PuavZiCfAZyBIgrXECtvKiMAMlcPIGgQA4nRVRMARq5NoSOcEnSD
 oN92pFeCMO6NJbVPziy8KbWvCk28cjbhZRHbTdo=
X-Google-Smtp-Source: APiQypL7AWLZlmIBMa3amp/QzQL9M/Nf4zde+7PwC466c7J+BXXGpoYFQ8ZRHLoGEFyzg6blh88L6ArTxb7OWLO9IWA=
X-Received: by 2002:a1c:9c15:: with SMTP id f21mr790250wme.139.1588133631499; 
 Tue, 28 Apr 2020 21:13:51 -0700 (PDT)
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
 <35ec5bbb53c4453f9673c4ba6731b080@huawei.com>
In-Reply-To: <35ec5bbb53c4453f9673c4ba6731b080@huawei.com>
From: Bin <anole1949@gmail.com>
Date: Wed, 29 Apr 2020 12:13:39 +0800
Message-ID: <CAEbUFv4cg_Nm9b8bR8O6M+9wOmLH88_NtaWMv18RObw=MKx85A@mail.gmail.com>
Subject: Re: iommu_iova slab eats too much memory
To: Salil Mehta <salil.mehta@huawei.com>
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
Content-Type: multipart/mixed; boundary="===============7028745220828623402=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============7028745220828623402==
Content-Type: multipart/alternative; boundary="000000000000f623af05a4662c5e"

--000000000000f623af05a4662c5e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shlil:

Thank you for your attention, and these are my answers:

1. I don't really understand what you're saying. What's the difference
between DMA buffer and DMA mapping?
It's like a memory block pool and a memory block or something like that?
2. Yes, the TSO is enabled all the time, but it seems not helping.
3. The CPU usage is pretty normal, and what's the point of this question?
Is it relevant to the leaking problem?

FYI:
I found an interesting phenomenon that it's just a small part of the
running hosts has this issue, even though they all
have the same kernel, configuration and hardwares, I don't know if this
really mean something.


Salil Mehta <salil.mehta@huawei.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:17=E5=86=99=E9=81=93=EF=BC=9A

> Hi Bin,
>
> Few questions:
>
> 1. If there is a leak of IOVA due to dma_unmap_* not being called
> somewhere then
> at certain point the throughput will drastically fall and will almost
> become equal
> to zero. This should be due to unavailability of the mapping anymore. But
> in your
> case VM is getting killed so this could be actual DMA buffer leak not DMA
> mapping
> leak. I doubt VM will get killed due to exhaustion of the DMA mappings in
> the IOMMU
> Layer for a transient reason or even due to mapping/unmapping leak.
>
> 2. Could you check if you have TSO offload enabled on Intel 82599? It wil=
l
> help
> in reducing the number of mappings and will take off IOVA mapping pressur=
e
> from
> the IOMMU/VT-d? Though I am not sure it will help in reducing the amount
> of memory
> required for the buffers.
>
> 3. Also, have you checked the cpu-usage while your experiment is going on=
?
>
> Thanks
> Salil.
>
> > -----Original Message-----
> > From: iommu [mailto:iommu-bounces@lists.linux-foundation.org] On Behalf
> Of
> > Robin Murphy
> > Sent: Friday, April 24, 2020 5:31 PM
> > To: Bin <anole1949@gmail.com>
> > Cc: iommu@lists.linux-foundation.org
> > Subject: Re: iommu_iova slab eats too much memory
> >
> > On 2020-04-24 2:20 pm, Bin wrote:
> > > Dear Robin:
> > >      Thank you for your explanation. Now, I understand that this coul=
d
> be
> > > NIC driver's fault, but how could I confirm it? Do I have to debug th=
e
> > > driver myself?
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
> >
> > > Robin Murphy <robin.murphy@arm.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=882=
4=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:15=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > >> On 2020-04-24 1:06 pm, Bin wrote:
> > >>> I'm not familiar with the mmu stuff, so what you mean by "some driv=
er
> > >>> leaking DMA mappings", is it possible that some other kernel module
> like
> > >>> KVM or NIC driver leads to the leaking problem instead of the iommu
> > >> module
> > >>> itself?
> > >>
> > >> Yes - I doubt that intel-iommu itself is failing to free IOVAs when =
it
> > >> should, since I'd expect a lot of people to have noticed that. It's
> far
> > >> more likely that some driver is failing to call dma_unmap_* when it'=
s
> > >> finished with a buffer - with the IOMMU disabled that would be a no-=
op
> > >> on x86 with a modern 64-bit-capable device, so such a latent bug cou=
ld
> > >> have been easily overlooked.
> > >>
> > >> Robin.
> > >>
> > >>> Bin <anole1949@gmail.com> =E4=BA=8E 2020=E5=B9=B44=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=BA=94 20:00=E5=86=99=E9=81=93=EF=BC=9A
> > >>>
> > >>>> Well, that's the problem! I'm assuming the iommu kernel module is
> > >> leaking
> > >>>> memory. But I don't know why and how.
> > >>>>
> > >>>> Do you have any idea about it? Or any further information is neede=
d?
> > >>>>
> > >>>> Robin Murphy <robin.murphy@arm.com> =E4=BA=8E 2020=E5=B9=B44=E6=9C=
=8824=E6=97=A5=E5=91=A8=E4=BA=94 19:20=E5=86=99=E9=81=93=EF=BC=9A
> > >>>>
> > >>>>> On 2020-04-24 1:40 am, Bin wrote:
> > >>>>>> Hello? anyone there?
> > >>>>>>
> > >>>>>> Bin <anole1949@gmail.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8823=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:14=E5=86=99=E9=81=93=EF=BC=9A
> > >>>>>>
> > >>>>>>> Forget to mention, I've already disabled the slab merge, so thi=
s
> is
> > >>>>> what
> > >>>>>>> it is.
> > >>>>>>>
> > >>>>>>> Bin <anole1949@gmail.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8823=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:11=E5=86=99=E9=81=93=EF=BC=9A
> > >>>>>>>
> > >>>>>>>> Hey, guys:
> > >>>>>>>>
> > >>>>>>>> I'm running a batch of CoreOS boxes, the lsb_release is:
> > >>>>>>>>
> > >>>>>>>> ```
> > >>>>>>>> # cat /etc/lsb-release
> > >>>>>>>> DISTRIB_ID=3D"Container Linux by CoreOS"
> > >>>>>>>> DISTRIB_RELEASE=3D2303.3.0
> > >>>>>>>> DISTRIB_CODENAME=3D"Rhyolite"
> > >>>>>>>> DISTRIB_DESCRIPTION=3D"Container Linux by CoreOS 2303.3.0
> (Rhyolite)"
> > >>>>>>>> ```
> > >>>>>>>>
> > >>>>>>>> ```
> > >>>>>>>> # uname -a
> > >>>>>>>> Linux cloud-worker-25 4.19.86-coreos #1 SMP Mon Dec 2 20:13:38
> -00
> > >>>>> 2019
> > >>>>>>>> x86_64 Intel(R) Xeon(R) CPU E5-2640 v2 @ 2.00GHz GenuineIntel
> > >>>>> GNU/Linux
> > >>>>>>>> ```
> > >>>>>>>> Recently, I found my vms constently being killed due to OOM, a=
nd
> > >> after
> > >>>>>>>> digging into the problem, I finally realized that the kernel i=
s
> > >>>>> leaking
> > >>>>>>>> memory.
> > >>>>>>>>
> > >>>>>>>> Here's my slabinfo:
> > >>>>>>>>
> > >>>>>>>>     Active / Total Objects (% used)    : 83818306 / 84191607
> (99.6%)
> > >>>>>>>>     Active / Total Slabs (% used)      : 1336293 / 1336293
> (100.0%)
> > >>>>>>>>     Active / Total Caches (% used)     : 152 / 217 (70.0%)
> > >>>>>>>>     Active / Total Size (% used)       : 5828768.08K /
> 5996848.72K
> > >>>>> (97.2%)
> > >>>>>>>>     Minimum / Average / Maximum Object : 0.01K / 0.07K / 23.25=
K
> > >>>>>>>>
> > >>>>>>>>      OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> > >>>>>>>>
> > >>>>>>>> 80253888 80253888 100%    0.06K 1253967       64   5015868K
> > >> iommu_iova
> > >>>>>
> > >>>>> Do you really have a peak demand of ~80 million simultaneous DMA
> > >>>>> buffers, or is some driver leaking DMA mappings?
> > >>>>>
> > >>>>> Robin.
> > >>>>>
> > >>>>>>>> 489472 489123  99%    0.03K   3824      128     15296K
> kmalloc-32
> > >>>>>>>>
> > >>>>>>>> 297444 271112  91%    0.19K   7082       42     56656K dentry
> > >>>>>>>>
> > >>>>>>>> 254400 252784  99%    0.06K   3975       64     15900K
> > >> anon_vma_chain
> > >>>>>>>>
> > >>>>>>>> 222528  39255  17%    0.50K   6954       32    111264K
> kmalloc-512
> > >>>>>>>>
> > >>>>>>>> 202482 201814  99%    0.19K   4821       42     38568K
> > >> vm_area_struct
> > >>>>>>>>
> > >>>>>>>> 200192 200192 100%    0.01K    391      512      1564K kmalloc=
-8
> > >>>>>>>>
> > >>>>>>>> 170528 169359  99%    0.25K   5329       32     42632K filp
> > >>>>>>>>
> > >>>>>>>> 158144 153508  97%    0.06K   2471       64      9884K
> kmalloc-64
> > >>>>>>>>
> > >>>>>>>> 149914 149365  99%    0.09K   3259       46     13036K anon_vm=
a
> > >>>>>>>>
> > >>>>>>>> 146640 143123  97%    0.10K   3760       39     15040K
> buffer_head
> > >>>>>>>>
> > >>>>>>>> 130368  32791  25%    0.09K   3104       42     12416K
> kmalloc-96
> > >>>>>>>>
> > >>>>>>>> 129752 129752 100%    0.07K   2317       56      9268K
> Acpi-Operand
> > >>>>>>>>
> > >>>>>>>> 105468 105106  99%    0.04K   1034      102      4136K
> > >>>>>>>> selinux_inode_security
> > >>>>>>>>     73080  73080 100%    0.13K   2436       30      9744K
> > >>>>> kernfs_node_cache
> > >>>>>>>>
> > >>>>>>>>     72360  70261  97%    0.59K   1340       54     42880K
> inode_cache
> > >>>>>>>>
> > >>>>>>>>     71040  71040 100%    0.12K   2220       32      8880K
> > >> eventpoll_epi
> > >>>>>>>>
> > >>>>>>>>     68096  59262  87%    0.02K    266      256      1064K
> kmalloc-16
> > >>>>>>>>
> > >>>>>>>>     53652  53652 100%    0.04K    526      102      2104K
> pde_opener
> > >>>>>>>>
> > >>>>>>>>     50496  31654  62%    2.00K   3156       16    100992K
> > >> kmalloc-2048
> > >>>>>>>>
> > >>>>>>>>     46242  46242 100%    0.19K   1101       42      8808K
> cred_jar
> > >>>>>>>>
> > >>>>>>>>     44496  43013  96%    0.66K    927       48     29664K
> > >>>>> proc_inode_cache
> > >>>>>>>>
> > >>>>>>>>     44352  44352 100%    0.06K    693       64      2772K
> > >>>>> task_delay_info
> > >>>>>>>>
> > >>>>>>>>     43516  43471  99%    0.69K    946       46     30272K
> > >>>>> sock_inode_cache
> > >>>>>>>>
> > >>>>>>>>     37856  27626  72%    1.00K   1183       32     37856K
> > >> kmalloc-1024
> > >>>>>>>>
> > >>>>>>>>     36736  36736 100%    0.07K    656       56      2624K
> > >> eventpoll_pwq
> > >>>>>>>>
> > >>>>>>>>     34076  31282  91%    0.57K   1217       28     19472K
> > >>>>> radix_tree_node
> > >>>>>>>>
> > >>>>>>>>     33660  30528  90%    1.05K   1122       30     35904K
> > >>>>> ext4_inode_cache
> > >>>>>>>>
> > >>>>>>>>     32760  30959  94%    0.19K    780       42      6240K
> kmalloc-192
> > >>>>>>>>
> > >>>>>>>>     32028  32028 100%    0.04K    314      102      1256K
> > >>>>> ext4_extent_status
> > >>>>>>>>
> > >>>>>>>>     30048  30048 100%    0.25K    939       32      7512K
> > >>>>> skbuff_head_cache
> > >>>>>>>>
> > >>>>>>>>     28736  28736 100%    0.06K    449       64      1796K
> fs_cache
> > >>>>>>>>
> > >>>>>>>>     24702  24702 100%    0.69K    537       46     17184K
> files_cache
> > >>>>>>>>
> > >>>>>>>>     23808  23808 100%    0.66K    496       48     15872K
> ovl_inode
> > >>>>>>>>
> > >>>>>>>>     23104  22945  99%    0.12K    722       32      2888K
> kmalloc-128
> > >>>>>>>>
> > >>>>>>>>     22724  21307  93%    0.69K    494       46     15808K
> > >>>>> shmem_inode_cache
> > >>>>>>>>
> > >>>>>>>>     21472  21472 100%    0.12K    671       32      2684K
> seq_file
> > >>>>>>>>
> > >>>>>>>>     19904  19904 100%    1.00K    622       32     19904K UNIX
> > >>>>>>>>
> > >>>>>>>>     17340  17340 100%    1.06K    578       30     18496K
> mm_struct
> > >>>>>>>>
> > >>>>>>>>     15980  15980 100%    0.02K     94      170       376K
> avtab_node
> > >>>>>>>>
> > >>>>>>>>     14070  14070 100%    1.06K    469       30     15008K
> > >> signal_cache
> > >>>>>>>>
> > >>>>>>>>     13248  13248 100%    0.12K    414       32      1656K pid
> > >>>>>>>>
> > >>>>>>>>     12128  11777  97%    0.25K    379       32      3032K
> kmalloc-256
> > >>>>>>>>
> > >>>>>>>>     11008  11008 100%    0.02K     43      256       172K
> > >>>>>>>> selinux_file_security
> > >>>>>>>>     10812  10812 100%    0.04K    106      102       424K
> > >> Acpi-Namespace
> > >>>>>>>>
> > >>>>>>>> These information shows that the 'iommu_iova' is the top memor=
y
> > >>>>> consumer.
> > >>>>>>>> In order to optimize the network performence of Openstack
> virtual
> > >>>>> machines,
> > >>>>>>>> I enabled the vt-d feature in bios and sriov feature of Intel
> 82599
> > >>>>> 10G
> > >>>>>>>> NIC. I'm assuming this is the root cause of this issue.
> > >>>>>>>>
> > >>>>>>>> Is there anything I can do to fix it?
> > >>>>>>>>
> > >>>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>> _______________________________________________
> > >>>>>> iommu mailing list
> > >>>>>> iommu@lists.linux-foundation.org
> > >>>>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> > >>>>>>
> > >>>>>
> > >>>>
> > >>>
> > >>
> > >
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

--000000000000f623af05a4662c5e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi <span class=3D"" id=3D":1nr.6" tabindex=3D"-1" style=3D=
"">Shlil</span>:<div><br></div><div>Thank you for your attention, and these=
 are my answers:</div><div><br></div><div>1. I don&#39;t really understand =
what you&#39;re saying. What&#39;s the difference between <span class=3D"" =
id=3D":1nr.8" tabindex=3D"-1" style=3D"">DMA</span> buffer and <span class=
=3D"" id=3D":1nr.9" tabindex=3D"-1" style=3D"">DMA</span> mapping?=C2=A0</d=
iv><div>It&#39;s like a memory block pool and a memory block or something l=
ike that?=C2=A0</div><div>2. Yes, the <span class=3D"" id=3D":1nr.10" tabin=
dex=3D"-1" style=3D"">TSO</span> is enabled all the time, but it seems not =
helping.</div><div>3. The CPU usage is pretty normal, and what&#39;s the po=
int of this question? Is it relevant=C2=A0to the leaking problem?</div><div=
><br></div><div>FYI:</div><div>I found an interesting=C2=A0phenomenon=C2=A0=
that it&#39;s just a small part of the running hosts has this issue, even t=
hough they all=C2=A0</div><div>have the same kernel, configuration and hard=
wares, I don&#39;t know if this really mean something.</div><div><br></div>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
Salil Mehta &lt;<a href=3D"mailto:salil.mehta@huawei.com">salil.mehta@huawe=
i.com</a>&gt; =E4=BA=8E2020=E5=B9=B44=E6=9C=8828=E6=97=A5=E5=91=A8=E4=BA=8C=
 =E4=B8=8B=E5=8D=885:17=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Hi Bin,<br>
<br>
Few questions:<br>
<br>
1. If there is a leak of IOVA due to dma_unmap_* not being called somewhere=
 then<br>
at certain point the throughput will drastically fall and will almost becom=
e equal<br>
to zero. This should be due to unavailability of the mapping anymore. But i=
n your<br>
case VM is getting killed so this could be actual DMA buffer leak not DMA m=
apping<br>
leak. I doubt VM will get killed due to exhaustion of the DMA mappings in t=
he IOMMU<br>
Layer for a transient reason or even due to mapping/unmapping leak.<br>
<br>
2. Could you check if you have TSO offload enabled on Intel 82599? It will =
help<br>
in reducing the number of mappings and will take off IOVA mapping pressure =
from<br>
the IOMMU/VT-d? Though I am not sure it will help in reducing the amount of=
 memory<br>
required for the buffers.<br>
<br>
3. Also, have you checked the cpu-usage while your experiment is going on?<=
br>
<br>
Thanks<br>
Salil.<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: iommu [mailto:<a href=3D"mailto:iommu-bounces@lists.linux-founda=
tion.org" target=3D"_blank">iommu-bounces@lists.linux-foundation.org</a>] O=
n Behalf Of<br>
&gt; Robin Murphy<br>
&gt; Sent: Friday, April 24, 2020 5:31 PM<br>
&gt; To: Bin &lt;<a href=3D"mailto:anole1949@gmail.com" target=3D"_blank">a=
nole1949@gmail.com</a>&gt;<br>
&gt; Cc: <a href=3D"mailto:iommu@lists.linux-foundation.org" target=3D"_bla=
nk">iommu@lists.linux-foundation.org</a><br>
&gt; Subject: Re: iommu_iova slab eats too much memory<br>
&gt; <br>
&gt; On 2020-04-24 2:20 pm, Bin wrote:<br>
&gt; &gt; Dear Robin:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Thank you for your explanation. Now, I unders=
tand that this could be<br>
&gt; &gt; NIC driver&#39;s fault, but how could I confirm it? Do I have to =
debug the<br>
&gt; &gt; driver myself?<br>
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
&gt; <br>
&gt; &gt; Robin Murphy &lt;<a href=3D"mailto:robin.murphy@arm.com" target=
=3D"_blank">robin.murphy@arm.com</a>&gt; =E4=BA=8E2020=E5=B9=B44=E6=9C=8824=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:15=E5=86=99=E9=81=93=EF=BC=
=9A<br>
&gt; &gt;<br>
&gt; &gt;&gt; On 2020-04-24 1:06 pm, Bin wrote:<br>
&gt; &gt;&gt;&gt; I&#39;m not familiar with the mmu stuff, so what you mean=
 by &quot;some driver<br>
&gt; &gt;&gt;&gt; leaking DMA mappings&quot;, is it possible that some othe=
r kernel module like<br>
&gt; &gt;&gt;&gt; KVM or NIC driver leads to the leaking problem instead of=
 the iommu<br>
&gt; &gt;&gt; module<br>
&gt; &gt;&gt;&gt; itself?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Yes - I doubt that intel-iommu itself is failing to free IOVA=
s when it<br>
&gt; &gt;&gt; should, since I&#39;d expect a lot of people to have noticed =
that. It&#39;s far<br>
&gt; &gt;&gt; more likely that some driver is failing to call dma_unmap_* w=
hen it&#39;s<br>
&gt; &gt;&gt; finished with a buffer - with the IOMMU disabled that would b=
e a no-op<br>
&gt; &gt;&gt; on x86 with a modern 64-bit-capable device, so such a latent =
bug could<br>
&gt; &gt;&gt; have been easily overlooked.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Robin.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; Bin &lt;<a href=3D"mailto:anole1949@gmail.com" target=3D"=
_blank">anole1949@gmail.com</a>&gt; =E4=BA=8E 2020=E5=B9=B44=E6=9C=8824=E6=
=97=A5=E5=91=A8=E4=BA=94 20:00=E5=86=99=E9=81=93=EF=BC=9A<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Well, that&#39;s the problem! I&#39;m assuming the io=
mmu kernel module is<br>
&gt; &gt;&gt; leaking<br>
&gt; &gt;&gt;&gt;&gt; memory. But I don&#39;t know why and how.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Do you have any idea about it? Or any further informa=
tion is needed?<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Robin Murphy &lt;<a href=3D"mailto:robin.murphy@arm.c=
om" target=3D"_blank">robin.murphy@arm.com</a>&gt; =E4=BA=8E 2020=E5=B9=B44=
=E6=9C=8824=E6=97=A5=E5=91=A8=E4=BA=94 19:20=E5=86=99=E9=81=93=EF=BC=9A<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; On 2020-04-24 1:40 am, Bin wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Hello? anyone there?<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Bin &lt;<a href=3D"mailto:anole1949@gmail.com=
" target=3D"_blank">anole1949@gmail.com</a>&gt; =E4=BA=8E2020=E5=B9=B44=E6=
=9C=8823=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:14=E5=86=99=E9=81=
=93=EF=BC=9A<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; Forget to mention, I&#39;ve already disab=
led the slab merge, so this is<br>
&gt; &gt;&gt;&gt;&gt;&gt; what<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; it is.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt; Bin &lt;<a href=3D"mailto:anole1949@gmail=
.com" target=3D"_blank">anole1949@gmail.com</a>&gt; =E4=BA=8E2020=E5=B9=B44=
=E6=9C=8823=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:11=E5=86=99=E9=
=81=93=EF=BC=9A<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hey, guys:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I&#39;m running a batch of CoreOS box=
es, the lsb_release is:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ```<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; # cat /etc/lsb-release<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; DISTRIB_ID=3D&quot;Container Linux by=
 CoreOS&quot;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; DISTRIB_RELEASE=3D2303.3.0<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; DISTRIB_CODENAME=3D&quot;Rhyolite&quo=
t;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; DISTRIB_DESCRIPTION=3D&quot;Container=
 Linux by CoreOS 2303.3.0 (Rhyolite)&quot;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ```<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ```<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; # uname -a<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Linux cloud-worker-25 4.19.86-coreos =
#1 SMP Mon Dec 2 20:13:38 -00<br>
&gt; &gt;&gt;&gt;&gt;&gt; 2019<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; x86_64 Intel(R) Xeon(R) CPU E5-2640 v=
2 @ 2.00GHz GenuineIntel<br>
&gt; &gt;&gt;&gt;&gt;&gt; GNU/Linux<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; ```<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Recently, I found my vms constently b=
eing killed due to OOM, and<br>
&gt; &gt;&gt; after<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; digging into the problem, I finally r=
ealized that the kernel is<br>
&gt; &gt;&gt;&gt;&gt;&gt; leaking<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; memory.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Here&#39;s my slabinfo:<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Active / Total Obj=
ects (% used)=C2=A0 =C2=A0 : 83818306 / 84191607 (99.6%)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Active / Total Sla=
bs (% used)=C2=A0 =C2=A0 =C2=A0 : 1336293 / 1336293 (100.0%)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Active / Total Cac=
hes (% used)=C2=A0 =C2=A0 =C2=A0: 152 / 217 (70.0%)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Active / Total Siz=
e (% used)=C2=A0 =C2=A0 =C2=A0 =C2=A0: 5828768.08K / 5996848.72K<br>
&gt; &gt;&gt;&gt;&gt;&gt; (97.2%)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0Minimum / Average =
/ Maximum Object : 0.01K / 0.07K / 23.25K<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 OBJS ACTIVE=C2=A0=
 USE OBJ SIZE=C2=A0 SLABS OBJ/SLAB CACHE SIZE NAME<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 80253888 80253888 100%=C2=A0 =C2=A0 0=
.06K 1253967=C2=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0 =C2=A05015868K<br>
&gt; &gt;&gt; iommu_iova<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Do you really have a peak demand of ~80 million s=
imultaneous DMA<br>
&gt; &gt;&gt;&gt;&gt;&gt; buffers, or is some driver leaking DMA mappings?<=
br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Robin.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 489472 489123=C2=A0 99%=C2=A0 =C2=A0 =
0.03K=C2=A0 =C2=A03824=C2=A0 =C2=A0 =C2=A0 128=C2=A0 =C2=A0 =C2=A015296K km=
alloc-32<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 297444 271112=C2=A0 91%=C2=A0 =C2=A0 =
0.19K=C2=A0 =C2=A07082=C2=A0 =C2=A0 =C2=A0 =C2=A042=C2=A0 =C2=A0 =C2=A05665=
6K dentry<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 254400 252784=C2=A0 99%=C2=A0 =C2=A0 =
0.06K=C2=A0 =C2=A03975=C2=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0 =C2=A0 =C2=A01590=
0K<br>
&gt; &gt;&gt; anon_vma_chain<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 222528=C2=A0 39255=C2=A0 17%=C2=A0 =
=C2=A0 0.50K=C2=A0 =C2=A06954=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 111=
264K kmalloc-512<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 202482 201814=C2=A0 99%=C2=A0 =C2=A0 =
0.19K=C2=A0 =C2=A04821=C2=A0 =C2=A0 =C2=A0 =C2=A042=C2=A0 =C2=A0 =C2=A03856=
8K<br>
&gt; &gt;&gt; vm_area_struct<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 200192 200192 100%=C2=A0 =C2=A0 0.01K=
=C2=A0 =C2=A0 391=C2=A0 =C2=A0 =C2=A0 512=C2=A0 =C2=A0 =C2=A0 1564K kmalloc=
-8<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 170528 169359=C2=A0 99%=C2=A0 =C2=A0 =
0.25K=C2=A0 =C2=A05329=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0 =C2=A0 =C2=A04263=
2K filp<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 158144 153508=C2=A0 97%=C2=A0 =C2=A0 =
0.06K=C2=A0 =C2=A02471=C2=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0 =C2=A0 =C2=A0 988=
4K kmalloc-64<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 149914 149365=C2=A0 99%=C2=A0 =C2=A0 =
0.09K=C2=A0 =C2=A03259=C2=A0 =C2=A0 =C2=A0 =C2=A046=C2=A0 =C2=A0 =C2=A01303=
6K anon_vma<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 146640 143123=C2=A0 97%=C2=A0 =C2=A0 =
0.10K=C2=A0 =C2=A03760=C2=A0 =C2=A0 =C2=A0 =C2=A039=C2=A0 =C2=A0 =C2=A01504=
0K buffer_head<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 130368=C2=A0 32791=C2=A0 25%=C2=A0 =
=C2=A0 0.09K=C2=A0 =C2=A03104=C2=A0 =C2=A0 =C2=A0 =C2=A042=C2=A0 =C2=A0 =C2=
=A012416K kmalloc-96<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 129752 129752 100%=C2=A0 =C2=A0 0.07K=
=C2=A0 =C2=A02317=C2=A0 =C2=A0 =C2=A0 =C2=A056=C2=A0 =C2=A0 =C2=A0 9268K Ac=
pi-Operand<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 105468 105106=C2=A0 99%=C2=A0 =C2=A0 =
0.04K=C2=A0 =C2=A01034=C2=A0 =C2=A0 =C2=A0 102=C2=A0 =C2=A0 =C2=A0 4136K<br=
>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; selinux_inode_security<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A073080=C2=A0 73080 =
100%=C2=A0 =C2=A0 0.13K=C2=A0 =C2=A02436=C2=A0 =C2=A0 =C2=A0 =C2=A030=C2=A0=
 =C2=A0 =C2=A0 9744K<br>
&gt; &gt;&gt;&gt;&gt;&gt; kernfs_node_cache<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A072360=C2=A0 70261=
=C2=A0 97%=C2=A0 =C2=A0 0.59K=C2=A0 =C2=A01340=C2=A0 =C2=A0 =C2=A0 =C2=A054=
=C2=A0 =C2=A0 =C2=A042880K inode_cache<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A071040=C2=A0 71040 =
100%=C2=A0 =C2=A0 0.12K=C2=A0 =C2=A02220=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0=
 =C2=A0 =C2=A0 8880K<br>
&gt; &gt;&gt; eventpoll_epi<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A068096=C2=A0 59262=
=C2=A0 87%=C2=A0 =C2=A0 0.02K=C2=A0 =C2=A0 266=C2=A0 =C2=A0 =C2=A0 256=C2=
=A0 =C2=A0 =C2=A0 1064K kmalloc-16<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A053652=C2=A0 53652 =
100%=C2=A0 =C2=A0 0.04K=C2=A0 =C2=A0 526=C2=A0 =C2=A0 =C2=A0 102=C2=A0 =C2=
=A0 =C2=A0 2104K pde_opener<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A050496=C2=A0 31654=
=C2=A0 62%=C2=A0 =C2=A0 2.00K=C2=A0 =C2=A03156=C2=A0 =C2=A0 =C2=A0 =C2=A016=
=C2=A0 =C2=A0 100992K<br>
&gt; &gt;&gt; kmalloc-2048<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A046242=C2=A0 46242 =
100%=C2=A0 =C2=A0 0.19K=C2=A0 =C2=A01101=C2=A0 =C2=A0 =C2=A0 =C2=A042=C2=A0=
 =C2=A0 =C2=A0 8808K cred_jar<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A044496=C2=A0 43013=
=C2=A0 96%=C2=A0 =C2=A0 0.66K=C2=A0 =C2=A0 927=C2=A0 =C2=A0 =C2=A0 =C2=A048=
=C2=A0 =C2=A0 =C2=A029664K<br>
&gt; &gt;&gt;&gt;&gt;&gt; proc_inode_cache<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A044352=C2=A0 44352 =
100%=C2=A0 =C2=A0 0.06K=C2=A0 =C2=A0 693=C2=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0=
 =C2=A0 =C2=A0 2772K<br>
&gt; &gt;&gt;&gt;&gt;&gt; task_delay_info<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A043516=C2=A0 43471=
=C2=A0 99%=C2=A0 =C2=A0 0.69K=C2=A0 =C2=A0 946=C2=A0 =C2=A0 =C2=A0 =C2=A046=
=C2=A0 =C2=A0 =C2=A030272K<br>
&gt; &gt;&gt;&gt;&gt;&gt; sock_inode_cache<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A037856=C2=A0 27626=
=C2=A0 72%=C2=A0 =C2=A0 1.00K=C2=A0 =C2=A01183=C2=A0 =C2=A0 =C2=A0 =C2=A032=
=C2=A0 =C2=A0 =C2=A037856K<br>
&gt; &gt;&gt; kmalloc-1024<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A036736=C2=A0 36736 =
100%=C2=A0 =C2=A0 0.07K=C2=A0 =C2=A0 656=C2=A0 =C2=A0 =C2=A0 =C2=A056=C2=A0=
 =C2=A0 =C2=A0 2624K<br>
&gt; &gt;&gt; eventpoll_pwq<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A034076=C2=A0 31282=
=C2=A0 91%=C2=A0 =C2=A0 0.57K=C2=A0 =C2=A01217=C2=A0 =C2=A0 =C2=A0 =C2=A028=
=C2=A0 =C2=A0 =C2=A019472K<br>
&gt; &gt;&gt;&gt;&gt;&gt; radix_tree_node<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A033660=C2=A0 30528=
=C2=A0 90%=C2=A0 =C2=A0 1.05K=C2=A0 =C2=A01122=C2=A0 =C2=A0 =C2=A0 =C2=A030=
=C2=A0 =C2=A0 =C2=A035904K<br>
&gt; &gt;&gt;&gt;&gt;&gt; ext4_inode_cache<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A032760=C2=A0 30959=
=C2=A0 94%=C2=A0 =C2=A0 0.19K=C2=A0 =C2=A0 780=C2=A0 =C2=A0 =C2=A0 =C2=A042=
=C2=A0 =C2=A0 =C2=A0 6240K kmalloc-192<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A032028=C2=A0 32028 =
100%=C2=A0 =C2=A0 0.04K=C2=A0 =C2=A0 314=C2=A0 =C2=A0 =C2=A0 102=C2=A0 =C2=
=A0 =C2=A0 1256K<br>
&gt; &gt;&gt;&gt;&gt;&gt; ext4_extent_status<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A030048=C2=A0 30048 =
100%=C2=A0 =C2=A0 0.25K=C2=A0 =C2=A0 939=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0=
 =C2=A0 =C2=A0 7512K<br>
&gt; &gt;&gt;&gt;&gt;&gt; skbuff_head_cache<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A028736=C2=A0 28736 =
100%=C2=A0 =C2=A0 0.06K=C2=A0 =C2=A0 449=C2=A0 =C2=A0 =C2=A0 =C2=A064=C2=A0=
 =C2=A0 =C2=A0 1796K fs_cache<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A024702=C2=A0 24702 =
100%=C2=A0 =C2=A0 0.69K=C2=A0 =C2=A0 537=C2=A0 =C2=A0 =C2=A0 =C2=A046=C2=A0=
 =C2=A0 =C2=A017184K files_cache<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A023808=C2=A0 23808 =
100%=C2=A0 =C2=A0 0.66K=C2=A0 =C2=A0 496=C2=A0 =C2=A0 =C2=A0 =C2=A048=C2=A0=
 =C2=A0 =C2=A015872K ovl_inode<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A023104=C2=A0 22945=
=C2=A0 99%=C2=A0 =C2=A0 0.12K=C2=A0 =C2=A0 722=C2=A0 =C2=A0 =C2=A0 =C2=A032=
=C2=A0 =C2=A0 =C2=A0 2888K kmalloc-128<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A022724=C2=A0 21307=
=C2=A0 93%=C2=A0 =C2=A0 0.69K=C2=A0 =C2=A0 494=C2=A0 =C2=A0 =C2=A0 =C2=A046=
=C2=A0 =C2=A0 =C2=A015808K<br>
&gt; &gt;&gt;&gt;&gt;&gt; shmem_inode_cache<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A021472=C2=A0 21472 =
100%=C2=A0 =C2=A0 0.12K=C2=A0 =C2=A0 671=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0=
 =C2=A0 =C2=A0 2684K seq_file<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A019904=C2=A0 19904 =
100%=C2=A0 =C2=A0 1.00K=C2=A0 =C2=A0 622=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0=
 =C2=A0 =C2=A019904K UNIX<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A017340=C2=A0 17340 =
100%=C2=A0 =C2=A0 1.06K=C2=A0 =C2=A0 578=C2=A0 =C2=A0 =C2=A0 =C2=A030=C2=A0=
 =C2=A0 =C2=A018496K mm_struct<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A015980=C2=A0 15980 =
100%=C2=A0 =C2=A0 0.02K=C2=A0 =C2=A0 =C2=A094=C2=A0 =C2=A0 =C2=A0 170=C2=A0=
 =C2=A0 =C2=A0 =C2=A0376K avtab_node<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A014070=C2=A0 14070 =
100%=C2=A0 =C2=A0 1.06K=C2=A0 =C2=A0 469=C2=A0 =C2=A0 =C2=A0 =C2=A030=C2=A0=
 =C2=A0 =C2=A015008K<br>
&gt; &gt;&gt; signal_cache<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A013248=C2=A0 13248 =
100%=C2=A0 =C2=A0 0.12K=C2=A0 =C2=A0 414=C2=A0 =C2=A0 =C2=A0 =C2=A032=C2=A0=
 =C2=A0 =C2=A0 1656K pid<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A012128=C2=A0 11777=
=C2=A0 97%=C2=A0 =C2=A0 0.25K=C2=A0 =C2=A0 379=C2=A0 =C2=A0 =C2=A0 =C2=A032=
=C2=A0 =C2=A0 =C2=A0 3032K kmalloc-256<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A011008=C2=A0 11008 =
100%=C2=A0 =C2=A0 0.02K=C2=A0 =C2=A0 =C2=A043=C2=A0 =C2=A0 =C2=A0 256=C2=A0=
 =C2=A0 =C2=A0 =C2=A0172K<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; selinux_file_security<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A010812=C2=A0 10812 =
100%=C2=A0 =C2=A0 0.04K=C2=A0 =C2=A0 106=C2=A0 =C2=A0 =C2=A0 102=C2=A0 =C2=
=A0 =C2=A0 =C2=A0424K<br>
&gt; &gt;&gt; Acpi-Namespace<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; These information shows that the &#39=
;iommu_iova&#39; is the top memory<br>
&gt; &gt;&gt;&gt;&gt;&gt; consumer.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; In order to optimize the network perf=
ormence of Openstack virtual<br>
&gt; &gt;&gt;&gt;&gt;&gt; machines,<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I enabled the vt-d feature in bios an=
d sriov feature of Intel 82599<br>
&gt; &gt;&gt;&gt;&gt;&gt; 10G<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; NIC. I&#39;m assuming this is the roo=
t cause of this issue.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Is there anything I can do to fix it?=
<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; _____________________________________________=
__<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; iommu mailing list<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:iommu@lists.linux-foundatio=
n.org" target=3D"_blank">iommu@lists.linux-foundation.org</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://lists.linuxfoundation.org/=
mailman/listinfo/iommu" rel=3D"noreferrer" target=3D"_blank">https://lists.=
linuxfoundation.org/mailman/listinfo/iommu</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; _______________________________________________<br>
&gt; iommu mailing list<br>
&gt; <a href=3D"mailto:iommu@lists.linux-foundation.org" target=3D"_blank">=
iommu@lists.linux-foundation.org</a><br>
&gt; <a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/iommu" r=
el=3D"noreferrer" target=3D"_blank">https://lists.linuxfoundation.org/mailm=
an/listinfo/iommu</a><br>
</blockquote></div>

--000000000000f623af05a4662c5e--

--===============7028745220828623402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7028745220828623402==--
