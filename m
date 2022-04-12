Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A71DC433EF
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 14:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0A9C60DF9;
	Tue, 12 Apr 2022 14:36:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YCzydpuRJmJl; Tue, 12 Apr 2022 14:36:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ABED260093;
	Tue, 12 Apr 2022 14:36:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86600C0033;
	Tue, 12 Apr 2022 14:36:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F2BCC002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 14:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1CD3E60DF9
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 14:36:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VzfHSuHo_y9Q for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 14:36:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85E2960093
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 14:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649774177; x=1681310177;
 h=message-id:date:mime-version:to:cc:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=JeWnAqK/BV2obmcOSf5I4zELcee40BbhqGtHiITzWPI=;
 b=Da1QMg4gUMJqKSsYZ8xQhRzAbU4QAlLlF4G+72JLv6sNZQz7ZvVeI+jI
 7dA7AcBvfEBv02X/e70bx2pKvI/Yij62pbdMHl2inji3o6ehYIgmUUogW
 ModD580mUJgCNbLSC5lCzHltV0PxCmGa8lfGVOSXC3Zf3a/3vKmx1CEUP
 p48KNfsvsVSQCFQM8w7+nE7LQyxaHT9nbk43VlRapmo8++OVQbVedlQ8F
 i/LFYDr0zulVUMezZ/EIVZWie7Bf/5cFK6jT83hD7wFXPXIo5nx1Rdkqi
 wrBL5AfcCtJqgoZVs3HRyH4irzY37Ihuqus1Bb12ITjbWnkY+0+v9r/BU w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="287406637"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; d="scan'208";a="287406637"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 07:36:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; d="scan'208";a="551735032"
Received: from vtelkarx-mobl.amr.corp.intel.com (HELO [10.209.191.73])
 ([10.209.191.73])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 07:36:15 -0700
Message-ID: <41ed3405-66d9-0cde-fc01-b3eacb85a081@intel.com>
Date: Tue, 12 Apr 2022 07:36:21 -0700
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
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
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

T24gNC8xMi8yMiAwMDowNCwgemhhbmdmZWkuZ2FvQGZveG1haWwuY29tIHdyb3RlOgo+IG1hc3Rl
ciBwcm9jZXNzIHF1aXQsIG1tcHV0IC0+wqAgbW1fcGFzaWRfZHJvcC0+aW9hc2lkX2ZyZWUKPiBC
dXQgdGhpcyBpZ25vcmUgZHJpdmVyJ3MgaW9tbXVfc3ZhX3VuYmluZF9kZXZpY2UgZnVuY3Rpb24s
Cj4gaW9tbXVfc3ZhX2JpbmRfZGV2aWNlIGFuZCBpb21tdV9zdmFfdW5iaW5kX2RldmljZSBhcmUg
bm90IHBhaXIswqAgU28KPiBkcml2ZXIgZG9lcyBub3Qga25vdyBpb2FzaWQgaXMgZnJlZWQuCj4g
Cj4gQW55IHN1Z2dlc3Rpb24/CgpJdCBzb3VuZHMgbGlrZSB5b3UncmUgc2F5aW5nIHRoYXQgdGhl
IGRldmljZSBpcyBzdGlsbCBhYm91bmQgdG8gdGhlClBBU0lEIGV2ZW4gdGhvdWdoIHRoZSBtbSBo
YXMgZXhpdGVkIGFuZCBmcmVlZCB0aGUgUEFTSUQuICBUaGlzIGlzCmVzc2VudGlhbGx5IGEgdXNl
LWFmdGVyLWZyZWUgZm9yIHRoZSBQQVNJRC4gIFJpZ2h0PwoKVGhlIHJpZ2h0IHRoaW5nIHRvIGRv
IGhlcmUgaXMgdG8gaGF2ZSB0aGUgUEFTSUQgY29kZSBob2xkIGEgcmVmZXJlbmNlIG9uCnRoZSBt
bS4gIFRoZSBtbSAib3ducyIgdGhlIFBBU0lEIGZvciBpdHMgZW50aXJlIGxpZmV0aW1lIGFuZCBp
ZiBhbnl0aGluZwpuZWVkcyB0aGUgUEFTSUQgdG8gbGl2ZSBsb25nZXIsIGl0cyBvbmx5IHJlY291
cnNlIGZvciBkb2luZyB0aGF0IGlzIHZpYQphbiBtbWdldCgpLiAgSSBfdGhpbmtfIG1tZ2V0KCkg
aXMgdGhlIHJpZ2h0IHRoaW5nIGFzIG9wcG9zZWQgdG8gbW1ncmFiKCkKYmVjYXVzZSB0aGUgUEFT
SUQgdXNlcnMgYWN0dWFsbHkgbmVlZCB0aGUgcGFnZSB0YWJsZXMgdG8gYmUgYXJvdW5kLgoKVGhp
cyB3b3VsZCBzdGlsbCBiZSBuaWNlIHRvIGNvbmZpcm0gd2l0aCBzb21lIHRyYWNlcyBvZiBmb3Jr
KCkvZXhpdCgpCmFuZCB0aGUgaW9tbXVfc3ZhX3tiaW5kLHVuYmluZH0gYW5kIGlvYXNpZF97YWxs
b2MsZnJlZX0gZnVuY3Rpb25zLgoKSSB3b25kZXIgaWYgdGhlIEludGVsIGFuZCBBUk0gSU9NTVUg
Y29kZSBkaWZmZXIgaW4gdGhlIHdheSB0aGV5IGtlZXAKcmVmZXJlbmNlcyB0byB0aGUgbW0sIG9y
IGlmIHRoaXMgYWZmZWN0cyBJbnRlbCBhcyB3ZWxsLCBidXQgd2UganVzdApoYXZlbid0IHRlc3Rl
ZCB0aGUgY29kZSBlbm91Z2guCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
