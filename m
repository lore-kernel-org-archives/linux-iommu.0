Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D379C63793
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 07:58:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A0A161221
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 07:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0A161221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEC944033D;
	Thu, 22 Jul 2021 07:58:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t5INwApXiVJF; Thu, 22 Jul 2021 07:58:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5769340292;
	Thu, 22 Jul 2021 07:58:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 104FAC0010;
	Thu, 22 Jul 2021 07:58:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40720C000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 07:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 19FE6605D5
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 07:58:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q8ZMXSMjM0WV for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 07:58:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8213C600BA
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 07:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626940699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6lwGJN8TiFLyvyvEI71qHXGC7kR0F74D2az+cv8IX3c=;
 b=E402BMChwM8HopHWzbJAWqdSCbFTL9RqMAE2vSTv1qAIzfEVi96HqUNlXdVR8F7I6e/5K5
 6MlFMvdfWVQtl81coF6fzd/tVGvbj560w1YhT7dVz4F/AZp+NkLaSEOw/HCsA7vqpPnRQc
 Rm2IYRVPP0zZmMN5Wav9/Fq/bIHmNHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284--TOyIPhhNMqqiunAANAukQ-1; Thu, 22 Jul 2021 03:58:17 -0400
X-MC-Unique: -TOyIPhhNMqqiunAANAukQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AB9D93923;
 Thu, 22 Jul 2021 07:58:16 +0000 (UTC)
Received: from T590 (ovpn-13-219.pek2.redhat.com [10.72.13.219])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE72160CA1;
 Thu, 22 Jul 2021 07:58:08 +0000 (UTC)
Date: Thu, 22 Jul 2021 15:58:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.garry@huawei.com>
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <YPklDMng1hL3bQ+v@T590>
References: <YOgK8fdv7dOQtkET@T590>
 <23e7956b-f3b5-b585-3c18-724165994051@arm.com>
 <YOhcOv1oOwm6fco+@T590>
 <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com>
 <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com>
 <YPfwAN1onpSKoeBj@T590>
 <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

On Wed, Jul 21, 2021 at 12:07:22PM +0100, John Garry wrote:
> On 21/07/2021 10:59, Ming Lei wrote:
> > > I have now removed that from the tree, so please re-pull.
> > Now the kernel can be built successfully, but not see obvious improvement
> > on the reported issue:
> > 
> > [root@ampere-mtjade-04 ~]# uname -a
> > Linux ampere-mtjade-04.khw4.lab.eng.bos.redhat.com 5.14.0-rc2_smmu_fix+ #2 SMP Wed Jul 21 05:49:03 EDT 2021 aarch64 aarch64 aarch64 GNU/Linux
> > 
> > [root@ampere-mtjade-04 ~]# taskset -c 0 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
> > + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
> > test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
> > fio-3.27
> > Starting 1 process
> > Jobs: 1 (f=1): [r(1)][100.0%][r=1503MiB/s][r=385k IOPS][eta 00m:00s]
> > test: (groupid=0, jobs=1): err= 0: pid=3143: Wed Jul 21 05:58:14 2021
> >    read: IOPS=384k, BW=1501MiB/s (1573MB/s)(14.7GiB/10001msec)
> 
> I am not sure what baseline you used previously, but you were getting 327K
> then, so at least this would be an improvement.

Looks the improvement isn't from your patches, please see the test result on
v5.14-rc2:

[root@ampere-mtjade-04 ~]# uname -a
Linux ampere-mtjade-04.khw4.lab.eng.bos.redhat.com 5.14.0-rc2_linus #3 SMP Thu Jul 22 03:41:24 EDT 2021 aarch64 aarch64 aarch64 GNU/Linux
[root@ampere-mtjade-04 ~]# taskset -c 0 ~/git/tools/test/nvme/io_uring 20 1 /dev/nvme1n1 4k
+ fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=20 --numjobs=1 --rw=randread --name=test --group_reporting
test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
fio-3.27
Starting 1 process
Jobs: 1 (f=1): [r(1)][100.0%][r=1489MiB/s][r=381k IOPS][eta 00m:00s]
test: (groupid=0, jobs=1): err= 0: pid=3099: Thu Jul 22 03:53:04 2021
  read: IOPS=381k, BW=1487MiB/s (1559MB/s)(29.0GiB/20001msec)


thanks, 
Ming

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
