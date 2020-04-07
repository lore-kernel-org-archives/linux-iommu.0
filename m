Return-Path: <SRS0=p9ZB=5X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E38C2BB55
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 15:36:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC8020678
	for <iommu@archiver.kernel.org>; Tue,  7 Apr 2020 15:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YGX3Czlp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC8020678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1967F87D75;
	Tue,  7 Apr 2020 15:36:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hNCtOULaUeju; Tue,  7 Apr 2020 15:36:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 38E9187D11;
	Tue,  7 Apr 2020 15:36:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AFA1C1D7E;
	Tue,  7 Apr 2020 15:36:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D656C0177
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 15:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8B76B876B2
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 15:36:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oHGFxwuon--y for <iommu@lists.linux-foundation.org>;
 Tue,  7 Apr 2020 15:36:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 84F0B87684
 for <iommu@lists.linux-foundation.org>; Tue,  7 Apr 2020 15:36:08 +0000 (UTC)
Received: by mail-qt1-f195.google.com with SMTP id s10so1398067qtn.10
 for <iommu@lists.linux-foundation.org>; Tue, 07 Apr 2020 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=yfPVQGibhMomAOfYcoICtCwUK/9R3QEEWW5iQ0Auk1w=;
 b=YGX3CzlpC2QNzcEluGVU9Ex60Lgiy0GQl+62qk6Ti8XWPKDX+E7JWzafU36nL/Hns0
 yLbie3q9Ul9kwZL89s1Om5Lj/Cit35DuhGHp7kD0V4w/P7PotjyK53t+uCtf40/OPOO5
 /HyOJW1XG4gcevpxKLKKZR74gXHYWPWCb/oKXVEJRBSi/lMmtKpvPBruEPT4KadjG5Hz
 GwPTKuDnwHwqp5ceKZf9K6Dj4xFdlqVZBw+VUa/iGMYtlOHkQ8jjjHaaByPhbGDooMs4
 hY6H8PiGn1Cm0rMDT4bcqgYn31rcx5qalP94/DImbB0CkB8V+jfnWH/8t0NttUig0VqS
 tg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=yfPVQGibhMomAOfYcoICtCwUK/9R3QEEWW5iQ0Auk1w=;
 b=E6xi9wEnCN6VPAWdOIHSaxkavZXw5hXBb7JDaLL+b3EFFF9cL4azRr1oq69N5CUivD
 I1NP6o/Q2KY5i/1k6K9ds1Dv7h8Sy4MdD3c1KHZJGCjvQhSPYyXMuXdP+kVR6CknCArQ
 ozM4gJCPrKJ+RxPiKG8qQ00BYL4ujM+bfJmC1MB4NdIQpEoow3xyuxDjC2lt1G8kFmSa
 qGHqXYhqNi/iTblzlqD/HIu0FdWeZZW49JmRVZT2AO+JvXM2yK/13PDorqeku6gJYa1n
 nsm+wUj0SSpUwdRSlpgLlXW29VKfzvcqnpZSyAfSuC710eXWrY7ovkh5Cz8cHT3Pqk8q
 ZmWQ==
X-Gm-Message-State: AGi0Pub4QU+B9mgtS+MSQFEI8LY6qOc8kQXC20JW9IcBwV73Kq0T0xUs
 MGz5rvTf+JYWJywo79e7ZUV8VQ==
X-Google-Smtp-Source: APiQypJ7IFEvxrg9/g/xTUjNwz5reLxxPlh8/GSKSJzcop5WMssKUPKhZ2mZ2JHs+BwlVjkAxdBMqQ==
X-Received: by 2002:ac8:4a94:: with SMTP id l20mr2840111qtq.302.1586273766929; 
 Tue, 07 Apr 2020 08:36:06 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net.
 [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id h135sm9916013qke.61.2020.04.07.08.36.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Apr 2020 08:36:06 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
From: Qian Cai <cai@lca.pw>
In-Reply-To: <20200407021246.10941-1-cai@lca.pw>
Date: Tue, 7 Apr 2020 11:36:05 -0400
Message-Id: <7664E2E7-04D4-44C3-AB7E-A4334CDEC373@lca.pw>
References: <20200407021246.10941-1-cai@lca.pw>
To: joro@8bytes.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Cgo+IE9uIEFwciA2LCAyMDIwLCBhdCAxMDoxMiBQTSwgUWlhbiBDYWkgPGNhaUBsY2EucHc+IHdy
b3RlOgo+IAo+IGZldGNoX3B0ZSgpIGNvdWxkIHJhY2Ugd2l0aCBpbmNyZWFzZV9hZGRyZXNzX3Nw
YWNlKCkgYmVjYXVzZSBpdCBoZWxkIG5vCj4gbG9jayBmcm9tIGlvbW11X3VubWFwX3BhZ2UoKS4g
T24gdGhlIENQVSB0aGF0IHJ1bnMgZmV0Y2hfcHRlKCkgaXQgY291bGQKPiBzZWUgYSBzdGFsZSBk
b21haW4tPnB0X3Jvb3QgYW5kIGEgbmV3IGluY3JlYXNlZCBkb21haW4tPm1vZGUgZnJvbQo+IGlu
Y3JlYXNlX2FkZHJlc3Nfc3BhY2UoKS4gQXMgdGhlIHJlc3VsdCwgaXQgY291bGQgdHJpZ2dlciBp
bnZhbGlkCj4gYWNjZXNzZXMgbGF0ZXIgb24uIEZpeCBpdCBieSB1c2luZyBhIHBhaXIgb2Ygc21w
X1t3fHJdbWIgaW4gdGhvc2UKPiBwbGFjZXMuCgpBZnRlciBmdXJ0aGVyIHRlc3RpbmcsIHRoZSBj
aGFuZ2UgYWxvbmcgaXMgaW5zdWZmaWNpZW50LiBXaGF0IEkgYW0gY2hhc2luZyByaWdodApub3cg
aXMgdGhlIHN3YXAgZGV2aWNlIHdpbGwgZ28gb2ZmbGluZSBhZnRlciBoZWF2eSBtZW1vcnkgcHJl
c3N1cmUgYmVsb3cuIFRoZQpzeW1wdG9tIGlzIHNpbWlsYXIgdG8gd2hhdCB3ZSBoYXZlIGluIHRo
ZSBjb21taXQsCgo3NTQyNjViY2FiNzggKOKAnGlvbW11L2FtZDogRml4IHJhY2UgaW4gaW5jcmVh
c2VfYWRkcmVzc19zcGFjZSgp4oCdKQoKQXBwYXJlbnRseSwgaXQgaXMgbm8gcG9zc2libGUgdG8g
dGFrZSB0aGUgZG9tYWluLT5sb2NrIGluIGZldGNoX3B0ZSgpIGJlY2F1c2UgaXQKY291bGQgc2xl
ZXAuCgpUaG91Z2h0cz8KClsgNzI5Mi43MjczNzddWyAgVDgxNF0gc21hcnRwcWkgMDAwMDoyMzow
MC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCBkb21haW49MHgwMDI3IGFk
ZHJlc3M9MHhmZmZmZmZmZmZmZDgwMDAwIGZsYWdzPTB4MDAxMF0KWyA3MjkyLjc0MDU3MV1bICBU
ODE0XSBzbWFydHBxaSAwMDAwOjIzOjAwLjA6IEFNRC1WaTogRXZlbnQgbG9nZ2VkIFtJT19QQUdF
X0ZBVUxUIGRvbWFpbj0weDAwMjcgYWRkcmVzcz0weGZmZmZmZmZmZmZkODEwMDAgZmxhZ3M9MHgw
MDEwXQpbIDcyOTIuNzUzMjY4XVsgIFQ4MTRdIHNtYXJ0cHFpIDAwMDA6MjM6MDAuMDogQU1ELVZp
OiBFdmVudCBsb2dnZWQgW0lPX1BBR0VfRkFVTFQgZG9tYWluPTB4MDAyNyBhZGRyZXNzPTB4ZmZm
ZmZmZmZmZmQ4MTkwMCBmbGFncz0weDAwMTBdClsgNzI5Mi43NjYwNzhdWyAgVDgxNF0gc21hcnRw
cWkgMDAwMDoyMzowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCBkb21h
aW49MHgwMDI3IGFkZHJlc3M9MHhmZmZmZmZmZmZmZDgxZDAwIGZsYWdzPTB4MDAxMF0KWyA3Mjky
Ljc3ODQ0N11bICBUODE0XSBzbWFydHBxaSAwMDAwOjIzOjAwLjA6IEFNRC1WaTogRXZlbnQgbG9n
Z2VkIFtJT19QQUdFX0ZBVUxUIGRvbWFpbj0weDAwMjcgYWRkcmVzcz0weGZmZmZmZmZmZmZkODIw
MDAgZmxhZ3M9MHgwMDEwXQpbIDcyOTIuNzkwNzI0XVsgIFQ4MTRdIHNtYXJ0cHFpIDAwMDA6MjM6
MDAuMDogQU1ELVZpOiBFdmVudCBsb2dnZWQgW0lPX1BBR0VfRkFVTFQgZG9tYWluPTB4MDAyNyBh
ZGRyZXNzPTB4ZmZmZmZmZmZmZmQ4MjQwMCBmbGFncz0weDAwMTBdClsgNzI5Mi44MDMxOTVdWyAg
VDgxNF0gc21hcnRwcWkgMDAwMDoyMzowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFH
RV9GQVVMVCBkb21haW49MHgwMDI3IGFkZHJlc3M9MHhmZmZmZmZmZmZmZDgyODAwIGZsYWdzPTB4
MDAxMF0KWyA3MjkyLjgxNTY2NF1bICBUODE0XSBzbWFydHBxaSAwMDAwOjIzOjAwLjA6IEFNRC1W
aTogRXZlbnQgbG9nZ2VkIFtJT19QQUdFX0ZBVUxUIGRvbWFpbj0weDAwMjcgYWRkcmVzcz0weGZm
ZmZmZmZmZmZkODJjMDAgZmxhZ3M9MHgwMDEwXQpbIDcyOTIuODI4MDg5XVsgIFQ4MTRdIHNtYXJ0
cHFpIDAwMDA6MjM6MDAuMDogQU1ELVZpOiBFdmVudCBsb2dnZWQgW0lPX1BBR0VfRkFVTFQgZG9t
YWluPTB4MDAyNyBhZGRyZXNzPTB4ZmZmZmZmZmZmZmQ4MzAwMCBmbGFncz0weDAwMTBdClsgNzI5
Mi44NDA0NjhdWyAgVDgxNF0gc21hcnRwcWkgMDAwMDoyMzowMC4wOiBBTUQtVmk6IEV2ZW50IGxv
Z2dlZCBbSU9fUEFHRV9GQVVMVCBkb21haW49MHgwMDI3IGFkZHJlc3M9MHhmZmZmZmZmZmZmZDgz
NDAwIGZsYWdzPTB4MDAxMF0KWyA3MjkyLjg1Mjc5NV1bICBUODE0XSBBTUQtVmk6IEV2ZW50IGxv
Z2dlZCBbSU9fUEFHRV9GQVVMVCBkZXZpY2U9MjM6MDAuMCBkb21haW49MHgwMDI3IGFkZHJlc3M9
MHhmZmZmZmZmZmZmZDgzODAwIGZsYWdzPTB4MDAxMF0KWyA3MjkyLjg2NDU2Nl1bICBUODE0XSBB
TUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCBkZXZpY2U9MjM6MDAuMCBkb21haW49
MHgwMDI3IGFkZHJlc3M9MHhmZmZmZmZmZmZmZDgzYzAwIGZsYWdzPTB4MDAxMF0KWyA3MzI2LjU4
MzkwOF1bICAgIEM4XSBzbWFydHBxaSAwMDAwOjIzOjAwLjA6IGNvbnRyb2xsZXIgaXMgb2ZmbGlu
ZTogc3RhdHVzIGNvZGUgMHgxNDgwMwpbIDczMjYuNTkyMzg2XVsgICAgQzhdIHNtYXJ0cHFpIDAw
MDA6MjM6MDAuMDogY29udHJvbGxlciBvZmZsaW5lClsgNzMyNi42NjM3MjhdWyAgIEM2Nl0gc2Qg
MDoxOjA6MDogW3NkYV0gdGFnIzQ2NyBVTktOT1dOKDB4MjAwMykgUmVzdWx0OiBob3N0Ynl0ZT0w
eDAxIGRyaXZlcmJ5dGU9MHgwMCBjbWRfYWdlPTZzClsgNzMyNi42NjQzMjFdWyBUMjczOF0gc21h
cnRwcWkgMDAwMDoyMzowMC4wOiByZXNldHRpbmcgc2NzaSAwOjE6MDowClsgNzMyNi42NzM4NDld
WyAgIEM2Nl0gc2QgMDoxOjA6MDogW3NkYV0gdGFnIzQ2NyBDREI6IG9wY29kZT0weDI4IDI4IDAw
IDAyIGVlIDJlIDYwIDAwIDAwIDA4IDAwClsgNzMyNi42ODAxMThdWyBUMjczOF0gc21hcnRwcWkg
MDAwMDoyMzowMC4wOiByZXNldCBvZiBzY3NpIDA6MTowOjA6IEZBSUxFRApbIDczMjYuNjg4NjEy
XVsgICBDNjZdIGJsa191cGRhdGVfcmVxdWVzdDogSS9PIGVycm9yLCBkZXYgc2RhLCBzZWN0b3Ig
NDkxNjM4NzIgb3AgMHgwOihSRUFEKSBmbGFncyAweDAgcGh5c19zZWcgMSBwcmlvIGNsYXNzIDAK
WyA3MzI2LjY5NTQ1Nl1bIFQyNzM4XSBzZCAwOjE6MDowOiBEZXZpY2Ugb2ZmbGluZWQgLSBub3Qg
cmVhZHkgYWZ0ZXIgZXJyb3IgcmVjb3ZlcnkKWyA3MzI2LjcwNjYzMl1bICAgQzY2XSBSZWFkLWVy
cm9yIG9uIHN3YXAtZGV2aWNlICgyNTQ6MTo0NTgzMzgyNCkKWyA3MzI2LjcxNDAzMF1bIFQyNzM4
XSBzZCAwOjE6MDowOiBEZXZpY2Ugb2ZmbGluZWQgLSBub3QgcmVhZHkgYWZ0ZXIgZXJyb3IgcmVj
b3ZlcnkKWyA3MzI2LjcyMzM4Ml1bVDQ1NTIzXSBzZCAwOjE6MDowOiByZWplY3RpbmcgSS9PIHRv
IG9mZmxpbmUgZGV2aWNlClsgNzMyNi43MjczNTJdWyBUMjczOF0gc2QgMDoxOjA6MDogRGV2aWNl
IG9mZmxpbmVkIC0gbm90IHJlYWR5IGFmdGVyIGVycm9yIHJlY292ZXJ5ClsgNzMyNi43MjczNzld
WyBUMjczOF0gc2QgMDoxOjA6MDogRGV2aWNlIG9mZmxpbmVkIC0gbm90IHJlYWR5IGFmdGVyIGVy
cm9yIHJlY292ZXJ5ClsgNzMyNi43Mjc0NDJdWyBUMjczOF0gc2QgMDoxOjA6MDogRGV2aWNlIG9m
ZmxpbmVkIC0gbm90IHJlYWR5IGFmdGVyIGVycm9yIHJlY292ZXJ5Cgo+IAo+IGtlcm5lbCBCVUcg
YXQgZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYzoxNzA0IQo+IEJVR19PTih1bm1hcHBlZCAmJiAh
aXNfcG93ZXJfb2ZfMih1bm1hcHBlZCkpOwo+IEhhcmR3YXJlIG5hbWU6IEhQRSBQcm9MaWFudCBE
TDM4NSBHZW4xMC9Qcm9MaWFudCBETDM4NSBHZW4xMCwgQklPUyBBNDAgMDcvMTAvMjAxOQo+IFJJ
UDogMDAxMDphbWRfaW9tbXVfdW5tYXArMHgxYjIvMHgxZDAKPiBDYWxsIFRyYWNlOgo+ICA8SVJR
Pgo+ICBfX2lvbW11X3VubWFwKzB4MTA2LzB4MzIwCj4gIGlvbW11X3VubWFwX2Zhc3QrMHhlLzB4
MTAKPiAgX19pb21tdV9kbWFfdW5tYXArMHhkYy8weDFhMAo+ICBpb21tdV9kbWFfdW5tYXBfc2cr
MHhhZS8weGQwCj4gIHNjc2lfZG1hX3VubWFwKzB4ZTcvMHgxNTAKPiAgcHFpX3JhaWRfaW9fY29t
cGxldGUrMHgzNy8weDYwIFtzbWFydHBxaV0KPiAgcHFpX2lycV9oYW5kbGVyKzB4MWZjLzB4MTNm
MCBbc21hcnRwcWldCj4gIF9faGFuZGxlX2lycV9ldmVudF9wZXJjcHUrMHg3OC8weDRmMAo+ICBo
YW5kbGVfaXJxX2V2ZW50X3BlcmNwdSsweDcwLzB4MTAwCj4gIGhhbmRsZV9pcnFfZXZlbnQrMHg1
YS8weDhiCj4gIGhhbmRsZV9lZGdlX2lycSsweDEwYy8weDM3MAo+ICBkb19JUlErMHg5ZS8weDFl
MAo+ICBjb21tb25faW50ZXJydXB0KzB4Zi8weGYKPiAgPC9JUlE+Cj4gCj4gU2lnbmVkLW9mZi1i
eTogUWlhbiBDYWkgPGNhaUBsY2EucHc+Cj4gLS0tCj4gZHJpdmVycy9pb21tdS9hbWRfaW9tbXUu
YyB8IDkgKysrKysrKysrCj4gMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQo+IAo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9hbWRf
aW9tbXUuYwo+IGluZGV4IDIwY2NlMzY2ZTk1MS4uMjIzMjhhMjMzMzVmIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmMKPiArKysgYi9kcml2ZXJzL2lvbW11L2FtZF9pb21t
dS5jCj4gQEAgLTE0MzQsNiArMTQzNCwxMSBAQCBzdGF0aWMgYm9vbCBpbmNyZWFzZV9hZGRyZXNz
X3NwYWNlKHN0cnVjdCBwcm90ZWN0aW9uX2RvbWFpbiAqZG9tYWluLAo+IAkqcHRlICAgICAgICAg
ICAgID0gUE1fTEVWRUxfUERFKGRvbWFpbi0+bW9kZSwKPiAJCQkJCWlvbW11X3ZpcnRfdG9fcGh5
cyhkb21haW4tPnB0X3Jvb3QpKTsKPiAJZG9tYWluLT5wdF9yb290ICA9IHB0ZTsKPiArCS8qCj4g
KwkgKiBNYWtlIHN1cmUgZmV0Y2hfcHRlKCkgd2lsbCBzZWUgdGhlIG5ldyBkb21haW4tPnB0X3Jv
b3QgYmVmb3JlIGl0Cj4gKwkgKiBzbmFwc2hvdHMgZG9tYWluLT5tb2RlLgo+ICsJICovCj4gKwlz
bXBfd21iKCk7Cj4gCWRvbWFpbi0+bW9kZSAgICArPSAxOwo+IAo+IAlyZXQgPSB0cnVlOwo+IEBA
IC0xNDYwLDYgKzE0NjUsOCBAQCBzdGF0aWMgdTY0ICphbGxvY19wdGUoc3RydWN0IHByb3RlY3Rp
b25fZG9tYWluICpkb21haW4sCj4gCQkqdXBkYXRlZCA9IGluY3JlYXNlX2FkZHJlc3Nfc3BhY2Uo
ZG9tYWluLCBhZGRyZXNzLCBnZnApIHx8ICp1cGRhdGVkOwo+IAo+IAlsZXZlbCAgID0gZG9tYWlu
LT5tb2RlIC0gMTsKPiArCS8qIFRvIHBhaXIgd2l0aCBzbXBfd21iKCkgaW4gaW5jcmVhc2VfYWRk
cmVzc19zcGFjZSgpLiAqLwo+ICsJc21wX3JtYigpOwo+IAlwdGUgICAgID0gJmRvbWFpbi0+cHRf
cm9vdFtQTV9MRVZFTF9JTkRFWChsZXZlbCwgYWRkcmVzcyldOwo+IAlhZGRyZXNzID0gUEFHRV9T
SVpFX0FMSUdOKGFkZHJlc3MsIHBhZ2Vfc2l6ZSk7Cj4gCWVuZF9sdmwgPSBQQUdFX1NJWkVfTEVW
RUwocGFnZV9zaXplKTsKPiBAQCAtMTU0NSw2ICsxNTUyLDggQEAgc3RhdGljIHU2NCAqZmV0Y2hf
cHRlKHN0cnVjdCBwcm90ZWN0aW9uX2RvbWFpbiAqZG9tYWluLAo+IAkJcmV0dXJuIE5VTEw7Cj4g
Cj4gCWxldmVsCSAgID0gIGRvbWFpbi0+bW9kZSAtIDE7Cj4gKwkvKiBUbyBwYWlyIHdpdGggc21w
X3dtYigpIGluIGluY3JlYXNlX2FkZHJlc3Nfc3BhY2UoKS4gKi8KPiArCXNtcF9ybWIoKTsKPiAJ
cHRlCSAgID0gJmRvbWFpbi0+cHRfcm9vdFtQTV9MRVZFTF9JTkRFWChsZXZlbCwgYWRkcmVzcyld
Owo+IAkqcGFnZV9zaXplID0gIFBURV9MRVZFTF9QQUdFX1NJWkUobGV2ZWwpOwo+IAo+IC0tIAo+
IDIuMjEuMCAoQXBwbGUgR2l0LTEyMi4yKQo+IAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
