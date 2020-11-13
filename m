Return-Path: <SRS0=vtxH=ET=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3832C5519F
	for <iommu@archiver.kernel.org>; Fri, 13 Nov 2020 00:41:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EFF2076E
	for <iommu@archiver.kernel.org>; Fri, 13 Nov 2020 00:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EFF2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8925887214;
	Fri, 13 Nov 2020 00:41:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dQOrTh53qWD3; Fri, 13 Nov 2020 00:41:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6934B86D78;
	Fri, 13 Nov 2020 00:41:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AE26C163C;
	Fri, 13 Nov 2020 00:41:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAF82C0FAA
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 00:41:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 94C9F86E31
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 00:41:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OfwvpNsApu3j for <iommu@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 00:41:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D287186E2C
 for <iommu@lists.linux-foundation.org>; Fri, 13 Nov 2020 00:41:26 +0000 (UTC)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CXKQX5jPQzLmVr;
 Fri, 13 Nov 2020 08:41:08 +0800 (CST)
Received: from [10.174.179.182] (10.174.179.182) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 08:41:14 +0800
Subject: Re: [PATCH v8 5/9] ACPI/IORT: Enable stall support for platform
 devices
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, <joro@8bytes.org>,
 <will@kernel.org>, <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
 <20201112125519.3987595-6-jean-philippe@linaro.org>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <f266330a-4c06-d33d-96a1-d703a6b7e76b@huawei.com>
Date: Fri, 13 Nov 2020 08:41:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201112125519.3987595-6-jean-philippe@linaro.org>
Content-Language: en-GB
X-Originating-IP: [10.174.179.182]
X-CFilter-Loop: Reflected
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, bhelgaas@google.com, zhangfei.gao@linaro.org,
 vivek.gautam@arm.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

On 2020/11/12 20:55, Jean-Philippe Brucker wrote:
> Copy the "Stall supported" bit, that tells whether a platform device
> supports stall, into the fwspec struct.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Hanjun Guo <guohanjun@huawei.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
