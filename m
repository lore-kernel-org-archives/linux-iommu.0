Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2236BC07E96
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:27:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A54BB611C1
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 08:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54BB611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56C5B405CE;
	Tue, 13 Jul 2021 08:27:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pZ-9vvXGgyu8; Tue, 13 Jul 2021 08:27:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0DDFD405BC;
	Tue, 13 Jul 2021 08:27:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9AC6C001A;
	Tue, 13 Jul 2021 08:27:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5A92C000E
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:27:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B417E6083D
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:27:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hpK1LHD7oFIz for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 08:27:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 644AC60831
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:27:32 +0000 (UTC)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 4EC8D40656
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 08:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1626164849;
 bh=90RfES78KpkRVfn+LDGEBestSWCPHLKDvATyG+mU35k=;
 h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 b=YWeTI36B0kgYg15aAF40wfbi3IITOo9U51Oj4LMsGAvLArUyDfzbkaFoasJ/6yPnA
 YYEZGpz2w0NHQJW9E97Uql45XcrivpwuG3KL0ZxZxMKWeaf+QW7oK6ckTyznOCBlXP
 c0gYaC/KRJ0gQpTXiy2nsA31vcq03kokCvDwBqEJnvy930BTjxFPcYpOjgPYROqT6n
 cTnyDGwhqkYS21b68SAF88kzmrcJqOfiqvSP4Adgd+63T8rbiWflZcaH9swFbBrdLE
 KmgwOrlz2Jn2ch6Y0uZfpbEYtrC9XCj1NVl3OwmL7MVc4hiaBFlmcIaVMB6q3+jIgE
 e5scM8DfOxfNg==
Received: by mail-ed1-f69.google.com with SMTP id
 n6-20020aa7c4460000b02903a12bbba1ebso8052296edr.6
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 01:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=90RfES78KpkRVfn+LDGEBestSWCPHLKDvATyG+mU35k=;
 b=Ou9iCbTYbJLo+4yt1ID8BwcJU9avLR/2IRrmPtRK+95PQ0lzRRDkVJRgpL4jHcF+X+
 HVhitAPnwtfYTOYSh6aX8FEwnjQ4z+bZfnTxF6QL8WuDzWo0wNY3SaQsz4tbdxsy5H6D
 BnddmNKGqvRVDC6Fs/dBh/DQgqhp0rIgpsJ48yhfLWm+y2zav0FRgejFehXdFf27Zdre
 kjJwfVgUT4QK+5ZhxC50fBJzemt/kBH0qzae379xZHlXZM/IEz7UszqidejuWOIGUFSo
 vOwAAFtpLqaq55llF9++j8g/yUrPTZDS4sBovSFRVJyuqeFJZvPf4zv/VOGRE9Z3AxbN
 D+wA==
X-Gm-Message-State: AOAM533d0JmOJy48XrYand/SOkh3zJDy1s5ucMax645BM6hJUcWLOMPW
 z98dXd9AiAriDox9xpEDiOUGlwVRSuOMAF1ImURvgapbxd12tViYzOQPKU+SP69atYaYtbXPCQy
 GWhk35NRtt3QiE47P99Oj19++REuZNv4jaZFjIBXzAwqU9veDxM3O6Hx3IgqWnNQ=
X-Received: by 2002:a05:6402:22c6:: with SMTP id
 dm6mr4216573edb.228.1626164849065; 
 Tue, 13 Jul 2021 01:27:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6pMwHXiAOSlFdfU7dpEd4HNiijqnguwMj60Om1zIodF74a4IJRoAK85lRX6uXsRE4r1JyfuuOAOPiOEGbvtY=
X-Received: by 2002:a05:6402:22c6:: with SMTP id
 dm6mr4216563edb.228.1626164848899; 
 Tue, 13 Jul 2021 01:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210621140036.2879563-1-thierry.reding@gmail.com>
 <162442779339.5511.14827117243689906234.b4-ty@canonical.com>
 <CAL_JsqL3WMOrPNzF-juqL8y20dAjt0BZaZU-yLnekKKCjTqmMA@mail.gmail.com>
In-Reply-To: <CAL_JsqL3WMOrPNzF-juqL8y20dAjt0BZaZU-yLnekKKCjTqmMA@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Tue, 13 Jul 2021 10:27:18 +0200
Message-ID: <CA+Eumj6hSOLJ32u5P00684BiLe3=1QztxWc9BFXWe5iQHSA9mA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm-smmu: Fix json-schema syntax
To: Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Olof Johansson <olof@lixom.net>
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Thierry Reding <thierry.reding@gmail.com>, Robin Murphy <robin.murphy@arm.com>
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

On Mon, 12 Jul 2021 at 16:14, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Jun 22, 2021 at 11:56 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
> >
> > On Mon, 21 Jun 2021 16:00:36 +0200, Thierry Reding wrote:
> > > Commit 4287861dca9d ("dt-bindings: arm-smmu: Add Tegra186 compatible
> > > string") introduced a jsonschema syntax error as a result of a rebase
> > > gone wrong. Fix it.
> >
> > Applied, thanks!
> >
> > [1/1] dt-bindings: arm-smmu: Fix json-schema syntax
> >       commit: bf3ec9deaa33889630722c47f7bb86ba58872ea7
>
> Applied where? Now Linus's master is broken.

To memory controller drivers tree. Pushed to soc folks some time ago:
https://lore.kernel.org/lkml/20210625073604.13562-1-krzysztof.kozlowski@canonical.com/

Cc: Arnd and Olof,
Any comments on merging these fixes? They should go to current RC.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
