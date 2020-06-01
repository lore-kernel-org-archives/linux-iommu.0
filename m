Return-Path: <SRS0=mWFx=7O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25021C433DF
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 12:38:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD71120679
	for <iommu@archiver.kernel.org>; Mon,  1 Jun 2020 12:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="XW4pchmy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD71120679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 94428879A3;
	Mon,  1 Jun 2020 12:38:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cdJv+zXr2fZC; Mon,  1 Jun 2020 12:38:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BB74C87933;
	Mon,  1 Jun 2020 12:38:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99DD0C088C;
	Mon,  1 Jun 2020 12:38:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FD76C0176
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 12:38:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 875B586235
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 12:38:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LMjA80OzmQk3 for <iommu@lists.linux-foundation.org>;
 Mon,  1 Jun 2020 12:38:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4051186223
 for <iommu@lists.linux-foundation.org>; Mon,  1 Jun 2020 12:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591015087;
 bh=IVf4hudrlbKj+KRTCcrAWHzDwVeED3tTOft/0bbn7WM=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=XW4pchmyx1QLl/aLV7yr83DtbRGEb9OVqZzjtI9rCw+KULlpcu/rHeAV4sfp2zGXd
 0pHxshV188cX8uzsYp9WqKXT1V/xq1ELh6y7tQcVCvrilT2S8GRzTd7/qCJ3IseA5v
 We9qqmXvHOdLjIogfIT+2sW8Rlu6Uy97ooOfDaGM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.133.32]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPaxV-1jbayV3TmL-004hSO; Mon, 01
 Jun 2020 14:38:06 +0200
Subject: Re: [PATCH] iommu: Improve exception handling in iommu_group_alloc()
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Baolin Wang <baolin.wang@linux.alibaba.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, iommu@lists.linux-foundation.org
Message-ID: <9f8d8308-2056-8e33-7b38-0b7d96e51c3c@web.de>
Date: Mon, 1 Jun 2020 14:38:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:jjZy/qq3MYji+Y3iMCXMt5mvHN2RXqF9PJKSs+9OGxty52SYeH9
 8BZoaXLSkqLa2RVSSDp1dsFeq3uV1NxU2LRkYO9t+51eiiKeCIkXVPfffJJl+krpszkAFyM
 MFaB7EpjJuT+o/5rpfePoaBk9cO/s1J3O7uMd9RJR7hapfleEZ/6UnMVRfox72TyVwhULyd
 JORYnj2l0gT/ffnwo3LZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wQGGWyQY5rY=:w9dUPrDQ36CF7o1X1HzNgN
 njtCoQAB9DCQbHCGWKuXkEO/w9bGg9M233GhfXyMxi9f9RHhy3ZWfdUh3UBDgYuNzVnudWgMZ
 p30nIu7SXzw7kLtEK2hwEO1n624xanJj5wzrEp6iMofOAcGZnbuqhQkzgmKgEStiHxNrYYAR4
 5O7I9eWVwVZze8+Be5GDFLQtVIkO3t7pAoN5sKzpnH0OSO6pjBVAO6XpQiOYHv03G90Zrb7th
 nphyBMrGuMnxDUDJXWkG5wnQSEJocBLq6EqHj3wG8p1Fh+2QtFgGVIaOU5KQ5O9Oih4YhjOmh
 9G+cobC+givb8Zl35umXbKxjzl5Ce2Te3fJclcFbVksF1BApBIZ9xsqEndhvVyHa74p3JtGGQ
 Zo58bBA/oKQfQZUZRYS6vK0J+521h5wZch0d/F+TdDPAkrK6iWYaPji/u0z2mW8T9wrYLRpyQ
 3vOVsI/dUAfyEq/QHZch5/z/UXrh68lAbofrpBzDPv4xZFZo4TnSLzXW+a/FZ6NeQUNyBM6ML
 IFcDA2woj8ZYVVUdfBktWQHGJLzD5HTMzaAEw9bR2iB8soenA6wvjQF36lIHAtu1UB9wf1OtT
 QdPkr0aaFlEozCvtc/svV7JDwpkn9UYn9/KJwA+Jpqc5GqnAkOCjP7Y2RfP/xYvurClzoLVy9
 sq1VdQudEuR3VmkKZjh+WD7mkZQCsxoA3TzFpouRysl+TqPfGFLeU25/zSiBgOgubJQ5kAbIY
 fqRno1mN3L2vBckBBlxN62gCoR/t8YAw4hOAjWINxZAfHa6+bMlzb0ZXU6WqQTYGchmp5LAd8
 3ESWdn9HwdeLyo2O0ZiAIqQCpi2pXmC0WjQCKjrtbxODgWsne+f93RmZlehtonZsjfyHtWoYB
 CXPRT8aejsiv3RcZjZ+iSdrmw4RnofzhjmoUVUdOV2VE7LvmT6INUkiUUyYWh6LYLjm4WV657
 yztqi2590MxGuADX1waGQq2Hn5m7FrpbRwD060eo4Cfdab2C4VS1Vh2j1PTW5CFKG8yCYViHb
 er/5kd9/BPG1Kf4ajtJ/DGXdFRGMpMErz9T8vWbKwM8fjvQV2JC9s6yGXWNqD7Myiviwo+QlR
 olX6EeOHzbeReWEW+035FIxY6nNLCa8LkrNFKlbiOwkREhbPpGDTRRb+2EY5mrSN2vFZb+Ruk
 nMcZ3Y1u5TJVR7HvEeTXBMBShLSfAFH2eDa0fTvp1PR2N7ngIXZ8Ox/yqBpsnvy6Kx1jXxKrA
 Mqn6gBpCDrXGSmZfh
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

PiBPcHRpbWl6ZSB0aGUgZXJyb3IgaGFuZGxpbmcgdG8gZnJlZSB0aGUgcmVzb3VyY2VzIGNvcnJl
Y3RseSB3aGVuCj4gZmFpbGVkIHRvIGFsbG9jYXRlIGFuIGlvbW11IGdyb3VwLgoKKiBJIHdvdWxk
IG5vdCBjYXRlZ29yaXNlIHRoZSBkZXNpcmVkIGNvbXBsZXRpb24gb2YgZXhjZXB0aW9uIGhhbmRs
aW5nCiAgYXMgYSBzb2Z0d2FyZSBvcHRpbWlzYXRpb24uCgoqIFdvdWxkIHlvdSBsaWtlIHRvIGFk
ZCB0aGUgdGFnIOKAnEZpeGVz4oCdIHRvIHRoZSBjb21taXQgbWVzc2FnZT8KCiogSSBzdWdnZXN0
IHRvIGF2b2lkIHRoZSBzcGVjaWZpY2F0aW9uIG9mIGR1cGxpY2F0ZSBmdW5jdGlvbiBjYWxscy4K
ICBXaWxsIGl0IGJlIGhlbHBmdWwgdG8gYWRkIGEgZmV3IGp1bXAgdGFyZ2V0cz8KICBodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5n
aXQvdHJlZS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3MvY29kaW5nLXN0eWxlLnJzdD9pZD0zZDc3ZTZh
ODgwNGFiY2MwNTA0YzkwNGJkNmU1Y2RmM2E1Y2Y4MTYyI240NTUKClJlZ2FyZHMsCk1hcmt1cwpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
