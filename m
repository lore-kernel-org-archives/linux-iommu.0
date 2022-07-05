Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B3BC43334
	for <iommu@archiver.kernel.org>; Tue,  5 Jul 2022 05:06:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F111F4168B;
	Tue,  5 Jul 2022 05:06:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F111F4168B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.a=rsa-sha256 header.s=qcdkim header.b=Qg/8jIG5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9bhyAFjk5u0U; Tue,  5 Jul 2022 05:06:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 725784150E;
	Tue,  5 Jul 2022 05:06:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 725784150E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44DC3C0032;
	Tue,  5 Jul 2022 05:06:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CFD9C002D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 05:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 64EEC82451
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 05:06:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64EEC82451
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.a=rsa-sha256 header.s=qcdkim header.b=Qg/8jIG5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lI7h8xs1K0L6 for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 05:06:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6DC8A8242D
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com
 [199.106.114.38])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6DC8A8242D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 05:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1656997560; x=1688533560;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=PAfrv6obJNhFhvY8AejIU454yGvN0bvGjWO9B1hF+c8=;
 b=Qg/8jIG5JHTH6xogOjI53NST7J8AYIHRRQFiB4b8+K+DDot7Hgjcz0Bw
 NmlYG5okae+N5/QDEuqc+zwh7+UW8yEQ8/SaXzcwbybn0HyvkmEDD9S56
 nHdZs44OwjdKxvjDU6+nvnIiJJTW6sSrM2CWNYYwxE9kZOXK8WHDpx08L w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 04 Jul 2022 22:05:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2022 22:05:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 22:05:58 -0700
Received: from [10.50.56.53] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 4 Jul 2022
 22:05:54 -0700
Message-ID: <00e8622a-915b-b5e0-12cd-78bb6a2758c9@quicinc.com>
Date: Tue, 5 Jul 2022 10:35:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv2] iommu/arm-smmu-qcom: Add debug support for TLB sync
 timeouts
Content-Language: en-US
From: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>
References: <20220526041403.9984-1-quic_saipraka@quicinc.com>
 <21d5fc44-4870-02bb-70b4-d9e1188c9cc1@quicinc.com>
In-Reply-To: <21d5fc44-4870-02bb-70b4-d9e1188c9cc1@quicinc.com>
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

T24gNi8yMy8yMDIyIDExOjMyIEFNLCBTYWkgUHJha2FzaCBSYW5qYW4gd3JvdGU6Cj4gT24gNS8y
Ni8yMDIyIDk6NDQgQU0sIFNhaSBQcmFrYXNoIFJhbmphbiB3cm90ZToKPj4gVExCIHN5bmMgdGlt
ZW91dHMgY2FuIGJlIGR1ZSB0byB2YXJpb3VzIHJlYXNvbnMgc3VjaCBhcyBUQlUgcG93ZXIgZG93
bgo+PiBvciBwZW5kaW5nIFRDVS9UQlUgaW52YWxpZGF0aW9uL3N5bmMgYW5kIHNvIG9uLiBEZWJ1
Z2dpbmcgdGhlc2Ugb2Z0ZW4KPj4gcmVxdWlyZSBkdW1waW5nIG9mIHNvbWUgaW1wbGVtZW50YXRp
b24gZGVmaW5lZCByZWdpc3RlcnMgdG8ga25vdyB0aGUKPj4gc3RhdHVzIG9mIFRCVS9UQ1Ugb3Bl
cmF0aW9ucyBhbmQgc29tZSBvZiB0aGVzZSByZWdpc3RlcnMgYXJlIG5vdAo+PiBhY2Nlc3NpYmxl
IGluIG5vbi1zZWN1cmUgd29ybGQgc3VjaCBhcyBmcm9tIGtlcm5lbCBhbmQgcmVxdWlyZXMgU01D
Cj4+IGNhbGxzIHRvIHJlYWQgdGhlbSBpbiB0aGUgc2VjdXJlIHdvcmxkLiBTbywgYWRkIHRoaXMg
ZGVidWcgc3VwcG9ydAo+PiB0byBkdW1wIGltcGxlbWVudGF0aW9uIGRlZmluZWQgcmVnaXN0ZXJz
IGZvciBUTEIgc3luYyB0aW1lb3V0IGlzc3Vlcy4KPj4KPj4gU2lnbmVkLW9mZi1ieTogU2FpIFBy
YWthc2ggUmFuamFuIDxxdWljX3NhaXByYWthQHF1aWNpbmMuY29tPgo+PiAtLS0KPj4KPj4gQ2hh
bmdlcyBpbiB2MjoKPj4gwqAgKiBVc2Ugc2NtIGNhbGwgY29uc2lzdGVudGx5IHNvIHRoYXQgaXQg
d29ya3Mgb24gb2xkZXIgY2hpcHNldHMgd2hlcmUKPj4gwqDCoMKgIHNvbWUgb2YgdGhlc2UgcmVn
cyBhcmUgc2VjdXJlIHJlZ2lzdGVycy4KPj4gwqAgKiBBZGQgZGV2aWNlIHNwZWNpZmljIGRhdGEg
dG8gZ2V0IHRoZSBpbXBsZW1lbnRhdGlvbiBkZWZpbmVkIHJlZ2lzdGVyCj4+IMKgwqDCoCBvZmZz
ZXRzLgo+Pgo+PiAtLS0KPj4gwqAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUt
cWNvbS5jIHwgMTYxICsrKysrKysrKysrKysrKysrKy0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L2Fy
bS9hcm0tc21tdS9hcm0tc21tdS5jwqDCoMKgwqDCoCB8wqDCoCAyICsKPj4gwqAgZHJpdmVycy9p
b21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuaMKgwqDCoMKgwqAgfMKgwqAgMSArCj4+IMKgIDMg
ZmlsZXMgY2hhbmdlZCwgMTQ2IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQo+Cj4gQW55
IGNvbW1lbnRzIG9uIHRoaXMgcGF0Y2g/CgpHZW50bGUgUGluZyAhIQoKVGhhbmtzLApTYWkKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
