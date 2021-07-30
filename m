Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A930EC432BE
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 12:52:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B60860FE7
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 12:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B60860FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0980260E74;
	Fri, 30 Jul 2021 12:52:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tgVpO0DKOozy; Fri, 30 Jul 2021 12:52:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D7B38605FB;
	Fri, 30 Jul 2021 12:52:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF8E0C0010;
	Fri, 30 Jul 2021 12:52:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE188C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 12:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6D3940558
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 12:52:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gpXDlPFlB8_y for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 12:52:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0E2A40525
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 12:52:10 +0000 (UTC)
Received: from [IPv6:2a02:810a:880:f54:51e7:d967:c146:d0c] (unknown
 [IPv6:2a02:810a:880:f54:51e7:d967:c146:d0c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7DA241F448DA;
 Fri, 30 Jul 2021 13:52:07 +0100 (BST)
Subject: Re: [PATCH v7 3/4] iommu: rockchip: Add internal ops to handle
 variants
To: Robin Murphy <robin.murphy@arm.com>, =?UTF-8?Q?Heiko_St=c3=bcbner?=
 <heiko@sntech.de>, Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 joro@8bytes.org, will@kernel.org, robh+dt@kernel.org, xxm@rock-chips.com,
 Ezequiel Garcia <ezequiel@collabora.com>
References: <20210525121551.606240-1-benjamin.gaignard@collabora.com>
 <20210525121551.606240-4-benjamin.gaignard@collabora.com>
 <c6175f3d-a324-9fb5-bd39-cfe0447ee5e7@collabora.com>
 <3544194.oiGErgHkdL@diego> <06cdd178-66af-9ff7-5100-3da4e901040f@arm.com>
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <4ad13d07-85d3-390d-123c-a7ed47056385@collabora.com>
Date: Fri, 30 Jul 2021 14:52:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <06cdd178-66af-9ff7-5100-3da4e901040f@arm.com>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org
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

CgpPbiAyOS4wNy4yMSAxODo1OCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjEtMDctMjkg
MTc6MDgsIEhlaWtvIFN0w7xibmVyIHdyb3RlOgo+PiBIaSBEYWZuYSwKPj4KPj4gQW0gRG9ubmVy
c3RhZywgMjkuIEp1bGkgMjAyMSwgMTc6NTk6MjYgQ0VTVCBzY2hyaWViIERhZm5hIEhpcnNjaGZl
bGQ6Cj4+PiBPbiAyNS4wNS4yMSAxNDoxNSwgQmVuamFtaW4gR2FpZ25hcmQgd3JvdGU6Cj4+Pj4g
QEAgLTg3OSw3ICs4OTUsNyBAQCBzdGF0aWMgaW50IHJrX2lvbW11X2VuYWJsZShzdHJ1Y3Qgcmtf
aW9tbXUgKmlvbW11KQo+Pj4+IMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgaW9tbXUtPm51
bV9tbXU7IGkrKykgewo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJrX2lvbW11X3dyaXRlKGlv
bW11LT5iYXNlc1tpXSwgUktfTU1VX0RURV9BRERSLAo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmtfZG9tYWluLT5kdF9kbWEpOwo+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmtfb3BzLT5kbWFfYWRkcl9kdGUocmtfZG9tYWluLT5k
dF9kbWEpKTsKPj4+Cj4+PiBIaSwKPj4+IFRoaXMgaXMgbm90IHJlbGF0ZWQgdG8gdGhhdCBwYXRj
aCwgSSB3YXMgd29uZHJpbmcgd2h5IGFyZSBhbGwgbW11IGRldmljZXMgaW5pdGlhbGl6ZWQKPj4+
IHdpdGggdGhlIHNhbWUgZHRfZG1hPwo+Pj4gSSBzZWUgZm9yIGV4YW1wbGUgdGhhdCB0aGUgaXNw
MF9tbXUgaW4gcmszMzk5LmR0c2kgaGFzIHR3byByZXNvdXJjZXMuIENhbid0IGVhY2ggcmVzb3Vy
Y2UKPj4+IGJlIGluaXRpYWxpemVkIHdpdGggZGlmZmVyZW50IGR0X2RtYSBhbmQgdGhpcyB3YXkg
dGhlcmUgYXJlIHR3byBkdCB0YWJsZXMgaW5zdGVhZCBvZiB0aGUgdHdvIG1tdXMgcG9pbnRpbmcK
Pj4+IHRvIHRoZSBzYW1lIGR0IHRhYmxlLgo+Pgo+PiBtYXliZQo+PiBnaXQgbG9nIC0xIGNkNjQz
OGM1Zjg0NDY2OTFhZmE0ODI5ZmUxYTlkN2I2NTYyMDRmMTEKPj4KPj4gImlvbW11L3JvY2tjaGlw
OiBSZWNvbnN0cnVjdCB0byBzdXBwb3J0IG11bHRpIHNsYXZlcwo+PiBUaGVyZSBhcmUgc29tZSBJ
UHMsIHN1Y2ggYXMgdmlkZW8gZW5jb2Rlci9kZWNvZGVyLCBjb250YWlucyAyIHNsYXZlIGlvbW11
cywKPj4gb25lIGZvciByZWFkaW5nIGFuZCB0aGUgb3RoZXIgZm9yIHdyaXRpbmcuIFRoZXkgc2hh
cmUgdGhlIHNhbWUgaXJxIGFuZAo+PiBjbG9jayB3aXRoIG1hc3Rlci4KPj4gVGhpcyBwYXRjaCBy
ZWNvbnN0cnVjdHMgdG8gc3VwcG9ydCB0aGlzIGNhc2UgYnkgbWFraW5nIHRoZW0gc2hhcmUgdGhl
IHNhbWUKPj4gUGFnZSBEaXJlY3RvcnksIFBhZ2UgVGFibGVzIGFuZCBldmVuIHRoZSByZWdpc3Rl
ciBvcGVyYXRpb25zLgo+PiBUaGF0IG1lYW5zIGV2ZXJ5IGluc3RydWN0aW9uIHRvIHRoZSByZWFk
aW5nIE1NVSByZWdpc3RlcnMgd291bGQgYmUKPj4gZHVwbGljYXRlZCB0byB0aGUgd3JpdGluZyBN
TVUgYW5kIHZpY2UgdmVyc2EuIgo+IAo+IFJpZ2h0LiBJbiB0aGVvcnkgd2UgKmNvdWxkKiBtYWlu
dGFpbiBhIHNlcGFyYXRlIHBhZ2V0YWJsZSBmb3IgZWFjaCBJT01NVSBpbnN0YW5jZSwgYnV0IGl0
IHdvdWxkIGp1c3QgbGVhZCB0byBhIGxvYWQgb2YgY29tcGxleGl0eSBhbmQgb3ZlcmhlYWQuIEZv
ciBhIG1hcCByZXF1ZXN0LCB3ZSdkIGhhdmUgdG8gZG8gZXh0cmEgd29yayB0byBkZWNpZGUgd2hp
Y2ggdGFibGUocykgbmVlZCBtb2RpZnlpbmcsIGFuZCBkdXBsaWNhdGUgYWxsIHRoZSB3b3JrIG9m
IHRoZSBhY3R1YWwgbWFwcGluZyBpZiBpdCdzIG1vcmUgdGhhbiBvbmUuIEZvciBhbiB1bm1hcCBy
ZXF1ZXN0LCB3ZSdkIGhhdmUgbm8gY2hvaWNlIGJ1dCB0byB3YWxrICphbGwqIHRoZSB0YWJsZXMg
YmFja2luZyB0aGF0IGRvbWFpbiB0byBmaWd1cmUgb3V0IHdoaWNoIChpZiBhbnkpIGFjdHVhbGx5
IGhhZCBpdCBtYXBwZWQgaW4gdGhlIGZpcnN0IHBsYWNlLgo+IAo+IEdpdmVuIHRoYXQgd2UgYWxy
ZWFkeSBoYXZlIGRpc3RpbmN0IHJlYWQgYW5kIHdyaXRlIHBlcm1pc3Npb25zIGZvciBtYXBwaW5n
cyB3aXRoaW4gYSBzaW5nbGUgdGFibGUsIHRoZXJlJ3Mgbm90IGV2ZW4gYW55IGZ1bmN0aW9uYWwg
YmVuZWZpdCB0aGF0IGNvdWxkIGJlIGdhaW5lZCBpbiB0aGlzIGNhc2UgKGFuZCBpbiB0aGUgbW9y
ZSBnZW5lcmFsIGNhc2Ugd2hlcmUgdGhlIGRldmljZSBtaWdodCBlbWl0IGFsbCBraW5kcyBvZiB0
cmFuc2FjdGlvbnMgZnJvbSBhbGwgaXRzIGludGVyZmFjZXMgeW91J2QgaGF2ZSB0byBtYWludGFp
biBpZGVudGljYWwgbWFwcGluZ3MgZm9yIGFsbCBpdHMgSU9NTVVzIGFueXdheSkuIFNhdmluZyBt
ZW1vcnkgYW5kIGNvZGUgY29tcGxleGl0eSBieSBwaHlzaWNhbGx5IHNoYXJpbmcgb25lIHBhZ2V0
YWJsZSBhbmQgbm90IHdvcnJ5aW5nIGFib3V0IHRyeWluZyB0byBkbyBzZWxlY3RpdmUgVExCIG1h
aW50ZW5hbmNlIGlzIGEgYmlnZ2VyIHdpbiB0aGFuIGFueXRoaW5nIGVsc2UgY291bGQgYmUuCj4g
Cj4gUm9iaW4uCgpIaSwgSSBqdXN0IHRyeSB0byB1bmRlcnN0YW5kIGhvdyB0aGlzIGlvbW11IGhh
cmR3YXJlL3NvZnR3YXJlIHdvcmtzLiBJIGhhdmUgdHdvIHF1ZXN0aW9ucywKCjEuIFNvIHdlIGN1
cnJlbnRseSBtaXNzIGEgcG90ZW50aWFsIG1hcHBpbmcgb2YgdGhlIGhhcmR3YXJlIHJpZ2h0PyBJ
IG1lYW4gLCBlYWNoIG1tdSBjYW4gbWFwIDEwMjQqMTAyNCo0SyA9IDRHIGFkZHJlc3Nlcywgc28g
dHdvIG1tdXMgY2FuIHBvdGVudGlhbGx5IG1hcCA4Ry4gQnV0IHNpbmNlCndlIHNldCB0aGVtIHRv
IGlkZW50aWNhbCB2YWx1ZXMsIHdlIGNhbiBtYXAgb25seSB1cCB0byA0Ry4KMi4gV2hhdCBpcyB0
aGUgYmVuZWZpdCBvZiBzZXR0aW5nIGFsbCBtbXVzIGlmIHRoZXkgYXJlIGFsbCBzZXQgdG8gdGhl
IHNhbWUgdmFsdWVzPyBDYW4ndCB3ZSBqdXN0IHdvcmsgd2l0aCB0aGUgZmlyc3QgbW11IGxpa2Ug
aXQgd2FzIGRvbmUgYmVmb3JlIHRoYXQgcGF0Y2gKY2Q2NDM4YzVmODQ0NjY5MWFmYTQ4MjlmZTFh
OWQ3YjY1NjIwNGYxMQoKVGhhbmtzLApEYWZuYQoKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
