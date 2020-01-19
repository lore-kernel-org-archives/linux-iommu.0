Return-Path: <SRS0=9Gch=3I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD724C32771
	for <iommu@archiver.kernel.org>; Sun, 19 Jan 2020 03:18:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C0E5206D5
	for <iommu@archiver.kernel.org>; Sun, 19 Jan 2020 03:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C0E5206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9DDB28113E;
	Sun, 19 Jan 2020 03:18:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gCIqm3KnhtuF; Sun, 19 Jan 2020 03:18:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8BABC856F4;
	Sun, 19 Jan 2020 03:18:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70286C1796;
	Sun, 19 Jan 2020 03:18:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEEE6C077D
 for <iommu@lists.linux-foundation.org>; Sun, 19 Jan 2020 03:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C257787A0A
 for <iommu@lists.linux-foundation.org>; Sun, 19 Jan 2020 03:18:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xw7DPKJQ8Uwx for <iommu@lists.linux-foundation.org>;
 Sun, 19 Jan 2020 03:18:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0260B878FE
 for <iommu@lists.linux-foundation.org>; Sun, 19 Jan 2020 03:18:49 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jan 2020 19:18:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,336,1574150400"; d="scan'208";a="269415937"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga001.fm.intel.com with ESMTP; 18 Jan 2020 19:18:49 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 18 Jan 2020 19:18:49 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.197]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.30]) with mapi id 14.03.0439.000;
 Sun, 19 Jan 2020 11:18:47 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "zhouguangdi@cambricon.com" <zhouguangdi@cambricon.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: intel iommu pasid question
Thread-Topic: intel iommu pasid question
Thread-Index: AQHVzfvIwTGndjdwSkChnJHk8CXQ6afvSymAgAIEq6A=
Date: Sun, 19 Jan 2020 03:18:46 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A1891B9@SHSMSX104.ccr.corp.intel.com>
References: <2419db41.2662.16fb6dfed52.Coremail.zhouguangdi@cambricon.com>
 <47df2cee.2663.16fb6e186ce.Coremail.zhouguangdi@cambricon.com>
In-Reply-To: <47df2cee.2663.16fb6e186ce.Coremail.zhouguangdi@cambricon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZWEwMDlkNDItMTZiMy00ODY4LTk1OWUtMGVhNWY4MWQxYjY4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOWExbTN2ZURLUzU0V1JjK0dITCsxOWxDcTl6b1wvbjhGcE1PQnE2VnIwQWFqalhtdXo4VWo4OVhaazdhY2d6TmQifQ==
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

PiBGcm9tOiBpb21tdSBbbWFpbHRvOmlvbW11LWJvdW5jZXNAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmddIE9uIEJlaGFsZiBPZiA/Pz8NCj4gU2VudDogU2F0dXJkYXksIEphbnVhcnkgMTgsIDIw
MjAgMTI6MjEgUE0NCj4gVG86IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnDQo+IFN1
YmplY3Q6IGludGVsIGlvbW11IHBhc2lkIHF1ZXN0aW9uDQo+IA0KPiBIaSBhbGzvvIwNCj4gDQo+
IA0KPiBJIGFtIGN1cnJlbnRseSBkZXZlbG9waW5nIGEgcGNpZSBkZXZpY2UgZHJpdmVyIG9uIExp
bnV4IGtlcm5lbCA0LjQgb3IgbGF0ZXIuIEkgd2FudCB0bw0KPiB1c2UgcGFzaWQgdG8gZGlyZWN0
bHkgYWNjZXNzIHVzZXItbW9kZSBtZW1vcnkuIEJ1dCBJIGZvdW5kIHRoYXQgdGhlIGlvbW11IG9m
IG15DQo+IGRldmVsb3BtZW50IG1hY2hpbmUgZG9lcyBub3Qgc3VwcG9ydCBwYXNpZC5wYXNpZF9l
bmFibGVkKGlvbW11KSBvcg0KPiBwYXNpZF9zdXBwb3J0ZWQoaW9tbXUpIHJldHVybiBmYWxzZS4N
Cg0KRWNobyBCYW9sdSdzIGNvbW1lbnQuDQoNCj4gDQo+IEkgd2FudCB0byBrbm93IGhvdyB0byBl
bmFibGUgdGhlIHBhc2lkIGZ1bmN0aW9uIG9mIGludGVsIGlvbW1177yMSXMgdGhlcmUgYSBzZXBh
cmF0ZQ0KPiBzd2l0Y2ggdG8gZW5hYmxlIHRoZSBpb21tdSBwYXNpZCBmdW5jdGlvbiBvciB0aGUg
aW9tbXUgaGFyZHdhcmUgaW1wbGVtZW50YXRpb24NCj4gaGFzIGRlY2lkZWQgd2hldGhlciB0byBz
dXBwb3J0IFBBU0lEIGFuZCB0aGUgc29mdHdhcmUgY2Fubm90IGNvbmZpZ3VyZSBpdO+8nw0KDQpZ
b3UgY2FuIGNoZWNrIGlmIFZULWQgaXMgZW5hYmxlZCBpbiBMaW51eCBrZXJuZWwgYnkgYmVsb3cg
Y29tbWFuZDoNCg0KZG1lc2cgfCBncmVwIOKAnEludGVsKFIpIFZpcnR1YWxpemF0aW9uIFRlY2hu
b2xvZ3kgZm9yIERpcmVjdGVkIEkvT+KAnQ0KDQo+IA0KPiBIb3cgY2FuIEkgY2hlY2sgd2hpY2gg
dmVyc2lvbiBvZiBpbnRlbCB2dC1kIGlzIGltcGxlbWVudGVkIGJ5IGlvbW11IG9uIG15DQo+IHBs
YXRmb3JtP0RvZXMgdGhlIHZhbHVlIG9mIGlvbW11J3MgVmVyc2lvbiBSZWdpc3RlciByZXByZXNl
bnQgdGhlIHZ0LWQgdmVyc2lvbj8NCj4gdGhlIGlvbW11IHZlcnNpb24gcmVnaXN0ZXIgb2YgbXkg
aW50ZWwgeGVvbiBnb2xkIDUxMTggcGxhdGZvcm0gc2VydmVyIGlzIDEuMA0KDQpZb3UgY2FuIGNo
ZWNrIFZULWQgUEFTSUQgc3VwcG9ydCBieSBlY2hvICJkbWVzZyB8IGdyZXAg4oCcZG1hcuKAnSIN
Cg0KWW91IHNob3VsZCBnZXQgc29tZSBpbmZvIGxpa2UgYmVsb3cuIENoZWNrIFBBU0lEIHN1cHBv
cnQgYnkgY2hlY2tpbmcgYml0IDQwIG9mIGVjYXAgcmVnaXN0ZXIuDQpbICAgIDAuMDc4Mjg1XSBE
TUFSOiBkbWFyMTogcmVnX2Jhc2VfYWRkciBmZWQ5MDAwMCB2ZXIgMTowIGNhcCAxYzAwMDBjNDA2
NjA0NjIgZWNhcCA3ZTNmZjA1MDVlDQpbICAgIDAuMDc4Mjg5XSBETUFSOiBkbWFyMjogcmVnX2Jh
c2VfYWRkciBmZWQ5MTAwMCB2ZXIgMTowIGNhcCBkMjAwOGM0MDY2MDQ2MiBlY2FwIGYwNTBkYQ0K
DQpBbHNvLCBpZiB5b3VyIGtlcm5lbCBzdXBwb3J0cyBpb21tdSBkZWJ1Z2ZzLCB5b3UgbWF5IGR1
bXAgdGhlIHRyYW5zbGF0aW9uLg0Kc3RydWN0dXJlcyBpbiAvc3lzL2tlcm5lbC9kZWJ1Zy9pb21t
dS9pbnRlbC9kbWFyX3RyYW5zbGF0aW9uX3N0cnVjdC4gVGhlcmUNCmlzIGEgYml0IGlzIENvbnRl
eHQgRW50cnkgd2hpY2ggZW5hYmxlcyBQQVNJRC4gKGJpdCAzIG9mIENvbnRleHQgZW50cnkpLg0K
DQpSZWdhcmRzLA0KWWkgTGl1DQoNCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQo+IGlvbW11IG1haWxpbmcgbGlzdA0KPiBpb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZw0KPiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
