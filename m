Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC0FC433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 10:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB36684745;
	Tue, 22 Mar 2022 10:51:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 93b27o4RKiJ8; Tue, 22 Mar 2022 10:51:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6323484749;
	Tue, 22 Mar 2022 10:51:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44E20C001A;
	Tue, 22 Mar 2022 10:51:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D306C000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 10:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 44C7284749
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 10:51:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6B_-2AT2tPoZ for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 10:51:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E38F84751
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 10:51:10 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 m26-20020a05600c3b1a00b0038c8b999f58so1559080wms.1
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 03:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=vHkckXRpWc29S4mUGAnBlHY1gMOmn1QpysKGSLTVZOM=;
 b=G1ZCn+YSaj8zyaI+u1xPH1mi587zvpCnLwH5rRfC26JQqNKMj7DtrEjzY/vbHSwTI6
 3EzyE2rQgTWSYc3H5VPJQbTC7p+UUoPasa8O1ZwqsWILevv3Odeebn3RMCn9KNS5UWMk
 Yrvn5iQ1f6WC4N+Tav7ZhK1z+/AHba5crj8+hnEhV+leYFoXgGttVGbTH54Q/gkAo5uR
 iK9I4vsIhbXg3A8BSqMVCogTTK+8O9pChYlCUz3e/5Ofqo1Cf/1W4WodFlI2aB/OV4hw
 Y4UPjxmzHA898W21Z/zGKujnzDkAjcQkiPyD69s0l85XMDW9NkR0HzlM+9u00tbMBWBT
 qONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=vHkckXRpWc29S4mUGAnBlHY1gMOmn1QpysKGSLTVZOM=;
 b=KTyGX7wj54sjaCtTNtq0FS1jQ6GzGJqGZEmB7oQAwJCCK+1+Ae/eITB5/naHsw0vuz
 Fc/CSSbETj6v+t4ceViGobq/FTNc84rKTzoNjynynmlqKXWzDTvodHyjPSjRA6O/oLKB
 0oZv4NEwamOAKsOKaUU4npu24MQGBh38x56PcGSzyFO4o0OOhfPZh93G/X7sskGk76MK
 ckpFfOtpNmjoGm6bYBT7VpNK/213+6yKX+aJmN5162WqRi/cxuCy7V9alOvkunlQb9k3
 qxbRY0PgaQjjQ1pjuCKR7HL/7iES1o4jpbIEqdoc3FY16wwNoXuB0nvcZcCK8+YIXa5h
 Sjyw==
X-Gm-Message-State: AOAM532jA6HQiNZyNYCiMqhOsmqSQ0qD0rvpkEZpSyq0ElG2FJAAU3J1
 H5GdmJv0CZcRXQtjc5m/wpE0tA==
X-Google-Smtp-Source: ABdhPJzFrwjVWwLqEgzwoKcTnyZeIa+AGuSx9Q9xf17eM30WNx66e6DW7dCcNcgfVjGrF921B9u+YQ==
X-Received: by 2002:a05:600c:1f0b:b0:38c:b121:c65f with SMTP id
 bd11-20020a05600c1f0b00b0038cb121c65fmr3095603wmb.124.1647946268316; 
 Tue, 22 Mar 2022 03:51:08 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 y13-20020adffa4d000000b00203e3ca2701sm19727486wrr.45.2022.03.22.03.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Mar 2022 03:51:07 -0700 (PDT)
Date: Tue, 22 Mar 2022 10:50:43 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
Message-ID: <YjmqA+zJUC+aPh8r@myrica>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <BL1PR11MB5271DE11A868204D2E0D5B548C169@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YjhkmDEGwF4EcM8R@myrica>
 <BN9PR11MB52769EBCAE7E3EBB6D6AF1328C179@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YjmflimaXyM/IZhk@myrica>
 <BN9PR11MB5276642FF0D53AE7773B5B718C179@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276642FF0D53AE7773B5B718C179@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Will Deacon <will@kernel.org>
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

T24gVHVlLCBNYXIgMjIsIDIwMjIgYXQgMTA6MjQ6MjZBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3Jv
dGU6Cj4gPiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJv
Lm9yZz4KPiA+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDIyLCAyMDIyIDY6MDYgUE0KPiA+IAo+ID4g
T24gVHVlLCBNYXIgMjIsIDIwMjIgYXQgMDE6MDA6MDhBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3Jv
dGU6Cj4gPiA+ID4gRnJvbTogSmVhbi1QaGlsaXBwZSBCcnVja2VyIDxqZWFuLXBoaWxpcHBlQGxp
bmFyby5vcmc+Cj4gPiA+ID4gU2VudDogTW9uZGF5LCBNYXJjaCAyMSwgMjAyMiA3OjQyIFBNCj4g
PiA+ID4KPiA+ID4gPiBIaSBLZXZpbiwKPiA+ID4gPgo+ID4gPiA+IE9uIE1vbiwgTWFyIDIxLCAy
MDIyIGF0IDA4OjA5OjM2QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOgo+ID4gPiA+ID4gPiBG
cm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPgo+ID4gPiA+ID4gPiBTZW50
OiBTdW5kYXksIE1hcmNoIDIwLCAyMDIyIDI6NDAgUE0KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
VGhlIGV4aXN0aW5nIElPUEYgaGFuZGxpbmcgZnJhbWV3b3JrIG9ubHkgaGFuZGxlcyB0aGUgSS9P
IHBhZ2UgZmF1bHRzCj4gPiBmb3IKPiA+ID4gPiA+ID4gU1ZBLiBHaW52ZW4gdGhhdCB3ZSBhcmUg
YWJsZSB0byBsaW5rIGlvbW11IGRvbWFpbiB3aXRoIGVhY2ggSS9PCj4gPiBwYWdlCj4gPiA+ID4g
ZmF1bHQsCj4gPiA+ID4gPiA+IHdlIGNhbiBub3cgbWFrZSB0aGUgSS9PIHBhZ2UgZmF1bHQgaGFu
ZGxpbmcgZnJhbWV3b3JrIG1vcmUKPiA+IGdlbmVyYWwKPiA+ID4gPiBmb3IKPiA+ID4gPiA+ID4g
bW9yZSB0eXBlcyBvZiBwYWdlIGZhdWx0cy4KPiA+ID4gPiA+Cj4gPiA+ID4gPiAibWFrZSAuLi4g
Z2VuZXJpYyIgaW4gc3ViamVjdCBsaW5lIGlzIGtpbmQgb2YgY29uZnVzaW5nLiBSZWFkaW5nIHRo
aXMgcGF0Y2gKPiA+IEkKPiA+ID4gPiA+IHRoaW5rIHlvdSByZWFsbHkgbWVhbnQgY2hhbmdpbmcg
ZnJvbSBwZXItZGV2aWNlIGZhdWx0IGhhbmRsaW5nIHRvIHBlci0KPiA+ID4gPiBkb21haW4KPiA+
ID4gPiA+IGZhdWx0IGhhbmRsaW5nLiBUaGlzIGlzIG1vcmUgYWNjdXJhdGUgaW4gY29uY2VwdCBz
aW5jZSB0aGUgZmF1bHQgaXMgY2F1c2VkCj4gPiBieQo+ID4gPiA+ID4gdGhlIGRvbWFpbiBwYWdl
IHRhYmxlLiDwn5iKCj4gPiA+ID4KPiA+ID4gPiBJIHRlbmQgdG8gZGlzYWdyZWUgd2l0aCB0aGF0
IGxhc3QgcGFydC4gVGhlIGZhdWx0IGlzIGNhdXNlZCBieSBhIHNwZWNpZmljCj4gPiA+ID4gZGV2
aWNlIGFjY2Vzc2luZyBzaGFyZWQgcGFnZSB0YWJsZXMuIFdlIHNob3VsZCBrZWVwIHRoYXQgZGV2
aWNlCj4gPiA+ID4gaW5mb3JtYXRpb24gdGhyb3VnaG91dCB0aGUgZmF1bHQgaGFuZGxpbmcsIHNv
IHRoYXQgd2UgY2FuIHJlcG9ydCBpdCB0byB0aGUKPiA+ID4gPiBkcml2ZXIgd2hlbiB0aGluZ3Mg
Z28gd3JvbmcuIEEgcHJvY2VzcyBjYW4gaGF2ZSBtdWx0aXBsZSB0aHJlYWRzIGJvdW5kCj4gPiB0
bwo+ID4gPiA+IGRpZmZlcmVudCBkZXZpY2VzLCB0aGV5IHNoYXJlIHRoZSBzYW1lIG1tIHNvIGlm
IHRoZSBkcml2ZXIgd2FudGVkIHRvCj4gPiA+ID4gc2lnbmFsIGEgbWlzYmVoYXZpbmcgdGhyZWFk
LCBzaW1pbGFybHkgdG8gYSBTRUdWIG9uIHRoZSBDUFUgc2lkZSwgaXQgd291bGQKPiA+ID4gPiBu
ZWVkIHRoZSBkZXZpY2UgaW5mb3JtYXRpb24gdG8gcHJlY2lzZWx5IHJlcG9ydCBpdCB0byB1c2Vy
c3BhY2UuCj4gPiA+ID4KPiA+ID4KPiA+ID4gaW9tbXUgZHJpdmVyIGNhbiBpbmNsdWRlIHRoZSBk
ZXZpY2UgaW5mb3JtYXRpb24gaW4gdGhlIGZhdWx0IGRhdGEuIEJ1dAo+ID4gPiBpbiBjb25jZXB0
IHRoZSBJT1BGIHNob3VsZCBiZSByZXBvcnRlZCBwZXIgZG9tYWluLgo+ID4gCj4gPiBTbyBJIGRv
bid0IHJlbWVtYmVyIHdoZXJlIHdlIGxlZnQgb2ZmIG9uIHRoYXQgdG9waWMsIHdoYXQgYWJvdXQg
ZmF1bHQKPiA+IGluamVjdGlvbiBpbnRvIGd1ZXN0cz8gIEluIHRoYXQgY2FzZSBkZXZpY2UgaW5m
byBpcyBtb3JlIHRoYW4ganVzdAo+ID4gZGlhZ25vc3RpYywgZmF1bHQgaW5qZWN0aW9uIGNhbid0
IHdvcmsgd2l0aG91dCBpdC4gSSB0aGluayB3ZSB0YWxrZWQgYWJvdXQKPiA+IHBhc3NpbmcgYSBk
ZXZpY2UgY29va2llIHRvIHVzZXJzcGFjZSwganVzdCB3YW50IHRvIG1ha2Ugc3VyZS4KPiA+IAo+
ID4gPiBhbmQgSSBhZ3JlZSB3aXRoIEphc29uIHRoYXQgYXQgbW9zdCB3ZSBjYW4gc2VuZCBTRUdW
IHRvIHRoZSBlbnRpcmUgdGhyZWFkCj4gPiA+IGdyb3VwIHNpbmNlIHRoZXJlIGlzIG5vIHdheSB0
byBhc3NvY2lhdGUgYSBETUEgYmFjayB0byBhIHRocmVhZCB3aGljaAo+ID4gPiBpbml0aWF0ZXMg
dGhlIERNQS4KPiA+IAo+ID4gVGhlIHBvaW50IGlzIHByb3ZpZGluZyB0aGUgbW9zdCBhY2N1cmF0
ZSBpbmZvcm1hdGlvbiB0byB0aGUgZGV2aWNlIGRyaXZlcgo+ID4gZm9yIGRpYWdub3N0aWNzIGFu
ZCBkZWJ1Z2dpbmcuIEEgcHJvY2VzcyBvcGVucyBtdWx0aXBsZSBxdWV1ZXMgdG8KPiA+IGRpZmZl
cmVudCBkZXZpY2VzLCB0aGVuIGlmIG9uZSBvZiB0aGUgcXVldWVzIGlzc3VlcyBpbnZhbGlkIERN
QSwgdGhlCj4gPiBkcml2ZXIgd29uJ3QgZXZlbiBrbm93IHdoaWNoIHF1ZXVlIGlzIGJyb2tlbiBp
ZiB5b3Ugb25seSByZXBvcnQgdGhlIHRhcmdldAo+ID4gbW0gYW5kIG5vdCB0aGUgc291cmNlIGRl
di4gSSBkb24ndCB0aGluayB3ZSBnYWluIGFueXRoaW5nIGZyb20gZGlzY2FyZGluZwo+ID4gdGhl
IGRldmljZSBpbmZvcm1hdGlvbiBmcm9tIHRoZSBmYXVsdCBwYXRoLgo+ID4gCj4gCj4gSW4gY2Fz
ZSBJIGRpZG4ndCBtYWtlIGl0IGNsZWFyLCB3aGF0IEkgdGFsa2VkIGFib3V0IGlzIGp1c3QgYWJv
dXQgaGF2aW5nIGlvbW11Cj4gY29yZSB0byByZXBvcnQgSU9QRiBwZXIgZG9tYWluIGhhbmRsZXIg
dnMuIHBlciBkZXZpY2UgaGFuZGxlciB3aGlsZSB0aGlzCj4gZGVzaWduIGNob2ljZSBkb2Vzbid0
IGNoYW5nZSB3aGF0IHRoZSBmYXVsdCBkYXRhIHNob3VsZCBpbmNsdWRlIChkZXZpY2UsCj4gcGFz
aWQsIGFkZHIsIGV0Yy4pLiBpLmUuIGl0IGFsd2F5cyBpbmNsdWRlcyBhbGwgdGhlIGluZm9ybWF0
aW9uIHByb3ZpZGVkIGJ5IHRoZQo+IGlvbW11IGRyaXZlciBubyBtYXR0ZXIgaG93IHRoZSBmYXVs
dCBpcyByZXBvcnRlZCB1cHdhcmRzLgoKUmlnaHQgdGhhbmtzLCBJIG1pc3VuZGVyc3Rvb2QuCgpU
aGFua3MsCkplYW4KCj4gCj4gZS5nLiB3aXRoIGlvbW11ZmQgaXQgaXMgaW9tbXVmZCB0byByZWdp
c3RlciBhIElPUEYgaGFuZGxlciBwZXIgbWFuYWdlZAo+IGRvbWFpbiBhbmQgcmVjZWl2ZSBJT1BG
IG9uIHRob3NlIGRvbWFpbnMuIElmIG5lY2Vzc2FyeSwgaW9tbXVmZCBmdXJ0aGVyCj4gZm9yd2Fy
ZHMgdG8gdXNlcnNwYWNlIGluY2x1ZGluZyBkZXZpY2UgY29va2llIGFjY29yZGluZyB0byB0aGUg
ZmF1bHQgZGF0YS4KPiAKPiBUaGFua3MKPiBLZXZpbgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
