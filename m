Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05084C433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Mar 2022 12:42:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93DB660E4B;
	Mon,  7 Mar 2022 12:42:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r5SOTnXuM7FD; Mon,  7 Mar 2022 12:42:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 30570607F2;
	Mon,  7 Mar 2022 12:42:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01BAAC0012;
	Mon,  7 Mar 2022 12:42:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14AD3C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 12:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 123FF40893
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 12:42:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id etxxWpFOGsTI for <iommu@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 12:42:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0369040892
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 12:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646656940;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6eeNwR4loaBjjEP8RdScYzxO+RCd7H+nxGYKGNuzU6E=;
 b=dOat/Y+2MniH41RdjNnR3KIWU7yGzqYzhtQC9PhMRm+ZkPHHqQxHTVtoUhVJQi28pi/Ofd
 p9w8p56G/didew/K83tQJTIuqeSnDuOTN+9L0qAUNTAaRHLQbCFclXfieUeGwoYp29juCC
 ykrhkjNWrGG/CfDPzON1+ct5n2lk7RQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-H_gXZZjFPv6PwPdhPgJTYg-1; Mon, 07 Mar 2022 07:42:16 -0500
X-MC-Unique: H_gXZZjFPv6PwPdhPgJTYg-1
Received: by mail-wr1-f71.google.com with SMTP id
 z16-20020adff1d0000000b001ef7dc78b23so4497034wro.12
 for <iommu@lists.linux-foundation.org>; Mon, 07 Mar 2022 04:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=6eeNwR4loaBjjEP8RdScYzxO+RCd7H+nxGYKGNuzU6E=;
 b=ZrawJRrq2L/4j5n7aWYC7UdVE2HQVa5lCuEfnLwiHm4BSpr2xe/EOVTHD7PXN7cfmH
 JSlecidXikdLwem5pv2gT2yqM2YbjhhQBCMFozUL8rOeO/UvhR7WmHtomKTHXLAuJdvh
 a7SrLBrfRZyrCPplxjLK4xRdDTUmUB6dfrUhzklXvy339DPsahHgx4mMMflpwa8Nqx7L
 LokxEhUQ/bH9+Ht8j+gw+NhuwaM1I8WQr+XsB3iJnnbYljYvmkMFMSM6tzpJuMlz4/6b
 2FRydCxY3IoNQmfYX3iL8WaSBCVih+UPmywtKi/oD+xEx8pQesYOcPrJZECEVjXvbW1M
 ERoQ==
X-Gm-Message-State: AOAM532XMmY+SVAKROHmvdlTh5oTOWn/bdNXON8XBeMLOgufyOaCAUNd
 hNZgCgSCnfpLIl/KFgjmmLUaHrq+mhSqcC7u065yawno5sTUrUKqZ+6DJHeEPfPghifLRvLY6iq
 zYoHetNGDYLDPFK26bABdflRo/plrmw==
X-Received: by 2002:adf:dcc2:0:b0:1f0:4c38:d6be with SMTP id
 x2-20020adfdcc2000000b001f04c38d6bemr8115734wrm.79.1646656935524; 
 Mon, 07 Mar 2022 04:42:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypym0PVHFx9W4v/f24ImuL8HFKfTAheoICss9sCuocVDFJFJoyHsNopW+2XcaueuxzLmWzTA==
X-Received: by 2002:adf:dcc2:0:b0:1f0:4c38:d6be with SMTP id
 x2-20020adfdcc2000000b001f04c38d6bemr8115695wrm.79.1646656935224; 
 Mon, 07 Mar 2022 04:42:15 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 v124-20020a1cac82000000b0037c3d08e0e7sm19689931wme.29.2022.03.07.04.42.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Mar 2022 04:42:14 -0800 (PST)
Subject: Re: [PATCH v7 01/11] iommu: Add DMA ownership management interfaces
To: Lu Baolu <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson
 <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20220228005056.599595-1-baolu.lu@linux.intel.com>
 <20220228005056.599595-2-baolu.lu@linux.intel.com>
 <c75b6e04-bc1b-b9f6-1a44-bf1567a8c19d@redhat.com>
 <7a3dc977-0c5f-6d88-6d3a-8e49bc717690@linux.intel.com>
 <1648bc97-a0d3-4051-58d0-e24fa9e9d183@arm.com>
 <350a8e09-08a9-082b-3ad1-b711c7d98d73@redhat.com>
 <e2698dbe-18e2-1a82-8a12-fe45bc9be534@arm.com>
 <b1a5db0a-0373-5ca0-6256-85a96d029ec9@linux.intel.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <ac75c521-fb13-8414-a81b-9178cbed3471@redhat.com>
Date: Mon, 7 Mar 2022 13:42:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b1a5db0a-0373-5ca0-6256-85a96d029ec9@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Chaitanya Kulkarni <kch@nvidia.com>, kvm@vger.kernel.org,
 Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Diana Craciun <diana.craciun@oss.nxp.com>,
 Dan Williams <dan.j.williams@intel.com>, Li Yang <leoyang.li@nxp.com>,
 Will Deacon <will@kernel.org>, Dmitry Osipenko <digetx@gmail.com>
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

SGkgTHUsCgpPbiAzLzcvMjIgNDoyNyBBTSwgTHUgQmFvbHUgd3JvdGU6Cj4gSGkgUm9iaW4sCj4K
PiBPbiAzLzQvMjIgMTA6MTAgUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPj4gT24gMjAyMi0wMy0w
NCAxMzo1NSwgRXJpYyBBdWdlciB3cm90ZToKPj4+IEhpIFJvYmluLAo+Pj4KPj4+IE9uIDMvNC8y
MiAxOjIyIFBNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+Pj4gT24gMjAyMi0wMy0wNCAxMDo0Mywg
THUgQmFvbHUgd3JvdGU6Cj4+Pj4+IEhpIEVyaWMsCj4+Pj4+Cj4+Pj4+IE9uIDIwMjIvMy80IDE4
OjM0LCBFcmljIEF1Z2VyIHdyb3RlOgo+Pj4+Pj4gSSBoaXQgYSBXQVJOX09OKCkgd2hlbiB1bmJp
bmRpbmcgYW4gZTEwMDBlIGRyaXZlciBqdXN0IGFmdGVyIGJvb3Q6Cj4+Pj4+Pgo+Pj4+Pj4gc3Vk
byBtb2Rwcm9iZSAtdiB2ZmlvLXBjaQo+Pj4+Pj4gZWNobyB2ZmlvLXBjaSB8IHN1ZG8gdGVlIC1h
Cj4+Pj4+PiAvc3lzL2J1cy9wY2kvZGV2aWNlcy8wMDA0OjAxOjAwLjAvZHJpdmVyX292ZXJyaWRl
Cj4+Pj4+PiB2ZmlvLXBjaQo+Pj4+Pj4gZWNobyAwMDA0OjAxOjAwLjAgfCBzdWRvIHRlZSAtYcKg
IC9zeXMvYnVzL3BjaS9kcml2ZXJzL2UxMDAwZS91bmJpbmQKPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4g
W8KgIDM5MC4wNDI4MTFdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQo+Pj4+
Pj4gW8KgIDM5MC4wNDY0NjhdIFdBUk5JTkc6IENQVTogNDIgUElEOiA1NTg5IGF0Cj4+Pj4+PiBk
cml2ZXJzL2lvbW11L2lvbW11LmM6MzEyMwo+Pj4+Pj4gaW9tbXVfZGV2aWNlX3VudXNlX2RlZmF1
bHRfZG9tYWluKzB4NjgvMHgxMDAKPj4+Pj4+IFvCoCAzOTAuMDU2NzEwXSBNb2R1bGVzIGxpbmtl
ZCBpbjogdmZpb19wY2kgdmZpb19wY2lfY29yZSB2ZmlvX3ZpcnFmZAo+Pj4+Pj4gdmZpb19pb21t
dV90eXBlMSB2ZmlvIHh0X0NIRUNLU1VNIHh0X01BU1FVRVJBREUgeHRfY29ubnRyYWNrCj4+Pj4+
PiBpcHRfUkVKRUNUCj4+Pj4+PiBuZl9yZWplY3RfaXB2NCBuZnRfY29tcGF0IG5mdF9jaGFpbl9u
YXQgbmZfbmF0IG5mX2Nvbm50cmFjawo+Pj4+Pj4gbmZfZGVmcmFnX2lwdjYgbmZfZGVmcmFnX2lw
djQgbmZfdGFibGVzIG5mbmV0bGluayBicmlkZ2Ugc3RwIGxsYwo+Pj4+Pj4gcmZraWxsCj4+Pj4+
PiBzdW5ycGMgdmZhdCBmYXQgbWx4NV9pYiBpYl91dmVyYnMgaWJfY29yZSBhY3BpX2lwbWkgaXBt
aV9zc2lmCj4+Pj4+PiBpcG1pX2RldmludGYgaXBtaV9tc2doYW5kbGVyIGNwcGNfY3B1ZnJlcSBk
cm0geGZzIGxpYmNyYzMyYwo+Pj4+Pj4gbWx4NV9jb3JlIHNnCj4+Pj4+PiBtbHhmdyBjcmN0MTBk
aWZfY2UgdGxzIGdoYXNoX2NlIHNoYTJfY2Ugc2hhMjU2X2FybTY0IHNoYTFfY2UKPj4+Pj4+IHNi
c2FfZ3dkdAo+Pj4+Pj4gZTEwMDBlIHBzYW1wbGUgc2RoY2lfYWNwaSBhaGNpX3BsYXRmb3JtIHNk
aGNpIGxpYmFoY2lfcGxhdGZvcm0KPj4+Pj4+IHFjb21fZW1hYwo+Pj4+Pj4gbW1jX2NvcmUgaGRt
YSBoZG1hX21nbXQgZG1fbWlycm9yIGRtX3JlZ2lvbl9oYXNoIGRtX2xvZyBkbV9tb2QgZnVzZQo+
Pj4+Pj4gW8KgIDM5MC4xMTA2MThdIENQVTogNDIgUElEOiA1NTg5IENvbW06IHRlZSBLZHVtcDog
bG9hZGVkIE5vdCB0YWludGVkCj4+Pj4+PiA1LjE3LjAtcmM0LWx1LXY3LW9mZmljaWFsKyAjMjQK
Pj4+Pj4+IFvCoCAzOTAuMTE5Mzg0XSBIYXJkd2FyZSBuYW1lOiBXSVdZTk4gUURGMjQwMCBSZWZl
cmVuY2UgRXZhbHVhdGlvbgo+Pj4+Pj4gUGxhdGZvcm0gQ1Y5MC1MQTExNS1QMTIwL1FERjI0MDAg
Q3VzdG9tZXIgUmVmZXJlbmNlIEJvYXJkLCBCSU9TCj4+Pj4+PiAwQUNKQTU3MAo+Pj4+Pj4gMTEv
MDUvMjAxOAo+Pj4+Pj4gW8KgIDM5MC4xMzI0OTJdIHBzdGF0ZTogYTA0MDAwMDUgKE56Q3YgZGFp
ZiArUEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTCj4+Pj4+PiBCVFlQRT0tLSkKPj4+Pj4+IFvCoCAz
OTAuMTM5NDM2XSBwYyA6IGlvbW11X2RldmljZV91bnVzZV9kZWZhdWx0X2RvbWFpbisweDY4LzB4
MTAwCj4+Pj4+PiBbwqAgMzkwLjE0NTE2NV0gbHIgOiBpb21tdV9kZXZpY2VfdW51c2VfZGVmYXVs
dF9kb21haW4rMHgzOC8weDEwMAo+Pj4+Pj4gW8KgIDM5MC4xNTA4OTRdIHNwIDogZmZmZjgwMDAw
ZmJiM2JjMAo+Pj4+Pj4gW8KgIDM5MC4xNTQxOTNdIHgyOTogZmZmZjgwMDAwZmJiM2JjMCB4Mjg6
IGZmZmYwM2MwY2Y2YjI0MDAgeDI3Ogo+Pj4+Pj4gMDAwMDAwMDAwMDAwMDAwMAo+Pj4+Pj4gW8Kg
IDM5MC4xNjEzMTFdIHgyNjogMDAwMDAwMDAwMDAwMDAwMCB4MjU6IDAwMDAwMDAwMDAwMDAwMDAg
eDI0Ogo+Pj4+Pj4gZmZmZjAzYzBjN2NjNTcyMAo+Pj4+Pj4gW8KgIDM5MC4xNjg0MjldIHgyMzog
ZmZmZjAzYzBjMmI5ZDE1MCB4MjI6IGZmZmZiNGU2MWRmMjIzZjggeDIxOgo+Pj4+Pj4gZmZmZmI0
ZTYxZGYyMjNmOAo+Pj4+Pj4gW8KgIDM5MC4xNzU1NDddIHgyMDogZmZmZjAzYzdjMDNjMzc1OCB4
MTk6IGZmZmYwM2M3YzAzYzM3MDAgeDE4Ogo+Pj4+Pj4gMDAwMDAwMDAwMDAwMDAwMAo+Pj4+Pj4g
W8KgIDM5MC4xODI2NjVdIHgxNzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6IDAwMDAwMDAwMDAwMDAw
MDAgeDE1Ogo+Pj4+Pj4gMDAwMDAwMDAwMDAwMDAwMAo+Pj4+Pj4gW8KgIDM5MC4xODk3ODNdIHgx
NDogMDAwMDAwMDAwMDAwMDAwMCB4MTM6IDAwMDAwMDAwMDAwMDAwMzAgeDEyOgo+Pj4+Pj4gZmZm
ZjAzYzBkNTE5Y2Q4MAo+Pj4+Pj4gW8KgIDM5MC4xOTY5MDFdIHgxMTogN2Y3ZjdmN2Y3ZjdmN2Y3
ZiB4MTA6IDAwMDAwMDAwMDAwMDBkYzAgeDkgOgo+Pj4+Pj4gZmZmZmI0ZTYyMGI1NGY4Ywo+Pj4+
Pj4gW8KgIDM5MC4yMDQwMTldIHg4IDogZmZmZjAzYzBjZjZiMzIyMCB4NyA6IGZmZmY0ZWYxMzJi
YmEwMDAgeDYgOgo+Pj4+Pj4gMDAwMDAwMDAwMDAwMDBmZgo+Pj4+Pj4gW8KgIDM5MC4yMTExMzdd
IHg1IDogZmZmZjAzYzBjMmI5ZjEwOCB4NCA6IGZmZmYwM2MwZDUxZjY0MzggeDMgOgo+Pj4+Pj4g
MDAwMDAwMDAwMDAwMDAwMAo+Pj4+Pj4gW8KgIDM5MC4yMTgyNTVdIHgyIDogZmZmZjAzYzBjZjZi
MjQwMCB4MSA6IDAwMDAwMDAwMDAwMDAwMDAgeDAgOgo+Pj4+Pj4gMDAwMDAwMDAwMDAwMDAwMAo+
Pj4+Pj4gW8KgIDM5MC4yMjUzNzRdIENhbGwgdHJhY2U6Cj4+Pj4+PiBbwqAgMzkwLjIyNzgwNF3C
oCBpb21tdV9kZXZpY2VfdW51c2VfZGVmYXVsdF9kb21haW4rMHg2OC8weDEwMAo+Pj4+Pj4gW8Kg
IDM5MC4yMzMxODddwqAgcGNpX2RtYV9jbGVhbnVwKzB4MzgvMHg0NAo+Pj4+Pj4gW8KgIDM5MC4y
MzY5MTldwqAgX19kZXZpY2VfcmVsZWFzZV9kcml2ZXIrMHgxYTgvMHgyNjAKPj4+Pj4+IFvCoCAz
OTAuMjQxNTE5XcKgIGRldmljZV9kcml2ZXJfZGV0YWNoKzB4NTAvMHhkMAo+Pj4+Pj4gW8KgIDM5
MC4yNDU2ODZdwqAgdW5iaW5kX3N0b3JlKzB4ZjgvMHgxMjAKPj4+Pj4+IFvCoCAzOTAuMjQ5MjQ1
XcKgIGRydl9hdHRyX3N0b3JlKzB4MzAvMHg0NAo+Pj4+Pj4gW8KgIDM5MC4yNTI4OTFdwqAgc3lz
ZnNfa2Zfd3JpdGUrMHg1MC8weDYwCj4+Pj4+PiBbwqAgMzkwLjI1NjUzN13CoCBrZXJuZnNfZm9w
X3dyaXRlX2l0ZXIrMHgxMzQvMHgxY2MKPj4+Pj4+IFvCoCAzOTAuMjYwOTY0XcKgIG5ld19zeW5j
X3dyaXRlKzB4ZjAvMHgxOGMKPj4+Pj4+IFvCoCAzOTAuMjY0Njk2XcKgIHZmc193cml0ZSsweDIz
MC8weDJkMAo+Pj4+Pj4gW8KgIDM5MC4yNjgwODJdwqAga3N5c193cml0ZSsweDc0LzB4MTAwCj4+
Pj4+PiBbwqAgMzkwLjI3MTQ2N13CoCBfX2FybTY0X3N5c193cml0ZSsweDI4LzB4M2MKPj4+Pj4+
IFvCoCAzOTAuMjc1MzczXcKgIGludm9rZV9zeXNjYWxsLmNvbnN0cHJvcC4wKzB4NTgvMHhmMAo+
Pj4+Pj4gW8KgIDM5MC4yODAwNjFdwqAgZWwwX3N2Y19jb21tb24uY29uc3Rwcm9wLjArMHgxNjAv
MHgxNjQKPj4+Pj4+IFvCoCAzOTAuMjg0OTIyXcKgIGRvX2VsMF9zdmMrMHgzNC8weGNjCj4+Pj4+
PiBbwqAgMzkwLjI4ODIyMV3CoCBlbDBfc3ZjKzB4MzAvMHgxNDAKPj4+Pj4+IFvCoCAzOTAuMjkx
MzQ2XcKgIGVsMHRfNjRfc3luY19oYW5kbGVyKzB4YTQvMHgxMzAKPj4+Pj4+IFvCoCAzOTAuMjk1
NTk5XcKgIGVsMHRfNjRfc3luYysweDFhMC8weDFhNAo+Pj4+Pj4gW8KgIDM5MC4yOTkyNDVdIC0t
LVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+PiBJ
IHB1dCBzb21lIHRyYWNlcyBpbiB0aGUgY29kZSBhbmQgSSBjYW4gc2VlIHRoYXQKPj4+Pj4+IGlv
bW11X2RldmljZV91c2VfZGVmYXVsdF9kb21haW4oKSBlZmZlY3RpdmVseSBpcyBjYWxsZWQgb24K
Pj4+Pj4+IDAwMDQ6MDE6MDAuMCBlMTAwMGUgZGV2aWNlIG9uIHBjaV9kbWFfY29uZmlndXJlKCkg
YnV0IGF0IHRoYXQgdGltZQo+Pj4+Pj4gdGhlIGlvbW11IGdyb3VwIGlzIE5VTEw6Cj4+Pj4+PiBb
wqDCoCAxMC41Njk0MjddIGUxMDAwZSAwMDA0OjAxOjAwLjA6IC0tLS0tLSBFTlRSWSBwY2lfZG1h
X2NvbmZpZ3VyZQo+Pj4+Pj4gZHJpdmVyX21hbmFnZWRfYXJlYT0wCj4+Pj4+PiBbwqDCoCAxMC41
Njk0MzFdIGUxMDAwZSAwMDA0OjAxOjAwLjA6ICoqKioKPj4+Pj4+IGlvbW11X2RldmljZV91c2Vf
ZGVmYXVsdF9kb21haW4gRU5UUlkKPj4+Pj4+IFvCoMKgIDEwLjU2OTQzM10gZTEwMDBlIDAwMDQ6
MDE6MDAuMDogKioqKgo+Pj4+Pj4gaW9tbXVfZGV2aWNlX3VzZV9kZWZhdWx0X2RvbWFpbiBubyBn
cm91cAo+Pj4+Pj4gW8KgwqAgMTAuNTY5NDM1XSBlMTAwMGUgMDAwNDowMTowMC4wOiBwY2lfZG1h
X2NvbmZpZ3VyZQo+Pj4+Pj4gaW9tbXVfZGV2aWNlX3VzZV9kZWZhdWx0X2RvbWFpbiByZXR1cm5l
ZCAwCj4+Pj4+PiBbwqDCoCAxMC41Njk0OTJdIGUxMDAwZSAwMDA0OjAxOjAwLjA6IEFkZGluZyB0
byBpb21tdSBncm91cCAzCj4+Pj4+Pgo+Pj4+Pj4gXl5edGhlIGdyb3VwIGlzIGFkZGVkIGFmdGVy
IHRoZQo+Pj4+Pj4gaW9tbXVfZGV2aWNlX3VzZV9kZWZhdWx0X2RvbWFpbigpIGNhbGwKPj4+Pj4+
IFNvIHRoZSBncm91cC0+b3duZXJfY250IGlzIG5vdCBpbmNyZW1lbnRlZCBhcyBleHBlY3RlZC4K
Pj4+Pj4KPj4+Pj4gVGhhbmsgeW91IGZvciByZXBvcnRpbmcgdGhpcy4gRG8geW91IGhhdmUgYW55
IGlkZWEgd2h5IHRoZSBkcml2ZXIgaXMKPj4+Pj4gbG9hZGVkIGJlZm9yZSBpb21tdV9wcm9iZV9k
ZXZpY2UoKT8KPj4+Pgo+Pj4+IFVyZ2gsIHRoaXMgaXMgdGhlIGhvcnJpYmxlIGZpcm13YXJlLWRh
dGEtb3JkZXJpbmcgdGhpbmcgYWdhaW4uIFRoZQo+Pj4+IHN0dWZmIEkndmUgYmVlbiBzYXlpbmcg
YWJvdXQgaGF2aW5nIHRvIHJld29yayB0aGUgd2hvbGUgLmRtYV9jb25maWd1cmUKPj4+PiBtZWNo
YW5pc20gaW4gdGhlIG5lYXIgZnV0dXJlIGlzIHRvIGZpeCB0aGlzIHByb3Blcmx5Lgo+Pj4+Cj4+
Pj4gVGhlIHN1bW1hcnkgaXMgdGhhdCBpbiBwYXRjaCAjNCwgY2FsbGluZwo+Pj4+IGlvbW11X2Rl
dmljZV91c2VfZGVmYXVsdF9kb21haW4oKSAqYmVmb3JlKiB7b2YsYWNwaX1fZG1hX2NvbmZpZ3Vy
ZSBpcwo+Pj4+IGN1cnJlbnRseSBhIHByb2JsZW0uIEFzIHRoaW5ncyBzdGFuZCwgdGhlIElPTU1V
IGRyaXZlciBpZ25vcmVkIHRoZQo+Pj4+IGluaXRpYWwgaW9tbXVfcHJvYmVfZGV2aWNlKCkgY2Fs
bCB3aGVuIHRoZSBkZXZpY2Ugd2FzIGFkZGVkLCBzaW5jZSBhdAo+Pj4+IHRoYXQgcG9pbnQgaXQg
aGFkIG5vIGZ3c3BlYyB5ZXQuIEluIHRoaXMgc2l0dWF0aW9uLAo+Pj4+IHtvZixhY3BpfV9pb21t
dV9jb25maWd1cmUoKSBhcmUgcmV0cmlnZ2VyaW5nIGlvbW11X3Byb2JlX2RldmljZSgpCj4+Pj4g
YWZ0ZXIgdGhlIElPTU1VIGRyaXZlciBoYXMgc2VlbiB0aGUgZmlybXdhcmUgZGF0YSB2aWEgLm9m
X3hsYXRlIHRvCj4+Pj4gbGVhcm4gdGhhdCBpdCBpdCBhY3R1YWxseSByZXNwb25zaWJsZSBmb3Ig
dGhlIGdpdmVuIGRldmljZS4KPj4+Cj4+PiB0aGFuayB5b3UgZm9yIHByb3ZpZGluZyB0aGUgaW5m
by4gSG9wZSB0aGlzIGlzIHNvbWV0aGluZyBMdSBjYW4gd29yawo+Pj4gYXJvdW5kLgo+Pgo+PiBI
b3BlZnVsbHkgaXQncyBqdXN0IGEgY2FzZSBvZiBmbGlwcGluZyB0aGUgY2FsbHMgYXJvdW5kLCBz
byB0aGF0Cj4+IGlvbW11X3VzZV9kZWZhdWx0X2RvbWFpbigpIGdvZXMgYXQgdGhlIGVuZCwgYW5k
IGNhbGxzCj4+IGFyY2hfdGVhcmRvd25fZG1hX29wcygpIGlmIGl0IGZhaWxzLiBGcm9tIGEgcXVp
Y2sgc2tpbSBJICp0aGluayogdGhhdAo+PiBzaG91bGQgc3RpbGwgd29yayBvdXQgdG8gdGhlIGRl
c2lyZWQgYmVoYXZpb3VyIChvciBhdCBsZWFzdCBjbG9zZQo+PiBlbm91Z2ggdGhhdCB3ZSBjYW4g
bW92ZSBmb3J3YXJkIHdpdGhvdXQgYSBjaXJjdWxhciBkZXBlbmRlbmN5IGJldHdlZW4KPj4gZml4
ZXMuLi4pCj4KPiBUaGlzIGlzIGEgcmVhc29uYWJsZSBzb2x1dGlvbiB0byBtZS4gVGhhbmsgeW91
IGZvciB0aGUgaW5mb3JtYXRpb24gYW5kCj4gc3VnZ2VzdGlvbi4KPgo+IEVyaWMsIEkgaGF2ZSB1
cGRhdGVkIHRoZSBwYXRjaCAjNCBhbmQgdXBsb2FkZWQgYSBuZXcgdmVyc2lvbiBoZXJlOgo+Cj4g
aHR0cHM6Ly9naXRodWIuY29tL0x1QmFvbHUvaW50ZWwtaW9tbXUvY29tbWl0cy9pb21tdS1kbWEt
b3duZXJzaGlwLXY4Cgp3aXRoIHY4IEkgZG8gbm90IGhpdCB0aGUgd2FybmluZyBhbnltb3JlIGFu
ZCB0aGUgb3duZXIgYWNjb3VudGluZyBzZWVtcwp0byB3b3JrIGFzIGV4cGVjdGVkLgoKVGhhbmtz
CgpFcmljCj4KPiBDYW4geW91IHBsZWFzZSBnaXZlIGl0IGEgdHJ5Pwo+Cj4gQmVzdCByZWdhcmRz
LAo+IGJhb2x1Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
