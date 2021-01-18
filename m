Return-Path: <SRS0=rNTl=GV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7568FC433DB
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 16:19:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC5020715
	for <iommu@archiver.kernel.org>; Mon, 18 Jan 2021 16:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC5020715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C7DF3860D5;
	Mon, 18 Jan 2021 16:19:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u5B8CIYwAxlE; Mon, 18 Jan 2021 16:19:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6DCD785C56;
	Mon, 18 Jan 2021 16:19:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53F85C088B;
	Mon, 18 Jan 2021 16:19:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5B5AC013A
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 16:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A360285CCF
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 16:19:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fhQkMeI1xxq1 for <iommu@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 16:18:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9904085C56
 for <iommu@lists.linux-foundation.org>; Mon, 18 Jan 2021 16:18:59 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10IGE9WY014277;
 Mon, 18 Jan 2021 16:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=XMv79LZuURhRyTxT/s5Jb08PQ1r3hLTJPHzx4pcvkWQ=;
 b=q4dU6qglz9OQWaPZXP3ckP5TFRfWyvRsO+kcL2Ny4HQciRweQHYB8w3ZTU9jIMKrpm8M
 cFhYpEh2r8aDRo/lqii7DDvDm7NUDsuj4EpOQFg2gfvYnrspWryFb5WN+UPuw9cmlzZn
 //WjguDinhJIQfdsuu2sdiDn4NHDKBHw3OrWQB/A/AfIytAzlto6JMMF4umly2fSafyI
 KWms7hzWQGn5hNJYX7N6bKqRIP1RNt07jdt+LvE7TH+Natt+JDCb0m6+kkoRupSVtGnL
 uLlTAanI9ZAbq7JeyP76lvM5QGRPqG+qC/WVAEe5P8fpmCF+UbPI+5CNGTOax577xdB5 CQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 363r3knvbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Jan 2021 16:18:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10IGFdjo046856;
 Mon, 18 Jan 2021 16:18:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 364a2v8yt9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Jan 2021 16:18:46 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10IGIi6E002607;
 Mon, 18 Jan 2021 16:18:44 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 18 Jan 2021 08:18:42 -0800
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20210112143819.GA9689@willie-the-truck>
Date: Mon, 18 Jan 2021 11:18:41 -0500
Message-Id: <607648D8-BF0C-40D6-9B43-2359F45EE74C@oracle.com>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
 <20210112143819.GA9689@willie-the-truck>
To: iommu@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 phishscore=0 mlxlogscore=833 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101180096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=845
 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101180096
Cc: linux-rdma <linux-rdma@vger.kernel.org>, Will Deacon <will@kernel.org>,
 robin.murphy@arm.com, murphyt7@tcd.ie, logang@deltatee.com,
 Christoph Hellwig <hch@lst.de>
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



> On Jan 12, 2021, at 9:38 AM, Will Deacon <will@kernel.org> wrote:
> 
> [Expanding cc list to include DMA-IOMMU and intel IOMMU folks]
> 
> On Fri, Jan 08, 2021 at 04:18:36PM -0500, Chuck Lever wrote:
>> Hi-
>> 
>> [ Please cc: me on replies, I'm not currently subscribed to
>> iommu@lists ].
>> 
>> I'm running NFS performance tests on InfiniBand using CX-3 Pro cards
>> at 56Gb/s. The test is iozone on an NFSv3/RDMA mount:
>> 
>> /home/cel/bin/iozone -M -+u -i0 -i1 -s1g -r256k -t12 -I
>> 
>> For those not familiar with the way storage protocols use RDMA, The
>> initiator/client sets up memory regions and the target/server uses
>> RDMA Read and Write to move data out of and into those regions. The
>> initiator/client uses only RDMA memory registration and invalidation
>> operations, and the target/server uses RDMA Read and Write.
>> 
>> My NFS client is a two-socket 12-core x86_64 system with its I/O MMU
>> enabled using the kernel command line options "intel_iommu=on
>> iommu=strict".
>> 
>> Recently I've noticed a significant (25-30%) loss in NFS throughput.
>> I was able to bisect on my client to the following commits.
>> 
>> Here's 65f746e8285f ("iommu: Add quirk for Intel graphic devices in
>> map_sg"). This is about normal for this test.
>> 
>> 	Children see throughput for 12 initial writers 	= 4732581.09 kB/sec
>> 	Parent sees throughput for 12 initial writers 	= 4646810.21 kB/sec
>> 	Min throughput per process 			=  387764.34 kB/sec
>> 	Max throughput per process 			=  399655.47 kB/sec
>> 	Avg throughput per process 			=  394381.76 kB/sec
>> 	Min xfer 					= 1017344.00 kB
>> 	CPU Utilization: Wall time    2.671    CPU time    1.974    CPU utilization  73.89 %
>> 	Children see throughput for 12 rewriters 	= 4837741.94 kB/sec
>> 	Parent sees throughput for 12 rewriters 	= 4833509.35 kB/sec
>> 	Min throughput per process 			=  398983.72 kB/sec
>> 	Max throughput per process 			=  406199.66 kB/sec
>> 	Avg throughput per process 			=  403145.16 kB/sec
>> 	Min xfer 					= 1030656.00 kB
>> 	CPU utilization: Wall time    2.584    CPU time    1.959    CPU utilization  75.82 %
>> 	Children see throughput for 12 readers 		= 5921370.94 kB/sec
>> 	Parent sees throughput for 12 readers 		= 5914106.69 kB/sec
>> 	Min throughput per process 			=  491812.38 kB/sec
>> 	Max throughput per process 			=  494777.28 kB/sec
>> 	Avg throughput per process 			=  493447.58 kB/sec
>> 	Min xfer 					= 1042688.00 kB
>> 	CPU utilization: Wall time    2.122    CPU time    1.968    CPU utilization  92.75 %
>> 	Children see throughput for 12 re-readers 	= 5947985.69 kB/sec
>> 	Parent sees throughput for 12 re-readers 	= 5941348.51 kB/sec
>> 	Min throughput per process 			=  492805.81 kB/sec
>> 	Max throughput per process 			=  497280.19 kB/sec
>> 	Avg throughput per process 			=  495665.47 kB/sec
>> 	Min xfer 					= 1039360.00 kB
>> 	CPU utilization: Wall time    2.111    CPU time    1.968    CPU utilization  93.22 %
>> 
>> Here's c062db039f40 ("iommu/vt-d: Update domain geometry in
>> iommu_ops.at(de)tach_dev"). It's losing some steam here.
>> 
>> 	Children see throughput for 12 initial writers 	= 4342419.12 kB/sec
>> 	Parent sees throughput for 12 initial writers 	= 4310612.79 kB/sec
>> 	Min throughput per process 			=  359299.06 kB/sec
>> 	Max throughput per process 			=  363866.16 kB/sec
>> 	Avg throughput per process 			=  361868.26 kB/sec
>> 	Min xfer 					= 1035520.00 kB
>> 	CPU Utilization: Wall time    2.902    CPU time    1.951    CPU utilization  67.22 %
>> 	Children see throughput for 12 rewriters 	= 4408576.66 kB/sec
>> 	Parent sees throughput for 12 rewriters 	= 4404280.87 kB/sec
>> 	Min throughput per process 			=  364553.88 kB/sec
>> 	Max throughput per process 			=  370029.28 kB/sec
>> 	Avg throughput per process 			=  367381.39 kB/sec
>> 	Min xfer 					= 1033216.00 kB
>> 	CPU utilization: Wall time    2.836    CPU time    1.956    CPU utilization  68.97 %
>> 	Children see throughput for 12 readers 		= 5406879.47 kB/sec
>> 	Parent sees throughput for 12 readers 		= 5401862.78 kB/sec
>> 	Min throughput per process 			=  449583.03 kB/sec
>> 	Max throughput per process 			=  451761.69 kB/sec
>> 	Avg throughput per process 			=  450573.29 kB/sec
>> 	Min xfer 					= 1044224.00 kB
>> 	CPU utilization: Wall time    2.323    CPU time    1.977    CPU utilization  85.12 %
>> 	Children see throughput for 12 re-readers 	= 5410601.12 kB/sec
>> 	Parent sees throughput for 12 re-readers 	= 5403504.40 kB/sec
>> 	Min throughput per process 			=  449918.12 kB/sec
>> 	Max throughput per process 			=  452489.28 kB/sec
>> 	Avg throughput per process 			=  450883.43 kB/sec
>> 	Min xfer 					= 1043456.00 kB
>> 	CPU utilization: Wall time    2.321    CPU time    1.978    CPU utilization  85.21 %
>> 
>> And here's c588072bba6b ("iommu/vt-d: Convert intel iommu driver to
>> the iommu ops"). Significant throughput loss.
>> 
>> 	Children see throughput for 12 initial writers 	= 3812036.91 kB/sec
>> 	Parent sees throughput for 12 initial writers 	= 3753683.40 kB/sec
>> 	Min throughput per process 			=  313672.25 kB/sec
>> 	Max throughput per process 			=  321719.44 kB/sec
>> 	Avg throughput per process 			=  317669.74 kB/sec
>> 	Min xfer 					= 1022464.00 kB
>> 	CPU Utilization: Wall time    3.309    CPU time    1.986    CPU utilization  60.02 %
>> 	Children see throughput for 12 rewriters 	= 3786831.94 kB/sec
>> 	Parent sees throughput for 12 rewriters 	= 3783205.58 kB/sec
>> 	Min throughput per process 			=  313654.44 kB/sec
>> 	Max throughput per process 			=  317844.50 kB/sec
>> 	Avg throughput per process 			=  315569.33 kB/sec
>> 	Min xfer 					= 1035520.00 kB
>> 	CPU utilization: Wall time    3.302    CPU time    1.945    CPU utilization  58.90 %
>> 	Children see throughput for 12 readers 		= 4265828.28 kB/sec
>> 	Parent sees throughput for 12 readers 		= 4261844.88 kB/sec
>> 	Min throughput per process 			=  352305.00 kB/sec
>> 	Max throughput per process 			=  357726.22 kB/sec
>> 	Avg throughput per process 			=  355485.69 kB/sec
>> 	Min xfer 					= 1032960.00 kB
>> 	CPU utilization: Wall time    2.934    CPU time    1.942    CPU utilization  66.20 %
>> 	Children see throughput for 12 re-readers 	= 4220651.19 kB/sec
>> 	Parent sees throughput for 12 re-readers 	= 4216096.04 kB/sec
>> 	Min throughput per process 			=  348677.16 kB/sec
>> 	Max throughput per process 			=  353467.44 kB/sec
>> 	Avg throughput per process 			=  351720.93 kB/sec
>> 	Min xfer 					= 1035264.00 kB
>> 	CPU utilization: Wall time    2.969    CPU time    1.952    CPU utilization  65.74 %
>> 
>> The regression appears to be 100% reproducible.

Any thoughts?

How about some tools to try or debugging advice? I don't know where to start.


--
Chuck Lever



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
