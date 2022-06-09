Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E888C43334
	for <iommu@archiver.kernel.org>; Thu,  9 Jun 2022 08:00:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 278BD40BE9;
	Thu,  9 Jun 2022 08:00:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LckoXnXoeeFA; Thu,  9 Jun 2022 08:00:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0A2F1401A2;
	Thu,  9 Jun 2022 08:00:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9EC1C0032;
	Thu,  9 Jun 2022 08:00:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E47A3C002D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 08:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C55B940182
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 08:00:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CxFIZ7lPdxE3 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 08:00:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com
 [199.106.114.38])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2EC940BEA
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 08:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1654761643; x=1686297643;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=e1UGClnaUgzCb1brsqptliKGNl+O+10vLwIjpGp/hgo=;
 b=CecnOctvlARq4gRCh8VwoRe0C/0yDOUcFBxQwwkvqFi7+zyPwDItclGf
 T8fnHUh6DNgSi5cmyHLpk1lIHoAksf/d5RBBht74COryYVli90XbVGyEf
 ZB9k2tO8fGNrerbpckz+zSZX1QH70oJktO55g24fZ8D9WpnggvSWoeGJA U=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Jun 2022 01:00:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2022 01:00:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 9 Jun 2022 01:00:12 -0700
Received: from [10.50.50.196] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 9 Jun 2022
 01:00:08 -0700
Message-ID: <231dd355-acf3-626f-3da0-350281c660f5@quicinc.com>
Date: Thu, 9 Jun 2022 13:30:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv2] iommu/arm-smmu-qcom: Add debug support for TLB sync
 timeouts
Content-Language: en-US
To: Vincent Knecht <vincent.knecht@mailoo.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
References: <20220526041403.9984-1-quic_saipraka@quicinc.com>
 <78f1adee5c6e0c3547c116d0e78fe5b70f9c15e1.camel@mailoo.org>
From: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <78f1adee5c6e0c3547c116d0e78fe5b70f9c15e1.camel@mailoo.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 quic_guptap@quicinc.com, linux-arm-kernel@lists.infradead.org
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

SGkgVmluY2VudCwKCk9uIDYvOS8yMDIyIDI6NTIgQU0sIFZpbmNlbnQgS25lY2h0IHdyb3RlOgo+
IExlIGpldWRpIDI2IG1haSAyMDIyIMOgIDA5OjQ0ICswNTMwLCBTYWkgUHJha2FzaCBSYW5qYW4g
YSDDqWNyaXTCoDoKPj4gVExCIHN5bmMgdGltZW91dHMgY2FuIGJlIGR1ZSB0byB2YXJpb3VzIHJl
YXNvbnMgc3VjaCBhcyBUQlUgcG93ZXIgZG93bgo+PiBvciBwZW5kaW5nIFRDVS9UQlUgaW52YWxp
ZGF0aW9uL3N5bmMgYW5kIHNvIG9uLiBEZWJ1Z2dpbmcgdGhlc2Ugb2Z0ZW4KPj4gcmVxdWlyZSBk
dW1waW5nIG9mIHNvbWUgaW1wbGVtZW50YXRpb24gZGVmaW5lZCByZWdpc3RlcnMgdG8ga25vdyB0
aGUKPj4gc3RhdHVzIG9mIFRCVS9UQ1Ugb3BlcmF0aW9ucyBhbmQgc29tZSBvZiB0aGVzZSByZWdp
c3RlcnMgYXJlIG5vdAo+PiBhY2Nlc3NpYmxlIGluIG5vbi1zZWN1cmUgd29ybGQgc3VjaCBhcyBm
cm9tIGtlcm5lbCBhbmQgcmVxdWlyZXMgU01DCj4+IGNhbGxzIHRvIHJlYWQgdGhlbSBpbiB0aGUg
c2VjdXJlIHdvcmxkLiBTbywgYWRkIHRoaXMgZGVidWcgc3VwcG9ydAo+PiB0byBkdW1wIGltcGxl
bWVudGF0aW9uIGRlZmluZWQgcmVnaXN0ZXJzIGZvciBUTEIgc3luYyB0aW1lb3V0IGlzc3Vlcy4K
Pj4KPj4gU2lnbmVkLW9mZi1ieTogU2FpIFByYWthc2ggUmFuamFuIDxxdWljX3NhaXByYWthQHF1
aWNpbmMuY29tPgo+PiAtLS0KPj4KPj4gQ2hhbmdlcyBpbiB2MjoKPj4gIMKgKiBVc2Ugc2NtIGNh
bGwgY29uc2lzdGVudGx5IHNvIHRoYXQgaXQgd29ya3Mgb24gb2xkZXIgY2hpcHNldHMgd2hlcmUK
Pj4gIMKgwqAgc29tZSBvZiB0aGVzZSByZWdzIGFyZSBzZWN1cmUgcmVnaXN0ZXJzLgo+PiAgwqAq
IEFkZCBkZXZpY2Ugc3BlY2lmaWMgZGF0YSB0byBnZXQgdGhlIGltcGxlbWVudGF0aW9uIGRlZmlu
ZWQgcmVnaXN0ZXIKPj4gIMKgwqAgb2Zmc2V0cy4KPj4KPj4gLS0tCj4+ICDCoGRyaXZlcnMvaW9t
bXUvYXJtL2FybS1zbW11L2FybS1zbW11LXFjb20uYyB8IDE2MSArKysrKysrKysrKysrKysrKyst
LS0KPj4gIMKgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuY8KgwqDCoMKgwqAg
fMKgwqAgMiArCj4+ICDCoGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmjCoMKg
wqDCoMKgIHzCoMKgIDEgKwo+PiAgwqAzIGZpbGVzIGNoYW5nZWQsIDE0NiBpbnNlcnRpb25zKCsp
LCAxOCBkZWxldGlvbnMoLSkKPiBIaSBTYWksIGFuZCB0aGFua3MgZm9yIHRoaXMgcGF0Y2ggIQo+
Cj4gSSd2ZSBlbmNvdW50ZXJlZCBUTEIgc3luYyB0aW1lb3V0cyB3aXRoIG1zbTg5MzkgU29DIHJl
Y2VudGx5Lgo+IFdoYXQgd291bGQgYmUgbmVlZGVkIHRvIGFkZCB0byB0aGlzIHBhdGNoIHNvIHRo
aXMgU29DIGlzIHN1cHBvcnRlZCA/Cj4gTGlrZSwgd2hlcmUgY291bGQgb25lIGNoZWNrIHRoZSB2
YWx1ZXMgdG8gYmUgdXNlZCBpbiBhbiBlcXVpdmFsZW50Cj4gb2YgcWNvbV9zbW11X2ltcGwwX3Jl
Z19vZmZzZXQgdmFsdWVzIGZvciB0aGlzIFNvQyAoaWYgYW55IGNoYW5nZSBuZWVkZWQpID8KPiBD
dXJyZW50IHZhbHVlcyBhcmUgbm90IGZvdW5kIGJ5IHNpbXBseSBncmVwaW5nIGluIGRvd25zdHJl
YW0vdmVuZG9yIGR0c2kvZHRzIGZpbGVzLi4uCgpUaGVzZSBhcmUgaW1wbGVtZW50YXRpb24gZGVm
aW5lZCByZWdpc3RlcnMgYW5kIHNvbWUgbWlnaHQgbm90IGJlIHByZXNlbnQgb24gb2xkZXIgU29D
cwphbmQgc29tZXRpbWVzIHRoZXkgZG9uJ3QgYWRkIHRoaXMgc3VwcG9ydCBpbiBkb3duc3RyZWFt
IGtlcm5lbHMgZXZlbiBpZiB0aGUgcmVnaXN0ZXJzCmFyZSBwcmVzZW50LgoKSSBsb29rZWQgdXAg
dGhlIElQIGRvYyBmb3IgbXNtODkzOSBhbmQgSSBjb3VsZCBmaW5kIG9ubHkgVEJVX1BXUl9TVEFU
VVMgcmVnaXN0ZXIgYW5kCnlvdSBjYW4gdXNlIHRoZSBzYW1lIG9mZnNldCBmb3IgaXQgYXMgZ2l2
ZW4gaW4gdGhpcyBwYXRjaC4KClRoYW5rcywKU2FpCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
