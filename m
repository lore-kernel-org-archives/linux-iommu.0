Return-Path: <SRS0=/ROq=YQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F69CA9EB6
	for <iommu@archiver.kernel.org>; Wed, 23 Oct 2019 09:10:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD3B20659
	for <iommu@archiver.kernel.org>; Wed, 23 Oct 2019 09:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD3B20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DACFAB88;
	Wed, 23 Oct 2019 09:10:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6269EB6C
	for <iommu@lists.linux-foundation.org>;
	Wed, 23 Oct 2019 09:10:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B13E987B
	for <iommu@lists.linux-foundation.org>;
	Wed, 23 Oct 2019 09:10:42 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id DAB3A68BE1; Wed, 23 Oct 2019 11:10:37 +0200 (CEST)
Date: Wed, 23 Oct 2019 11:10:37 +0200
From: "hch@lst.de" <hch@lst.de>
To: Wei Hu <weh@microsoft.com>
Subject: Re: [PATCH] video: hyperv: hyperv_fb: Use physical memory for fb
	on HyperV Gen 1 VMs.
Message-ID: <20191023091037.GB21910@lst.de>
References: <20191022110905.4032-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191022110905.4032-1-weh@microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "sashal@kernel.org" <sashal@kernel.org>, "info@metux.net" <info@metux.net>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
	"sam@ravnborg.org" <sam@ravnborg.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Michael Kelley <mikelley@microsoft.com>,
	"dcui@microsoft.com" <dcui@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
	KY Srinivasan <kys@microsoft.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

PiArCXNlbGVjdCBETUFfQ01BCgpUaNGWcyBuZWVkcyB0byBiZQoKCXNlbGVjdCBETUFfQ01BIGlm
IEhBVkVfRE1BX0NPTlRJR1VPVVMKCj4gKyNpbmNsdWRlIDxsaW51eC9kbWEtY29udGlndW91cy5o
PgoKPiArCS8qIEFsbG9jYXRlIGZyb20gQ01BICovCj4gKwkvLyByZXF1ZXN0X3BhZ2VzID0gKHJl
cXVlc3Rfc2l6ZSA+PiBQQUdFX1NISUZUKSArIDE7Cj4gKwlyZXF1ZXN0X3BhZ2VzID0gKHJvdW5k
X3VwKHJlcXVlc3Rfc2l6ZSwgUEFHRV9TSVpFKSA+PiBQQUdFX1NISUZUKTsKPiArCXBhZ2UgPSBk
bWFfYWxsb2NfZnJvbV9jb250aWd1b3VzKE5VTEwsIHJlcXVlc3RfcGFnZXMsIDAsIGZhbHNlKTsK
CmRtYV9hbGxvY19mcm9tX2NvbnRpZ3VvdXMgaXMgYW4gaW50ZXJuYWwgaGVscGVyLCB5b3UgbXVz
dCB1c2UgaXQKdGhyb3VnaCBkbWFfYWxsb2NfY29oZXJlbnQgYW5kIHBhc3MgYSBzdHJ1Y3QgZGV2
aWNlIHRvIHRoYXQgZnVuY3Rpb24uCgo+ICsJaWYgKCFnZW4ydm0pIHsKPiArCQlwZGV2ID0gcGNp
X2dldF9kZXZpY2UoUENJX1ZFTkRPUl9JRF9NSUNST1NPRlQsCj4gKwkJCVBDSV9ERVZJQ0VfSURf
SFlQRVJWX1ZJREVPLCBOVUxMKTsKPiArCQlpZiAoIXBkZXYpIHsKPiArCQkJcHJfZXJyKCJVbmFi
bGUgdG8gZmluZCBQQ0kgSHlwZXItViB2aWRlb1xuIik7Cj4gKwkJCXJldHVybiAtRU5PREVWOwo+
ICsJCX0KPiArCX0KClBsZWFzZSBhY3R1YWxseSBpbXBsZW1lbnQgYSBwY2lfZHJpdmVyIGluc3Rl
YWQgb2YgaGFja3MgbGlrZSB0aGlzLgoKPiArCQkJcGFyLT5uZWVkX2RvY29weSA9IGZhbHNlOwo+
ICsJCQlnb3RvIGdldG1lbTE7Cj4gKwkJfSBlbHNlIHsKCk5vIG5lZWQgZm9yIGFuIGVsc2UgYWZ0
ZXIgYSBnb3RvLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
