Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A60C433DF
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 08:01:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08ED1206A2
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 08:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="BKyq8Jp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08ED1206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B2BE8876CF;
	Tue,  2 Jun 2020 08:01:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u3vm8EU3o-Wl; Tue,  2 Jun 2020 08:01:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3868D8764F;
	Tue,  2 Jun 2020 08:01:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DFABC0178;
	Tue,  2 Jun 2020 08:01:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD39BC016E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 08:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C7E72226C2
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 08:01:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kB8uIMZkxxCU for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 08:01:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by silver.osuosl.org (Postfix) with ESMTPS id 02DB1226A9
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 08:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591084815;
 bh=WDTzVTHGmlp+OKn3B4aToc1JJv25StJggllptMxwqW0=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=BKyq8Jp/aP9jLSFRhzEcVlsSJ7f1HgTKEdsx/kiskfg1w+PvdD2yOykrtJO9qJKyL
 IA8d1EIEiO4hRS/FFEiKWTdUqu/PX3Q1Wz51tCvu/rfI22YK9EcueGbkDOCT2xqxS+
 k/dZPkFSruLwXNAP8qhi9gjW6yBrSulE+bywGcc4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.186.246]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUCz1-1jX3Rk1uEd-00RGnz; Tue, 02
 Jun 2020 10:00:15 +0200
Subject: Re: [PATCH v2] iommu: Improve exception handling in
 iommu_group_alloc()
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Baolin Wang <baolin.wang@linux.alibaba.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, iommu@lists.linux-foundation.org
Message-ID: <c6f587ac-aebe-3aae-da0e-087dc7f78ac5@web.de>
Date: Tue, 2 Jun 2020 10:00:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:2nsbRfza6hwFswpjoHsdOMyT2iUDhwVGN2ST+H1u/k28aNAo6eW
 sq3+wS6MYXyYunk0ZeMmlnAZ4MH9h2DiWMXmL4a9mDUb1v1Zf2iJAOn8GNjxPK7I3Z+ozJy
 4g/8u0cYK356M+6v251ikTUIO+Te9g47b3t0byYt3wKVYtcuQ9y9MUkMI5cxy9XSSxrdSRH
 ME6IFE+RqySD+SrQG7ekQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qa4nB0VQa90=:xozb6EhVlbPDbDEray/hyo
 TDRSIdhZOygLp3SO9M6I0+HCjRGIIMp6zEjBcW7rMVJcMF19w+6OpSfnGlT0zMEX/dWs+Pcva
 UsyxNYe8BR8V0I/XFnFzkvljiApnQLolCFvGbFNzVv4pqBYS9HRoXhANj5MBEcHlxZpKV1A1x
 NAMYffO1D0NSad9ghY//BqKlHa6g82zuUD6uEKW7eQGPq3gYrJLn8fajnjdXcstdy+eVSmT8m
 daNhszrkdjtQ8qeG8+g7xo4k6eNKYXZxO3A7BaqCLDbqhwhQhxe2/D9qwdtUYFXJ//nMGloYV
 ZXO0CZUu63IAJdT5faK2fq7yd/ytp6gZRnFBkhvE133/NEP9ja+aA1PZPmlm/Ds91FKueslfK
 Xm+LLLJI9Ab1uPUMsYGuL1qwxdDaX2kQ2HBqVYc2/sZfGDt/qYHDh1XdSStaQJ2FvIc8EQrvl
 GMsRsZLON4aAbVoNkek7fhCJewkghFEo4iJ9bPduWuX81cFioBXWroCl2QA3r0wG463vp4y/U
 2GVVcUL0dpiEFEf2lPGZRdSp6ZnRPgvxEyFVtJlEPJNwZupHZOPog57pEGsmljhaH/FUnHcGa
 lZKTCVJXXiMOadXx38e408Sa9e+VyJNYXLOmtF52AyuXhMdKPmydHp1Qn6Coc4ShZ7ulZHkdh
 6L32WT88hLhJilFPsn0WBBU6ECR1Asm+6VHbz4+jCqwPiPGHBfikFrkZIQGaPNGbo04ZhTrp4
 TRvjY38o5MZoS9WGVS1mOevncqUWCsg1HpVEm8qotcDv3TADLV8F+B0neh0/SjMSMrOauTMtA
 lGg3y8uyGVUSQh5zjR/OyHyfZ40w1A4GQuAShZ93dE7MeI9Z78RLSdw3Hyz/myVHNnpSLe4b4
 Xc4TRw/7gzaYLSaw4qDUv0SsFYUcquDh/yq1SCe8HNbh/atcnT0+LkxxK8PwhOCWkam0o7t6y
 xKQ0nYLu1zR32YF0USNGG/nb71YIFnK6VNeu4xJtkZgdPb8z1H+4Wm/9EtA5Hykm0YTJM3Lhr
 T40t2YtHvjaIbu1fDKv+y8kcL2ml0FuKtUX5SjezCrES2Z+JqoJXSKVl/cZkFXB9QqU1CQ3Hk
 7V9QOy9+T/nuiiiGU8A/m7pYl9FIaaWPN0qu88bImqsBsyIrjWs+JUwsWt8owAKMnoezXuu/Z
 rvjm/ElNI3owQ5PH5ZvZAuE1UT/idEHVP+D8mUdPlCP2fJPoXB9Hb0WhukAC3J0fTsAa76+gU
 OLNVyCZBFST4ap4+e
Cc: Kangjie Lu <kjlu@umn.edu>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> Improve the exception handling to free the resources correctly when
> failed to allocate an iommu group.

I propose to avoid the specification of duplicate function calls.
Will it become helpful to add a few jump targets?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=f359287765c04711ff54fbd11645271d8e5ff763#n455


> ---
>  drivers/iommu/iommu.c | 10 ++++++++--

I suggest to replace the triple dashes before this diffstat
by a blank line.

Regards,
Markus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
