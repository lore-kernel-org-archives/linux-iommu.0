Return-Path: <SRS0=45t2=MU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E236BC4338F
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 01:32:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C66060F41
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 01:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C66060F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16C56405BC;
	Wed, 28 Jul 2021 01:32:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WmPiQrJsnmXK; Wed, 28 Jul 2021 01:32:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C65ED405B4;
	Wed, 28 Jul 2021 01:32:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C874C0010;
	Wed, 28 Jul 2021 01:32:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DB73C000E
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 01:32:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 026614016D
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 01:32:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GIdtzQCcne4X for <iommu@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 01:32:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E93CB40158
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 01:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627435949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kf5aUfsANGKBoZwHiIJy34leYH8aHIuAfY+f1HX0vi8=;
 b=PlIXtsZo0X1NtMBn4SWo4zP69ZN+rTyAyOFXoq3MAacfvAdpDIsYZVTOyw9mKQ4H6ISjHu
 VmfreJXePyGLdDzDd/6vXwrOZT7/LBvDLlYlUrPz20+dw7dwpmFomfxgODlNbtELf80Dpn
 VZ0SUTkfBiXHpwX88eMDg4h4sOxmlAk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-IFwEwnDONKu1wGtCypxFWQ-1; Tue, 27 Jul 2021 21:32:26 -0400
X-MC-Unique: IFwEwnDONKu1wGtCypxFWQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 k6-20020a2e92060000b0290199022fba24so63756ljg.13
 for <iommu@lists.linux-foundation.org>; Tue, 27 Jul 2021 18:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kf5aUfsANGKBoZwHiIJy34leYH8aHIuAfY+f1HX0vi8=;
 b=Itf2n5nXsM5qm7mCdx1BjlK/QrA1utu1m7Ju9rgcMp3REk31m5do/iRoiej2JA3yLR
 B5ywGyuVexgzHz8tSq6zscmH07ogo47aO3LmXX9NWpd3I/qDdT/4N9l00GGIxJnTSc7I
 LAJtuoFzVslgjCNFte0Y48aVC1gFCTNAvvPg2+itQGHVD+2BFEJdFKqthhudNftSSpZA
 sjkkTAaxmWQYKGFeUkSdwTZoc7SmWNimrCYizvZrkHv+R0uOZIwzB5BAS2rVjCVSGNp0
 AyE5TceQb6JeBhi6I0Ch+y1MgAWnH3nU4I7cuMBoGFzDv/ocCJGBpMjrvP7C32e/ENpB
 b1jQ==
X-Gm-Message-State: AOAM530WRcjQ+Pp/dA1VZMe2gy6H8noSuqDc3YSi180mDdElOm2vlx7L
 80YppX6bzCLcU1HGJnFwaS2UT8ywN1WR8txUJw5pW3pSd94TyH2LY2euBYNzW/4j+68ouc011Pw
 l9KElVvDMC84KXnNDLxwZjEJlVAZhHnIBjI991BjTCNXjHQ==
X-Received: by 2002:a2e:9f17:: with SMTP id u23mr17792649ljk.489.1627435944454; 
 Tue, 27 Jul 2021 18:32:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykFYilZJ2GcF6ouX3vcGwfM+Hskq6tfweIJmhp9Yv8JcjVZgcMTXPVL1ESbZYm6VaP6gLAx2EBoAE5N087UTU=
X-Received: by 2002:a2e:9f17:: with SMTP id u23mr17792637ljk.489.1627435944184; 
 Tue, 27 Jul 2021 18:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com>
 <YPfwAN1onpSKoeBj@T590> <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com>
 <YPklDMng1hL3bQ+v@T590> <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com>
 <YPlGOOMSdm6Bcyy/@T590> <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com>
 <YPmUoBk9u+tU2rbS@T590> <0adbe03b-ce26-e4d3-3425-d967bc436ef5@arm.com>
 <YPqYDY9/VAhfHNfU@T590> <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
In-Reply-To: <6ceab844-465f-3bf3-1809-5df1f1dbbc5c@huawei.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 28 Jul 2021 09:32:17 +0800
Message-ID: <CAFj5m9J+9vO=CK3uPP+va5EoWffZj9ruSRe2fDDLXn+AE971CQ@mail.gmail.com>
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
To: John Garry <john.garry@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=minlei@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Jul 26, 2021 at 3:51 PM John Garry <john.garry@huawei.com> wrote:
>
> On 23/07/2021 11:21, Ming Lei wrote:
> >> Thanks, I was also going to suggest the latter, since it's what
> >> arm_smmu_cmdq_issue_cmdlist() does with IRQs masked that should be most
> >> indicative of where the slowness most likely stems from.
> > The improvement from 'iommu.strict=0' is very small:
> >
>
> Have you tried turning off the IOMMU to ensure that this is really just
> an IOMMU problem?
>
> You can try setting CONFIG_ARM_SMMU_V3=n in the defconfig or passing
> cmdline param iommu.passthrough=1 to bypass the the SMMU (equivalent to
> disabling for kernel drivers).

Bypassing SMMU via iommu.passthrough=1 basically doesn't make a difference
on this issue.

And from fio log, submission latency is good, but completion latency
is pretty bad,
and maybe it is something that writing to PCI memory isn't committed to HW in
time?

BTW, adding one mb() at the exit of nvme_queue_rq() doesn't make a difference.


Follows the fio log after passing iommu.passthrough=1:

[root@ampere-mtjade-04 ~]# taskset -c 0 ~/git/tools/test/nvme/io_uring
10 1 /dev/nvme1n1 4k
+ fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri
--iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16
--filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1
--rw=randread --name=test --group_reporting
test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
4096B-4096B, ioengine=io_uring, iodepth=64
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [r(1)][100.0%][r=1538MiB/s][r=394k IOPS][eta 00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=3053: Tue Jul 27 20:57:04 2021
  read: IOPS=393k, BW=1536MiB/s (1611MB/s)(15.0GiB/10001msec)
    slat (usec): min=12, max=343, avg=18.54, stdev= 3.47
    clat (usec): min=46, max=487, avg=140.15, stdev=22.72
     lat (usec): min=63, max=508, avg=158.72, stdev=22.29
    clat percentiles (usec):
     |  1.00th=[   87],  5.00th=[  104], 10.00th=[  113], 20.00th=[  123],
     | 30.00th=[  130], 40.00th=[  135], 50.00th=[  141], 60.00th=[  145],
     | 70.00th=[  151], 80.00th=[  159], 90.00th=[  167], 95.00th=[  176],
     | 99.00th=[  196], 99.50th=[  206], 99.90th=[  233], 99.95th=[  326],
     | 99.99th=[  392]
   bw (  MiB/s): min= 1533, max= 1539, per=100.00%, avg=1537.99,
stdev= 1.36, samples=19
   iops        : min=392672, max=394176, avg=393724.63, stdev=348.25, samples=19
  lat (usec)   : 50=0.01%, 100=3.64%, 250=96.30%, 500=0.06%
  cpu          : usr=17.58%, sys=82.03%, ctx=1113, majf=0, minf=5
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=0.0%, 8=0.0%, 16=100.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=0.0%, 8=0.0%, 16=100.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=3933712,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=1536MiB/s (1611MB/s), 1536MiB/s-1536MiB/s
(1611MB/s-1611MB/s), io=15.0GiB (16.1GB), run=10001-10001msec

Disk stats (read/write):
  nvme1n1: ios=3890950/0, merge=0/0, ticks=529137/0, in_queue=529137,
util=99.15%
[root@ampere-mtjade-04 ~]#
[root@ampere-mtjade-04 ~]# taskset -c 80
~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
+ fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri
--iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16
--filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1
--rw=randread --name=test --group_reporting
test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T)
4096B-4096B, ioengine=io_uring, iodepth=64
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [r(1)][100.0%][r=150MiB/s][r=38.4k IOPS][eta 00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=3062: Tue Jul 27 20:57:23 2021
  read: IOPS=38.4k, BW=150MiB/s (157MB/s)(1501MiB/10002msec)
    slat (usec): min=14, max=376, avg=20.21, stdev= 4.66
    clat (usec): min=439, max=2457, avg=1640.85, stdev=17.01
     lat (usec): min=559, max=2494, avg=1661.09, stdev=15.67
    clat percentiles (usec):
     |  1.00th=[ 1614],  5.00th=[ 1631], 10.00th=[ 1647], 20.00th=[ 1647],
     | 30.00th=[ 1647], 40.00th=[ 1647], 50.00th=[ 1647], 60.00th=[ 1647],
     | 70.00th=[ 1647], 80.00th=[ 1647], 90.00th=[ 1647], 95.00th=[ 1647],
     | 99.00th=[ 1647], 99.50th=[ 1663], 99.90th=[ 1729], 99.95th=[ 1827],
     | 99.99th=[ 2057]
   bw (  KiB/s): min=153600, max=153984, per=100.00%, avg=153876.21,
stdev=88.10, samples=19
   iops        : min=38400, max=38496, avg=38469.05, stdev=22.02, samples=19
  lat (usec)   : 500=0.01%, 1000=0.01%
  lat (msec)   : 2=99.96%, 4=0.03%
  cpu          : usr=2.00%, sys=97.65%, ctx=1056, majf=0, minf=5
  IO depths    : 1=0.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=0.0%, 8=0.0%, 16=100.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=0.0%, 8=0.0%, 16=100.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=384288,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=150MiB/s (157MB/s), 150MiB/s-150MiB/s (157MB/s-157MB/s),
io=1501MiB (1574MB), run=10002-10002msec

Disk stats (read/write):
  nvme1n1: ios=380266/0, merge=0/0, ticks=554940/0, in_queue=554940, util=99.22%

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
