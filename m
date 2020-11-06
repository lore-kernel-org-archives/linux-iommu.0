Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E49C2D0A3
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 13:58:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5131F206A4
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 13:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TS2UJ3vS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5131F206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B4F1286126;
	Fri,  6 Nov 2020 13:58:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6QpVEbTwkoJb; Fri,  6 Nov 2020 13:58:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 31731860FE;
	Fri,  6 Nov 2020 13:58:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1460DC088B;
	Fri,  6 Nov 2020 13:58:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21C43C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 13:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0B67E226EA
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 13:58:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fI2Y0NdUu+2f for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 13:58:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by silver.osuosl.org (Postfix) with ESMTPS id BF85D20022
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 13:58:06 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id cq7so1154013edb.4
 for <iommu@lists.linux-foundation.org>; Fri, 06 Nov 2020 05:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=4G7VFoqCmQpgFdNuLHy4W4jZ3qixbp1erZ4TZDOjOrA=;
 b=TS2UJ3vSTZgOIv8gT8YeXB3G5jqtOXp+sK+Jx1qof2vce/Mcamvetp6yH1lNf4r0E4
 xcU1lntD5f99v+fGWPrvOzzbKSsMg9FVujLxTPIH1PPUiyoxyC+nORiSMzyc9E36sF7k
 SFv+h1WTAH5vR9LL8deg6t9tCdfJf7B5BxKB+26FbVFFh/ZOeR0P1LNnRicWw/KtLfj5
 M/3KzIrWNLlTfuv1Q5PPgRzgbYmjUy5jtcizSDO7CmNwP2EqG79Xs04SA1dX5bJDw7Hq
 NqybykBbwpbhDAf/BXzuXt8DVv7ERiuV0nKGion8mQAnUkfNDUSYdiJ99iX0vexXUCYs
 qBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=4G7VFoqCmQpgFdNuLHy4W4jZ3qixbp1erZ4TZDOjOrA=;
 b=LuvrDKtHBsJXBqe9YwRZ13cvW9TsybT8hc0lapukn4EK1agcXIuQQ1qp9DvVDhmwF1
 DvjxmPptPwTQi8mbkOR0goAtypdcRHVB3XO6fKwqj7ocFhq8BjwFVVo6j7msERyrViQx
 fDcFqbwtDiEaydBbV9YVLT4vzCbYA+e//4w0hL3rO0JTEGwOGVplnIarmaHA7QgbBaPJ
 gkVFd2s19UC3qnRqcEYt5Sm/6sRifPr0STSyAJZVcvvIirz/KYiMllNvxzxTkGZAVRJB
 /jJioNirqMqxtZz8x0dnxdiQtW41RROQbO4BNkkXhgWd8eLHdJiQPPsicKh3HBDbhe44
 8Q+Q==
X-Gm-Message-State: AOAM5324A9CWpERhI7i7xyI9NvTGvUB1ChuxK+/ZqK/moIu4u49o4+HY
 ZHUS+5IEYMx6a+3AkWBeCr/+Ew==
X-Google-Smtp-Source: ABdhPJzchuahg5qlMMu1FoXwDEw98+QBKE6mknvesJrB/vL5mpbdzxJtMuFWWUGe1vEoed3EZ66dcg==
X-Received: by 2002:aa7:d4c9:: with SMTP id t9mr1169766edr.313.1604671085173; 
 Fri, 06 Nov 2020 05:58:05 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y12sm1065156ede.82.2020.11.06.05.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 05:58:04 -0800 (PST)
Date: Fri, 6 Nov 2020 14:57:45 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Yinghan Yang <Yinghan.Yang@microsoft.com>
Subject: Re: [EXTERNAL] Re: Question regarding VIOT proposal
Message-ID: <20201106135745.GB974750@myrica>
References: <MW2PR2101MB1130313B4AE39B7EAC09349B80EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
 <20201105134503.GA950007@myrica>
 <MW2PR2101MB113096E822AD835F658808B480EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB113096E822AD835F658808B480EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
Cc: "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Boeuf,
 Sebastien" <sebastien.boeuf@intel.com>,
 Alexander Grest <Alexander.Grest@microsoft.com>,
 "ahs3@redhat.com" <ahs3@redhat.com>
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

SGkgWWluZ2hhbiwKCk9uIFRodSwgTm92IDA1LCAyMDIwIGF0IDEwOjA1OjI4UE0gKzAwMDAsIFlp
bmdoYW4gWWFuZyB3cm90ZToKPiBUaGFuayB5b3UgZm9yIHRoZSBjbGFyaWZpY2F0aW9ucy4gSW4g
Y2FzZXMgd2hlcmUgYSBsYXJnZSByYW5nZSBvZiAgUENJIHNlZ21lbnRzIG1heSBiZSBhc3NpZ25l
ZCB0byBndWVzdCwgd291bGQgaXQgbWFrZSBzZW5zZSB0byBkZXNjcmliZSB0aGlzIGNvbmZpZ3Vy
YXRpb24gYXMgYmFzZSArIGNvdW50LiBDdXJyZW50bHksIG9uZSB3b3VsZCBoYXZlIHRvIGRlc2Ny
aWJlIHRoZW0gaW5kaXZpZHVhbGx5LiAKClllcywgSSd2ZSBiZWVuIHdvbmRlcmluZyB3aGV0aGVy
IHRoYXQgd291bGQgYmUgdXNlZnVsLiBJdCB3b3VsZCBhbHNvIGFsbG93CmhvdHBsdWdnaW5nIG5l
dyBzZWdtZW50cywgaWYgdGhhdCdzIGV2ZXIgbmVlZGVkLiBJdCByZXF1aXJlcyBjaGFuZ2luZyB0
aGUKZW51bWVyYXRpb24gcnVsZSB0aGF0IGRlcml2ZXMgYW4gZW5kcG9pbnQgSUQgZnJvbSBzZWdt
ZW50ICsgQkRGIG51bWJlci4KCkZpcnN0LCB3aGVuIGRlc2NyaWJpbmcgYSByYW5nZSBvZiBzZWdt
ZW50cywgYXJlIEJGRCBzdGFydCBhbmQgZW5kIHN0aWxsCnZhbGlkPyAgRG8gdGhleSBvbmx5IGFw
cGx5IHRvIGZpcnN0IGFuZCBsYXN0IHNlZ21lbnQgcmVzcGVjdGl2ZWx5PyAgVG8Ka2VlcCB0aGlu
Z3Mgc2ltcGxlIEkgdGhpbmsgQkRGIHN0YXJ0L2VuZCBzaG91bGQga2VlcCB0aGUgc2FtZSBtZWFu
aW5nOgp2YWxpZCByZWdhcmRsZXNzIG9mIHNlZ21lbnQgcmFuZ2UsIGFuZCBhcHBseSB0byBhbGwg
c2VnbWVudHMgaW4gdGhlIHJhbmdlLgoKU28gdGhlIG5ldyBQQ0kgUmFuZ2Ugbm9kZSBjb3VsZCBi
ZToKCkZpZWxkICAgICAgICAgICAgICAgICAgIExlbmd0aCAgT2Zmc2V0ICBEZXNjcmlwdGlvbgot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tClR5cGUgICAgICAgICAgICAgICAgICAgIDEgICAgICAgMCAg
ICAgICAxIOKAkyBQQ0kgcmFuZ2UKUmVzZXJ2ZWQgICAgICAgICAgICAgICAgMSAgICAgICAxICAg
ICAgIDAuCkxlbmd0aCAgICAgICAgICAgICAgICAgIDIgICAgICAgMiAgICAgICBMZW5ndGggb2Yg
dGhlIG5vZGUgaW4gYnl0ZXMuCkVuZHBvaW50IHN0YXJ0ICAgICAgICAgIDQgICAgICAgNCAgICAg
ICBGaXJzdCBlbmRwb2ludCBJRC4KUENJIFNlZ21lbnQgc3RhcnQgICAgICAgMiAgICAgICA4ICAg
ICAgIEZpcnN0IFBDSSBTZWdtZW50IG51bWJlciBpbiB0aGUgcmFuZ2UuClBDSSBTZWdtZW50IGVu
ZCAgICAgICAgIDIgICAgICAgMTAgICAgICBMYXN0IFBDSSBTZWdtZW50IG51bWJlciBpbiB0aGUg
cmFuZ2UuClBDSSBCREYgc3RhcnQgICAgICAgICAgIDIgICAgICAgMTIgICAgICBGaXJzdCBCdXMt
RGV2aWNlLUZ1bmN0aW9uIG51bWJlciBpbiB0aGUgcmFuZ2UuClBDSSBCREYgZW5kICAgICAgICAg
ICAgIDIgICAgICAgMTQgICAgICBMYXN0IEJ1cy1EZXZpY2UtRnVuY3Rpb24gbnVtYmVyIGluIHRo
ZSByYW5nZS4KT3V0cHV0IG5vZGUgICAgICAgICAgICAgMiAgICAgICAxNiAgICAgIE9mZnNldCBm
cm9tIHRoZSBzdGFydCBvZiB0aGUgdGFibGUgdG8gdGhlIG5leHQgdHJhbnNsYXRpb24gZWxlbWVu
dC4KUmVzZXJ2ZWQgICAgICAgICAgICAgICAgNiAgICAgICAxOCAgICAgIDAuCgpBIFBDSSBkZXZp
Y2UgaXMgYWZmZWN0ZWQgYnkgdGhlIG5vZGUgaWYgaXRzIHNlZ21lbnQgaXMgaW4gW1NlZ21lbnQg
c3RhcnQsClNlZ21lbnQgZW5kXSwgYW5kIGlmIGl0cyBCREYgaXMgaW4gW0JQRiBzdGFydCwgQkRG
IGVuZF0uIEl0cyBlbmRwb2ludCBJRAp3aWxsIGJlOgoKICAgICgoU2VnbWVudCAtIFNlZ21lbnQg
c3RhcnQpIDw8IDE2KSArIEJERiAtIEJERiBzdGFydCArIEVuZHBvaW50IHN0YXJ0CgpEb2VzIHRo
YXQgc291bmQgT0s/CgpUaGFua3MsCkplYW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
