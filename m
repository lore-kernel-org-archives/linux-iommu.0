Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB2BC433F5
	for <iommu@archiver.kernel.org>; Fri,  4 Feb 2022 12:36:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D12482F51;
	Fri,  4 Feb 2022 12:36:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aQZj7xwSw3fJ; Fri,  4 Feb 2022 12:36:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2D33C82CF9;
	Fri,  4 Feb 2022 12:36:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D16AC001A;
	Fri,  4 Feb 2022 12:36:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACCF6C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 12:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A98CC82F32
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 12:36:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1GSPVF__7_Ch for <iommu@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 12:36:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id D334C82CF9
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 12:36:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E40A311D4;
 Fri,  4 Feb 2022 04:35:59 -0800 (PST)
Received: from [10.57.68.47] (unknown [10.57.68.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 621133F40C;
 Fri,  4 Feb 2022 04:35:58 -0800 (PST)
Message-ID: <903818af-5cec-bfdd-6c03-69e6c4f29604@arm.com>
Date: Fri, 4 Feb 2022 12:35:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: iommu non-strict mode for arm64
Content-Language: en-GB
To: Josh Poimboeuf <jpoimboe@redhat.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
References: <20220204054616.cfqhygo3v7amrzvp@treble>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220204054616.cfqhygo3v7amrzvp@treble>
Cc: linux-kernel@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-02-04 05:46, Josh Poimboeuf wrote:
> Hi all,
> 
> We've gotten significant slowdowns on arm64 with 4k pages compared to
> 64k.  The slowdowns can be alleviated by setting iommu.strict=0 or
> iommu.passthrough=1.
> 
> Is there a reason x86 defaults to lazy iommu, while arm64 does not?  Are
> there security implications which are specific to arm64?

The x86 behaviour is basically 2 decades of legacy where nobody now 
feels brave enough to flip the default. At the time the arm64 IOMMU DMA 
ops were first added, strict mode was the only thing feasible to 
implement, but there was also a conscious consideration that having a 
default assumption of "IOMMU == more protection" wasn't a bad thing 
anyway. Given what played out a couple of years later, and everyone now 
being that much more security-aware, I think that decision has only been 
reinforced.

Passthrough and non-strict mode in iommu-dma only came along later, and 
most IOMMU drivers for arm64 still don't support them, which is another 
reason I'm still against changing the default today. However, if you're 
confident that your arm64 users care more about high-bandwidth I/O 
throughput than memory protection then feel free to set 
IOMMU_DEFAULT_DMA_LAZY or IOMMU_DEFAULT_PASSTHROUGH in your config.

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
