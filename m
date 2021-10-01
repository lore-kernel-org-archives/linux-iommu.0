Return-Path: <SRS0=Y/Kh=OV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6038C433F5
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 14:46:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E1C761A51
	for <iommu@archiver.kernel.org>; Fri,  1 Oct 2021 14:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E1C761A51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44280421DA;
	Fri,  1 Oct 2021 14:46:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bol04kIarlzU; Fri,  1 Oct 2021 14:46:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3226F40781;
	Fri,  1 Oct 2021 14:46:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E536DC0011;
	Fri,  1 Oct 2021 14:46:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01A30C000D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 14:46:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB6E341969
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 14:46:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ejtNmG2crADI for <iommu@lists.linux-foundation.org>;
 Fri,  1 Oct 2021 14:46:23 +0000 (UTC)
X-Greylist: delayed 00:09:09 by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BCAAD40781
 for <iommu@lists.linux-foundation.org>; Fri,  1 Oct 2021 14:46:23 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HLXkY0sk8z4xb7;
 Sat,  2 Oct 2021 00:37:09 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210930034454.95794-1-aik@ozlabs.ru>
References: <20210930034454.95794-1-aik@ozlabs.ru>
Subject: Re: [PATCH kernel] powerpc/iommu: Report the correct most efficient
 DMA mask for PCI devices
Message-Id: <163309900983.1612134.6469972296732099183.b4-ty@ellerman.id.au>
Date: Sat, 02 Oct 2021 00:36:49 +1000
MIME-Version: 1.0
Cc: Carol L Soto <clsoto@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
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

On Thu, 30 Sep 2021 13:44:54 +1000, Alexey Kardashevskiy wrote:
> According to dma-api.rst, the dma_get_required_mask() helper should return
> "the mask that the platform requires to operate efficiently". Which in
> the case of PPC64 means the bypass mask and not a mask from an IOMMU table
> which is shorter and slower to use due to map/unmap operations (especially
> expensive on "pseries").
> 
> However the existing implementation ignores the possibility of bypassing
> and returns the IOMMU table mask on the pseries platform which makes some
> drivers (mpt3sas is one example) choose 32bit DMA even though bypass is
> supported. The powernv platform sort of handles it by having a bigger
> default window with a mask >=40 but it only works as drivers choose
> 63/64bit if the required mask is >32 which is rather pointless.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/iommu: Report the correct most efficient DMA mask for PCI devices
      https://git.kernel.org/powerpc/c/23c216b335d1fbd716076e8263b54a714ea3cf0e

cheers
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
