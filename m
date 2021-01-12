Return-Path: <SRS0=VgK/=GP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FORGED_MUA_MOZILLA,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8C3C433E0
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 07:08:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB75122CAD
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 07:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB75122CAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 496FD85FA1;
	Tue, 12 Jan 2021 07:08:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D-Gjpv9oXo8X; Tue, 12 Jan 2021 07:08:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D6E5285D37;
	Tue, 12 Jan 2021 07:08:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB0A6C0893;
	Tue, 12 Jan 2021 07:08:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 453A9C013A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 07:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 28F8C87094
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 07:08:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pd7VjQcyBre8 for <iommu@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 07:08:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DEA5287008
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 07:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1610435227;
 bh=IVspVoyZIJAARCo6tSZ/fSyF7jV4s/QkY6ysZf9k7qc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To;
 b=hiOMLpFNzbJbjGnc32VUWQJ1w82sbMAUYkyaRFyhPYf4QKSasqM3U0qNlfOJoMsCv
 7uyn9X54m6kn+psibRAunFp2yrp3br3654+AQuIYgLeqsBWzq0Ycnc2wLn/GKVJYu3
 SuPiV9clkvGp5yIv+CNXiCGDJ7eoxxQmuyT2spMM=
Received: from [IPv6:240e:362:4bf:e00:19ba:7333:19c1:ecbe]
 ([240e:362:4bf:e00:19ba:7333:19c1:ecbe])
 by newxmesmtplogicsvrszc5.qq.com (NewEsmtp) with SMTP
 id 16A17479; Tue, 12 Jan 2021 15:05:42 +0800
X-QQ-mid: xmsmtpt1610435142tf8fz7hle
Message-ID: <tencent_19C176B65A601349DA564348C7CAE0470406@qq.com>
X-QQ-XMAILINFO: MgmB7lY4LTHyzvoOtMgoRSvz6WYHN5VyH0Ee8sisFgzZ2+xeSt1+IpuCzWVe/2
 Ajl1hftPbsj4hc41kHF80/6kUzIMRdGtzdRuFhw/eMmv9TWO7wil8NNU2j7PVIzuDBlky8b6b6wH
 pY+py1dyboxL4z/zuevg2nZfkVkf5FajqRX2o3PnQLIAK4ZlReYDXgaLaGJf/9EEtYOP6XrdP4u8
 NXz+wg22MT/2Yim+nTJ5yren6qFAwP610UqkgWGPtUZ3aVi2yxvhbRiNq8s69QEs6Pna/KCBBN0b
 H/rbnr/ztAjHo94WLTlsShb7ROOpdEBYhNHoTbLyTFI2K4C85+aIlgLeAnEm1bVCpgfDq+ABL9UU
 yGl7C/q/8zd/PiNck/3SlwLm8fZRt8V8PRg6wG/jTNc0VkGsMgDIY6vNgqaarfiRLx5sdnFEqwTX
 Xh2DKeF+UpLQEOTjkCJOjPxicRatmVlV2IVNWYl6SPKuCOYzmIvE3XvLFxmkQQJnRjqgRtuQOyCI
 VDfFg18CjSBkwFFl4vzC7sf/roZ3jPWfGnYAHhz1wPIf+ktvqs2ZWAY2l4LgmSi2ihgZ1lpHszYm
 ZK5IiUV5l4gShuj+8WJWsdvarHZDMZspDpiYEzq0mSVU72gJDDE1ukfh+7rRA5lswVXzJkHSghtQ
 +6yALAxZe6zC4SMCAsLkq9InBINI+hna7S2kIhi48Soxg7MfeWjt/brjyMVmDW1tbMOTtIxN80Ur
 8kT1TCh/Nf1DGtzNtekCcmD/Xx4Iakud/GxQZbjDREq/OZeF/mUmS8uSz7l0G0guXXVi1Kiy/kNG
 8K0YVS5BmtpmRqgqN6nb+DS4rbxKNrOfip9B8sK7aQ6w==
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
To: Bjorn Helgaas <helgaas@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>
References: <20201217203806.GA20785@bjorn-Precision-5520>
From: "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <83afc1a6-9ee3-5fd1-9700-9c835c7b5319@foxmail.com>
Date: Tue, 12 Jan 2021 15:05:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201217203806.GA20785@bjorn-Precision-5520>
Content-Language: en-US
Cc: linux-pci <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 jean-philippe <jean-philippe@linaro.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Len Brown <lenb@kernel.org>,
 Thanu Rangarajan <Thanu.Rangarajan@arm.com>,
 Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Bjorn Helgaas <bhelgaas@google.com>, wanghuiqiang <wanghuiqiang@huawei.com>,
 kenneth-lee-2012@foxmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
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

SGksIEJqb3JuCgpPbiAyMDIwLzEyLzE4IOS4iuWNiDQ6MzgsIEJqb3JuIEhlbGdhYXMgd3JvdGU6
Cj4KPj4+IFRoZSBwcmluY2lwbGVzIGFyZToKPj4+Cj4+PiAgICAtIEkgZG9uJ3Qgd2FudCB0byBo
YXZlIHRvIHVwZGF0ZSBhIHF1aXJrIGZvciBldmVyeSBuZXcgRGV2aWNlIElECj4+PiAgICAgIHRo
YXQgbmVlZHMgdGhpcy4KPj4gSGkgQmpvcm4gYW5kIFpoYW5nZmVpLAo+Pgo+PiBXZSBwbGFuIHRv
IHVzZSBBVFMvUFJJIHRvIHN1cHBvcnQgU1ZBIGluIGZ1dHVyZSBQQ0kgZGV2aWNlcy4gSG93ZXZl
ciwgZm9yCj4+IGN1cnJlbnQgZGV2aWNlcywgd2UgbmVlZCB0byBhZGQgbGltaXRlZCBudW1iZXIg
b2YgcXVpcmsgdG8gbGV0IHRoZW0KPj4gd29yay4gVGhlIGRldmljZSBJRHMgb2YgY3VycmVudCBx
dWlyayBuZWVkZWQgZGV2aWNlcyBhcmUgWklQIGVuZ2luZSgweGEyNTAsIDB4YTI1MSksCj4+IFNF
QyBlbmdpbmUoMHhhMjU1LCAweGEyNTYpLCBIUFJFIGVuZ2luZSgweGEyNTgsIDB4YTI1OSksIHJl
dmlzaW9uIGlkIGFyZQo+PiAweDIxIGFuZCAweDMwLgo+Pgo+PiBMZXQncyBjb250aW51ZSB0byB1
cHN0cmVhbSB0aGVzZSBxdWlya3MhCj4gUGxlYXNlIHBvc3QgdGhlIHBhdGNoZXMgeW91IHByb3Bv
c2UuICBJIGRvbid0IHRoaW5rIHRoZSBwcmV2aW91cyBvbmVzCj4gYXJlIGluIG15IHF1ZXVlLiAg
UGxlYXNlIGluY2x1ZGUgdGhlIGxvcmUgVVJMIGZvciB0aGUgcHJldmlvdXMKPiBwb3N0aW5nKHMp
IGluIHRoZSBjb3ZlciBsZXR0ZXIgc28gd2UgY2FuIGNvbm5lY3QgdGhlIGRpc2N1c3Npb24uCj4K
SGF2ZSBzZW50IHRoZSB1cGRhdGVkIHBhdGNoCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LXBjaS8xNjEwNDM0MTkyLTI3OTk1LTEtZ2l0LXNlbmQtZW1haWwtemhhbmdmZWkuZ2FvQGxpbmFy
by5vcmcvVC8jdQoKV2UgZG8gbm90IG5lZWQgY2hhbmdlIGlvcnQgbm93IGJ1dCBqdXN0IHVzZSBh
IHF1aXJrIGZvciBIaVNpbGljb24gCkt1blBlbmc5MjAgYW5kIEt1blBlbmc5MzAsCnNpbmNlIEpl
YW4gbWFkZSBhIGNoYW5nZSBub3QgdXNpbmcgZndzcGVjLCB3aGljaCBtYWtlIHVzIGVhc2llci4K
CiogVXNlIGRldmljZSBwcm9wZXJ0aWVzIGZvciBkbWEtY2FuLXN0YWxsLCBpbnN0ZWFkIG9mIGEg
c3BlY2lhbCBmd3NwZWMKIMKgIG1lbWJlci4KCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LWlvbW11LzIwMjEwMTA4MTQ1MjE3LjIyNTQ0NDctMS1qZWFuLXBoaWxpcHBlQGxpbmFyby5vcmcv
CgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
