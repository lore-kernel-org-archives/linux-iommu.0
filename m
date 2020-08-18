Return-Path: <SRS0=kAxJ=B4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE87FC433E1
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 00:49:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C803620789
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 00:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C803620789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9DDFA85700;
	Tue, 18 Aug 2020 00:49:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cWwecBJlvFC4; Tue, 18 Aug 2020 00:49:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 15C1784626;
	Tue, 18 Aug 2020 00:49:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0110C07FF;
	Tue, 18 Aug 2020 00:49:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B72E7C0051
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 00:49:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9EA5E87089
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 00:49:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tvpO5ltUBMes for <iommu@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 00:49:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7F50F8707A
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 00:49:33 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id BB02D617EC3729C72B1C;
 Tue, 18 Aug 2020 08:49:28 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.33) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 18 Aug 2020
 08:49:19 +0800
Subject: Re: [PATCH v2 01/12] ACPI/IORT: Make iort_match_node_callback walk
 the ACPI namespace for NC
From: Hanjun Guo <guohanjun@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-2-lorenzo.pieralisi@arm.com>
 <718cae1f-2f33-f6d9-f278-157300b73116@huawei.com>
 <20200629090551.GA28873@e121166-lin.cambridge.arm.com>
 <765078e7-b3ec-af5d-0405-7834ba0f120a@huawei.com>
 <20200630102454.GA17556@e121166-lin.cambridge.arm.com>
 <4817d766-0437-5356-a0b9-97b111d4cae2@huawei.com>
 <952a6720-f401-1441-5548-5b40cfc76d3a@arm.com>
 <0cbd1da8-e283-7e13-d2b3-4d14775fd870@huawei.com>
Message-ID: <1c0b1657-8d45-7075-ee2c-3abfdd801006@huawei.com>
Date: Tue, 18 Aug 2020 08:49:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <0cbd1da8-e283-7e13-d2b3-4d14775fd870@huawei.com>
Content-Language: en-GB
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Cc: devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 linux-pci@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Makarand Pawagi <makarand.pawagi@nxp.com>, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On 2020/7/2 16:22, Hanjun Guo wrote:
> 
> As I said in previous email, I'm not against this patch, and seems
> have no regressions for platforms that using named component node
> such as D05/D06 (I will test it shortly to make sure), but it's better
> to update the wording of the spec (even after this patch set is merged).

I can see that IORT revision E was updated to add IMP_DEF input
IDs in ID mappings for Named Component nodes, thanks for that.

Thanks
Hanjun

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
