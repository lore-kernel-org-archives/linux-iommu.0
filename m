Return-Path: <SRS0=o1xy=ZV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBC3C432C0
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 17:24:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C28A208E4
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 17:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Q6Td1VXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C28A208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4D3BB885D8;
	Fri, 29 Nov 2019 17:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vRhyFrDvkJAl; Fri, 29 Nov 2019 17:24:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 734B3885B4;
	Fri, 29 Nov 2019 17:24:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B504C1DD9;
	Fri, 29 Nov 2019 17:24:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3442AC0881
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 17:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2B4D4861A1
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 17:24:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i6_5-qts9027 for <iommu@lists.linux-foundation.org>;
 Fri, 29 Nov 2019 17:24:51 +0000 (UTC)
X-Greylist: delayed 00:05:03 by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4DDE286054
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 17:24:51 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id s18so6299718pfd.8
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 09:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=googlenew;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=PluLd8iVD+LLnEDvxxVn2n44IA0azS1nHZX7RCBx5eI=;
 b=Q6Td1VXNltrpwRpv76nKV38tc62evrFFzSGrUcrypWz1p/dZYd7Tvgm9kkwS5vYrW6
 2yo1d+vpi00Ccj6TOPCn+wYZJnXWyVHNmalLJJQXzihXO5D0eP6m1w2Sr0sk7can3QuP
 SpQelYK6CV6hs6qkENnbI0vvvLx1AwzVIN4MMAkXP8T4mUwjMDbk3q7F9g7A41LWJui2
 aQljwixEwE+If4dd3bR5r9ZqFRXJmHUQCxQ2lzr51QRcEivbOCXS6RUxPdE2V+ispsoa
 QR2Y9zxqMJ7umkhrOLxrf1Creueo1e7BKX3ynvTpOlt1jBqCRCcVIT9mW7eF81es4+9I
 9OsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=PluLd8iVD+LLnEDvxxVn2n44IA0azS1nHZX7RCBx5eI=;
 b=GQvkIVUbJRX460MnfLl1K62GlCqWsyWIVuE0VMBvAlha5SMlB+JhT9fuGxvf4zu9EL
 tzWxZLLo+Gt6UtMJAVy6TPegYbCgQKX1S3luGT7h6z4txTGcnYymy8peYgoMx/Gh+u/T
 vIdnfJrW+7YXj4sfO7mQH7Qaw3TTKc+oSuw7jmjRHTT5dznghBU744Vby7K2wOT0+h5x
 7endo0T8+Xsc2OQ86jYCU3uGI/smDGIKnZkRVzha19N/3xY1F8pgoK8ND/7h2sT3AH8K
 nyqtYyh6XQ1/mopu09bXnt7pbQ5gJ8NoQTVI6xJDKZjQL4zkeOoiSvdC6u373WxoMQWh
 RBow==
X-Gm-Message-State: APjAAAV9raqh8ofBzZLTCxyQ7pVost0Dox9k9JSG9xaZKgrzx9nLFegE
 kp1fKgNK0PZXRl64S6hDMu7aoQ==
X-Google-Smtp-Source: APXvYqyumM5ZLIy9Nuo5UT+YMh25eg7v2oDAI8y12wtwJbV1TUFp0Kv4HPEdAHhSSgvMjjWjWSgzVg==
X-Received: by 2002:aa7:8699:: with SMTP id d25mr3925340pfo.139.1575047988000; 
 Fri, 29 Nov 2019 09:19:48 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
 by smtp.gmail.com with ESMTPSA id q66sm25520301pfb.150.2019.11.29.09.19.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 Nov 2019 09:19:47 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v4 1/2] PCI: Add parameter nr_devfns to pci_add_dma_alias
In-Reply-To: <058383d9-69fe-65e3-e410-eebd99840261@deltatee.com>
Date: Fri, 29 Nov 2019 17:19:42 +0000
Message-Id: <F26CC19F-66C2-466B-AE30-D65E10BA3022@arista.com>
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <20191126173833.GA16069@infradead.org>
 <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
 <9c54c5dd-702c-a19b-38ba-55ab73b24729@deltatee.com>
 <435064D4-00F0-47F5-94D2-2C354F6B1206@arista.com>
 <058383d9-69fe-65e3-e410-eebd99840261@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
X-Mailer: Apple Mail (2.3445.102.3)
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Dmitry Safonov <dima@arista.com>, linux-pci@vger.kernel.org,
 Dmitry Safonov <0x7f454c46@gmail.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>
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
From: James Sewart via iommu <iommu@lists.linux-foundation.org>
Reply-To: James Sewart <jamessewart@arista.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Cgo+IE9uIDI5IE5vdiAyMDE5LCBhdCAxNjo1MCwgTG9nYW4gR3VudGhvcnBlIDxsb2dhbmdAZGVs
dGF0ZWUuY29tPiB3cm90ZToKPiAKPiAKPiAKPiBPbiAyMDE5LTExLTI5IDU6NDkgYS5tLiwgSmFt
ZXMgU2V3YXJ0IHdyb3RlOgo+PiBwY2lfYWRkX2RtYV9hbGlhcyBjYW4gbm93IGJlIHVzZWQgdG8g
Y3JlYXRlIGEgZG1hIGFsaWFzIGZvciBhIHJhbmdlIG9mCj4+IGRldmZucy4KPj4gCj4+IFNpZ25l
ZC1vZmYtYnk6IEphbWVzIFNld2FydCA8amFtZXNzZXdhcnRAYXJpc3RhLmNvbT4KPj4gLS0tCj4+
IGRyaXZlcnMvcGNpL3BjaS5jICAgIHwgMjMgKysrKysrKysrKysrKysrKysrLS0tLS0KPj4gZHJp
dmVycy9wY2kvcXVpcmtzLmMgfCAxNCArKysrKysrLS0tLS0tLQo+PiBpbmNsdWRlL2xpbnV4L3Bj
aS5oICB8ICAyICstCj4+IDMgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTMgZGVs
ZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpLmMgYi9kcml2ZXJz
L3BjaS9wY2kuYwo+PiBpbmRleCBhOTdlMjU3MWE1MjcuLjliMGUzNDgxZmUxNyAxMDA2NDQKPj4g
LS0tIGEvZHJpdmVycy9wY2kvcGNpLmMKPj4gKysrIGIvZHJpdmVycy9wY2kvcGNpLmMKPj4gQEAg
LTU4NTcsNyArNTg1Nyw4IEBAIGludCBwY2lfc2V0X3ZnYV9zdGF0ZShzdHJ1Y3QgcGNpX2RldiAq
ZGV2LCBib29sIGRlY29kZSwKPj4gLyoqCj4+ICAqIHBjaV9hZGRfZG1hX2FsaWFzIC0gQWRkIGEg
RE1BIGRldmZuIGFsaWFzIGZvciBhIGRldmljZQo+PiAgKiBAZGV2OiB0aGUgUENJIGRldmljZSBm
b3Igd2hpY2ggYWxpYXMgaXMgYWRkZWQKPj4gLSAqIEBkZXZmbjogYWxpYXMgc2xvdCBhbmQgZnVu
Y3Rpb24KPj4gKyAqIEBkZXZmbl9mcm9tOiBhbGlhcyBzbG90IGFuZCBmdW5jdGlvbgo+PiArICog
QG5yX2RldmZuczogTnVtYmVyIG9mIHN1YnNlcXVlbnQgZGV2Zm5zIHRvIGFsaWFzCj4+ICAqCj4+
ICAqIFRoaXMgaGVscGVyIGVuY29kZXMgYW4gOC1iaXQgZGV2Zm4gYXMgYSBiaXQgbnVtYmVyIGlu
IGRtYV9hbGlhc19tYXNrCj4+ICAqIHdoaWNoIGlzIHVzZWQgdG8gcHJvZ3JhbSBwZXJtaXNzaWJs
ZSBidXMtZGV2Zm4gc291cmNlIGFkZHJlc3NlcyBmb3IgRE1BCj4+IEBAIC01ODczLDggKzU4NzQs
MTQgQEAgaW50IHBjaV9zZXRfdmdhX3N0YXRlKHN0cnVjdCBwY2lfZGV2ICpkZXYsIGJvb2wgZGVj
b2RlLAo+PiAgKiBjYW5ub3QgYmUgbGVmdCBhcyBhIHVzZXJzcGFjZSBhY3Rpdml0eSkuICBETUEg
YWxpYXNlcyBzaG91bGQgdGhlcmVmb3JlCj4+ICAqIGJlIGNvbmZpZ3VyZWQgdmlhIHF1aXJrcywg
c3VjaCBhcyB0aGUgUENJIGZpeHVwIGhlYWRlciBxdWlyay4KPj4gICovCj4+IC12b2lkIHBjaV9h
ZGRfZG1hX2FsaWFzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHU4IGRldmZuKQo+PiArdm9pZCBwY2lf
YWRkX2RtYV9hbGlhcyhzdHJ1Y3QgcGNpX2RldiAqZGV2LCB1OCBkZXZmbl9mcm9tLCB1bnNpZ25l
ZCBucl9kZXZmbnMpCj4+IHsKPj4gKwlpbnQgZGV2Zm5fdG87Cj4+ICsKPj4gKwlpZiAobnJfZGV2
Zm5zID4gVThfTUFYKzEpCj4+ICsJCW5yX2RldmZucyA9IFU4X01BWCsxOwo+IAo+IFdoeSArMT8g
VGhhdCBkb2Vzbid0IHNlZW0gcmlnaHQgdG8gbWXigKYuCgpVOF9NQVggaXMgdGhlIG1heCBudW1i
ZXIgVTggY2FuIHJlcHJlc2VudCgyNTUpIGJ1dCBpcyBvbmUgbGVzcyB0aGFuIHRoZSBudW1iZXIg
Cm9mIHZhbHVlcyBpdCBjYW4gcmVwcmVzZW50KDI1NikuIGRldmZucyBjYW4gYmUgMC4wIHRvIDFm
LjcgaW5jbHVzaXZlKEkgdGhpbmspIApzbyB0aGUgbnVtYmVyIG9mIHBvc3NpYmxlIGRldmZucyBp
cyAyNTYuIFRoaW5raW5nIGFib3V0IGl0LCBtYXliZSB0aGUgCnphbGxvYyBzaG91bGQgYmUgVThf
TUFYKzEgdG9vPwoKSSBtaWdodCBiZSB3cm9uZyB0aG91Z2gsIHdoYXQgZG8geW91IHJlY2tvbj8K
Cj4gCj4+ICsJZGV2Zm5fdG8gPSBkZXZmbl9mcm9tICsgbnJfZGV2Zm5zIC0gMTsKPj4gKwo+PiAJ
aWYgKCFkZXYtPmRtYV9hbGlhc19tYXNrKQo+PiAJCWRldi0+ZG1hX2FsaWFzX21hc2sgPSBiaXRt
YXBfemFsbG9jKFU4X01BWCwgR0ZQX0tFUk5FTCk7Cj4+IAlpZiAoIWRldi0+ZG1hX2FsaWFzX21h
c2spIHsKPj4gQEAgLTU4ODIsOSArNTg4OSwxNSBAQCB2b2lkIHBjaV9hZGRfZG1hX2FsaWFzKHN0
cnVjdCBwY2lfZGV2ICpkZXYsIHU4IGRldmZuKQo+PiAJCXJldHVybjsKPj4gCX0KPj4gCj4+IC0J
c2V0X2JpdChkZXZmbiwgZGV2LT5kbWFfYWxpYXNfbWFzayk7Cj4+IC0JcGNpX2luZm8oZGV2LCAi
RW5hYmxpbmcgZml4ZWQgRE1BIGFsaWFzIHRvICUwMnguJWRcbiIsCj4+IC0JCSBQQ0lfU0xPVChk
ZXZmbiksIFBDSV9GVU5DKGRldmZuKSk7Cj4+ICsJYml0bWFwX3NldChkZXYtPmRtYV9hbGlhc19t
YXNrLCBkZXZmbl9mcm9tLCBucl9kZXZmbnMpOwo+PiArCj4+ICsJaWYgKG5yX2RldmZucyA9PSAx
KQo+PiArCQlwY2lfaW5mbyhkZXYsICJFbmFibGluZyBmaXhlZCBETUEgYWxpYXMgdG8gJTAyeC4l
ZFxuIiwKPj4gKwkJCQlQQ0lfU0xPVChkZXZmbl9mcm9tKSwgUENJX0ZVTkMoZGV2Zm5fZnJvbSkp
Owo+PiArCWVsc2UgaWYobnJfZGV2Zm5zID4gMSkKPj4gKwkJcGNpX2luZm8oZGV2LCAiRW5hYmxp
bmcgZml4ZWQgRE1BIGFsaWFzIGZvciBkZXZmbiByYW5nZSBmcm9tICUwMnguJWQgdG8gJTAyeC4l
ZFxuIiwKPj4gKwkJCQlQQ0lfU0xPVChkZXZmbl9mcm9tKSwgUENJX0ZVTkMoZGV2Zm5fZnJvbSks
Cj4+ICsJCQkJUENJX1NMT1QoZGV2Zm5fdG8pLCBQQ0lfRlVOQyhkZXZmbl90bykpOwo+PiB9Cj4+
IAo+PiBib29sIHBjaV9kZXZzX2FyZV9kbWFfYWxpYXNlcyhzdHJ1Y3QgcGNpX2RldiAqZGV2MSwg
c3RydWN0IHBjaV9kZXYgKmRldjIpCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9xdWlya3Mu
YyBiL2RyaXZlcnMvcGNpL3F1aXJrcy5jCj4+IGluZGV4IDMyMDI1NWU1ZThmOC4uMGYzZjVhZmM3
M2ZkIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3BjaS9xdWlya3MuYwo+PiArKysgYi9kcml2ZXJz
L3BjaS9xdWlya3MuYwo+PiBAQCAtMzkzMiw3ICszOTMyLDcgQEAgaW50IHBjaV9kZXZfc3BlY2lm
aWNfcmVzZXQoc3RydWN0IHBjaV9kZXYgKmRldiwgaW50IHByb2JlKQo+PiBzdGF0aWMgdm9pZCBx
dWlya19kbWFfZnVuYzBfYWxpYXMoc3RydWN0IHBjaV9kZXYgKmRldikKPj4gewo+PiAJaWYgKFBD
SV9GVU5DKGRldi0+ZGV2Zm4pICE9IDApCj4+IC0JCXBjaV9hZGRfZG1hX2FsaWFzKGRldiwgUENJ
X0RFVkZOKFBDSV9TTE9UKGRldi0+ZGV2Zm4pLCAwKSk7Cj4+ICsJCXBjaV9hZGRfZG1hX2FsaWFz
KGRldiwgUENJX0RFVkZOKFBDSV9TTE9UKGRldi0+ZGV2Zm4pLCAwKSwgMSk7Cj4+IH0KPj4gCj4+
IC8qCj4+IEBAIC0zOTQ2LDcgKzM5NDYsNyBAQCBERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJ
X1ZFTkRPUl9JRF9SSUNPSCwgMHhlNDc2LCBxdWlya19kbWFfZnVuYzBfYWxpYXMpOwo+PiBzdGF0
aWMgdm9pZCBxdWlya19kbWFfZnVuYzFfYWxpYXMoc3RydWN0IHBjaV9kZXYgKmRldikKPj4gewo+
PiAJaWYgKFBDSV9GVU5DKGRldi0+ZGV2Zm4pICE9IDEpCj4+IC0JCXBjaV9hZGRfZG1hX2FsaWFz
KGRldiwgUENJX0RFVkZOKFBDSV9TTE9UKGRldi0+ZGV2Zm4pLCAxKSk7Cj4+ICsJCXBjaV9hZGRf
ZG1hX2FsaWFzKGRldiwgUENJX0RFVkZOKFBDSV9TTE9UKGRldi0+ZGV2Zm4pLCAxKSwgMSk7Cj4+
IH0KPj4gCj4+IC8qCj4+IEBAIC00MDMxLDcgKzQwMzEsNyBAQCBzdGF0aWMgdm9pZCBxdWlya19m
aXhlZF9kbWFfYWxpYXMoc3RydWN0IHBjaV9kZXYgKmRldikKPj4gCj4+IAlpZCA9IHBjaV9tYXRj
aF9pZChmaXhlZF9kbWFfYWxpYXNfdGJsLCBkZXYpOwo+PiAJaWYgKGlkKQo+PiAtCQlwY2lfYWRk
X2RtYV9hbGlhcyhkZXYsIGlkLT5kcml2ZXJfZGF0YSk7Cj4+ICsJCXBjaV9hZGRfZG1hX2FsaWFz
KGRldiwgaWQtPmRyaXZlcl9kYXRhLCAxKTsKPj4gfQo+PiAKPj4gREVDTEFSRV9QQ0lfRklYVVBf
SEVBREVSKFBDSV9WRU5ET1JfSURfQURBUFRFQzIsIDB4MDI4NSwgcXVpcmtfZml4ZWRfZG1hX2Fs
aWFzKTsKPj4gQEAgLTQwNzMsOSArNDA3Myw5IEBAIERFQ0xBUkVfUENJX0ZJWFVQX0hFQURFUigw
eDgwODYsIDB4MjQ0ZSwgcXVpcmtfdXNlX3BjaWVfYnJpZGdlX2RtYV9hbGlhcyk7Cj4+ICAqLwo+
PiBzdGF0aWMgdm9pZCBxdWlya19taWNfeDIwMF9kbWFfYWxpYXMoc3RydWN0IHBjaV9kZXYgKnBk
ZXYpCj4+IHsKPj4gLQlwY2lfYWRkX2RtYV9hbGlhcyhwZGV2LCBQQ0lfREVWRk4oMHgxMCwgMHgw
KSk7Cj4+IC0JcGNpX2FkZF9kbWFfYWxpYXMocGRldiwgUENJX0RFVkZOKDB4MTEsIDB4MCkpOwo+
PiAtCXBjaV9hZGRfZG1hX2FsaWFzKHBkZXYsIFBDSV9ERVZGTigweDEyLCAweDMpKTsKPj4gKwlw
Y2lfYWRkX2RtYV9hbGlhcyhwZGV2LCBQQ0lfREVWRk4oMHgxMCwgMHgwKSwgMSk7Cj4+ICsJcGNp
X2FkZF9kbWFfYWxpYXMocGRldiwgUENJX0RFVkZOKDB4MTEsIDB4MCksIDEpOwo+PiArCXBjaV9h
ZGRfZG1hX2FsaWFzKHBkZXYsIFBDSV9ERVZGTigweDEyLCAweDMpLCAxKTsKPj4gfQo+PiBERUNM
QVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHgyMjYwLCBxdWlya19t
aWNfeDIwMF9kbWFfYWxpYXMpOwo+PiBERUNMQVJFX1BDSV9GSVhVUF9IRUFERVIoUENJX1ZFTkRP
Ul9JRF9JTlRFTCwgMHgyMjY0LCBxdWlya19taWNfeDIwMF9kbWFfYWxpYXMpOwo+PiBAQCAtNTI3
Myw3ICs1MjczLDcgQEAgc3RhdGljIHZvaWQgcXVpcmtfc3dpdGNodGVjX250Yl9kbWFfYWxpYXMo
c3RydWN0IHBjaV9kZXYgKnBkZXYpCj4+IAkJCXBjaV9kYmcocGRldiwKPj4gCQkJCSJBbGlhc2lu
ZyBQYXJ0aXRpb24gJWQgUHJveHkgSUQgJTAyeC4lZFxuIiwKPj4gCQkJCXBwLCBQQ0lfU0xPVChk
ZXZmbiksIFBDSV9GVU5DKGRldmZuKSk7Cj4+IC0JCQlwY2lfYWRkX2RtYV9hbGlhcyhwZGV2LCBk
ZXZmbik7Cj4+ICsJCQlwY2lfYWRkX2RtYV9hbGlhcyhwZGV2LCBkZXZmbiwgMSk7Cj4+IAkJfQo+
PiAJfQo+PiAKPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcGNpLmggYi9pbmNsdWRlL2xp
bnV4L3BjaS5oCj4+IGluZGV4IDFhNmNmMTllYWMyZC4uODRhOGQ0YzJiMjRlIDEwMDY0NAo+PiAt
LS0gYS9pbmNsdWRlL2xpbnV4L3BjaS5oCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvcGNpLmgKPj4g
QEAgLTIzMjMsNyArMjMyMyw3IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IGVlaF9kZXYgKnBjaV9k
ZXZfdG9fZWVoX2RldihzdHJ1Y3QgcGNpX2RldiAqcGRldikKPj4gfQo+PiAjZW5kaWYKPj4gCj4+
IC12b2lkIHBjaV9hZGRfZG1hX2FsaWFzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHU4IGRldmZuKTsK
Pj4gK3ZvaWQgcGNpX2FkZF9kbWFfYWxpYXMoc3RydWN0IHBjaV9kZXYgKmRldiwgdTggZGV2Zm5f
ZnJvbSwgdW5zaWduZWQgbnJfZGV2Zm5zKTsKPj4gYm9vbCBwY2lfZGV2c19hcmVfZG1hX2FsaWFz
ZXMoc3RydWN0IHBjaV9kZXYgKmRldjEsIHN0cnVjdCBwY2lfZGV2ICpkZXYyKTsKPj4gaW50IHBj
aV9mb3JfZWFjaF9kbWFfYWxpYXMoc3RydWN0IHBjaV9kZXYgKnBkZXYsCj4+IAkJCSAgIGludCAo
KmZuKShzdHJ1Y3QgcGNpX2RldiAqcGRldiwKPj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
