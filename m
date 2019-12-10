Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F90C43603
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 00:52:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC38E20726
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 00:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvC95ZB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC38E20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5E43786A4F;
	Tue, 10 Dec 2019 00:52:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MPNELRgQ3eep; Tue, 10 Dec 2019 00:52:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8E3ED869F6;
	Tue, 10 Dec 2019 00:52:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82915C1796;
	Tue, 10 Dec 2019 00:52:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B5D6C0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 00:52:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6A70886A3C
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 00:52:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pyEpo3eSqm0b for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 00:52:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A4E75869F6
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 00:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575939160;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ns3ZVV1MA/amU6PHYGZmOgz2Qp+Rd1lybjBoABM9L6g=;
 b=KvC95ZB1bbV8wcJ9blSXd4C1L9i4ebSyQckDNZzAxBBT1lm7B0rjZCBU19BYnURjvDgntP
 AvOhcZoaMtkhnGk2V3m63mKKmo/q2cmHJYzZ+g1FCV5pOTc3mEQQpuPpmKeAUR13Bo38t5
 Ux+3q9t6uHZhT5vxzYWrF1AznqsGc5k=
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-sguzTGf6PECb2J_EV2jB1A-1; Mon, 09 Dec 2019 19:52:38 -0500
Received: by mail-yw1-f71.google.com with SMTP id r75so13113824ywg.19
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 16:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=W56tlLFPgliGVn3gNY7MBzJPpa/h8reAF5vxf9RoLhg=;
 b=T2BwOZCnDPATQ9xZWPOzebFJm8A3I9QrMGNQY4oC/D6sFfZRAmTk+QK+dP/31+1jtd
 y4fShbWj7wR74ruy6r7SNpUUargr2h5OzUORGcz8n81t1FFNS2ZRpJ3byIfHZKqZ6MrS
 J8PTPKg4N6IpQm/JrymR9E7oE1NVp7dkOmBIx6M22YrPk55s/1+liVv/b96Eb9wwhtph
 3wLkzpDmC7LpUHzim4/MP5ON0MfiR4YA5SDHSXxHPq9P9GVlmpAYQZEm7oHD9UYY66uI
 iVJy5lXudgfasfbe51HpCPyGAUjWX6eSAdCs7cB0RYxuEbsFyL7VRCQZPL6ItmyzQWbH
 UwkQ==
X-Gm-Message-State: APjAAAUhSzTDs4LHGfvf2Kd9GXsmr1+/1H6l6VJLrNDfPzI2Fa4u3Hfw
 S0RVABJbqEH5+a9CWqG1hQu9d/NRM+TQEAsQXE7XhwvLwqkbYqbKgsj10+UQ06G5VbWChC3mKlH
 UeibZWBy96/MtBnv54nouVwTyCbrC2w==
X-Received: by 2002:a25:c08d:: with SMTP id
 c135mr24028447ybf.100.1575939157657; 
 Mon, 09 Dec 2019 16:52:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBJLAIBZUKFhB50RxX2DOfvxbtNnkuT6WpfNU2+Bvk7QGXN8BgzFIhviHKtcxq1dLxbdV3XA==
X-Received: by 2002:a25:c08d:: with SMTP id
 c135mr24028431ybf.100.1575939157251; 
 Mon, 09 Dec 2019 16:52:37 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id j68sm778241ywg.6.2019.12.09.16.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 16:52:36 -0800 (PST)
Date: Mon, 9 Dec 2019 17:52:34 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
Message-ID: <20191210005234.kanygdcjgsgo7z6j@cantor>
References: <2d4e0c05-f0ee-d4b1-d2ed-24197811b097@linux.intel.com>
 <20191205022551.janpwjvr4kei5r7c@cantor>
 <d5981dee-d37b-a725-ed94-8864f3dd7602@linux.intel.com>
 <20191205025320.oiulo3msfcggdlv5@cantor>
 <d5fbedce-7a06-79b4-75fa-0aa3cc3ef73b@linux.intel.com>
 <20191206072453.5jjwrjedqbjimx45@cantor>
 <0f82007e-9887-d6b2-08e5-9c430c920b36@linux.intel.com>
 <20191207022914.7uccwkmgadz4hvbf@cantor>
 <20191207024118.uwwzthqifh2dca5q@cantor>
 <7979b838-e2c5-4064-490c-8e0884909715@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <7979b838-e2c5-4064-490c-8e0884909715@linux.intel.com>
X-MC-Unique: sguzTGf6PECb2J_EV2jB1A-1
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

T24gU3VuIERlYyAwOCAxOSwgTHUgQmFvbHUgd3JvdGU6Cj5IaSwKPgo+T24gMTIvNy8xOSAxMDo0
MSBBTSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPj5PbiBGcmkgRGVjIDA2IDE5LCBKZXJyeSBT
bml0c2VsYWFyIHdyb3RlOgo+Pj5PbiBTYXQgRGVjIDA3IDE5LCBMdSBCYW9sdSB3cm90ZToKPj4+
PkhpIEplcnJ5LAo+Pj4+Cj4+Pj5PbiAxMi82LzE5IDM6MjQgUE0sIEplcnJ5IFNuaXRzZWxhYXIg
d3JvdGU6Cj4+Pj4+T24gRnJpIERlYyAwNiAxOSwgTHUgQmFvbHUgd3JvdGU6Cj4+Pj4+W3NuaXBd
Cj4+Pj4+Pgo+Pj4+Pj5DYW4geW91IHBsZWFzZSB0cnkgYmVsb3cgY2hhbmdlPyBMZXQncyBjaGVj
ayB3aGV0aGVyIHRoZSBhZmVuZGluZwo+Pj4+Pj5hZGRyZXNzIGhhcyBiZWVuIG1hcHBlZCBmb3Ig
ZGV2aWNlIDAxLjAwLjIuCj4+Pj4+Pgo+Pj4+Pj4kIGdpdCBkaWZmCj4+Pj4+PmRpZmYgLS1naXQg
YS9kcml2ZXJzL2lvbW11L2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKPj4+Pj4+aW5k
ZXggZGI3YmZkNGYyZDIwLi5kOWRhZjY2YmU4NDkgMTAwNjQ0Cj4+Pj4+Pi0tLSBhL2RyaXZlcnMv
aW9tbXUvaW9tbXUuYwo+Pj4+Pj4rKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMKPj4+Pj4+QEAg
LTY2Myw2ICs2NjMsOCBAQCBzdGF0aWMgaW50IAo+Pj4+Pj5pb21tdV9ncm91cF9jcmVhdGVfZGly
ZWN0X21hcHBpbmdzKHN0cnVjdCBpb21tdV9ncm91cCAKPj4+Pj4+Kmdyb3VwLAo+Pj4+Pj7CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBpb21tdV9tYXAo
ZG9tYWluLCBhZGRyLCBhZGRyLCAKPj4+Pj4+cGdfc2l6ZSwgZW50cnktPnByb3QpOwo+Pj4+Pj7C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+Pj4+
Pj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBvdXQ7Cj4+Pj4+PisKPj4+Pj4+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGRldl9pbmZvKGRldiwgIlNldHRpbmcgaWRlbnRpdHkgbWFwIAo+
Pj4+Pj5bMHglTHggLSAweCVMeF0gZm9yIGdyb3VwICVkXG4iLCBhZGRyLCBhZGRyICsgcGdfc2l6
ZSwgCj4+Pj4+Pmdyb3VwLT5pZCk7Cj4+Pj4+PsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fQo+Pj4+Pj4KPj4+Pj4+wqDCoMKgwqDCoMKgIH0KPj4+Pj4+Cj4+Pj4+PkkgYW0gZG91YnRpbmcg
dGhhdCBkZXZpY2UgMDEuMDAuMiBpcyBub3QgaW4gdGhlIGRldmljZSBzY29wZSBvZgo+Pj4+Pj4K
Pj4+Pj4+W8KgwqDCoCA0LjQ4NTEwOF0gRE1BUjogUk1SUiBiYXNlOiAweDAwMDAwMGJkZjZmMDAw
IGVuZDogMHgwMDAwMDBiZGY3ZWZmZgo+Pj4+Pj4KPj4+Pj4+QnkgdGhlIHdheSwgZG9lcyBkZXZp
Y2UgMDEuMDAuMiB3b3JrcyB3ZWxsIGFmdGVyIGJpbmRpbmcgdGhlIGRyaXZlcj8KPj4+Pj4+Cj4+
Pj4+Cj4+Pj4+V2hlbiBJIGJvb3QgaXQgd2l0aCBwYXNzdGhyb3VnaCBpdCBkb2Vzbid0IGdldCB0
byBhIHBvaW50IHdoZXJlIEkgY2FuCj4+Pj4+bG9naW4uIEkgdGhpbmsgdGhlIHNlcmlhbCBjb25z
b2xlIG9uIHRoZXNlIHN5c3RlbXMgaXMgdGllZCB0byB0aGUgaWxvLAo+Pj4+PnNvIHRoZSBjb25z
ZXJ2ZXIgY29ubmVjdGlvbiBjb3VsZCBiZSBtYWtpbmcgdGhpbmdzCj4+Pj4+d29yc2UuIFVuZm9y
dHVuYXRlbHkgdGhlIHN5c3RlbSBpcyByZW1vdGUuIEkgc2hvdWxkIGhhdmUgbW9yZSB0aW1lIG5v
dwo+Pj4+PnRvIGZvY3VzIG9uIGRlYnVnZ2luZyB0aGlzLgo+Pj4+Pgo+Pj4+PkF0dGFjaGluZyBj
b25zb2xlIG91dHB1dCBmb3IgdGhlIGFib3ZlIHBhdGNoLgo+Pj4+Cj4+Pj5JdCBzZWVtcyB0aGF0
IGRldmljZSAwMS4wMC4yIGlzbid0IGluIHRoZSBzY29wZSBvZiBSTVJSIFtiYXNlOgo+Pj4+MHgw
MDAwMDBiZGY2ZjAwMCBlbmQ6IDB4MDAwMDAwYmRmN2VmZmZdLiBCdXQgaXQgc3RpbGwgdHJpZXMg
dG8gYWNjZXNzCj4+Pj50aGUgYWRkcmVzcyB3aXRoaW4gaXQsIGhlbmNlIGZhdWx0cyBnZW5lcmF0
ZWQuCj4+Pj4KPj4+PllvdSBjYW4gY2hlY2sgaXQgd2l0aCBBQ1BJL0RNQVIgdGFibGUuCj4+Pj4K
Pj4+PkJlc3QgcmVnYXJkcywKPj4+PmJhb2x1Cj4+Pj4KPj4+Cj4+PkkgYmVsaWV2ZSBpdCBpcyB0
aGUgM3JkIGVuZHBvaW50IGRldmljZSBlbnRyeSBpbiBkbWFyIGRhdGEgYmVsb3cuCj4+PlNvIHF1
ZXN0aW9uIGFib3V0IHJlcXVlc3RfZGVmYXVsdF9kb21haW5fZm9yX2Rldi4gU2luY2UgYSBkbWEg
bWFwcGluZwo+Pj5pcyBhbHJlYWR5IGRvbmUgZm9yIDEuMDAuMCwgYW5kIHRoYXQgc2V0cyB0aGUg
ZGVmYXVsdF9kb21haW4gZm9yIHRoZQo+Pj5ncm91cCAoSSB0aGluayksIHdvbid0IGl0IGJhaWwg
b3V0IGZvciAxLjAwLjIgYXQgdGhpcyBjaGVjaz8KPj4+Cj4+PsKgwqDCoMKgaWYgKGdyb3VwLT5k
ZWZhdWx0X2RvbWFpbiAmJiBncm91cC0+ZGVmYXVsdF9kb21haW4tPnR5cGUgPT0gdHlwZSkKPj4+
wqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4+Pgo+Pgo+Pk9yIEkgZ3Vlc3MgcmVxdWVzdF9kZWZh
dWx0X2RvbWFpbl9mb3JfZGV2IHdvdWxkbid0IGV2ZW4gYmUgY2FsbGVkIAo+PmZvciAxLjAwLjIu
Cj4+aW50ZWxfaW9tbXVfYWRkX2RldmljZSBpdCB3b3VsZG4ndCBldmVuIGNhbGwgb25lIG9mIHRo
ZSByZXF1ZXN0Cj4+ZnVuY3Rpb25zIHdpdGggMS4wMC4yIHNpbmNlIGRvbWFpbi0+dHlwZSB3b3Vs
ZCBiZSBkbWEgZnJvbSAxLjAwLjAsIAo+PmFuZCBkZXZpY2VfZGVmX2RvbWFpbl90eXBlCj4+c2hv
dWxkIHJldHVybiBkbWEuCj4KPkNhbiB5b3UgcGxlYXNlIGFkZCBzb21lIGRlYnVnIG1lc3NhZ2Vz
IGFuZCBjaGVjayB3aGF0IHJlYWxseSBoYXBwZW5zCj5oZXJlPwo+Cj5CZXN0IHJlZ2FyZHMsCj5i
YW9sdQo+CgpbICAgMjUuMDAwNTQ0XSBwY2kgMDAwMDowMTowMC4wOiBBZGRpbmcgdG8gaW9tbXUg
Z3JvdXAgMjUKWyAgIDI1LjUwMjI0M10gcGNpIDAwMDA6MDE6MDAuMDogRE1BUjogZG9tYWluLT50
eXBlIGlzIGlkZW50aXR5ICA8PCBpbnRlbF9pb21tdV9hZGRfZGV2aWNlIChhbGxvY2VkIGluIGlv
bW11X2dyb3VwX2dldF9mb3JfZGV2KQpbICAgMjUuNTA0MjM5XSBwY2kgMDAwMDowMTowMC4wOiBE
TUFSOiBkZXZpY2UgZGVmYXVsdCBkb21haW4gdHlwZSBpcyBkbWEuIHJlcXVlc3RpbmcgZG1hIGRv
bWFpbiAgPDwgaW50ZWxfaW9tbXVfYWRkX2RldmljZQpbICAgMjUuNTA3OTU0XSBwY2kgMDAwMDow
MTowMC4wOiBVc2luZyBpb21tdSBkbWEgbWFwcGluZyAgICA8PCByZXF1ZXN0X2RlZmF1bHRfZG9t
YWluX2Zvcl9kZXYgIChub3cgZGVmYXVsdCBkb21haW4gZm9yIGdyb3VwIGlzIGRtYSkKWyAgIDI1
LjUwOTc2NV0gcGNpIDAwMDA6MDE6MDAuMTogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDI1ClsgICAy
NS41MTE1MTRdIHBjaSAwMDAwOjAxOjAwLjE6IERNQVI6IGRvbWFpbi0+dHlwZSBpcyBkbWEgIDw8
IGludGVsX2lvbW11X2FkZF9kZXZpY2UKWyAgIDI1LjUxMzI2M10gcGNpIDAwMDA6MDE6MDAuMTog
RE1BUjogZGV2aWNlIGRlZmF1bHQgZG9tYWluIHR5cGUgaXMgaWRlbnRpdHkuIHJlcXVlc3Rpbmcg
aWRlbnRpdHkgZG9tYWluICA8PCBpbnRlbF9pb21tdV9hZGRfZGV2aWNlClsgICAyNS41MTY0MzVd
IHBjaSAwMDAwOjAxOjAwLjE6IGRvbid0IGNoYW5nZSBtYXBwaW5ncyBvZiBleGlzdGluZyBkZXZp
Y2VzLiAgICA8PCByZXF1ZXN0X2RlZmF1bHRfZG9tYWluX2Zvcl9kZXYKWyAgIDI1LjUxODY2OV0g
cGNpIDAwMDA6MDE6MDAuMTogRE1BUjogRGV2aWNlIHVzZXMgYSBwcml2YXRlIGlkZW50aXR5IGRv
bWFpbi4gIDw8IGludGVsX2lvbW11X2FkZF9kZXZpY2UKWyAgIDI1LjUyMTA2MV0gcGNpIDAwMDA6
MDE6MDAuMjogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDI1ClsgICAyNS41MjI3OTFdIHBjaSAwMDAw
OjAxOjAwLjI6IERNQVI6IGRvbWFpbi0+dHlwZSBpcyBkbWEgIDw8IGludGVsX2lvbW11X2FkZF9k
ZXZpY2UKWyAgIDI1LjUyNDcwNl0gcGNpIDAwMDA6MDE6MDAuNDogQWRkaW5nIHRvIGlvbW11IGdy
b3VwIDI1ClsgICAyNS41MjY0NThdIHBjaSAwMDAwOjAxOjAwLjQ6IERNQVI6IGRvbWFpbi0+dHlw
ZSBpcyBkbWEgIDw8IGludGVsX2lvbW11X2FkZF9kZXZpY2UKWyAgIDI1LjUyODIxM10gcGNpIDAw
MDA6MDE6MDAuNDogRE1BUjogZGV2aWNlIGRlZmF1bHQgZG9tYWluIHR5cGUgaXMgaWRlbnRpdHku
IHJlcXVlc3RpbmcgaWRlbnRpdHkgZG9tYWluICA8PCBpbnRlbF9pb21tdV9hZGRfZGV2aWNlClsg
ICAyNS41MzEyODRdIHBjaSAwMDAwOjAxOjAwLjQ6IGRvbid0IGNoYW5nZSBtYXBwaW5ncyBvZiBl
eGlzdGluZyBkZXZpY2VzLiAgICA8PCByZXF1ZXN0X2RlZmF1bHRfZG9tYWluX2Zvcl9kZXYKWyAg
IDI1LjUzMzUwMF0gcGNpIDAwMDA6MDE6MDAuNDogRE1BUjogRGV2aWNlIHVzZXMgYSBwcml2YXRl
IGlkZW50aXR5IGRvbWFpbi4gIDw8IGludGVsX2lvbW11X2FkZF9kZXZpY2UKClNvIHRoZSBkb21h
aW4gdHlwZSBpcyBkbWEgYWZ0ZXIgMDE6MDAuMCBnZXRzIGFkZGVkLCBhbmQgd2hlbgppbnRlbF9p
b21tdV9hZGRfZGV2aWNlIGlzIGNhbGxlZCBmb3IgMDE6MDAuMiBpdCB3aWxsIGdvIGludG8gdGhl
IGlmCnNlY3Rpb24uIFNpbmNlIHRoZSBkZXZpY2UgZGVmYXVsdCBkb21haW4gdHlwZSBmb3IgMDE6
MDAuMiBpcyBkbWEKbm90aGluZyBoYXBwZW5zIGluIHRoZXJlLCBhbmQgaXQgZ29lcyBvbiB0byAw
MTowMC40LiBJcyB0aGUgInByaXZhdGUKaWRlbnRpdHkgZG9tYWluIiBtZXNzYWdlIHJlYWxseSBh
Y2N1cmF0ZSBzaW5jZSBldmVyeW9uZSB3aWxsIHVzZQpzaV9kb21haW4/IEFkZGluZyBzb21lIG1v
cmUgZGVidWdnaW5nLgoKUmVnYXJkcywKSmVycnkKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
