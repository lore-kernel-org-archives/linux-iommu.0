Return-Path: <SRS0=5D8q=VO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50616C76188
	for <iommu@archiver.kernel.org>; Wed, 17 Jul 2019 03:38:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220B5206C2
	for <iommu@archiver.kernel.org>; Wed, 17 Jul 2019 03:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220B5206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DDBF9D90;
	Wed, 17 Jul 2019 03:38:45 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9DFE4D8E
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Jul 2019 02:50:43 +0000 (UTC)
X-Greylist: delayed 00:07:08 by SQLgrey-1.7.6
Received: from impout006.msg.chrl.nc.charter.net
	(impout006aa.msg.chrl.nc.charter.net [47.43.20.30])
	by smtp2.linuxfoundation.org (Postfix) with ESMTPS id D7E811DE21
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Jul 2019 02:50:42 +0000 (UTC)
Received: from [10.10.100.101] ([24.236.195.206]) by cmsmtp with ESMTPA
	id nZunhiEFjjcvSnZunhcKhc; Wed, 17 Jul 2019 02:43:33 +0000
Authentication-Results: charter.net; none
X-Authority-Analysis: v=2.3 cv=XPWEtjpE c=1 sm=1 tr=0
	a=mQKZifbrf9Y32dM5lNTaRA==:117 a=mQKZifbrf9Y32dM5lNTaRA==:17
	a=IkcTkHD0fZMA:10 a=3fyaaF4VAAAA:8 a=1asNQ19BmXUiVwYOiVQA:9
	a=QEXdDO2ut3YA:10 a=jOuFdahVONy5WApiBME_:22
From: Al Farleigh <AWFour@charter.net>
Subject: x86-64 kernel dma issue; bisected
To: iommu@lists.linux-foundation.org
Message-ID: <c04211d3-5e4a-daa2-4410-88c8c84e5735@charter.net>
Date: Tue, 16 Jul 2019 22:43:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
Content-Language: en-US
X-CMAE-Envelope: MS4wfMh6iKVEv/zl2+2U2TpbcxaKskDd+WsNMjlKkvFmoobEKqiUbvfUJ8f7RUofTkKln5AZClbkzrNpWR30UKUzHZVc/fr+Bl1ZtuyWFAon+vMEMXkzYrRM
	FFdYPby/eiUt6x2YfxnSnzdocCOyWYtFBS+7iMYf2ug3vIdiECeT4Y+8i91tR6zb2bwQBNz2gxjBfQ==
X-Mailman-Approved-At: Wed, 17 Jul 2019 03:38:44 +0000
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

re: the dma-direct code commit below

I have bisected the kernel to isolate a PCI board problem on my AMD 
x86-64 ASROCK system. The board worked at (Fedora kernel) 4.18.16 but 
stopped when moving to (Fedora kernel) 5.0. I then used 
(git/torvalds/linux) 4.20-rc4 or so to locate the fault via bisect.

I now have two kernels, good/bad, that straddle the commit.

I was asked to try v5.2 just in case it was fixed; I compiled it and the 
fault appears to still be present.

Simply, mpeg video does not stream from board; no errors, but no video.

My work is documented at
https://bugs.kde.org/show_bug.cgi?id=408004

including dmesgs, lspcis, and (second) git bisect log.

Could I please ask if and where I should submit a bug? and am willing to 
assist if I can.

Thank You!


-----

commit 55897af63091ebc2c3f239c6a6666f748113ac50
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Dec 3 11:43:54 2018 +0100

     dma-direct: merge swiotlb_dma_ops into the dma_direct code

     While the dma-direct code is (relatively) clean and simple we
     actually have to use the swiotlb ops for the mapping on many
     architectures due to devices with addressing limits.  Instead
     of keeping two implementations around this commit allows the
     dma-direct implementation to call the swiotlb bounce buffering
     functions and thus share the guts of the mapping implementation.
     This also simplified the dma-mapping setup on a few architectures
     where we don't have to differenciate which implementation to use.





_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
