Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6699C43334
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 11:58:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3B68640610;
	Wed, 29 Jun 2022 11:58:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B68640610
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SU6ifBLTbqRs; Wed, 29 Jun 2022 11:58:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F0AE040002;
	Wed, 29 Jun 2022 11:58:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F0AE040002
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1153C0039;
	Wed, 29 Jun 2022 11:58:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04CE6C002D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 11:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E0EFF410A5
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 11:57:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0EFF410A5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8yKsk4_hevyH for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 11:57:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 826CA409FE
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 826CA409FE
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 11:57:57 +0000 (UTC)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LY0Lr1xbbz67yhs;
 Wed, 29 Jun 2022 19:57:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 13:57:53 +0200
Received: from [10.195.245.77] (10.195.245.77) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 12:57:52 +0100
Message-ID: <416ebe33-28ed-eef0-0001-83efd83a9d0f@huawei.com>
Date: Wed, 29 Jun 2022 12:57:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 1/5] dma-mapping: Add dma_opt_mapping_size()
To: Robin Murphy <robin.murphy@arm.com>
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-2-git-send-email-john.garry@huawei.com>
 <bbca5df5-8681-d6d9-201d-3d48b34e3001@arm.com>
 <a2e717d0-c3e2-ea98-9d8b-cee1fd37c117@huawei.com>
In-Reply-To: <a2e717d0-c3e2-ea98-9d8b-cee1fd37c117@huawei.com>
X-Originating-IP: [10.195.245.77]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-doc@vger.kernel.org, will@kernel.org, damien.lemoal@opensource.wdc.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linuxarm@huawei.com, linux-ide@vger.kernel.org, iommu@lists.linux.dev,
 hch@lst.de, jejb@linux.ibm.com
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjgvMDYvMjAyMiAxMjoyNywgSm9obiBHYXJyeSB2aWEgaW9tbXUgd3JvdGU6Cj4gT24gMjgv
MDYvMjAyMiAxMjoyMywgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4gKwo+Pj4gK8KgwqDCoCBzaXpl
X3QKPj4+ICvCoMKgwqAgZG1hX29wdF9tYXBwaW5nX3NpemUoc3RydWN0IGRldmljZSAqZGV2KTsK
Pj4+ICsKPj4+ICtSZXR1cm5zIHRoZSBtYXhpbXVtIG9wdGltYWwgc2l6ZSBvZiBhIG1hcHBpbmcg
Zm9yIHRoZSBkZXZpY2UuIAo+Pj4gTWFwcGluZyBsYXJnZQo+Pj4gK2J1ZmZlcnMgbWF5IHRha2Ug
bG9uZ2VyIHNvIGRldmljZSBkcml2ZXJzIGFyZSBhZHZpc2VkIHRvIGxpbWl0IHRvdGFsIAo+Pj4g
RE1BCj4+PiArc3RyZWFtaW5nIG1hcHBpbmdzIGxlbmd0aCB0byB0aGUgcmV0dXJuZWQgdmFsdWUu
Cj4+Cj4+IE5pdDogSSdtIG5vdCBzdXJlICJhZHZpc2VkIiBpcyBuZWNlc3NhcmlseSB0aGUgcmln
aHQgdGhpbmcgdG8gc2F5IGluIAo+PiBnZW5lcmFsIC0gdGhhdCdzIG9ubHkgcmVhbGx5IHRydWUg
Zm9yIGEgY2FsbGVyIHdobyBjYXJlcyBhYm91dCAKPj4gdGhyb3VnaHB1dCBvZiBjaHVybmluZyB0
aHJvdWdoIHNob3J0LWxpdmVkIG1hcHBpbmdzIG1vcmUgdGhhbiBhbnl0aGluZyAKPj4gZWxzZSwg
YW5kIGRvZXNuJ3QgdGFrZSBhIHNpZ25pZmljYW50IGhpdCBvdmVyYWxsIGZyb20gc3BsaXR0aW5n
IHVwIAo+PiBsYXJnZXIgcmVxdWVzdHMuIEkgZG8gdGhpbmsgaXQncyBnb29kIHRvIGNsYXJpZnkg
dGhlIGV4YWN0IGNvbnRleHQgb2YgCj4+ICJvcHRpbWFsIiBoZXJlLCBidXQgSSdkIHByZWZlciB0
byBiZSBvYmplY3RpdmVseSBjbGVhciB0aGF0IGl0J3MgZm9yIAo+PiB3b3JrbG9hZHMgd2hlcmUg
dGhlIHVwLWZyb250IG1hcHBpbmcgb3ZlcmhlYWQgZG9taW5hdGVzLgo+IApJJ20gZ29pbmcgdG8g
Z28gd2l0aCBzb21ldGhpbmcgbGlrZSB0aGlzOgoKc2l6ZV90CmRtYV9vcHRfbWFwcGluZ19zaXpl
KHN0cnVjdCBkZXZpY2UgKmRldik7CgpSZXR1cm5zIHRoZSBtYXhpbXVtIG9wdGltYWwgc2l6ZSBv
ZiBhIG1hcHBpbmcgZm9yIHRoZSBkZXZpY2UuCgpNYXBwaW5nIGxhcmdlciBidWZmZXJzIG1heSB0
YWtlIG11Y2ggbG9uZ2VyIGluIGNlcnRhaW4gc2NlbmFyaW9zLiBJbiAKYWRkaXRpb24sIGZvciBo
aWdoLXJhdGUgc2hvcnQtbGl2ZWQgc3RyZWFtaW5nIG1hcHBpbmdzIHRoZSB1cGZyb250IHRpbWUg
CnNwZW50IG9uIHRoZSBtYXBwaW5nIG1heSBhY2NvdW50IGZvciBhbiBhcHByZWNpYWJsZSBwYXJ0
IG9mIHRoZSB0b3RhbCAKcmVxdWVzdCBsaWZldGltZS4gQXMgc3VjaCwgaWYgc3BsaXR0aW5nIGxh
cmdlciByZXF1ZXN0cyBpbmN1cnMgbm8gCnNpZ25pZmljYW50IHBlcmZvcm1hbmNlIHBlbmFsdHks
IHRoZW4gZGV2aWNlIGRyaXZlcnMgYXJlIGFkdmlzZWQgdG8gCmxpbWl0IHRvdGFsIERNQSBzdHJl
YW1pbmcgbWFwcGluZ3MgbGVuZ3RoIHRvIHRoZSByZXR1cm5lZCB2YWx1ZS4KCkxldCBtZSBrbm93
IGlmIHlvdSB3b3VsZCBsaWtlIGl0IGZ1cnRoZXIgYW1lbmRlZC4KCkNoZWVycywKSm9obgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
