Return-Path: <SRS0=HAoA=WF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DC6C433FF
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 17:11:18 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D8320820
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 17:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D8320820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DF909C75;
	Fri,  9 Aug 2019 17:11:17 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4D7E7B79
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 17:11:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id BBC1867F
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 17:11:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7122415A2;
	Fri,  9 Aug 2019 10:11:16 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F9E03F575;
	Fri,  9 Aug 2019 10:11:13 -0700 (PDT)
Subject: Re: [PATCH 00/15] Arm SMMU refactoring
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
References: <cover.1565369764.git.robin.murphy@arm.com>
Message-ID: <92ded198-4bee-2440-0f31-da590c9bf0d2@arm.com>
Date: Fri, 9 Aug 2019 18:11:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cover.1565369764.git.robin.murphy@arm.com>
Content-Language: en-GB
Cc: gregory.clement@bootlin.com, iommu@lists.linux-foundation.org,
	bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org
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

...and of course I had to forget someone's cc - sorry Jordan! :(

Robin.

On 09/08/2019 18:07, Robin Murphy wrote:
> Hi all,
> 
> This is a big refactoring of arm-smmu in order to help cope with the
> various divergent implementation details currently flying around. So
> far we've been accruing various quirks and errata workarounds within
> the main flow of the driver, but given that it's written to an
> architecture rather than any particular hardware implementation, after
> a point these start to become increasingly invasive and potentially
> conflict with each other.
> 
> These patches clean up the existing quirks handled by the driver to
> lay a foundation on which we can continue to add more in a maintainable
> fashion. The idea is that major vendor customisations can then be kept
> in arm-smmu-<vendor>.c implementation files out of each others' way.
> 
> A branch is available at:
> 
>    git://linux-arm.org/linux-rm  iommu/smmu-impl
> 
> which I'll probably keep tweaking until I'm happy with the names of
> things; I just didn't want to delay this initial posting any lomnger.
> 
> Robin.
> 
> 
> Robin Murphy (15):
>    iommu/arm-smmu: Convert GR0 registers to bitfields
>    iommu/arm-smmu: Convert GR1 registers to bitfields
>    iommu/arm-smmu: Convert context bank registers to bitfields
>    iommu/arm-smmu: Rework cb_base handling
>    iommu/arm-smmu: Split arm_smmu_tlb_inv_range_nosync()
>    iommu/arm-smmu: Get rid of weird "atomic" write
>    iommu/arm-smmu: Abstract GR1 accesses
>    iommu/arm-smmu: Abstract context bank accesses
>    iommu/arm-smmu: Abstract GR0 accesses
>    iommu/arm-smmu: Rename arm-smmu-regs.h
>    iommu/arm-smmu: Add implementation infrastructure
>    iommu/arm-smmu: Move Secure access quirk to implementation
>    iommu/arm-smmu: Add configuration implementation hook
>    iommu/arm-smmu: Add reset implementation hook
>    iommu/arm-smmu: Add context init implementation hook
> 
>   MAINTAINERS                   |   3 +-
>   drivers/iommu/Makefile        |   2 +-
>   drivers/iommu/arm-smmu-impl.c | 165 ++++++++++
>   drivers/iommu/arm-smmu-regs.h | 210 -------------
>   drivers/iommu/arm-smmu.c      | 570 +++++++++++-----------------------
>   drivers/iommu/arm-smmu.h      | 386 +++++++++++++++++++++++
>   drivers/iommu/qcom_iommu.c    |  15 +-
>   7 files changed, 743 insertions(+), 608 deletions(-)
>   create mode 100644 drivers/iommu/arm-smmu-impl.c
>   delete mode 100644 drivers/iommu/arm-smmu-regs.h
>   create mode 100644 drivers/iommu/arm-smmu.h
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
