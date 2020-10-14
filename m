Return-Path: <SRS0=zShu=DV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A7BC433E7
	for <iommu@archiver.kernel.org>; Wed, 14 Oct 2020 07:31:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6FE1212CC
	for <iommu@archiver.kernel.org>; Wed, 14 Oct 2020 07:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FE1212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0C5E52E23A;
	Wed, 14 Oct 2020 07:31:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kWUB5sVYvPWm; Wed, 14 Oct 2020 07:31:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 88D3C20404;
	Wed, 14 Oct 2020 07:31:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 694B2C07FF;
	Wed, 14 Oct 2020 07:31:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D1F0C0051
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 07:31:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2AD3A86FBA
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 07:31:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EKm2zY2W2fGC for <iommu@lists.linux-foundation.org>;
 Wed, 14 Oct 2020 07:31:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 80A5086F63
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 07:31:45 +0000 (UTC)
IronPort-SDR: y1WXD9XHdlJcMdSvEqws/Cul8R4pXDHxnf1Brr90GXE/RUfuNvRnqAi3hd+baZSAOhHzOwyz1U
 oR3ANacZUpAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="166115602"
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; d="scan'208";a="166115602"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2020 00:31:38 -0700
IronPort-SDR: Q/+QmmCHxC00fwQEG7cm2Y/Tvul4iJK2EQtiK4wSrB0kAVxZDKyYHdNvbg7IpB95XB4QXdle29
 27vjgmGxEXZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; d="scan'208";a="345558605"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 14 Oct 2020 00:31:36 -0700
Subject: Re: [PATCH next] iommu: intel: don't dereference iommu_device if
 IOMMU_API is not built
To: Bartosz Golaszewski <brgl@bgdev.pl>
References: <20201013073055.11262-1-brgl@bgdev.pl>
 <abd717c9-9eaa-d4bb-3fd8-ff7250d97ab7@linux.intel.com>
 <CAMRc=MdLXaPNUwbUPGJS1AY0pq5je9zsGM7eHShLT=f6mT5Dww@mail.gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <dc6f3226-c6e5-b361-601b-afa91540144e@linux.intel.com>
Date: Wed, 14 Oct 2020 15:25:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=MdLXaPNUwbUPGJS1AY0pq5je9zsGM7eHShLT=f6mT5Dww@mail.gmail.com>
Content-Language: en-US
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

SGkgQmFydG9zeiwKCk9uIDEwLzE0LzIwIDM6MTggUE0sIEJhcnRvc3ogR29sYXN6ZXdza2kgd3Jv
dGU6Cj4gT24gV2VkLCBPY3QgMTQsIDIwMjAgYXQgMjo0OSBBTSBMdSBCYW9sdSA8YmFvbHUubHVA
bGludXguaW50ZWwuY29tPiB3cm90ZToKPj4KPj4gT24gMTAvMTMvMjAgMzozMCBQTSwgQmFydG9z
eiBHb2xhc3pld3NraSB3cm90ZToKPj4+IEZyb206IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xh
c3pld3NraUBiYXlsaWJyZS5jb20+Cj4+Pgo+Pj4gU2luY2UgY29tbWl0IGM0MGFhYWFjMTAxOCAo
ImlvbW11L3Z0LWQ6IEdyYWNlZnVsbHkgaGFuZGxlIERNQVIgdW5pdHMKPj4+IHdpdGggbm8gc3Vw
cG9ydGVkIGFkZHJlc3Mgd2lkdGhzIikgZG1hci5jIG5lZWRzIHN0cnVjdCBpb21tdV9kZXZpY2Ug
dG8KPj4+IGJlIHNlbGVjdGVkLiBXZSBjYW4gZHJvcCB0aGlzIGRlcGVuZGVuY3kgYnkgbm90IGRl
cmVmZXJlbmNpbmcgc3RydWN0Cj4+PiBpb21tdV9kZXZpY2UgaWYgSU9NTVVfQVBJIGlzIG5vdCBz
ZWxlY3RlZCBhbmQgYnkgcmV1c2luZyB0aGUgaW5mb3JtYXRpb24KPj4+IHN0b3JlZCBpbiBpb21t
dS0+ZHJoZC0+aWdub3JlZCBpbnN0ZWFkLgo+Pj4KPj4+IFRoaXMgZml4ZXMgdGhlIGZvbGxvd2lu
ZyBidWlsZCBlcnJvciB3aGVuIElPTU1VX0FQSSBpcyBub3Qgc2VsZWN0ZWQ6Cj4+Pgo+Pj4gZHJp
dmVycy9pb21tdS9pbnRlbC9kbWFyLmM6IEluIGZ1bmN0aW9uIOKAmGZyZWVfaW9tbXXigJk6Cj4+
PiBkcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYzoxMTM5OjQxOiBlcnJvcjog4oCYc3RydWN0IGlv
bW11X2RldmljZeKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmG9wc+KAmQo+Pj4gICAgMTEzOSB8
ICBpZiAoaW50ZWxfaW9tbXVfZW5hYmxlZCAmJiBpb21tdS0+aW9tbXUub3BzKSB7Cj4+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KPj4+Cj4+PiBG
aXhlczogYzQwYWFhYWMxMDE4ICgiaW9tbXUvdnQtZDogR3JhY2VmdWxseSBoYW5kbGUgRE1BUiB1
bml0cyB3aXRoIG5vIHN1cHBvcnRlZCBhZGRyZXNzIHdpZHRocyIpCj4+PiBTaWduZWQtb2ZmLWJ5
OiBCYXJ0b3N6IEdvbGFzemV3c2tpIDxiZ29sYXN6ZXdza2lAYmF5bGlicmUuY29tPgo+Pgo+PiBX
aXRoIGNvbW1pdCB0aXRsZSBhZGp1c3RlZCB0byAiaW9tbXUvdnQtZDogRG9uJ3QgZGVyZWZlcmVu
Y2UKPj4gaW9tbXVfZGV2aWNlIGlmIElPTU1VX0FQSSBpcyBub3QgYnVpbHQiLAo+Pgo+PiBBY2tl
ZC1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KPj4KPiAKPiBEbyB5b3Ug
d2FudCBtZSB0byByZXNlbmQgaXQgYWdhaW4gd2l0aCBhIGNoYW5nZWQgdGl0bGUgb3IgY2FuIHlv
dSBmaXgKPiBpdCB1cCB3aGVuIGFwcGx5aW5nPyBPciBzaG91bGQgc29tZW9uZSBlbHNlIHBpY2sg
aXQgdXA/CgpJIHN1cHBvc2UgSm9lcmcgd2lsbCBwaWNrIHRoaXMgdXAuIEkgZ3Vlc3MgeW91IGRv
bid0IG5lZWQgdG8gcmVzZW5kIGl0CnVubGVzcyBKb2VyZyBhc2tzIHlvdSB0byBkby4KCkJlc3Qg
cmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
