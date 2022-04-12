Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0A1C433F5
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 14:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D79360F2D;
	Tue, 12 Apr 2022 14:39:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Oslc40UK1y_P; Tue, 12 Apr 2022 14:39:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5A59960E46;
	Tue, 12 Apr 2022 14:39:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33667C0033;
	Tue, 12 Apr 2022 14:39:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0F95C002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 14:39:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DF12F60F2D
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 14:39:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HWDeBVbvWDhe for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 14:39:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4203560E46
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 14:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649774351; x=1681310351;
 h=message-id:date:mime-version:to:cc:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=GZj64pjcWXoZ+UWhUertM7DeZpkX/WIgVteyu9EF33A=;
 b=S22hoy+U/9g0wh8aAr/1BuGepJjIiqy369mPiubrDyqehu+W5LPumlo9
 VHVDVldfFERs1h4ODTWLK9xUGNp4sOhwQQN5nj7KwtJ6sOf/UcLo5KC8r
 AnpzBVsSPA94JDcDbqP60zJGgB2vznQAaHxpMOLT6CiMap4Pp+3ejJO8C
 MdVxpafQI7eTRhFie9OMOPP+pHljuhRbvR29UIMGaPwehMBin2UNkudxJ
 c71JL87gX29vuxz/FlNuSK6AaXwr1UfoIXJHTZS7cvBk4GBOdUO+xW8AB
 +L9g9UotrNN9r3sT/6mdGiM7snxdXi6gN4YPqnq6gC3E8N/0ukT+0GBOD w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262569444"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; d="scan'208";a="262569444"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 07:39:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; d="scan'208";a="551735814"
Received: from vtelkarx-mobl.amr.corp.intel.com (HELO [10.209.191.73])
 ([10.209.191.73])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 07:39:04 -0700
Message-ID: <2cd3132b-2c24-610e-1a96-591f2803404c@intel.com>
Date: Tue, 12 Apr 2022 07:39:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Fenghua Yu <fenghua.yu@intel.com>,
 "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com> <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
Cc: jean-philippe <jean-philippe@linaro.org>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

T24gNC8xMi8yMiAwNjo0MSwgRmVuZ2h1YSBZdSB3cm90ZToKPj4gbWFzdGVyIHByb2Nlc3MgcXVp
dCwgbW1wdXQgLT7CoCBtbV9wYXNpZF9kcm9wLT5pb2FzaWRfZnJlZQo+PiBCdXQgdGhpcyBpZ25v
cmUgZHJpdmVyJ3MgaW9tbXVfc3ZhX3VuYmluZF9kZXZpY2UgZnVuY3Rpb24sCj4+IGlvbW11X3N2
YV9iaW5kX2RldmljZSBhbmQgaW9tbXVfc3ZhX3VuYmluZF9kZXZpY2UgYXJlIG5vdCBwYWlyLMKg
IFNvIGRyaXZlcgo+PiBkb2VzIG5vdCBrbm93IGlvYXNpZCBpcyBmcmVlZC4KPj4KPj4gQW55IHN1
Z2dlc3Rpb24/Cj4gaW9hc2lkIGlzIHBlciBwcm9jZXNzIG9yIHBlciBtbS4gQSBkYWVtb24gcHJv
Y2VzcyBzaG91bGRuJ3Qgc2hhcmUgdGhlIHNhbWUgCj4gaW9hc2lkIHdpdGggYW55IG90aGVyIHBy
b2Nlc3Mgd2l0aCBldmVuIGl0cyBwYXJlbnQgcHJvY2Vzcy4gSXRzIHBhcmVudCBnZXRzCj4gYW4g
aW9hc2lkIGFuZCBmcmVlcyBpdCBvbiBleGl0LiBUaGUgaW9hc2lkIGlzIGdvbmUgYW5kIHNob3Vs
ZG4ndCBiZSB1c2VkCj4gYnkgaXRzIGNoaWxkIHByb2Nlc3MuCj4gCj4gRWFjaCBkYWVtb24gcHJv
Y2VzcyBzaG91bGQgY2FsbCBkcml2ZXIgLT4gaW9tbXVfc3ZhX2JpbmRfZGV2aWNlIC0+IGlvYXNp
ZF9hbGxvYwo+IHRvIGdldCBpdHMgb3duIGlvYXNpZC9QQVNJRC4gT24gZGFlbW9uIHF1aXQsIHRo
ZSBpb2FzaWQgaXMgZnJlZWQuCj4gCj4gVGhhdCBtZWFucyBucW5peCBuZWVkcyB0byBiZSBjaGFu
Z2VkLgoKRmVuZ2h1YSwgcGxlYXNlIHN0ZXAgYmFjayBmb3IgYSBzZWNvbmQgYW5kIGxvb2sgYXQg
d2hhdCB5b3UgYXJlIHNheWluZy4KIFlvdXIgcGF0Y2ggY2F1c2VkIHVzZXJzcGFjZSB0byBicmVh
ay4gIE5vdywgeW91J3JlIHRlbGxpbmcgc29tZW9uZSB0aGF0CnRoZXkgbmVlZCB0byBnbyBjaGFu
Z2UgdGhhdCB1c2Vyc3BhY2UgdG8gd29yayBhcm91bmQgc29tZXRoaW5nIHRoYXQgeW91cgpwYXRj
aC4gIEhvdywgZXhhY3RseSwgYXJlIHlvdSBzdWdnZXN0aW5nIHRoYXQgbmdpbnggY291bGQgY2hh
bmdlIHRvIGZpeAp0aGlzPyAgV2hhdCwgc3BlY2lmaWNhbGx5LCB3YXMgaXQgZG9pbmcgd2l0aCAq
Zm9yaygpKiB0aGF0IHdhcyB3cm9uZz8KCkl0IHNvdW5kcyB0byBtZSBsaWtlIHlvdSdyZSBzYXlp
bmcgdGhhdCBpdCdzIE9LIHRvIGJyZWFrIHVzZXJzcGFjZS4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
