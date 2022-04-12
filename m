Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DA2C433EF
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 13:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EB5860A93;
	Tue, 12 Apr 2022 13:41:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b9GEpVpSovqY; Tue, 12 Apr 2022 13:41:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0061C6103A;
	Tue, 12 Apr 2022 13:41:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC4B9C002F;
	Tue, 12 Apr 2022 13:41:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0C63C002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F61E40353
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:41:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NpxZvn8yBqJ6 for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 13:41:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 802C84032F
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649770879; x=1681306879;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=4mr0BKGyGNmXW0x7QfGTYNSu+BqJgjoRew/Y6ezcFe4=;
 b=A/ua4LQDANDzC+m/5NIauxLgHT7WjK0qbnbWzyQMaamx99Hd75Ohhmz4
 gJHPo2RXmk5bDqXCXeVtMpFQhxoiTtFEs+rEkdYk2NVYE1LkeZigvC+mQ
 GL7pkKYSr6/0SgbaZUIiY9vKIStGxP9x/bVpHJeZadGaWfPTE2LKze3RN
 82QAUiyErk53p86GDhL3bGorxb3DRwCa35o9sZ6lf0P95maVlBUUR5uqD
 0b5xfKGHW1Zq/7g3/WvWPZgVRb3upQ++11KRV0NSn1+iudHgBVVaujza7
 ShsxgyE7zqWgGmXyRlVItD/wgipGplYUysbh1MqkkU7oPG/q4U3Q76TE7 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261814698"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; d="scan'208";a="261814698"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 06:41:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; d="scan'208";a="660494090"
Received: from fyu1.sc.intel.com ([172.25.103.126])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 06:41:18 -0700
Date: Tue, 12 Apr 2022 06:41:39 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com>
 <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, jean-philippe <jean-philippe@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

SGksIFpoYW5nZmVpLAoKT24gVHVlLCBBcHIgMTIsIDIwMjIgYXQgMDM6MDQ6MDlQTSArMDgwMCwg
emhhbmdmZWkuZ2FvQGZveG1haWwuY29tIHdyb3RlOgo+IAo+IAo+IE9uIDIwMjIvNC8xMSDkuIvl
jYgxMDo1MiwgRGF2ZSBIYW5zZW4gd3JvdGU6Cj4gPiBPbiA0LzExLzIyIDA3OjQ0LCB6aGFuZ2Zl
aS5nYW9AZm94bWFpbC5jb20gd3JvdGU6Cj4gPiA+IE9uIDIwMjIvNC8xMSDkuIvljYgxMDozNiwg
RGF2ZSBIYW5zZW4gd3JvdGU6Cj4gPiA+ID4gT24gNC8xMS8yMiAwNzoyMCwgemhhbmdmZWkuZ2Fv
QGZveG1haWwuY29tIHdyb3RlOgo+ID4gPiA+ID4gPiBJcyB0aGVyZSBub3RoaW5nIGJlZm9yZSB0
aGlzIGNhbGwgdHJhY2U/wqAgVXN1YWxseSB0aGVyZSB3aWxsIGJlIGF0IGxlYXN0Cj4gPiA+ID4g
PiA+IHNvbWUgd2FybmluZyB0ZXh0Lgo+ID4gPiA+ID4gSSBhZGRlZCBkdW1wX3N0YWNrKCkgaW4g
aW9hc2lkX2ZyZWUuCj4gPiA+ID4gSG9sZCBvbiBhIHNlYywgdGhvdWdoLi4uCj4gPiA+ID4gCj4g
PiA+ID4gV2hhdCdzIHRoZSAqcHJvYmxlbSogaGVyZT/CoCBEaWQgc29tZXRoaW5nIGJyZWFrIG9y
IGFyZSB5b3UganVzdCBzYXlpbmcKPiA+ID4gPiB0aGF0IHNvbWV0aGluZyBsb29rcyB3ZWlyZCB0
byBfeW91Xz8KPiA+ID4gQWZ0ZXIgdGhpcywgbmdpbnggaXMgbm90IHdvcmtpbmcgYXQgYWxsLCBh
bmQgaGFyZHdhcmUgcmVwb3J0cyBlcnJvci4KPiA+ID4gU3VwcG9zZSB0aGUgdGhlIG1hc3RlciB1
c2UgdGhlIGlvYXNpZCBmb3IgaW5pdCwgYnV0IGdvdCBmcmVlZC4KPiA+ID4gCj4gPiA+IGhhcmR3
YXJlIHJlcG9ydHM6Cj4gPiA+IFvCoCAxNTIuNzMxODY5XSBoaXNpX3NlYzIgMDAwMDo3NjowMC4w
OiBxbV9hY2NfZG9fdGFza190aW1lb3V0IFtlcnJvciBzdGF0dXM9MHgyMF0gZm91bmQKPiA+ID4g
W8KgIDE1Mi43Mzk2NTddIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IHFtX2FjY193Yl9ub3RfcmVh
ZHlfdGltZW91dCBbZXJyb3Igc3RhdHVzPTB4NDBdIGZvdW5kCj4gPiA+IFvCoCAxNTIuNzQ3ODc3
XSBoaXNpX3NlYzIgMDAwMDo3NjowMC4wOiBzZWNfZnNtX2hiZWF0X3JpbnQgW2Vycm9yIHN0YXR1
cz0weDIwXSBmb3VuZAo+ID4gPiBbwqAgMTUyLjc1NTM0MF0gaGlzaV9zZWMyIDAwMDA6NzY6MDAu
MDogQ29udHJvbGxlciByZXNldHRpbmcuLi4KPiA+ID4gW8KgIDE1Mi43NjIwNDRdIGhpc2lfc2Vj
MiAwMDAwOjc2OjAwLjA6IFFNIG1haWxib3ggb3BlcmF0aW9uIHRpbWVvdXQhCj4gPiA+IFvCoCAx
NTIuNzY4MTk4XSBoaXNpX3NlYzIgMDAwMDo3NjowMC4wOiBGYWlsZWQgdG8gZHVtcCBzcWMhCj4g
PiA+IFvCoCAxNTIuNzczNDkwXSBoaXNpX3NlYzIgMDAwMDo3NjowMC4wOiBGYWlsZWQgdG8gZHJh
aW4gb3V0IGRhdGEgZm9yIHN0b3BwaW5nIQo+ID4gPiBbwqAgMTUyLjc4MTQyNl0gaGlzaV9zZWMy
IDAwMDA6NzY6MDAuMDogUU0gbWFpbGJveCBpcyBidXN5IHRvIHN0YXJ0IQo+ID4gPiBbwqAgMTUy
Ljc4NzQ2OF0gaGlzaV9zZWMyIDAwMDA6NzY6MDAuMDogRmFpbGVkIHRvIGR1bXAgc3FjIQo+ID4g
PiBbwqAgMTUyLjc5Mjc1M10gaGlzaV9zZWMyIDAwMDA6NzY6MDAuMDogRmFpbGVkIHRvIGRyYWlu
IG91dCBkYXRhIGZvciBzdG9wcGluZyEKPiA+ID4gW8KgIDE1Mi44MDA2ODVdIGhpc2lfc2VjMiAw
MDAwOjc2OjAwLjA6IFFNIG1haWxib3ggaXMgYnVzeSB0byBzdGFydCEKPiA+ID4gW8KgIDE1Mi44
MDY3MzBdIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IEZhaWxlZCB0byBkdW1wIHNxYyEKPiA+ID4g
W8KgIDE1Mi44MTIwMTddIGhpc2lfc2VjMiAwMDAwOjc2OjAwLjA6IEZhaWxlZCB0byBkcmFpbiBv
dXQgZGF0YSBmb3Igc3RvcHBpbmchCj4gPiA+IFvCoCAxNTIuODE5OTQ2XSBoaXNpX3NlYzIgMDAw
MDo3NjowMC4wOiBRTSBtYWlsYm94IGlzIGJ1c3kgdG8gc3RhcnQhCj4gPiA+IFvCoCAxNTIuODI1
OTkyXSBoaXNpX3NlYzIgMDAwMDo3NjowMC4wOiBGYWlsZWQgdG8gZHVtcCBzcWMhCj4gPiBUaGF0
IHdvdWxkIGhhdmUgYmVlbiBhd2Z1bGx5IGhhbmR5IGluZm9ybWF0aW9uIHRvIGhhdmUgaW4gYW4g
aW5pdGlhbCBidWcgcmVwb3J0LiA6KQo+ID4gSXMgdGhlcmUgYSBjaGFuY2UgeW91IGNvdWxkIGR1
bXAgb3V0IHRoYXQgaW9hc2lkIGFsbG9jICphbmQqIGZyZWUgaW5mb3JtYXRpb24gaW4gaW9hc2lk
X2FsbG9jL2ZyZWUoKT8gIFRoaXMgY291bGQgYmUgc29tZSBraW5kIG9mIHByb2JsZW0gd2l0aCB0
aGUgYWxsb2NhdG9yLCBvciB3aXRoIGNvcHlpbmcgdGhlIGlvYXNpZCBhdCBmb3JrLgo+IFRoZSBp
c3N1ZSBpcyBuZ2lueCBtYXN0ZXIgcHJvY2VzcyBpbml0IHJlc291cmNlLCBzdGFydCBkYWVtb24g
cHJvY2VzcywgdGhlbgo+IG1hc3RlciBwcm9jZXNzIHF1aXQgYW5kIGZyZWUgaW9hc2lkLgo+IFRo
ZSBkYWVtb24gbmdpbnggcHJvY2VzcyBpcyBub3QgdGhlIG9yaWdpbmFsIG1hc3RlciBwcm9jZXNz
Lgo+IAo+IG1hc3RlciBwcm9jZXNzOsKgIGluaXQgcmVzb3VyY2UKPiBkcml2ZXIgLT4gaW9tbXVf
c3ZhX2JpbmRfZGV2aWNlIC0+IGlvYXNpZF9hbGxvYwoKV2hpY2ggY29kZSBpbiB0aGUgbWFzdGVy
IHByb2Nlc3MvZGFlbW9uIGNhbGxzIGRyaXZlci0+aW9tbXVfc3ZhX3VuYmluZF9kZXZpY2U/Cgo+
IAo+IG5naW54IDogbmd4X2RhZW1vbgo+IGZvcmsgZGFlbW9uLCB3aXRob3V0IGFkZCBtbSdzIHJl
ZmNvdW50Lgo+IAo+IHNyYy9vcy91bml4L25neF9kYWVtb24uYwo+IG5neF9kYWVtb24obmd4X2xv
Z190ICpsb2cpCj4gewo+IMKgwqDCoCBpbnTCoCBmZDsKPiAKPiDCoMKgwqAgc3dpdGNoIChmb3Jr
KCkpIHsKPiDCoMKgwqAgY2FzZSAtMToKPiDCoMKgwqDCoMKgwqDCoCBuZ3hfbG9nX2Vycm9yKE5H
WF9MT0dfRU1FUkcsIGxvZywgbmd4X2Vycm5vLCAiZm9yaygpIGZhaWxlZCIpOwo+IMKgwqDCoMKg
wqDCoMKgIHJldHVybiBOR1hfRVJST1I7Cj4gCj4gwqDCoMKgIGNhc2UgMDrCoMKgwqAgwqDCoMKg
IC8vIGhlcmUgbWFzdGVyIHByb2Nlc3MgaXMgcXVpdCBkaXJlY3RseSBhbmQgd2lsbCBiZQo+IHJl
bGVhc2VkLgo+IMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+IAo+IMKgwqDCoCBkZWZhdWx0Ogo+IMKg
wqDCoMKgwqDCoMKgIGV4aXQoMCk7Cj4gwqDCoMKgIH0KPiAvLyBoZXJlIGRhZW1vbiBwcm9jZXNz
IHRha2UgY29udHJvbC4KPiDCoMKgwqAgbmd4X3BhcmVudCA9IG5neF9waWQ7Cj4gwqDCoMKgIG5n
eF9waWQgPSBuZ3hfZ2V0cGlkKCk7Cj4gCj4gCj4gZm9yay5jCj4gY29weV9tbQo+IMKgwqDCoMKg
wqDCoMKgIGlmIChjbG9uZV9mbGFncyAmIENMT05FX1ZNKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIG1tZ2V0KG9sZG1tKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgbW0gPSBvbGRtbTsKPiDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBtbSA9IGR1cF9tbSh0c2ssIGN1cnJlbnQtPm1tKTvCoMKgwqAgLy8g
aGVyZSBkYWVtb24gcHJvY2Vzcwo+IGhhbmRsaW5nIHdpdGhvdXQgbW1nZXQuCj4gCj4gbWFzdGVy
IHByb2Nlc3MgcXVpdCwgbW1wdXQgLT7CoCBtbV9wYXNpZF9kcm9wLT5pb2FzaWRfZnJlZQo+IEJ1
dCB0aGlzIGlnbm9yZSBkcml2ZXIncyBpb21tdV9zdmFfdW5iaW5kX2RldmljZSBmdW5jdGlvbiwK
PiBpb21tdV9zdmFfYmluZF9kZXZpY2UgYW5kIGlvbW11X3N2YV91bmJpbmRfZGV2aWNlIGFyZSBu
b3QgcGFpcizCoCBTbyBkcml2ZXIKPiBkb2VzIG5vdCBrbm93IGlvYXNpZCBpcyBmcmVlZC4KPiAK
PiBBbnkgc3VnZ2VzdGlvbj8KCmlvYXNpZCBpcyBwZXIgcHJvY2VzcyBvciBwZXIgbW0uIEEgZGFl
bW9uIHByb2Nlc3Mgc2hvdWxkbid0IHNoYXJlIHRoZSBzYW1lIAppb2FzaWQgd2l0aCBhbnkgb3Ro
ZXIgcHJvY2VzcyB3aXRoIGV2ZW4gaXRzIHBhcmVudCBwcm9jZXNzLiBJdHMgcGFyZW50IGdldHMK
YW4gaW9hc2lkIGFuZCBmcmVlcyBpdCBvbiBleGl0LiBUaGUgaW9hc2lkIGlzIGdvbmUgYW5kIHNo
b3VsZG4ndCBiZSB1c2VkCmJ5IGl0cyBjaGlsZCBwcm9jZXNzLgoKRWFjaCBkYWVtb24gcHJvY2Vz
cyBzaG91bGQgY2FsbCBkcml2ZXIgLT4gaW9tbXVfc3ZhX2JpbmRfZGV2aWNlIC0+IGlvYXNpZF9h
bGxvYwp0byBnZXQgaXRzIG93biBpb2FzaWQvUEFTSUQuIE9uIGRhZW1vbiBxdWl0LCB0aGUgaW9h
c2lkIGlzIGZyZWVkLgoKVGhhdCBtZWFucyBucW5peCBuZWVkcyB0byBiZSBjaGFuZ2VkLgoKPiBP
ciBjYW4gd2Ugc3RpbGwgdXNlIHRoZSBvcmlnaW5hbCBpb2FzaWQgcmVmY291bnQgbWVjaGFuaXNt
Pwo+IAoKVGhhbmtzLgoKLUZlbmdodWEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
