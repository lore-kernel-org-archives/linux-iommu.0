Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DFAC433E0
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 15:11:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D2E23E54
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 15:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D2E23E54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9508C2286C;
	Mon, 29 Jun 2020 15:11:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h5hkk4Ehcxzx; Mon, 29 Jun 2020 15:11:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8C57D2284F;
	Mon, 29 Jun 2020 15:11:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 555BAC0865;
	Mon, 29 Jun 2020 15:11:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3397C016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 15:11:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9E90D88783
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 15:11:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b3gKiCo5XSBI for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 15:11:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CFEBD888CE
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 15:10:47 +0000 (UTC)
IronPort-SDR: /FrJsXulYSMSOE41TVFgY0rVaB21vq095No4UHhJhHE/3TZXodu2GQM27OS7CTmbYtQjKFkRyv
 gThYHLDAWMsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="147536781"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; d="scan'208";a="147536781"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2020 08:10:46 -0700
IronPort-SDR: mw6GdldLIMHUg1p42ZqiigUai0KEvZPO4JmOhxUKKwkLU1eWIPjoi4leEGe+trp6TiAwM03dva
 0x/VdwNad0nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; d="scan'208";a="313073307"
Received: from unknown (HELO btopel-mobl.ger.intel.com) ([10.252.54.90])
 by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2020 08:10:43 -0700
Subject: Re: [PATCH net] xsk: remove cheap_dma optimization
To: Daniel Borkmann <daniel@iogearbox.net>, Christoph Hellwig <hch@lst.de>
References: <20200626134358.90122-1-bjorn.topel@gmail.com>
 <c60dfb5a-2bf3-20bd-74b3-6b5e215f73f8@iogearbox.net>
 <20200627070406.GB11854@lst.de>
 <88d27e1b-dbda-301c-64ba-2391092e3236@intel.com>
 <e879bcc8-5f7d-b1b3-9b66-1032dec6245d@iogearbox.net>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Message-ID: <81aec200-c1a0-6d57-e3b6-26dad30790b8@intel.com>
Date: Mon, 29 Jun 2020 17:10:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <e879bcc8-5f7d-b1b3-9b66-1032dec6245d@iogearbox.net>
Content-Language: en-US
Cc: maximmi@mellanox.com, konrad.wilk@oracle.com, jonathan.lemon@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 magnus.karlsson@intel.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjAyMC0wNi0yOSAxNTo1MiwgRGFuaWVsIEJvcmttYW5uIHdyb3RlOgo+IAo+IE9rLCBmYWly
IGVub3VnaCwgcGxlYXNlIHdvcmsgd2l0aCBETUEgZm9sa3MgdG8gZ2V0IHRoaXMgcHJvcGVybHkg
Cj4gaW50ZWdyYXRlZCBhbmQKPiByZXN0b3JlZCB0aGVuLiBBcHBsaWVkLCB0aGFua3MhCgpEYW5p
ZWwsIHlvdSB3ZXJlIHRvbyBxdWljayEgUGxlYXNlIHJldmVydCB0aGlzIG9uZTsgQ2hyaXN0b3Bo
IGp1c3QgCnN1Ym1pdHRlZCBhIDQtcGF0Y2gtc2VyaWVzIHRoYXQgYWRkcmVzc2VzIGJvdGggdGhl
IERNQSBBUEksIGFuZCB0aGUgcGVyZiAKcmVncmVzc2lvbiEKCgpCasO2cm4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
