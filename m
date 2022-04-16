Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A20DC433EF
	for <iommu@archiver.kernel.org>; Sat, 16 Apr 2022 01:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 14B3F400E5;
	Sat, 16 Apr 2022 01:30:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 17ijoxOef77B; Sat, 16 Apr 2022 01:30:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E261640129;
	Sat, 16 Apr 2022 01:30:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F011C0033;
	Sat, 16 Apr 2022 01:30:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32EC0C002C
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 01:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0BDD06117D
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 01:30:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=foxmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id znohQlZnWTnu for <iommu@lists.linux-foundation.org>;
 Sat, 16 Apr 2022 01:30:36 +0000 (UTC)
X-Greylist: delayed 15:16:12 by SQLgrey-1.8.0
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com
 [162.62.58.216])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E7ABC6117B
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 01:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1650072628;
 bh=MRhdO0cz7cxp9uoazzUTQIFzQSvjWuvNyJYajb1r9is=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To;
 b=izGEMVFVBkox/rY0IEUR7tq3VdLky0RHy5QWIE/48uCv+RSij7t882fjocRfuVnO9
 arKc+6YlYLgnOzDYmNyMIozTbP5RkoAWLgdYaUfcwCJsoy0/jcqJNB9zfhYLVOEzH9
 tVAbYCx/3s6vBvsMQCD0ziEF13wEfVzpWmW0CBBA=
Received: from [IPv6:240e:362:47d:9500:6527:51dc:8ce2:179e]
 ([240e:362:47d:9500:6527:51dc:8ce2:179e])
 by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
 id 798346B3; Sat, 16 Apr 2022 09:30:24 +0800
X-QQ-mid: xmsmtpt1650072624trb9mmb58
Message-ID: <tencent_C8A588B7ED0135E6A6CB349F06AE0EB44107@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70QpzxApsWPM1NiJ2tyeChvdwskY/HojDIOHIeQ0wZc6DtJaB77C
 qxEIDkoQ3uTCgYYP6ee+dDWikpW+roqtweBaIiIoWtjSq4FYdXqgyKlh1W+X3La4Fm52vtXAHZtN
 QGTtG1RGhbFN1Beh1Gvvwb/4/bNgqE7dUd/HtnmAl9miMe8o0PhKi2Td8y0g6KCLZI2/pJuICMXz
 dnjGjTzPdhORuURiOksZgiPHNP9JAUHDWW1r+OPS9QwFIP54qQr0+UHN8aGidXfVRritM8e7PP1N
 R5LyQCRyan35JxttaPmLvptA0qyw5yPWFu32XQJ35apnA6zefnmaTG+WdQKcX+axk8bx65Ova19j
 4sGwFsa2d8a87btvtEfkwuWh5Y+0+s2aItiBGm2i8aO/oqKMTJPHnJX9UKV2VlhkRc4gTY9Vm88c
 9hA7KOMDjnU27aGpB1MDlb9xsXyi0R1mzsFVefiNbo+YvY/QSf8tIPPiTv3HgR4teG6SPboOKetE
 LDXtHUOUAun46pBGkPuCIQkcZei51Ddm7yNS+DaTxhjuZOhyZi63OUzymAIWJzRAScAeLyh3kIwM
 fsNthC9bD73kiUx22wxEvi4Q1z5/PjwDK5ksK9mzgONMdD7kQmd6UGcxLuFGrzc9gyeW2XCX4yuB
 ojC/oAmxC3vBwQ1hyA6eYW9FIA8gJLqtIKftoStNYDup+MHOeESwgJpEjllVnj9GeF0Rafxawzyg
 GY3RRyJ+/h2Bb49MZ1M4v1OtyvfDCZ385DVdO8Giy0MtsJfx/Myd19ZKXJOV2CLjCd3C+X9PkF9j
 dtbMCzek2zsz+UuQje9bwlDnHjfXsNP4CWz4KdJVeJTTCZ/gIIEFQ/nLuEY5B5a6TiIRw2GSgKb1
 IuK2uEJ7zCVPN4ZY0MJqwYJvHqlA7dG61k1q1cZNAVu2p6grqa1NAy2ZP/VkteQ6TsjM/1i1neey
 1w/VaxJUdXnxVCxYyFJBB4i25C04vT
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To: Fenghua Yu <fenghua.yu@intel.com>
References: <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
 <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
 <YllN/OmjpYdT1tO9@otcwcpicx3.sc.intel.com>
 <tencent_CD35B6A6FBB48186B38EF641F088BAED1407@qq.com>
 <YllnAPUlh3KHwjXq@fyu1.sc.intel.com>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <06436154-03dc-96c3-4e75-b7d982832d8a@foxmail.com>
Date: Sat, 16 Apr 2022 09:30:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YllnAPUlh3KHwjXq@fyu1.sc.intel.com>
Content-Language: en-US
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiAyMDIyLzQvMTUg5LiL5Y2IODozNywgRmVuZ2h1YSBZdSB3cm90ZToKPiBIaSwgWmhhbmdm
ZWksCj4KPiBPbiBGcmksIEFwciAxNSwgMjAyMiBhdCAwNzo1MjowM1BNICswODAwLCB6aGFuZ2Zl
aS5nYW9AZm94bWFpbC5jb20gd3JvdGU6Cj4+Cj4+IE9uIDIwMjIvNC8xNSDkuIvljYg2OjUwLCBG
ZW5naHVhIFl1IHdyb3RlOgo+Pj4gSGksIFpoYW5nZmVpLAo+Pj4KPj4+IE9uIEZyaSwgQXByIDE1
LCAyMDIyIGF0IDA2OjE0OjA5UE0gKzA4MDAsIHpoYW5nZmVpLmdhb0Bmb3htYWlsLmNvbSB3cm90
ZToKPj4+IEkgZG93bmxvYWQgdGhpcyBwYXRjaCBmcm9tOgo+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC9ZbGxBREw2dU1vTGxselFvQGZ5dTEuc2MuaW50ZWwuY29tL3Jhdwo+Pj4gZ2l0
IGFtIHRvIGVpdGhlciB2NS4xOC1yYzIgb3IgdGhlIGxhdGVzdCB1cHN0cmVhbSB3aXRob3V0IGFu
eSBpc3N1ZS4KPj4gSXQgaXMgbXkgY29weSBwYXN0ZSBpc3N1ZS4KPj4KPj4gSSBoYXZlIHRlc3Rl
ZCwgbmdpbnggd29rcyB3ZWxsLgo+IEdyZWF0IQo+Cj4+IE90aGVyIHRoYW4gdGhlIGZvbGxvd2lu
ZyBpc3N1ZSwKPj4gRWFjaCB0aW1lIC9zYmluL25naW54IHdpbGwgYWxsb2MgaW9hc2lkIGJ1dCBu
b3QgZnJlZS4KPj4gd2hpY2ggSSB0aGluayBpdCBtYXliZSBuZ2lueCBpc3N1ZSBvciB0aGUgbWlz
LXVzYWdlLCB3aWxsIGFzayB0aGVyZS4KPiBXaGljaCBuZ2lueC9vcGVuc3NsIGZ1bmN0aW9uIGlz
IHN1cHBvc2VkIHRvIGNhbGwga2VybmVsIHN2YV91bmJpbmQ/IEkgY291bGRuJ3QKPiBmaW5kIHRo
ZSBmdW5jdGlvbiBpbiBuZ2lueCB0cmVlLgo+Cj4gSWYgbmdpbnggZG9lc24ndCBmcmVlIGlvYXNp
ZCwgaXQgd2lsbCBjYXVzZSBpb2FzaWQgbGVhayBhbmQgbWVtb3J5IGxlYWsuClllcwoKSW4gbXkg
Y2FzZSwgc3ZhX2JpbmQvdW5iaW5kIGlzIGZyb20gb3BlbnNzbF9lbmdpbmUsIGJpbmRfZm4sIG5v
dCBpbiAKbmdpbnggaXRzZWxmCm5naW54IHdpbGwgdXNlIG9wZW5zc2wgLT4gb3BlbnNzbCBlbmdp
bmUuCgpuZ2lueDoKc3JjL2NvcmUvbmdpbnguYwptYWluCm5neF9zc2xfaW5pdChsb2cpOwoKT1BF
TlNTTF9pbml0X3NzbChPUEVOU1NMX0lOSVRfTE9BRF9DT05GSUcsIE5VTEwpCgoKb3BlbnNzbF9l
bmdpbmUKSU1QTEVNRU5UX0RZTkFNSUNfQklORF9GTihiaW5kX2ZuKQpiaW5kX2ZuCnN2YV9iaW5k
CgpkZXN0cm95CnN2YV91bmJpbmQKCkJ1dCBkZXN0cm95IHNlZW1zIG5vdCBjYWxsZWQgaW4gc2Jp
bi9uZ2lueCAtcyBxdWl0LgoKClRoYW5rcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
