Return-Path: <SRS0=XGcg=MI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D75C07E95
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 14:41:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24657613F8
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 14:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24657613F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE214607CB;
	Fri, 16 Jul 2021 14:41:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wFNNj_FpoqgZ; Fri, 16 Jul 2021 14:41:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C65D5605A3;
	Fri, 16 Jul 2021 14:41:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DE8DC0010;
	Fri, 16 Jul 2021 14:41:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71FCAC000E
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 14:41:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 615D84028C
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 14:41:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eNeOdyV0LWlR for <iommu@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 14:41:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D484140192
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 14:41:43 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71CB7613F9
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 14:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626446503;
 bh=Gg3Ke0wyfoprEaQsLgh/4ChP1BGmBVSkJ5TkIjXTauk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=NVNSiK17IZjvwxQwUyBbXALG1OEfj/EPl2TPfwfVV2SEmLVoOjr8/JfNGY/aaVnE7
 MBfOD7nHttfeYeex7PtN6rz/vf+yKwTYMH1j5Qj8jc31viyzaPJgbFDX7MQ/OVYpMG
 Zn/YXvDOBP4atQd5Igte4jDFrMfeP8eHnhfYYll+sRylJ0NgfCPskA/xDlMmkUCI64
 0c7tJxUu1wL3Tw2iHsoRNhecQq2SO8VOhN6JQCfluFX18iRvaWMRxvyRv2vVqjdCjD
 YYVZO5etRr2K6DuF3T55f5ZpE7Wpl+NCXA4jS/feOK83aMKBsfr8YVRsK3SBlSSJFR
 YyPg86ZUtRL9g==
Received: by mail-ed1-f44.google.com with SMTP id ee25so13262836edb.5
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 07:41:43 -0700 (PDT)
X-Gm-Message-State: AOAM531lfsnKz6Bn4iY2cTBxWiF/+ONg5QpwJlQbHaxdlhgFYp+KjHIt
 8Vindk3bY4mVSRFb/YoTWtwFKYhp3LEB3iFLbQ==
X-Google-Smtp-Source: ABdhPJytXw32jFRKV/IdOZxQT/8gJgcEca+5S6hsSEebSUX+rUCDRaxZJRXWlatA7XKj4j5GTedS5nJA2LZGGpnQGiw=
X-Received: by 2002:aa7:da4b:: with SMTP id w11mr13827478eds.258.1626446502075; 
 Fri, 16 Jul 2021 07:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
 <20210423163234.3651547-3-thierry.reding@gmail.com>
 <bdc42077-d1f3-f561-2e4d-647b5fceb7b6@gmail.com>
In-Reply-To: <bdc42077-d1f3-f561-2e4d-647b5fceb7b6@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 16 Jul 2021 08:41:28 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+jSY-OLau3gLPsDL02AYaE_TySOGrd9-tNLFaYvLHZ6A@mail.gmail.com>
Message-ID: <CAL_Jsq+jSY-OLau3gLPsDL02AYaE_TySOGrd9-tNLFaYvLHZ6A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] iommu: Implement of_iommu_get_resv_regions()
To: Dmitry Osipenko <digetx@gmail.com>
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Will Deacon <will@kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>,
 Thierry Reding <thierry.reding@gmail.com>, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra <linux-tegra@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>
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

T24gRnJpLCBKdWwgMiwgMjAyMSBhdCA4OjA1IEFNIERtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdt
YWlsLmNvbT4gd3JvdGU6Cj4KPiAyMy4wNC4yMDIxIDE5OjMyLCBUaGllcnJ5IFJlZGluZyDQv9C4
0YjQtdGCOgo+ID4gK3ZvaWQgb2ZfaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucyhzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHN0cnVjdCBsaXN0X2hlYWQgKmxpc3QpCj4gPiArewo+ID4gKyAgICAgc3RydWN0IG9m
X3BoYW5kbGVfaXRlcmF0b3IgaXQ7Cj4gPiArICAgICBpbnQgZXJyOwo+ID4gKwo+ID4gKyAgICAg
b2ZfZm9yX2VhY2hfcGhhbmRsZSgmaXQsIGVyciwgZGV2LT5vZl9ub2RlLCAibWVtb3J5LXJlZ2lv
biIsICIjbWVtb3J5LXJlZ2lvbi1jZWxscyIsIDApIHsKPiA+ICsgICAgICAgICAgICAgc3RydWN0
IGlvbW11X3Jlc3ZfcmVnaW9uICpyZWdpb247Cj4gPiArICAgICAgICAgICAgIHN0cnVjdCBvZl9w
aGFuZGxlX2FyZ3MgYXJnczsKPiA+ICsgICAgICAgICAgICAgc3RydWN0IHJlc291cmNlIHJlczsK
PiA+ICsKPiA+ICsgICAgICAgICAgICAgYXJncy5hcmdzX2NvdW50ID0gb2ZfcGhhbmRsZV9pdGVy
YXRvcl9hcmdzKCZpdCwgYXJncy5hcmdzLCBNQVhfUEhBTkRMRV9BUkdTKTsKPiA+ICsKPiA+ICsg
ICAgICAgICAgICAgZXJyID0gb2ZfYWRkcmVzc190b19yZXNvdXJjZShpdC5ub2RlLCAwLCAmcmVz
KTsKPiA+ICsgICAgICAgICAgICAgaWYgKGVyciA8IDApIHsKPiA+ICsgICAgICAgICAgICAgICAg
ICAgICBkZXZfZXJyKGRldiwgImZhaWxlZCB0byBwYXJzZSBtZW1vcnkgcmVnaW9uICVwT0Y6ICVk
XG4iLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaXQubm9kZSwgZXJyKTsKPiA+
ICsgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKPiA+ICsgICAgICAgICAgICAgfQo+ID4g
Kwo+ID4gKyAgICAgICAgICAgICBpZiAoYXJncy5hcmdzX2NvdW50ID4gMCkgewo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgIC8qCj4gPiArICAgICAgICAgICAgICAgICAgICAgICogQWN0aXZlIG1l
bW9yeSByZWdpb25zIGFyZSBleHBlY3RlZCB0byBiZSBhY2Nlc3NlZCBieSBoYXJkd2FyZSBkdXJp
bmcKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgKiBib290IGFuZCBtdXN0IHRoZXJlZm9yZSBo
YXZlIGFuIGlkZW50aXR5IG1hcHBpbmcgY3JlYXRlZCBwcmlvciB0byB0aGUKPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgKiBkcml2ZXIgdGFraW5nIGNvbnRyb2wgb2YgdGhlIGhhcmR3YXJlLiBU
aGlzIGVuc3VyZXMgdGhhdCBub24tcXVpZXNjZW50Cj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICogaGFyZHdhcmUgZG9lc24ndCBjYXVzZSBJT01NVSBmYXVsdHMgZHVyaW5nIGJvb3QuCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICovCj4gPiArICAgICAgICAgICAgICAgICAgICAgaWYgKGFy
Z3MuYXJnc1swXSAmIE1FTU9SWV9SRUdJT05fSURFTlRJVFlfTUFQUElORykgewo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcmVnaW9uID0gaW9tbXVfYWxsb2NfcmVzdl9yZWdpb24o
cmVzLnN0YXJ0LCByZXNvdXJjZV9zaXplKCZyZXMpLAo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVfUkVBRCB8IElP
TU1VX1dSSVRFLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgSU9NTVVfUkVTVl9ESVJFQ1RfUkVMQVhBQkxFKTsKPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICghcmVnaW9uKQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKPiA+ICsKPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGxpc3RfYWRkX3RhaWwoJnJlZ2lvbi0+bGlzdCwgbGlzdCk7Cj4g
PiArICAgICAgICAgICAgICAgICAgICAgfQo+ID4gKyAgICAgICAgICAgICB9Cj4gPiArICAgICB9
Cj4gPiArfQo+ID4gK0VYUE9SVF9TWU1CT0wob2ZfaW9tbXVfZ2V0X3Jlc3ZfcmVnaW9ucyk7Cj4K
PiBBbnkgcmVhc29uIHdoeSB0aGlzIGlzIG5vdCBFWFBPUlRfU1lNQk9MX0dQTD8gSSdtIGN1cmlv
dXMgd2hhdCBpcyB0aGUKPiBsb2dpYyBiZWhpbmQgdGhlIE9GIHN5bWJvbHMgaW4gZ2VuZXJhbCBz
aW5jZSBpdCBsb29rcyBsaWtlIGhhbGYgb2YgdGhlbQo+IGFyZSBHUEwuCgpHZW5lcmFsbHksIG5l
dyBvbmVzIGFyZSBfR1BMLiBPbGQgb25lcyBwcm9iYWJseSBwcmVkYXRlIF9HUEwuCgpUaGlzIG9u
ZSBpcyB1cCB0byB0aGUgSU9NTVUgbWFpbnRhaW5lcnMuCgpSb2IKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
