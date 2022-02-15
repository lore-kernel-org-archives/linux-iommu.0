Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64546C433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Feb 2022 15:32:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3A6F416EE;
	Tue, 15 Feb 2022 15:32:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vPgtKi509CKH; Tue, 15 Feb 2022 15:32:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8043840997;
	Tue, 15 Feb 2022 15:32:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DE0DC0011;
	Tue, 15 Feb 2022 15:32:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36FECC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 15:32:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 273AC60B1B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 15:32:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bwrfuC3FgqNN for <iommu@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 15:32:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C838960672
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 15:32:42 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id i10so5735209plr.2
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 07:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=FBiiPLPd7+SxOKLK0aIlgBvmX6QhgUZILG2dW+7FR74=;
 b=VahgQg1aE4Q1WwSRu/onKUxVYusoGE7A0NZya041wsiB0hGdWZPSC+YkJF54JCcbV0
 GxboLQcl2O+XxOOI55HQDACuUC4gJF14nUwST4D0X/SDv6IwBWpLjbcMgQ6s7sl2YJYk
 aWWS4HeXlHhWUN/ZuSFJZJ7Ocy1DVg0RkntPRtLnmonVKjuJE/yo5AJ+YwVfpsW4QKhH
 V95rhbfecsSX7EC2sKuuEn1qolUVWHjjz+jp9hlQaWicj4l3coURFekSjwZ86lwSU9VM
 2u4HJ1eNS1nSrETG2qv99BoKVZMcVlzX6bbYvyyRcCeHfZr/rBqgayhrIiEf/xPLweeb
 sqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=FBiiPLPd7+SxOKLK0aIlgBvmX6QhgUZILG2dW+7FR74=;
 b=wcpGUU1ZbTEu4nc2Cjs62pKXV/rsdC/G/J1DF7suLS6NSaf1LYMcxU1PDNYjxiXS3k
 PZZdxU/DtXJDwPyRMVPzSjEFm2Vu5RNRmkwJtm7twWWVQNwuj5BqKx4sjgP118ChxZlT
 nC6k+Fp4/QNxFScbr82mBpVqLzdHPi4Z9sb1eZu9kFy4M6CPUGGNth8Ujrle15/QQjeA
 nTC1YXTy0LRa8om9ny1qekCcMTgVTO+4qLBxauDLolb6+ZtixM3/ugx7gJQ+Zq53zCFA
 u4RytlA/T7O1BGtgya7BfdeGz9DGo0DX3IhjHPizBXBDUHooCs0ty/UwrQJUZD6iwSD/
 7FOQ==
X-Gm-Message-State: AOAM531pz5R9CP2W0Fn62lnJhctwTgUUBU8ycWbvPcFLzp7tErSaj2RZ
 CL0yWYByUecmOy2po0hREgY=
X-Google-Smtp-Source: ABdhPJyeBo29foNKLBgSDKrg7awYd2jwbDbxYcS+BFn21/cqlDPFYCebhzbjY4jE9940TBqU6OXztA==
X-Received: by 2002:a17:90b:4c8a:: with SMTP id
 my10mr4871894pjb.97.1644939162155; 
 Tue, 15 Feb 2022 07:32:42 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::754? ([2404:f801:9000:18:efec::754])
 by smtp.gmail.com with ESMTPSA id
 g6sm20301632pfv.158.2022.02.15.07.32.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Feb 2022 07:32:41 -0800 (PST)
Message-ID: <8d052867-ccff-f00f-7c89-cc26a4bfa347@gmail.com>
Date: Tue, 15 Feb 2022 23:32:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V2 1/2] Swiotlb: Add swiotlb_alloc_from_low_pages switch
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
References: <20220209122302.213882-1-ltykernel@gmail.com>
 <20220209122302.213882-2-ltykernel@gmail.com> <20220214081919.GA18337@lst.de>
 <4f433f07-05be-f81f-43e8-55c3f1af23b3@gmail.com>
 <20220214135834.GA30150@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20220214135834.GA30150@lst.de>
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com,
 hch@infradead.org, wei.liu@kernel.org, sthemmin@microsoft.com, x86@kernel.org,
 decui@microsoft.com, michael.h.kelley@microsoft.com, mingo@redhat.com,
 parri.andrea@gmail.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, robin.murphy@arm.com
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

T24gMi8xNC8yMDIyIDk6NTggUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIE1vbiwg
RmViIDE0LCAyMDIyIGF0IDA3OjI4OjQwUE0gKzA4MDAsIFRpYW55dSBMYW4gd3JvdGU6Cj4+IE9u
IDIvMTQvMjAyMiA0OjE5IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4+IEFkZGluZyBh
IGZ1bmN0aW9uIHRvIHNldCB0aGUgZmxhZyBkb2Vzbid0IHJlYWxseSBjaGFuZ2UgbXVjaC4gIEFz
IFJvYmluCj4+PiBwb2ludGVkIG91dCBsYXN0IHRpbWUgeW91IHNob3VsZCBmaW5lIGEgd2F5IHRv
IGp1c3QgY2FsbAo+Pj4gc3dpb3RsYl9pbml0X3dpdGhfdGJsIGRpcmVjdGx5IHdpdGggdGhlIG1l
bW9yeSBhbGxvY2F0ZWQgdGhlIHdheSB5b3UKPj4+IGxpa2UgaXQuICBPciBnaXZlbiB0aGF0IHdl
IGhhdmUgcXVpdGUgYSBmZXcgb2YgdGhlc2UgdHJ1c3RlZCBoeXBlcnZpc29yCj4+PiBzY2hlbWVz
IG1heWJlIGFkZCBhbiBhcmd1bWVudCB0byBzd2lvdGxiX2luaXQgdGhhdCBzcGVjaWZpZXMgaG93
IHRvCj4+PiBhbGxvY2F0ZSB0aGUgbWVtb3J5Lgo+Pgo+PiBUaGFua3MgZm9yIHlvdXIgc3VnZ2Vz
dGlvbi4gSSB3aWxsIHRyeSB0aGUgZmlyc3QgYXBwcm9hY2ggZmlyc3QgYXBwcm9hY2guCj4gCj4g
VGFrZSBhIGxvb2sgYXQgdGhlIFNXSU9UTEJfQU5ZIGZsYWcgaW4gdGhpcyBXSVAgYnJhbmNoOgo+
IAo+ICAgICBodHRwOi8vZ2l0LmluZnJhZGVhZC5vcmcvdXNlcnMvaGNoL21pc2MuZ2l0L3Nob3J0
bG9nL3JlZnMvaGVhZHMvc3dpb3RsYi1pbml0LWNsZWFudXAKPiAKPiBUaGF0IGJlaW5nIHNhaWQg
SSdtIG5vdCBzdXJlIHRoYXQgZWl0aGVyIHRoaXMgZmxhZyBvciB0aGUgZXhpc3RpbmcgcG93ZXJw
Ywo+IGNvZGUgadGVIGFjdHVhbGx5IHRoZSByaWdodCB0aGluZyB0byBkby4gIFdlIHN0aWxsIG5l
ZWQgdGhlIDRHIGxpbWl0ZWQKPiBidWZmZXIgdG8gc3VwcG9ydCBkZXZpY2VzIHdpdGggYWRkcmVz
c2luZyBsaW1pdGF0aW9ucy4gIFNvIEkgdGhpbmsgd2UgbmVlZAo+IGFuIGFkZGl0aW9uYWwgaW9f
dGxiX21lbSBpbnN0YW5jZSBmb3IgdGhlIGRldmljZXMgd2l0aG91dCBhZGRyZXNzaW5nCj4gbGlt
aXRhdGlvbnMgaW5zdGVhZC4KPiAKCkhpIENocmlzdG9waDoKICAgICAgVGhhbmtzIGZvciB5b3Vy
IHBhdGNoZXMuIEkgdGVzdGVkIHRoZXNlIHBhdGNoZXMgaW4gSHlwZXItViB0cnVzdGVkIApWTSBh
bmQgc3lzdGVtIGNhbid0IGJvb3QgdXAuIEkgYW0gZGVidWdnaW5nIGFuZCB3aWxsIHJlcG9ydCBi
YWNrLgoKCgkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
