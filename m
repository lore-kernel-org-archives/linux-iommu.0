Return-Path: <SRS0=tZpB=NH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E4AC4338F
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 14:50:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4AB6056B
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 14:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F4AB6056B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 677984027A;
	Mon, 16 Aug 2021 14:50:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BLMtMaiINdUk; Mon, 16 Aug 2021 14:50:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 420A840234;
	Mon, 16 Aug 2021 14:50:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14FEEC0010;
	Mon, 16 Aug 2021 14:50:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EB74C000E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 14:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2FFD5402D8
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 14:50:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O9kZU4N_FJhb for <iommu@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 14:50:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F254040234
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 14:50:42 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id n5so6429675pjt.4
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WJWFiW1tNTGnEXAY83sW/96pfLutJ+nc92p/dxWLkZg=;
 b=NXbT1zLrDuMqskh2PkrXNK2vbCTKyrRJCbfTY5Bly9fYQ/XU0SfRcVq5Opg7hJuYPq
 WAHFOfTPq1K1gGqDqCEl7LfXOVRnVK+Trx+MMYCG7OPlcmQ484293t+hm2eNoNgWwPWn
 FMa4FwwJpv6nh2ij8bhxvHhBGoaIurIFplj7wnpKTSuRMnyldRdPcAWWcSmd+W7oZuoa
 90O5BmPR7Iyg7k9vnQyRNKKQWgQWCvIDkqkqBKagNtE87pOxDe8b9ZAS8kRj2RhhMem8
 RcODv8S8rQQKapLBdjj/yipP4YK2d1vrMKq6Wk4vAH1jeB7D9R7aSg32dzMV4dgTGHNn
 cHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WJWFiW1tNTGnEXAY83sW/96pfLutJ+nc92p/dxWLkZg=;
 b=nJoubkhfbMQe9kogXD/+06lPA0GmkQSvnqY39oueWDrFuMeDXWK4U45p6rpp9r0nQt
 0cSSBknss+jO9C7rZiaVUUG9Ro4qAzId4pdeY+tZ/+M5XBl9tkGa1JUv+WRS76N3DWed
 lWsBsRV+6ns0msQ5m5bgbSfliCJCoDz5KUIbbevvHwtcun1yyu7A/i2yeEABvwFAmFzS
 YE80/ZhoPFuXCeuGWhoqnxJDJ+ruCuunk1osbOa5EJiPnlSx5FIVuN0XRkaMDK+WzTG5
 TfvZK0K9hLsCYOOnIkIPN6VpSLnXe7J61RNiln9iT7ae3TQNWrgF/z17lViifi11GF5T
 qfgw==
X-Gm-Message-State: AOAM530yJmBhK7ubac92VoQ9VYYPHVd7JUxyoXe/2/V/nPyBswssffNS
 ROmwAe03hqwP9Zr09hWNl1I=
X-Google-Smtp-Source: ABdhPJwwGaWbF5lMH7zWG8CjOdMFhlJFveeUXJRyURV3wu36AAVQm0z4EMghAqWltWQj3nIzdJtriw==
X-Received: by 2002:a17:90b:3014:: with SMTP id
 hg20mr17976900pjb.140.1629125442297; 
 Mon, 16 Aug 2021 07:50:42 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::50b? ([2404:f801:9000:18:efec::50b])
 by smtp.gmail.com with ESMTPSA id
 z2sm6264141pgb.33.2021.08.16.07.50.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Aug 2021 07:50:41 -0700 (PDT)
Subject: Re: [PATCH V3 10/13] x86/Swiotlb: Add Swiotlb bounce buffer remap
 function for HV IVM
From: Tianyu Lan <ltykernel@gmail.com>
To: Christoph Hellwig <hch@lst.de>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-11-ltykernel@gmail.com>
 <20210812122741.GC19050@lst.de>
 <d18ae061-6fc2-e69e-fc2c-2e1a1114c4b4@gmail.com>
Message-ID: <890e5e21-714a-2db6-f68a-6211a69bebb9@gmail.com>
Date: Mon, 16 Aug 2021 22:50:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d18ae061-6fc2-e69e-fc2c-2e1a1114c4b4@gmail.com>
Content-Language: en-US
Cc: parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 peterz@infradead.org, dave.hansen@linux.intel.com, dave.hansen@intel.com,
 hpa@zytor.com, kys@microsoft.com, will@kernel.org, boris.ostrovsky@oracle.com,
 linux-arch@vger.kernel.org, sfr@canb.auug.org.au, wei.liu@kernel.org,
 sstabellini@kernel.org, sthemmin@microsoft.com, xen-devel@lists.xenproject.org,
 linux-scsi@vger.kernel.org, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 decui@microsoft.com, ardb@kernel.org, michael.h.kelley@microsoft.com,
 mingo@redhat.com, pgonda@google.com, rientjes@google.com, kuba@kernel.org,
 jejb@linux.ibm.com, martin.b.radev@gmail.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, arnd@arndb.de, konrad.wilk@oracle.com,
 haiyangz@microsoft.com, bp@alien8.de, luto@kernel.org,
 krish.sadhukhan@oracle.com, tglx@linutronix.de, vkuznets@redhat.com,
 jgross@suse.com, martin.petersen@oracle.com, saravanand@fb.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, rppt@kernel.org, hannes@cmpxchg.org,
 tj@kernel.org, akpm@linux-foundation.org, robin.murphy@arm.com,
 davem@davemloft.net, kirill.shutemov@linux.intel.com
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

T24gOC8xNC8yMDIxIDE6NTggQU0sIFRpYW55dSBMYW4gd3JvdGU6Cj4gT24gOC8xMi8yMDIxIDg6
MjcgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+PiBUaGlzIGlzIHN0aWxsIGJyb2tlbi7C
oCBZb3UgbmVlZCB0byBtYWtlIHN1cmUgdGhlIGFjdHVhbCBETUEgYWxsb2NhdGlvbnMKPj4gZG8g
aGF2ZSBzdHJ1Y3QgcGFnZSBiYWNraW5nLgo+Pgo+IAo+IEhpIENocmlzdG9waDoKPiAgwqDCoMKg
wqAgc3dpb3RsYl90YmxfbWFwX3NpbmdsZSgpIHN0aWxsIHJldHVybnMgUEEgYmVsb3cgdlRPTS9z
aGFyZV9ncGFfID4gYm91bmRhcnkuIFRoZXNlIFBBcyBoYXMgYmFja2luZyBwYWdlcyBhbmQgYmVs
b25nIHRvIHN5c3RlbSBtZW1vcnkuCj4gSW4gb3RoZXIgd29yZCwgYWxsIFBBcyBwYXNzZWQgdG8g
RE1BIEFQSSBoYXZlIGJhY2tpbmcgcGFnZXMgYW5kIHRoZXNlIGlzIAo+IG5vIGRpZmZlcmVuY2Ug
YmV0d2VlbiBJc29sYXRpb24gZ3Vlc3QgYW5kIHRyYWRpdGlvbmFsIGd1ZXN0IGZvciBETUEgQVBJ
Lgo+IFRoZSBuZXcgbWFwcGVkIFZBIGZvciBQQSBhYm92ZSB2VE9NIGhlcmUgaXMganVzdCB0byBh
Y2Nlc3MgdGhlIGJvdW5jZSAKPiBidWZmZXIgaW4gdGhlIHN3aW90bGIgY29kZSBhbmQgaXNuJ3Qg
ZXhwb3NlZCB0byBvdXRzaWRlLgoKSGkgQ2hyaXN0b3BoOgogICAgICAgU29ycnkgdG8gYm90aGVy
IHlvdS5QbGVhc2UgZG91YmxlIGNoZWNrIHdpdGggdGhlc2UgdHdvIHBhdGNoZXMKIiBbUEFUQ0gg
VjMgMTAvMTNdIHg4Ni9Td2lvdGxiOiBBZGQgU3dpb3RsYiBib3VuY2UgYnVmZmVyIHJlbWFwIGZ1
bmN0aW9uIApmb3IgSFYgSVZNIiBhbmQgIltQQVRDSCBWMyAwOS8xM10gRE1BOiBBZGQgZG1hX21h
cF9kZWNyeXB0ZWQvZG1hXwp1bm1hcF9lbmNyeXB0ZWQoKSBmdW5jdGlvbiIuCiAgICAgICBUaGUg
c3dpb3RsYiBib3VuY2UgYnVmZmVyIGluIHRoZSBpc29sYXRpb24gVk0gYXJlIGFsbG9jYXRlZCBp
biB0aGUKbG93IGVuZCBtZW1vcnkgYW5kIHRoZXNlIG1lbW9yeSBoYXMgc3RydWN0IHBhZ2UgYmFj
a2luZy4gQWxsIGRtYSBhZGRyZXNzCnJldHVybmVkIGJ5IHN3aW90bGIvRE1BIEFQSSBhcmUgbG93
IGVuZCBtZW1vcnkgYW5kIHRoaXMgaXMgYXMgc2FtZSBhcyAKd2hhdCBoYXBwZW4gaW4gdGhlIHRy
YWRpdGlvbmFsIFZNLlNvIHRoaXMgbWVhbnMgYWxsIFBBcyBwYXNzZWQgdG8gRE1BIApBUEkgaGF2
ZSBzdHJ1Y3QgcGFnZSBiYWNraW5nLiBUaGUgZGlmZmVyZW5jZSBpbiBJc29sYXRpb24gVk0gaXMg
dG8gCmFjY2VzcyBib3VuY2UgYnVmZmVyIHZpYSBhZGRyZXNzIHNwYWNlIGFib3ZlIHZUT00vc2hh
cmVkX2d1ZXN0X21lbW9yeQpfYm91bmRhcnkuIFRvIGFjY2VzcyBib3VuY2UgYnVmZmVyIHNoYXJl
ZCB3aXRoIGhvc3QsIHRoZSBndWVzdCBuZWVkcyB0bwptYXJrIHRoZSBtZW1vcnkgdmlzaWJsZSB0
byBob3N0IHZpYSBoeXBlcmNhbGwgYW5kIG1hcCBib3VuY2UgYnVmZmVyIGluIAp0aGUgZXh0cmEg
YWRkcmVzcyBzcGFjZShQQSArIHNoYXJlZF9ndWVzdF9tZW1vcnlfYm91bmRhcnkpLiBUaGUgdnN0
YXJ0CmludHJvZHVjZWQgaW4gdGhpcyBwYXRjaCBpcyB0byBzdG9yZSB2YSBvZiBleHRyYSBhZGRy
ZXNzIHNwYWNlIGFuZCBpdCdzIApvbmx5IHVzZWQgdG8gYWNjZXNzIGJvdW5jZSBidWZmZXIgaW4g
dGhlIHN3aW90bGJfYm91bmNlKCkuIFRoZSBQQSBpbiAKZXh0cmEgc3BhY2UgaXMgb25seSBpbiB0
aGUgSHlwZXItViBtYXAgZnVuY3Rpb24gYW5kIHdvbid0IGJlIHBhc3NlZCB0byAKRE1BIEFQSSBv
ciBvdGhlciBjb21wb25lbnRzLgogICAgICAgVGhlIEFQSSBkbWFfbWFwX2RlY3J5cHRlZCgpIGlu
dHJvZHVjZWQgaW4gdGhlIHBhdGNoIDkgaXMgdG8gbWFwIAp0aGUgYm91bmNlIGJ1ZmZlciBpbiB0
aGUgZXh0cmEgc3BhY2UgYW5kIHRoZXNlIG1lbW9yeSBpbiB0aGUgbG93IGVuZCAKc3BhY2UgYXJl
IHVzZWQgYXMgRE1BIG1lbW9yeSBpbiB0aGUgZHJpdmVyLiBEbyB5b3UgcHJlZmVyIHRoZXNlIEFQ
SXMKc3RpbGwgaW4gdGhlIHNldF9tZW1vcnkuYz8gSSBtb3ZlIHRoZSBBUEkgdG8gZG1hL21hcHBp
bmcuYyBkdWUgdG8gdGhlCnN1Z2dlc3RlZCBuYW1lIGFyY2hfZG1hX21hcF9kZWNyeXB0ZWQoKSBp
biB0aGUgcHJldmlvdXMgbWFpbAooaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjEw
NzIwMTM1NDM3LkdBMTM1NTRAbHN0LmRlLykuCiAgICAgICBJZiB0aGVyZSBhcmUgc29tZXRoaW5n
IHVuY2xlYXIsIHBsZWFzZSBsZXQgbWUga25vdy4gSG9wZSB0aGlzCnN0aWxsIGNhbiBjYXRjaCB0
aGUgbWVyZ2Ugd2luZG93LgoKVGhhbmtzLgoKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
