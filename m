Return-Path: <SRS0=bJ3n=6P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F319C47253
	for <iommu@archiver.kernel.org>; Fri,  1 May 2020 13:54:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535772051A
	for <iommu@archiver.kernel.org>; Fri,  1 May 2020 13:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535772051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 25D658821F;
	Fri,  1 May 2020 13:54:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A2C0vozKP4FC; Fri,  1 May 2020 13:54:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B5E4C8820C;
	Fri,  1 May 2020 13:54:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A944DC088D;
	Fri,  1 May 2020 13:54:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7A1EC016F
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 13:54:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A40EF8821F
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 13:54:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tzE4TE7BVDVY for <iommu@lists.linux-foundation.org>;
 Fri,  1 May 2020 13:54:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from cmccmta3.chinamobile.com (cmccmta3.chinamobile.com
 [221.176.66.81])
 by hemlock.osuosl.org (Postfix) with ESMTP id CFA508820C
 for <iommu@lists.linux-foundation.org>; Fri,  1 May 2020 13:54:06 +0000 (UTC)
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by
 rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5eac29d8f14-dc2d1;
 Fri, 01 May 2020 21:53:31 +0800 (CST)
X-RM-TRANSID: 2eec5eac29d8f14-dc2d1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.0.104] (unknown[112.1.172.204])
 by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45eac29d99fd-e9ba9;
 Fri, 01 May 2020 21:53:31 +0800 (CST)
X-RM-TRANSID: 2ee45eac29d99fd-e9ba9
Subject: Re: [PATCH v2]iommu/qcom:fix local_base status check
To: Joerg Roedel <joro@8bytes.org>
References: <20200418134703.1760-1-tangbin@cmss.chinamobile.com>
 <20200501113745.GE18423@8bytes.org>
From: Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <f59a9807-e804-5331-4ba6-ddcc8cc78f8b@cmss.chinamobile.com>
Date: Fri, 1 May 2020 21:54:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200501113745.GE18423@8bytes.org>
Content-Language: en-US
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, agross@kernel.org, bjorn.andersson@linaro.org
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


On 2020/5/1 19:37, Joerg Roedel wrote:
> On Sat, Apr 18, 2020 at 09:47:03PM +0800, Tang Bin wrote:
>> The function qcom_iommu_device_probe() does not perform sufficient
>> error checking after executing devm_ioremap_resource(), which can
>> result in crashes if a critical error path is encountered.
>>
>> Fixes: 0ae349a0f33f ("iommu/qcom: Add qcom_iommu")
>>
>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>> ---
>> v2:
>>   - fix commit message and add fixed tag
>> ---
>>   drivers/iommu/qcom_iommu.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
> Applied for v5.7, thanks.

Thank you very much.

Tang Bin

>


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
