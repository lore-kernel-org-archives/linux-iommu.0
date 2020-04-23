Return-Path: <SRS0=eKRE=6H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70723C55186
	for <iommu@archiver.kernel.org>; Thu, 23 Apr 2020 09:41:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B3E2077D
	for <iommu@archiver.kernel.org>; Thu, 23 Apr 2020 09:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="F6bTYix8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B3E2077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 08F3786BC9;
	Thu, 23 Apr 2020 09:41:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BSWyO1c7VrTK; Thu, 23 Apr 2020 09:41:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7CBCB86BB5;
	Thu, 23 Apr 2020 09:41:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A420C1AE2;
	Thu, 23 Apr 2020 09:41:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D86AC0175
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 09:41:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 724DF86BB5
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 09:41:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JhQlXp_a1vi7 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Apr 2020 09:41:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F2CF186BC9
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 09:41:08 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1587634870; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=X4JlYBXDzz9vV+CUfgeK/NaJLq5Ep+S6sMu6NUItr0I=;
 b=F6bTYix8UURvQj8HRLAS/UurEgHLt8oTYrhtgY3F/Kh9O5KRSy3llssk9DAkcdrSu8EewR3R
 dK+h07xHTXwK8ihab+4oowJ/K+3HVoQIL8cWlFPLd1ODxOm/kIMCazn6zti7DYQ89vtHdjRJ
 Xz2ubV5Hphw94opwS+/jZgz9ffU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea162b0.7f00987d2b58-smtp-out-n01;
 Thu, 23 Apr 2020 09:41:04 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id C1081C432C2; Thu, 23 Apr 2020 09:41:03 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C107C433CB;
 Thu, 23 Apr 2020 09:41:03 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 23 Apr 2020 15:11:03 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu: Demote error messages to debug in
 shutdown callback
In-Reply-To: <006edb3b-8834-41fe-d9d1-fe873edfca99@arm.com>
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
 <006edb3b-8834-41fe-d9d1-fe873edfca99@arm.com>
Message-ID: <685e51afcf8f89c2d8e225716a57b67a@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Doug Anderson <dianders@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-arm-msm-owner@vger.kernel.org
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

T24gMjAyMC0wNC0yMyAxNDo1OCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMDQtMjMg
OToxNyBhbSwgU2FpIFByYWthc2ggUmFuamFuIHdyb3RlOgo+IFsuLi5dCj4+PiBBbnkgdXBkYXRl
IG9uIHRoZSBzdGF0dXMgaGVyZT/CoCBJZiBJJ20gcmVhZGluZyB0aGUgY29udmVyc2F0aW9uIAo+
Pj4gYWJvdmUsCj4+PiBSb2JpbiBzYWlkOiAid2UnbGwgKmFsd2F5cyogc2VlIHRoZSB3YXJuaW5n
IGJlY2F1c2UgdGhlcmUncyBubyB3YXkgdG8KPj4+IHRlYXIgZG93biB0aGUgZGVmYXVsdCBETUEg
ZG9tYWlucywgYW5kIGV2ZW4gaWYgYWxsIGRldmljZXMgKmhhdmUqIAo+Pj4gYmVlbgo+Pj4gbmlj
ZWx5IHF1aWVzY2VkIHRoZXJlJ3Mgbm8gd2F5IHRvIHRlbGwiLsKgIERpZCBJIHVuZGVyc3RhbmQg
dGhhdAo+Pj4gcHJvcGVybHk/wqAgSWYgc28sIGl0IHNlZW1zIGxpa2UgaXQncyBmdWxseSBleHBl
Y3RlZCB0byBzZWUgdGhpcwo+Pj4gbWVzc2FnZSBvbiBldmVyeSByZWJvb3QgYW5kIGl0IGRvZXNu
J3QgbmVjZXNzYXJpbHkgc2lnbmlmeSBhbnl0aGluZwo+Pj4gYmFkLgo+Pj4gCj4+IAo+PiBVbmRl
cnN0YW5kaW5nIGlzIHRoZSBzYW1lLCB3YWl0aW5nIGZvciBXaWxsIGFuZCBSb2JpbiB0byBjaGVj
ayBpZiBpdHMgCj4+IE9LCj4+IHRvIG1ha2UgdGhlIG1lc3NhZ2UgbW9yZSBmcmllbmRseS4KPiAK
PiBUaGUgd2F5IEkgc2VlIGl0LCB3ZSBlc3NlbnRpYWxseSBqdXN0IHdhbnQgKnNvbWV0aGluZyog
dmlzaWJsZSB0aGF0Cj4gd2lsbCBjb3JyZWxhdGUgd2l0aCBhbnkgbWlzYmVoYXZpb3VyIHRoYXQg
Km1pZ2h0KiByZXN1bHQgZnJvbSB0dXJuaW5nCj4gb2ZmIGEgcG9zc2libHktbGl2ZSBjb250ZXh0
LiBIb3cgYWJvdXQgc2ltcGx5ICJkaXNhYmxpbmcgdHJhbnNsYXRpb24iLAo+IGF0IGRldl93YXJu
IG9yIGRldl9pbmZvIGxldmVsPwo+IAoKClNvdW5kcyBnb29kLCBJJ2xsIGdvIHdpdGggZGlzYWJs
aW5nIHRyYW5zbGF0aW9uIHdpdGggZGV2X2luZm8uCgpUaGFua3MsClNhaQotLSAKUVVBTENPTU0g
SU5ESUEsIG9uIGJlaGFsZiBvZiBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBpcyBh
IAptZW1iZXIKb2YgQ29kZSBBdXJvcmEgRm9ydW0sIGhvc3RlZCBieSBUaGUgTGludXggRm91bmRh
dGlvbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
