Return-Path: <SRS0=codQ=S4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E930C43218
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 15:57:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04262077B
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 15:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="S0wsh0Vn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04262077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C471F293A;
	Fri, 26 Apr 2019 15:57:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 135572714
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 15:55:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
	[209.85.222.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 76B0B2D4
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 15:55:15 +0000 (UTC)
Received: by mail-qk1-f196.google.com with SMTP id w73so2126615qkb.13
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=M1KaF+DSCnWN8ZthCrAegiw+U4FUrxW5sRpTIk7RM0M=;
	b=S0wsh0VnxEBNrOgR+67oYarfPiEP7S7R+Sdd8KeHAAaJIk49JL0RiKgjzFiz0J+Z7P
	7FyyVZ9J20UFX5rkf3W3JyYfD9Oqty0UN6WBfZf6i+hhUYGUte42+trt6sUJdYAZcA9O
	DN0i3LDJsYWLfhWZwrVLHEbcWi7a6Iv6D6YzvKE7Jzg4PnVPEpMZ1+P9Qbi0jEEJabEO
	CvL2kW60B2OVjW02WR4zlVFQW7LQEuCDRq88jKt24rEkLL6LQbHLIcVBFTSFoGlio/Zm
	GX0l53jp62D1xByx7mB7GZ7ramo+jiLQtdLZ7mgjMU+Hj8OPNDPphbWu0ixWlR4QfFxb
	l/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=M1KaF+DSCnWN8ZthCrAegiw+U4FUrxW5sRpTIk7RM0M=;
	b=fOo3+2T7qQSSNKbd9tEg3kP1I7/8WOj8yTdIIU5Q1hOEGvmaQ2/TisRZAg0HpAvaQf
	A+rY05dNd5EThAQG20xHtpmkv3Qv+BD6Fx5514RgCOhP321jCkuq6k6jziB/DeP1DjcS
	mhTKu3bgmgr+pZWi4pKvHJR6+iDc2Ze/u6WHuyfelAP7MuepoYFvh6JLUnCiYJ+eoJ4m
	9zsrs6ywvjzu3anbw4O/5oAXBs18T1uxlk8j1HqYmOKgvtN8gOkYNKSVZROuyCRB5z8d
	OWW4WCN5H9FeazE8V3QVQZOanLp07EeNzVEPIOK6UumXmmVDOzPMGolzPlPWzpyeGyD5
	5lvA==
X-Gm-Message-State: APjAAAV7i0JOoKAGpbAZUh/IpxRmdzOcPDTBTxPsECHh0eRhXictbqZP
	p7LvZmmzI3rW9+MUDMZw+c0jQQ==
X-Google-Smtp-Source: APXvYqx0B6IxCHYVAJC79ZkHE7/H1twzINBweRC6BFRaN13IwzSa46wZ5jQHJLliIdFBcUh2sVD2uQ==
X-Received: by 2002:a37:484c:: with SMTP id v73mr35618564qka.37.1556294114426; 
	Fri, 26 Apr 2019 08:55:14 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
	[66.187.233.206])
	by smtp.gmail.com with ESMTPSA id a1sm5063373qkn.58.2019.04.26.08.55.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 08:55:13 -0700 (PDT)
Message-ID: <1556294112.6132.7.camel@lca.pw>
Subject: Re: "iommu/amd: Set exclusion range correctly" causes smartpqi offline
From: Qian Cai <cai@lca.pw>
To: Joerg Roedel <jroedel@suse.de>
Date: Fri, 26 Apr 2019 11:55:12 -0400
In-Reply-To: <20190426152632.GC3173@suse.de>
References: <1556290348.6132.6.camel@lca.pw> <20190426152632.GC3173@suse.de>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Cc: iommu@lists.linux-foundation.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190426155512.ZhjpoBMgP7qPI10XMpDkaTzztYodETY9R3vTTtODQXE@z>

T24gRnJpLCAyMDE5LTA0LTI2IGF0IDE3OjI2ICswMjAwLCBKb2VyZyBSb2VkZWwgd3JvdGU6Cj4g
T24gRnJpLCBBcHIgMjYsIDIwMTkgYXQgMTA6NTI6MjhBTSAtMDQwMCwgUWlhbiBDYWkgd3JvdGU6
Cj4gPiBBcHBseWluZyBzb21lIG1lbW9yeSBwcmVzc3VyZSB3b3VsZCBjYXVzZXMgc21hcnRwcWkg
b2ZmbGluZSBldmVuIGluIHRvZGF5J3MKPiA+IGxpbnV4LW5leHQuIFRoaXMgY2FuIGFsd2F5cyBi
ZSByZXByb2R1Y2VkIGJ5IGEgTFRQIHRlc3QgY2FzZXMgWzFdIG9yCj4gPiBzb21ldGltZXMKPiA+
IGp1c3QgY29tcGlsaW5nIGtlcm5lbHMuCj4gPiAKPiA+IFJldmVydGluZyB0aGUgY29tbWl0ICJp
b21tdS9hbWQ6IFNldCBleGNsdXNpb24gcmFuZ2UgY29ycmVjdGx5IsKgZml4ZWQgdGhlCj4gPiBp
c3N1ZS4KPiA+IAo+ID4gW8KgwqAyMTMuNDM3MTEyXSBzbWFydHBxaSAwMDAwOjIzOjAwLjA6IEFN
RC1WaTogRXZlbnQgbG9nZ2VkIFtJT19QQUdFX0ZBVUxUCj4gPiBkb21haW49MHgwMDAwIGFkZHJl
c3M9MHgxMDAwIGZsYWdzPTB4MDAwMF0KPiA+IFvCoMKgMjEzLjQ0NzY1OV0gc21hcnRwcWkgMDAw
MDoyMzowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVAo+ID4gZG9tYWlu
PTB4MDAwMCBhZGRyZXNzPTB4MTgwMCBmbGFncz0weDAwMDBdCj4gPiBbwqDCoDIzMy4zNjIwMTNd
IHNtYXJ0cHFpIDAwMDA6MjM6MDAuMDogY29udHJvbGxlciBpcyBvZmZsaW5lOiBzdGF0dXMgY29k
ZQo+ID4gMHgxNDgwMwo+ID4gW8KgwqAyMzMuMzY5MzU5XSBzbWFydHBxaSAwMDAwOjIzOjAwLjA6
IGNvbnRyb2xsZXIgb2ZmbGluZQo+ID4gW8KgwqAyMzMuMzg4OTE1XSBwcmludF9yZXFfZXJyb3I6
IEkvTyBlcnJvciwgZGV2IHNkYiwgc2VjdG9yIDMzMTczNTIgZmxhZ3MKPiA+IDIwMDAwMDEKPiA+
IFvCoMKgMjMzLjM4ODkyMV0gc2QgMDowOjA6MDogW3NkYl0gdGFnIzk1IFVOS05PV04oMHgyMDAz
KSBSZXN1bHQ6Cj4gPiBob3N0Ynl0ZT0weDAxCj4gPiBkcml2ZXJieXRlPTB4MDAKPiA+IFvCoMKg
MjMzLjM4ODkzMV0gc2QgMDowOjA6MDogW3NkYl0gdGFnIzk1IENEQjogb3Bjb2RlPTB4MmEgMmEg
MDAgMDAgNTUgODkgMDAKPiA+IDAwIDAxCj4gPiAwOCAwMAo+ID4gW8KgwqAyMzMuMzg5MDAzXSBX
cml0ZS1lcnJvciBvbiBzd2FwLWRldmljZSAoMjU0OjE6NDQ3NDY0MCkKPiA+IFvCoMKgMjMzLjM4
OTAxNV0gV3JpdGUtZXJyb3Igb24gc3dhcC1kZXZpY2UgKDI1NDoxOjIxOTA3NzYpCj4gPiBbwqDC
oDIzMy4zODkwMjNdIFdyaXRlLWVycm9yIG9uIHN3YXAtZGV2aWNlICgyNTQ6MTo4MzUxOTM2KQo+
ID4gCj4gPiBbMV0gL29wdC9sdHAvdGVzdGNhc2VzL2Jpbi9tdGVzdDAxIC1wODAgLXcKPiAKPiBJ
IGNhbid0IGV4cGxhaW4gdGhhdCwgY2FuIHlvdSBwbGVhc2UgYm9vdCB3aXRoICdhbWRfaW9tbXVf
ZHVtcCcgb24gdGhlCj4ga2VybmVsIGNvbW1hbmQgbGluZSBhbmQgc2VuZCBtZSBkbWVzZyBhZnRl
ciBib290PwoKaHR0cHM6Ly9naXQuc3IuaHQvfmNhaS9saW51eC1kZWJ1Zy9ibG9iL21hc3Rlci9k
bWVzZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
