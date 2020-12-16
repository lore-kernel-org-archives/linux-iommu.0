Return-Path: <SRS0=vTls=FU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34075C4361B
	for <iommu@archiver.kernel.org>; Wed, 16 Dec 2020 11:04:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2CB23371
	for <iommu@archiver.kernel.org>; Wed, 16 Dec 2020 11:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2CB23371
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9155687225;
	Wed, 16 Dec 2020 11:03:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MDTVnugg2Uja; Wed, 16 Dec 2020 11:03:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9441C87219;
	Wed, 16 Dec 2020 11:03:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51154C088E;
	Wed, 16 Dec 2020 11:03:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CE2FC013B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 11:03:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E0D1920500
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 11:03:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lkB8hvyO2-T9 for <iommu@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 11:03:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [207.82.80.151])
 by silver.osuosl.org (Postfix) with ESMTPS id CE2EE203E7
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 11:03:50 +0000 (UTC)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-94--UvXZFBAOeinyWm-PmDBBw-1; Wed, 16 Dec 2020 11:03:46 +0000
X-MC-Unique: -UvXZFBAOeinyWm-PmDBBw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 16 Dec 2020 11:03:46 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000; 
 Wed, 16 Dec 2020 11:03:46 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Yong Wu' <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH v3 4/7] iommu: Switch gather->end to unsigned long long
Thread-Topic: [PATCH v3 4/7] iommu: Switch gather->end to unsigned long long
Thread-Index: AQHW05fCvUUyI8/vv0eBmqh9Irindan5jgVQ
Date: Wed, 16 Dec 2020 11:03:46 +0000
Message-ID: <6b4a1d37a90f4663adf6b4adb9f80e2b@AcuMS.aculab.com>
References: <20201216103607.23050-1-yong.wu@mediatek.com>
 <20201216103607.23050-5-yong.wu@mediatek.com>
In-Reply-To: <20201216103607.23050-5-yong.wu@mediatek.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Cc: "youlin.pei@mediatek.com" <youlin.pei@mediatek.com>,
 "anan.sun@mediatek.com" <anan.sun@mediatek.com>,
 Nicolas Boichat <drinkcat@chromium.org>,
 "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
 "chao.hao@mediatek.com" <chao.hao@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Tomasz Figa <tfiga@google.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Greg Kroah-Hartman <gregkh@google.com>,
 "kernel-team@android.com" <kernel-team@android.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Yong Wu
> Sent: 16 December 2020 10:36
> 
> Currently gather->end is "unsigned long" which may be overflow in
> arch32 in the corner case: 0xfff00000 + 0x100000(iova + size).
> Although it doesn't affect the size(end - start), it affects the checking
> "gather->end < end"
> 
> Fixes: a7d20dc19d9e ("iommu: Introduce struct iommu_iotlb_gather for batching TLB flushes")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  include/linux/iommu.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 794d4085edd3..6e907a95d981 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -178,7 +178,7 @@ enum iommu_dev_features {
>   */
>  struct iommu_iotlb_gather {
>  	unsigned long		start;
> -	unsigned long		end;
> +	unsigned long long	end;
>  	size_t			pgsize;
>  };

Doesn't that add two pad words on many 32bit systems?
You probably ought to re-order the structure to keep the fields
on their natural boundaries.

I'm not sure what is being mapped here, but could it make sense
to just avoid using the highest addresses?
Then you never hit the problem.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
