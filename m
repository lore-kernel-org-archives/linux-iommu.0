Return-Path: <SRS0=CJHf=KH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649B5C433ED
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 15:46:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DB461D92
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 15:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DB461D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75B2B40580;
	Wed, 12 May 2021 15:46:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nmQZT6AfBehA; Wed, 12 May 2021 15:46:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 189B1404B8;
	Wed, 12 May 2021 15:46:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9497C000E;
	Wed, 12 May 2021 15:46:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC548C0001
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 15:46:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA75A40594
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 15:46:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XilVHzb4jRis for <iommu@lists.linux-foundation.org>;
 Wed, 12 May 2021 15:46:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9903340580
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 15:46:06 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95ADF61963;
 Wed, 12 May 2021 15:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1620834366;
 bh=yXpAUGPfUGGryxBbvmnZ5EvTuV7yQeJO9HahDsulaq4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CBNi+CpTVDiOTyf2igmIRQ01axZMwD9kcyhIORT+xMj0QJIDZvX5ParHobc/IncGR
 gilUeYH8PXpywdjszpCrSZoPcWQOzIZ759LVUMhWqtTsppXTzEN2jNkwOFF8lnupmp
 LwAD3NWE5t52iol75AvgquP4KGtbXB0V9iqLN5qc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5.11 514/601] iommu/amd: Put newline after closing bracket in
 warning
Date: Wed, 12 May 2021 16:49:51 +0200
Message-Id: <20210512144844.781983473@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512144827.811958675@linuxfoundation.org>
References: <20210512144827.811958675@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Cc: Sasha Levin <sashal@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Joerg Roedel <jroedel@suse.de>, Brijesh Singh <brijesh.singh@amd.com>,
 Robert Richter <rrichter@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

RnJvbTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4KClsgVXBzdHJlYW0gY29t
bWl0IDMwNGM3M2JhNjk0NTlkNGMxOGMyYTRiODQzYmU2ZjU3NzdiNGI4NWMgXQoKQ3VycmVudGx5
LCBvbiB0aGUgRGVsbCBPcHRpUGxleCA1MDU1IHRoZSBFRlIgbWlzbWF0Y2ggd2FybmluZyBsb29r
cyBsaWtlCmJlbG93LgoKICAgIFsgICAgMS40Nzk3NzRdIHNtcGJvb3Q6IENQVTA6IEFNRCBSeXpl
biA1IFBSTyAxNTAwIFF1YWQtQ29yZSBQcm9jZXNzb3IgKGZhbWlseTogMHgxNywgbW9kZWw6IDB4
MSwgc3RlcHBpbmc6IDB4MSkKICAgIFvigKZdCiAgICBbICAgIDIuNTA3MzcwXSBBTUQtVmk6IFtG
aXJtd2FyZSBXYXJuXTogRUZSIG1pc21hdGNoLiBVc2UgSVZIRCBFRlIgKDB4Zjc3ZWYyMjI5NGFk
YSA6IDB4NDAwZjc3ZWYyMjI5NGFkYQogICAgICAgICAgICAgICAgICAgKS4KCkFkZCB0aGUgbmV3
bGluZSBhZnRlciB0aGUgYCkuYCwgc28gaXTigJlzIG9uIG9uZSBsaW5lLgoKRml4ZXM6IGE0NDA5
MmUzMjZkNCAoImlvbW11L2FtZDogVXNlIElWSEQgRUZSIGZvciBlYXJseSBpbml0aWFsaXphdGlv
biBvZiBJT01NVSBmZWF0dXJlcyIpCkNjOiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpDYzogU3VyYXZlZSBTdXRoaWt1bHBhbml0IDxzdXJhdmVlLnN1dGhpa3VscGFuaXRAYW1kLmNv
bT4KQ2M6IEJyaWplc2ggU2luZ2ggPGJyaWplc2guc2luZ2hAYW1kLmNvbT4KQ2M6IFJvYmVydCBS
aWNodGVyIDxycmljaHRlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBQYXVsIE1lbnplbCA8cG1l
bnplbEBtb2xnZW4ubXBnLmRlPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjEw
NDEyMTgwMTQxLjI5NjA1LTEtcG1lbnplbEBtb2xnZW4ubXBnLmRlClNpZ25lZC1vZmYtYnk6IEpv
ZXJnIFJvZWRlbCA8anJvZWRlbEBzdXNlLmRlPgpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8
c2FzaGFsQGtlcm5lbC5vcmc+Ci0tLQogZHJpdmVycy9pb21tdS9hbWQvaW5pdC5jIHwgMiArLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pb21tdS9hbWQvaW5pdC5jIGIvZHJpdmVycy9pb21tdS9hbWQvaW5pdC5jCmlu
ZGV4IDc4MzM5YjBiYjhlNS4uOTg0NmIwMWE1MjE0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11
L2FtZC9pbml0LmMKKysrIGIvZHJpdmVycy9pb21tdS9hbWQvaW5pdC5jCkBAIC0xODM1LDcgKzE4
MzUsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQgbGF0ZV9pb21tdV9mZWF0dXJlc19pbml0KHN0cnVj
dCBhbWRfaW9tbXUgKmlvbW11KQogCSAqIElWSEQgYW5kIE1NSU8gY29uZmxpY3QuCiAJICovCiAJ
aWYgKGZlYXR1cmVzICE9IGlvbW11LT5mZWF0dXJlcykKLQkJcHJfd2FybihGV19XQVJOICJFRlIg
bWlzbWF0Y2guIFVzZSBJVkhEIEVGUiAoJSNsbHggOiAlI2xseFxuKS4iLAorCQlwcl93YXJuKEZX
X1dBUk4gIkVGUiBtaXNtYXRjaC4gVXNlIElWSEQgRUZSICglI2xseCA6ICUjbGx4KS5cbiIsCiAJ
CQlmZWF0dXJlcywgaW9tbXUtPmZlYXR1cmVzKTsKIH0KIAotLSAKMi4zMC4yCgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
