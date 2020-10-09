Return-Path: <SRS0=yPDG=DQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53E6C433E7
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 13:56:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61062222B9
	for <iommu@archiver.kernel.org>; Fri,  9 Oct 2020 13:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hlz0T0HY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61062222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 196068770B;
	Fri,  9 Oct 2020 13:56:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9P9enu5wUT6n; Fri,  9 Oct 2020 13:56:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 94CEB8770C;
	Fri,  9 Oct 2020 13:56:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78AF0C07FF;
	Fri,  9 Oct 2020 13:56:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C948FC0051
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 13:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AD0302034A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 13:56:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IRzsZxOlmxLg for <iommu@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 13:56:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com
 [209.85.166.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 7F3A620026
 for <iommu@lists.linux-foundation.org>; Fri,  9 Oct 2020 13:56:36 +0000 (UTC)
Received: by mail-il1-f196.google.com with SMTP id p16so783894ilq.5
 for <iommu@lists.linux-foundation.org>; Fri, 09 Oct 2020 06:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:from:date:message-id:subject:to:cc;
 bh=6o6qPP8lMx7cYOKA/MqaKbaqIjCjGnaiLWr14rPl5P0=;
 b=Hlz0T0HYpcI1RmYPyeOF014dP7wq6mto4JOO5AQX3su3fh95zbsrdvX+wsqbFQFmuk
 o56RJq7SGR5KyYMNTqsQjirLof/hnJtOBvvKEwO9b1+TN3p0b4gl92toDcBj7VMPnn7/
 8tY2NMUR4+quoUAFnkcxw7tVy93kHmwxgOPAcTX7m1Uo+ZCdjtmxau9fhNb4E82Tq5ot
 B5nJJa8LIH8PryvenpUGFLf4m8Kd88gjuibR7FbKT1TrjSS9oz09MR1uncgkH+1kLLzz
 /FVRczFb6cSO2chHkoCGBoFXPEzehWoc1SQrPGaGcYlVCO8j83PhHkDjqmQt2j07l4cf
 0s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:from:date:message-id
 :subject:to:cc;
 bh=6o6qPP8lMx7cYOKA/MqaKbaqIjCjGnaiLWr14rPl5P0=;
 b=MjrZ9iJLny/Y0b/7rYUf/UNwaFPmC6elR8085byPZ/cMkuietmc60Xcg/j9KoOB0Pq
 JaqFVo9QzuTBquW0j2iBFyGJdvvwqyS1tXttUfqyyF5J+MJwfTfIR/OrvsIUfZqmD5GS
 LkaU37QxMlRbiLPYw2WWAFRK8Bj6RwoIb646aGiyAgI9hTBacVz+SDsJVEhi8bjl1HhH
 H9IVRYxsn66XAo9TzVK88PJ9PXOWC4Yaqz0uNInHjSYWyeKPUWVXJ2FY/KLQVdmrmb+N
 IB3vbiqH4dQ93a4FaSSD5pEcJcq4jY3xNyqqWU/MTFPvGh+BBD844mtkGfsuI9l2ALKy
 +M9g==
X-Gm-Message-State: AOAM532TY1YDA99j+U3YQAbHSlCdh4F9xW0mDW813fWmaMFalX6ik0eM
 0DcBgXSdluRth5HdfiFPapCUlqEcv06pDnSUtryQwA==
X-Google-Smtp-Source: ABdhPJzUkvbAvYEa3k1BsUYozC/xotWpIsogjry89hwi8FrKRfRA/5IIZf6URsj+bAxUF2s9ybtiMe1E4JF5+OFqUys=
X-Received: by 2002:a05:6e02:664:: with SMTP id
 l4mr11033643ilt.81.1602251795786; 
 Fri, 09 Oct 2020 06:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvuq58q+GsWnzni0sKSHbubuQz-UaK3TASX26V_a7yBVw@mail.gmail.com>
 <20200924090349.GF27174@8bytes.org>
 <ecf71b34-a104-d42a-bfcd-9570e73520a7@arm.com>
 <20200924092546.GJ27174@8bytes.org>
 <e2186418-d4d6-e1f4-5eb4-3bfafb5cebb2@arm.com>
 <20200924095629.GL27174@8bytes.org>
 <CA+G9fYu42j_B+Rg2nq+KKBiKLqxVEqabQ15CujyJ+o6jqRj2uQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 9 Oct 2020 19:26:24 +0530
Message-ID: <CA+G9fYtG6Ro-NdrP89ipDyUqVVT2=_8pTvjTSeFcWr795bp8AA@mail.gmail.com>
Subject: Re: arm-smmu 5000000.iommu: Cannot accommodate DMA offset for IOMMU
 page tables
To: Joerg Roedel <joro@8bytes.org>
Cc: Poonam Aggrwal <poonam.aggrwal@nxp.com>, Rob Herring <robh@kernel.org>,
 Joerg Roedel <jroedel@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Richard Weinberger <richard@nod.at>, "Z.Q. Hou" <Zhiqiang.Hou@nxp.com>,
 Will Deacon <will@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Suram Suram <suram@nxp.com>, masonccyang@mxic.com.tw,
 Robin Murphy <robin.murphy@arm.com>
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

On Fri, 9 Oct 2020 at 19:24, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
>
>
> On Thu, 24 Sep 2020 at 15:26, Joerg Roedel <joro@8bytes.org> wrote:
> >
> > On Thu, Sep 24, 2020 at 10:36:47AM +0100, Robin Murphy wrote:
> > > Yes, the issue was introduced by one of the changes in "dma-mapping:
> > > introduce DMA range map, supplanting dma_pfn_offset", so it only existed in
> > > the dma-mapping/for-next branch anyway.
>

FYI,
The reported problem still exists on 5.9.0-rc8-next-20201009.

[    1.843814] Driver must set ecc.strength when using hardware ECC
[    1.849847] WARNING: CPU: 4 PID: 1 at
drivers/mtd/nand/raw/nand_base.c:5687 nand_scan_with_ids+0x1450/0x1470
[    1.859676] Modules linked in:
[    1.862730] CPU: 4 PID: 1 Comm: swapper/0 Not tainted
5.9.0-rc8-next-20201009 #1
[    1.870125] Hardware name: Freescale Layerscape 2088A RDB Board (DT)
[    1.876478] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
[    1.882483] pc : nand_scan_with_ids+0x1450/0x1470
[    1.887183] lr : nand_scan_with_ids+0x1450/0x1470

full test log,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20201009/testrun/3284876/suite/linux-log-parser/test/check-kernel-warning-92014/log

> >
> > Okay, alright then.
> >

- Naresh
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
