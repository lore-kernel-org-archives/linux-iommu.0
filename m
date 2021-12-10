Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45ACAC433FE
	for <iommu@archiver.kernel.org>; Sat, 11 Dec 2021 14:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E1B8240441;
	Sat, 11 Dec 2021 14:57:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0TJlzC4JzQph; Sat, 11 Dec 2021 14:57:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A224340012;
	Sat, 11 Dec 2021 14:57:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85F1EC002F;
	Sat, 11 Dec 2021 14:57:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25F96C0012;
 Fri, 10 Dec 2021 07:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1296961399;
 Fri, 10 Dec 2021 07:30:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9P5jQyU7bJ3X; Fri, 10 Dec 2021 07:30:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2786A61120;
 Fri, 10 Dec 2021 07:30:14 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 gx15-20020a17090b124f00b001a695f3734aso6859748pjb.0; 
 Thu, 09 Dec 2021 23:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:to:cc:references
 :from:in-reply-to:content-transfer-encoding;
 bh=kqdwZyEU31KaNW+cOFp1dor6RRAOvhH6zrtcJuFenfA=;
 b=gqnhaZdO12ibnFTEUYTRcyNDsVi4fZjKWuF1d+1IX2QtK+zXEl/CleEzgCXcZCKWk4
 DeGXeYahXgF25toJDTBvItitvosjjzyrdtCOfzBPXJUv2sNA46FGCrVbWvzev5Gqa7Ak
 meZ3c5sCNkdjOENTF0nlgXWFhqmZAwIOkT71xtM4OT2BCJb5l3qSGmgij0kaSHc39jlT
 lz+NQj74lZEDNXhnwDnJm6MBPftfgIEvxzLs37o6722DhjM05TgsyYdxT05vxKbTRo5c
 paO1XE+hWA5qYswHrUze+qL1vRsNsy/KmrR7y+w/OwTPs4iJXL+3vAPXn7Z6f5NDhlEr
 bj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :to:cc:references:from:in-reply-to:content-transfer-encoding;
 bh=kqdwZyEU31KaNW+cOFp1dor6RRAOvhH6zrtcJuFenfA=;
 b=BUxoOEOquksKUBrgSHmPgb/FI+QCIKUYki7HLvCKuD0xa9vShJlMc0+kJrqAOkj+rk
 MXd7DLP2PCImoSm839KX7CbLC/Rb2ajLewpQ9zIwwoXP2OGukdYrOgAl2CCe8E1iUbZu
 OWjRunrNydTck0+BLPsXQWJrir6f5Mm+GE+FTv+aOwl6G+12jkUNencTcwGiIpMZMsLU
 837eX8N6YR7Zt5AaTZrYCBFha3V4ejVShK440vCfiPI67+6nzPmhRd1QFa7ShNHlSIlB
 6RBE4zkXVpQBdas740Lr9d2TDhSv2EHZA9KLFZAesiypbELOKdxx9MC0fUBgUSm+l+x1
 vfnw==
X-Gm-Message-State: AOAM5332vobu7K+TzvOyp15vpJBucm+aOn/3ygdw5E1f4x8wNzFApj3w
 ZwfUixtqWNqOU63hQX4TKbM=
X-Google-Smtp-Source: ABdhPJxRm9ttF7FhbBeprnb6+zsZD1lD+fI51oOUlTadE/AU/yNXP9DA3iOR8FWZWbadxSA9RFDXLw==
X-Received: by 2002:a17:902:f687:b0:141:cf6b:fee7 with SMTP id
 l7-20020a170902f68700b00141cf6bfee7mr71919578plg.75.1639121413466; 
 Thu, 09 Dec 2021 23:30:13 -0800 (PST)
Received: from [30.240.98.4] ([205.204.117.108])
 by smtp.gmail.com with ESMTPSA id c17sm185764pfc.163.2021.12.09.23.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Dec 2021 23:30:13 -0800 (PST)
Message-ID: <07f11dfc-f491-3b08-a2cb-3c8f5a8102d3@gmail.com>
Date: Fri, 10 Dec 2021 15:30:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [RFC PATCH v2 0/7] Use pageblock_order for cma and
 alloc_contig_range alignment.
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org
References: <20211209230414.2766515-1-zi.yan@sent.com>
From: Eric Ren <renzhengeek@gmail.com>
In-Reply-To: <20211209230414.2766515-1-zi.yan@sent.com>
X-Mailman-Approved-At: Sat, 11 Dec 2021 14:57:43 +0000
Cc: Mel Gorman <mgorman@techsingularity.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, Vlastimil Babka <vbabka@suse.cz>
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

SGkgWmkgWWFuLAoKT24gMjAyMS8xMi8xMCAwNzowNCwgWmkgWWFuIHdyb3RlOgo+IEZyb206IFpp
IFlhbiA8eml5QG52aWRpYS5jb20+Cj4KPiBIaSBhbGwsCj4KPiBUaGlzIHBhdGNoc2V0IHRyaWVz
IHRvIHJlbW92ZSB0aGUgTUFYX09SREVSIC0gMSBhbGlnbm1lbnQgcmVxdWlyZW1lbnQgZm9yIENN
QQo+IGFuZCBhbGxvY19jb250aWdfcmFuZ2UoKS4gSXQgcHJlcGFyZXMgZm9yIG15IHVwY29taW5n
IGNoYW5nZXMgdG8gbWFrZSBNQVhfT1JERVIKPiBhZGp1c3RhYmxlIGF0IGJvb3QgdGltZVsxXS4K
Pgo+IFRoZSBNQVhfT1JERVIgLSAxIGFsaWdubWVudCByZXF1aXJlbWVudCBjb21lcyBmcm9tIHRo
YXQgYWxsb2NfY29udGlnX3JhbmdlKCkKPiBpc29sYXRlcyBwYWdlYmxvY2tzIHRvIHJlbW92ZSBm
cmVlIG1lbW9yeSBmcm9tIGJ1ZGR5IGFsbG9jYXRvciBidXQgaXNvbGF0aW5nCj4gb25seSBhIHN1
YnNldCBvZiBwYWdlYmxvY2tzIHdpdGhpbiBhIHBhZ2Ugc3Bhbm5pbmcgYWNyb3NzIG11bHRpcGxl
IHBhZ2VibG9ja3MKPiBjYXVzZXMgZnJlZSBwYWdlIGFjY291bnRpbmcgaXNzdWVzLiBJc29sYXRl
ZCBwYWdlIG1pZ2h0IG5vdCBiZSBwdXQgaW50byB0aGUKPiByaWdodCBmcmVlIGxpc3QsIHNpbmNl
IHRoZSBjb2RlIGFzc3VtZXMgdGhlIG1pZ3JhdGV0eXBlIG9mIHRoZSBmaXJzdCBwYWdlYmxvY2sK
PiBhcyB0aGUgd2hvbGUgZnJlZSBwYWdlIG1pZ3JhdGV0eXBlLiBUaGlzIGlzIGJhc2VkIG9uIHRo
ZSBkaXNjdXNzaW9uIGF0IFsyXS4KPgo+IFRvIHJlbW92ZSB0aGUgcmVxdWlyZW1lbnQsIHRoaXMg
cGF0Y2hzZXQ6Cj4gMS4gc3RpbGwgaXNvbGF0ZXMgcGFnZWJsb2NrcyBhdCBNQVhfT1JERVIgLSAx
IGdyYW51bGFyaXR5OwpUaGVuLCB1bnBsdWcgZmFpbHMgaWYgZWl0aGVyIHBhZ2VibG9jayBvZiB0
aGXCoCBNQVhfT1JERVIgLSAxIHBhZ2UgaGFzIAp1bm1vdmFibGUgcGFnZSwgcmlnaHQ/CgpUaGFu
a3MsCkVyaWMKPiAyLiBidXQgc2F2ZXMgdGhlIHBhZ2VibG9jayBtaWdyYXRldHlwZXMgb3V0c2lk
ZSB0aGUgc3BlY2lmaWVkIHJhbmdlIG9mCj4gICAgIGFsbG9jX2NvbnRpZ19yYW5nZSgpIGFuZCBy
ZXN0b3JlcyB0aGVtIGFmdGVyIGFsbCBwYWdlcyB3aXRoaW4gdGhlIHJhbmdlCj4gICAgIGJlY29t
ZSBmcmVlIGFmdGVyIF9fYWxsb2NfY29udGlnX21pZ3JhdGVfcmFuZ2UoKTsKPiAzLiBzcGxpdHMg
ZnJlZSBwYWdlcyBzcGFubmluZyBtdWx0aXBsZSBwYWdlYmxvY2tzIGF0IHRoZSBiZWdpbm5pbmcg
YW5kIHRoZSBlbmQKPiAgICAgb2YgdGhlIHJhbmdlIGFuZCBwdXRzIHRoZSBzcGxpdCBwYWdlcyB0
byB0aGUgcmlnaHQgbWlncmF0ZXR5cGUgZnJlZSBsaXN0cwo+ICAgICBiYXNlZCBvbiB0aGUgcGFn
ZWJsb2NrIG1pZ3JhdGV0eXBlczsKPiA0LiByZXR1cm5zIHBhZ2VzIG5vdCBpbiB0aGUgcmFuZ2Ug
YXMgaXQgZGlkIGJlZm9yZSB0aGlzIHBhdGNoLgo+Cj4gSXNvbGF0aW9uIG5lZWRzIHRvIGhhcHBl
biBhdCBNQVhfT1JERVIgLSAxIGdyYW51bGFyaXR5LCBiZWNhdXNlIG90aGVyd2lzZQo+IDEpIGV4
dHJhIGNvZGUgaXMgbmVlZGVkIHRvIGRldGVjdCBwYWdlcyAoZnJlZSwgUGFnZUh1Z2UsIFRIUCwg
b3IgUGFnZUNvbXBvdW5kKQo+IHRvIG1ha2Ugc3VyZSBhbGwgcGFnZWJsb2NrcyBiZWxvbmdpbmcg
dG8gYSBzaW5nbGUgcGFnZSBhcmUgaXNvbGF0ZWQgdG9nZXRoZXIKPiBhbmQgbGF0ZXIgcGFnZWJs
b2NrcyBvdXRzaWRlIHRoZSByYW5nZSBuZWVkIHRvIGhhdmUgdGhlaXIgbWlncmF0ZXR5cGVzIHJl
c3RvcmVkOwo+IG9yIDIpIGV4dHJhIGxvZ2ljIHdpbGwgbmVlZCB0byBiZSBhZGRlZCBkdXJpbmcg
cGFnZSBmcmVlIHRpbWUgdG8gc3BsaXQgYSBmcmVlCj4gcGFnZSB3aXRoIG11bHRpLW1pZ3JhdGV0
eXBlIHBhZ2VibG9ja3MuCj4KPiBUd28gb3B0aW1pemF0aW9ucyBtaWdodCBjb21lIGxhdGVyOgo+
IDEuIG9ubHkgY2hlY2sgdW5tb3ZhYmxlIHBhZ2VzIHdpdGhpbiB0aGUgcmFuZ2UgaW5zdGVhZCBv
ZiBNQVhfT1JERVIgLSAxIGFsaWduZWQKPiAgICAgcmFuZ2UgZHVyaW5nIGlzb2xhdGlvbiB0byBp
bmNyZWFzZSBzdWNjZXNzZnVsIHJhdGUgb2YgYWxsb2NfY29udGlnX3JhbmdlKCkuCj4gMi4gbWFr
ZSBNSUdSQVRFX0lTT0xBVEUgYSBzZXBhcmF0ZSBiaXQgdG8gYXZvaWQgc2F2aW5nIGFuZCByZXN0
b3JpbmcgZXhpc3RpbmcKPiAgICAgbWlncmF0ZXR5cGVzIGJlZm9yZSBhbmQgYWZ0ZXIgaXNvbGF0
aW9uIHJlc3BlY3RpdmVseS4KPgo+IEZlZWwgZnJlZSB0byBnaXZlIGNvbW1lbnRzIGFuZCBzdWdn
ZXN0aW9ucy4gVGhhbmtzLgo+Cj4KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
bW0vMjAyMTA4MDUxOTAyNTMuMjc5NTYwNC0xLXppLnlhbkBzZW50LmNvbS8KPiBbMl0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vZDE5ZmIwNzgtY2I5Yi1mNjBmLWUzMTAtZmRlZWEx
Yjk0N2QyQHJlZGhhdC5jb20vCj4KPgo+IFppIFlhbiAoNyk6Cj4gICAgbW06IHBhZ2VfYWxsb2M6
IGF2b2lkIG1lcmdpbmcgbm9uLWZhbGxiYWNrYWJsZSBwYWdlYmxvY2tzIHdpdGggb3RoZXJzLgo+
ICAgIG1tOiBjb21wYWN0aW9uOiBoYW5kbGUgbm9uLWxydSBjb21wb3VuZCBwYWdlcyBwcm9wZXJs
eSBpbgo+ICAgICAgaXNvbGF0ZV9taWdyYXRlcGFnZXNfYmxvY2soKS4KPiAgICBtbTogbWlncmF0
ZTogYWxsb2NhdGUgdGhlIHJpZ2h0IHNpemUgb2Ygbm9uIGh1Z2V0bGIgb3IgVEhQIGNvbXBvdW5k
Cj4gICAgICBwYWdlcy4KPiAgICBtbTogbWFrZSBhbGxvY19jb250aWdfcmFuZ2Ugd29yayBhdCBw
YWdlYmxvY2sgZ3JhbnVsYXJpdHkKPiAgICBtbTogY21hOiB1c2UgcGFnZWJsb2NrX29yZGVyIGFz
IHRoZSBzaW5nbGUgYWxpZ25tZW50Cj4gICAgZHJpdmVyczogdmlydGlvX21lbTogdXNlIHBhZ2Vi
bG9jayBzaXplIGFzIHRoZSBtaW5pbXVtIHZpcnRpb19tZW0KPiAgICAgIHNpemUuCj4gICAgYXJj
aDogcG93ZXJwYzogYWRqdXN0IGZhZHVtcCBhbGlnbm1lbnQgdG8gYmUgcGFnZWJsb2NrIGFsaWdu
ZWQuCj4KPiAgIGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9mYWR1bXAtaW50ZXJuYWwuaCB8ICAg
NCArLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX21lbS5jICAgICAgICAgICAgICAgIHwgICA2
ICstCj4gICBpbmNsdWRlL2xpbnV4L21tem9uZS5oICAgICAgICAgICAgICAgICAgICAgfCAgMTEg
Ky0KPiAgIGtlcm5lbC9kbWEvY29udGlndW91cy5jICAgICAgICAgICAgICAgICAgICB8ICAgMiAr
LQo+ICAgbW0vY21hLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICst
Cj4gICBtbS9jb21wYWN0aW9uLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTAgKy0K
PiAgIG1tL21pZ3JhdGUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgOCArLQo+
ICAgbW0vcGFnZV9hbGxvYy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjAzICsrKysr
KysrKysrKysrKysrLS0tLQo+ICAgOCBmaWxlcyBjaGFuZ2VkLCAxOTYgaW5zZXJ0aW9ucygrKSwg
NTQgZGVsZXRpb25zKC0pCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
