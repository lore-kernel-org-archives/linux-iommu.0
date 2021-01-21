Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179E1C433E6
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 12:57:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D28239FF
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 12:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D28239FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DF533214EB;
	Thu, 21 Jan 2021 12:57:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OqTxVSGcBsIh; Thu, 21 Jan 2021 12:57:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 46BBB20530;
	Thu, 21 Jan 2021 12:57:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35D93C08A1;
	Thu, 21 Jan 2021 12:57:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01209C013A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 12:57:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DB1E4207A8
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 12:57:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YfiWDuR09Kyy for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 12:57:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 7D3FC20530
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 12:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611233836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/QDx1uICxO7SRgcCMtNojL+VasBQOuT1uJCUPAbo6Y=;
 b=Jq/T29SmpvJLM4IXN1CthZQIZ6Tc4jTp9cMvmyCtvRz6eVh27VpGEaVr25qYajG6MoKXM6
 eXH8dN2xpRpxQAgmwjvP5lDXyIZd7oRjR8pR4CzU5MY8znCxGrVNndQ9GRYZlN8zvaBH+1
 wcK+QOTva2oBFMjawvNLsJ5/gB4XpWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-LBeykFJWPiqHrgC7_AUeUQ-1; Thu, 21 Jan 2021 07:57:14 -0500
X-MC-Unique: LBeykFJWPiqHrgC7_AUeUQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CCFB19611AD;
 Thu, 21 Jan 2021 12:57:13 +0000 (UTC)
Received: from [10.72.12.73] (ovpn-12-73.pek2.redhat.com [10.72.12.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76DDB60C6D;
 Thu, 21 Jan 2021 12:57:10 +0000 (UTC)
Subject: Re: [PATCH 2/2 v2] iommu: use the __iommu_attach_device() directly
 for deferred attach
To: Christoph Hellwig <hch@infradead.org>
References: <20210119111616.12761-1-lijiang@redhat.com>
 <20210119111616.12761-3-lijiang@redhat.com>
 <20210119152939.GB3453587@infradead.org>
From: lijiang <lijiang@redhat.com>
Message-ID: <0ee9d0a5-25f7-60ce-e6de-f7cacea990fa@redhat.com>
Date: Thu, 21 Jan 2021 20:57:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210119152939.GB3453587@infradead.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: thomas.lendacky@amd.com, iommu@lists.linux-foundation.org, will@kernel.org,
 linux-kernel@vger.kernel.org, robin.murphy@arm.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGksIENocmlzdG9waAoK5ZyoIDIwMjHlubQwMeaciDE55pelIDIzOjI5LCBDaHJpc3RvcGggSGVs
bHdpZyDlhpnpgZM6Cj4+ICtpbnQgaW9tbXVfZG9fZGVmZXJyZWRfYXR0YWNoKHN0cnVjdCBkZXZp
Y2UgKmRldiwKPj4gKwkJCSAgICAgc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluKQo+IAo+IEkn
ZCByZW1vdmUgdGhlICJkb18iIGZyb20gdGhlIG5hbWUsIGl0IGRvZXNuJ3QgcmVhbGx5IGFkZCBh
bnkgdmFsdWUuCj4gCk9LLgoKPj4gK3sKPj4gKwljb25zdCBzdHJ1Y3QgaW9tbXVfb3BzICpvcHMg
PSBkb21haW4tPm9wczsKPj4gKwo+PiArCWlmICh1bmxpa2VseShvcHMtPmlzX2F0dGFjaF9kZWZl
cnJlZCAmJgo+PiArCQkgICAgIG9wcy0+aXNfYXR0YWNoX2RlZmVycmVkKGRvbWFpbiwgZGV2KSkp
Cj4+ICsJCXJldHVybiBfX2lvbW11X2F0dGFjaF9kZXZpY2UoZG9tYWluLCBkZXYpOwo+PiArCj4+
ICsJcmV0dXJuIDA7Cj4gCj4gTm93IHRoYXQgZXZlcnl0aW5nIGlzIHVuZGVyIHRoZSBzdGF0aWMg
a2V5IHdlIGRvbid0IHJlYWxseSBuZWVkIHRvCj4gYm90aGVyIHdpdGggdGhlIHVubGlrZWx5IG1p
Y3JvIG9wdGltaXphdGlvbiwgZG8gd2U/Cj4gCkdvb2QgdW5kZXJzdGFuZGluZy4gSSBjYW4gcmVt
b3ZlIGl0LCBvdGhlcndpc2UgaXQgc2hvdWxkIHVzZSB0aGUgbGlrZWx5KCkuCgo+PiArZXh0ZXJu
IGludCBpb21tdV9kb19kZWZlcnJlZF9hdHRhY2goc3RydWN0IGRldmljZSAqZGV2LAo+PiArCQkJ
CSAgICBzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4pOwo+IAo+IE5vIG5lZWQgZm9yIHRoZSBl
eHRlcm4uCj4gClNvdW5kcyBnb29kLiBJIHdpbGwgcmVtb3ZlIHRoZSAnZXh0ZXJuJyB3aGVuIEkg
cG9zdCBhZ2Fpbi4KClRoYW5rcy4KTGlhbmJvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
