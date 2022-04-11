Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1863EC433EF
	for <iommu@archiver.kernel.org>; Mon, 11 Apr 2022 14:36:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B597F83148;
	Mon, 11 Apr 2022 14:36:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D_V1boLSQUsy; Mon, 11 Apr 2022 14:36:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A089682FEA;
	Mon, 11 Apr 2022 14:36:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76149C002F;
	Mon, 11 Apr 2022 14:36:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C3DCC002C
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:36:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2BAA860BB1
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:36:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZtqzbHlXMhPF for <iommu@lists.linux-foundation.org>;
 Mon, 11 Apr 2022 14:36:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EFD1560C27
 for <iommu@lists.linux-foundation.org>; Mon, 11 Apr 2022 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649687784; x=1681223784;
 h=message-id:date:mime-version:to:cc:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=YZSVAZRsUUEFlaaidv4vr1KoJx4NYOFjDRgt6QosIts=;
 b=ju+PSkrDneEi3QQlgWVG/v4+bY+W7rqQQH4mAdm9nogZmqTMYkKm7/r6
 AeypsQJcVAnb84/t/DBUIuHsGbF8ZTvSjMDq8JjKaEQRv/5+b28BVWOxK
 H26SdXgq6GmVHxQ7SxOt9eoJweA9hgRJp0euWCul2XwSeSIXO9dBoVaT7
 CicS042zAxZ2FWjdQv5KNeyeryllpsnyXZmftEj2ZBd4PyxK8Gk932FiA
 0BqST2vlPYbjJVeJJn/wcJGDL7P7po45zI20rJ24WGcCBbhGAgMrxAMvI
 wjWWSnhRuGlIaDhqoP84VUHVuvKx78lRl+DS94fpddMfpiIiKj1uYG63k w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="348568869"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="348568869"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 07:36:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="525557138"
Received: from srkondle-mobl.amr.corp.intel.com (HELO [10.212.113.6])
 ([10.212.113.6])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 07:36:21 -0700
Message-ID: <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
Date: Mon, 11 Apr 2022 07:36:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
 Joerg Roedel <joro@8bytes.org>, Fenghua Yu <fenghua.yu@intel.com>,
 jean-philippe <jean-philippe@linaro.org>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com> <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
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

T24gNC8xMS8yMiAwNzoyMCwgemhhbmdmZWkuZ2FvQGZveG1haWwuY29tIHdyb3RlOgo+PiBJcyB0
aGVyZSBub3RoaW5nIGJlZm9yZSB0aGlzIGNhbGwgdHJhY2U/wqAgVXN1YWxseSB0aGVyZSB3aWxs
IGJlIGF0IGxlYXN0Cj4+IHNvbWUgd2FybmluZyB0ZXh0Lgo+IEkgYWRkZWQgZHVtcF9zdGFjaygp
IGluIGlvYXNpZF9mcmVlLgoKSG9sZCBvbiBhIHNlYywgdGhvdWdoLi4uCgpXaGF0J3MgdGhlICpw
cm9ibGVtKiBoZXJlPyAgRGlkIHNvbWV0aGluZyBicmVhayBvciBhcmUgeW91IGp1c3Qgc2F5aW5n
CnRoYXQgc29tZXRoaW5nIGxvb2tzIHdlaXJkIHRvIF95b3VfPwoKRm9yIGluc3RhbmNlLCBpZiB3
ZSBoYXZlOgoKCW5naW54OiBpb2FzaWRfYWxsb2MoKT09MQoJICAgICAgIGZvcmsoKTsgLy8gc3Bh
d24gdGhlIGRhZW1vbgoJICAgICAgIGV4aXQoKTsKCSAgICAgICBpb2FzaWRfZnJlZSgxKTsKCmFu
ZCB0aGVuIGEgbW9tZW50IGxhdGVyOgoKCWx5bng6ICBpb2FzaWRfYWxsb2MoKT09MQoJICAgICAg
IGZvcmsoKTsKCSAgICAgICBleGl0KCk7CgkgICAgICAgaW9hc2lkX2ZyZWUoMSk7CgpUaGVyZSdz
IG5vIHByb2JsZW0uICBUaGUgb3JpZ2luYWwgbmdpbnggcHJvY2VzcyB3aXRoIGlvYXNpZD09MSBl
eGl0ZWQuClRoZSBmYWN0IHRoYXQgKnNvbWUqIHByb2Nlc3MgY2FsbGVkIG5naW54IGlzIHN0aWxs
IHJ1bm5pbmcgZG9lc24ndCBtZWFuCnRoYXQgaXQgc3RpbGwgaGFzIGEgcmVmZXJlbmNlIHRvIGFz
aWQ9PTEuCgpBcmUgeW91IHN1cmUgdGhlIG5naW54IHByb2Nlc3MgdGhhdCBhbGxvY2F0ZWQgdGhl
IEFTSUQgaXMgdGhlIHNhbWUKcHJvY2VzcyB5b3Ugc2VlIGluIHBzPwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
