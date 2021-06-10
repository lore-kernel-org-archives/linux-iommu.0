Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39C3C47094
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 14:13:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6816E613E9
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 14:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6816E613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 342D840410;
	Thu, 10 Jun 2021 14:13:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n8BnTa5hG10Z; Thu, 10 Jun 2021 14:13:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 24C43400E9;
	Thu, 10 Jun 2021 14:13:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F4238C000D;
	Thu, 10 Jun 2021 14:13:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEF9AC000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 14:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB29440212
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 14:13:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S_0ohdZNewjV for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 14:13:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F28A24020B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 14:13:47 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id y15so1732219pfl.4
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uVvPHfIwriaeCqaGS4SWF2JfjGEeCNMTseqgcHKL0PY=;
 b=ot0iffXK2/znAlvDWUx0DvEHPs9Hu42jQhvk3aHGx+T2NhWFpnwKA1vIkYGIy+cgYb
 LxEbfgCrbULtFd7nVuJsfQAH+IMqZIL2R35dwiAl9sJZz1GKTswJr7viHRHzd8ec6z9L
 cpBdHTN6hAjfnZCW/MdapYStRdZ2pSAmS2zSYAlKj+wqby1v1sKfa0Z3IJGU1Q2S8YcP
 HqfC/opPsY22Z36tiTPSUNG8yLuAg9Bq77HzKuJDM2mT1cANyfp9SOlXy6wpSwett2B6
 yucBibCk75zJ2NzA/8lMhfuq11vR41IllnpzmIyKLTH/P3wGLWQCIUfWmxQ4zGD/3HTx
 tacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uVvPHfIwriaeCqaGS4SWF2JfjGEeCNMTseqgcHKL0PY=;
 b=QTwEzbmkgOR0yeY7I1dhIFgOdd/Vy9E0y77EkdJOeWvPlhDkSD85M/kYS0hvA3VfPw
 1RF6sahe4HWi8zZtpwQM/oJHCQrus33TMo3vx+ryW+6VE5hx/LAzKy5q/lwXvcgGy1jb
 +l2/Gp7GSzw+f2sRr+9A0EAeFD8Udvykl/15lx4sOtkxF7lWq4+Iavt+45oyjd8WP2xy
 YpftyC7TsPM5dMEDeYMpHFsAbM+16MKo9Nj+Z+YxLUSBsFUqngTB+ZFtadh7d5zStQBs
 QQKTIFakoFwpElWxn9ah86PsI7t8B6rU48AehF47irRvzCKJDmtq/rc+O+UW68NTLWj3
 HVDA==
X-Gm-Message-State: AOAM532w9p4TbGuOK0gt3ay51CyaTxCzGtqiMmrbzIjlpNo7FQUlNld0
 cxHy1Nk3KumUZj57VVVfc1o=
X-Google-Smtp-Source: ABdhPJz4FYgWX1XRVYnd1fLznm93BCcmg2/a4wkuQ7x2l90mgEwjIr25Q5mcrDlHBGTMoQXHYCH6CA==
X-Received: by 2002:a05:6a00:2353:b029:2f2:987a:5da2 with SMTP id
 j19-20020a056a002353b02902f2987a5da2mr3220673pfj.58.1623334427380; 
 Thu, 10 Jun 2021 07:13:47 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 h12sm3035510pgn.54.2021.06.10.07.13.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jun 2021 07:13:46 -0700 (PDT)
Subject: Re: [RFC PATCH V3 01/11] x86/HV: Initialize GHCB page in Isolation VM
To: Joerg Roedel <joro@8bytes.org>
References: <20210530150628.2063957-1-ltykernel@gmail.com>
 <20210530150628.2063957-2-ltykernel@gmail.com> <YMC2RSr/J1WYCvtz@8bytes.org>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <c9a7eaa8-a8b3-3ed3-c52c-7a2cea3c95bc@gmail.com>
Date: Thu, 10 Jun 2021 22:13:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMC2RSr/J1WYCvtz@8bytes.org>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 thomas.lendacky@amd.com, peterz@infradead.org, dave.hansen@linux.intel.com,
 hpa@zytor.com, kys@microsoft.com, will@kernel.org, hch@lst.de,
 linux-arch@vger.kernel.org, wei.liu@kernel.org, sstabellini@kernel.org,
 sthemmin@microsoft.com, linux-scsi@vger.kernel.org, x86@kernel.org,
 decui@microsoft.com, mingo@redhat.com, xen-devel@lists.xenproject.org,
 jejb@linux.ibm.com, jgross@suse.com, Tianyu.Lan@microsoft.com, arnd@arndb.de,
 konrad.wilk@oracle.com, haiyangz@microsoft.com, kuba@kernel.org, bp@alien8.de,
 luto@kernel.org, krish.sadhukhan@oracle.com, tglx@linutronix.de,
 vkuznets@redhat.com, boris.ostrovsky@oracle.com, martin.petersen@oracle.com,
 saravanand@fb.com, netdev@vger.kernel.org, sunilmut@microsoft.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 kirill.shutemov@linux.intel.com, hannes@cmpxchg.org, cai@lca.pw,
 akpm@linux-foundation.org, robin.murphy@arm.com, davem@davemloft.net,
 rppt@kernel.org
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

SGkgSm9lcmfvvJoKCVRoYW5rcyBmb3IgeW91ciByZXZpZXcuCgoKT24gNi85LzIwMjEgODozOCBQ
TSwgSm9lcmcgUm9lZGVsIHdyb3RlOgo+IE9uIFN1biwgTWF5IDMwLCAyMDIxIGF0IDExOjA2OjE4
QU0gLTA0MDAsIFRpYW55dSBMYW4gd3JvdGU6Cj4+IEZyb206IFRpYW55dSBMYW4gPFRpYW55dS5M
YW5AbWljcm9zb2Z0LmNvbT4KPj4KPj4gSHlwZXItViBleHBvc2VzIEdIQ0IgcGFnZSB2aWEgU0VW
IEVTIEdIQ0IgTVNSIGZvciBTTlAgZ3Vlc3QKPj4gdG8gY29tbXVuaWNhdGUgd2l0aCBoeXBlcnZp
c29yLiBNYXAgR0hDQiBwYWdlIGZvciBhbGwKPj4gY3B1cyB0byByZWFkL3dyaXRlIE1TUiByZWdp
c3RlciBhbmQgc3VibWl0IGh2Y2FsbCByZXF1ZXN0Cj4+IHZpYSBHSENCLgo+Pgo+PiBTaWduZWQt
b2ZmLWJ5OiBUaWFueXUgTGFuIDxUaWFueXUuTGFuQG1pY3Jvc29mdC5jb20+Cj4+IC0tLQo+PiAg
IGFyY2gveDg2L2h5cGVydi9odl9pbml0LmMgICAgICAgfCA2MCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0KPj4gICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc2h5cGVydi5oIHwgIDIg
KysKPj4gICBpbmNsdWRlL2FzbS1nZW5lcmljL21zaHlwZXJ2LmggIHwgIDIgKysKPj4gICAzIGZp
bGVzIGNoYW5nZWQsIDYwIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9oeXBlcnYvaHZfaW5pdC5jIGIvYXJjaC94ODYvaHlwZXJ2L2h2X2lu
aXQuYwo+PiBpbmRleCBiYjBhZTRiNWMwMGYuLmRjNzRkMDFjYjg1OSAxMDA2NDQKPj4gLS0tIGEv
YXJjaC94ODYvaHlwZXJ2L2h2X2luaXQuYwo+PiArKysgYi9hcmNoL3g4Ni9oeXBlcnYvaHZfaW5p
dC5jCj4+IEBAIC02MCw2ICs2MCw5IEBAIHN0YXRpYyBpbnQgaHZfY3B1X2luaXQodW5zaWduZWQg
aW50IGNwdSkKPj4gICAJc3RydWN0IGh2X3ZwX2Fzc2lzdF9wYWdlICoqaHZwID0gJmh2X3ZwX2Fz
c2lzdF9wYWdlW3NtcF9wcm9jZXNzb3JfaWQoKV07Cj4+ICAgCXZvaWQgKippbnB1dF9hcmc7Cj4+
ICAgCXN0cnVjdCBwYWdlICpwZzsKPj4gKwl1NjQgZ2hjYl9ncGE7Cj4+ICsJdm9pZCAqZ2hjYl92
YTsKPj4gKwl2b2lkICoqZ2hjYl9iYXNlOwo+IAo+IEFueSByZWFzb24geW91IGNhbid0IHJldXNl
IHRoZSBTRVYtRVMgc3VwcG9ydCBjb2RlIGluIHRoZSBMaW51eCBrZXJuZWw/Cj4gSXQgYWxyZWFk
eSBoYXMgY29kZSB0byBzZXR1cCBHSENCcyBmb3IgYWxsIHZDUFVzLgo+IAo+IEkgc2VlIHRoYXQg
eW91IGRvbid0IG5lZWQgI1ZDIGhhbmRsaW5nIGluIHlvdXIgU05QIFZNcyBiZWNhdXNlIG9mIHRo
ZQo+IHBhcmF2aXNvciBydW5uaW5nIHVuZGVybmVhdGggaXQsIGJ1dCBqdXN0IHJlLXVzaW5nIHRo
ZSBHSENCIHNldHVwIGNvZGUKPiBzaG91bGRuJ3QgYmUgdG9vIGhhcmQuCj4gCgpUaGFua3MgZm9y
IHlvdXIgc3VnZ2VzdGlvbi4gSSB3aWxsIGhhdmUgYSB0cnkgdG8gdXNlIFNFVi1FUyBjb2RlLgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
