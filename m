Return-Path: <SRS0=FWOh=HO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F05C433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 07:14:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF4664DBA
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 07:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF4664DBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 645006F5D2
	for <iommu@archiver.kernel.org>; Fri, 12 Feb 2021 07:14:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1-UUolDyCv4G for <iommu@archiver.kernel.org>;
	Fri, 12 Feb 2021 07:14:22 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 2B0E56F60D; Fri, 12 Feb 2021 07:14:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78AD46F477;
	Fri, 12 Feb 2021 07:14:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61C62C0891;
	Fri, 12 Feb 2021 07:14:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79A4BC013A
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 07:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 67F2F8748B
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 07:14:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A2g-pxCDijF0 for <iommu@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 07:14:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 75F7C8745D
 for <iommu@lists.linux-foundation.org>; Fri, 12 Feb 2021 07:14:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13AC012FC
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 23:14:16 -0800 (PST)
Received: from mail-pf1-f181.google.com (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1ED53F93E
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 23:14:15 -0800 (PST)
Received: by mail-pf1-f181.google.com with SMTP id z6so5299454pfq.0
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 23:14:15 -0800 (PST)
X-Gm-Message-State: AOAM533PIFSsa3uNPQ9DiUenS8xqMFCnt7n3r7V6QDiWKedIziRcM4D9
 fLls3rpGx6qCEiKdLklPzc/WVQwViLxZ2ljI+CM=
X-Google-Smtp-Source: ABdhPJwh4OqzK51l5+oCcpoe1lJtHP5iZhZK3MLekzZNtkSeLcPp/+/1EG+P0Mm/KZz1hThhfwoCC9mQkeT8tsLUBKQ=
X-Received: by 2002:a63:1865:: with SMTP id 37mr1914822pgy.206.1613114055288; 
 Thu, 11 Feb 2021 23:14:15 -0800 (PST)
MIME-Version: 1.0
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <1599734733-6431-3-git-send-email-yi.l.liu@intel.com>
 <CAFp+6iFob_fy1cTgcEv0FOXBo70AEf3Z1UvXgPep62XXnLG9Gw@mail.gmail.com>
 <DM5PR11MB14356D5688CA7DC346AA32DBC3AA0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <CAFp+6iEnh6Tce26F0RHYCrQfiHrkf-W3_tXpx+ysGiQz6AWpEw@mail.gmail.com>
 <DM5PR11MB1435D9ED79B2BE9C8F235428C3A90@DM5PR11MB1435.namprd11.prod.outlook.com>
 <6bcd5229-9cd3-a78c-ccb2-be92f2add373@redhat.com>
 <DM5PR11MB143531EA8BD997A18F0A7671C3BF9@DM5PR11MB1435.namprd11.prod.outlook.com>
In-Reply-To: <DM5PR11MB143531EA8BD997A18F0A7671C3BF9@DM5PR11MB1435.namprd11.prod.outlook.com>
From: Vivek Gautam <vivek.gautam@arm.com>
Date: Fri, 12 Feb 2021 12:44:03 +0530
X-Gmail-Original-Message-ID: <CAFp+6iGZZ9fANN_0-NFb31kHfiytD5=vcsk1_Q8gp-_6L7xQVw@mail.gmail.com>
Message-ID: <CAFp+6iGZZ9fANN_0-NFb31kHfiytD5=vcsk1_Q8gp-_6L7xQVw@mail.gmail.com>
Subject: Re: [PATCH v7 02/16] iommu/smmu: Report empty domain nesting info
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "Sun, Yi Y" <yi.y.sun@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, Will Deacon <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, "Tian, Jun J" <jun.j.tian@intel.com>, "Wu,
 Hao" <hao.wu@intel.com>
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

SGkgWWksCgoKT24gU2F0LCBKYW4gMjMsIDIwMjEgYXQgMjoyOSBQTSBMaXUsIFlpIEwgPHlpLmwu
bGl1QGludGVsLmNvbT4gd3JvdGU6Cj4KPiBIaSBFcmljLAo+Cj4gPiBGcm9tOiBBdWdlciBFcmlj
IDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+Cj4gPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDE5LCAy
MDIxIDY6MDMgUE0KPiA+Cj4gPiBIaSBZaSwgVml2ZWssCj4gPgo+IFsuLi5dCj4gPiA+IEkgc2Vl
LiBJIHRoaW5rIHRoZXJlIG5lZWRzIGEgY2hhbmdlIGluIHRoZSBjb2RlIHRoZXJlLiBTaG91bGQg
YWxzbyBleHBlY3QKPiA+ID4gYSBuZXN0aW5nX2luZm8gcmV0dXJuZWQgaW5zdGVhZCBvZiBhbiBp
bnQgYW55bW9yZS4gQEVyaWMsIGhvdyBhYm91dCB5b3VyCj4gPiA+IG9waW5pb24/Cj4gPiA+Cj4g
PiA+ICAgICBkb21haW4gPSBpb21tdV9nZXRfZG9tYWluX2Zvcl9kZXYoJnZkZXYtPnBkZXYtPmRl
dik7Cj4gPiA+ICAgICByZXQgPSBpb21tdV9kb21haW5fZ2V0X2F0dHIoZG9tYWluLCBET01BSU5f
QVRUUl9ORVNUSU5HLAo+ID4gJmluZm8pOwo+ID4gPiAgICAgaWYgKHJldCB8fCAhKGluZm8uZmVh
dHVyZXMgJiBJT01NVV9ORVNUSU5HX0ZFQVRfUEFHRV9SRVNQKSkgewo+ID4gPiAgICAgICAgICAg
ICAvKgo+ID4gPiAgICAgICAgICAgICAgKiBObyBuZWVkIGdvIGZ1dGhlciBhcyBubyBwYWdlIHJl
cXVlc3Qgc2VydmljZSBzdXBwb3J0Lgo+ID4gPiAgICAgICAgICAgICAgKi8KPiA+ID4gICAgICAg
ICAgICAgcmV0dXJuIDA7Cj4gPiA+ICAgICB9Cj4gPiBTdXJlIEkgdGhpbmsgaXQgaXMgImp1c3Qi
IGEgbWF0dGVyIG9mIHN5bmNocm8gYmV0d2VlbiB0aGUgMiBzZXJpZXMuIFlpLAo+Cj4gZXhhY3Rs
eS4KPgo+ID4gZG8geW91IGhhdmUgcGxhbnMgdG8gcmVzcGluIHBhcnQgb2YKPiA+IFtQQVRDSCB2
NyAwMC8xNl0gdmZpbzogZXhwb3NlIHZpcnR1YWwgU2hhcmVkIFZpcnR1YWwgQWRkcmVzc2luZyB0
byBWTXMKPiA+IG9yIHdvdWxkIHlvdSBhbGxvdyBtZSB0byBlbWJlZCB0aGlzIHBhdGNoIGluIG15
IHNlcmllcy4KPgo+IE15IHY3IGhhc27igJl0IHRvdWNoIHRoZSBwcnEgY2hhbmdlIHlldC4gU28g
SSB0aGluayBpdCdzIGJldHRlciBmb3IgeW91IHRvCj4gZW1iZWQgaXQgdG8gIHlvdXIgc2VyaWVz
LiBeX14KPgoKQ2FuIHlvdSBwbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW4gdXBkYXRl
ZCBzZXJpZXMgb2YgdGhlc2UKcGF0Y2hlcz8gSXQgd2lsbCBoZWxwIG1lIHRvIHdvcmsgd2l0aCB2
aXJ0aW8taW9tbXUvYXJtIHNpZGUgY2hhbmdlcy4KClRoYW5rcyAmIHJlZ2FyZHMKVml2ZWsKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
