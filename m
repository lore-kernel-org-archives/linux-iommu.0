Return-Path: <SRS0=z+Ry=HS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DECC433DB
	for <iommu@archiver.kernel.org>; Tue, 16 Feb 2021 13:45:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43DBF614A7
	for <iommu@archiver.kernel.org>; Tue, 16 Feb 2021 13:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DBF614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 03FC387160;
	Tue, 16 Feb 2021 13:45:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8xUnKIhZZHZs; Tue, 16 Feb 2021 13:45:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EDFCF8715D;
	Tue, 16 Feb 2021 13:45:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD9E6C0893;
	Tue, 16 Feb 2021 13:45:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11A1AC013A
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 13:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0002A86749
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 13:45:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yYP5pmapz6Tr for <iommu@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 13:45:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id BCB5F8669C
 for <iommu@lists.linux-foundation.org>; Tue, 16 Feb 2021 13:45:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CC0E31B;
 Tue, 16 Feb 2021 05:45:16 -0800 (PST)
Received: from [10.57.48.219] (unknown [10.57.48.219])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E96FF3F694;
 Tue, 16 Feb 2021 05:45:14 -0800 (PST)
Subject: Re: [PATCH v2] iommu: Check dev->iommu in iommu_dev_xxx functions
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <c82f6d0cced74c43947714e7de576d5a@huawei.com>
 <d541ebeb-5b89-7a9d-50a2-3867f9cf78b3@arm.com>
 <33cf95925cfb47dda3ee472e00b9846c@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f89f150f-20d3-8f22-c6c5-92c19d3d7e33@arm.com>
Date: Tue, 16 Feb 2021 13:45:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <33cf95925cfb47dda3ee472e00b9846c@huawei.com>
Content-Language: en-GB
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "will@kernel.org" <will@kernel.org>,
 "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>
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

T24gMjAyMS0wMi0xMiAxNzoyOCwgU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSB3cm90ZToKPiAK
PiAKPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogU2hhbWVlcmFsaSBLb2xv
dGh1bSBUaG9kaQo+PiBTZW50OiAxMiBGZWJydWFyeSAyMDIxIDE2OjQ1Cj4+IFRvOiAnUm9iaW4g
TXVycGh5JyA8cm9iaW4ubXVycGh5QGFybS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOwo+PiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+PiBDYzogam9yb0A4Ynl0
ZXMub3JnOyBqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc7IHdpbGxAa2VybmVsLm9yZzsgWmVuZ3Rh
byAoQikKPj4gPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47IGxpbnV4YXJtQG9wZW5ldWxlci5v
cmcKPj4gU3ViamVjdDogUkU6IFtQQVRDSCB2Ml0gaW9tbXU6IENoZWNrIGRldi0+aW9tbXUgaW4g
aW9tbXVfZGV2X3h4eCBmdW5jdGlvbnMKPj4KPj4KPj4KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tCj4+PiBGcm9tOiBSb2JpbiBNdXJwaHkgW21haWx0bzpyb2Jpbi5tdXJwaHlAYXJtLmNv
bV0KPj4+IFNlbnQ6IDEyIEZlYnJ1YXJ5IDIwMjEgMTY6MzkKPj4+IFRvOiBTaGFtZWVyYWxpIEtv
bG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+Owo+Pj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKPj4+IENjOiBqb3JvQDhieXRlcy5vcmc7IGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZzsg
d2lsbEBrZXJuZWwub3JnOyBaZW5ndGFvIChCKQo+Pj4gPHByaW1lLnplbmdAaGlzaWxpY29uLmNv
bT47IGxpbnV4YXJtQG9wZW5ldWxlci5vcmcKPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGlv
bW11OiBDaGVjayBkZXYtPmlvbW11IGluIGlvbW11X2Rldl94eHgKPj4gZnVuY3Rpb25zCj4+Pgo+
Pj4gT24gMjAyMS0wMi0xMiAxNDo1NCwgU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSB3cm90ZToK
Pj4+PiBIaSBSb2Jpbi9Kb2VyZywKPj4+Pgo+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQo+Pj4+PiBGcm9tOiBTaGFtZWVyIEtvbG90aHVtCj4+IFttYWlsdG86c2hhbWVlcmFsaS5rb2xv
dGh1bS50aG9kaUBodWF3ZWkuY29tXQo+Pj4+PiBTZW50OiAwMSBGZWJydWFyeSAyMDIxIDEyOjQx
Cj4+Pj4+IFRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBpb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwo+Pj4+PiBDYzogam9yb0A4Ynl0ZXMub3JnOyByb2Jpbi5tdXJwaHlA
YXJtLmNvbTsgamVhbi1waGlsaXBwZUBsaW5hcm8ub3JnOwo+Pj4+PiB3aWxsQGtlcm5lbC5vcmc7
IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+Owo+Pj4+PiBsaW51eGFybUBv
cGVuZXVsZXIub3JnCj4+Pj4+IFN1YmplY3Q6IFtMaW51eGFybV0gW1BBVENIIHYyXSBpb21tdTog
Q2hlY2sgZGV2LT5pb21tdSBpbgo+Pj4gaW9tbXVfZGV2X3h4eAo+Pj4+PiBmdW5jdGlvbnMKPj4+
Pj4KPj4+Pj4gVGhlIGRldmljZSBpb21tdSBwcm9iZS9hdHRhY2ggbWlnaHQgaGF2ZSBmYWlsZWQg
bGVhdmluZyBkZXYtPmlvbW11Cj4+Pj4+IHRvIE5VTEwgYW5kIGRldmljZSBkcml2ZXJzIG1heSBz
dGlsbCBpbnZva2UgdGhlc2UgZnVuY3Rpb25zIHJlc3VsdGluZwo+Pj4+PiBpbiBhIGNyYXNoIGlu
IGlvbW11IHZlbmRvciBkcml2ZXIgY29kZS4gSGVuY2UgbWFrZSBzdXJlIHdlIGNoZWNrIHRoYXQu
Cj4+Pj4+Cj4+Pj4+IEFsc28gYWRkZWQgaW9tbXVfb3BzIHRvIHRoZSAic3RydWN0IGRldl9pb21t
dSIgYW5kIHNldCBpdCBpZiB0aGUgZGV2Cj4+Pj4+IGlzIHN1Y2Nlc3NmdWxseSBhc3NvY2lhdGVk
IHdpdGggYW4gaW9tbXUuCj4+Pj4+Cj4+Pj4+IEZpeGVzOsKgYTNhMTk1OTI5ZDQwICgiaW9tbXU6
IEFkZCBBUElzIGZvciBtdWx0aXBsZSBkb21haW5zIHBlcgo+PiBkZXZpY2UiKQo+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtCj4+PiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9k
aUBodWF3ZWkuY29tPgo+Pj4+PiAtLS0KPj4+Pj4gdjEgLS0+IHYyOgo+Pj4+PiAgICAtQWRkZWQg
aW9tbXVfb3BzIHRvIHN0cnVjdCBkZXZfaW9tbXUgYmFzZWQgb24gdGhlIGRpc2N1c3Npb24gd2l0
aAo+Pj4gUm9iaW4uCj4+Pj4+ICAgIC1SZWJhc2VkIGFnYWluc3QgaW9tbXUtdHJlZSBjb3JlIGJy
YW5jaC4KPj4+Pgo+Pj4+IEEgZ2VudGxlIHBpbmcgb24gdGhpcy4uLgo+Pj4KPj4+IElzIHRoZXJl
IGEgY29udmluY2luZyBqdXN0aWZpY2F0aW9uIGZvciBtYWludGFpbmluZyB5ZXQgYW5vdGhlciBj
b3B5IG9mCj4+PiB0aGUgb3BzIHBvaW50ZXIgcmF0aGVyIHRoYW4gc2ltcGx5IGRlcmVmZXJlbmNp
bmcgaW9tbXVfZGV2LT5vcHMgYXQgcG9pbnQKPj4+IG9mIHVzZT8KPj4+Cj4+Cj4+IFRCSCwgbm90
aGluZyBJIGNhbiB0aGluayBvZiBub3cuIFRoYXQgd2FzIG1haW5seSB0aGUgd2F5IEkgaW50ZXJw
cmV0ZWQgeW91cgo+PiBzdWdnZXN0aW9uCj4+IGZyb20gdGhlIHYxLiAgTm93IGl0IGxvb2tzIGxp
a2UgeW91IGRpZG7igJl0IG1lYW4gaXQgOikuIEkgYW0gT2sgdG8gcmV3b3JrIGl0IHRvCj4+IGRl
cmVmZXJlbmNlCj4+IGl0IGZyb20gaW9tbXVfZGV2LiBQbGVhc2UgbGV0IG1lIGtub3cuCj4gCj4g
U28gd2UgY2FuIGRvIHNvbWV0aGluZyBsaWtlIHRoaXMsCj4gCj4gaW5kZXggZmQ3NmUyZjU3OWZl
Li41ZmQzMWEzY2VjMTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5jCj4gKysr
IGIvZHJpdmVycy9pb21tdS9pb21tdS5jCj4gQEAgLTI4NjUsMTAgKzI4NjUsMTIgQEAgRVhQT1JU
X1NZTUJPTF9HUEwoaW9tbXVfZndzcGVjX2FkZF9pZHMpOwo+ICAgICovCj4gICBpbnQgaW9tbXVf
ZGV2X2VuYWJsZV9mZWF0dXJlKHN0cnVjdCBkZXZpY2UgKmRldiwgZW51bSBpb21tdV9kZXZfZmVh
dHVyZXMgZmVhdCkKPiAgIHsKPiAtICAgICAgIGNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKm9wcyA9
IGRldi0+YnVzLT5pb21tdV9vcHM7Cj4gKyAgICAgICBpZiAoZGV2LT5pb21tdSAmJiBkZXYtPmlv
bW11LT5pb21tdV9kZXYgJiYgZGV2LT5pb21tdS0+aW9tbXVfZGV2LT5vcHMpCj4gKyAgICAgICAg
ICAgICAgIHN0cnVjdCBpb21tdV9vcHMgICpvcHMgPSBkZXYtPmlvbW11LT5pb21tdV9kZXYtPm9w
czsKPiAgIAo+IC0gICAgICAgaWYgKG9wcyAmJiBvcHMtPmRldl9lbmFibGVfZmVhdCkKPiAtICAg
ICAgICAgICAgICAgcmV0dXJuIG9wcy0+ZGV2X2VuYWJsZV9mZWF0KGRldiwgZmVhdCk7Cj4gKyAg
ICAgICAgICAgICAgIGlmIChvcHMtPmRldl9lbmFibGVfZmVhdCkKPiArICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gb3BzLT5kZXZfZW5hYmxlX2ZlYXQoZGV2LCBmZWF0KTsKPiArICAgICAg
IH0KPiAgIAo+ICAgICAgICAgIHJldHVybiAtRU5PREVWOwo+ICAgfQo+IAo+IEFnYWluLCBub3Qg
c3VyZSB3ZSBuZWVkIHRvIGRvIHRoZSBjaGVja2luZyBmb3IgaW9tbXUtPmRldiBhbmQgb3BzIGhl
cmUuIElmIHRoZQo+IGRldi0+aW9tbXUgaXMgc2V0LCBpcyBpdCBzYWZlIHRvIGFzc3VtZSB0aGF0
IHdlIGhhdmUgYSB2YWxpZCBpb21tdS0+aW9tbXVfZGV2Cj4gYW5kIG9wcyBhbHdheXM/IChNYXkg
YmUgaXQgaXMgc2FmZXIgdG8gZG8gdGhlIGNoZWNraW5nIGluIGNhc2Ugc29tZXRoaW5nCj4gZWxz
ZSBicmVha3MgdGhpcyBhc3N1bXB0aW9uIGluIGZ1dHVyZSkuIFBsZWFzZSBsZXQgbWUga25vdyB5
b3VyIHRob3VnaHRzLgoKSSB0aGluayBpdCAqY291bGQqIGhhcHBlbiB0aGF0IGRldi0+aW9tbXUg
aXMgc2V0IGJ5IGlvbW11X2Z3c3BlY19pbml0KCkgCmJ1dCBpb21tdV9wcm9iZV9kZXZpY2UoKSBs
YXRlciByZWZ1c2VzIHRoZSBkZXZpY2UgZm9yIHdoYXRldmVyIHJlYXNvbiwgCnNvIHdlIHdvdWxk
IHN0aWxsIG5lZWQgdG8gY2hlY2sgaW9tbXUtPmlvbW11X2RldiB0byBiZSBjb21wbGV0ZWx5IHNh
ZmUuIApXZSBjYW4gYXNzdW1lIGlvbW11X2Rldi0+b3BzIGlzIHZhbGlkLCBzaW5jZSBpZiB0aGUg
SU9NTVUgZHJpdmVyIGhhcyAKcmV0dXJuZWQgc29tZXRoaW5nIGJvZ3VzIGZyb20gLnByb2JlX2Rl
dmljZSB0aGVuIGl0J3MgYSBtYWpvciBidWcgaW4gCnRoYXQgZHJpdmVyIGFuZCBjcmFzaGluZyBp
cyB0aGUgYmVzdCBpbmRpY2F0b3IgOikKClJvYmluLgoKPiAKPiBUaGFua3MsCj4gU2hhbWVlcgo+
IAo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
aW9tbXUgbWFpbGluZyBsaXN0Cj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPiBo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQo+
IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
