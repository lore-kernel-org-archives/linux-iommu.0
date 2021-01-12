Return-Path: <SRS0=VgK/=GP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C87C433E0
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 14:38:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F298E2312D
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 14:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F298E2312D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A40EC203E2;
	Tue, 12 Jan 2021 14:38:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ch5c8sBVGMHJ; Tue, 12 Jan 2021 14:38:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2C3E120337;
	Tue, 12 Jan 2021 14:38:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C255C0893;
	Tue, 12 Jan 2021 14:38:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3EF1C013A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 14:38:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BA7C0203F5
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 14:38:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PisGbggqWXI2 for <iommu@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 14:38:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id D2FAB20337
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 14:38:24 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E183D20771;
 Tue, 12 Jan 2021 14:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610462304;
 bh=/+TO0V946bI56guDMyc3LjAhDC0JejiP8ooVdPIrl4g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=THx5fJ/dkXlArCPNjLkX4O8RcTplr7mtjL0MAAB8Sm4xRTo2VbqTU7XjwYSfvI5oh
 cGHb/HFyOIVXbDuKTV1h6iBgpMJA+3xkgZbZOZTZzIrLSu+0OcsZbzy9skwEjOQAlI
 kTWfE4Ao49KbpXvAnbAGVB9urVfMaZz8aoc9u2if1e0PP1yar7mZeuqwLz6imxqZQx
 J37xzvgvamtULJh6y9RJIBNdi0cDLxES9HR171UWVZg79Y/mtMiZWYKCANTQznnzgp
 TsjlvsDu2tIl2eWy28cmM0Yj5g2YNw/vmO7jw4agWitPcLK+E3E9WCNTIzwItFcfIB
 XyxgjZDqA0SqA==
Date: Tue, 12 Jan 2021 14:38:19 +0000
From: Will Deacon <will@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
Message-ID: <20210112143819.GA9689@willie-the-truck>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-rdma <linux-rdma@vger.kernel.org>, robin.murphy@arm.com,
 murphyt7@tcd.ie, iommu@lists.linux-foundation.org, logang@deltatee.com,
 hch@lst.de
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

[Expanding cc list to include DMA-IOMMU and intel IOMMU folks]

On Fri, Jan 08, 2021 at 04:18:36PM -0500, Chuck Lever wrote:
> Hi-
> 
> [ Please cc: me on replies, I'm not currently subscribed to
> iommu@lists ].
> 
> I'm running NFS performance tests on InfiniBand using CX-3 Pro cards
> at 56Gb/s. The test is iozone on an NFSv3/RDMA mount:
> 
> /home/cel/bin/iozone -M -+u -i0 -i1 -s1g -r256k -t12 -I
> 
> For those not familiar with the way storage protocols use RDMA, The
> initiator/client sets up memory regions and the target/server uses
> RDMA Read and Write to move data out of and into those regions. The
> initiator/client uses only RDMA memory registration and invalidation
> operations, and the target/server uses RDMA Read and Write.
> 
> My NFS client is a two-socket 12-core x86_64 system with its I/O MMU
> enabled using the kernel command line options "intel_iommu=on
> iommu=strict".
> 
> Recently I've noticed a significant (25-30%) loss in NFS throughput.
> I was able to bisect on my client to the following commits.
> 
> Here's 65f746e8285f ("iommu: Add quirk for Intel graphic devices in
> map_sg"). This is about normal for this test.
> 
> 	Children see throughput for 12 initial writers 	= 4732581.09 kB/sec
>  	Parent sees throughput for 12 initial writers 	= 4646810.21 kB/sec
>  	Min throughput per process 			=  387764.34 kB/sec
>  	Max throughput per process 			=  399655.47 kB/sec
>  	Avg throughput per process 			=  394381.76 kB/sec
>  	Min xfer 					= 1017344.00 kB
>  	CPU Utilization: Wall time    2.671    CPU time    1.974    CPU utilization  73.89 %
>  	Children see throughput for 12 rewriters 	= 4837741.94 kB/sec
>  	Parent sees throughput for 12 rewriters 	= 4833509.35 kB/sec
>  	Min throughput per process 			=  398983.72 kB/sec
>  	Max throughput per process 			=  406199.66 kB/sec
>  	Avg throughput per process 			=  403145.16 kB/sec
>  	Min xfer 					= 1030656.00 kB
>  	CPU utilization: Wall time    2.584    CPU time    1.959    CPU utilization  75.82 %
>  	Children see throughput for 12 readers 		= 5921370.94 kB/sec
>  	Parent sees throughput for 12 readers 		= 5914106.69 kB/sec
>  	Min throughput per process 			=  491812.38 kB/sec
>  	Max throughput per process 			=  494777.28 kB/sec
>  	Avg throughput per process 			=  493447.58 kB/sec
>  	Min xfer 					= 1042688.00 kB
>  	CPU utilization: Wall time    2.122    CPU time    1.968    CPU utilization  92.75 %
>  	Children see throughput for 12 re-readers 	= 5947985.69 kB/sec
>  	Parent sees throughput for 12 re-readers 	= 5941348.51 kB/sec
>  	Min throughput per process 			=  492805.81 kB/sec
>  	Max throughput per process 			=  497280.19 kB/sec
>  	Avg throughput per process 			=  495665.47 kB/sec
>  	Min xfer 					= 1039360.00 kB
>  	CPU utilization: Wall time    2.111    CPU time    1.968    CPU utilization  93.22 %
> 
> Here's c062db039f40 ("iommu/vt-d: Update domain geometry in
> iommu_ops.at(de)tach_dev"). It's losing some steam here.
> 
> 	Children see throughput for 12 initial writers 	= 4342419.12 kB/sec
>  	Parent sees throughput for 12 initial writers 	= 4310612.79 kB/sec
>  	Min throughput per process 			=  359299.06 kB/sec
>  	Max throughput per process 			=  363866.16 kB/sec
>  	Avg throughput per process 			=  361868.26 kB/sec
>  	Min xfer 					= 1035520.00 kB
>  	CPU Utilization: Wall time    2.902    CPU time    1.951    CPU utilization  67.22 %
>  	Children see throughput for 12 rewriters 	= 4408576.66 kB/sec
>  	Parent sees throughput for 12 rewriters 	= 4404280.87 kB/sec
>  	Min throughput per process 			=  364553.88 kB/sec
>  	Max throughput per process 			=  370029.28 kB/sec
>  	Avg throughput per process 			=  367381.39 kB/sec
>  	Min xfer 					= 1033216.00 kB
>  	CPU utilization: Wall time    2.836    CPU time    1.956    CPU utilization  68.97 %
>  	Children see throughput for 12 readers 		= 5406879.47 kB/sec
>  	Parent sees throughput for 12 readers 		= 5401862.78 kB/sec
>  	Min throughput per process 			=  449583.03 kB/sec
>  	Max throughput per process 			=  451761.69 kB/sec
>  	Avg throughput per process 			=  450573.29 kB/sec
>  	Min xfer 					= 1044224.00 kB
>  	CPU utilization: Wall time    2.323    CPU time    1.977    CPU utilization  85.12 %
>  	Children see throughput for 12 re-readers 	= 5410601.12 kB/sec
>  	Parent sees throughput for 12 re-readers 	= 5403504.40 kB/sec
>  	Min throughput per process 			=  449918.12 kB/sec
>  	Max throughput per process 			=  452489.28 kB/sec
>  	Avg throughput per process 			=  450883.43 kB/sec
>  	Min xfer 					= 1043456.00 kB
>  	CPU utilization: Wall time    2.321    CPU time    1.978    CPU utilization  85.21 %
> 
> And here's c588072bba6b ("iommu/vt-d: Convert intel iommu driver to
> the iommu ops"). Significant throughput loss.
> 
> 	Children see throughput for 12 initial writers 	= 3812036.91 kB/sec
>  	Parent sees throughput for 12 initial writers 	= 3753683.40 kB/sec
>  	Min throughput per process 			=  313672.25 kB/sec
>  	Max throughput per process 			=  321719.44 kB/sec
>  	Avg throughput per process 			=  317669.74 kB/sec
>  	Min xfer 					= 1022464.00 kB
>  	CPU Utilization: Wall time    3.309    CPU time    1.986    CPU utilization  60.02 %
>  	Children see throughput for 12 rewriters 	= 3786831.94 kB/sec
>  	Parent sees throughput for 12 rewriters 	= 3783205.58 kB/sec
>  	Min throughput per process 			=  313654.44 kB/sec
>  	Max throughput per process 			=  317844.50 kB/sec
>  	Avg throughput per process 			=  315569.33 kB/sec
>  	Min xfer 					= 1035520.00 kB
>  	CPU utilization: Wall time    3.302    CPU time    1.945    CPU utilization  58.90 %
>  	Children see throughput for 12 readers 		= 4265828.28 kB/sec
>  	Parent sees throughput for 12 readers 		= 4261844.88 kB/sec
>  	Min throughput per process 			=  352305.00 kB/sec
>  	Max throughput per process 			=  357726.22 kB/sec
>  	Avg throughput per process 			=  355485.69 kB/sec
>  	Min xfer 					= 1032960.00 kB
>  	CPU utilization: Wall time    2.934    CPU time    1.942    CPU utilization  66.20 %
>  	Children see throughput for 12 re-readers 	= 4220651.19 kB/sec
>  	Parent sees throughput for 12 re-readers 	= 4216096.04 kB/sec
>  	Min throughput per process 			=  348677.16 kB/sec
>  	Max throughput per process 			=  353467.44 kB/sec
>  	Avg throughput per process 			=  351720.93 kB/sec
>  	Min xfer 					= 1035264.00 kB
>  	CPU utilization: Wall time    2.969    CPU time    1.952    CPU utilization  65.74 %
> 
> The regression appears to be 100% reproducible. 
> 
> 
> --
> Chuck Lever
> 
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
