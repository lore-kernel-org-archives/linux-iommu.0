Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6B0C31E44
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 06:16:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5682620851
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 06:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5682620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 47AACE4F;
	Fri, 14 Jun 2019 06:16:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 321DDE4E
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 06:16:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 16EF3E5
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 06:16:22 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	13 Jun 2019 23:16:22 -0700
X-ExtLoop1: 1
Received: from pgsmsx114.gar.corp.intel.com ([10.108.55.203])
	by orsmga007.jf.intel.com with ESMTP; 13 Jun 2019 23:16:20 -0700
Received: from pgsmsx109.gar.corp.intel.com ([169.254.14.167]) by
	pgsmsx114.gar.corp.intel.com ([169.254.4.185]) with mapi id
	14.03.0415.000; Fri, 14 Jun 2019 14:11:00 +0800
From: "Tan, Ley Foon" <ley.foon.tan@intel.com>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: switch nios2 and microblaze to use the generic uncached
	segement support
Thread-Topic: switch nios2 and microblaze to use the generic uncached
	segement support
Thread-Index: AQHVGdkT7boJI3RS4kqc/A8kJoZA3KaatPRz//+BHIA=
Date: Fri, 14 Jun 2019 06:11:00 +0000
Message-ID: <1560492659.21652.3.camel@intel.com>
References: <20190603065324.9724-1-hch@lst.de>
	<1560476434.21652.1.camel@intel.com> <20190614054418.GA6722@lst.de>
In-Reply-To: <20190614054418.GA6722@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.226.248.78]
Content-ID: <BBFDFFA76CA1BE40A273987AB2E67CFB@intel.com>
MIME-Version: 1.0
Cc: "lftan.linux@gmail.com" <lftan.linux@gmail.com>,
	"monstr@monstr.eu" <monstr@monstr.eu>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
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

T24gRnJpLCAyMDE5LTA2LTE0IGF0IDA3OjQ0ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gRnJpLCBKdW4gMTQsIDIwMTkgYXQgMDk6NDA6MzRBTSArMDgwMCwgTGV5IEZvb24g
VGFuIHdyb3RlOg0KPiA+IA0KPiA+IEhpwqBDaHJpc3RvcGgNCj4gPiANCj4gPiBDYW4gdGhpcyBw
YXRjaCBpbsKgaHR0cDovL2dpdC5pbmZyYWRlYWQub3JnL3VzZXJzL2hjaC9kbWEtbWFwcGluZy5n
aQ0KPiA+IHQvc2gNCj4gPiBvcnRsb2cvcmVmcy9oZWFkcy9mb3ItbmV4dA0KPiA+IA0KPiA+IFtQ
QVRDSCAxLzJdIG5pb3MyOiB1c2UgdGhlIGdlbmVyaWMgdW5jYWNoZWQgc2VnbWVudCBzdXBwb3J0
IGluIGRtYS0NCj4gPiBkaXJlY3QNCj4gSGkgTGV5IEZvb24sDQo+IA0KPiBJIGRvbid0IHVuZGVy
c3RhbmQgdGhlIGFib3ZlIHNlbnRlbmNlLsKgwqBEb2VzIGl0IGltcGx5IGEgUmV2aWV3ZWQtYnk/
DQpTb3JyeSwgdHlwbyBpbiBteSBwcmV2aW91cyBlbWFpbC7CoA0KQ2FuJ3QgZmluZCB0aGlzIHBh
dGNoIGluIHRoZSBnaXQgbGluayB5b3UgcHJvdmlkZWQgKGZvci1uZXh0IGJyYW5jaCkuDQpEaWQg
eW91IHB1c2ggdGhlIHBhdGNoPw0KDQpSZWdhcmRzDQpMZXkgRm9vbgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
