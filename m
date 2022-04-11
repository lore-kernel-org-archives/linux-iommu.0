Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22692C433EF
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 14:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF46260803;
	Mon, 11 Apr 2022 14:11:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hUJ20rm-N_Bt; Mon, 11 Apr 2022 14:11:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 923E660797;
	Mon, 11 Apr 2022 14:11:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 546B3C002F;
	Mon, 11 Apr 2022 14:11:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40F18C002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E4A283E0E
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T-r0VG6r3ySh for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 14:11:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1869883DF5
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649686265; x=1681222265;
 h=message-id:date:mime-version:to:cc:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=frC20TMIzMSN3lrgDTo+z6mOXOf30jMlelae8Bj8uAA=;
 b=c0NBWPJ7Iqq1RhiAG9c3V8S3GuAR6/GJldrT7KH+/c+xnPvluHhxMJpn
 IDfcfiQoKhZjFTXlANnwpNFhJEsn/UEkbzhz8muuztmfz/+qsX+HDAEcJ
 62aHx3YWAbXsYUH+HP+kdM4l2kyMcI/nS2ORKqG1E0nqxanODN5AOVvWc
 WqxLEtvpxoKNuheKWsWNLIKh7Rwdb9pPHo+sNQt2QRZHH9ZHVJrzUvNK7
 ltwYogT2DngeDwGIAC1tK99WB0AxyL0xgg8RpYo4ErZcD9HKXa8E0wr15
 b85XXMVPpeFDQP8hLUF8YEQ/YtV9jAmRTV7yo7JpAzfAV1gebXtC2gujp Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="259720083"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="259720083"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 07:10:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="525550119"
Received: from srkondle-mobl.amr.corp.intel.com (HELO [10.212.113.6])
 ([10.212.113.6])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 07:10:38 -0700
Message-ID: <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
Date: Mon, 11 Apr 2022 07:10:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Zhangfei Gao <zhangfei.gao@foxmail.com>, Joerg Roedel <joro@8bytes.org>,
 Fenghua Yu <fenghua.yu@intel.com>, jean-philippe <jean-philippe@linaro.org>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com> <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Borislav Petkov <bp@alien8.de>,
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

T24gNC8xMS8yMiAwNzowMCwgWmhhbmdmZWkgR2FvIHdyb3RlOgo+IHdpdGggdGhpcyBwYXRjaHNl
dCwgZWFjaCB0aW1lIGFmdGVyICBzYmluL25naW54LCBpb2FzaWQgaXMgZnJlZWQKPiBpbW1lZGlh
dGVseS4gbHlueCB0ZXN0IHdpbGwgYWxsb2MgdGhlIHNhbWUgaW9hc2lkPTEuCgpUaGF0IGRvZXNu
J3Qgc2VlbSByaWdodC4gIElzbid0ICdzYmluL25naW54JyBzdGlsbCBydW5uaW5nIHdoZW4gbHlu
eApydW5zPyAgSG93IGNhbiB0aGV5IGdldCB0aGUgc2FtZSBpb2FzaWQ/CgpUaGlzIHNvdW5kcyBs
aWtlIGEgcmVmY291bnRpbmcgcHJvYmxlbSwgbGlrZSB0aGF0IHRoZSBpb2FzaWQgd2Fzbid0CnBy
b3Blcmx5IHJlZmNvdW50ZWQgYXMgbmdpbnggZm9ya2VkIGludG8gdGhlIGJhY2tncm91bmQuCgo+
IFRvIHZlcmlmeSwgaGFjayBjb21tZW50wqBtbV9wYXNpZF9kcm9wIGluwqBfX21tcHV0IHdpbGwg
bWFrZSB0aGUgaXNzdWUKPiBkaXNhcHBlYXIuCj4gCj4gbG9nOiBhZnRlciBzYmluL25naW54Lgo+
IFvCoCDCoDk2LjUyNjczMF0gQ2FsbCB0cmFjZToKPiBbwqAgwqA5Ni41MjY3MzJdwqAgZHVtcF9i
YWNrdHJhY2UrMHhlNC8weGYwCj4gW8KgIMKgOTYuNTI2NzQxXcKgIHNob3dfc3RhY2srMHgyMC8w
eDcwCj4gW8KgIMKgOTYuNTI2NzQ0XcKgIGR1bXBfc3RhY2tfbHZsKzB4OGMvMHhiOAo+IFvCoCDC
oDk2LjUyNjc1MV3CoCBkdW1wX3N0YWNrKzB4MTgvMHgzNAo+IFvCoCDCoDk2LjUyNjc1NF3CoCBp
b2FzaWRfZnJlZSsweGRjLzB4ZmMKPiBbwqAgwqA5Ni41MjY3NTddwqAgbW1wdXQrMHgxMzgvMHgx
NjAKPiBbwqAgwqA5Ni41MjY3NjBdwqAgZG9fZXhpdCsweDI4NC8weDlkMAo+IFvCoCDCoDk2LjUy
Njc2NV3CoCBkb19ncm91cF9leGl0KzB4M2MvMHhhOAo+IFvCoCDCoDk2LjUyNjc2N13CoCBfX3dh
a2VfdXBfcGFyZW50KzB4MC8weDM4Cj4gW8KgIMKgOTYuNTI2NzcwXcKgIGludm9rZV9zeXNjYWxs
KzB4NGMvMHgxMTAKPiBbwqAgwqA5Ni41MjY3NzVdwqAgZWwwX3N2Y19jb21tb24uY29uc3Rwcm9w
LjArMHg2OC8weDEyOAo+IFvCoCDCoDk2LjUyNjc3OF3CoCBkb19lbDBfc3ZjKzB4MmMvMHg5MAo+
IFvCoCDCoDk2LjUyNjc4MV3CoCBlbDBfc3ZjKzB4MzAvMHg5OAo+IFvCoCDCoDk2LjUyNjc4M13C
oCBlbDB0XzY0X3N5bmNfaGFuZGxlcisweGIwLzB4YjgKPiBbwqAgwqA5Ni41MjY3ODVdwqAgZWww
dF82NF9zeW5jKzB4MThjLzB4MTkwCgpJcyB0aGVyZSBub3RoaW5nIGJlZm9yZSB0aGlzIGNhbGwg
dHJhY2U/ICBVc3VhbGx5IHRoZXJlIHdpbGwgYmUgYXQgbGVhc3QKc29tZSB3YXJuaW5nIHRleHQu
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
