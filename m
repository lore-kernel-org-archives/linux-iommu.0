Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F4BC07E9C
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 13:19:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560F5613B6
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 13:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560F5613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2B18940001;
	Wed, 14 Jul 2021 13:19:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a_FN8np3Z9-v; Wed, 14 Jul 2021 13:19:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 23D614053C;
	Wed, 14 Jul 2021 13:19:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF71CC0010;
	Wed, 14 Jul 2021 13:19:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D1DBC000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 13:19:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CCC0C83BC1
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 13:19:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gypa4xbTA6sq for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 13:18:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A289283B01
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 13:18:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="197614209"
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; d="scan'208";a="197614209"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2021 06:18:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,239,1620716400"; d="scan'208";a="466081488"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
 by fmsmga008.fm.intel.com with SMTP; 14 Jul 2021 06:18:38 -0700
Received: by stinkbox (sSMTP sendmail emulation);
 Wed, 14 Jul 2021 16:18:37 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Subject: [PATCH v2 0/4] iommu/vt-d: Disable igfx iommu superpage on bxt/skl/glk
Date: Wed, 14 Jul 2021 16:18:33 +0300
Message-Id: <20210714131837.8978-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

RnJvbTogVmlsbGUgU3lyasOkbMOkIDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4KCkkg
cmFuIGludG8gc29tZSBraW5kIG9mIGZhaWwgd2l0aCBWVC1kIHN1cGVycGFnZSBvbiBHZW1pbmxh
a2UgaWdmeCwKc28gd2l0aG91dCBhbnkgYmV0dGVyIGlkZWFzIGxldCdzIGp1c3QgZGlzYWJsZSBp
dC4KCkFkZGl0aW9uYWxseSBTa3lsYWtlL0Jyb3h0b24gaWdmeCBoYXZlIGtub3duIGlzc3VlcyB3
aXRoIFZULWQKc3VwZXJwYWdlIGFzIHdlbGwsIHNvIGxldCdzIGRpc2FibGUgaXQgdGhlcmUgYXMg
d2VsbC4gVGhpcyBzaG91bGQKbGV0IHVzIHJlLWVuYWJsZSBmcmFtZSBidWZmZXIgY29tcHJlc3Np
b24gKEZCQykgZm9yIHNvbWUgZXh0cmEKcG93ZXIgc2F2aW5ncyB3aGVuIHRoZSBkaXNwbGF5IGlz
IG9uLgoKdjI6IGRpc2FibGUgc3VwZXJwYWdlIG9ubHkgZm9yIHRoZSBpZ2Z4IGlvbW11CgpDYzog
RGF2aWQgV29vZGhvdXNlIDxkd213MkBpbmZyYWRlYWQub3JnPgpDYzogTHUgQmFvbHUgPGJhb2x1
Lmx1QGxpbnV4LmludGVsLmNvbT4KQ2M6IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
CgpWaWxsZSBTeXJqw6Rsw6QgKDQpOgogIGlvbW11L3Z0LWQ6IERpc2FibGUgc3VwZXJwYWdlIGZv
ciBHZW1pbmlsYWtlIGlnZngKICBpb21tdS92dC1kOiBEaXNhYmxlIHN1cGVycGFnZSBmb3IgQnJv
eHRvbiBpZ2Z4CiAgaW9tbXUvdnQtZDogRGlzYWJsZSBzdXBlcnBhZ2UgZm9yIFNreWxha2UgaWdm
eAogIGRybS9pOTE1L2ZiYzogQWxsb3cgRkJDICsgVlQtZCBvbiBTS0wvQlhUCgogZHJpdmVycy9n
cHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9mYmMuYyB8IDE2IC0tLS0tLQogZHJpdmVycy9pb21t
dS9pbnRlbC9pb21tdS5jICAgICAgICAgICAgICB8IDY4ICsrKysrKysrKysrKysrKysrKysrKysr
LQogMiBmaWxlcyBjaGFuZ2VkLCA2NyBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKCi0t
IAoyLjMxLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
