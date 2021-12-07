Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D14C433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 12:04:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0B82A40533;
	Tue,  7 Dec 2021 12:04:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6DgqqRprYYHb; Tue,  7 Dec 2021 12:04:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7FDB040553;
	Tue,  7 Dec 2021 12:04:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B56EC001E;
	Tue,  7 Dec 2021 12:04:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AD1CC0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 12:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EEEA040553
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 12:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kFY7BW9xuJUa for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 12:04:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4025040533
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 12:04:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97E7911FB;
 Tue,  7 Dec 2021 04:04:38 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F11633F5A1;
 Tue,  7 Dec 2021 04:04:36 -0800 (PST)
Message-ID: <766ac58a-ffb7-f673-709b-0f0f740f3cfd@arm.com>
Date: Tue, 7 Dec 2021 12:04:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 3/3] perf/smmuv3: Synthesize IIDR from CoreSight ID
 registers
Content-Language: en-GB
To: John Garry <john.garry@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, robh+dt@kernel.org
References: <20211117144844.241072-1-jean-philippe@linaro.org>
 <20211117144844.241072-4-jean-philippe@linaro.org>
 <e60b15db-4e52-b5a6-1b17-203d250f1e65@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <e60b15db-4e52-b5a6-1b17-203d250f1e65@huawei.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, uchida.jun@socionext.com, leo.yan@linaro.org,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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

On 2021-12-07 09:14, John Garry wrote:
> On 17/11/2021 14:48, Jean-Philippe Brucker wrote:
>> From: Robin Murphy<robin.murphy@arm.com>
>>
>> The SMMU_PMCG_IIDR register was not present in older revisions of the
>> Arm SMMUv3 spec. On Arm Ltd. implementations, the IIDR value consists of
>> fields from several PIDR registers, allowing us to present a
>> standardized identifier to userspace.
>>
> So is there some userspace part to go with this now?

FWIW I've not looked into it - is it just a case of someone knocking out 
some JSON from the MMU-600/700 TRMs, or is there still mroe to do? I had 
the impression that *some* part of the process was stalled until 
implementations can start providing meaningful IIDRs, but I wasn't sure 
whether that was tooling or just data. I just work the low-level 
enablement angle :)

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
