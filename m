Return-Path: <SRS0=eMD9=K6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58826C4743C
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 17:10:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E6661359
	for <iommu@archiver.kernel.org>; Fri,  4 Jun 2021 17:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E6661359
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C36D140664;
	Fri,  4 Jun 2021 17:10:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aeh6cS0-RHCr; Fri,  4 Jun 2021 17:10:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7D29A40222;
	Fri,  4 Jun 2021 17:10:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64754C000E;
	Fri,  4 Jun 2021 17:10:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F15CC0001
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 17:10:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E21E83D16
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 17:10:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4DdBrAJ7rNYL for <iommu@lists.linux-foundation.org>;
 Fri,  4 Jun 2021 17:10:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 786C883CB1
 for <iommu@lists.linux-foundation.org>; Fri,  4 Jun 2021 17:10:43 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id 6so8384545pgk.5
 for <iommu@lists.linux-foundation.org>; Fri, 04 Jun 2021 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=6UWs4F/LiNKwGVZ1bzmUFbFeuYWDKRTT9nUEK353f64=;
 b=X8aW3XwzqxJ3VlB5j4+rIqIOqPzkjRCkdnbxjki+d+a5Cq0x9jxF1gUJsBQLUE0gEy
 2cfWOEMhcPK5xpu1iDuAUj1OftbYmKAjKv0OwQ1EcwCl3eyg/QhbpsVPdcl3mljdS3qC
 vemheUs8g88K40H8D1gZFIxoW3dXLaor0Lfctiv/50YltLgL7nH1+ns/VPHvQUtdsM1I
 ns6OQI3Csf1STnkSU4E5L+XUJtiTTCh6ZpTsORPGNxWFVwrnhdMfHqCMHRMEDo3nEF3a
 CIIYIZ1wjpombqkNe8z0ZYcVxNyBLqkyfkqo/kz2CX0bTLFByPL49RijZ2Ls9T7jbwqk
 uTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=6UWs4F/LiNKwGVZ1bzmUFbFeuYWDKRTT9nUEK353f64=;
 b=eyZQ5CmFIfu8vzzbNBF8yWUQ7SfERwYIi37iu/P794Y+EMBCgSbF8n8ODZJtyLHpXJ
 mP5zXspCxI178QdSSBcF8f/UL/fzcWI7lw6PFG5YXwkG72nbrUZOK6VnKjRt2TPF4Ugv
 Vep2EOTN8BooSeE9lLJrxCPQiYBFTadCX2HaxJoC2HPp/+qQbKP8lV4YXVGPLJe+Xd4k
 1yLexbHh7BNTLX5vjFwkEWJ5aECWGUcLVuAiLyFAPcmXp3WD6pVcrxkS7oQJ+xURwTDH
 bggAbzefUQJCu15/PnPSi5V/u7n/A8DPYLny9epjvrbTwFLas0U/1aBGMJyxSeH7u/s7
 /qlA==
X-Gm-Message-State: AOAM530q5kTwap62iiqxlQJ0zhirdB/tMpTJbKxAyWIH8sZEUIK/XQlx
 1J0cNAQwfocbVKBX+aBFZQo=
X-Google-Smtp-Source: ABdhPJwFk/+y0P5mH5oIK9Y8IdN1mPk5DlvowjHPiKeaobmrXB50aIxPGmTdHbHwskDpwsH/DIWAXA==
X-Received: by 2002:a65:6644:: with SMTP id z4mr6048915pgv.101.1622826642633; 
 Fri, 04 Jun 2021 10:10:42 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net.
 [24.6.216.183])
 by smtp.gmail.com with ESMTPSA id j7sm800001pjf.0.2021.06.04.10.10.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Jun 2021 10:10:42 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2 0/4] iommu/amd: Enable page-selective flushes
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YLpI7tKtsf4l5MlN@8bytes.org>
Date: Fri, 4 Jun 2021 10:10:40 -0700
Message-Id: <05098022-1ED6-44BE-931D-D16C2D0B2D09@gmail.com>
References: <20210524224159.32807-1-namit@vmware.com>
 <YLpI7tKtsf4l5MlN@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, Jiajun Cao <caojiajun@vmware.com>,
 linux-kernel@vger.kernel.org
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

Cgo+IE9uIEp1biA0LCAyMDIxLCBhdCA4OjM4IEFNLCBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVz
Lm9yZz4gd3JvdGU6Cj4gCj4gSGkgTmFkYXYsCj4gCj4gW0FkZGluZyBSb2Jpbl0KPiAKPiBPbiBN
b24sIE1heSAyNCwgMjAyMSBhdCAwMzo0MTo1NVBNIC0wNzAwLCBOYWRhdiBBbWl0IHdyb3RlOgo+
PiBOYWRhdiBBbWl0ICg0KToKPj4gIGlvbW11L2FtZDogRml4IHdyb25nIHBhcmVudGhlc2VzIG9u
IHBhZ2Utc3BlY2lmaWMgaW52YWxpZGF0aW9ucwo+IAo+IFRoaXMgcGF0Y2ggaXMgYWxyZWFkeSB1
cHN0cmVhbSBpbiB2NS4xMy1yYzQuIFBsZWFzZSByZWJhc2UgdG8gdGhhdAo+IHZlcnNpb24uCgpJ
IGd1ZXNzIGl0IHdvdWxkIGJlIHJjNSBieSB0aGUgdGltZSBJIHNlbmQgaXQuCgo+IAo+PiAgaW9t
bXUvYW1kOiBTZWxlY3RpdmUgZmx1c2ggb24gdW5tYXAKPj4gIGlvbW11L2FtZDogRG8gbm90IHN5
bmMgb24gcGFnZSBzaXplIGNoYW5nZXMKPj4gIGlvbW11L2FtZDogRG8gbm90IHVzZSBmbHVzaC1x
dWV1ZSB3aGVuIE5wQ2FjaGUgaXMgb24KPiAKPiBBbmQgSSB0aGluayB0aGVyZSBoYXZlIGJlZW4g
b2JqZWN0aW9ucyBmcm9tIFJvYmluIE11cnBoeSBvbiBQYXRjaCAzLAo+IGhhdmUgdGhvc2UgYmVl
biB3b3JrZWQgb3V0PwoKSSBhbSBzdGlsbCB3YWl0aW5nIGZvciBSb2JpbuKAmXMgZmVlZGJhY2sg
b24gbXkgcHJvcG9zZWQgY2hhbmdlcy4gSWYgaGUgZG9lcyBub3QgcmVzcG9uZCBzb29uLCBJIHdp
bGwgZHJvcCB0aGlzIHBhdGNoIGZvciBub3cuCgpUaGFua3MsCk5hZGF2Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
