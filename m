Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AF1C433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 10:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 676124176A;
	Tue, 22 Mar 2022 10:06:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZDCKd8krfL8r; Tue, 22 Mar 2022 10:06:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 39E3D41740;
	Tue, 22 Mar 2022 10:06:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08C74C0012;
	Tue, 22 Mar 2022 10:06:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE2B1C000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 10:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB4558432C
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 10:06:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G3KeG9mBLUgl for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 10:06:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E395842F3
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 10:06:41 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 123-20020a1c1981000000b0038b3616a71aso1075455wmz.4
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 03:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=1PPlSdu6SJbMd88ecCAMnsK5O5gk90YXV6AjFTf/9W4=;
 b=e3hHzf4ibX5io970YXLoJEDxZJW3LESP/5JVdX3m1Pu+MDi/bX0fgd0HO/4CNqbniz
 XplxXB10KhO0jPOpj2MSFM0S+HZYQ4qiwyTC6Je8dKZLFk4wPnJhwNZQHXDw+FrLL+4X
 1+p5m8/o8FxxQXy56I4VDrr8cgPSnVucID2A5Uc8JQfEijGyxsGS6uMde5u/5Hulf0oO
 wo7LzFPhb8DNYT8P/dOl1DNGKoBYHFhrVO/bZAfV6DFpGSVQmc09bpFYdcIo6XW3yPNm
 m7ZrSy18qz7Mi/RJMVyIMBFN8MHOzmTV1s7DvmOTQcRSVhQW6gnYtK8ZIWY5NOnEogg8
 fQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=1PPlSdu6SJbMd88ecCAMnsK5O5gk90YXV6AjFTf/9W4=;
 b=fZJ2CNnqjWCAxj3A30wSbZ/tWqvVS52xbrDiIeqQw8Mr6WCyQM1iUPXdFY8qZXzIkL
 4cuHc+DFt74Q94fYda45twAE36YFrK1rz8Hw8F9NtDM1SDsnCsnC7mLz6VqL0N2vfEDT
 X4aQzmx/YlMvldVzCufwaxozMA6FClAP87fHMaweHYIMNoYY0pqHh51ct3LVTDjY/blH
 ixaW7Fvz7Wmu5N0X3V431sQzu9iNbSzgjnGnYFCOoeP8xp6auSp6RKJQuyRMQQb8AECB
 llXe6/lUn76Gw8GCLUQ3kbVVhF9kKwsdFtYNaSxyiH/4DaiPjn2454vu4wY6dETG//gJ
 8EmA==
X-Gm-Message-State: AOAM5302nTfn43a3GOaaJbJeflrHjHMN+tv5boSPsiQGDHCIeJMNDzDO
 AdaZph9Uv5cXnJblfgIGQboXMA==
X-Google-Smtp-Source: ABdhPJyLXu0xHdHXUhFQd0plssBfQL6O0HwMPeQyS6jDpo5e99ED+JqNH/XUFEbehtDo1kcC4q+7+Q==
X-Received: by 2002:a5d:6e0c:0:b0:1ef:7cbb:a5aa with SMTP id
 h12-20020a5d6e0c000000b001ef7cbba5aamr21752063wrz.5.1647943599593; 
 Tue, 22 Mar 2022 03:06:39 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 v124-20020a1cac82000000b0037c3d08e0e7sm1502463wme.29.2022.03.22.03.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Mar 2022 03:06:39 -0700 (PDT)
Date: Tue, 22 Mar 2022 10:06:14 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
Message-ID: <YjmflimaXyM/IZhk@myrica>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <BL1PR11MB5271DE11A868204D2E0D5B548C169@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YjhkmDEGwF4EcM8R@myrica>
 <BN9PR11MB52769EBCAE7E3EBB6D6AF1328C179@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52769EBCAE7E3EBB6D6AF1328C179@BN9PR11MB5276.namprd11.prod.outlook.com>
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

T24gVHVlLCBNYXIgMjIsIDIwMjIgYXQgMDE6MDA6MDhBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3Jv
dGU6Cj4gPiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJv
Lm9yZz4KPiA+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMjEsIDIwMjIgNzo0MiBQTQo+ID4gCj4gPiBI
aSBLZXZpbiwKPiA+IAo+ID4gT24gTW9uLCBNYXIgMjEsIDIwMjIgYXQgMDg6MDk6MzZBTSArMDAw
MCwgVGlhbiwgS2V2aW4gd3JvdGU6Cj4gPiA+ID4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxp
bnV4LmludGVsLmNvbT4KPiA+ID4gPiBTZW50OiBTdW5kYXksIE1hcmNoIDIwLCAyMDIyIDI6NDAg
UE0KPiA+ID4gPgo+ID4gPiA+IFRoZSBleGlzdGluZyBJT1BGIGhhbmRsaW5nIGZyYW1ld29yayBv
bmx5IGhhbmRsZXMgdGhlIEkvTyBwYWdlIGZhdWx0cyBmb3IKPiA+ID4gPiBTVkEuIEdpbnZlbiB0
aGF0IHdlIGFyZSBhYmxlIHRvIGxpbmsgaW9tbXUgZG9tYWluIHdpdGggZWFjaCBJL08gcGFnZQo+
ID4gZmF1bHQsCj4gPiA+ID4gd2UgY2FuIG5vdyBtYWtlIHRoZSBJL08gcGFnZSBmYXVsdCBoYW5k
bGluZyBmcmFtZXdvcmsgbW9yZSBnZW5lcmFsCj4gPiBmb3IKPiA+ID4gPiBtb3JlIHR5cGVzIG9m
IHBhZ2UgZmF1bHRzLgo+ID4gPgo+ID4gPiAibWFrZSAuLi4gZ2VuZXJpYyIgaW4gc3ViamVjdCBs
aW5lIGlzIGtpbmQgb2YgY29uZnVzaW5nLiBSZWFkaW5nIHRoaXMgcGF0Y2ggSQo+ID4gPiB0aGlu
ayB5b3UgcmVhbGx5IG1lYW50IGNoYW5naW5nIGZyb20gcGVyLWRldmljZSBmYXVsdCBoYW5kbGlu
ZyB0byBwZXItCj4gPiBkb21haW4KPiA+ID4gZmF1bHQgaGFuZGxpbmcuIFRoaXMgaXMgbW9yZSBh
Y2N1cmF0ZSBpbiBjb25jZXB0IHNpbmNlIHRoZSBmYXVsdCBpcyBjYXVzZWQgYnkKPiA+ID4gdGhl
IGRvbWFpbiBwYWdlIHRhYmxlLiDwn5iKCj4gPiAKPiA+IEkgdGVuZCB0byBkaXNhZ3JlZSB3aXRo
IHRoYXQgbGFzdCBwYXJ0LiBUaGUgZmF1bHQgaXMgY2F1c2VkIGJ5IGEgc3BlY2lmaWMKPiA+IGRl
dmljZSBhY2Nlc3Npbmcgc2hhcmVkIHBhZ2UgdGFibGVzLiBXZSBzaG91bGQga2VlcCB0aGF0IGRl
dmljZQo+ID4gaW5mb3JtYXRpb24gdGhyb3VnaG91dCB0aGUgZmF1bHQgaGFuZGxpbmcsIHNvIHRo
YXQgd2UgY2FuIHJlcG9ydCBpdCB0byB0aGUKPiA+IGRyaXZlciB3aGVuIHRoaW5ncyBnbyB3cm9u
Zy4gQSBwcm9jZXNzIGNhbiBoYXZlIG11bHRpcGxlIHRocmVhZHMgYm91bmQgdG8KPiA+IGRpZmZl
cmVudCBkZXZpY2VzLCB0aGV5IHNoYXJlIHRoZSBzYW1lIG1tIHNvIGlmIHRoZSBkcml2ZXIgd2Fu
dGVkIHRvCj4gPiBzaWduYWwgYSBtaXNiZWhhdmluZyB0aHJlYWQsIHNpbWlsYXJseSB0byBhIFNF
R1Ygb24gdGhlIENQVSBzaWRlLCBpdCB3b3VsZAo+ID4gbmVlZCB0aGUgZGV2aWNlIGluZm9ybWF0
aW9uIHRvIHByZWNpc2VseSByZXBvcnQgaXQgdG8gdXNlcnNwYWNlLgo+ID4gCj4gCj4gaW9tbXUg
ZHJpdmVyIGNhbiBpbmNsdWRlIHRoZSBkZXZpY2UgaW5mb3JtYXRpb24gaW4gdGhlIGZhdWx0IGRh
dGEuIEJ1dAo+IGluIGNvbmNlcHQgdGhlIElPUEYgc2hvdWxkIGJlIHJlcG9ydGVkIHBlciBkb21h
aW4uCgpTbyBJIGRvbid0IHJlbWVtYmVyIHdoZXJlIHdlIGxlZnQgb2ZmIG9uIHRoYXQgdG9waWMs
IHdoYXQgYWJvdXQgZmF1bHQKaW5qZWN0aW9uIGludG8gZ3Vlc3RzPyAgSW4gdGhhdCBjYXNlIGRl
dmljZSBpbmZvIGlzIG1vcmUgdGhhbiBqdXN0CmRpYWdub3N0aWMsIGZhdWx0IGluamVjdGlvbiBj
YW4ndCB3b3JrIHdpdGhvdXQgaXQuIEkgdGhpbmsgd2UgdGFsa2VkIGFib3V0CnBhc3NpbmcgYSBk
ZXZpY2UgY29va2llIHRvIHVzZXJzcGFjZSwganVzdCB3YW50IHRvIG1ha2Ugc3VyZS4KCj4gYW5k
IEkgYWdyZWUgd2l0aCBKYXNvbiB0aGF0IGF0IG1vc3Qgd2UgY2FuIHNlbmQgU0VHViB0byB0aGUg
ZW50aXJlIHRocmVhZAo+IGdyb3VwIHNpbmNlIHRoZXJlIGlzIG5vIHdheSB0byBhc3NvY2lhdGUg
YSBETUEgYmFjayB0byBhIHRocmVhZCB3aGljaCAKPiBpbml0aWF0ZXMgdGhlIERNQS4KClRoZSBw
b2ludCBpcyBwcm92aWRpbmcgdGhlIG1vc3QgYWNjdXJhdGUgaW5mb3JtYXRpb24gdG8gdGhlIGRl
dmljZSBkcml2ZXIKZm9yIGRpYWdub3N0aWNzIGFuZCBkZWJ1Z2dpbmcuIEEgcHJvY2VzcyBvcGVu
cyBtdWx0aXBsZSBxdWV1ZXMgdG8KZGlmZmVyZW50IGRldmljZXMsIHRoZW4gaWYgb25lIG9mIHRo
ZSBxdWV1ZXMgaXNzdWVzIGludmFsaWQgRE1BLCB0aGUKZHJpdmVyIHdvbid0IGV2ZW4ga25vdyB3
aGljaCBxdWV1ZSBpcyBicm9rZW4gaWYgeW91IG9ubHkgcmVwb3J0IHRoZSB0YXJnZXQKbW0gYW5k
IG5vdCB0aGUgc291cmNlIGRldi4gSSBkb24ndCB0aGluayB3ZSBnYWluIGFueXRoaW5nIGZyb20g
ZGlzY2FyZGluZwp0aGUgZGV2aWNlIGluZm9ybWF0aW9uIGZyb20gdGhlIGZhdWx0IHBhdGguCgpU
aGFua3MsCkplYW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
