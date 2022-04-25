Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E99EC433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 02:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E80160AE2;
	Mon, 25 Apr 2022 02:59:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v1j3hH_pLhAg; Mon, 25 Apr 2022 02:59:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A8410607C9;
	Mon, 25 Apr 2022 02:59:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AF5BC0039;
	Mon, 25 Apr 2022 02:59:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56413C002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 02:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D5BA8125B
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 02:59:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=foxmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 26aQoy6WixOA for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 02:59:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com
 [203.205.221.155])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C7C481092
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 02:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1650855567;
 bh=HucfxWg7WLzKK33ibHuCmIEtwQY3NwivHh2WljaMSPk=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To;
 b=OEZu8VCWT1FdLuB1mCIh4rl1M/61weub00YVI3fKMXkFn2qXH3ireOGRkMW1Gt66I
 xLDdZ/llvP9X++OnbqkE2qloxxT6b4GU7vNGCSpTOEE2e4tdQQ6jLXUpjIaDtecs8s
 cXhtkuFSHJtoklydVeaU6z8xXNZAwAQ3MYJtqiK4=
Received: from [10.27.0.6] ([94.177.118.128])
 by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
 id E7715EE1; Mon, 25 Apr 2022 10:57:55 +0800
X-QQ-mid: xmsmtpt1650855475te67wfj42
Message-ID: <tencent_5151C34BC7D86055C4C7768C1A4653505A06@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQC/KJV6LaTwBj061LhYfOrByOSpey+K3S1udv28bAJjd5Bdllfd
 pNb7IEi0EY/cpHk10CYCm+d4cYqiCLcqqx/UcZ9XIVctITwZhcaxrq4AXXKFmiHMzFmtOaxWriNQ
 4hCNKjJs4cvj9qjSwWboYISnOiamhpm3yGXZ+WAmnQqWDDu5uS8Y7eYFmxHJwuwcHHM4B6Qaz2mI
 wWuVLmL0i/W/vSNlo3/tQiiviDuSL2NxALnbXwUkBqHNAuxFAEjZnZZYRF5kfCz9bvnys4jlOYBs
 bMlE2272nyI0aVjUA4mnUxCdHyImXVnpX+fzFlSwpcGJHmuVPt4j5WEfL7Ybo1XI4WBnq0Bn3lV4
 iE6jqCw3iMWqKMtshFuaHGNoUP5Uetko1WTX/8KW49AOaE9ix1IUdW2q7EP8sxF3iC+IRoCgTZ6t
 3YWYr6gLxB6mwTgHj/j7aQrqNhECc1f0hGC5xfxUVPTTvnRDXgLi8Y8qE9/eIHoWC56ibR9x/W/I
 zTOkiWDLBTv0L5Ba+/J/ZF3GrVEuBYuoHZSsWYASi4WTqhFmT/wBikEosE422A4nweHtC7ao5Gqc
 6eHmokCHPzg4hk0QMnGLXm7jD/Xj8ey9dgYk6UC8Uq3CPMxaDNl1LpTXeDVxxWsTjcILOZKuo2xp
 F8pvRpJDYBHcV7xhV8+OxlftqHtBYLJoGQKeFnLRufsIcTLkw/yR6LFWtLZkitCdUEF0Fa3JmEeT
 m6wjurCIXKFXX1wQOMsa+yb/OcBI0a+/VnCxpH0gWGLg84Aa7qAN4Y0C1CVwRIiX5CJE9Y+jHRxv
 h244I2/fM5O5tmDQ3142Jof8BbQa69HKjH8fmK8bdFk/g3BNNOrK54rWxGiId5ajoz4cy3UuCiqs
 mRjBozcKxwJifU8C3We0p/Xkouf5HGrEi4elXPN5nNbrYRzFmUkMyI2YPSE9oMzXcF5S934HkO
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To: Dave Hansen <dave.hansen@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220207230254.3342514-6-fenghua.yu@intel.com>
 <Ygt4h0PgYzKOiB38@8bytes.org>
 <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <41ed3405-66d9-0cde-fc01-b3eacb85a081@intel.com> <YlWWavIDMNpbD3Ye@larix>
 <8b1e40c9-b2e8-7b73-d9ad-2c6a5a167370@intel.com>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <6daae664-fad2-fe1f-0c22-b8c8aceab841@foxmail.com>
Date: Mon, 25 Apr 2022 10:57:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8b1e40c9-b2e8-7b73-d9ad-2c6a5a167370@intel.com>
Content-Language: en-US
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, zhangfei <zhangfei.gao@linaro.org>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGksIERhdmUKCk9uIDIwMjIvNC8xMiDkuIvljYgxMTozNSwgRGF2ZSBIYW5zZW4gd3JvdGU6Cj4g
T24gNC8xMi8yMiAwODoxMCwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+Pj4gSSB3b25k
ZXIgaWYgdGhlIEludGVsIGFuZCBBUk0gSU9NTVUgY29kZSBkaWZmZXIgaW4gdGhlIHdheSB0aGV5
IGtlZXAKPj4+IHJlZmVyZW5jZXMgdG8gdGhlIG1tLCBvciBpZiB0aGlzIGFmZmVjdHMgSW50ZWwg
YXMgd2VsbCwgYnV0IHdlIGp1c3QKPj4+IGhhdmVuJ3QgdGVzdGVkIHRoZSBjb2RlIGVub3VnaC4K
Pj4gVGhlIEFybSBjb2RlIHdhcyB3cml0dGVuIGV4cGVjdGluZyB0aGUgUEFTSUQgdG8gYmUgZnJl
ZWQgb24gdW5iaW5kKCksIG5vdAo+PiBtbSBleGl0LiBJIG1pc3NlZCB0aGUgY2hhbmdlIG9mIGJl
aGF2aW9yLCBzb3JyeSAoSSB0aG91Z2h0IHlvdXIgcGxhbiB3YXMKPj4gdG8gZXh0ZW5kIFBBU0lE
IGxpZmV0aW1lLCBub3Qgc2hvcnRlbiBpdD8pIGJ1dCBhcyBpcyBpdCBzZWVtcyB2ZXJ5IGJyb2tl
bi4KPj4gRm9yIGV4YW1wbGUgaW4gdGhlIGlvbW11X3N2YV91bmJpbmRfZGV2aWNlKCksIHdlIGhh
dmUKPj4gYXJtX3NtbXVfbW11X25vdGlmaWVyX3B1dCgpIGNsZWFyaW5nIHRoZSBQQVNJRCB0YWJs
ZSBlbnRyeSBmb3IKPj4gIm1tLT5wYXNpZCIsIHdoaWNoIGlzIGdvaW5nIHRvIGVuZCBiYWRseSBp
ZiB0aGUgUEFTSUQgaGFzIGJlZW4gY2xlYXJlZCBvcgo+PiByZWFsbG9jYXRlZC4gV2UgY2FuJ3Qg
Y2xlYXIgdGhlIFBBU0lEIGVudHJ5IGluIG1tIGV4aXQgYmVjYXVzZSBhdCB0aGF0Cj4+IHBvaW50
IHRoZSBkZXZpY2UgbWF5IHN0aWxsIGJlIGlzc3VpbmcgRE1BIGZvciB0aGF0IFBBU0lEIGFuZCB3
ZSBuZWVkIHRvCj4+IHF1aWVzY2UgdGhlIGVudHJ5IHJhdGhlciB0aGFuIGRlYWN0aXZhdGUgaXQu
Cj4gSSB0aGluayB3ZSBlbmRlZCB1cCBmbGlwcGluZyBzb21lIG9mIHRoaXMgYXJvdW5kIG9uIHRo
ZSBJbnRlbCBzaWRlLgo+IEluc3RlYWQgb2YgaGF2aW5nIHRvIHF1aWVzY2UgdGhlIGRldmljZSBv
biBtbSBleGl0LCB3ZSBkb24ndCBsZXQgdGhlIG1tCj4gZXhpdCB1bnRpbCB0aGUgZGV2aWNlIGlz
IGRvbmUuCj4KPiBXaGVuIHlvdSBwcm9ncmFtIHRoZSBwYXNpZCBpbnRvIHRoZSBkZXZpY2UsIGl0
J3MgYSBsb3QgbGlrZSB3aGVuIHlvdQo+IGNyZWF0ZSBhIHRocmVhZC4gIFdlIGJ1bXAgdGhlIHJl
ZmVyZW5jZSBjb3VudCBvbiB0aGUgbW0gd2hlbiB3ZSBwcm9ncmFtCj4gdGhlIHBhZ2UgdGFibGUg
cG9pbnRlciBpbnRvIGEgQ1BVLiAgV2UgZHJvcCB0aGUgdGhyZWFkJ3MgcmVmZXJlbmNlIHRvCj4g
dGhlIG1tIHdoZW4gdGhlIHRocmVhZCBleGl0cyBhbmQgd2lsbCBubyBsb25nZXIgYmUgdXNpbmcg
dGhlIHBhZ2UgdGFibGVzLgo+Cj4gU2FtZSB0aGluZyB3aXRoIHBhc2lkcy4gIFdlIGJ1bXAgdGhl
IHJlZmNvdW50IG9uIHRoZSBtbSB3aGVuIHRoZSBwYXNpZAo+IGlzIHByb2dyYW1tZWQgaW50byB0
aGUgZGV2aWNlLiAgT25jZSB0aGUgZGV2aWNlIGlzIGRvbmUgd2l0aCB0aGUgbW0sIHdlCj4gZHJv
cCB0aGUgbW0uCj4KPiBCYXNpY2FsbHksIGluc3RlYWQgb2YgcmVjb3VudGluZyB0aGUgcGFzaWQg
aXRzZWxmLCB3ZSBqdXN0IHJlZmNvdW50IHRoZSBtbS4KVGhpcyBoYXMgaXNzdWUsIHNpbmNlIHJl
ZmNvdW50IHRoZSBtbSB3aWxsIGJsb2NrwqAgZm9wc19yZWxlYXNlIHRvIGJlIApjYWxsZWQsIHdo
ZXJlIHVuYmluZCBtYXkgcmVhbGx5IGhhcHBlbi4KCkZvciBleGFtcGxlLCB1c2VyIGRyaXZlciBh
cmUgZW5kZWQgdW5leHBlY3RlZGx5LAp1c3VhbGx5IHN5c3RlbSB3aWxsIGVuZCBhbGwgYXBwbGlj
YXRpb25zIHZpYSBjbG9zZSBmZCAtPiBmb3BzX3JlbGVhc2UgLT4gCnVuYmluZCBtYXkgaGFwcGVu
IGhlcmUuCk5vdyBtbWdldCBpcyBjYWxsZWQsIGZvcHNfcmVsZWFzZSAtPiB1bmJpbmQgaGFzIE5P
IGNoYW5jZSB0byBiZSBjYWxsZWQsIApzbyBpb2FzaWQgY2FuIE5PVCBiZSBmcmVlZC4KClRoYW5r
cwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
