Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFE8C2D0E7
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 06:29:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA552071A
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 06:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA552071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D56AD8A11B;
	Wed,  1 Apr 2020 06:29:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PLRKYcAfo8P3; Wed,  1 Apr 2020 06:29:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DFE1B89EAB;
	Wed,  1 Apr 2020 06:29:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAB57C1AE2;
	Wed,  1 Apr 2020 06:29:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A90CC089F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 06:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 66C0F2C8DA
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 06:29:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7gQsFoBzvISe for <iommu@lists.linux-foundation.org>;
 Wed,  1 Apr 2020 06:29:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 23BF429DD6
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 06:29:40 +0000 (UTC)
IronPort-SDR: iogZ8AZvCc+X3RsIxr3aGO4WSrGh6nfZFivSdiXf5WB4VxvaXpeCokYH0c+yXYDAJKVE7brrF1
 02PUhGGuA5Eg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2020 23:29:39 -0700
IronPort-SDR: 4Mw2HjpAHqmvI8RrApvWaf5zrGlWT1+VkjD3RjXkYXX1snTRxLG0idJB5QwUlJfG6pg06Ytkdz
 86KM1VgDGiQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,330,1580803200"; d="scan'208";a="422582521"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga005.jf.intel.com with ESMTP; 31 Mar 2020 23:29:39 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 23:29:39 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 23:29:38 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.146]) with mapi id 14.03.0439.000;
 Wed, 1 Apr 2020 14:29:36 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate function
Thread-Topic: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate function
Thread-Index: AQHV/w5hchZ4XNV890+XBMGi6MGw3ahdsRPAgAGJtYCAAsrMAIAAtFqAgAEkbYA=
Date: Wed, 1 Apr 2020 06:29:35 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D803C33@SHSMSX104.ccr.corp.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-9-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA0AB@SHSMSX104.ccr.corp.intel.com>
 <3215b83c-81f7-a30f-fe82-a51f29d7b874@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D800D67@SHSMSX104.ccr.corp.intel.com>
 <20200331135807.4e9976ab@jacob-builder>
In-Reply-To: <20200331135807.4e9976ab@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: Alex Williamson <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, David
 Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

PiBGcm9tOiBKYWNvYiBQYW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPg0KPiBTZW50
OiBXZWRuZXNkYXksIEFwcmlsIDEsIDIwMjAgNDo1OCBBTQ0KPiANCj4gT24gVHVlLCAzMSBNYXIg
MjAyMCAwMjo0OToyMSArMDAwMA0KPiAiVGlhbiwgS2V2aW4iIDxrZXZpbi50aWFuQGludGVsLmNv
bT4gd3JvdGU6DQo+IA0KPiA+ID4gRnJvbTogQXVnZXIgRXJpYyA8ZXJpYy5hdWdlckByZWRoYXQu
Y29tPg0KPiA+ID4gU2VudDogU3VuZGF5LCBNYXJjaCAyOSwgMjAyMCAxMTozNCBQTQ0KPiA+ID4N
Cj4gPiA+IEhpLA0KPiA+ID4NCj4gPiA+IE9uIDMvMjgvMjAgMTE6MDEgQU0sIFRpYW4sIEtldmlu
IHdyb3RlOg0KPiA+ID4gPj4gRnJvbTogSmFjb2IgUGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4Lmlu
dGVsLmNvbT4NCj4gPiA+ID4+IFNlbnQ6IFNhdHVyZGF5LCBNYXJjaCAyMSwgMjAyMCA3OjI4IEFN
DQo+ID4gPiA+Pg0KPiA+ID4gPj4gV2hlbiBTaGFyZWQgVmlydHVhbCBBZGRyZXNzIChTVkEpIGlz
IGVuYWJsZWQgZm9yIGEgZ3Vlc3QgT1MgdmlhDQo+ID4gPiA+PiB2SU9NTVUsIHdlIG5lZWQgdG8g
cHJvdmlkZSBpbnZhbGlkYXRpb24gc3VwcG9ydCBhdCBJT01NVSBBUEkNCj4gPiA+ID4+IGFuZA0K
PiA+ID4gZHJpdmVyDQo+ID4gPiA+PiBsZXZlbC4gVGhpcyBwYXRjaCBhZGRzIEludGVsIFZULWQg
c3BlY2lmaWMgZnVuY3Rpb24gdG8gaW1wbGVtZW50DQo+ID4gPiA+PiBpb21tdSBwYXNzZG93biBp
bnZhbGlkYXRlIEFQSSBmb3Igc2hhcmVkIHZpcnR1YWwgYWRkcmVzcy4NCj4gPiA+ID4+DQo+ID4g
PiA+PiBUaGUgdXNlIGNhc2UgaXMgZm9yIHN1cHBvcnRpbmcgY2FjaGluZyBzdHJ1Y3R1cmUgaW52
YWxpZGF0aW9uDQo+ID4gPiA+PiBvZiBhc3NpZ25lZCBTVk0gY2FwYWJsZSBkZXZpY2VzLiBFbXVs
YXRlZCBJT01NVSBleHBvc2VzIHF1ZXVlDQo+ID4gIFsuLi5dDQo+ID4gIFsuLi5dDQo+ID4gPiB0
bw0KPiA+ID4gPj4gKyAqIFZULWQgZ3JhbnVsYXJpdHkuIEludmFsaWRhdGlvbiBpcyB0eXBpY2Fs
bHkgaW5jbHVkZWQgaW4gdGhlDQo+ID4gPiA+PiB1bm1hcA0KPiA+ID4gb3BlcmF0aW9uDQo+ID4g
PiA+PiArICogYXMgYSByZXN1bHQgb2YgRE1BIG9yIFZGSU8gdW5tYXAuIEhvd2V2ZXIsIGZvciBh
c3NpZ25lZA0KPiA+ID4gPj4gZGV2aWNlcw0KPiA+ID4gZ3Vlc3QNCj4gPiA+ID4+ICsgKiBvd25z
IHRoZSBmaXJzdCBsZXZlbCBwYWdlIHRhYmxlcy4gSW52YWxpZGF0aW9ucyBvZg0KPiA+ID4gPj4g
dHJhbnNsYXRpb24gY2FjaGVzIGluDQo+ID4gPiB0aGUNCj4gPiAgWy4uLl0NCj4gPiAgWy4uLl0N
Cj4gPiAgWy4uLl0NCj4gPiA+DQo+IGludl90eXBlX2dyYW51X21hcFtJT01NVV9DQUNIRV9JTlZf
VFlQRV9OUl1bSU9NTVVfSU5WX0dSQU5VXw0KPiA+ID4gPj4gTlJdID0gew0KPiA+ID4gPj4gKwkv
Kg0KPiA+ID4gPj4gKwkgKiBQQVNJRCBiYXNlZCBJT1RMQiBpbnZhbGlkYXRpb246IFBBU0lEIHNl
bGVjdGl2ZSAocGVyDQo+ID4gPiA+PiBQQVNJRCksDQo+ID4gPiA+PiArCSAqIHBhZ2Ugc2VsZWN0
aXZlIChhZGRyZXNzIGdyYW51bGFyaXR5KQ0KPiA+ID4gPj4gKwkgKi8NCj4gPiA+ID4+ICsJezAs
IDEsIDF9LA0KPiA+ID4gPj4gKwkvKiBQQVNJRCBiYXNlZCBkZXYgVExCcywgb25seSBzdXBwb3J0
IGFsbCBQQVNJRHMgb3INCj4gPiA+ID4+IHNpbmdsZSBQQVNJRCAqLw0KPiA+ID4gPj4gKwl7MSwg
MSwgMH0sDQo+ID4gPiA+DQo+ID4gPiA+IElzIHRoaXMgY29tYmluYXRpb24gY29ycmVjdD8gd2hl
biBzaW5nbGUgUEFTSUQgaXMgYmVpbmcNCj4gPiA+ID4gc3BlY2lmaWVkLCBpdCBpcyBlc3NlbnRp
YWxseSBhIHBhZ2Utc2VsZWN0aXZlIGludmFsaWRhdGlvbiBzaW5jZQ0KPiA+ID4gPiB5b3UgbmVl
ZCBwcm92aWRlIEFkZHJlc3MgYW5kIFNpemUuDQo+ID4gPiBJc24ndCBpdCB0aGUgc2FtZSB3aGVu
IEc9MT8gU3RpbGwgdGhlIGFkZHIvc2l6ZSBpcyB1c2VkLiBEb2Vzbid0DQo+ID4gPiBpdA0KPiA+
DQo+ID4gSSB0aG91Z2h0IGFkZHIvc2l6ZSBpcyBub3QgdXNlZCB3aGVuIEc9MSwgYnV0IGl0IG1p
Z2h0IGJlIHdyb25nLiBJJ20NCj4gPiBjaGVja2luZyB3aXRoIG91ciB2dC1kIHNwZWMgb3duZXIu
DQo+ID4NCj4gDQo+ID4gPiBjb3JyZXNwb25kIHRvIElPTU1VX0lOVl9HUkFOVV9BRERSIHdpdGgN
Cj4gPiA+IElPTU1VX0lOVl9BRERSX0ZMQUdTX1BBU0lEIGZsYWcNCj4gPiA+IHVuc2V0Pw0KPiA+
ID4NCj4gPiA+IHNvIHswLCAwLCAxfT8NCj4gPg0KPiBJIGFtIG5vdCBzdXJlIEkgZ290IHlvdXIg
bG9naWMuIFRoZSB0aHJlZSBmaWVsZHMgY29ycmVzcG9uZCB0bw0KPiAJSU9NTVVfSU5WX0dSQU5V
X0RPTUFJTiwJLyogZG9tYWluLXNlbGVjdGl2ZQ0KPiBpbnZhbGlkYXRpb24gKi8NCj4gCUlPTU1V
X0lOVl9HUkFOVV9QQVNJRCwJLyogUEFTSUQtc2VsZWN0aXZlIGludmFsaWRhdGlvbiAqLw0KPiAJ
SU9NTVVfSU5WX0dSQU5VX0FERFIsCS8qIHBhZ2Utc2VsZWN0aXZlIGludmFsaWRhdGlvbiAqDQo+
IA0KPiBGb3IgZGV2VExCLCB3ZSB1c2UgZG9tYWluIGFzIGdsb2JhbCBzaW5jZSB0aGVyZSBpcyBu
byBkb21haW4uIFRoZW4gSQ0KPiBjYW1lIHVwIHdpdGggezEsIDEsIDB9LCB3aGljaCBtZWFucyB3
ZSBjb3VsZCBoYXZlIGdsb2JhbCBhbmQgcGFzaWQNCj4gZ3JhbnUgaW52YWxpZGF0aW9uIGZvciBQ
QVNJRCBiYXNlZCBkZXZUTEIuDQo+IA0KPiBJZiB0aGUgY2FsbGVyIGFsc28gcHJvdmlkZSBhZGRy
IGFuZCBTIGJpdCwgdGhlIGZsdXNoIHJvdXRpbmUgd2lsbCBwdXQNCg0KImFsc28iIC0+ICJtdXN0
IiwgYmVjYXVzZSB2dC1kIHJlcXVpcmVzIGFkZHIvc2l6ZSBtdXN0IGJlIHByb3ZpZGVkDQppbiBk
ZXZ0bGIgZGVzY3JpcHRvciwgdGhhdCBpcyB3aHkgRXJpYyBzdWdnZXN0cyB7MCwgMCwgMX0uDQoN
Cj4gdGhhdCBpbnRvIFFJIGRlc2NyaXB0b3IuIEkga25vdyB0aGlzIGlzIGEgbGl0dGxlIG9kZCwg
YnV0IGZyb20gdGhlDQo+IGdyYW51IHRyYW5zbGF0aW9uIHAuby52LiBWVC1kIHNwZWMgaGFzIG5v
IEcgYml0IGZvciBwYWdlIHNlbGVjdGl2ZQ0KPiBpbnZhbGlkYXRpb24uDQoNCldlIGRvbid0IG5l
ZWQgc3VjaCBvZGQgd2F5IGlmIGNhbiBkbyBpdCBwcm9wZXJseS4g8J+Yig0KDQo+IA0KPiA+IEkg
aGF2ZSBvbmUgbW9yZSBvcGVuOg0KPiA+DQo+ID4gSG93IGRvZXMgdXNlcnNwYWNlIGtub3cgd2hp
Y2ggaW52YWxpZGF0aW9uIHR5cGUvZ3JhbiBpcyBzdXBwb3J0ZWQ/DQo+ID4gSSBkaWRuJ3Qgc2Vl
IHN1Y2ggY2FwYWJpbGl0eSByZXBvcnRpbmcgaW4gWWkncyBWRklPIHZTVkEgcGF0Y2ggc2V0Lg0K
PiA+IERvIHdlIHdhbnQgdGhlIHVzZXIva2VybmVsIGFzc3VtZSB0aGUgc2FtZSBjYXBhYmlsaXR5
IHNldCBpZiB0aGV5IGFyZQ0KPiA+IGFyY2hpdGVjdHVyYWw/IEhvd2V2ZXIgdGhlIGtlcm5lbCBj
b3VsZCBhbHNvIGRvIHNvbWUgb3B0aW1pemF0aW9uDQo+ID4gZS5nLiBoaWRlIGRldnRsYiBpbnZh
bGlkYXRpb24gY2FwYWJpbGl0eSBnaXZlbiB0aGF0IHRoZSBrZXJuZWwNCj4gPiBhbHJlYWR5IGlu
dmFsaWRhdGUgZGV2dGxiIGF1dG9tYXRpY2FsbHkgd2hlbiBzZXJ2aW5nIGlvdGxiDQo+ID4gaW52
YWxpZGF0aW9uLi4uDQo+ID4NCj4gSW4gZ2VuZXJhbCwgd2UgYXJlIHRyZW5kaW5nIHRvIHVzZSBW
RklPIGNhcGFiaWxpdHkgY2hhaW4gdG8gZXhwb3NlIGlvbW11DQo+IGNhcGFiaWxpdGllcy4NCj4g
DQo+IEJ1dCBmb3IgYXJjaGl0ZWN0dXJhbCBmZWF0dXJlcyBzdWNoIGFzIHR5cGUvZ3JhbnUsIHdl
IGhhdmUgdG8gYXNzdW1lDQo+IHRoZSBzYW1lIGNhcGFiaWxpdHkgYmV0d2VlbiBob3N0ICYgZ3Vl
c3QuIEdyYW51IGFuZCB0eXBlcyBhcmUgbm90DQo+IGVudW1lcmF0ZWQgb24gdGhlIGhvc3QgSU9N
TVUgZWl0aGVyLg0KPiANCj4gRm9yIGRldlRMQiBvcHRpbWl6YXRpb24sIEkgYWdyZWUgd2UgbmVl
ZCB0byBleHBvc2UgYSBjYXBhYmlsaXR5IHRvDQo+IHRoZSBndWVzdCBzdGF0aW5nIHRoYXQgaW1w
bGljaXQgZGV2dGxiIGludmFsaWRhdGlvbiBpcyBzdXBwb3J0ZWQuDQo+IE90aGVyd2lzZSwgaWYg
TGludXggZ3Vlc3QgcnVucyBvbiBvdGhlciBPU2VzIG1heSBub3Qgc3VwcG9ydCBpbXBsaWNpdA0K
PiBkZXZ0bGIgaW52YWxpZGF0aW9uLg0KPiANCj4gUmlnaHQgWWk/DQoNClRoYW5rcyBmb3IgZXhw
bGFuYXRpb24uIFNvIHdlIGFyZSBhc3N1bWVkIHRvIHN1cHBvcnQgYWxsIG9wZXJhdGlvbnMNCmRl
ZmluZWQgaW4gc3BlYywgc28gbm8gbmVlZCB0byBleHBvc2UgdGhlbSBvbmUtYnktb25lLiBGb3IN
Cm9wdGltaXphdGlvbiwgSSdtIGZpbmUgdG8gZG8gaXQgbGF0ZXIuIA0KDQo+IA0KPiA+IFRoYW5r
cw0KPiA+IEtldmluDQo+ID4NCj4gPiA+DQo+ID4gPiBUaGFua3MNCj4gPiA+DQo+ID4gPiBFcmlj
DQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPj4gKwkvKiBQQVNJRCBjYWNoZSAqLw0KPiA+ID4gPg0K
PiA+ID4gPiBQQVNJRCBjYWNoZSBpcyBmdWxseSBtYW5hZ2VkIGJ5IHRoZSBob3N0LiBHdWVzdCBQ
QVNJRCBjYWNoZQ0KPiA+ID4gPiBpbnZhbGlkYXRpb24gaXMgaW50ZXJwcmV0ZWQgYnkgdklPTU1V
IGZvciBiaW5kIGFuZCB1bmJpbmQNCj4gPiA+ID4gb3BlcmF0aW9ucy4gSSBkb24ndCB0aGluayB3
ZSBzaG91bGQgYWNjZXB0IGFueSBQQVNJRCBjYWNoZQ0KPiA+ID4gPiBpbnZhbGlkYXRpb24gZnJv
bSB1c2Vyc3BhY2Ugb3IgZ3Vlc3QuDQo+ID4gIFsuLi5dDQo+ID4gPg0KPiBpbnZfdHlwZV9ncmFu
dV90YWJsZVtJT01NVV9DQUNIRV9JTlZfVFlQRV9OUl1bSU9NTVVfSU5WX0dSQU5VDQo+ID4gIFsu
Li5dDQo+ID4gPiA+DQo+ID4gPiA+IGJ0dyBkbyB3ZSByZWFsbHkgbmVlZCBib3RoIG1hcCBhbmQg
dGFibGUgaGVyZT8gQ2FuJ3Qgd2UganVzdA0KPiA+ID4gPiB1c2Ugb25lIHRhYmxlIHdpdGggdW5z
dXBwb3J0ZWQgZ3JhbnVsYXJpdHkgbWFya2VkIGFzIGEgc3BlY2lhbA0KPiA+ID4gPiB2YWx1ZT8N
Cj4gPiA+ID4NCj4gPiAgWy4uLl0NCj4gPiA+ID4NCj4gPiA+ID4gLUVOT1RTVVBQPw0KPiA+ID4g
Pg0KPiA+ICBbLi4uXQ0KPiA+ID4gPg0KPiA+ID4gPiBncmFudWxhcml0eSA9PSBJT01NVV9JTlZf
R1JBTlVfQUREUj8gb3RoZXJ3aXNlIGl0J3MgdW5jbGVhcg0KPiA+ID4gPiB3aHkgSU9NTVVfSU5W
X0dSQU5VX0RPTUFJTiBhbHNvIG5lZWRzIHNpemUgY2hlY2suDQo+ID4gPiA+DQo+ID4gIFsuLi5d
DQo+ID4gPiA+Pj4gYWRkcl9pbmZvLmFkZHIpLA0KPiA+ICBbLi4uXQ0KPiA+ICBbLi4uXQ0KPiA+
ID4gPj4gKwkJCWlmIChpbmZvLT5hdHNfZW5hYmxlZCkgew0KPiA+ID4gPj4gKwkJCQlxaV9mbHVz
aF9kZXZfaW90bGJfcGFzaWQoaW9tbXUsDQo+ID4gPiA+PiBzaWQsIGluZm8tDQo+ID4gPiA+Pj4g
cGZzaWQsDQo+ID4gIFsuLi5dDQo+ID4gPiA+Pj4gcGZzaWQsDQo+ID4gPiA+PiArDQo+ID4gPiA+
PiBpbnZfaW5mby0+YWRkcl9pbmZvLnBhc2lkLCBpbmZvLT5hdHNfcWRlcCwNCj4gPiA+ID4+ICsN
Cj4gPiA+ID4+IGludl9pbmZvLT5hZGRyX2luZm8uYWRkciwgc2l6ZSwNCj4gPiA+ID4+ICsJCQkJ
CQlncmFudSk7DQo+ID4gIFsuLi5dDQo+ID4gIFsuLi5dDQo+ID4gPiA+Pj4gcGFzaWRfaW5mby5w
YXNpZCk7DQo+ID4gPiA+PiArDQo+ID4gPiA+DQo+ID4gPiA+IGFzIGVhcmxpZXIgY29tbWVudCwg
d2Ugc2hvdWxkbid0IGFsbG93IHVzZXJzcGFjZSBvciBndWVzdCB0bw0KPiA+ID4gPiBpbnZhbGlk
YXRlIFBBU0lEIGNhY2hlDQo+ID4gPiA+DQo+ID4gIFsuLi5dDQo+ID4gPiA+DQo+ID4NCj4gDQo+
IFtKYWNvYiBQYW5dDQoNClRoYW5rcw0KS2V2aW4NCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
