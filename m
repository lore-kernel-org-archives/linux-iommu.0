Return-Path: <SRS0=xWGd=D6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3405FC4363A
	for <iommu@archiver.kernel.org>; Fri, 23 Oct 2020 13:36:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821C1208FE
	for <iommu@archiver.kernel.org>; Fri, 23 Oct 2020 13:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="wZztWpB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821C1208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E4F1E2078B;
	Fri, 23 Oct 2020 13:36:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ye5OEy+qH2OK; Fri, 23 Oct 2020 13:36:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 04DAF20362;
	Fri, 23 Oct 2020 13:36:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9F8EC088B;
	Fri, 23 Oct 2020 13:36:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0212CC0052
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 13:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DD1852076B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 13:36:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wLuMK+e5n5ti for <iommu@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 13:36:43 +0000 (UTC)
X-Greylist: delayed 00:23:17 by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 93A3820362
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 13:36:43 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id dt13so2398618ejb.12
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 06:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0tDZG2QXwAtXIV9FNwWQRXbE5wHh/hZpuXcTzCtBfWc=;
 b=wZztWpB3u9MiM5IylLZH778ki5xv1bs59Ch+0OdAsFeDheDC8MF3Bl3ydb7/fcFpGs
 Sarv5ExaWbCoANMopMQWbl2kZqUmZyR5SdBXoz5dJXklUQMwNmb+cRCZMMxI2NRWKoI2
 OMOq29kjQzK0qcFgTkxIzgoloXxglg0cBIWfAQwidjAwTSSU1QyMOc96Qye8gC9JsLGp
 kxJQCt9xrXp9NsGIJi9tOCcWTIEcN2rQuHfdUAMgLb0y9m6FlRLF72x/IghJyzsOTKiI
 NhznftvkjZWQJ4e/PFEx2j1uO+ESD/HcXHXnwulNPVENFzZo7/PYdpdAHmUI5RaLk8jX
 b3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0tDZG2QXwAtXIV9FNwWQRXbE5wHh/hZpuXcTzCtBfWc=;
 b=MDaepT5DB+i+nmcNTW1PWQpf+y51oyvP4VmNjpoHxW6/Vi/fzrLmkk6a6922lulxkc
 T2AB7W3BaiaTFKbxRKk+oDLtB1UUvmxXHmWirl1PaDMcMcnmXgkBfl5zWXLXd+01PmA3
 lMRHPsNtsGnzxfpOjwD8qI7ewniAeb+zbzYkhei+6qeYfvPNMz2IK06m5CaHN+45VOFq
 oU49JxEaMZwumo4+WzjysTpxxAwlGtUbEG1CKLTXuL9JM6aT/HLSVE7L+WVKtLByNcq3
 f7plnTbA9DynZRv49VOlaBLaSgAboXknmqZz879yCfOYdDmiKjfKVWWQiJrgRC8wAyAa
 eh7g==
X-Gm-Message-State: AOAM5309WFxuFabgoiPLrdU+nEg65hF2qCRDN9spu0aKqJ3SgDmJ+3eV
 lfy9Jignc65hPBqLqv7x9IxMhygMR0w8kQ==
X-Google-Smtp-Source: ABdhPJzpbS93jJyLCJK3eYwLBNOD3ASipxM7IF9xvAkrpxT7SfhZJ/2nCMxhNMtkpQo/Gmb6V3Xajw==
X-Received: by 2002:a5d:488e:: with SMTP id g14mr2554460wrq.203.1603458310485; 
 Fri, 23 Oct 2020 06:05:10 -0700 (PDT)
Received: from tnowicki.c.googlers.com
 (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
 by smtp.gmail.com with ESMTPSA id l26sm2918296wmi.41.2020.10.23.06.05.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 06:05:09 -0700 (PDT)
Subject: Re: [PATCH v4 0/4] Add system mmu support for Armada-806
To: Robin Murphy <robin.murphy@arm.com>,
 Denis Odintsov <d.odintsov@traviangames.com>
References: <20200715070649.18733-1-tn@semihalf.com>
 <517BB937-1F18-4CCF-81BF-11777BB99779@traviangames.com>
 <9ff9682f-c165-2ad4-6edd-9e56d7ec7424@semihalf.com>
 <88409606-6672-8955-2681-ece34dda24b8@arm.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <762f88f5-689e-a312-e135-6b7491c19110@semihalf.com>
Date: Fri, 23 Oct 2020 13:05:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <88409606-6672-8955-2681-ece34dda24b8@arm.com>
Content-Language: en-US
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "hannah@marvell.com" <hannah@marvell.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nadavh@marvell.com" <nadavh@marvell.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "mw@semihalf.com" <mw@semihalf.com>,
 "will@kernel.org" <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

T24gMTAvMjMvMjAgMTI6MzMgUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIwLTEwLTIz
IDEzOjE5LCBUb21hc3ogTm93aWNraSB3cm90ZToKPj4gSGkgRGVuaXMsCj4+Cj4+IFNvcnJ5IGZv
ciBsYXRlIHJlc3BvbnNlLCB3ZSBoYWQgdG8gY2hlY2sgZmV3IHRoaW5ncy4gUGxlYXNlIHNlZSAK
Pj4gY29tbWVudHMgaW5saW5lLgo+Pgo+PiBPbiAxMC82LzIwIDM6MTYgUE0sIERlbmlzIE9kaW50
c292IHdyb3RlOgo+Pj4gSGksCj4+Pgo+Pj4+IEFtIDE1LjA3LjIwMjAgdW0gMDk6MDYgc2Nocmll
YiBUb21hc3ogTm93aWNraSA8dG5Ac2VtaWhhbGYuY29tPjoKPj4+Pgo+Pj4+IFRoZSBzZXJpZXMg
aXMgbWVhbnQgdG8gc3VwcG9ydCBTTU1VIGZvciBBUDgwNiBhbmQgYSB3b3JrYXJvdW5kCj4+Pj4g
Zm9yIGFjY2Vzc2luZyBBUk0gU01NVSA2NGJpdCByZWdpc3RlcnMgaXMgdGhlIGdpc3Qgb2YgaXQu
Cj4+Pj4KPj4+PiBGb3IgdGhlIHJlY29yZCwgQVAtODA2IGNhbid0IGFjY2VzcyBTTU1VIHJlZ2lz
dGVycyB3aXRoIDY0Yml0IHdpZHRoLgo+Pj4+IFRoaXMgcGF0Y2hlcyBzcGxpdCB0aGUgcmVhZHEv
d3JpdGVxIGludG8gdHdvIDMyYml0IGFjY2Vzc2VzIGluc3RlYWQKPj4+PiBhbmQgdXBkYXRlIERU
IGJpbmRpbmdzLgo+Pj4+Cj4+Pj4gVGhlIHNlcmllcyB3YXMgc3VjY2Vzc2Z1bGx5IHRlc3RlZCBv
biBhIHZhbmlsbGEgdjUuOC1yYzMga2VybmVsIGFuZAo+Pj4+IEludGVsIGUxMDAwZSBQQ0llIE5J
Qy4gVGhlIHNhbWUgZm9yIHBsYXRmb3JtIGRldmljZXMgbGlrZSBTQVRBIGFuZCBVU0IuCj4+Pj4K
Pj4+PiBGb3IgcmVmZXJlbmNlLCBwcmV2aW91cyB2ZXJzaW9ucyBhcmUgbGlzdGVkIGJlbG93Ogo+
Pj4+IFYxOiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOC8xMC8xNS8zNzMKPj4+PiBWMjogaHR0
cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvNy8xMS80MjYKPj4+PiBWMzogaHR0cHM6Ly9sa21sLm9y
Zy9sa21sLzIwMjAvNy8yLzExMTQKPj4+Pgo+Pj4KPj4+IDEpIEFmdGVyIGVuYWJsaW5nIFNNTVUg
b24gQXJtYWRhIDgwNDAsIGFuZCAKPj4+IEFSTV9TTU1VX0RJU0FCTEVfQllQQVNTX0JZX0RFRkFV
TD15IGJ5IGRlZmF1bHQgaW4ga2VybmVsIHNpbmNlIAo+Pj4gOTU0YTAzYmUwMzNjN2NlZjgwZGRj
MjMyZTdjYmRiMTdkZjczNTY2MywKPj4+IGludGVybmFsIGVNTUMgaXMgcHJldmVudGVkIGZyb20g
YmVpbmcgaW5pdGlhbGlzZWQgKGFzIHRoZXJlIGlzIG5vIAo+Pj4gaW9tbXVzIHByb3BlcnR5IGZv
ciBhcF9zZGhjaTApCj4+PiBEaXNhYmxpbmcgIkRpc2FibGUgYnlwYXNzIGJ5IGRlZmF1bHQiIG1h
a2UgaXQgd29yaywgYnV0IHRoZSBwYXRjaCAKPj4+IGhpZ2hseSBzdWdnZXN0IGRvaW5nIGl0IHBy
b3Blcmx5Lgo+Pj4gSSB3YXNuJ3QgYWJsZSB0byBmaW5kIGNvcnJlY3QgcGF0aCBmb3IgYXBfc2Ro
Y2kgZm9yIGlvbW11cyBpbiBhbnkgCj4+PiBwdWJsaWNseSBhdmFpbGFibGUgZG9jdW1lbnRhdGlv
biwKPj4+IHdvdWxkIGJlIGhpZ2hseSBhcHByZWNpYXRlZCBhZGRyZXNzZWQgcHJvcGVybHksIHRo
YW5rIHlvdSEKPj4+Cj4+PiAyKSBTZWNvbmQgaXNzdWUgSSBnb3QgKGJ0dyBJIGhhdmUgQ2xlYXJG
b2cgR1QgOGsgYXJtYWRhLTgwNDAgYmFzZWQgCj4+PiBib2FyZCkgaXMgbXBjaSBhdGgxMGsgY2Fy
ZC4KPj4+IEl0IGlzIGZvdW5kLCBpdCBpcyBlbnVtZXJhdGVkLCBpdCBpcyB2aXNpYmxlIGluIGxz
cGNpLCBidXQgaXQgZmFpbHMgCj4+PiB0byBiZSBpbml0aWFsaXNlZC4gSGVyZSBpcyB0aGUgbG9n
Ogo+Pgo+PiBGaXJtd2FyZSBoYXMgdG8gY29uZmlndXJlIGFuZCBhc3NpZ24gZGV2aWNlIFN0cmVh
bUlEcy4gTW9zdCBvZiB0aGUgCj4+IGRldmljZXMgYXJlIGNvbmZpZ3VyZWQgcHJvcGVybHkgYW5k
IHN1cHBvcnRlZCBpbiBwdWJsaWMgRlcuIEhvd2V2ZXIsIAo+PiBmb3IgYm90aCB0aGVzZSBjYXNl
cyAoYXBfc2RoY2kwIGFuZCBQQ0llKSBzb21lIGV4dHJhICh1LWJvb3QvVUVGSS9BVEYpIAo+PiBw
YXRjaGVzIGFyZSByZXF1aXJlZCB3aGljaCBhcmUgbm90IGF2YWlsYWJsZSB5ZXQuIFNvcnJ5IHdl
IGxldCB0aGF0IAo+PiBoYXBwZW4uCj4+Cj4+IFNpbmNlIHdlIGhhdmUgZGVwZW5kZW5jeSBvbiBj
dXN0b20gRlcgYW5kIHdlIGNhbm5vdCBlbmZvcmNlIHBlb3BsZSB0byAKPj4gcGF0Y2ggdGhlaXIg
Rlcgd2Ugd2lsbCBzZW5kIHRoZSBmb2xsb3cgdXAgZml4IHBhdGNoICh2NS45KykgYW5kIHJldmVy
dCAKPj4gcmVzcGVjdGl2ZSBEVFMgY2hhbmdlcy4KPiAKPiBOb3RlIHRoYXQgaXQgc2hvdWxkIGJl
IHN1ZmZpY2llbnQgdG8gc2ltcGx5IGtlZXAgdGhlIFNNTVUgbm9kZSBkaXNhYmxlZCwgCj4gcmF0
aGVyIHRoYW4gZnVsbHkgcmV2ZXJ0IGV2ZXJ5dGhpbmcuIEZvciBleGFtcGxlLCB0aGUgUENJZSBT
TU1VIGZvciBBcm0gCj4gSnVubyBib2FyZHMgaGFzIGJlZW4gaW4gdGhhdCBzdGF0ZSBmb3IgYSBs
b25nIHRpbWUgLSB0aGVyZSBhcmUgcmVhc29ucyAKPiB3aHkgaXQgaXNuJ3QgKHlldCkgMTAwJSB1
c2FibGUgZm9yIGV2ZXJ5b25lLCBidXQgaXQgY2FuIGVhc2lseSBiZSAKPiBlbmFibGVkIGxvY2Fs
bHkgZm9yIGRldmVsb3BtZW50IChhcyBJIGRvKS4KPiAKCkFjdHVhbGx5IHRoYXQgd2FzIG91ciBw
bGFuIDopIGJ1dCB0aGVuIHdlIGRlY2lkZWQgdG8ga2VlcCBEVFMgY2xlYW4gaWYgCnNvbWV0aGlu
ZyBpcyBub3QgdXNlZC4gWW91ciByZWFzb25pbmcsIGhvd2V2ZXIsIGRvZXMgbWFrZSBzZW5zZSBh
bmQgd2UgCndpbGwgZ28gZm9yIGl0LgoKVGhhbmtzLApUb21hc3oKCj4gCj4+IFRoZSBtb3N0IGlt
cG9ydGFudCBBcm1hZGEtODA2IFNNTVUgZHJpdmVyIGVuaGFuY2VtZW50cyB3ZXJlIG1lcmdlZCBz
byAKPj4gcGVvcGxlIHdobyBzdGlsbCB3aWxsaW5nIHRvIHVzZSBTTU1VIG5lZWQgdG8gcHJvdmlk
ZSBwcm9wZXIgRFRCIGFuZCAKPj4gdXNlIEFSTV9TTU1VX0RJU0FCTEVfQllQQVNTX0JZX0RFRkFV
TD1uIChvciB2aWEga2VybmVsIGNvbW1hbmQgbGluZSkgCj4+IHdpdGggZXh0cmEgY2F1dGlvdXMu
Cj4+Cj4+IFRoYW5rcywKPj4gVG9tYXN6Cj4+Cj4+Pgo+Pj4gW8KgwqDCoCAxLjc0Mzc1NF0gYXJt
YWRhOGstcGNpZSBmMjYwMDAwMC5wY2llOiBob3N0IGJyaWRnZSAKPj4+IC9jcDAvcGNpZUBmMjYw
MDAwMCByYW5nZXM6Cj4+PiBbwqDCoMKgIDEuNzUxMTE2XSBhcm1hZGE4ay1wY2llIGYyNjAwMDAw
LnBjaWU6wqDCoMKgwqDCoCBNRU0gCj4+PiAweDAwZjYwMDAwMDAuLjB4MDBmNmVmZmZmZiAtPiAw
eDAwZjYwMDAwMDAKPj4+IFvCoMKgwqAgMS45NjQ2OTBdIGFybWFkYThrLXBjaWUgZjI2MDAwMDAu
cGNpZTogTGluayB1cAo+Pj4gW8KgwqDCoCAxLjk2OTM3OV0gYXJtYWRhOGstcGNpZSBmMjYwMDAw
MC5wY2llOiBQQ0kgaG9zdCBicmlkZ2UgdG8gYnVzIAo+Pj4gMDAwMDowMAo+Pj4gW8KgwqDCoCAx
Ljk3NjAyNl0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbYnVzIDAwLWZmXQo+
Pj4gW8KgwqDCoCAxLjk4MTUzN10gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBb
bWVtIAo+Pj4gMHhmNjAwMDAwMC0weGY2ZWZmZmZmXQo+Pj4gW8KgwqDCoCAxLjk4ODQ2Ml0gcGNp
IDAwMDA6MDA6MDAuMDogWzExYWI6MDExMF0gdHlwZSAwMSBjbGFzcyAweDA2MDQwMAo+Pj4gW8Kg
wqDCoCAxLjk5NDUwNF0gcGNpIDAwMDA6MDA6MDAuMDogcmVnIDB4MTA6IFttZW0gMHgwMDAwMDAw
MC0weDAwMGZmZmZmXQo+Pj4gW8KgwqDCoCAyLjAwMDg0M10gcGNpIDAwMDA6MDA6MDAuMDogc3Vw
cG9ydHMgRDEgRDIKPj4+IFvCoMKgwqAgMi4wMDUxMzJdIHBjaSAwMDAwOjAwOjAwLjA6IFBNRSMg
c3VwcG9ydGVkIGZyb20gRDAgRDEgRDNob3QKPj4+IFvCoMKgwqAgMi4wMTE4NTNdIHBjaSAwMDAw
OjAxOjAwLjA6IFsxNjhjOjAwM2NdIHR5cGUgMDAgY2xhc3MgMHgwMjgwMDAKPj4+IFvCoMKgwqAg
Mi4wMTgwMDFdIHBjaSAwMDAwOjAxOjAwLjA6IHJlZyAweDEwOiBbbWVtIDB4MDAwMDAwMDAtMHgw
MDFmZmZmZiAKPj4+IDY0Yml0XQo+Pj4gW8KgwqDCoCAyLjAyNTAwMl0gcGNpIDAwMDA6MDE6MDAu
MDogcmVnIDB4MzA6IFttZW0gMHgwMDAwMDAwMC0weDAwMDBmZmZmIAo+Pj4gcHJlZl0KPj4+IFvC
oMKgwqAgMi4wMzIxMTFdIHBjaSAwMDAwOjAxOjAwLjA6IHN1cHBvcnRzIEQxIEQyCj4+PiBbwqDC
oMKgIDIuMDQ5NDA5XSBwY2kgMDAwMDowMDowMC4wOiBCQVIgMTQ6IGFzc2lnbmVkIFttZW0gCj4+
PiAweGY2MDAwMDAwLTB4ZjYxZmZmZmZdCj4+PiBbwqDCoMKgIDIuMDU2MzIyXSBwY2kgMDAwMDow
MDowMC4wOiBCQVIgMDogYXNzaWduZWQgW21lbSAKPj4+IDB4ZjYyMDAwMDAtMHhmNjJmZmZmZl0K
Pj4+IFvCoMKgwqAgMi4wNjMxNDJdIHBjaSAwMDAwOjAwOjAwLjA6IEJBUiAxNTogYXNzaWduZWQg
W21lbSAKPj4+IDB4ZjYzMDAwMDAtMHhmNjNmZmZmZiBwcmVmXQo+Pj4gW8KgwqDCoCAyLjA3MDQ4
NF0gcGNpIDAwMDA6MDE6MDAuMDogQkFSIDA6IGFzc2lnbmVkIFttZW0gCj4+PiAweGY2MDAwMDAw
LTB4ZjYxZmZmZmYgNjRiaXRdCj4+PiBbwqDCoMKgIDIuMDc3ODgwXSBwY2kgMDAwMDowMTowMC4w
OiBCQVIgNjogYXNzaWduZWQgW21lbSAKPj4+IDB4ZjYzMDAwMDAtMHhmNjMwZmZmZiBwcmVmXQo+
Pj4gW8KgwqDCoCAyLjA4NTEzNV0gcGNpIDAwMDA6MDA6MDAuMDogUENJIGJyaWRnZSB0byBbYnVz
IDAxLWZmXQo+Pj4gW8KgwqDCoCAyLjA5MDM4NF0gcGNpIDAwMDA6MDA6MDAuMDrCoMKgIGJyaWRn
ZSB3aW5kb3cgW21lbSAKPj4+IDB4ZjYwMDAwMDAtMHhmNjFmZmZmZl0KPj4+IFvCoMKgwqAgMi4w
OTcyMDJdIHBjaSAwMDAwOjAwOjAwLjA6wqDCoCBicmlkZ2Ugd2luZG93IFttZW0gCj4+PiAweGY2
MzAwMDAwLTB4ZjYzZmZmZmYgcHJlZl0KPj4+IFvCoMKgwqAgMi4xMDQ1MzldIHBjaWVwb3J0IDAw
MDA6MDA6MDAuMDogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDQKPj4+IFvCoMKgwqAgMi4xMTAyMzJd
IHBjaWVwb3J0IDAwMDA6MDA6MDAuMDogUE1FOiBTaWduYWxpbmcgd2l0aCBJUlEgMzgKPj4+IFvC
oMKgwqAgMi4xMTYxNDFdIHBjaWVwb3J0IDAwMDA6MDA6MDAuMDogQUVSOiBlbmFibGVkIHdpdGgg
SVJRIDM4Cj4+PiBbwqDCoMKgIDguMTMxMTM1XSBhdGgxMGtfcGNpIDAwMDA6MDE6MDAuMDogQWRk
aW5nIHRvIGlvbW11IGdyb3VwIDQKPj4+IFvCoMKgwqAgOC4xMzE4NzRdIGF0aDEwa19wY2kgMDAw
MDowMTowMC4wOiBlbmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMikKPj4+IFvCoMKgwqAgOC4x
MzIyMDNdIGF0aDEwa19wY2kgMDAwMDowMTowMC4wOiBwY2kgaXJxIG1zaSBvcGVyX2lycV9tb2Rl
IDIgCj4+PiBpcnFfbW9kZSAwIHJlc2V0X21vZGUgMAo+Pj4KPj4+IHVwIHRvIHRoYXQgcG9pbnQg
dGhlIGxvZyBpcyB0aGUgc2FtZSBhcyB3aXRob3V0IFNNTVUgZW5hYmxlZCwgZXhjZXB0IAo+Pj4g
IkFkZGluZyB0byBpb21tdSBncm91cCBOIiBsaW5lcywgYW5kIElSUSBiZWluZyAzNwo+Pj4KPj4+
IFvCoMKgwqAgOC4yMjEzMjhdIGF0aDEwa19wY2kgMDAwMDowMTowMC4wOiBmYWlsZWQgdG8gcG9r
ZSBjb3B5IGVuZ2luZTogLTE2Cj4+PiBbwqDCoMKgIDguMzEzMzYyXSBhdGgxMGtfcGNpIDAwMDA6
MDE6MDAuMDogZmFpbGVkIHRvIHBva2UgY29weSBlbmdpbmU6IC0xNgo+Pj4gW8KgwqDCoCA4LjQw
OTM3M10gYXRoMTBrX3BjaSAwMDAwOjAxOjAwLjA6IGZhaWxlZCB0byBwb2tlIGNvcHkgZW5naW5l
OiAtMTYKPj4+IFvCoMKgwqAgOC41NTM0MzNdIGF0aDEwa19wY2kgMDAwMDowMTowMC4wOiBmYWls
ZWQgdG8gcG9rZSBjb3B5IGVuZ2luZTogLTE2Cj4+PiBbwqDCoMKgIDguNjQxMzcwXSBhdGgxMGtf
cGNpIDAwMDA6MDE6MDAuMDogZmFpbGVkIHRvIHBva2UgY29weSBlbmdpbmU6IC0xNgo+Pj4gW8Kg
wqDCoCA4LjczNzk3OV0gYXRoMTBrX3BjaSAwMDAwOjAxOjAwLjA6IGZhaWxlZCB0byBwb2tlIGNv
cHkgZW5naW5lOiAtMTYKPj4+IFvCoMKgwqAgOC44MDczNTZdIGF0aDEwa19wY2kgMDAwMDowMTow
MC4wOiBGYWlsZWQgdG8gZ2V0IHBjaWUgc3RhdGUgCj4+PiBhZGRyOiAtMTYKPj4+IFvCoMKgwqAg
OC44MTQwMzJdIGF0aDEwa19wY2kgMDAwMDowMTowMC4wOiBmYWlsZWQgdG8gc2V0dXAgaW5pdCBj
b25maWc6IC0xNgo+Pj4gW8KgwqDCoCA4LjgyMDYwNV0gYXRoMTBrX3BjaSAwMDAwOjAxOjAwLjA6
IGNvdWxkIG5vdCBwb3dlciBvbiBoaWYgYnVzICgtMTYpCj4+PiBbwqDCoMKgIDguODI3MTExXSBh
dGgxMGtfcGNpIDAwMDA6MDE6MDAuMDogY291bGQgbm90IHByb2JlIGZ3ICgtMTYpCj4+Pgo+Pj4g
VGhhbmsgeW91IQo+Pj4KPj4+PiB2MyAtPiB2NAo+Pj4+IC0gY2FsbCBjZmdfcHJvYmUoKSBpbXBs
IGhvb2sgYSBiaXQgZWFybGllciB3aGljaCBzaW1wbGlmaWVzIGVycmF0YSAKPj4+PiBoYW5kbGlu
Zwo+Pj4+IC0gdXNlIGhpX2xvX3JlYWRxX3JlbGF4ZWQoKSBhbmQgaGlfbG9fd3JpdGVxX3JlbGF4
ZWQoKSBmb3IgcmVnaXN0ZXIgCj4+Pj4gYWNjZXNzb3JzCj4+Pj4gLSBrZWVwIFNNTVUgc3RhdHVz
IGRpc2FibGVkIGJ5IGRlZmF1bHQgYW5kIGVuYWJsZSB3aGVyZSBwb3NzaWJsZSAKPj4+PiAoRFRT
IGNoYW5nZXMpCj4+Pj4gLSBjb21taXQgbG9ncyBpbXByb3ZlbWVudHMgYW5kIG90aGVyIG1pbm9y
IGZpeGVzCj4+Pj4KPj4+PiBIYW5uYSBIYXdhICgxKToKPj4+PiDCoCBpb21tdS9hcm0tc21tdTog
V29ya2Fyb3VuZCBmb3IgTWFydmVsbCBBcm1hZGEtQVA4MDYgU29DIGVycmF0dW0KPj4+PiDCoMKg
wqAgIzU4Mjc0Mwo+Pj4+Cj4+Pj4gTWFyY2luIFdvanRhcyAoMSk6Cj4+Pj4gwqAgYXJtNjQ6IGR0
czogbWFydmVsbDogYWRkIFNNTVUgc3VwcG9ydAo+Pj4+Cj4+Pj4gVG9tYXN6IE5vd2lja2kgKDIp
Ogo+Pj4+IMKgIGlvbW11L2FybS1zbW11OiBDYWxsIGNvbmZpZ3VyYXRpb24gaW1wbCBob29rIGJl
Zm9yZSBjb25zdW1pbmcgCj4+Pj4gZmVhdHVyZXMKPj4+PiDCoCBkdC1iaW5kaW5nczogYXJtLXNt
bXU6IGFkZCBjb21wYXRpYmxlIHN0cmluZyBmb3IgTWFydmVsbCBBcm1hZGEtQVA4MDYKPj4+PiDC
oMKgwqAgU01NVS01MDAKPj4+Pgo+Pj4+IERvY3VtZW50YXRpb24vYXJtNjQvc2lsaWNvbi1lcnJh
dGEucnN0wqDCoMKgwqDCoMKgwqAgfMKgIDMgKysKPj4+PiAuLi4vZGV2aWNldHJlZS9iaW5kaW5n
cy9pb21tdS9hcm0sc21tdS55YW1swqDCoCB8wqAgNCArKwo+Pj4+IGFyY2gvYXJtNjQvYm9vdC9k
dHMvbWFydmVsbC9hcm1hZGEtNzA0MC5kdHNpwqAgfCAyOCArKysrKysrKysrKysKPj4+PiBhcmNo
L2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLTgwNDAuZHRzacKgIHwgNDAgKysrKysrKysr
KysrKysrKysKPj4+PiBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvYXJtYWRhLWFwODB4LmR0
c2kgfCAxOCArKysrKysrKwo+Pj4+IGRyaXZlcnMvaW9tbXUvYXJtLXNtbXUtaW1wbC5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0NSArKysrKysrKysrKysrKysrKysrCj4+Pj4g
ZHJpdmVycy9pb21tdS9hcm0tc21tdS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHwgMTEgKysrLS0KPj4+PiA3IGZpbGVzIGNoYW5nZWQsIDE0NSBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gLS0gCj4+Pj4gMi4xNy4xCj4+Pj4KPj4+PiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4+IGlvbW11
IG1haWxpbmcgbGlzdAo+Pj4+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4+Pj4g
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXUK
Pj4+Pgo+Pj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
