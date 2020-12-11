Return-Path: <SRS0=kesm=FP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642ECC4361B
	for <iommu@archiver.kernel.org>; Fri, 11 Dec 2020 18:57:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E4923F29
	for <iommu@archiver.kernel.org>; Fri, 11 Dec 2020 18:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E4923F29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=sect.tu-berlin.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1E0DF8749D;
	Fri, 11 Dec 2020 18:57:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id opDETqQUevdo; Fri, 11 Dec 2020 18:57:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0160787440;
	Fri, 11 Dec 2020 18:57:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D391CC0FA7;
	Fri, 11 Dec 2020 18:57:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60D77C013B;
 Fri, 11 Dec 2020 17:33:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4DC0E86EC6;
 Fri, 11 Dec 2020 17:33:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7otXC-Ik2nyy; Fri, 11 Dec 2020 17:33:47 +0000 (UTC)
X-Greylist: delayed 00:05:58 by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from exchange.tu-berlin.de (exchange.tu-berlin.de [130.149.7.70])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4A99786C73;
 Fri, 11 Dec 2020 17:33:47 +0000 (UTC)
Received: from SPMA-01.tubit.win.tu-berlin.de (localhost.localdomain
 [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 17BBF7E03D2_FD3AC13B;
 Fri, 11 Dec 2020 17:27:47 +0000 (GMT)
Received: from exchange.tu-berlin.de (exchange.tu-berlin.de [130.149.7.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client CN "exchange.tu-berlin.de",
 Issuer "DFN-Verein Global Issuing CA" (verified OK))
 by SPMA-01.tubit.win.tu-berlin.de (Sophos Email Appliance) with ESMTPS id
 BBADF7DBD42_FD3AC12F; Fri, 11 Dec 2020 17:27:46 +0000 (GMT)
Received: from [192.168.1.8] (91.64.84.74) by ex-02.tubit.win.tu-berlin.de
 (172.26.26.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.529.5; Fri, 11 Dec 2020
 18:27:46 +0100
To: <virtualization@lists.linux-foundation.org>,
 <iommu@lists.linux-foundation.org>
From: Felicitas Hetzelt <file@sect.tu-berlin.de>
Subject: swiotlb/virtio: unchecked device dma address and length
Message-ID: <d2ae0b1d-332b-42a1-87bf-7da2b749cac2@sect.tu-berlin.de>
Date: Fri, 11 Dec 2020 18:31:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
Content-Language: en-US
X-ClientProxiedBy: ex-03.tubit.win.tu-berlin.de (172.26.26.164) To
 ex-02.tubit.win.tu-berlin.de (172.26.26.163)
X-SASI-RCODE: 200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-berlin.de;
 h=to:cc:from:subject:message-id:date:mime-version:content-type:content-transfer-encoding;
 s=dkim-tub; bh=8rSY1R2pGMx93SfLPdXVjUsole9TQlrbbw1N+MlwkiE=;
 b=drIrtgEbH0U5f3OmKWDzXzTMS1fSA5kOycAN4cMyYxF8wldqP/Yaw3+tABCAurzzX0Scr+58SlTfxh2+6savts1FEwGgpsSr1LCZy11rSqr96MGQqOa86GoqlRT7kk6dnU/iV8Nu0fMAKJqGeByVqOh196rY3SsgNQlMOMyGRWk=
X-Mailman-Approved-At: Fri, 11 Dec 2020 18:57:19 +0000
Cc: "Radev, Martin" <martin.radev@aisec.fraunhofer.de>, david.kaplan@amd.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 konrad.wilk@oracle.com, Robert Buhren <robert@sect.tu-berlin.de>, "Morbitzer,
 Mathias" <mathias.morbitzer@aisec.fraunhofer.de>
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

Hello,
we have been analyzing the Hypervisor-OS interface of Linux
and discovered bugs in the swiotlb/virtio implementation that can be
triggered from a malicious Hypervisor / virtual device.
With SEV, the SWIOTLB implementation is forcefully enabled and would
always be used. Thus, all virtio devices and others would use it under
the hood.

The reason for analyzing this interface is that, technologies such as
Intel's Trusted Domain Extensions [1] and AMD's Secure Nested Paging [2]
change the threat model assumed by various Linux kernel subsystems.
These technologies take the presence of a fully malicious hypervisor
into account and aim to provide protection for virtual machines in such
an environment. Therefore, all input received from the hypervisor or an
external device should be carefully validated. Note that these issues
are of little (or no) relevance in a "normal" virtualization setup,
nevertheless we believe that it is required to fix them if TDX or SNP is
used.

We are happy to provide more information if needed!

[1]
https://software.intel.com/content/www/us/en/develop/articles/intel-trust-domain-extensions.html

[2] https://www.amd.com/en/processors/amd-secure-encrypted-virtualization

Bug:
OOB memory write.
dma_unmap_single -> swiotlb_tbl_unmap_single is invoked with dma_addr
and length parameters that are under control of the device.
This happens e.g. in virtio_ring:
https://elixir.bootlin.com/linux/v5.10-rc7/source/drivers/virtio/virtio_ring.c#L378

This raises two issues:
1) swiotlb_tlb_unmap_single fails to check whether the index generated
from the dma_addr is in range of the io_tlb_orig_addr array.
2) when swiotlb_bounce is called the device controls the length of the
memory copied to the cpu address.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
