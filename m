Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EB5C433B4
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 03:29:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B62CA61585
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 03:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62CA61585
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BBA6606B0;
	Tue, 11 May 2021 03:29:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s5-SHjYJcnx6; Tue, 11 May 2021 03:29:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 515A260C26;
	Tue, 11 May 2021 03:29:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28238C000E;
	Tue, 11 May 2021 03:29:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89C80C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 03:29:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F46A838F0
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 03:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cGwKQTP7-zQw for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 03:29:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56261838ED
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 03:29:22 +0000 (UTC)
IronPort-SDR: O2i9fuOsuaio3dUA9xSNVyO/5XS1lPWlZC+zDtKZ/Vqq872ggTmxgtyuM7staGCsWVL0UD0OfS
 PEWH+Uo26PvQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="179607813"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; d="scan'208";a="179607813"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 20:29:21 -0700
IronPort-SDR: Uhpb1DvDD4VWPvQUKBbuZtT0+KRdRivARUbZUC56WRz1l0s45RJxsvGjfZ0Rq+c/5mOehZQAfH
 TrML/fzG6MxA==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; d="scan'208";a="436443967"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 20:29:21 -0700
Date: Mon, 10 May 2021 20:31:45 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210510203145.086835cc@jacob-builder>
In-Reply-To: <20210510233749.GG1002214@nvidia.com>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210510233749.GG1002214@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

SGkgSmFzb24sCgpPbiBNb24sIDEwIE1heSAyMDIxIDIwOjM3OjQ5IC0wMzAwLCBKYXNvbiBHdW50
aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToKCj4gT24gTW9uLCBNYXkgMTAsIDIwMjEgYXQg
MDY6MjU6MDdBTSAtMDcwMCwgSmFjb2IgUGFuIHdyb3RlOgo+IAo+ID4gKy8qCj4gPiArICogVGhl
IElPTU1VX1NWQV9CSU5EX1NVUEVSVklTT1IgZmxhZyByZXF1ZXN0cyBhIFBBU0lEIHdoaWNoIGNh
biBiZQo+ID4gdXNlZCBvbmx5Cj4gPiArICogZm9yIGFjY2VzcyB0byBrZXJuZWwgYWRkcmVzc2Vz
LiBObyBJT1RMQiBmbHVzaGVzIGFyZSBhdXRvbWF0aWNhbGx5Cj4gPiBkb25lCj4gPiArICogZm9y
IGtlcm5lbCBtYXBwaW5nczsgaXQgaXMgdmFsaWQgb25seSBmb3IgYWNjZXNzIHRvIHRoZSBrZXJu
ZWwncwo+ID4gc3RhdGljCj4gPiArICogMToxIG1hcHBpbmcgb2YgcGh5c2ljYWwgbWVtb3J5IOKA
lCBub3QgdG8gdm1hbGxvYyBvciBldmVuIG1vZHVsZQo+ID4gbWFwcGluZ3MuCj4gPiArICogQSBm
dXR1cmUgQVBJIGFkZGl0aW9uIG1heSBwZXJtaXQgdGhlIHVzZSBvZiBzdWNoIHJhbmdlcywgYnkg
bWVhbnMKPiA+IG9mIGFuCj4gPiArICogZXhwbGljaXQgSU9UTEIgZmx1c2ggY2FsbCAoYWtpbiB0
byB0aGUgRE1BIEFQSSdzIHVubWFwIG1ldGhvZCkuCj4gPiArICoKPiA+ICsgKiBJdCBpcyB1bmxp
a2VseSB0aGF0IHdlIHdpbGwgZXZlciBob29rIGludG8gZmx1c2hfdGxiX2tlcm5lbF9yYW5nZSgp
Cj4gPiB0bwo+ID4gKyAqIGRvIHN1Y2ggSU9UTEIgZmx1c2hlcyBhdXRvbWF0aWNhbGx5Lgo+ID4g
KyAqLwo+ID4gKyNkZWZpbmUgSU9NTVVfU1ZBX0JJTkRfU1VQRVJWSVNPUiAgICAgICBCSVQoMCkg
IAo+IAo+IEh1aD8gVGhhdCBpc24ndCByZWFsbHkgU1ZBLCBjYW4geW91IGNhbGwgaXQgc29tZXRo
aW5nIHNhbmVyIHBsZWFzZT8KPiAKVGhpcyBpcyBzaGFyZWQga2VybmVsIHZpcnR1YWwgYWRkcmVz
cywgSSBhbSBmb2xsb3dpbmcgdGhlIFNWQSBsaWIgbmFtaW5nCnNpbmNlIHRoaXMgaXMgd2hlcmUg
dGhlIGZsYWcgd2lsbCBiZSB1c2VkLiBXaHkgdGhpcyBpcyBub3QgU1ZBPyBLZXJuZWwKdmlydHVh
bCBhZGRyZXNzIGlzIHN0aWxsIHZpcnR1YWwgYWRkcmVzcy4gSXMgaXQgZHVlIHRvIGRpcmVjdCBt
YXA/Cgo+IElzIGl0IHJlYWxseSBhIFBBU0lEIHRoYXQgYWx3YXlzIGhhcyBhbGwgb2YgcGh5c2lj
YWwgbWVtb3J5IG1hcHBlZAo+IGludG8gaXQ/IFNvdW5kcyBkYW5nZXJvdXMuIFdoYXQgaXMgaXQg
Zm9yPwo+IAoKWWVzLiBJdCBpcyB0byBiaW5kIERNQSByZXF1ZXN0IHcvIFBBU0lEIHdpdGggaW5p
dF9tbS9pbml0X3RvcF9wZ3QuIFBlciBQQ0llCnNwZWMgUEFTSUQgVExQIHByZWZpeCBoYXMgIlBy
aXZpbGVnZWQgTW9kZSBSZXF1ZXN0ZWQiIGJpdC4gVlQtZCBzdXBwb3J0cwp0aGlzIHdpdGggIlBy
aXZpbGVnZWQtbW9kZS1SZXF1ZXN0ZWQgKFBSKSBmbGFnICh0byBkaXN0aW5ndWlzaCB1c2VyIHZl
cnN1cwpzdXBlcnZpc29yIGFjY2VzcykiLiBFYWNoIFBBU0lEIGVudHJ5IGhhcyBhIFNSRSAoU3Vw
ZXJ2aXNvciBSZXF1ZXN0IEVuYWJsZSkKYml0LgoKUGVyaGFwcyB3ZSBzaG91bGQgbGltaXQgdGhh
dCB0byB0cnVzdGVkIGRldmljZSwgZS5nLiBSQ0lFUCBkZXZpY2U/Cgo+IEphc29uCgoKVGhhbmtz
LAoKSmFjb2IKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
