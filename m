Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32C7C433F5
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 13:55:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42437416B1;
	Fri,  4 Mar 2022 13:55:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gsXui9t0oonx; Fri,  4 Mar 2022 13:55:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CBF7540948;
	Fri,  4 Mar 2022 13:55:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9399EC001D;
	Fri,  4 Mar 2022 13:55:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28CFCC000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 13:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E39040140
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 13:55:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SaHl266hrTsf for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 13:55:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8C3E40137
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646402153;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QPWIp0sQmTP3HApGBB8ym38KTT9fOuLCB6okmKYuF40=;
 b=L4dLiNwvs4hZ88C0NtTZXP9vyuWdQ8ILxNO8zz5dP9/uWHPU4sxUvhHSYghsmlJTkRsEFx
 qzSMGJIYVLA8xjpcLHIvukzPpl3g1t68roW4PXV5i4f5+Djd3/NGZdQ7gI01q6pp2di1XH
 147WwheAdBttn0iTDcZzEimkrb6Ns2I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-mUDNiJ-DPQCyrvMVMaOMfA-1; Fri, 04 Mar 2022 08:55:52 -0500
X-MC-Unique: mUDNiJ-DPQCyrvMVMaOMfA-1
Received: by mail-wm1-f71.google.com with SMTP id
 10-20020a1c020a000000b0037fae68fcc2so4164509wmc.8
 for <iommu@lists.linux-foundation.org>; Fri, 04 Mar 2022 05:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=QPWIp0sQmTP3HApGBB8ym38KTT9fOuLCB6okmKYuF40=;
 b=hVdtYcdHo0ONKj+EpDfys/eku+yyAaKcqDaLM8PF6bDsgDdbpv8gGDz4rS0a7qqNnP
 cQHVkOX9gw7mReVEpbpZfIEZOCTJDipJqelCy6GU6LKMCc0LoTdqcV4rcjScEbI0xLj7
 eeWhhNDEBp5F7gMCmLMzNrnKiOR/B6S1ajsPcyGy4z97+4pgMv+LUVhJmyFHUWa24qOy
 ZssOOmLPYzNGIVCaw+SNs+wRN/I2oy5uzcQIeffO7pMbANXz4jvt6UcVsFYyOD6YBqgU
 uzQGOjStrHCBDPLoLT1uyfzJpcMl72c74pW7tqOq5jrUfaliashLEMn7Iov+IqAZK+F7
 q1kQ==
X-Gm-Message-State: AOAM531V6HPGmMVXX7aQ7NOiPQ6mNx6FgGRhqA00VMNcrM+JQHXd/OXF
 zyaX7FIx/ryEl7T7MMKbJHGzUZiOBtksJYBBNpGG10h2EWdxUzU7U/jjX7Jte/Nst0xXPpHKLIx
 H+2wtz98nbqOtaE5DR8+RUj0UYJ1DMQ==
X-Received: by 2002:a05:6000:15cf:b0:1f0:44b9:b916 with SMTP id
 y15-20020a05600015cf00b001f044b9b916mr8971043wry.86.1646402150000; 
 Fri, 04 Mar 2022 05:55:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz37GW0eYMmhzDC8Bw8HScH/vx+QGCD7Wqeg6Mo3LcpV8MchkeDSAHiRDo/oQwFe6JNh/ax7g==
X-Received: by 2002:a05:6000:15cf:b0:1f0:44b9:b916 with SMTP id
 y15-20020a05600015cf00b001f044b9b916mr8971026wry.86.1646402149735; 
 Fri, 04 Mar 2022 05:55:49 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a05600c4f8f00b003842f011bc5sm8462562wmq.2.2022.03.04.05.55.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Mar 2022 05:55:49 -0800 (PST)
Subject: Re: [PATCH v7 01/11] iommu: Add DMA ownership management interfaces
To: Robin Murphy <robin.murphy@arm.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
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
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <350a8e09-08a9-082b-3ad1-b711c7d98d73@redhat.com>
Date: Fri, 4 Mar 2022 14:55:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1648bc97-a0d3-4051-58d0-e24fa9e9d183@arm.com>
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

SGkgUm9iaW4sCgpPbiAzLzQvMjIgMToyMiBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIw
MjItMDMtMDQgMTA6NDMsIEx1IEJhb2x1IHdyb3RlOgo+PiBIaSBFcmljLAo+Pgo+PiBPbiAyMDIy
LzMvNCAxODozNCwgRXJpYyBBdWdlciB3cm90ZToKPj4+IEkgaGl0IGEgV0FSTl9PTigpIHdoZW4g
dW5iaW5kaW5nIGFuIGUxMDAwZSBkcml2ZXIganVzdCBhZnRlciBib290Ogo+Pj4KPj4+IHN1ZG8g
bW9kcHJvYmUgLXYgdmZpby1wY2kKPj4+IGVjaG8gdmZpby1wY2kgfCBzdWRvIHRlZSAtYQo+Pj4g
L3N5cy9idXMvcGNpL2RldmljZXMvMDAwNDowMTowMC4wL2RyaXZlcl9vdmVycmlkZQo+Pj4gdmZp
by1wY2kKPj4+IGVjaG8gMDAwNDowMTowMC4wIHwgc3VkbyB0ZWUgLWHCoCAvc3lzL2J1cy9wY2kv
ZHJpdmVycy9lMTAwMGUvdW5iaW5kCj4+Pgo+Pj4KPj4+IFvCoCAzOTAuMDQyODExXSAtLS0tLS0t
LS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0KPj4+IFvCoCAzOTAuMDQ2NDY4XSBXQVJOSU5H
OiBDUFU6IDQyIFBJRDogNTU4OSBhdCBkcml2ZXJzL2lvbW11L2lvbW11LmM6MzEyMwo+Pj4gaW9t
bXVfZGV2aWNlX3VudXNlX2RlZmF1bHRfZG9tYWluKzB4NjgvMHgxMDAKPj4+IFvCoCAzOTAuMDU2
NzEwXSBNb2R1bGVzIGxpbmtlZCBpbjogdmZpb19wY2kgdmZpb19wY2lfY29yZSB2ZmlvX3ZpcnFm
ZAo+Pj4gdmZpb19pb21tdV90eXBlMSB2ZmlvIHh0X0NIRUNLU1VNIHh0X01BU1FVRVJBREUgeHRf
Y29ubnRyYWNrIGlwdF9SRUpFQ1QKPj4+IG5mX3JlamVjdF9pcHY0IG5mdF9jb21wYXQgbmZ0X2No
YWluX25hdCBuZl9uYXQgbmZfY29ubnRyYWNrCj4+PiBuZl9kZWZyYWdfaXB2NiBuZl9kZWZyYWdf
aXB2NCBuZl90YWJsZXMgbmZuZXRsaW5rIGJyaWRnZSBzdHAgbGxjIHJma2lsbAo+Pj4gc3VucnBj
IHZmYXQgZmF0IG1seDVfaWIgaWJfdXZlcmJzIGliX2NvcmUgYWNwaV9pcG1pIGlwbWlfc3NpZgo+
Pj4gaXBtaV9kZXZpbnRmIGlwbWlfbXNnaGFuZGxlciBjcHBjX2NwdWZyZXEgZHJtIHhmcyBsaWJj
cmMzMmMKPj4+IG1seDVfY29yZSBzZwo+Pj4gbWx4ZncgY3JjdDEwZGlmX2NlIHRscyBnaGFzaF9j
ZSBzaGEyX2NlIHNoYTI1Nl9hcm02NCBzaGExX2NlIHNic2FfZ3dkdAo+Pj4gZTEwMDBlIHBzYW1w
bGUgc2RoY2lfYWNwaSBhaGNpX3BsYXRmb3JtIHNkaGNpIGxpYmFoY2lfcGxhdGZvcm0KPj4+IHFj
b21fZW1hYwo+Pj4gbW1jX2NvcmUgaGRtYSBoZG1hX21nbXQgZG1fbWlycm9yIGRtX3JlZ2lvbl9o
YXNoIGRtX2xvZyBkbV9tb2QgZnVzZQo+Pj4gW8KgIDM5MC4xMTA2MThdIENQVTogNDIgUElEOiA1
NTg5IENvbW06IHRlZSBLZHVtcDogbG9hZGVkIE5vdCB0YWludGVkCj4+PiA1LjE3LjAtcmM0LWx1
LXY3LW9mZmljaWFsKyAjMjQKPj4+IFvCoCAzOTAuMTE5Mzg0XSBIYXJkd2FyZSBuYW1lOiBXSVdZ
Tk4gUURGMjQwMCBSZWZlcmVuY2UgRXZhbHVhdGlvbgo+Pj4gUGxhdGZvcm0gQ1Y5MC1MQTExNS1Q
MTIwL1FERjI0MDAgQ3VzdG9tZXIgUmVmZXJlbmNlIEJvYXJkLCBCSU9TCj4+PiAwQUNKQTU3MAo+
Pj4gMTEvMDUvMjAxOAo+Pj4gW8KgIDM5MC4xMzI0OTJdIHBzdGF0ZTogYTA0MDAwMDUgKE56Q3Yg
ZGFpZiArUEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTCj4+PiBCVFlQRT0tLSkKPj4+IFvCoCAzOTAu
MTM5NDM2XSBwYyA6IGlvbW11X2RldmljZV91bnVzZV9kZWZhdWx0X2RvbWFpbisweDY4LzB4MTAw
Cj4+PiBbwqAgMzkwLjE0NTE2NV0gbHIgOiBpb21tdV9kZXZpY2VfdW51c2VfZGVmYXVsdF9kb21h
aW4rMHgzOC8weDEwMAo+Pj4gW8KgIDM5MC4xNTA4OTRdIHNwIDogZmZmZjgwMDAwZmJiM2JjMAo+
Pj4gW8KgIDM5MC4xNTQxOTNdIHgyOTogZmZmZjgwMDAwZmJiM2JjMCB4Mjg6IGZmZmYwM2MwY2Y2
YjI0MDAgeDI3Ogo+Pj4gMDAwMDAwMDAwMDAwMDAwMAo+Pj4gW8KgIDM5MC4xNjEzMTFdIHgyNjog
MDAwMDAwMDAwMDAwMDAwMCB4MjU6IDAwMDAwMDAwMDAwMDAwMDAgeDI0Ogo+Pj4gZmZmZjAzYzBj
N2NjNTcyMAo+Pj4gW8KgIDM5MC4xNjg0MjldIHgyMzogZmZmZjAzYzBjMmI5ZDE1MCB4MjI6IGZm
ZmZiNGU2MWRmMjIzZjggeDIxOgo+Pj4gZmZmZmI0ZTYxZGYyMjNmOAo+Pj4gW8KgIDM5MC4xNzU1
NDddIHgyMDogZmZmZjAzYzdjMDNjMzc1OCB4MTk6IGZmZmYwM2M3YzAzYzM3MDAgeDE4Ogo+Pj4g
MDAwMDAwMDAwMDAwMDAwMAo+Pj4gW8KgIDM5MC4xODI2NjVdIHgxNzogMDAwMDAwMDAwMDAwMDAw
MCB4MTY6IDAwMDAwMDAwMDAwMDAwMDAgeDE1Ogo+Pj4gMDAwMDAwMDAwMDAwMDAwMAo+Pj4gW8Kg
IDM5MC4xODk3ODNdIHgxNDogMDAwMDAwMDAwMDAwMDAwMCB4MTM6IDAwMDAwMDAwMDAwMDAwMzAg
eDEyOgo+Pj4gZmZmZjAzYzBkNTE5Y2Q4MAo+Pj4gW8KgIDM5MC4xOTY5MDFdIHgxMTogN2Y3Zjdm
N2Y3ZjdmN2Y3ZiB4MTA6IDAwMDAwMDAwMDAwMDBkYzAgeDkgOgo+Pj4gZmZmZmI0ZTYyMGI1NGY4
Ywo+Pj4gW8KgIDM5MC4yMDQwMTldIHg4IDogZmZmZjAzYzBjZjZiMzIyMCB4NyA6IGZmZmY0ZWYx
MzJiYmEwMDAgeDYgOgo+Pj4gMDAwMDAwMDAwMDAwMDBmZgo+Pj4gW8KgIDM5MC4yMTExMzddIHg1
IDogZmZmZjAzYzBjMmI5ZjEwOCB4NCA6IGZmZmYwM2MwZDUxZjY0MzggeDMgOgo+Pj4gMDAwMDAw
MDAwMDAwMDAwMAo+Pj4gW8KgIDM5MC4yMTgyNTVdIHgyIDogZmZmZjAzYzBjZjZiMjQwMCB4MSA6
IDAwMDAwMDAwMDAwMDAwMDAgeDAgOgo+Pj4gMDAwMDAwMDAwMDAwMDAwMAo+Pj4gW8KgIDM5MC4y
MjUzNzRdIENhbGwgdHJhY2U6Cj4+PiBbwqAgMzkwLjIyNzgwNF3CoCBpb21tdV9kZXZpY2VfdW51
c2VfZGVmYXVsdF9kb21haW4rMHg2OC8weDEwMAo+Pj4gW8KgIDM5MC4yMzMxODddwqAgcGNpX2Rt
YV9jbGVhbnVwKzB4MzgvMHg0NAo+Pj4gW8KgIDM5MC4yMzY5MTldwqAgX19kZXZpY2VfcmVsZWFz
ZV9kcml2ZXIrMHgxYTgvMHgyNjAKPj4+IFvCoCAzOTAuMjQxNTE5XcKgIGRldmljZV9kcml2ZXJf
ZGV0YWNoKzB4NTAvMHhkMAo+Pj4gW8KgIDM5MC4yNDU2ODZdwqAgdW5iaW5kX3N0b3JlKzB4Zjgv
MHgxMjAKPj4+IFvCoCAzOTAuMjQ5MjQ1XcKgIGRydl9hdHRyX3N0b3JlKzB4MzAvMHg0NAo+Pj4g
W8KgIDM5MC4yNTI4OTFdwqAgc3lzZnNfa2Zfd3JpdGUrMHg1MC8weDYwCj4+PiBbwqAgMzkwLjI1
NjUzN13CoCBrZXJuZnNfZm9wX3dyaXRlX2l0ZXIrMHgxMzQvMHgxY2MKPj4+IFvCoCAzOTAuMjYw
OTY0XcKgIG5ld19zeW5jX3dyaXRlKzB4ZjAvMHgxOGMKPj4+IFvCoCAzOTAuMjY0Njk2XcKgIHZm
c193cml0ZSsweDIzMC8weDJkMAo+Pj4gW8KgIDM5MC4yNjgwODJdwqAga3N5c193cml0ZSsweDc0
LzB4MTAwCj4+PiBbwqAgMzkwLjI3MTQ2N13CoCBfX2FybTY0X3N5c193cml0ZSsweDI4LzB4M2MK
Pj4+IFvCoCAzOTAuMjc1MzczXcKgIGludm9rZV9zeXNjYWxsLmNvbnN0cHJvcC4wKzB4NTgvMHhm
MAo+Pj4gW8KgIDM5MC4yODAwNjFdwqAgZWwwX3N2Y19jb21tb24uY29uc3Rwcm9wLjArMHgxNjAv
MHgxNjQKPj4+IFvCoCAzOTAuMjg0OTIyXcKgIGRvX2VsMF9zdmMrMHgzNC8weGNjCj4+PiBbwqAg
MzkwLjI4ODIyMV3CoCBlbDBfc3ZjKzB4MzAvMHgxNDAKPj4+IFvCoCAzOTAuMjkxMzQ2XcKgIGVs
MHRfNjRfc3luY19oYW5kbGVyKzB4YTQvMHgxMzAKPj4+IFvCoCAzOTAuMjk1NTk5XcKgIGVsMHRf
NjRfc3luYysweDFhMC8weDFhNAo+Pj4gW8KgIDM5MC4yOTkyNDVdIC0tLVsgZW5kIHRyYWNlIDAw
MDAwMDAwMDAwMDAwMDAgXS0tLQo+Pj4KPj4+Cj4+PiBJIHB1dCBzb21lIHRyYWNlcyBpbiB0aGUg
Y29kZSBhbmQgSSBjYW4gc2VlIHRoYXQKPj4+IGlvbW11X2RldmljZV91c2VfZGVmYXVsdF9kb21h
aW4oKSBlZmZlY3RpdmVseSBpcyBjYWxsZWQgb24KPj4+IDAwMDQ6MDE6MDAuMCBlMTAwMGUgZGV2
aWNlIG9uIHBjaV9kbWFfY29uZmlndXJlKCkgYnV0IGF0IHRoYXQgdGltZQo+Pj4gdGhlIGlvbW11
IGdyb3VwIGlzIE5VTEw6Cj4+PiBbwqDCoCAxMC41Njk0MjddIGUxMDAwZSAwMDA0OjAxOjAwLjA6
IC0tLS0tLSBFTlRSWSBwY2lfZG1hX2NvbmZpZ3VyZQo+Pj4gZHJpdmVyX21hbmFnZWRfYXJlYT0w
Cj4+PiBbwqDCoCAxMC41Njk0MzFdIGUxMDAwZSAwMDA0OjAxOjAwLjA6ICoqKioKPj4+IGlvbW11
X2RldmljZV91c2VfZGVmYXVsdF9kb21haW4gRU5UUlkKPj4+IFvCoMKgIDEwLjU2OTQzM10gZTEw
MDBlIDAwMDQ6MDE6MDAuMDogKioqKgo+Pj4gaW9tbXVfZGV2aWNlX3VzZV9kZWZhdWx0X2RvbWFp
biBubyBncm91cAo+Pj4gW8KgwqAgMTAuNTY5NDM1XSBlMTAwMGUgMDAwNDowMTowMC4wOiBwY2lf
ZG1hX2NvbmZpZ3VyZQo+Pj4gaW9tbXVfZGV2aWNlX3VzZV9kZWZhdWx0X2RvbWFpbiByZXR1cm5l
ZCAwCj4+PiBbwqDCoCAxMC41Njk0OTJdIGUxMDAwZSAwMDA0OjAxOjAwLjA6IEFkZGluZyB0byBp
b21tdSBncm91cCAzCj4+Pgo+Pj4gXl5edGhlIGdyb3VwIGlzIGFkZGVkIGFmdGVyIHRoZQo+Pj4g
aW9tbXVfZGV2aWNlX3VzZV9kZWZhdWx0X2RvbWFpbigpIGNhbGwKPj4+IFNvIHRoZSBncm91cC0+
b3duZXJfY250IGlzIG5vdCBpbmNyZW1lbnRlZCBhcyBleHBlY3RlZC4KPj4KPj4gVGhhbmsgeW91
IGZvciByZXBvcnRpbmcgdGhpcy4gRG8geW91IGhhdmUgYW55IGlkZWEgd2h5IHRoZSBkcml2ZXIg
aXMKPj4gbG9hZGVkIGJlZm9yZSBpb21tdV9wcm9iZV9kZXZpY2UoKT8KPgo+IFVyZ2gsIHRoaXMg
aXMgdGhlIGhvcnJpYmxlIGZpcm13YXJlLWRhdGEtb3JkZXJpbmcgdGhpbmcgYWdhaW4uIFRoZQo+
IHN0dWZmIEkndmUgYmVlbiBzYXlpbmcgYWJvdXQgaGF2aW5nIHRvIHJld29yayB0aGUgd2hvbGUg
LmRtYV9jb25maWd1cmUKPiBtZWNoYW5pc20gaW4gdGhlIG5lYXIgZnV0dXJlIGlzIHRvIGZpeCB0
aGlzIHByb3Blcmx5Lgo+Cj4gVGhlIHN1bW1hcnkgaXMgdGhhdCBpbiBwYXRjaCAjNCwgY2FsbGlu
Zwo+IGlvbW11X2RldmljZV91c2VfZGVmYXVsdF9kb21haW4oKSAqYmVmb3JlKiB7b2YsYWNwaX1f
ZG1hX2NvbmZpZ3VyZSBpcwo+IGN1cnJlbnRseSBhIHByb2JsZW0uIEFzIHRoaW5ncyBzdGFuZCwg
dGhlIElPTU1VIGRyaXZlciBpZ25vcmVkIHRoZQo+IGluaXRpYWwgaW9tbXVfcHJvYmVfZGV2aWNl
KCkgY2FsbCB3aGVuIHRoZSBkZXZpY2Ugd2FzIGFkZGVkLCBzaW5jZSBhdAo+IHRoYXQgcG9pbnQg
aXQgaGFkIG5vIGZ3c3BlYyB5ZXQuIEluIHRoaXMgc2l0dWF0aW9uLAo+IHtvZixhY3BpfV9pb21t
dV9jb25maWd1cmUoKSBhcmUgcmV0cmlnZ2VyaW5nIGlvbW11X3Byb2JlX2RldmljZSgpCj4gYWZ0
ZXIgdGhlIElPTU1VIGRyaXZlciBoYXMgc2VlbiB0aGUgZmlybXdhcmUgZGF0YSB2aWEgLm9mX3hs
YXRlIHRvCj4gbGVhcm4gdGhhdCBpdCBpdCBhY3R1YWxseSByZXNwb25zaWJsZSBmb3IgdGhlIGdp
dmVuIGRldmljZS4KCnRoYW5rIHlvdSBmb3IgcHJvdmlkaW5nIHRoZSBpbmZvLiBIb3BlIHRoaXMg
aXMgc29tZXRoaW5nIEx1IGNhbiB3b3JrIGFyb3VuZC4KClRoYW5rcyEKCkVyaWMKPgo+IFJvYmlu
Lgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
