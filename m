Return-Path: <SRS0=b5xv=ME=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ECAC07E99
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 09:40:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5C26108B
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 09:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5C26108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1EA00403DB;
	Mon, 12 Jul 2021 09:40:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ZphhfaHZ8g3; Mon, 12 Jul 2021 09:40:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DC6D4403DC;
	Mon, 12 Jul 2021 09:40:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3B2AC001A;
	Mon, 12 Jul 2021 09:40:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E03CC000E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 09:40:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7DDC5600C4
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 09:40:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o3UYOpDh1Sth for <iommu@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 09:40:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B7C4E600B3
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 09:40:27 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id g24so9776009pji.4
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=k4GGfq+hVsQvPEL9sGnkKkX1T5cHEpElvgl+H/D8GGg=;
 b=EkbTRNsENXQloBh/r+302XMpUfivY4n/w5cVp65wMsO8W0nGbNZWXtUpGIviZUFMAy
 hVFPC6f41UQksp8J6hOtkXkI1ILbHE9sNZcJkJnKx0RudbrlBVNOQLGk52plindDLFMf
 0HidNEe5dnhfekaP3FOVdL3ce/SvQgBj9ik/lEvFt5vP9q7wJ5ZuDvmEpmvcF5JRom1t
 2eapWgs0Md02bchF5N+TVdbkrIOrWMIsIpK0TzcTloe094d/by9NBbGKhQB62sMXf/ds
 jqItDVYo/8NVUWioCBvu/2MyBq3LvV1RB8PjsNypw3SWcxG1OHtv43K0i0bJE0RuT+wZ
 vSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k4GGfq+hVsQvPEL9sGnkKkX1T5cHEpElvgl+H/D8GGg=;
 b=J7PH4ItU3q5XxShePNTSZQ6IlyeF6zY9hnvVh9M0Um6uQ2uY6We5YcxvHSsK+APOKj
 9rdcALBfaODAnnpb0G6jJFh1KoP8uyPB0uJy0Jl8mmX/WNS1PV2/j420dvUCPFqSIxJa
 IpEAVrwvPf7+2EmYQEr5wvvzxsJgtdCqx2gfRlHtHUhUcUUvnhhCsbXKE3/3b4rI1aOC
 2gosGmoMVSB8l9BXAU4zaz9ZyCUGyVJHZg1qkKnX/4zO6jvudexezuSYWcKKn+yuFzsP
 VM1jnMX2bEv9a8YX0aZc0YJbLGNh7VhltT5c80sIuOhjQ0kTNodzxSpBEsd6zewWo8n7
 tHMw==
X-Gm-Message-State: AOAM533IxelU+kj+0cD8e+Y0k7ZsNQEC5qE7n7EMazXDFImUfUhUoowq
 Ua3J/8xh1ij+Ez+gyuVoTjw=
X-Google-Smtp-Source: ABdhPJwRdZQLr6WcRQHTJmvy3QekS6aYpqqDhr3YMzQ3fQO9CQGmdbyBFz8czGBJt97d+duRqdeEsg==
X-Received: by 2002:a17:90b:4a4d:: with SMTP id
 lb13mr13276916pjb.221.1626082827215; 
 Mon, 12 Jul 2021 02:40:27 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:1a:efea::4b1])
 by smtp.gmail.com with ESMTPSA id
 31sm16879517pgu.17.2021.07.12.02.40.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jul 2021 02:40:26 -0700 (PDT)
Subject: Re: [RFC PATCH V3 08/11] swiotlb: Add bounce buffer remap address
 setting function
From: Tianyu Lan <ltykernel@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
References: <20210530150628.2063957-1-ltykernel@gmail.com>
 <20210530150628.2063957-9-ltykernel@gmail.com>
 <20210607064312.GB24478@lst.de>
 <94038087-a33c-93c5-27bf-7ec1f6f5f0e3@arm.com> <20210614153252.GA1741@lst.de>
 <9e347c4c-d4b9-129c-10d2-0d7ff1b917cc@gmail.com>
Message-ID: <873a6872-e2f5-7c6c-ec57-d21305380cd9@gmail.com>
Date: Mon, 12 Jul 2021 17:40:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9e347c4c-d4b9-129c-10d2-0d7ff1b917cc@gmail.com>
Content-Language: en-US
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, peterz@infradead.org,
 dave.hansen@linux.intel.com, hpa@zytor.com, kys@microsoft.com, will@kernel.org,
 boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, linux-scsi@vger.kernel.org,
 x86@kernel.org, decui@microsoft.com, mingo@redhat.com,
 xen-devel@lists.xenproject.org, jejb@linux.ibm.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, kuba@kernel.org, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, vkuznets@redhat.com,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, sunilmut@microsoft.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, kirill.shutemov@linux.intel.com,
 hannes@cmpxchg.org, cai@lca.pw, akpm@linux-foundation.org, davem@davemloft.net,
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

SGkgQ2hyaXN0b3BoIGFuZCBSb2JpbjoKICAgICAgSSBpbnRyb2R1Y2VkIG5ldyBpbnRlcmZhY2Ug
c2V0X21lbW9yeV9kZWNyeXB0ZWRfbWFwKCkgdG8gaGlkZSBhbGwKdGhlIGh5cGVydmlzb3IgY29k
ZSBiZWhpbmQgaXQgaW4gdGhlIGxhdGVzdCB2ZXJzaW9uLiBJbiBjdXJyZW50IGdlbmVyaWMKY29k
ZSwgb25seSBzd2lvdGxiIGJvdW5jZSBidWZmZXIgbmVlZHMgdG8gYmUgZGVjcnlwdGVkIGFuZCBy
ZW1hcHBlZCBpbiAKdGhlIHNhbWUgdGltZSBhbmQgc28ga2VlcCBzZXRfbWVtb3J5X2RlY3J5cHRl
ZCgpLiBJZiB0aGVyZSB3ZXJlIG1vcmUgCnJlcXVlc3RzIG9mIHNldF9tZW1vcnlfZGVjcnlwdGVk
X21hcCgpIGZvciBvdGhlciBwbGF0Zm9ybSwgd2UgbWF5CnJlcGxhY2Ugc2V0X21lbW9yeV9kZWNy
eXB0ZWQoKSBzdGVwIGJ5IHN0ZXAuIFBsZWFzZSBoYXZlIGEgbG9vay4KICAgICAgIGh0dHBzOi8v
bGttbC5vcmcvbGttbC8yMDIxLzcvNy81NzAKClRoYW5rcy4KCk9uIDYvMTUvMjAyMSAxMToyNCBQ
TSwgVGlhbnl1IExhbiB3cm90ZToKPiBPbiA2LzE0LzIwMjEgMTE6MzIgUE0sIENocmlzdG9waCBI
ZWxsd2lnIHdyb3RlOgo+PiBPbiBNb24sIEp1biAxNCwgMjAyMSBhdCAwMjo0OTo1MVBNICswMTAw
LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+PiBGV0lXLCBJIHRoaW5rIGEgYmV0dGVyIGdlbmVyYWxp
c2F0aW9uIGZvciB0aGlzIHdvdWxkIGJlIGFsbG93aW5nCj4+PiBzZXRfbWVtb3J5X2RlY3J5cHRl
ZCgpIHRvIHJldHVybiBhbiBhZGRyZXNzIHJhdGhlciB0aGFuIGltcGxpY2l0bHkKPj4+IG9wZXJh
dGluZyBpbi1wbGFjZSwgYW5kIGhpZGUgYWxsIHRoZSB2YXJpb3VzIGh5cGVydmlzb3IgaG9va3Mg
YmVoaW5kIAo+Pj4gdGhhdC4KPj4KPj4gWWVzLCBzb21ldGhpbmcgbGlrZSB0aGF0IHdvdWxkIGJl
IGEgZ29vZCBpZGVhLsKgIEFzLWlzCj4+IHNldF9tZW1vcnlfZGVjcnlwdGVkIGlzIGEgcHJldHR5
IGhvcnJpYmx5IEFQSSBhbnl3YXkgZHVlIHRvIHBhc3NpbmcKPj4gdGhlIGFkZHJlc3MgYXMgdm9p
ZCwgYW5kIHRha2luZyBhIHNpemUgcGFyYW1ldGVyIHdoaWxlIGl0IHdvcmtzIGluIHVuaXRzCj4+
IG9mIHBhZ2VzLsKgIFNvIEknZCB2ZXJ5IG11Y2ggd2VsY29tZSBhIG1ham9yIG92ZXJoYXVsIG9m
IHRoaXMgQVBJLgo+Pgo+IAo+IEhpIENocmlzdG9waCBhbmQgUm9iaW46Cj4gIMKgwqDCoMKgVGhh
bmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uIEkgd2lsbCB0cnkgdGhpcyBpZGVhIGluIHRoZSBuZXh0
IAo+IHZlcnNpb24uIEJlc2lkZXMgbWFrZSB0aGUgYWRkcmVzcyB0cmFuc2xhdGlvbiBpbnRvIHNl
dF9tZW1vcnlfCj4gZGVjcnlwdGVkKCkgYW5kIHJldHVybiBhZGRyZXNzLCBkbyB5b3Ugd2FudCB0
byBtYWtlIG90aGVyIGNoYW5nZXMgdG8gdGhlIAo+IEFQSSBpbiBvcmRlciB0byBtYWtlIGl0IG1v
cmUgcmVhc29uYWJsZShlLmcgc2l6ZSBwYXJhbWV0ZXIpPwo+IAo+IFRoYW5rcwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
