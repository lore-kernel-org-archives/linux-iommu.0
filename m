Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08E3C433E0
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 16:23:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11D32558F
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 16:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11D32558F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9700322658;
	Mon, 29 Jun 2020 16:23:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P6aWrXZDGxOo; Mon, 29 Jun 2020 16:23:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C9F7B20425;
	Mon, 29 Jun 2020 16:23:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B26A5C0865;
	Mon, 29 Jun 2020 16:23:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAA88C016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 16:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D9AD7887D1
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 16:23:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UfZ2baJueKjU for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 16:23:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5EDB7887A5
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 16:23:35 +0000 (UTC)
IronPort-SDR: pYmzjX9xfXSNVrDzJQ6McwiKAnUzd6ZgfmW3dVGxzsFHTCvMoYpDtDiHYsuoUGTKb1QZq8dN9R
 vkO2iDdBWczg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="144187165"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; d="scan'208";a="144187165"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2020 09:23:35 -0700
IronPort-SDR: ew6c6XfsnDZieu6Kj7KBL7Ukg7p0HAZg9LfTg3/OJyk7NWtYn8Fhv36+W/Fj20mUDTdHWxEjGm
 SNR0uj/5R7IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; d="scan'208";a="313096285"
Received: from unknown (HELO btopel-mobl.ger.intel.com) ([10.252.54.90])
 by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2020 09:23:32 -0700
Subject: Re: [PATCH net] xsk: remove cheap_dma optimization
To: Daniel Borkmann <daniel@iogearbox.net>, Christoph Hellwig <hch@lst.de>
References: <20200626134358.90122-1-bjorn.topel@gmail.com>
 <c60dfb5a-2bf3-20bd-74b3-6b5e215f73f8@iogearbox.net>
 <20200627070406.GB11854@lst.de>
 <88d27e1b-dbda-301c-64ba-2391092e3236@intel.com>
 <e879bcc8-5f7d-b1b3-9b66-1032dec6245d@iogearbox.net>
 <81aec200-c1a0-6d57-e3b6-26dad30790b8@intel.com>
 <903c646c-dc74-a15c-eb33-e1b67bc7da0d@iogearbox.net>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Message-ID: <fa7ffbe4-f863-7dd9-f833-4054a2baa149@intel.com>
Date: Mon, 29 Jun 2020 18:23:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <903c646c-dc74-a15c-eb33-e1b67bc7da0d@iogearbox.net>
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

Ck9uIDIwMjAtMDYtMjkgMTc6MTgsIERhbmllbCBCb3JrbWFubiB3cm90ZToKPiBOaWNlLCB0b3Nz
ZWQgZnJvbSBicGYgdHJlZSB0aGVuISAoTG9va3MgbGlrZSBpdCBkaWRuJ3QgbGFuZCBvbiB0aGUg
YnBmIAo+IGxpc3QgeWV0LAo+IGJ1dCBzZWVtcyBvdGhlciBtYWlscyBhcmUgY3VycmVudGx5IHN0
dWNrIGFzIHdlbGwgb24gdmdlci4gSSBwcmVzdW1lIGl0IAo+IHdpbGwgYmUKPiByb3V0ZWQgdG8g
TGludXMgdmlhIENocmlzdG9waD8pCgpUaGFua3MhCgpDaHJpc3RvcGggKGFjY29yZGluZyB0byB0
aGUgb3RoZXIgbWFpbCkgd2FzIE9LIHRha2luZyB0aGUgc2VyaWVzIHZpYSAKeW91ciBicGYsIERh
dmUncyBuZXQsIG9yIGhpcyBkbWEtbWFwcGluZyB0cmVlLgoKCkJqw7ZybgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9t
bXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
