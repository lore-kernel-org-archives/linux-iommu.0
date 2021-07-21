Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2847BC12002
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 11:59:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2F060E08
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 11:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2F060E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8752E8280E;
	Wed, 21 Jul 2021 11:58:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WJo3q_i93fov; Wed, 21 Jul 2021 11:58:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4362D827FD;
	Wed, 21 Jul 2021 11:58:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21727C001A;
	Wed, 21 Jul 2021 11:58:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D846C000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 11:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C13B40163
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 11:58:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GzV72jPkcEKC for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 11:58:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A7C7400C3
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 11:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626868735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gxJfZWLtNPAs2shHJ9IAWHN7TfwnN9A2aOkk0cTcs2k=;
 b=bmayNyRi7AT/WRCas2drY555KGrtORsvdmQJVQ70lOFA/FV+U6LyyOeQ9DQ8WNiWtq4LcT
 K/Qq7LqM32jAgkV6KR8pSRihhZ5rghpBW+56ke26Ph8EZ0X/8zPZ4IeqYipp5GWESBlYr3
 X0oo1Qi43XURg0COD/kesEvl4Lqbnko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-GMMTpxDdNDy79OlVI1KIHQ-1; Wed, 21 Jul 2021 07:58:51 -0400
X-MC-Unique: GMMTpxDdNDy79OlVI1KIHQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17430100F79B;
 Wed, 21 Jul 2021 11:58:50 +0000 (UTC)
Received: from T590 (ovpn-13-178.pek2.redhat.com [10.72.13.178])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EFFE1B5C2;
 Wed, 21 Jul 2021 11:58:40 +0000 (UTC)
Date: Wed, 21 Jul 2021 19:58:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.garry@huawei.com>
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <YPgL7InbR9UPkSQD@T590>
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
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Yeah, that might be one improvement, but not checked it since code base
is changed.

> 
> > 
> > [root@ampere-mtjade-04 ~]# taskset -c 80 ~/git/tools/test/nvme/io_uring 10 1 /dev/nvme1n1 4k
> > + fio --bs=4k --ioengine=io_uring --fixedbufs --registerfiles --hipri --iodepth=64 --iodepth_batch_submit=16 --iodepth_batch_complete_min=16 --filename=/dev/nvme1n1 --direct=1 --runtime=10 --numjobs=1 --rw=randread --name=test --group_reporting
> > test: (g=0): rw=randread, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=64
> > fio-3.27
> > Starting 1 process
> > Jobs: 1 (f=1): [r(1)][100.0%][r=138MiB/s][r=35.4k IOPS][eta 00m:00s]
> > test: (groupid=0, jobs=1): err= 0: pid=3063: Wed Jul 21 05:55:31 2021
> >    read: IOPS=35.4k, BW=138MiB/s (145MB/s)(1383MiB/10001msec)
> 
> I can try similar on our arm64 board when I get a chance.

The issue I reported is this one.

Thanks,
Ming

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
