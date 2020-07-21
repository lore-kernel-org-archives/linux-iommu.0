Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B3EC433E3
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 16:21:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4159B20771
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 16:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ymm00dD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4159B20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 10BD9864F3;
	Tue, 21 Jul 2020 16:21:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oMV67mI29mJI; Tue, 21 Jul 2020 16:21:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 98B42864A4;
	Tue, 21 Jul 2020 16:21:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B6A7C089F;
	Tue, 21 Jul 2020 16:21:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E8FEC016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 16:21:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8D0CD863B7
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 16:21:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XqL2Bhlt3bBM for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 16:21:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D5810864E6
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 16:21:06 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id n2so15712002edr.5
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=OHn7hEjFb/8SBXPDh1+DgoRQWsuvdjNe2+U9AyALG4o=;
 b=Ymm00dD9F2MasO44D8/wTfY1on9EmII3e6c5icTnGDjY49MsIFNKckv4IZwX+ryogf
 GRb1dqFZQCLJj0kOlfQ+/ioq9eSG3gXCeDvzxIkQ3XhNVRYELEvEWCTRfL41X2oFvkFJ
 6B+e20IzO63huP1rpSd2WjArWZ25Qb3gIIWlfNwKP5mOav3z7CoBOoIoQhiYBALvUL52
 BYB+4ZQb63i8kAb2LtDh/0/iF3bUWc3Th+eULyeWS+cGaSLe5tkqpkhazu1sKFawBxHm
 fQZv5FoabAu9gg8akYzMCY6Fw5v7Hb5iimAkyb1YL8YKZPr0UHqJfXw85J3Bl5e2ND/y
 4o2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=OHn7hEjFb/8SBXPDh1+DgoRQWsuvdjNe2+U9AyALG4o=;
 b=UKAuIV9MFZXlsE/85ZNeABcuIIw0zCwjMoDWX7lQH1hgcYz1Pn9CSY8rb6WV8z9vSL
 tCWPznsADyh0dOyI90d7omI1aIFvFJSU7W2ohYxl8N0z9IakW5YPOPKgdcCvAO/r8ha0
 4dO5AktUQ5fv7qq7QQGcFpgcwjI6ar34ByD8Q7OTUvs30C061LqrrNG0KxnmM/cuiGEF
 P9c6WBKBmeAYQC34doToR8CjOlsgWAQemap8YMhEyoFBcwf4ZiLDaaWrDJY5AkJWqhba
 OcsCOAJJ8tV+XRrI2DlpL5+PHxlQ5BanGoaWJOhTwappUm0ZD5OjbOmTPOCC4nsdvf8C
 R47g==
X-Gm-Message-State: AOAM530KfRn51AT4S2MCjkq80486a9hjBijIa92CQu1Klz58KGRqy/pm
 ylfO470XMQWEdIWTU3Go/WAgjmws4YKBjehZDYM=
X-Google-Smtp-Source: ABdhPJwlkQdsmXiGVJuT5fBMSRufgvGnNFQJWXPQYp7JmU26Bood8ogKvJRBt/XX6NId4d0K7v9nUTgHvmnJoTuh4oY=
X-Received: by 2002:a05:6402:202e:: with SMTP id
 ay14mr26654583edb.233.1595348465062; 
 Tue, 21 Jul 2020 09:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200704122809.73794-1-konradybcio@gmail.com>
 <20200704130922.GB21333@willie-the-truck>
 <20200705033511.GR388985@builder.lan>
 <CAMS8qEWO-1mNd12Zs-2WogCrgNF5=6RkF=Z1pTeOZxSuKjx+qg@mail.gmail.com>
 <20200721154415.GA5758@jcrouse1-lnx.qualcomm.com>
In-Reply-To: <20200721154415.GA5758@jcrouse1-lnx.qualcomm.com>
From: Konrad Dybcio <konradybcio@gmail.com>
Date: Tue, 21 Jul 2020 18:20:29 +0200
Message-ID: <CAMS8qEXNh6n9SpMkPAr8cPneasPvJPELD2TZ4gxUf0byxNePbg@mail.gmail.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Implement qcom,skip-init
To: Konrad Dybcio <konradybcio@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, 
 Will Deacon <will@kernel.org>, skrzynka@konradybcio.pl, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, 
 DTML <devicetree@vger.kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 John Stultz <john.stultz@linaro.org>
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

>The current
>focus has been on moving more of the SMMU specific bits into the arm-smmu-qcom
>implementation [1] and I think that is the right way to go.

Pardon if I overlooked something obvious, but I can't seem to find a
clean way for implementing qcom,skip-init in arm-smmu-qcom, as neither
the arm_smmu_test_smr_masks nor the probe function seem to be
alterable with arm_smmu_impl. I'm open to your ideas guys.

Konrad
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
