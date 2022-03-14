Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF46C433F5
	for <iommu@archiver.kernel.org>; Mon, 14 Mar 2022 10:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA52260EAF;
	Mon, 14 Mar 2022 10:37:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8zllBBa0fJqP; Mon, 14 Mar 2022 10:37:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 61EFC60D4E;
	Mon, 14 Mar 2022 10:37:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44049C0033;
	Mon, 14 Mar 2022 10:37:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83376C0012
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 10:37:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 72698410B3
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 10:37:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WbKwlOaP67Ph for <iommu@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 10:37:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A2FC410A7
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 10:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647254241;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eum59AlCLQDv1izwNFq3yujGas6YkpJfse8C8gTNsNo=;
 b=NITqk+4VPBY1Z6iKUYQKBzTyXWha73GJoR0/XfIEQjpOM8fLJUHIrC+v3YAaT1kQLJYowK
 TWjdrVBwxilJnALHnzQa4ZBWhNP0d7O0z4Sdb6Wma6D9BnwPhJ6p1uL2q4vx74jGifj02Q
 XKlt7QxvjQbA/cSJ/E82LGakFsaqWUA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-uac5FE65PQS8umkUNgbQ3g-1; Mon, 14 Mar 2022 06:37:18 -0400
X-MC-Unique: uac5FE65PQS8umkUNgbQ3g-1
Received: by mail-wm1-f71.google.com with SMTP id
 14-20020a05600c104e00b003897a167353so6859462wmx.8
 for <iommu@lists.linux-foundation.org>; Mon, 14 Mar 2022 03:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=Eum59AlCLQDv1izwNFq3yujGas6YkpJfse8C8gTNsNo=;
 b=1UdTEzyJofzpAmMblzpuQ4SeS4/2quEzWCgxIT+qjNFvs43TuMfxYutkN9nmbNe5vV
 1lhaUC2qE0wijqcRc0Uo93H+D5n7mUcwXoJG/pK1R8su6CYjQ2vixndfe2nMCJy+mxIw
 BHvofulyT1mIMI5wyr7S2a5b8Wv5x61Ow72jq2uaeB0/7PzITaDsOinbcrc+mN2wvVFx
 CU+98lo0cIq+oL91x0JBnJoMaZgdKPd5JSxXn1Hyj+sEOUexUODx/2XSgv4zdKw6La00
 HsqkFIbGaN4Nlt3bPtsfk0eq5nqYSTDbPy8hyqyLuIOCTprGMlgK30DPTqxeOkdb24V0
 eZzQ==
X-Gm-Message-State: AOAM533ZdxiBXbV08LiQDu1WLsNoFgglOq0v4EwbHpY+QGJiMsnrFB1j
 EM5XyDPJVkQ6dDYLBq6H9xBmqldOu1C1YycRNRwAoQbkukyAD19a1a8W+hiiul52dLrKqlGQXPR
 KUe93BcPBvjqKkshjWiMiUbFewE3/5w==
X-Received: by 2002:a5d:4c4a:0:b0:1f1:e43d:c9ba with SMTP id
 n10-20020a5d4c4a000000b001f1e43dc9bamr15380535wrt.677.1647254237515; 
 Mon, 14 Mar 2022 03:37:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF/CGT+ct1fm4AulzqBynDof0pe020GC5uIxZZ4dr5LW1S+8KQ+a57HeTNKk9wU6j27VMCmQ==
X-Received: by 2002:a5d:4c4a:0:b0:1f1:e43d:c9ba with SMTP id
 n10-20020a5d4c4a000000b001f1e43dc9bamr15380516wrt.677.1647254237202; 
 Mon, 14 Mar 2022 03:37:17 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 k14-20020a5d518e000000b002019c7402aasm12915234wrv.25.2022.03.14.03.37.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Mar 2022 03:37:16 -0700 (PDT)
Subject: Re: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
To: Robin Murphy <robin.murphy@arm.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Ard Biesheuvel <ardb@kernel.org>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <bb3688c7-8f42-039e-e22f-6529078da97d@redhat.com>
 <8ecce421-e2ee-1a19-ae2d-a8454a8a5844@arm.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <0cde239c-8d30-33a8-6e5b-792e30e20462@redhat.com>
Date: Mon, 14 Mar 2022 11:37:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <8ecce421-e2ee-1a19-ae2d-a8454a8a5844@arm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
 will@kernel.org, wanghuiqiang@huawei.com
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgUm9iaW4KCk9uIDMvMTEvMjIgMTE6MzQgQU0sIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAy
MDIyLTAzLTExIDA4OjE5LCBFcmljIEF1Z2VyIHdyb3RlOgo+PiBIaSBndXlzLAo+Pgo+PiBPbiAy
LzIxLzIyIDQ6NDMgUE0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6Cj4+PiBIaSwKPj4+Cj4+PiBT
aW5jZSB3ZSBub3cgaGF2ZSBhbiB1cGRhdGVkIHZlcmlvblswXSBvZiBJT1JUIHNwZWMoRS5kKSB3
aGljaAo+Pj4gYWRkcmVzc2VzIHRoZSBtZW1vcnkgYXR0cmlidXRlcyBpc3N1ZXMgZGlzY3Vzc2Vk
IGhlcmUgWzFdLAo+Pj4gdGhpcyBzZXJpZXMgbm93IG1ha2UgdXNlIG9mIGl0Lgo+Pj4KPj4+IFRo
ZSBwdWxsIHJlcXVlc3QgZm9yIEFDUElDQSBFLmQgcmVsYXRlZCBjaGFuZ2VzIGFyZSBhbHJlYWR5
Cj4+PiByYWlzZWQgYW5kIGNhbiBiZSBmb3VuZCBoZXJlLAo+Pj4gaHR0cHM6Ly9naXRodWIuY29t
L2FjcGljYS9hY3BpY2EvcHVsbC83NTIKPj4+Cj4+PiB2NyAtLT4gdjgKPj4+IMKgwqAgLSBQYXRj
aCAjMSBoYXMgdGVtcCBkZWZpbml0aW9ucyBmb3IgUk1SIHJlbGF0ZWQgY2hhbmdlcyB0aWxsCj4+
PiDCoMKgwqDCoCB0aGUgQUNQSUNBIGhlYWRlciBjaGFuZ2VzIGFyZSBwYXJ0IG9mIGtlcm5lbC4K
Pj4+IMKgwqAgLSBObyBlYXJseSBwYXJzaW5nIG9mIFJNUiBub2RlIGluZm8gYW5kIGlzIG9ubHkg
cGFyc2VkIGF0IHRoZQo+Pj4gwqDCoMKgwqAgdGltZSBvZiB1c2UuCj4+PiDCoMKgIC0gQ2hhbmdl
cyB0byB0aGUgUk1SIGdldC9wdXQgQVBJIGZvcm1hdCBjb21wYXJlZCB0byB0aGUKPj4+IMKgwqDC
oMKgIHByZXZpb3VzIHZlcnNpb24uCj4+PiDCoMKgIC0gU3VwcG9ydCBmb3IgUk1SIGRlc2NyaXB0
b3Igc2hhcmVkIGJ5IG11bHRpcGxlIHN0cmVhbSBJRHMuCj4+Pgo+Pj4gUGxlYXNlIHRha2UgYSBs
b29rIGFuZCBsZXQgbWUga25vdyB5b3VyIHRob3VnaHRzLgo+Pj4KPj4+IFRoYW5rcywKPj4+IFNo
YW1lZXIKPj4+IFswXSBodHRwczovL2RldmVsb3Blci5hcm0uY29tL2RvY3VtZW50YXRpb24vZGVu
MDA0OS9lZC8KPj4gSSBzdGlsbCBoYXZlIGEgcXVlc3Rpb24gb24gdGhlIElPUlQgRS5kIHNwZWMg
KHVucmVsYXRlZCB0byB0aGlzIHNlcmllcykuCj4+Cj4+IFRoZSBzcGVjIG1hbmRhdGVzIHRoYXQg
aWYgUk1SIG5vZGVzIGFyZSBwcmVzZW50ZWQgaW4gdGhlIElPUlQsCj4+IF9EU00gZnVuY3Rpb24g
IzUgZm9yIHRoZSBQQ0llIGhvc3QgYnJpZGdlIEFDUEkgZGV2aWNlIG9iamVjdCBtdXN0IHJldHVy
bgo+PiAwLCBpbmRpY2F0aW5nIHRoZSBPUyBtdXN0IGhvbm91ciB0aGUgUENJIGNvbmZpZyB0aGF0
IHRoZSBGVyBjb21wdXRlZCBhdAo+PiBib290IHRpbWUuCj4+Cj4+IEhvd2V2ZXIgaW1wbGVtZW50
aW5nIHRoaXMgX0RTTSAjNSBhcyBhYm92ZSBpcyBrbm93biB0byBwcmV2ZW50IFBDSQo+PiBkZXZp
Y2VzIHdpdGggSU8gcG9ydHMgZnJvbSB3b3JraW5nLCBvbiBhYXJjaDY0IGxpbnV4Lgo+Pgo+PiAi
Cj4+IFRoZSByZWFzb24gaXMgdGhhdCBFRkkgY3JlYXRlcyBJL08gcG9ydCBtYXBwaW5ncyBiZWxv
dwo+PiDCoMKgwqDCoCAweDEwMDAgKGluIGZhY3QsIGF0IDApLiBIb3dldmVyIExpbnV4LCBmb3Ig
bGVnYWN5IHJlYXNvbnMsIGRvZXMgbm90Cj4+IMKgwqDCoMKgIHN1cHBvcnQgSS9PIHBvcnRzIDw9
IDB4MTAwMCBvbiBQQ0ksIHNvIHRoZSBJL08gYXNzaWdubWVudAo+PiBjcmVhdGVkIGJ5IEVGSQo+
PiDCoMKgwqDCoCBpcyByZWplY3RlZC4KPj4gwqDCoMKgIMKgwqDCoMKgIEVGSSBjcmVhdGVzIHRo
ZSBtYXBwaW5ncyBwcmltYXJpbHkgZm9yIGl0c2VsZiwgYW5kIHVwIHVudGlsCj4+IERTTSAjNQo+
PiDCoMKgwqDCoCBzdGFydGVkIHRvIGJlIGVuZm9yY2VkLCBhbGwgUENJIHJlc291cmNlIGFsbG9j
YXRpb25zIHRoYXQKPj4gZXhpc3RlZCBhdAo+PiDCoMKgwqDCoCBib290IHdlcmUgaWdub3JlZCBi
eSBMaW51eCBhbmQgcmVjcmVhdGVkIGZyb20gc2NyYXRjaC4KPj4gIgo+Pgo+PiBUaGlzIGlzIGFu
IGV4Y2VycHQgb2YgYSBxZW11IGNvbW1pdCBtZXNzYWdlIHRoYXQgcmV2ZXJ0ZWQgdGhlIF9ETVMg
IzUKPj4gY2hhbmdlIChSZXZlcnQgImFjcGkvZ3BleDogSW5mb3JtIG9zIHRvIGtlZXAgZmlybXdh
cmUgcmVzb3VyY2UgbWFwIikuCj4+IEhhcyB0aGUgc2l0dWF0aW9uIGNoYW5nZWQgc2luY2UgSnVs
eSAyMDIxIChpZS4gaGFzIFVFRkkgYmVlbiByZXdvcmtlZD8pLgo+PiBbKyBBcmRdCj4KPiBGV0lX
IEkgd2Fzbid0IGF3YXJlIG9mIHRoYXQsIGJ1dCBpZiBpdCdzIGFuIGlzc3VlIHRoZW4gaXQgd2ls
bCBuZWVkIHRvCj4gYmUgZml4ZWQgaW4gTGludXggb3IgVUVGSSdzIFBDSSByZXNvdXJjZSBjb2Rl
IChhcmd1YWJseSBpZiBVRUZJIGhhcwo+IGFscmVhZHkgYWxsb2NhdGVkIGZyb20gdGhlIGJvdHRv
bSBvZiBJL08gc3BhY2UgdGhlbiBMaW51eCBzaG91bGQgYmUKPiBzYWZlIHRvIGFzc3VtZSB0aGF0
IHRoZXJlIGFyZSBubyBsZWdhY3kgUEMgSS9PIHJlc291cmNlcyB0byB3b3JyeQo+IGFib3V0KS4g
VGhlIERTTSBpcyByZXF1aXJlZCB0byBwcmV2ZW50IGJ1cyBudW1iZXJzIGJlaW5nIHJlYXNzaWdu
ZWQsCj4gYmVjYXVzZSBpZiB0aGF0IGhhcHBlbnMgdGhlbiBhbnkgUENJIFN0cmVhbUlEcyByZWZl
cmVuY2VkIGluIElPUlQgbWF5Cj4gc3VkZGVubHkgYmVjb21lIG1lYW5pbmdsZXNzIGFuZCB0aGUg
YXNzb2NpYXRpb24gb2Ygcm9vdCBjb21wbGV4IG5vZGVzCj4gYW5kIFJNUnMgdG8gcGh5c2ljYWwg
aGFyZHdhcmUgbG9zdC4KClRoYW5rIHlvdSBmb3IgY29uZmlybWluZyBhbmQgZXhwbGFpbmluZyB0
aGUgbmVlZCBmb3IgRFNNICM1LiBBcmQsIHBsZWFzZQpjb3VsZCB5b3UgY29uZmlybSB0aGF0IHRo
ZSBpbmNvbXBhdGliaWxpdHkgd2l0aCBQQ0kgZGV2aWNlcyB3aXRoIElPCnBvcnRzIGlzIHN0aWxs
IHRoZXJlPwoKRXJpYwoKPgo+IFJvYmluLgo+Cj4+IFRoYW5rIHlvdSBpbiBhZHZhbmNlCj4+Cj4+
IFJlZ2FyZHMKPj4KPj4gRXJpYwo+Pgo+Pgo+Pgo+Pgo+Pj4gWzFdCj4+PiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1hY3BpLzIwMjEwODA1MTYwMzE5LkdCMjMwODVAbHBpZXJhbGlzaS8K
Pj4+Cj4+PiDCoEZyb20gb2xkOgo+Pj4gV2UgaGF2ZSBmYWNlZCBpc3N1ZXMgd2l0aCAzNDA4aU1S
IFJBSUQgY29udHJvbGxlciBjYXJkcyB3aGljaAo+Pj4gZmFpbCB0byBib290IHdoZW4gU01NVSBp
cyBlbmFibGVkLiBUaGlzIGlzIGJlY2F1c2UgdGhlc2UKPj4+IGNvbnRyb2xsZXJzIG1ha2UgdXNl
IG9mIGhvc3QgbWVtb3J5IGZvciB2YXJpb3VzIGNhY2hpbmcgcmVsYXRlZAo+Pj4gcHVycG9zZXMg
YW5kIHdoZW4gU01NVSBpcyBlbmFibGVkIHRoZSBpTVIgZmlybXdhcmUgZmFpbHMgdG8KPj4+IGFj
Y2VzcyB0aGVzZSBtZW1vcnkgcmVnaW9ucyBhcyB0aGVyZSBpcyBubyBtYXBwaW5nIGZvciB0aGVt
Lgo+Pj4gSU9SVCBSTVIgcHJvdmlkZXMgYSB3YXkgZm9yIFVFRkkgdG8gZGVzY3JpYmUgYW5kIHJl
cG9ydCB0aGVzZQo+Pj4gbWVtb3J5IHJlZ2lvbnMgc28gdGhhdCB0aGUga2VybmVsIGNhbiBtYWtl
IGEgdW5pdHkgbWFwcGluZyBmb3IKPj4+IHRoZXNlIGluIFNNTVUuCj4+Pgo+Pj4gQ2hhbmdlIEhp
c3Rvcnk6Cj4+Pgo+Pj4gdjYgLS0+IHY3Cj4+PiDCoCAtZml4IHBvaW50ZWQgb3V0IGJ5IFN0ZXZl
IHRvIHRoZSBTTU1VdjIgU01SIGJ5cGFzcyBpbnN0YWxsIGluCj4+PiBwYXRjaCAjOC4KPj4+Cj4+
PiB2NSAtLT4gdjYKPj4+IC0gQWRkcmVzc2VkIGNvbW1lbnRzIGZyb20gUm9iaW4gJiBMb3Jlbnpv
Lgo+Pj4gwqDCoCA6IE1vdmVkIGlvcnRfcGFyc2Vfcm1yKCkgdG8gYWNwaV9pb3J0X2luaXQoKSBm
cm9tCj4+PiDCoMKgwqDCoCBpb3J0X2luaXRfcGxhdGZvcm1fZGV2aWNlcygpLgo+Pj4gwqDCoCA6
IFJlbW92ZWQgdXNlIG9mIHN0cnVjdCBpb3J0X3Jtcl9lbnRyeSBkdXJpbmcgdGhlIGluaXRpYWwK
Pj4+IMKgwqDCoMKgIHBhcnNlLiBVc2luZyBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gaW5zdGVh
ZC4KPj4+IMKgwqAgOiBSZXBvcnQgUk1SIGFkZHJlc3MgYWxpZ25tZW50IGFuZCBvdmVybGFwIGVy
cm9ycywgYnV0IGNvbnRpbnVlLgo+Pj4gwqDCoCA6IFJld29ya2VkIGFybV9zbW11X2luaXRfYnlw
YXNzX3N0ZXMoKSAocGF0Y2ggIyA2KS4KPj4+IC0gVXBkYXRlZCBTTU1VdjIgYnlwYXNzIFNNUiBj
b2RlLiBUaGFua3MgdG8gSm9uIE4gKHBhdGNoICM4KS4KPj4+IC0gU2V0IElPTU1VIHByb3RlY3Rp
b24gZmxhZ3MoSU9NTVVfQ0FDSEUsIElPTU1VX01NSU8pIGJhc2VkCj4+PiDCoMKgIG9uIFR5cGUg
b2YgUk1SIHJlZ2lvbi4gU3VnZ2VzdGVkIGJ5IEpvbiBOLgo+Pj4KPj4+IHY0IC0tPiB2NQo+Pj4g
wqAgLUFkZGVkIGEgZndfZGF0YSB1bmlvbiB0byBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gYW5k
IHJlbW92ZWQKPj4+IMKgwqAgc3RydWN0IGlvbW11X3JtciAoQmFzZWQgb24gY29tbWVudHMgZnJv
bSBKb2VyZy9Sb2JpbikuCj4+PiDCoCAtQWRkZWQgaW9tbXVfcHV0X3JtcnMoKSB0byByZWxlYXNl
IG1lbS4KPj4+IMKgIC1UaGFua3MgdG8gU3RldmUgZm9yIHZlcmlmeWluZyBvbiBTTU1VdjIsIGJ1
dCBub3QgYWRkZWQgdGhlIFRlc3RlZC1ieQo+Pj4gwqDCoCB5ZXQgYmVjYXVzZSBvZiB0aGUgYWJv
dmUgY2hhbmdlcy4KPj4+Cj4+PiB2MyAtLT52NAo+Pj4gLUluY2x1ZGVkIHRoZSBTTU1VdjIgU01S
IGJ5cGFzcyBpbnN0YWxsIGNoYW5nZXMgc3VnZ2VzdGVkIGJ5Cj4+PiDCoCBTdGV2ZShwYXRjaCAj
NykKPj4+IC1BcyBwZXIgUm9iaW4ncyBjb21tZW50cywgUk1SIHJlc2VydmUgaW1wbGVtZW50YXRp
b24gaXMgbm93Cj4+PiDCoCBtb3JlIGdlbmVyaWPCoCAocGF0Y2ggIzgpIGFuZCBkcm9wcGVkIHYz
IHBhdGNoZXMgOCBhbmQgMTAuCj4+PiAtUmViYXNlIHRvIDUuMTMtcmMxCj4+Pgo+Pj4gUkZDIHYy
IC0tPiB2Mwo+Pj4gwqAgLURyb3BwZWQgUkZDIHRhZyBhcyB0aGUgQUNQSUNBIGhlYWRlciBjaGFu
Z2VzIGFyZSBub3cgcmVhZHkgdG8gYmUKPj4+IMKgwqAgcGFydCBvZiA1LjEzWzBdLiBCdXQgdGhp
cyBzZXJpZXMgc3RpbGwgaGFzIGEgZGVwZW5kZW5jeSBvbiB0aGF0Cj4+PiBwYXRjaC4KPj4+IMKg
IC1BZGRlZCBJT1JUIEUuYiByZWxhdGVkIGNoYW5nZXMobm9kZSBmbGFncywgX0RTTSBmdW5jdGlv
biA1IGNoZWNrcwo+Pj4gZm9yCj4+PiDCoMKgIFBDSWUpLgo+Pj4gwqAgLUNoYW5nZWQgUk1SIHRv
IHN0cmVhbSBpZCBtYXBwaW5nIGZyb20gTTpOIHRvIE06MSBhcyBwZXIgdGhlIHNwZWMgYW5kCj4+
PiDCoMKgIGRpc2N1c3Npb24gaGVyZVsxXS4KPj4+IMKgIC1MYXN0IHR3byBwYXRjaGVzIGFkZCBz
dXBwb3J0IGZvciBTTU1VdjIoVGhhbmtzIHRvIEpvbiBOZXR0bGV0b24hKQo+Pj4KPj4+IEpvbiBO
ZXR0bGV0b24gKDEpOgo+Pj4gwqDCoCBpb21tdS9hcm0tc21tdTogR2V0IGFzc29jaWF0ZWQgUk1S
IGluZm8gYW5kIGluc3RhbGwgYnlwYXNzIFNNUgo+Pj4KPj4+IFNoYW1lZXIgS29sb3RodW0gKDEw
KToKPj4+IMKgwqAgQUNQSS9JT1JUOiBBZGQgdGVtcG9yYXJ5IFJNUiBub2RlIGZsYWcgZGVmaW5p
dGlvbnMKPj4+IMKgwqAgaW9tbXU6IEludHJvZHVjZSBhIHVuaW9uIHRvIHN0cnVjdCBpb21tdV9y
ZXN2X3JlZ2lvbgo+Pj4gwqDCoCBBQ1BJL0lPUlQ6IEFkZCBoZWxwZXIgZnVuY3Rpb25zIHRvIHBh
cnNlIFJNUiBub2Rlcwo+Pj4gwqDCoCBpb21tdS9kbWE6IEludHJvZHVjZSBnZW5lcmljIGhlbHBl
ciB0byByZXRyaWV2ZSBSTVIgaW5mbwo+Pj4gwqDCoCBBQ1BJL0lPUlQ6IEFkZCBhIGhlbHBlciB0
byByZXRyaWV2ZSBSTVIgbWVtb3J5IHJlZ2lvbnMKPj4+IMKgwqAgaW9tbXUvYXJtLXNtbXUtdjM6
IEludHJvZHVjZSBzdHJ0YWIgaW5pdCBoZWxwZXIKPj4+IMKgwqAgaW9tbXUvYXJtLXNtbXUtdjM6
IFJlZmFjdG9yIGFybV9zbW11X2luaXRfYnlwYXNzX3N0ZXMoKSB0byBmb3JjZQo+Pj4gwqDCoMKg
wqAgYnlwYXNzCj4+PiDCoMKgIGlvbW11L2FybS1zbW11LXYzOiBHZXQgYXNzb2NpYXRlZCBSTVIg
aW5mbyBhbmQgaW5zdGFsbCBieXBhc3MgU1RFCj4+PiDCoMKgIGlvbW11L2FybS1zbW11LXYzOiBS
ZXNlcnZlIGFueSBSTVIgcmVnaW9ucyBhc3NvY2lhdGVkIHdpdGggYSBkZXYKPj4+IMKgwqAgaW9t
bXUvYXJtLXNtbXU6IFJlc2VydmUgYW55IFJNUiByZWdpb25zIGFzc29jaWF0ZWQgd2l0aCBhIGRl
dgo+Pj4KPj4+IMKgIGRyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCAzMDUKPj4+ICsrKysrKysrKysrKysrKysrKysrCj4+PiDCoCBk
cml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jIHzCoCA5MSArKysrLS0K
Pj4+IMKgIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmPCoMKgwqDCoMKgwqAg
fMKgIDY1ICsrKystCj4+PiDCoCBkcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAyNSArKwo+Pj4gwqAgaW5jbHVkZS9saW51eC9h
Y3BpX2lvcnQuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTQgKwo+
Pj4gwqAgaW5jbHVkZS9saW51eC9kbWEtaW9tbXUuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgMTQgKwo+Pj4gwqAgaW5jbHVkZS9saW51eC9pb21tdS5owqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgOSArCj4+PiDCoCA3IGZp
bGVzIGNoYW5nZWQsIDUwNCBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkKPj4+Cj4+Cj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
