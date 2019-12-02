Return-Path: <SRS0=Z2AP=ZY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3572C432C0
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 07:14:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB2A215F1
	for <iommu@archiver.kernel.org>; Mon,  2 Dec 2019 07:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flfA5SqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB2A215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6BE1B85F34;
	Mon,  2 Dec 2019 07:14:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c92-Cunsl1wi; Mon,  2 Dec 2019 07:14:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DEA7F85EBE;
	Mon,  2 Dec 2019 07:14:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFA33C1798;
	Mon,  2 Dec 2019 07:14:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF676C1DD9
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 07:14:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D9D3F20027
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 07:14:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LVP1Zk5yE22W for <iommu@lists.linux-foundation.org>;
 Mon,  2 Dec 2019 07:14:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id BD6BE204E4
 for <iommu@lists.linux-foundation.org>; Mon,  2 Dec 2019 07:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575270867;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2TOYYMgv/uXyxVD64yQ25KG0kpXvJnwqIqrwjffodn0=;
 b=flfA5SqPl5qyEMWJYs8neY/zjKPfKX36Flr9DvwsWgb/qPfzkVPFAorRJ7QqBEdIsC/R7u
 a6qMKzq7JEkVBJlM0GzuEKsE+t8NsuHrGmwloRcbU1DpcmKqj6JXA1QIGIlBXNf2aC7I/i
 DV8WJ1ws/u83NRCDVpMzQCjvvMWNwjI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-GoErT8dkPvW12mYViIFGyg-1; Mon, 02 Dec 2019 02:14:26 -0500
Received: by mail-pf1-f199.google.com with SMTP id h76so6957065pfe.1
 for <iommu@lists.linux-foundation.org>; Sun, 01 Dec 2019 23:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=LvBZlwttzzQw5hgM5NoX7JKx4jc2xLsnGToCKZ//WmM=;
 b=IgrIHHfLhmUBRE6I+G2nESLai2Qfc7Zl0PEF+qC3N/I5jWtgSvU22Mu0DiMy3Vyea+
 zVtP1yuMaR767ZyuW1bW9WkrJw8Z/jAtuPE3zBCJtTlDKTxkzsWC3MV3LCTBMfPAbQKM
 viZCCPSl31tEeyQ19uSihKP+Mr82Q/vtFfuC36Wc6TndWD5Y7EjVRtSZTusRixyOk217
 2PyE4aiVuivZuEFxs4szQ4RNMlnY6xtL3G+DD6tO1p5ooEVj7cn6+yEn0ycbnZtp2vqL
 7LMRCHxgaGnzBR+3Y0sivSo+bG7zEWIi3MXrd+DIbFeFaG1XmitY41oln7KiEnxAO8qT
 ToIg==
X-Gm-Message-State: APjAAAUYwMo8X9L4oA7RLT5cHPoXNhEUN+9dJaUIMT5wTqwwFSPQJF8u
 98NTbj6YLFzNxXw20TScwgKwc9qrnV26ZNt1/3XSZQrN9zLv/qsYgcotqMmCmTntmLpa8KmvGwj
 p+hxQDmvryMeErUj9hnQBcFcajKZZyg==
X-Received: by 2002:a17:902:fe91:: with SMTP id
 x17mr24740518plm.50.1575270863986; 
 Sun, 01 Dec 2019 23:14:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxkuSAySs1YunqX0OrCoeBqaiYbE5F9jbVizyjNNNIgoZN4/f/Vu7qhvJbpZExSZOzYP0unGQ==
X-Received: by 2002:a17:902:fe91:: with SMTP id
 x17mr24740499plm.50.1575270863666; 
 Sun, 01 Dec 2019 23:14:23 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id i9sm21455882pfk.24.2019.12.01.23.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2019 23:14:22 -0800 (PST)
Date: Mon, 2 Dec 2019 00:14:06 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
Message-ID: <20191202071406.jpq5qobbtnwhktlc@cantor>
References: <20191202063422.3lyfoerkejig4num@cantor>
 <702d8a8a-88de-bffb-911e-9eb9a6a7845d@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <702d8a8a-88de-bffb-911e-9eb9a6a7845d@linux.intel.com>
X-MC-Unique: GoErT8dkPvW12mYViIFGyg-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: iommu@lists.linux-foundation.org
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gTW9uIERlYyAwMiAxOSwgTHUgQmFvbHUgd3JvdGU6Cj5IaSwKPgo+T24gMTIvMi8xOSAyOjM0
IFBNLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+PldlIGFyZSBzZWVpbmcgRE1BUiBQVEUgcmVh
ZCBhY2Nlc3Mgbm90IHNldCBlcnJvcnMgd2hlbiBib290aW5nIGEKPj5rZXJuZWwgd2l0aCBkZWZh
dWx0IHBhc3N0aHJvdWdoLCBib3RoIHdpdGggYSB0ZXN0IGtlcm5lbCBhbmQgd2l0aAo+PmEgNS40
LjAga2VybmVsLiBQcmV2aW91c2x5IHdlIHdvdWxkIHNlZSBhIG51bWJlciBvZiBpZGVudGl0eSBt
YXBwaW5ncwo+PmJlaW5nIHNldCByZWxhdGVkIHRvIHRoZSBybXJycywgYW5kIG5vdyB0aGV5IGFy
ZW4ndCBzZWVuIGFuZCB3ZSBnZXQKPj50aGUgZG1hciBwdGUgZXJyb3JzIGFzIGRldmljZXMgdG91
Y2ggdGhvc2UgcmVnaW9ucy4gRnJvbSB3aGF0IEkgY2FuIHRlbGwKPj5jdXJyZW50bHkgZGY0ZjNj
NjAzYWViICgiaW9tbXUvdnQtZDogUmVtb3ZlIHN0YXRpYyBpZGVudGl0eSBtYXAgY29kZSIpCj4+
cmVtb3ZlZCB0aGUgYml0IG9mIGNvZGUgaW4gaW5pdF9kbWFycyB0aGF0IHVzZWQgdG8gc2V0IHVw
IHRob3NlCj4+bWFwcGluZ3M6Cj4+Cj4+LcKgwqDCoMKgwqDCoCAvKgo+Pi3CoMKgwqDCoMKgwqDC
oCAqIEZvciBlYWNoIHJtcnIKPj4twqDCoMKgwqDCoMKgwqAgKsKgwqAgZm9yIGVhY2ggZGV2IGF0
dGFjaGVkIHRvIHJtcnIKPj4twqDCoMKgwqDCoMKgwqAgKsKgwqAgZG8KPj4twqDCoMKgwqDCoMKg
wqAgKsKgwqDCoMKgIGxvY2F0ZSBkcmhkIGZvciBkZXYsIGFsbG9jIGRvbWFpbiBmb3IgZGV2Cj4+
LcKgwqDCoMKgwqDCoMKgICrCoMKgwqDCoCBhbGxvY2F0ZSBmcmVlIGRvbWFpbgo+Pi3CoMKgwqDC
oMKgwqDCoCAqwqDCoMKgwqAgYWxsb2NhdGUgcGFnZSB0YWJsZSBlbnRyaWVzIGZvciBybXJyCj4+
LcKgwqDCoMKgwqDCoMKgICrCoMKgwqDCoCBpZiBjb250ZXh0IG5vdCBhbGxvY2F0ZWQgZm9yIGJ1
cwo+Pi3CoMKgwqDCoMKgwqDCoCAqwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWxsb2NhdGUgYW5kIGlu
aXQgY29udGV4dAo+Pi3CoMKgwqDCoMKgwqDCoCAqwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2V0IHBy
ZXNlbnQgaW4gcm9vdCB0YWJsZSBmb3IgdGhpcyBidXMKPj4twqDCoMKgwqDCoMKgwqAgKsKgwqDC
oMKgIGluaXQgY29udGV4dCB3aXRoIGRvbWFpbiwgdHJhbnNsYXRpb24gZXRjCj4+LcKgwqDCoMKg
wqDCoMKgICrCoMKgwqAgZW5kZm9yCj4+LcKgwqDCoMKgwqDCoMKgICogZW5kZm9yCj4+LcKgwqDC
oMKgwqDCoMKgICovCj4+LcKgwqDCoMKgwqDCoCBwcl9pbmZvKCJTZXR0aW5nIFJNUlI6XG4iKTsK
Pj4twqDCoMKgwqDCoMKgIGZvcl9lYWNoX3JtcnJfdW5pdHMocm1ycikgewo+Pi3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC8qIHNvbWUgQklPUyBsaXN0cyBub24tZXhpc3QgZGV2aWNlcyBp
biBETUFSIHRhYmxlLiAqLwo+Pi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvcl9lYWNo
X2FjdGl2ZV9kZXZfc2NvcGUocm1yci0+ZGV2aWNlcywgcm1yci0+ZGV2aWNlc19jbnQsCj4+LcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGksIGRldikgewo+Pi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBpb21tdV9wcmVwYXJlX3JtcnJfZGV2KHJtcnIs
IGRldik7Cj4+LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IChyZXQpCj4+LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBwcl9lcnIoIk1hcHBpbmcgcmVzZXJ2ZWQgcmVnaW9uIGZhaWxlZFxuIik7
Cj4+LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pi3CoMKgwqDCoMKgwqAgfQo+Pgo+
PnNpX2RvbWFpbl9pbml0IG5vdyBoYXMgY29kZSB0aGF0IHNldHMgaWRlbnRpdHkgbWFwcyBmb3Ig
ZGV2aWNlcyBpbiAKPj5ybXJycywgYnV0Cj4+b25seSBmb3IgY2VydGFpbiBkZXZpY2VzLgo+Cj5P
biB3aGljaCBkZXZpY2UsIGFyZSB5b3Ugc2VlaW5nIHRoaXMgZXJyb3I/IElzIGl0IGEgcm1yciBs
b2NrZWQgZGV2aWNlPwo+Cj5CZXN0IHJlZ2FyZHMsCj5iYW9sdQo+CgpBbG1vc3QgYWxsIG9mIHRo
ZSBtZXNzYWdlcyBhcmUgZm9yIHRoZSBpbG8sIGJ1dCB0aGVyZSBhbHNvIGlzIGEgbWVzc2FnZSBm
b3IKdGhlIHNtYXJ0IGFycmF5IHJhaWQgYnVzIGNvbnRyb2xsZXIuCgo+Pgo+PldpdGggaW9tbXU9
bm9wdCwgdGhlIHN5c3RlbSBib290cyB1cCB3aXRob3V0IGlzc3VlLgo+Pgo+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
