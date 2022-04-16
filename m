Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF69C433EF
	for <iommu@archiver.kernel.org>; Sat, 16 Apr 2022 01:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AB1E841F1;
	Sat, 16 Apr 2022 01:43:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zePAwBQ3uipy; Sat, 16 Apr 2022 01:43:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4F23A841EE;
	Sat, 16 Apr 2022 01:43:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F618C0033;
	Sat, 16 Apr 2022 01:43:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CA1BC002C
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 01:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7010E61171
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 01:43:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=foxmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H5vP777qIHSc for <iommu@lists.linux-foundation.org>;
 Sat, 16 Apr 2022 01:43:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com
 [162.62.58.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C7C560D55
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 01:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1650073404;
 bh=CriwDWtOWAQX5VANr5fAIAkGQbBAnagbCEroVjZL5xE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To;
 b=vYoQt6SJewL6WI0K5O30tCPiO5L3WaLOyA5Gwfa951PaIN+iCHv9/Ct4y13HtTwJn
 W5t56DPp29BB4zTcGZGFEEHsQ8K+qABRyX5U14P6XWZfVDHMQ0dBRG6vfZYZI0Gydo
 h7NXZqTdi+BO0nascDmtzhVBI+40UjL+4HO/zBvM=
Received: from [IPv6:240e:362:47d:9500:6527:51dc:8ce2:179e]
 ([240e:362:47d:9500:6527:51dc:8ce2:179e])
 by newxmesmtplogicsvrszc7.qq.com (NewEsmtp) with SMTP
 id AD38087B; Sat, 16 Apr 2022 09:43:19 +0800
X-QQ-mid: xmsmtpt1650073399tvl7nvia6
Message-ID: <tencent_8EC09A26D25C1A263AE207952230B789D409@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYSrO+zHxGJ/iwzNSjLXu9vUBN6PnZHIBGTm9jqMKPbKBgmf1wIfN
 fUnS32uHdLgy3E17MQn5nFZSjeuCUdYakAG0ji4xpE2GYKNVYpdnhhiMAyVYLaYzjVramRVd2o6T
 PBKHwjgnLhPCmooQY8Laqj4OEKZkrHDUYaNs6LU0sl3pPhLu9tkGtd7ookVkvph0+UidYKAunvTl
 z64mBPOAzGtjKjINLBHRpyPODP9pwo///ZZYbqaX/8sZ9yXWUo65C/WPy8YoOlqhnHs8VqUSMZLP
 h7/QcFSpSabezlKuABc/Wc/pjNosbHwzpDVAWJ9XolbEH93SZPppBI5AMRueJubQh+/vV6hHOKHR
 Y+AFXbM4k/ES7/0nxIZfWygx2H4lW7tefGlAaGII6lLDYSSHCqfjVpmrGKkY0Zd2TU6QlpNrSD7O
 7QWzcDuxN6wQUBngabozrXDxiyeXEpoclQka7rTkMp3+/5Euph5yL1mqelcqQunVwmuPTv1w+iUz
 WxAGWWWQkwg/8dzxw/NdUDUzSo5OWhYFlYkxLLzlDLZMUMIehLrrF0+gLFfGbzUkF5RS7a8q3IJb
 8lrJzBymc56Fn/tztPziAJBerWZxZ3+c8tF7zcBjUZP9dSZNb2blYQZw+VVvxDTb5igATok3q35O
 6PIQGZkUpGXIW5e0/M9ZEfI1eTTEzcQ2lopQigFZnhNAZ3lu/1+4jc8P1v8uJC/hezPlSX1BKFvi
 y6O5YlLO9pbmg+Zu0uqrecPrFhfwamuTbcuYhgHZyxEY6aPA64xzsL7ESon5Rrz4jL1z08ULC3CU
 xNAp8smcjAtTgyp37Z+QYLn5SKilhvPcZx5jn3ME9bKAuWX6oh4QE/+ASY50DPki7FRfUaqp60rk
 63jl0c74ddlK+VrqzWWIu0WF629TKIDoj/id2Z1rgmyE8kz20Viyu9zOXNU+hmCMecUiG/Xh/ZsB
 y5FqaZTq2OEsJN4wfz7Q==
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
 <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
 <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
 <20220415140002.7c12b0d2@jacob-builder>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <df95e2ad-4010-cd9c-094b-8b816419951a@foxmail.com>
Date: Sat, 16 Apr 2022 09:43:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220415140002.7c12b0d2@jacob-builder>
Content-Language: en-US
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 jean-philippe <jean-philippe@linaro.org>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiAyMDIyLzQvMTYg5LiK5Y2INTowMCwgSmFjb2IgUGFuIHdyb3RlOgo+IEhpIHpoYW5nZmVp
Lmdhb0Bmb3htYWlsLmNvbSwKPgo+IE9uIEZyaSwgMTUgQXByIDIwMjIgMTk6NTI6MDMgKzA4MDAs
ICJ6aGFuZ2ZlaS5nYW9AZm94bWFpbC5jb20iCj4gPHpoYW5nZmVpLmdhb0Bmb3htYWlsLmNvbT4g
d3JvdGU6Cj4KPj4+Pj4gQSBQQVNJRCBtaWdodCBiZSBzdGlsbCB1c2VkIGV2ZW4gdGhvdWdoIGl0
IGlzIGZyZWVkIG9uIG1tIGV4aXQuCj4+Pj4+Cj4+Pj4+IHByb2Nlc3MgQToKPj4+Pj4gCXN2YV9i
aW5kKCk7Cj4+Pj4+IAlpb2FzaWRfYWxsb2MoKSA9IE47IC8vIEdldCBQQVNJRCBOIGZvciB0aGUg
bW0KPj4+Pj4gCWZvcmsoKTogLy8gc3Bhd24gcHJvY2VzcyBCCj4+Pj4+IAlleGl0KCk7Cj4+Pj4+
IAlpb2FzaWRfZnJlZShOKTsKPj4+Pj4KPj4+Pj4gcHJvY2VzcyBCOgo+Pj4+PiAJZGV2aWNlIHVz
ZXMgUEFTSUQgTiAtPiBmYWlsdXJlCj4+Pj4+IAlzdmFfdW5iaW5kKCk7Cj4+Pj4+Cj4+Pj4+IERh
dmUgSGFuc2VuIHN1Z2dlc3RzIHRvIHRha2UgYSByZWZjb3VudCBvbiB0aGUgbW0gd2hlbmV2ZXIg
YmluZGluZyB0aGUKPj4+Pj4gUEFTSUQgdG8gYSBkZXZpY2UgYW5kIGRyb3AgdGhlIHJlZmNvdW50
IG9uIHVuYmluZGluZy4gVGhlIG1tIHdvbid0IGJlCj4+Pj4+IGRyb3BwZWQgaWYgdGhlIFBBU0lE
IGlzIHN0aWxsIGJvdW5kIHRvIGl0Lgo+Pj4+Pgo+Pj4+PiBGaXhlczogNzAxZmFjNDAzODRmICgi
aW9tbXUvc3ZhOiBBc3NpZ24gYSBQQVNJRCB0byBtbSBvbiBQQVNJRAo+Pj4+PiBhbGxvY2F0aW9u
IGFuZCBmcmVlIGl0IG9uIG1tIGV4aXQiKQo+Pj4+Pgo+IElzIHByb2Nlc3MgQSdzIG1tIGludGVu
ZGVkIHRvIGJlIHVzZWQgYnkgcHJvY2VzcyBCPyBPciB5b3UgcmVhbGx5IHNob3VsZAo+IHVzZSBQ
QVNJRCBOIG9uIHByb2Nlc3MgQidzIG1tPyBJZiB0aGUgbGF0dGVyLCBpdCBtYXkgd29yayBmb3Ig
YSB3aGlsZSB1bnRpbAo+IEIgY2hhbmdlcyBtYXBwaW5nLgo+Cj4gSXQgc2VlbXMgeW91IGFyZSBq
dXN0IGV4dGVuZGluZyB0aGUgbGlmZSBvZiBhIGRlZnVuY3QgbW0/CgogRnJvbSBuZ2lueCBjb2Rl
LCB0aGUgbWFzdGVyIHByb2Nlc3MgaW5pdCByZXNvdXJjZXMsIHRoZW4gZm9yayBkYWVtb24gCnBy
b2Nlc3MgdG8gdGFrZSBvdmVyLAp0aGVuIG1hc3RlciBwcm9jZXNzIGV4aXQgYnkgaXRzZWxmLgoK
c3JjL2NvcmUvbmdpbnguYwptYWluCm5neF9zc2xfaW5pdChsb2cpO8KgwqDCoCAtPiBvcGVuc3Ns
IGVuZ2luZSAtPiBiaW5kX2ZuIC0+IHN2YV9iaW5kKCkKbmd4X2RhZW1vbihjeWNsZS0+bG9nKQoK
c3JjL29zL3VuaXgvbmd4X2RhZW1vbi5jCm5neF9kYWVtb24obmd4X2xvZ190ICpsb2cpCnsKIMKg
wqDCoMKgIGludMKgIGZkOwoKIMKgwqDCoMKgIHN3aXRjaCAoZm9yaygpKSB7CiDCoMKgwqDCoCBj
YXNlIC0xOgogwqDCoMKgwqDCoMKgwqDCoCBuZ3hfbG9nX2Vycm9yKE5HWF9MT0dfRU1FUkcsIGxv
Zywgbmd4X2Vycm5vLCAiZm9yaygpIGZhaWxlZCIpOwogwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
TkdYX0VSUk9SOwoKIMKgwqDCoMKgIGNhc2UgMDoKIMKgwqDCoMKgwqDCoMKgIC8vIHRoZSBmb3Jr
IGRhZW1vbiBwcm9jZXNzCiDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwoKIMKgwqDCoMKgIGRlZmF1
bHQ6CiDCoMKgwqDCoMKgwqAgLy8gbWFzdGVyIHByb2Nlc3MgZGlyZWN0bHkgZXhpdCwgYW5kIHJl
bGVhc2UgbW0gYXMgd2VsbCBhcyBpb2FzaWQKIMKgwqDCoMKgwqDCoMKgwqAgZXhpdCgwKTsKIMKg
wqDCoMKgIH0KCiDCoMKgwqDCoMKgIC8vIG9ubHkgZGFlbW9uIHByb2Nlc3MKClRoYW5rcwoKPgo+
IFRoYW5rcywKPgo+IEphY29iCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
