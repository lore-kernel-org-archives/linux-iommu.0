Return-Path: <SRS0=hFKH=2D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FFCC43603
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 00:30:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E99521655
	for <iommu@archiver.kernel.org>; Fri, 13 Dec 2019 00:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWaJppcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E99521655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D713B87264;
	Fri, 13 Dec 2019 00:30:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 93FuFU2w13KZ; Fri, 13 Dec 2019 00:30:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 12C7487255;
	Fri, 13 Dec 2019 00:30:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F296FC1796;
	Fri, 13 Dec 2019 00:30:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 810E7C0881
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 00:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6596687C0E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 00:30:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rlSvXnCo-k+W for <iommu@lists.linux-foundation.org>;
 Fri, 13 Dec 2019 00:30:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 33EAA874A7
 for <iommu@lists.linux-foundation.org>; Fri, 13 Dec 2019 00:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576197038;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jS6U1pgpCajQvRuzqz6/DRsKR0QCJ6hk9xIEhJ0Onh0=;
 b=QWaJppcWwuyZpkc5DHs1jtLjQNUdxvpg+STK7/rxXMOCMRIS3h+biBNoHmBtsfIW21fBKF
 exgbDlkSL0XJq3qL0s06BWQzEmXiL2hC/IV0EOCDmWfwNKXcJu3FNU4TECRPmVOj1gWDwJ
 ovDleoFnSPUy8Gp6SEs583gKihk0za0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-6Ett_mEoOii5rob3XiiTHg-1; Thu, 12 Dec 2019 19:30:36 -0500
X-MC-Unique: 6Ett_mEoOii5rob3XiiTHg-1
Received: by mail-yb1-f199.google.com with SMTP id g132so595806ybf.21
 for <iommu@lists.linux-foundation.org>; Thu, 12 Dec 2019 16:30:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=jS6U1pgpCajQvRuzqz6/DRsKR0QCJ6hk9xIEhJ0Onh0=;
 b=A1+eM/5t8QOTre9CB/Ysu6TRunJ64roiuER/YtG8vi9OdcVlFuXRa+aL5fB6S2Cvi1
 BMnBsD80aWADctOirFlc4aUvXea2FseY9ZB2p5fkvp9W5cYh96Ra06ZVB4POB/Qin4J7
 JrFpIMPAWu3UokLSzxvVimCgLhTLNxy/+tXSeljz8p+/UqAHJAotoD034Z07LMYJ2nxZ
 Junl+uN/cLTZMv32328C+cbAflBpgiVoxtQwE4Sbqi4+nkKtxP6H8aOOLehPmK+YNuFa
 k8KoZvEgcn4PLxd7IweoEn+dt0wOkXZSj6ClDrXdiCw6Rso5fzW4n20F0yW0h3nAnSbi
 etmg==
X-Gm-Message-State: APjAAAUH/2Z+OhidMxRhWkMFKNKZeW706eRkzYgt0Ze90z3Pl8+s6mcm
 8NLpj3FEdMsrDcK3DbAxi+N5F/9p58pM4Va3UIXaFi0W55MzmXZHsLcCE7bQuCW/n+1xwEzNNxw
 gF608dGaLWbfxk6oWqhRLjKABsuTG6Q==
X-Received: by 2002:a81:498c:: with SMTP id w134mr6683682ywa.391.1576197034962; 
 Thu, 12 Dec 2019 16:30:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqyV7bxeIbdjA2RjieoU8xu+V/i2Ro+FbC2boqYfNwO1+evCBVPio5ha6QZdRyIltr6nkNf1aQ==
X-Received: by 2002:a81:498c:: with SMTP id w134mr6683661ywa.391.1576197034599; 
 Thu, 12 Dec 2019 16:30:34 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id f22sm3571083ywb.104.2019.12.12.16.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2019 16:30:33 -0800 (PST)
Date: Thu, 12 Dec 2019 17:30:13 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix dmar pte read access not set error
Message-ID: <20191213003013.gc3zg3fpzpjntnzg@cantor>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
 jacob.jun.pan@intel.com, kevin.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20191211014015.7898-1-baolu.lu@linux.intel.com>
 <20191212014952.vlrmxrk2cebwxjnp@cantor>
 <6f3bcad9-b9b3-b349-fdad-ce53a79a665b@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6f3bcad9-b9b3-b349-fdad-ce53a79a665b@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, iommu@lists.linux-foundation.org,
 jacob.jun.pan@intel.com, David Woodhouse <dwmw2@infradead.org>
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

T24gVGh1IERlYyAxMiAxOSwgTHUgQmFvbHUgd3JvdGU6Cj5IaSwKPgo+T24gMTIvMTIvMTkgOTo0
OSBBTSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPj5PbiBXZWQgRGVjIDExIDE5LCBMdSBCYW9s
dSB3cm90ZToKPj4+SWYgdGhlIGRlZmF1bHQgRE1BIGRvbWFpbiBvZiBhIGdyb3VwIGRvZXNuJ3Qg
Zml0IGEgZGV2aWNlLCBpdAo+Pj53aWxsIHN0aWxsIHNpdCBpbiB0aGUgZ3JvdXAgYnV0IHVzZSBh
IHByaXZhdGUgaWRlbnRpdHkgZG9tYWluLgo+Pj5XaGVuIG1hcC91bm1hcC9pb3ZhX3RvX3BoeXMg
Y29tZSB0aHJvdWdoIGlvbW11IEFQSSwgdGhlIGRyaXZlcgo+Pj5zaG91bGQgc3RpbGwgc2VydmUg
dGhlbSwgb3RoZXJ3aXNlLCBvdGhlciBkZXZpY2VzIGluIHRoZSBzYW1lCj4+Pmdyb3VwIHdpbGwg
YmUgaW1wYWN0ZWQuIFNpbmNlIGlkZW50aXR5IGRvbWFpbiBoYXMgYmVlbiBtYXBwZWQKPj4+d2l0
aCB0aGUgd2hvbGUgYXZhaWxhYmxlIG1lbW9yeSBzcGFjZSBhbmQgUk1SUnMsIHdlIGRvbid0IG5l
ZWQKPj4+dG8gd29ycnkgYWJvdXQgdGhlIGltcGFjdCBvbiBpdC4KPj4+Cj4+Pkxpbms6IGh0dHBz
Oi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2lvbW11L21zZzQwNDE2Lmh0bWwKPj4+Q2M6IEplcnJ5
IFNuaXRzZWxhYXIgPGpzbml0c2VsQHJlZGhhdC5jb20+Cj4+PlJlcG9ydGVkLWJ5OiBKZXJyeSBT
bml0c2VsYWFyIDxqc25pdHNlbEByZWRoYXQuY29tPgo+Pj5GaXhlczogOTQyMDY3ZjFiNmI5NyAo
ImlvbW11L3Z0LWQ6IElkZW50aWZ5IGRlZmF1bHQgZG9tYWlucyAKPj4+cmVwbGFjZWQgd2l0aCBw
cml2YXRlIikKPj4+Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyB2NS4zKwo+Pj5TaWduZWQt
b2ZmLWJ5OiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPgo+Pgo+PlJldmlld2Vk
LWJ5OiBKZXJyeSBTbml0c2VsYWFyIDxqc25pdHNlbEByZWRoYXQuY29tPgo+Cj5DYW4geW91IHBs
ZWFzZSB0cnkgdGhpcyBmaXggYW5kIGNoZWNrIHdoZXRoZXIgaXQgY2FuIGZpeCB5b3VyIHByb2Js
ZW0/Cj5JZiBpdCBoZWxwcywgZG8geW91IG1pbmQgYWRkaW5nIGEgVGVzdGVkLWJ5Pwo+Cj5CZXN0
IHJlZ2FyZHMsCj5iYW9sdQo+CgpJJ20gdGVzdGluZyB3aXRoIHRoaXMgcGF0Y2gsIG15IHBhdGNo
IHRoYXQgbW92ZXMgdGhlIGRpcmVjdCBtYXBwaW5nIGNhbGwsCmFuZCBBbGV4J3MgcGF0Y2ggZm9y
IHRoZSBJU0EgYnJpZGdlLiBJdCBzb2x2ZWQgdGhlIDIgaW9tbXUgbWFwcGluZyBlcnJvcnMKSSB3
YXMgc2VlaW5nIHdpdGggZGVmYXVsdCBwYXNzdGhyb3VnaCwgSSBubyBsb25nZXIgc2VlIGFsbCB0
aGUgZG1hciBwdGUKcmVhZCBhY2Nlc3MgZXJyb3JzLCBhbmQgdGhlIHN5c3RlbSBib290cyBhbGxv
d2luZyBtZSB0byBsb2dpbi4gSSdtIHRyYWNraW5nCmRvd24gMiBpc3N1ZXMgYXQgdGhlIG1vbWVu
dC4gV2l0aCBwYXNzdGhyb3VnaCBJIHNlZSBhIHByb2JsZW0gd2l0aCAwMTowMC40CnRoYXQgSSBt
ZW50aW9uZWQgaW4gdGhlIGVhcmxpZXIgZW1haWw6CgpbICAgNzguOTc4NTczXSB1aGNpX2hjZDog
VVNCIFVuaXZlcnNhbCBIb3N0IENvbnRyb2xsZXIgSW50ZXJmYWNlIGRyaXZlcgpbICAgNzguOTgw
ODQyXSB1aGNpX2hjZCAwMDAwOjAxOjAwLjQ6IFVIQ0kgSG9zdCBDb250cm9sbGVyClsgICA3OC45
ODI3MzhdIHVoY2lfaGNkIDAwMDA6MDE6MDAuNDogbmV3IFVTQiBidXMgcmVnaXN0ZXJlZCwgYXNz
aWduZWQgYnVzIG51bWJlciAzClsgICA3OC45ODUyMjJdIHVoY2lfaGNkIDAwMDA6MDE6MDAuNDog
ZGV0ZWN0ZWQgOCBwb3J0cwpbICAgNzguOTg2OTA3XSB1aGNpX2hjZCAwMDAwOjAxOjAwLjQ6IHBv
cnQgY291bnQgbWlzZGV0ZWN0ZWQ/IGZvcmNpbmcgdG8gMiBwb3J0cwpbICAgNzguOTg5MzE2XSB1
aGNpX2hjZCAwMDAwOjAxOjAwLjQ6IGlycSAxNiwgaW8gYmFzZSAweDAwMDAzYzAwClsgICA3OC45
OTQ2MzRdIHVoY2lfaGNkIDAwMDA6MDE6MDAuNDogRE1BUjogMzJiaXQgRE1BIHVzZXMgbm9uLWlk
ZW50aXR5IG1hcHBpbmcKWyAgIDcgMDAwMDowMTowMC40OiB1bmFibGUgdG8gYWxsb2NhdGUgY29u
c2lzdGVudCBtZW1vcnkgZm9yIGZyYW1lIGxpc3QKWyAgIDc5LjQ5OTg5MV0gdWhjaV9oY2QgMDAw
MDowMTowMC40OiBzdGFydHVwIGVycm9yIC0xNgpbICAgNzkuNTAxNTg4XSB1aGNpX2hjZCAwMDAw
OjAxOjAwLjQ6IFVTQiBidXMgMyBkZXJlZ2lzdGVyZWQKWyAgIDc5LjUwMzQ5NF0gdWhjaV9oY2Qg
MDAwMDowMTowMC40OiBpbml0IDAwMDA6MDE6MDAuNCBmYWlsLCAtMTYKWyAgIDc5LjUwNTQ5N10g
dWhjaV9oY2Q6IHByb2JlIG9mIDAwMDA6MDE6MDAuNCBmYWlsZWQgd2l0aCBlcnJvciAtMTYKCklm
IEkgYm9vdCB0aGUgc3lzdGVtIHdpdGggaW9tbXU9bm9wdCBJIHNlZSBhbiBpb21tdSBtYXAgZmFp
bHVyZSBkdWUgdG8KdGhlIHByb3QgY2hlY2sgaW4gX19kb21haW5fbWFwcGluZzoKClsgICA0MC45
NDA1ODldIHBjaSAwMDAwOjAwOjFmLjA6IGlvbW11X2dyb3VwX2FkZF9kZXZpY2U6IGNhbGxpbmcg
aW9tbXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5ncwpbICAgNDAuOTQzNTU4XSBwY2kgMDAw
MDowMDoxZi4wOiBpb21tdV9ncm91cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzOiBpdGVyYXRpbmcg
dGhyb3VnaCBtYXBwaW5ncwpbICAgNDAuOTQ2NDAyXSBwY2kgMDAwMDowMDoxZi4wOiBpb21tdV9n
cm91cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzOiBjYWxsaW5nIGFwcGx5X3Jlc3ZfcmVnaW9uClsg
ICA0MC45NDkxODRdIHBjaSAwMDAwOjAwOjFmLjA6IGlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3Rf
bWFwcGluZ3M6IGVudHJ5IHR5cGUgaXMgZGlyZWN0ClsgICA0MC45NTE4MTldIERNQVI6IGludGVs
X2lvbW11X21hcDogZW50ZXIKWyAgIDQwLjk1MzEyOF0gRE1BUjogX19kb21haW5fbWFwcGluZzog
cHJvdCAmIChETUFfUFRFX1JFQUR8RE1BX1BURV9XUklURSkgPT0gMApbICAgNDAuOTU1NDg2XSBE
TUFSOiBkb21haW5fbWFwcGluZzogX19kb21haW5fbWFwcGluZyBmYWlsZWQKWyAgIDQwLjk1NzM0
OF0gRE1BUjogaW50ZWxfaW9tbXVfbWFwOiBkb21haW5fcGZuX21hcHBpbmcgcmV0dXJuZWQgLTIy
ClsgICA0MC45NTk0NjZdIERNQVI6IGludGVsX2lvbW11X21hcDogbGVhdmUKWyAgIDQwLjk1OTQ2
OF0gaW9tbXU6IGlvbW11X21hcDogb3BzLT5tYXAgZmFpbGVkIGlvdmEgMHgwIHBhIDB4MDAwMDAw
MDAwMDAwMDAwMCBwZ3NpemUgMHgxMDAwClsgICA0MC45NjM1MTFdIHBjaSAwMDAwOjAwOjFmLjA6
IGlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3M6IGlvbW11X21hcCBmYWlsZWQKWyAg
IDQwLjk2NjAyNl0gcGNpIDAwMDA6MDA6MWYuMDogaW9tbXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9t
YXBwaW5nczogbGVhdmluZyBmdW5jClsgICA0MC45Njg0ODddIHBjaSAwMDAwOjAwOjFmLjA6IGlv
bW11X2dyb3VwX2FkZF9kZXZpY2U6IGNhbGxpbmcgX19pb21tdV9hdHRhY2hfZGV2aWNlClsgICA0
MC45NzEwMTZdIHBjaSAwMDAwOjAwOjFmLjA6IEFkZGluZyB0byBpb21tdSBncm91cCAxOQpbICAg
NDAuOTcyNzMxXSBwY2kgMDAwMDowMDoxZi4wOiBETUFSOiBkb21haW4tPnR5cGUgaXMgZG1hCgov
c3lzL2tlcm5lbC9pb21tdV9ncm91cHMvMTkKW3Jvb3RAaHAtZGwzODhnOC0wNyAxOV0jIGNhdCBy
ZXNlcnZlZF9yZWdpb25zIAoweDAwMDAwMDAwMDAwMDAwMDAgMHgwMDAwMDAwMDAwZmZmZmZmIGRp
cmVjdAoweDAwMDAwMDAwYmRmNmUwMDAgMHgwMDAwMDAwMGJkZjg0ZmZmIGRpcmVjdAoweDAwMDAw
MDAwZmVlMDAwMDAgMHgwMDAwMDAwMGZlZWZmZmZmIG1zaQoKMDA6MWYuMCBJU0EgYnJpZGdlOiBJ
bnRlbCBDb3Jwb3JhdGlvbiBDNjAwL1g3OSBzZXJpZXMgY2hpcHNldCBMUEMgQ29udHJvbGxlcgoK
Pj4KPj4+LS0tCj4+PmRyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYyB8IDggLS0tLS0tLS0KPj4+
MSBmaWxlIGNoYW5nZWQsIDggZGVsZXRpb25zKC0pCj4+Pgo+Pj5kaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pb21tdS9pbnRlbC1pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+Pmlu
ZGV4IDBjOGQ4MWY1NmEzMC4uYjczYmViZWE5MTQ4IDEwMDY0NAo+Pj4tLS0gYS9kcml2ZXJzL2lv
bW11L2ludGVsLWlvbW11LmMKPj4+KysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+
PkBAIC01NDc4LDkgKzU0NzgsNiBAQCBzdGF0aWMgaW50IGludGVsX2lvbW11X21hcChzdHJ1Y3Qg
Cj4+PmlvbW11X2RvbWFpbiAqZG9tYWluLAo+Pj7CoMKgwqDCoGludCBwcm90ID0gMDsKPj4+wqDC
oMKgwqBpbnQgcmV0Owo+Pj4KPj4+LcKgwqDCoCBpZiAoZG1hcl9kb21haW4tPmZsYWdzICYgRE9N
QUlOX0ZMQUdfTE9TRV9DSElMRFJFTikKPj4+LcKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFM
Owo+Pj4tCj4+PsKgwqDCoMKgaWYgKGlvbW11X3Byb3QgJiBJT01NVV9SRUFEKQo+Pj7CoMKgwqDC
oMKgwqDCoCBwcm90IHw9IERNQV9QVEVfUkVBRDsKPj4+wqDCoMKgwqBpZiAoaW9tbXVfcHJvdCAm
IElPTU1VX1dSSVRFKQo+Pj5AQCAtNTUyMyw4ICs1NTIwLDYgQEAgc3RhdGljIHNpemVfdCBpbnRl
bF9pb21tdV91bm1hcChzdHJ1Y3QgCj4+PmlvbW11X2RvbWFpbiAqZG9tYWluLAo+Pj7CoMKgwqDC
oC8qIENvcGUgd2l0aCBob3JyaWQgQVBJIHdoaWNoIHJlcXVpcmVzIHVzIHRvIHVubWFwIG1vcmUg
dGhhbiB0aGUKPj4+wqDCoMKgwqDCoMKgIHNpemUgYXJndW1lbnQgaWYgaXQgaGFwcGVucyB0byBi
ZSBhIGxhcmdlLXBhZ2UgbWFwcGluZy4gKi8KPj4+wqDCoMKgwqBCVUdfT04oIXBmbl90b19kbWFf
cHRlKGRtYXJfZG9tYWluLCBpb3ZhID4+IFZURF9QQUdFX1NISUZULCAmbGV2ZWwpKTsKPj4+LcKg
wqDCoCBpZiAoZG1hcl9kb21haW4tPmZsYWdzICYgRE9NQUlOX0ZMQUdfTE9TRV9DSElMRFJFTikK
Pj4+LcKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4KPj4+wqDCoMKgwqBpZiAoc2l6ZSA8IFZU
RF9QQUdFX1NJWkUgPDwgbGV2ZWxfdG9fb2Zmc2V0X2JpdHMobGV2ZWwpKQo+Pj7CoMKgwqDCoMKg
wqDCoCBzaXplID0gVlREX1BBR0VfU0laRSA8PCBsZXZlbF90b19vZmZzZXRfYml0cyhsZXZlbCk7
Cj4+PkBAIC01NTU2LDkgKzU1NTEsNiBAQCBzdGF0aWMgcGh5c19hZGRyX3QgCj4+PmludGVsX2lv
bW11X2lvdmFfdG9fcGh5cyhzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sCj4+PsKgwqDCoMKg
aW50IGxldmVsID0gMDsKPj4+wqDCoMKgwqB1NjQgcGh5cyA9IDA7Cj4+Pgo+Pj4twqDCoMKgIGlm
IChkbWFyX2RvbWFpbi0+ZmxhZ3MgJiBET01BSU5fRkxBR19MT1NFX0NISUxEUkVOKQo+Pj4twqDC
oMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+Pi0KPj4+wqDCoMKgwqBwdGUgPSBwZm5fdG9fZG1hX3B0
ZShkbWFyX2RvbWFpbiwgaW92YSA+PiBWVERfUEFHRV9TSElGVCwgJmxldmVsKTsKPj4+wqDCoMKg
wqBpZiAocHRlKQo+Pj7CoMKgwqDCoMKgwqDCoCBwaHlzID0gZG1hX3B0ZV9hZGRyKHB0ZSk7Cj4+
Pi0tIAo+Pj4yLjE3LjEKPj4+Cj4+Cj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwo+aW9tbXUgbWFpbGluZyBsaXN0Cj5pb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwo+aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
