Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBF3C433DB
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 15:43:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8821821D81
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 15:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8821821D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0980A8735E;
	Fri, 22 Jan 2021 15:43:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tiQpe8zXi2W8; Fri, 22 Jan 2021 15:43:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 14ECF8733B;
	Fri, 22 Jan 2021 15:43:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8E74C08A1;
	Fri, 22 Jan 2021 15:43:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69C8FC013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 15:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5078E86A95
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 15:43:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12FYHmS5FFi5 for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 15:43:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7AA0E86A5B
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 15:43:15 +0000 (UTC)
IronPort-SDR: 6t+dKof0FO/G+kngfcjh5uGAbqAbpS0JLx+9ytYpaluCI1GJfqKCzRyzDIfWitYAzMjbcfqjpK
 3L8n357M8a9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="198218112"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; d="scan'208";a="198218112"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2021 07:43:14 -0800
IronPort-SDR: HhVvVYp9UNmAue99p2JpAnb8MYodJe2PpnP5Q2H5t3j+vb7w+TRaAAehQbJmESyDt/fKxv9iqK
 jTA3C8i7r2Gg==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; d="scan'208";a="367469522"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.160.72])
 ([10.212.160.72])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2021 07:43:12 -0800
Subject: Re: [PATCH v9 05/10] uacce: Enable IOMMU_DEV_FEAT_IOPF
To: Zhou Wang <wangzhou1@hisilicon.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 will@kernel.org
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-6-jean-philippe@linaro.org>
 <e14f47bd-1b0c-1905-3bb7-62e1c5b096c7@intel.com>
 <d25faa15-eaaf-a3b8-adaf-f7c81653f688@hisilicon.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <ee066d95-c8ef-887b-35bc-d47d641c9f58@intel.com>
Date: Fri, 22 Jan 2021 08:43:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <d25faa15-eaaf-a3b8-adaf-f7c81653f688@hisilicon.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-acpi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 sudeep.holla@arm.com, rjw@rjwysocki.net, iommu@lists.linux-foundation.org,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>, vivek.gautam@arm.com,
 robh+dt@kernel.org, linux-accelerators@lists.ozlabs.org, guohanjun@huawei.com,
 zhangfei.gao@linaro.org, Dan Williams <dan.j.williams@intel.com>,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

Ck9uIDEvMjIvMjAyMSA0OjUzIEFNLCBaaG91IFdhbmcgd3JvdGU6Cj4gT24gMjAyMS8xLzIxIDQ6
NDcsIERhdmUgSmlhbmcgd3JvdGU6Cj4+IE9uIDEvOC8yMDIxIDc6NTIgQU0sIEplYW4tUGhpbGlw
cGUgQnJ1Y2tlciB3cm90ZToKPj4+IFRoZSBJT1BGIChJL08gUGFnZSBGYXVsdCkgZmVhdHVyZSBp
cyBub3cgZW5hYmxlZCBpbmRlcGVuZGVudGx5IGZyb20gdGhlCj4+PiBTVkEgZmVhdHVyZSwgYmVj
YXVzZSBzb21lIElPUEYgaW1wbGVtZW50YXRpb25zIGFyZSBkZXZpY2Utc3BlY2lmaWMgYW5kCj4+
PiBkbyBub3QgcmVxdWlyZSBJT01NVSBzdXBwb3J0IGZvciBQQ0llIFBSSSBvciBBcm0gU01NVSBz
dGFsbC4KPj4+Cj4+PiBFbmFibGUgSU9QRiB1bmNvbmRpdGlvbmFsbHkgd2hlbiBlbmFibGluZyBT
VkEgZm9yIG5vdy4gSW4gdGhlIGZ1dHVyZSwgaWYKPj4+IGEgZGV2aWNlIGRyaXZlciBpbXBsZW1l
bnRpbmcgYSB1YWNjZSBpbnRlcmZhY2UgZG9lc24ndCBuZWVkIElPUEYKPj4+IHN1cHBvcnQsIGl0
IHdpbGwgbmVlZCB0byB0ZWxsIHRoZSB1YWNjZSBtb2R1bGUsIGZvciBleGFtcGxlIHdpdGggYSBu
ZXcKPj4+IGZsYWcuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogSmVhbi1QaGlsaXBwZSBCcnVja2Vy
IDxqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc+Cj4+PiAtLS0KPj4+IENjOiBBcm5kIEJlcmdtYW5u
IDxhcm5kQGFybmRiLmRlPgo+Pj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+Cj4+PiBDYzogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbGluYXJv
Lm9yZz4KPj4+IENjOiBaaG91IFdhbmcgPHdhbmd6aG91MUBoaXNpbGljb24uY29tPgo+Pj4gLS0t
Cj4+PiAgICBkcml2ZXJzL21pc2MvdWFjY2UvdWFjY2UuYyB8IDMyICsrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tCj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwg
NyBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL3VhY2NlL3Vh
Y2NlLmMgYi9kcml2ZXJzL21pc2MvdWFjY2UvdWFjY2UuYwo+Pj4gaW5kZXggZDA3YWY0ZWRmY2Fj
Li40MWVmMWViNjJhMTQgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL21pc2MvdWFjY2UvdWFjY2Uu
Ywo+Pj4gKysrIGIvZHJpdmVycy9taXNjL3VhY2NlL3VhY2NlLmMKPj4+IEBAIC0zODUsNiArMzg1
LDI0IEBAIHN0YXRpYyB2b2lkIHVhY2NlX3JlbGVhc2Uoc3RydWN0IGRldmljZSAqZGV2KQo+Pj4g
ICAgICAgIGtmcmVlKHVhY2NlKTsKPj4+ICAgIH0KPj4+ICAgICtzdGF0aWMgdW5zaWduZWQgaW50
IHVhY2NlX2VuYWJsZV9zdmEoc3RydWN0IGRldmljZSAqcGFyZW50LCB1bnNpZ25lZCBpbnQgZmxh
Z3MpCj4+PiArewo+Pj4gKyAgICBpZiAoIShmbGFncyAmIFVBQ0NFX0RFVl9TVkEpKQo+Pj4gKyAg
ICAgICAgcmV0dXJuIGZsYWdzOwo+Pj4gKwo+Pj4gKyAgICBmbGFncyAmPSB+VUFDQ0VfREVWX1NW
QTsKPj4+ICsKPj4+ICsgICAgaWYgKGlvbW11X2Rldl9lbmFibGVfZmVhdHVyZShwYXJlbnQsIElP
TU1VX0RFVl9GRUFUX0lPUEYpKQo+Pj4gKyAgICAgICAgcmV0dXJuIGZsYWdzOwo+Pj4gKwo+Pj4g
KyAgICBpZiAoaW9tbXVfZGV2X2VuYWJsZV9mZWF0dXJlKHBhcmVudCwgSU9NTVVfREVWX0ZFQVRf
U1ZBKSkgewo+Pj4gKyAgICAgICAgaW9tbXVfZGV2X2Rpc2FibGVfZmVhdHVyZShwYXJlbnQsIElP
TU1VX0RFVl9GRUFUX0lPUEYpOwo+Pj4gKyAgICAgICAgcmV0dXJuIGZsYWdzOwo+Pj4gKyAgICB9
Cj4+IFNvcnJ5IHRvIGp1bXAgaW4gYSBiaXQgbGF0ZSBvbiB0aGlzIGFuZCBub3Qgc3BlY2lmaWNh
bGx5IHRvd2FyZHMgdGhlCj4+IGludGVudCBvZiB0aGlzIHBhdGNoLiBCdXQgSSdkIGxpa2UgdG8g
c3RhcnQgYSBkaXNjdXNzaW9uIG9uIGlmIHdlIHdhbnQKPj4gdG8gcHVzaCB0aGUgaW9tbXUgZGV2
IGZlYXR1cmUgZW5hYmxpbmcgdG8gdGhlIGRldmljZSBkcml2ZXIgaXRzZWxmIHJhdGhlcgo+PiB0
aGFuIGhhdmluZyBVQUNDRSBjb250cm9sIHRoaXM/IE1heWJlIGFsbG93IHRoZSBkZXZpY2UgZHJp
dmVyIHRvIG1hbmFnZQo+PiB0aGUgZmVhdHVyZSBiaXRzIGFuZCBVQUNDRSBvbmx5IHZlcmlmeSB0
aGF0IHRoZXkgYXJlIGVuYWJsZWQ/Cj4+Cj4+IDEuIFRoZSBkZXZpY2UgZHJpdmVyIGtub3dzIHdo
YXQgcGxhdGZvcm0gaXQncyBvbiBhbmQgd2hhdCBzcGVjaWZpYwo+PiAgICAgZmVhdHVyZSBiaXRz
IGl0cyBkZXZpY2VzIHN1cHBvcnRzLiBNYXliZSBpbiB0aGUgZnV0dXJlIGlmIHRoZXJlIGFyZQo+
PiAgICAgZmVhdHVyZSBiaXRzIHRoYXQncyBuZWVkZWQgb24gb25lIHBsYXRmb3JtIGFuZCBub3Qg
b24gYW5vdGhlcj8KPiBIaSBEYXZlLAo+Cj4gIEZyb20gdGhlIGRpc2N1c3Npb24gaW4gdGhpcyBz
ZXJpZXMsIHRoZSBtZWFuaW5nIG9mIElPTU1VX0RFVl9GRUFUX0lPUEYgaGVyZQo+IGlzIHRoZSBJ
T1BGIGNhcGFiaWxpdHkgb2YgaW9tbXUgZGV2aWNlIGl0c2VsZi4gU28gSSB0aGluayBjaGVjayBp
dCBpbiBVQUNDRQo+IHdpbGwgYmUgZmluZS4KPgo+PiAyLiBUaGlzIGFsbG93cyB0aGUgcG9zc2li
aWxpdHkgb2YgbXVsdGlwbGUgdWFjY2UgZGV2aWNlIHJlZ2lzdGVyZWQgdG8gMQo+PiAgICAgcGNp
IGRldiwgd2hpY2ggZm9yIGEgZGV2aWNlIHdpdGggYXN5bW1ldHJpYyBxdWV1ZXMgKEludGVsIERT
QS9pZHhkCj4+ICAgICBkcml2ZXIpIHRoYXQgaXMgZGVzaXJhYmxlIGZlYXR1cmUuIFRoZSBjdXJy
ZW50IHNldHVwIGZvcmNlcyBhIHNpbmdsZQo+PiAgICAgdWFjY2UgZGV2aWNlIHBlciBwZGV2LiBJ
ZiBhZGRpdGlvbmFsIHVhY2NlIGRldnMgYXJlIHJlZ2lzdGVyZWQsIHRoZQo+PiAgICAgZmlyc3Qg
cmVtb3ZhbCBvZiB1YWNjZSBkZXZpY2Ugd2lsbCBkaXNhYmxlIHRoZSBmZWF0dXJlIGJpdCBmb3Ig
dGhlCj4+ICAgICByZXN0IG9mIHRoZSByZWdpc3RlcmVkIGRldmljZXMuIFdpdGggdWFjY2UgbWFu
YWdpbmcgdGhlIGZlYXR1cmUgYml0LAo+PiAgICAgaXQgd291bGQgbmVlZCB0byBhZGQgZGV2aWNl
IGNvbnRleHQgdG8gdGhlIHBhcmVudCBwZGV2IGFuZCByZWYKPj4gICAgIGNvdW50aW5nLiBJdCBt
YXkgYmUgY2xlYW5lciB0byBqdXN0IGFsbG93IGRldmljZSBkcml2ZXIgdG8gbWFuYWdlCj4+ICAg
ICB0aGUgZmVhdHVyZSBiaXRzIGFuZCB0aGUgZHJpdmVyIHNob3VsZCBoYXZlIGFsbCB0aGUgaW5m
b3JtYXRpb24gb24KPj4gICAgIHdoZW4gdGhlIGZlYXR1cmUgbmVlZHMgdG8gYmUgdHVybmVkIG9u
IGFuZCBvZmYuCj4gWWVzLCB3ZSBoYXZlIHRoaXMgcHJvYmxlbSwgaG93ZXZlciwgdGhpcyBwcm9i
bGVtIGV4aXN0cyBmb3IgSU9NTVVfREVWX0ZFQVRfU1ZBCj4gdG9vLiBIb3cgYWJvdXQgdG8gZml4
IGl0IGluIGFub3RoZXIgcGF0Y2g/CgpIaSBaaG91LAoKUmlnaHQgdGhhdCdzIHdoYXQgSSdtIGlt
cGx5aW5nLiBJJ20gbm90IHB1c2hpbmcgYmFjayBvbiB0aGUgSU9QRiBmZWF0dXJlIApzZXQuIEp1
c3QgdHJ5aW5nIHRvIHN1cnZlecKgIHRoZSBvcGluaW9ucyBmcm9tIHBlb3BsZSBvbiBtb3Zpbmcg
dGhlIApmZWF0dXJlIHNldHRpbmdzIHRvIHRoZSBhY3R1YWwgZHJpdmVycyByYXRoZXIgdGhhbiBo
YXZpbmcgaXQgaW4gVUFDQ0UuIEkgCndpbGwgY3JlYXRlIHNvbWUgcGF0Y2hlcyB0byBzaG93IHdo
YXQgSSBtZWFuIGZvciBjb21tZW50cy4KCgo+Cj4gQmVzdCwKPiBaaG91Cj4KPj4gLSBEYXZlSgo+
Pgo+Pgo+Pj4gKwo+Pj4gKyAgICByZXR1cm4gZmxhZ3MgfCBVQUNDRV9ERVZfU1ZBOwo+Pj4gK30K
Pj4+ICsKPj4+ICAgIC8qKgo+Pj4gICAgICogdWFjY2VfYWxsb2MoKSAtIGFsbG9jIGFuIGFjY2Vs
ZXJhdG9yCj4+PiAgICAgKiBAcGFyZW50OiBwb2ludGVyIG9mIHVhY2NlIHBhcmVudCBkZXZpY2UK
Pj4+IEBAIC00MDQsMTEgKzQyMiw3IEBAIHN0cnVjdCB1YWNjZV9kZXZpY2UgKnVhY2NlX2FsbG9j
KHN0cnVjdCBkZXZpY2UgKnBhcmVudCwKPj4+ICAgICAgICBpZiAoIXVhY2NlKQo+Pj4gICAgICAg
ICAgICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKPj4+ICAgIC0gICAgaWYgKGZsYWdzICYgVUFD
Q0VfREVWX1NWQSkgewo+Pj4gLSAgICAgICAgcmV0ID0gaW9tbXVfZGV2X2VuYWJsZV9mZWF0dXJl
KHBhcmVudCwgSU9NTVVfREVWX0ZFQVRfU1ZBKTsKPj4+IC0gICAgICAgIGlmIChyZXQpCj4+PiAt
ICAgICAgICAgICAgZmxhZ3MgJj0gflVBQ0NFX0RFVl9TVkE7Cj4+PiAtICAgIH0KPj4+ICsgICAg
ZmxhZ3MgPSB1YWNjZV9lbmFibGVfc3ZhKHBhcmVudCwgZmxhZ3MpOwo+Pj4gICAgICAgICAgdWFj
Y2UtPnBhcmVudCA9IHBhcmVudDsKPj4+ICAgICAgICB1YWNjZS0+ZmxhZ3MgPSBmbGFnczsKPj4+
IEBAIC00MzIsOCArNDQ2LDEwIEBAIHN0cnVjdCB1YWNjZV9kZXZpY2UgKnVhY2NlX2FsbG9jKHN0
cnVjdCBkZXZpY2UgKnBhcmVudCwKPj4+ICAgICAgICByZXR1cm4gdWFjY2U7Cj4+PiAgICAgIGVy
cl93aXRoX3VhY2NlOgo+Pj4gLSAgICBpZiAoZmxhZ3MgJiBVQUNDRV9ERVZfU1ZBKQo+Pj4gKyAg
ICBpZiAoZmxhZ3MgJiBVQUNDRV9ERVZfU1ZBKSB7Cj4+PiAgICAgICAgICAgIGlvbW11X2Rldl9k
aXNhYmxlX2ZlYXR1cmUodWFjY2UtPnBhcmVudCwgSU9NTVVfREVWX0ZFQVRfU1ZBKTsKPj4+ICsg
ICAgICAgIGlvbW11X2Rldl9kaXNhYmxlX2ZlYXR1cmUodWFjY2UtPnBhcmVudCwgSU9NTVVfREVW
X0ZFQVRfSU9QRik7Cj4+PiArICAgIH0KPj4+ICAgICAgICBrZnJlZSh1YWNjZSk7Cj4+PiAgICAg
ICAgcmV0dXJuIEVSUl9QVFIocmV0KTsKPj4+ICAgIH0KPj4+IEBAIC00ODcsOCArNTAzLDEwIEBA
IHZvaWQgdWFjY2VfcmVtb3ZlKHN0cnVjdCB1YWNjZV9kZXZpY2UgKnVhY2NlKQo+Pj4gICAgICAg
IG11dGV4X3VubG9jaygmdWFjY2UtPnF1ZXVlc19sb2NrKTsKPj4+ICAgICAgICAgIC8qIGRpc2Fi
bGUgc3ZhIG5vdyBzaW5jZSBubyBvcGVuZWQgcXVldWVzICovCj4+PiAtICAgIGlmICh1YWNjZS0+
ZmxhZ3MgJiBVQUNDRV9ERVZfU1ZBKQo+Pj4gKyAgICBpZiAodWFjY2UtPmZsYWdzICYgVUFDQ0Vf
REVWX1NWQSkgewo+Pj4gICAgICAgICAgICBpb21tdV9kZXZfZGlzYWJsZV9mZWF0dXJlKHVhY2Nl
LT5wYXJlbnQsIElPTU1VX0RFVl9GRUFUX1NWQSk7Cj4+PiArICAgICAgICBpb21tdV9kZXZfZGlz
YWJsZV9mZWF0dXJlKHVhY2NlLT5wYXJlbnQsIElPTU1VX0RFVl9GRUFUX0lPUEYpOwo+Pj4gKyAg
ICB9Cj4+PiAgICAgICAgICBpZiAodWFjY2UtPmNkZXYpCj4+PiAgICAgICAgICAgIGNkZXZfZGV2
aWNlX2RlbCh1YWNjZS0+Y2RldiwgJnVhY2NlLT5kZXYpOwo+PiAuCj4+Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
