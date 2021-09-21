Return-Path: <SRS0=55Rd=OL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24E7C433F5
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 17:12:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3494C61166
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 17:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3494C61166
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E1D7E403FF;
	Tue, 21 Sep 2021 17:12:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GNCSGinf1-5s; Tue, 21 Sep 2021 17:12:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8CE274020E;
	Tue, 21 Sep 2021 17:12:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65CCAC000F;
	Tue, 21 Sep 2021 17:12:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B81AC000D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 17:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1806760C06
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 17:12:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amazon.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cuKMJ6r1UyYD for <iommu@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 17:12:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57C766080D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 17:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1632244357; x=1663780357;
 h=from:to:cc:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version:subject;
 bh=16YU7KkjpiOEAKPRsxoOGSp6GaxRIbNZG8DW2Dc8Nxc=;
 b=Jyjo6k/LTyjXmUSUThCLMCe+36gC6HfzJ/Uc/z2iuIEP/Lk/HO6sRkti
 Rr4OFuDgxJyIrUNai9VQueFt1tlVnS8Eg1mEgKlWaICQJRl6P7bo/0vN3
 B2Nf62YwG5V+ont55l2GJhT9h1x7pW/aj4TcenD/GNTmwilLl1iVgySc9 g=;
X-IronPort-AV: E=Sophos;i="5.85,311,1624320000"; d="scan'208";a="143494894"
Subject: Re: [PATCH] iommu/arm-smmu-v3: poll cmdq until it has space
Thread-Topic: [PATCH] iommu/arm-smmu-v3: poll cmdq until it has space
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-iad-1d-1c3c2014.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-6001.iad6.amazon.com with ESMTP; 21 Sep 2021 17:12:29 +0000
Received: from EX13D03EUA004.ant.amazon.com
 (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
 by email-inbound-relay-iad-1d-1c3c2014.us-east-1.amazon.com (Postfix) with
 ESMTPS id 947D5CB307; Tue, 21 Sep 2021 17:12:27 +0000 (UTC)
Received: from EX13D03EUA004.ant.amazon.com (10.43.165.93) by
 EX13D03EUA004.ant.amazon.com (10.43.165.93) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Tue, 21 Sep 2021 17:12:26 +0000
Received: from EX13D03EUA004.ant.amazon.com ([10.43.165.93]) by
 EX13D03EUA004.ant.amazon.com ([10.43.165.93]) with mapi id 15.00.1497.023;
 Tue, 21 Sep 2021 17:12:26 +0000
To: John Garry <john.garry@huawei.com>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
Thread-Index: AQHXrt3+ZWYnaFhO3kmkBSrWrVwBSauurBkAgAAMX78=
Date: Tue, 21 Sep 2021 17:12:25 +0000
Message-ID: <1632244345526.44611@amazon.com>
References: <20210921114338.1144521-1-sieberf@amazon.com>,
 <c1c10203-ffd3-25f9-f2c6-9cee3458aac9@huawei.com>
In-Reply-To: <c1c10203-ffd3-25f9-f2c6-9cee3458aac9@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.90]
MIME-Version: 1.0
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
From: "Sieber, Fernand via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Sieber, Fernand" <sieberf@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi John,

> But is the polarity really correct? That is, if we don't have space,
> then exit with success (the function to check for space).

You are absolutely correct, this is a mistake that I made as I was resolving conflicts while porting this patch to iommu/next from 5.4 where I implemented and tested it.
It should be:

> -             if (!queue_full(llq))
> +             if (queue_has_space(llq, n))


> what is llq->state->val?

This is an other oversight for the same reason, llq->state->val has since then been renamed llq->val

Will fix both of these in the next revision.
Thanks and kind regards,

--Fernand

________________________________________
From: John Garry <john.garry@huawei.com>
Sent: Tuesday, September 21, 2021 18:22
To: Sieber, Fernand; will@kernel.org; robin.murphy@arm.com
Cc: linux-arm-kernel@lists.infradead.org; iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
Subject: RE: [EXTERNAL] [PATCH] iommu/arm-smmu-v3: poll cmdq until it has space

CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.



On 21/09/2021 12:43, Fernand Sieber wrote:
>       do {

I didn't follow the full logic of this change yet ...

>               llq->val = READ_ONCE(cmdq->q.llq.val);
> -             if (!queue_full(llq))
> +             if (!queue_has_space(llq, n))

But is the polarity really correct? That is, if we don't have space,
then exit with success (the function to check for space).

>                       break;
>
> +             /*
> +              * We must return here even if there's no space, because the producer
> +              * having moved forward could mean that the last thread observing the
> +              * SMMU progress has allocated space in the cmdq and moved on, leaving
> +              * us in this waiting loop with no other thread updating
> +              * llq->state->val.

what is llq->state->val?

> +              */
> +             if (llq->prod != prod)
> +                     return -EAGAIN;
> +
>               ret = queue_poll(&qp);

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
