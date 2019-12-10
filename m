Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C818C43603
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 22:12:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BB322053B
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 22:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQ+2b/mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB322053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 14C3586138;
	Tue, 10 Dec 2019 22:12:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YlDGYYH1zY7a; Tue, 10 Dec 2019 22:12:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 476C685CC7;
	Tue, 10 Dec 2019 22:12:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E13DC1796;
	Tue, 10 Dec 2019 22:12:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7756FC0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 22:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5DAEB88438
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 22:12:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0l0MgfdU7c3t for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 22:12:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DEF4B8842A
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 22:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576015961;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7oCubdkjrnOmNk0SLXuHp4Ft/25W3SDgLx9zd5rzzM=;
 b=gQ+2b/mtIo6u6JHL8ljMOro/6PQAYQKRtZ3hOxlbDQmhCGn5Nnn4MuohweaqDbNXnjrU2g
 EUt/Fr59b0ZBMqD/ZohnwA/FUCTYV57rfWMnz+554Me0X0xG+lR4R+2FkCvCbHvbkH9OvV
 YiYgCa4RQHaRIaiR2y9TgtOY95GiXDA=
Received: from mail-yw1-f72.google.com (mail-yw1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-nio7s9tFNMuJWJcvbRczDQ-1; Tue, 10 Dec 2019 17:12:40 -0500
Received: by mail-yw1-f72.google.com with SMTP id 199so15520155ywe.20
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 14:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=EZJoCA7LEDYUlbhBsjgOOFt33ach6KGcPPmVysLWTSg=;
 b=QTjvqgjQucqpTdROTI7fgQFvtb6oskr5H7iOQ5GCpPcojArgF6JbgH5RVyB9oKfk1C
 j06b3qnInssiaXFhHNxvzBts5k6GbnTVVfuQtF+EZwD1hhIR2ETX399/JjAf8egDdhhE
 TSmWhXljFz5aDZrn0mbO8fEJeUyNs9ushHJXHI7ieXl9Kdqn52fbnsHgLow3360rMx5P
 t+ImB99u7gmo/s7JnTpY3m2GXoXjhow71Jvb83doVl/Rg2UwxQH8O2oxJcpaovQw8xue
 R/tkappys/AEi9wi9CVLk0gInJpQzQ3VjHOm4LWYDUMV37MmFfiRl4ymxRMruhGxTdA3
 qErA==
X-Gm-Message-State: APjAAAW6HWTo9ap+4ugtIjKZdUC/Jqj9ZRkCnDJPrHnNvV3tKHx0IBUk
 uAr8JZg8jSdSqLAvwEiqDtWLRlQMjN53S/1uB9PL3y70zbEKKpw2WZwshRsegO1YDQQDvtPo9Jm
 33BYK/2huI3J0L+nSZ+X5q2pJLXZ+XQ==
X-Received: by 2002:a81:113:: with SMTP id 19mr27333506ywb.514.1576015959537; 
 Tue, 10 Dec 2019 14:12:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqygBjxifpwmz2FIxzMitJmYrYvtm7laBkootQkscbLxnjzsEJ/Yk0LuynCsC9BelW7yLv+N4w==
X-Received: by 2002:a81:113:: with SMTP id 19mr27333489ywb.514.1576015959193; 
 Tue, 10 Dec 2019 14:12:39 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id u136sm16301ywf.101.2019.12.10.14.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 14:12:38 -0800 (PST)
Date: Tue, 10 Dec 2019 15:12:35 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
Message-ID: <20191210221235.7brlgxomcved67r2@cantor>
References: <20191206072453.5jjwrjedqbjimx45@cantor>
 <0f82007e-9887-d6b2-08e5-9c430c920b36@linux.intel.com>
 <20191207022914.7uccwkmgadz4hvbf@cantor>
 <20191207024118.uwwzthqifh2dca5q@cantor>
 <7979b838-e2c5-4064-490c-8e0884909715@linux.intel.com>
 <20191210005234.kanygdcjgsgo7z6j@cantor>
 <77d3ca8e-cb8c-4392-fa99-c55daa263b8e@linux.intel.com>
 <20191210034753.wlmbqdvqpcnzfxyl@cantor>
 <20191210051830.n37dimvrrgtiuydk@cantor>
 <c0519047-7c52-349b-7522-4343bbc80775@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <c0519047-7c52-349b-7522-4343bbc80775@linux.intel.com>
X-MC-Unique: nio7s9tFNMuJWJcvbRczDQ-1
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

T24gVHVlIERlYyAxMCAxOSwgTHUgQmFvbHUgd3JvdGU6Cj5IaSwKPgo+T24gMTIvMTAvMTkgMTox
OCBQTSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPj5PbiBNb24gRGVjIDA5IDE5LCBKZXJyeSBT
bml0c2VsYWFyIHdyb3RlOgo+PltzbmlwXQo+Pj4KPj4+QSBjYWxsIHRvIGlvbW11X21hcCBpcyBm
YWlsaW5nLgo+Pj4KPj4+W8KgwqAgMzYuNjg2ODgxXSBwY2kgMDAwMDowMTowMC4yOiBpb21tdV9n
cm91cF9hZGRfZGV2aWNlOiBjYWxsaW5nIAo+Pj5pb21tdV9ncm91cF9jcmVhdGVfZGlyZWN0X21h
cHBpbmdzCj4+PlvCoMKgIDM2LjY4OTg0M10gcGNpIDAwMDA6MDE6MDAuMjogCj4+PmlvbW11X2dy
b3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3M6IGl0ZXJhdGluZyB0aHJvdWdoIG1hcHBpbmdzCj4+
PlvCoMKgIDM2LjY5Mjc1N10gcGNpIDAwMDA6MDE6MDAuMjogCj4+PmlvbW11X2dyb3VwX2NyZWF0
ZV9kaXJlY3RfbWFwcGluZ3M6IGNhbGxpbmcgYXBwbHlfcmVzdl9yZWdpb24KPj4+W8KgwqAgMzYu
Njk1NTI2XSBwY2kgMDAwMDowMTowMC4yOiBlX2RpcmVjdF9tYXBwaW5nczogZW50cnkgdHlwZSBp
cyBkaXJlY3QKPj4+W8KgwqAgMzcuMTk4MDUzXSBpb21tdTogaW9tbXVfbWFwOiBvcHMtPm1hcCBm
YWlsZWQgaW92YSAweGJkZGRlMDAwIAo+Pj5wYSAweDAwMDAwMDAwYmRkZGUwMDAgcGdzaXplIDB4
MTAwMAo+Pj5bwqDCoCAzNy4yMDEzNTddIHBjaSAwMDAwOjAxOjAwLjI6IAo+Pj5pb21tdV9ncm91
cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzOiBpb21tdV9tYXAgZmFpbGVkCj4+PlvCoMKgIDM3LjIw
Mzk3M10gcGNpIDAwMDA6MDE6MDAuMjogCj4+PmlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFw
cGluZ3M6IGxlYXZpbmcgZnVuYwo+Pj5bwqDCoCAzNy4yMDYzODVdIHBjaSAwMDAwOjAxOjAwLjI6
IGlvbW11X2dyb3VwX2FkZF9kZXZpY2U6IGNhbGxpbmcgCj4+Pl9faW9tbXVfYXR0YWNoX2Rldmlj
ZQo+Pj5bwqDCoCAzNy4yMDg5NTBdIHBjaSAwMDAwOjAxOjAwLjI6IEFkZGluZyB0byBpb21tdSBn
cm91cCAyNQo+Pj5bwqDCoCAzNy4yMTA2NjBdIHBjaSAwMDAwOjAxOjAwLjI6IERNQVI6IGRvbWFp
bi0+dHlwZSBpcyBkbWEKPj4+Cj4+Cj4+SXQgYmFpbHMgYXQgdGhlIGRtYXJfZG9tYWluLT5mbGFn
cyAmIERPTUFJTl9GTEFHX0xPU0VfQ0hJTERSRU4gY2hlY2sKPj5hdCB0aGUgYmVnaW5uaW5nIG9m
IGludGVsX2lvbW11X21hcC7CoCBJIHdpbGwgdmVyaWZ5LCBidXQgaXQgbG9va3MgbGlrZQo+PnRo
YXQgaXMgZ2V0dGluZyBzZXQgd2hlbiBpbnRlbF9pb21tdV9hZGRfZGV2aWNlIGlzIGNhbGxlZCBm
b3IgMDE6MDAuMS4KPj5yZXF1ZXN0X2RlZmF1bHRfZG9tYWluX2Zvcl9kZXYgZm9yIDAxOjAwLjEg
d2lsbCByZXR1cm4gLUVCVVNZIGJlY2F1c2UKPj5pb21tdV9ncm91cF9kZXZpY2VfY291bnQoZ3Jv
dXApICE9IDEuCj4KPk9rYXksIEkgd2lsbCBzZW5kIHlvdSBhIGZpeCBwYXRjaCBsYXRlci4gVGhh
bmtzIQo+Cj5CZXN0IHJlZ2FyZHMsCj5iYW9sdQo+CgpPbmUgaXNzdWUgSSBzZWUgaXM6CgpbICAg
MzguODY5MTgyXSB1aGNpX2hjZCAwMDAwOjAxOjAwLjQ6IFVIQ0kgSG9zdCBDb250cm9sbGVyClsg
ICAzOS4zNzExNzNdIHVoY2lfaGNkIDAwMDA6MDE6MDAuNDogbmV3IFVTQiBidXMgcmVnaXN0ZXJl
ZCwgYXNzaWduZWQgYnVzIG51bWJlciAzClsgICAzOS4zNzM3MDhdIHVoY2lfaGNkIDAwMDA6MDE6
MDAuNDogZGV0ZWN0ZWQgOCBwb3J0cwpbICAgMzkuMzc1MzMzXSB1aGNpX2hjZCAwMDAwOjAxOjAw
LjQ6IHBvcnQgY291bnQgbWlzZGV0ZWN0ZWQ/IGZvcmNpbmcgdG8gMiBwb3J0cwpbICAgMzkuMzc3
ODIwXSB1aGNpX2hjZCAwMDAwOjAxOjAwLjQ6IGlycSAxNiwgaW8gYmFzZSAweDAwMDAzYzAwClsg
ICAzOS4zNzk5MjFdIHVoY2lfaGNkIDAwMDA6MDE6MDAuNDogRE1BUjogMzJiaXQgRE1BIHVzZXMg
bm9uLWlkZW50aXR5IG1hcHBpbmcKWyAgIDM5LjM4MjI2OV0gdWhjaV9oY2QgMDAwMDowMTowMC40
OiB1bmFibGUgdG8gYWxsb2NhdGUgY29uc2lzdGVudCBtZW1vcnkgZm9yIGZyYW1lIGxpc3QKWyAg
IDM5LjM4NDkyMF0gdWhjaV9oY2QgMDAwMDowMTowMC40OiBzdGFydHVwIGVycm9yIC0xNgpbICAg
MzkuMzg2NjE5XSB1aGNpX2hjZCAwMDAwOjAxOjAwLjQ6IFVTQiBidXMgMyBkZXJlZ2lzdGVyZWQK
WyAgIDM5LjM4ODY0MF0gdWhjaV9oY2QgMDAwMDowMTowMC40OiBpbml0IDAwMDA6MDE6MDAuNCBm
YWlsLCAtMTYKWyAgIDM5LjM5MDYxNl0gdWhjaV9oY2Q6IHByb2JlIG9mIDAwMDA6MDE6MDAuNCBm
YWlsZWQgd2l0aCBlcnJvciAtMTYKCkknbSBub3Qgc3VyZSBpZiB0aGlzIGlzIHJlbGF0ZWQgdG8g
dGhlIGZsYWcgYW5kIHdoYXQgaXMgYWxsb3dlZCBub3cKYnkgdGhlIGFwaS4gSSBuZWVkIHRvIGdv
IGxvb2sgYXQgdGhlIGNvZGUgdG8gc2VlIHdoYXQgaXQgaXMKZG9pbmcuIEknbGwgdHJ5IGRlYnVn
Z2luZyBpdCB0b25pZ2h0LgoKUmVnYXJkcywKSmVycnkKCj4+Cj4+PkFsc28gZmFpbHMgZm9yIDAx
OjAwLjQ6Cj4+Pgo+Pj5bwqDCoCAzNy4yMTI0NDhdIHBjaSAwMDAwOjAxOjAwLjQ6IGlvbW11X2dy
b3VwX2FkZF9kZXZpY2U6IGNhbGxpbmcgCj4+PmlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFw
cGluZ3MKPj4+W8KgwqAgMzcuMjE1MzgyXSBwY2kgMDAwMDowMTowMC40OiAKPj4+aW9tbXVfZ3Jv
dXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5nczogaXRlcmF0aW5nIHRocm91Z2ggbWFwcGluZ3MKPj4+
W8KgwqAgMzcuMjE4MTcwXSBwY2kgMDAwMDowMTowMC40OiAKPj4+aW9tbXVfZ3JvdXBfY3JlYXRl
X2RpcmVjdF9tYXBwaW5nczogY2FsbGluZyBhcHBseV9yZXN2X3JlZ2lvbgo+Pj5bwqDCoCAzNy4y
MjA5MzNdIHBjaSAwMDAwOjAxOjAwLjQ6IAo+Pj5pb21tdV9ncm91cF9jcmVhdGVfZGlyZWN0X21h
cHBpbmdzOiBlbnRyeSB0eXBlIGlzIGRpcmVjdC1yZWxheGFibGUKPj4+W8KgwqAgMzcuMjIzOTMy
XSBpb21tdTogaW9tbXVfbWFwOiBvcHMtPm1hcCBmYWlsZWQgaW92YSAweGJkZGRlMDAwIAo+Pj5w
YSAweDAwMDAwMDAwYmRkZGUwMDAgcGdzaXplIDB4MTAwMAo+Pj5bwqDCoCAzNy4yMjY4NTddIHBj
aSAwMDAwOjAxOjAwLjQ6IAo+Pj5pb21tdV9ncm91cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzOiBp
b21tdV9tYXAgZmFpbGVkCj4+PlvCoMKgIDM3LjIyOTMwMF0gcGNpIDAwMDA6MDE6MDAuNDogCj4+
PmlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3M6IGxlYXZpbmcgZnVuYwo+Pj5bwqDC
oCAzNy4yMzE2NDhdIHBjaSAwMDAwOjAxOjAwLjQ6IGlvbW11X2dyb3VwX2FkZF9kZXZpY2U6IGNh
bGxpbmcgCj4+Pl9faW9tbXVfYXR0YWNoX2RldmljZQo+Pj5bwqDCoCAzNy4yMzQxOTRdIHBjaSAw
MDAwOjAxOjAwLjQ6IEFkZGluZyB0byBpb21tdSBncm91cCAyNQo+Pj5bwqDCoCAzNy4yMzYxOTJd
IHBjaSAwMDAwOjAxOjAwLjQ6IERNQVI6IGRvbWFpbi0+dHlwZSBpcyBkbWEKPj4+W8KgwqAgMzcu
MjM3OTU4XSBwY2kgMDAwMDowMTowMC40OiBETUFSOiBkZXZpY2UgZGVmYXVsdCBkb21haW4gdHlw
ZSAKPj4+aXMgaWRlbnRpdHkuIHJlcXVlc3RpbmcgaWRlbnRpdHkgZG9tYWluCj4+PlvCoMKgIDM3
LjI0MTA2MV0gcGNpIDAwMDA6MDE6MDAuNDogZG9uJ3QgY2hhbmdlIG1hcHBpbmdzIG9mIGV4aXN0
aW5nIAo+Pj5kMzcuNDg5ODcwXSBwY2kgMDAwMDowMTowMC40OiBETUFSOiBEZXZpY2UgdXNlcyBh
IHByaXZhdGUgaWRlbnRpdHkgCj4+PmRvbWFpbi4KPj4+Cj4+PlRoZXJlIGlzIGFuIFJNUlIgZm9y
IDB4YmRkZGUwMDAtMHhkZGRkZWZmZjoKPj4+Cj4+Pls2M0FoIDE1OTTCoMKgIDJdwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFN1YnRhYmxlIFR5cGUgOiAwMDAxIFtSZXNlcnZlZCAKPj4+
TWVtb3J5IFJlZ2lvbl0KPj4+WzYzQ2ggMTU5NsKgwqAgMl3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBMZW5ndGggOiAwMDM2Cj4+Pgo+Pj5bNjNFaCAxNTk4wqDC
oCAyXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUmVzZXJ2ZWQgOiAw
MDAwCj4+Pls2NDBoIDE2MDDCoMKgIDJdwqDCoMKgwqDCoMKgwqDCoMKgwqAgUENJIFNlZ21lbnQg
TnVtYmVyIDogMDAwMAo+Pj5bNjQyaCAxNjAywqDCoCA4XcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIEJhc2UgQWRkcmVzcyA6IDAwMDAwMDAwQkREREUwMDAKPj4+WzY0QWggMTYxMMKg
wqAgOF3CoMKgwqDCoMKgwqDCoMKgwqAgRW5kIEFkZHJlc3MgKGxpbWl0KSA6IDAwMDAwMDAwQkRE
REVGRkYKPj4+Cj4+Pls2NTJoIDE2MTjCoMKgIDFdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBEZXZp
Y2UgU2NvcGUgVHlwZSA6IDAxIFtQQ0kgRW5kcG9pbnQgRGV2aWNlXQo+Pj5bNjUzaCAxNjE5wqDC
oCAxXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVudHJ5IExlbmd0aCA6IDBBCj4+
Pls2NTRoIDE2MjDCoMKgIDJdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBSZXNlcnZlZCA6IDAwMDAKPj4+WzY1NmggMTYyMsKgwqAgMV3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIEVudW1lcmF0aW9uIElEIDogMDAKPj4+WzY1N2ggMTYyM8KgwqAgMV3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBDSSBCdXMgTnVtYmVyIDogMDAKPj4+Cj4+Pls2NThoIDE2
MjTCoMKgIDJdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQQ0kgUGF0
aCA6IDFDLDA3Cj4+Pgo+Pj5bNjVBaCAxNjI2wqDCoCAyXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgUENJIFBhdGggOiAwMCwwMAo+Pj4KPj4+Cj4+Pls2NUNoIDE2MjjC
oMKgIDFdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBEZXZpY2UgU2NvcGUgVHlwZSA6IDAxIFtQQ0kg
RW5kcG9pbnQgRGV2aWNlXQo+Pj5bNjVEaCAxNjI5wqDCoCAxXcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEVudHJ5IExlbmd0aCA6IDBBCj4+Pls2NUVoIDE2MzDCoMKgIDJdwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSZXNlcnZlZCA6IDAwMDAKPj4+WzY2
MGggMTYzMsKgwqAgMV3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVudW1lcmF0aW9uIElE
IDogMDAKPj4+WzY2MWggMTYzM8KgwqAgMV3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBD
SSBCdXMgTnVtYmVyIDogMDAKPj4+Cj4+Pls2NjJoIDE2MzTCoMKgIDJdwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQQ0kgUGF0aCA6IDFDLDA3Cj4+Pgo+Pj5bNjY0aCAx
NjM2wqDCoCAyXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUENJIFBh
dGggOiAwMCwwMgo+Pj4KPj4+Cj4+Pls2NjZoIDE2MzjCoMKgIDFdwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBEZXZpY2UgU2NvcGUgVHlwZSA6IDAxIFtQQ0kgRW5kcG9pbnQgRGV2aWNlXQo+Pj5bNjY3
aCAxNjM5wqDCoCAxXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEVudHJ5IExlbmd0
aCA6IDBBCj4+Pls2NjhoIDE2NDDCoMKgIDJdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBSZXNlcnZlZCA6IDAwMDAKPj4+WzY2QWggMTY0MsKgwqAgMV3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIEVudW1lcmF0aW9uIElEIDogMDAKPj4+WzY2QmggMTY0M8KgwqAg
MV3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBDSSBCdXMgTnVtYmVyIDogMDAKPj4+Cj4+
Pls2NkNoIDE2NDTCoMKgIDJdwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBQQ0kgUGF0aCA6IDFDLDA3Cj4+Pgo+Pj5bNjZFaCAxNjQ2wqDCoCAyXcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUENJIFBhdGggOiAwMCwwNAo+Pj4KPj4KPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
