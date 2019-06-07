Return-Path: <SRS0=pxo5=UG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1CCC2BCA1
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 10:40:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49DB320B7C
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 10:40:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DB320B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2A22FF0A;
	Fri,  7 Jun 2019 10:40:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F217BF03
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 10:40:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6217E623
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 10:40:08 +0000 (UTC)
Received: from ns.iliad.fr (localhost [127.0.0.1])
	by ns.iliad.fr (Postfix) with ESMTP id 28F4F1FFF7;
	Fri,  7 Jun 2019 12:40:06 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
	by ns.iliad.fr (Postfix) with ESMTP id 1176D1FF7C;
	Fri,  7 Jun 2019 12:40:06 +0200 (CEST)
Subject: Re: [PATCH v3] iommu/arm-smmu: Avoid constant zero in TLBI writes
To: Joerg Roedel <joro@8bytes.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>
References: <f523effd-ef81-46fe-1f9e-1a0cb42c8b7b@free.fr>
	<20190529130559.GB11023@fuggles.cambridge.arm.com>
	<84791515-e0ae-0322-78aa-02ca0b40d157@free.fr>
	<09a290f1-27a0-5ee3-16b9-659ef2ba99dc@free.fr>
	<20190605121900.GJ15030@fuggles.cambridge.arm.com>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <f7b2e799-e3b1-ad40-c7b7-153f00323636@free.fr>
Date: Fri, 7 Jun 2019 12:40:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605121900.GJ15030@fuggles.cambridge.arm.com>
Content-Language: en-US
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ;
	Fri Jun  7 12:40:06 2019 +0200 (CEST)
Cc: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
	MSM <linux-arm-msm@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
	iommu <iommu@lists.linux-foundation.org>, Andy Gross <agross@kernel.org>,
	AngeloGioacchino Del Regno <kholk11@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 05/06/2019 14:19, Will Deacon wrote:

> On Mon, Jun 03, 2019 at 02:15:37PM +0200, Marc Gonzalez wrote:
>
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> Apparently, some Qualcomm arm64 platforms which appear to expose their
>> SMMU global register space are still, in fact, using a hypervisor to
>> mediate it by trapping and emulating register accesses. Sadly, some
>> deployed versions of said trapping code have bugs wherein they go
>> horribly wrong for stores using r31 (i.e. XZR/WZR) as the source
>> register.
>>
>> While this can be mitigated for GCC today by tweaking the constraints
>> for the implementation of writel_relaxed(), to avoid any potential
>> arms race with future compilers more aggressively optimising register
>> allocation, the simple way is to just remove all the problematic
>> constant zeros. For the write-only TLB operations, the actual value is
>> irrelevant anyway and any old nearby variable will provide a suitable
>> GPR to encode. The one point at which we really do need a zero to clear
>> a context bank happens before any of the TLB maintenance where crashes
>> have been reported, so is apparently not a problem... :/
>>
>> Reported-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
>> Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Joerg -- Please can you take this as a fix for 5.2, with a Cc stable?

Hello Joerg,

Can you ping this thread once this patch hits linux-next, so I can
ask Bjorn to pick up the 8998 ANOC1 DT node, and the PCIe DT node
that requires ANOC1.

Bjorn: for ANOC1, a small fixup: s/arm,smmu/iommu/

https://patchwork.kernel.org/project/linux-arm-msm/list/?series=99701
https://patchwork.kernel.org/patch/10895341/

Regards.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
