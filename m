Return-Path: <SRS0=6oxg=MB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195E8C07E99
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 14:22:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A320B613B5
	for <iommu@archiver.kernel.org>; Fri,  9 Jul 2021 14:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A320B613B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7534F423D8;
	Fri,  9 Jul 2021 14:22:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 58w6GOTO08XZ; Fri,  9 Jul 2021 14:22:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3CAB8423D5;
	Fri,  9 Jul 2021 14:22:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14DF4C0010;
	Fri,  9 Jul 2021 14:22:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4DDFC000E
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 14:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A47564025F
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 14:21:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id szCF_kZxN6Jr for <iommu@lists.linux-foundation.org>;
 Fri,  9 Jul 2021 14:21:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B05004014B
 for <iommu@lists.linux-foundation.org>; Fri,  9 Jul 2021 14:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625840517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R80jkwSRBMdXMIX0M3ux6M8QaLP+0xDfTy88OLoP8qM=;
 b=h2OBH8KDRHbrCG5SsHpkU3eV5vRInHIHJTd646l3pt11E1+9IHRNoE9V0Kj6+Ex26msm1L
 KtKQLlVIIlnEIpLtYu4sCCj/nLCIP1IfVZdb1dpYVyYyVx8fAG1iFTW5mMjWui7Pwa1OOR
 rnWksp+7w+AXYxxYu7qbjhr6l/w9z5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-Mi1YBWmwOS2HtCIMAe8qEg-1; Fri, 09 Jul 2021 10:21:54 -0400
X-MC-Unique: Mi1YBWmwOS2HtCIMAe8qEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C834B343CD;
 Fri,  9 Jul 2021 14:21:52 +0000 (UTC)
Received: from T590 (ovpn-12-94.pek2.redhat.com [10.72.12.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE32F60BD8;
 Fri,  9 Jul 2021 14:21:44 +0000 (UTC)
Date: Fri, 9 Jul 2021 22:21:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <YOhbc5C47IzC893B@T590>
References: <YOgK8fdv7dOQtkET@T590>
 <20210709101614.GZ22278@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210709101614.GZ22278@shell.armlinux.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
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

On Fri, Jul 09, 2021 at 11:16:14AM +0100, Russell King (Oracle) wrote:
> On Fri, Jul 09, 2021 at 04:38:09PM +0800, Ming Lei wrote:
> > I observed that NVMe performance is very bad when running fio on one
> > CPU(aarch64) in remote numa node compared with the nvme pci numa node.
> 
> Have you checked the effect of running a memory-heavy process using
> memory from node 1 while being executed by CPUs in node 0?

1) aarch64
[root@ampere-mtjade-04 ~]# taskset -c 0 numactl -m 0  perf bench mem memcpy -s 4GB -f default
# Running 'mem/memcpy' benchmark:
# function 'default' (Default memcpy() provided by glibc)
# Copying 4GB bytes ...

      11.511752 GB/sec
[root@ampere-mtjade-04 ~]# taskset -c 0 numactl -m 1  perf bench mem memcpy -s 4GB -f default
# Running 'mem/memcpy' benchmark:
# function 'default' (Default memcpy() provided by glibc)
# Copying 4GB bytes ...

       3.084333 GB/sec


2) x86_64[1]
[root@hp-dl380g10-01 mingl]#  taskset -c 0 numactl -m 0  perf bench mem memcpy -s 4GB -f default
# Running 'mem/memcpy' benchmark:
# function 'default' (Default memcpy() provided by glibc)
# Copying 4GB bytes ...

       4.193927 GB/sec
[root@hp-dl380g10-01 mingl]#  taskset -c 0 numactl -m 1  perf bench mem memcpy -s 4GB -f default
# Running 'mem/memcpy' benchmark:
# function 'default' (Default memcpy() provided by glibc)
# Copying 4GB bytes ...

       3.553392 GB/sec


[1] on this x86_64 machine, IOPS can reach 680K in same fio nvme test 



Thanks,
Ming

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
