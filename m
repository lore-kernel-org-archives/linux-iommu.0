Return-Path: <SRS0=eKRE=6H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8ADC2BA19
	for <iommu@archiver.kernel.org>; Thu, 23 Apr 2020 09:29:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA272076C
	for <iommu@archiver.kernel.org>; Thu, 23 Apr 2020 09:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA272076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AD3CE227A3;
	Thu, 23 Apr 2020 09:29:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vhxekCt95jeq; Thu, 23 Apr 2020 09:29:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 71BBB20117;
	Thu, 23 Apr 2020 09:29:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5556CC1AE2;
	Thu, 23 Apr 2020 09:29:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC059C0175
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 09:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AA6548616A
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 09:29:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o9C35W8muaim for <iommu@lists.linux-foundation.org>;
 Thu, 23 Apr 2020 09:29:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D22EF85E69
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 09:29:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 011BA31B;
 Thu, 23 Apr 2020 02:29:00 -0700 (PDT)
Received: from [10.57.33.170] (unknown [10.57.33.170])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9E633F73D;
 Thu, 23 Apr 2020 02:28:58 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu: Demote error messages to debug in
 shutdown callback
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Doug Anderson <dianders@chromium.org>, Will Deacon <will@kernel.org>
References: <20200327132852.10352-1-saiprakash.ranjan@codeaurora.org>
 <0023bc68-45fb-4e80-00c8-01fd0369243f@arm.com>
 <37db9a4d524aa4d7529ae47a8065c9e0@codeaurora.org>
 <5858bdac-b7f9-ac26-0c0d-c9653cef841d@arm.com>
 <d60196b548e1241b8334fadd0e8c2fb5@codeaurora.org>
 <CAD=FV=WXTN6xxqtL6d6MHxG8Epuo6FSQERRPfnoSCskhjh1KeQ@mail.gmail.com>
 <890456524e2df548ba5d44752513a62c@codeaurora.org>
 <20200331074400.GB25612@willie-the-truck>
 <1bf04938249bcd5b2111c1921facfd25@codeaurora.org>
 <CAD=FV=VBM6cS1UmWTUJ2vrt0a2zn7xV3C53tpthBx58M2=1JPg@mail.gmail.com>
 <6c82e688f335b9c07b0f52987244664b@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <006edb3b-8834-41fe-d9d1-fe873edfca99@arm.com>
Date: Thu, 23 Apr 2020 10:28:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6c82e688f335b9c07b0f52987244664b@codeaurora.org>
Content-Language: en-GB
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 linux-arm-msm-owner@vger.kernel.org, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>
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

T24gMjAyMC0wNC0yMyA5OjE3IGFtLCBTYWkgUHJha2FzaCBSYW5qYW4gd3JvdGU6ClsuLi5dCj4+
IEFueSB1cGRhdGUgb24gdGhlIHN0YXR1cyBoZXJlP8KgIElmIEknbSByZWFkaW5nIHRoZSBjb252
ZXJzYXRpb24gYWJvdmUsCj4+IFJvYmluIHNhaWQ6ICJ3ZSdsbCAqYWx3YXlzKiBzZWUgdGhlIHdh
cm5pbmcgYmVjYXVzZSB0aGVyZSdzIG5vIHdheSB0bwo+PiB0ZWFyIGRvd24gdGhlIGRlZmF1bHQg
RE1BIGRvbWFpbnMsIGFuZCBldmVuIGlmIGFsbCBkZXZpY2VzICpoYXZlKiBiZWVuCj4+IG5pY2Vs
eSBxdWllc2NlZCB0aGVyZSdzIG5vIHdheSB0byB0ZWxsIi7CoCBEaWQgSSB1bmRlcnN0YW5kIHRo
YXQKPj4gcHJvcGVybHk/wqAgSWYgc28sIGl0IHNlZW1zIGxpa2UgaXQncyBmdWxseSBleHBlY3Rl
ZCB0byBzZWUgdGhpcwo+PiBtZXNzYWdlIG9uIGV2ZXJ5IHJlYm9vdCBhbmQgaXQgZG9lc24ndCBu
ZWNlc3NhcmlseSBzaWduaWZ5IGFueXRoaW5nCj4+IGJhZC4KPj4KPiAKPiBVbmRlcnN0YW5kaW5n
IGlzIHRoZSBzYW1lLCB3YWl0aW5nIGZvciBXaWxsIGFuZCBSb2JpbiB0byBjaGVjayBpZiBpdHMg
T0sKPiB0byBtYWtlIHRoZSBtZXNzYWdlIG1vcmUgZnJpZW5kbHkuCgpUaGUgd2F5IEkgc2VlIGl0
LCB3ZSBlc3NlbnRpYWxseSBqdXN0IHdhbnQgKnNvbWV0aGluZyogdmlzaWJsZSB0aGF0IHdpbGwg
CmNvcnJlbGF0ZSB3aXRoIGFueSBtaXNiZWhhdmlvdXIgdGhhdCAqbWlnaHQqIHJlc3VsdCBmcm9t
IHR1cm5pbmcgb2ZmIGEgCnBvc3NpYmx5LWxpdmUgY29udGV4dC4gSG93IGFib3V0IHNpbXBseSAi
ZGlzYWJsaW5nIHRyYW5zbGF0aW9uIiwgYXQgCmRldl93YXJuIG9yIGRldl9pbmZvIGxldmVsPwoK
Um9iaW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
