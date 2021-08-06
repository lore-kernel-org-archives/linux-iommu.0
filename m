Return-Path: <SRS0=o7oR=M5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4377FC432BE
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 09:16:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30E7610FC
	for <iommu@archiver.kernel.org>; Fri,  6 Aug 2021 09:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D30E7610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8283A607A3;
	Fri,  6 Aug 2021 09:16:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NpUUt5w98dbA; Fri,  6 Aug 2021 09:16:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6195B605FC;
	Fri,  6 Aug 2021 09:16:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 362A8C0010;
	Fri,  6 Aug 2021 09:16:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECF3EC000E
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 09:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D8B9D402B8
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 09:16:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 327GjqZ6dJwO for <iommu@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 09:16:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49F65400C2
 for <iommu@lists.linux-foundation.org>; Fri,  6 Aug 2021 09:16:11 +0000 (UTC)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gh0Fd6jBTz6BCSP;
 Fri,  6 Aug 2021 17:15:49 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 6 Aug 2021 11:16:07 +0200
Received: from [10.47.24.8] (10.47.24.8) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 6 Aug 2021
 10:16:06 +0100
Subject: Re: [PATCH v3 23/25] iommu: Merge strictness and domain type configs
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
References: <cover.1628094600.git.robin.murphy@arm.com>
 <18f2757675b1a4d74d052b2b211e512ebf6e465e.1628094601.git.robin.murphy@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <3f383bf0-621a-9e3d-3c49-3e50c498b9f8@huawei.com>
Date: Fri, 6 Aug 2021 10:15:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <18f2757675b1a4d74d052b2b211e512ebf6e465e.1628094601.git.robin.murphy@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.24.8]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, dianders@chromium.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 rajatja@google.com, linux-arm-kernel@lists.infradead.org
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

On 04/08/2021 18:15, Robin Murphy wrote:
> To parallel the sysfs behaviour, merge the new build-time option
> for DMA domain strictness into the default domain type choice.
> 
> Suggested-by: Joerg Roedel<joro@8bytes.org>
> Reviewed-by: Lu Baolu<baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker<jean-philippe@linaro.org>
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

Reviewed-by: John Garry <john.garry@huawei.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
