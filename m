Return-Path: <SRS0=8AL1=AI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697A9C433E0
	for <iommu@archiver.kernel.org>; Sat, 27 Jun 2020 16:21:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF0C20724
	for <iommu@archiver.kernel.org>; Sat, 27 Jun 2020 16:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF0C20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CCC8386126;
	Sat, 27 Jun 2020 16:21:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XGIPE-ZzbWY6; Sat, 27 Jun 2020 16:21:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 390B185BCA;
	Sat, 27 Jun 2020 16:21:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0296EC0865;
	Sat, 27 Jun 2020 16:21:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6772EC016F
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 16:21:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4EBEA86B47
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 16:21:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N6JoYdbSUg56 for <iommu@lists.linux-foundation.org>;
 Sat, 27 Jun 2020 16:21:32 +0000 (UTC)
X-Greylist: delayed 00:07:40 by SQLgrey-1.7.6
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr
 [80.12.242.124])
 by whitealder.osuosl.org (Postfix) with ESMTP id C1D9B86B17
 for <iommu@lists.linux-foundation.org>; Sat, 27 Jun 2020 16:21:31 +0000 (UTC)
Received: from [192.168.42.210] ([93.22.39.177]) by mwinf5d03 with ME
 id wGDk2200B3pKrM103GDkec; Sat, 27 Jun 2020 18:13:48 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 27 Jun 2020 18:13:48 +0200
X-ME-IP: 93.22.39.177
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
To: Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
References: <20200608132217.29945-1-geert@linux-m68k.org>
 <20200620200936.GA106151@roeck-us.net> <20200624073815.GE18609@lst.de>
From: Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <6473db8e-4116-c994-aa08-6b50a6c609fb@wanadoo.fr>
Date: Sat, 27 Jun 2020 18:13:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624073815.GE18609@lst.de>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 David Rientjes <rientjes@google.com>, Robin Murphy <robin.murphy@arm.com>
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

CkxlIDI0LzA2LzIwMjAgw6AgMDk6MzgsIENocmlzdG9waCBIZWxsd2lnIGEgw6ljcml0wqA6Cj4g
SGkgR3VlbnRlciwKPgo+IGNhbiB5b3UgdHJ5IHRoZSBwYXRjaCBiZWxvdz8gIFRoaXMganVzdCBj
b252ZXJ0cyB0aGUgaHVnZSBhbGxvY2F0aW9ucwo+IGluIG1wdGJhc2UgdG8gdXNlIEdGUF9LRVJO
RUwuICBDaHJpc3RvcGhlIChhZGRlZCB0byBDYykgYWN0dWFsbHkgaGFzCj4gYSBzY3JpcHRlZCBj
b252ZXJzaW9uIGZvciB0aGUgcmVzdCB0aGF0IGhlIGhhc24ndCBwb3N0ZWQgeWV0LCBzbyBJJ2xs
Cj4gYWltIGZvciB0aGUgbWluaW1hbCB2ZXJzaW9uIGhlcmUuCgpIaSwKCkknbSBzb3JyeSwgYnV0
IEkgd2lsbCBub3Qgc2VuZCBwY2lfIC0tPiBkbWFfIGNvbnZlcnNpb24gZm9yIHRoaXMgZHJpdmVy
LgpJJ20gYSBiaXQgcHV6emxlZCBieSBzb21lIGNob2ljZSBvZiBHRlBfS0VSTkVMIGFuZCBHRlBf
QVRPTUlDIHRoYXQgbm90IAphbGwgdGhhdCBvYnZpb3VzIHRvIG1lLgoKSSdsbCB0cnkgdG8gc2Vu
ZCBzb21lIHBhdGNoZXMgZm9yIG90aGVyIGVhc2llciBkcml2ZXJzIGluIHRoZSBjb21pbmcgd2Vl
a3MuCgpCZXN0IHJlZ2FyZHMsCgpDSgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
