Return-Path: <SRS0=Zlue=TG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3829C004C9
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 02:57:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 918D320449
	for <iommu@archiver.kernel.org>; Mon,  6 May 2019 02:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="CiNMRpI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918D320449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 0C45944B4;
	Mon,  6 May 2019 02:57:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C576144AA
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 02:56:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
	[209.85.222.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 18557196
	for <iommu@lists.linux-foundation.org>;
	Mon,  6 May 2019 02:56:31 +0000 (UTC)
Received: by mail-qk1-f194.google.com with SMTP id a64so1197120qkg.5
	for <iommu@lists.linux-foundation.org>;
	Sun, 05 May 2019 19:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=3EkTKV/xQkVhztjonY/d2AGuSlnO5DKm1O3uub0aHJ4=;
	b=CiNMRpI1IAu6DnSiyjrSy5Aixri8/vQFDFlMzD8ensn0XCYTXSWhAgWy6g/hK7c6mZ
	wcEdg9GOe6dcwjVn+ntQt3OSopX7SR2cH23U90g5iLbWna5gJWKtGJAQjmHY1SC4V1RC
	n6WuBE62bihChM05MZ2kstQ978lwLmcaTSH4XSQi3DnhE0lAdsvBRR6+YJjmO4TpC0sz
	QTJPjVFEiBOPC5QnPf+kqUk8QWTEjmQsuTwU25paNSb4QawN8Wthhfl3kOLa1q8kc84R
	OFO2DhEt844O04oqS96eAv/tnGsjcMPWDKaiPADXa0zlfnjgX4BH/XPQtLS0N2Xh3F2i
	xsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=3EkTKV/xQkVhztjonY/d2AGuSlnO5DKm1O3uub0aHJ4=;
	b=LMVniGdk2IjcPtJJD+HnwbyZfW1J9CUMN7Ar4XYhlvVfMrauLJK5W1XmgFdpQpXPKR
	mNBLpxmNnbHAe2FBnzHhFuQEZSaSA61Yp2vkurfF+lDtZoLAdkvmoe6uqaQtkF9OoHeq
	KJ0BlCIlN5ftg97p9r6wgHPGbwYsuCHf33CzKu2Q5U94jSP7AKWbAyXAwxExlFk957WI
	8tG6BDvGE1qIKmyIUhbGXE3RNeEYG/UfL/0opx+WUj/GXZilLvFGQF+UcMpl3U1Yq8Zz
	+5JQJshAnbpGl1UJGX31o5Cq2/k8zdWV19PWE3tu2Gx7qjm4M2FA0Q/E/qnTJ+Dhrwev
	GMWw==
X-Gm-Message-State: APjAAAVL77a5dvv8NtiNuwBAzo0N6+w+hGe8fPNePLAluHkTj3rRF7Ky
	h7ftQPeByUn+55IKJcJEVJ9KSg==
X-Google-Smtp-Source: APXvYqw34FnNuqogx9nOJUx63jvgosRyfZRsiTutqvSvyJ5zT+75yh4mjnY6m0C+08OyQ6Oj97fiWw==
X-Received: by 2002:a37:a3d8:: with SMTP id m207mr4392842qke.334.1557111391110;
	Sun, 05 May 2019 19:56:31 -0700 (PDT)
Received: from ovpn-121-162.rdu2.redhat.com
	(pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
	by smtp.gmail.com with ESMTPSA id d8sm2477648qtd.2.2019.05.05.19.56.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 05 May 2019 19:56:30 -0700 (PDT)
Subject: Re: "iommu/amd: Set exclusion range correctly" causes smartpqi offline
From: Qian Cai <cai@lca.pw>
To: jroedel@suse.de, hch@lst.de
References: <1556290348.6132.6.camel@lca.pw>
Message-ID: <ca40e139-3b0e-01db-b3c8-df0c1a04f9e6@lca.pw>
Date: Sun, 5 May 2019 22:56:28 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
	Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556290348.6132.6.camel@lca.pw>
Content-Language: en-US
Cc: don.brace@microsemi.com, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, kevin.barnett@microsemi.com,
	jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, scott.teel@microsemi.com,
	david.carroll@microsemi.com
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

T24gNC8yNi8xOSAxMDo1MiBBTSwgUWlhbiBDYWkgd3JvdGU6Cj4gQXBwbHlpbmcgc29tZSBtZW1v
cnkgcHJlc3N1cmUgd291bGQgY2F1c2VzIHNtYXJ0cHFpIG9mZmxpbmUgZXZlbiBpbiB0b2RheSdz
Cj4gbGludXgtbmV4dC4gVGhpcyBjYW4gYWx3YXlzIGJlIHJlcHJvZHVjZWQgYnkgYSBMVFAgdGVz
dCBjYXNlcyBbMV0gb3Igc29tZXRpbWVzCj4ganVzdCBjb21waWxpbmcga2VybmVscy4KPiAKPiBS
ZXZlcnRpbmcgdGhlIGNvbW1pdCAiaW9tbXUvYW1kOiBTZXQgZXhjbHVzaW9uIHJhbmdlIGNvcnJl
Y3RseSLCoGZpeGVkIHRoZSBpc3N1ZS4KPiAKPiBbwqDCoDIxMy40MzcxMTJdIHNtYXJ0cHFpIDAw
MDA6MjM6MDAuMDogQU1ELVZpOiBFdmVudCBsb2dnZWQgW0lPX1BBR0VfRkFVTFQKPiBkb21haW49
MHgwMDAwIGFkZHJlc3M9MHgxMDAwIGZsYWdzPTB4MDAwMF0KPiBbwqDCoDIxMy40NDc2NTldIHNt
YXJ0cHFpIDAwMDA6MjM6MDAuMDogQU1ELVZpOiBFdmVudCBsb2dnZWQgW0lPX1BBR0VfRkFVTFQK
PiBkb21haW49MHgwMDAwIGFkZHJlc3M9MHgxODAwIGZsYWdzPTB4MDAwMF0KPiBbwqDCoDIzMy4z
NjIwMTNdIHNtYXJ0cHFpIDAwMDA6MjM6MDAuMDogY29udHJvbGxlciBpcyBvZmZsaW5lOiBzdGF0
dXMgY29kZSAweDE0ODAzCj4gW8KgwqAyMzMuMzY5MzU5XSBzbWFydHBxaSAwMDAwOjIzOjAwLjA6
IGNvbnRyb2xsZXIgb2ZmbGluZQo+IFvCoMKgMjMzLjM4ODkxNV0gcHJpbnRfcmVxX2Vycm9yOiBJ
L08gZXJyb3IsIGRldiBzZGIsIHNlY3RvciAzMzE3MzUyIGZsYWdzIDIwMDAwMDEKPiBbwqDCoDIz
My4zODg5MjFdIHNkIDA6MDowOjA6IFtzZGJdIHRhZyM5NSBVTktOT1dOKDB4MjAwMykgUmVzdWx0
OiBob3N0Ynl0ZT0weDAxCj4gZHJpdmVyYnl0ZT0weDAwCj4gW8KgwqAyMzMuMzg4OTMxXSBzZCAw
OjA6MDowOiBbc2RiXSB0YWcjOTUgQ0RCOiBvcGNvZGU9MHgyYSAyYSAwMCAwMCA1NSA4OSAwMCAw
MCAwMQo+IDA4IDAwCj4gW8KgwqAyMzMuMzg5MDAzXSBXcml0ZS1lcnJvciBvbiBzd2FwLWRldmlj
ZSAoMjU0OjE6NDQ3NDY0MCkKPiBbwqDCoDIzMy4zODkwMTVdIFdyaXRlLWVycm9yIG9uIHN3YXAt
ZGV2aWNlICgyNTQ6MToyMTkwNzc2KQo+IFvCoMKgMjMzLjM4OTAyM10gV3JpdGUtZXJyb3Igb24g
c3dhcC1kZXZpY2UgKDI1NDoxOjgzNTE5MzYpCj4gCj4gWzFdIC9vcHQvbHRwL3Rlc3RjYXNlcy9i
aW4vbXRlc3QwMSAtcDgwIC13CgpJdCB0dXJuZWQgb3V0IGFub3RoZXIgbGludXgtbmV4dCBjb21t
aXQgaXMgbmVlZGVkIHRvIHJlcHJvZHVjZSB0aGlzLCBpLmUuLAo3YTVkYmYzYWIyZjAgKCJpb21t
dS9hbWQ6IFJlbW92ZSB0aGUgbGVmdG92ZXIgb2YgYnlwYXNzIHN1cHBvcnQiKS4gU3BlY2lmaWNh
bGx5LAp0aGUgY2h1bmtzIGZvciBtYXBfc2coKSBhbmQgdW5tYXBfc2coKS4gVGhpcyBoYXMgYmVl
biByZXByb2R1Y2VkIG9uIDMgZGlmZmVyZW50CkhQRSBQcm9MaWFudCBETDM4NSBHZW4xMCBzeXN0
ZW1zIHNvIGZhci4KCkVpdGhlciByZXZlcnRlZCB0aGUgY2h1bmtzIChtYXBfc2coKSBhbmQgdW5t
YXBfc2coKSkgb24gdGhlIHRvcCBvZiB0aGUgbGF0ZXN0CmxpbnV4LW5leHQgZml4ZWQgdGhlIGlz
c3VlIG9yIGFwcGxpZWQgdGhlbSBvbiB0aGUgdG9wIG9mIHRoZSBtYWlubGluZSB2NS4xCnJlcHJv
ZHVjZWQgaXQgaW1tZWRpYXRlbHkuCgpMb3RzIG9mIHRpbWUgaXQgdHJpZ2dlcmVkIHRoaXMgQlVH
X09OKCFpb3ZhKSBpbiBpb3ZhX21hZ2F6aW5lX2ZyZWVfcGZucygpCmluc3RlYWQgb2YgdGhlIHNt
YXJ0cHFpIG9mZmxpbmUuCgogICAga2VybmVsIEJVRyBhdCBkcml2ZXJzL2lvbW11L2lvdmEuYzo4
MTMhCiAgICBXb3JrcXVldWU6IGtibG9ja2QgYmxrX21xX3J1bl93b3JrX2ZuCiAgICBSSVA6IDAw
MTA6aW92YV9tYWdhemluZV9mcmVlX3BmbnMrMHg3ZC8weGMwCiAgICBDYWxsIFRyYWNlOgogICAg
IGZyZWVfY3B1X2NhY2hlZF9pb3ZhcysweGJkLzB4MTUwCiAgICAgYWxsb2NfaW92YV9mYXN0KzB4
OGMvMHhiYQogICAgIGRtYV9vcHNfYWxsb2NfaW92YS5pc3JhLjYrMHg2NS8weGEwCiAgICAgbWFw
X3NnKzB4OGMvMHgyYTAKICAgICBzY3NpX2RtYV9tYXArMHhjNi8weDE2MAogICAgIHBxaV9haW9f
c3VibWl0X2lvKzB4MWY2LzB4NDQwIFtzbWFydHBxaV0KICAgICBwcWlfc2NzaV9xdWV1ZV9jb21t
YW5kKzB4OTBjLzB4ZGQwIFtzbWFydHBxaV0KICAgICBzY3NpX3F1ZXVlX3JxKzB4NzljLzB4MTIw
MAogICAgIGJsa19tcV9kaXNwYXRjaF9ycV9saXN0KzB4NGRjLzB4YjcwCiAgICAgYmxrX21xX3Nj
aGVkX2Rpc3BhdGNoX3JlcXVlc3RzKzB4MjQ5LzB4MzEwCiAgICAgX19ibGtfbXFfcnVuX2h3X3F1
ZXVlKzB4MTI4LzB4MjAwCiAgICAgYmxrX21xX3J1bl93b3JrX2ZuKzB4MjcvMHgzMAogICAgIHBy
b2Nlc3Nfb25lX3dvcmsrMHg1MjIvMHhhMTAKICAgICB3b3JrZXJfdGhyZWFkKzB4NjMvMHg1YjAK
ICAgICBrdGhyZWFkKzB4MWQyLzB4MWYwCiAgICAgcmV0X2Zyb21fZm9yaysweDIyLzB4NDAKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
